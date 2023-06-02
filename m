Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19F30720927
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 20:29:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235851AbjFBS3l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 14:29:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235859AbjFBS3i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 14:29:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE3071B8
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 11:29:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 801D162E52
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 18:29:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2B9DC433D2;
        Fri,  2 Jun 2023 18:29:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685730566;
        bh=WF+uizsnt/P2HHhQeL07QMLt3IOk9O3wTfqCKyJFKtY=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=kffszOWE2H4+/ZAc0WkR6bbiJCmSR1Jeg76SuoM0TMRZYoE/h/TDRS9Q/DqzF1uRx
         CnsPxq3hNAT1Sen0IwFeJr+wO2QBwKPJ7Fl2bp3tuRTPHM0DQ02BatO5KnBzpblhCM
         2JoAhN4nqMRLsr2j/S9yBjSvj0XqRssbrWH5j2bXgGMjT0Aa/b1Fk9xKTbkWETbPdv
         V7aL/vdxVL8/PRMQK0ec8V8UFE0oCbc5opVAnx1b/Md+NjO+xl9LpG+kgjy7kfmKcr
         SS7EScdbGZZd8oWB1+xNohI39opCKFPMpicgRmGxPaJrDKdGEEAFYvXExekFqVMr6K
         9vTC/gOUUYsjg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 7DBFECE3B00; Fri,  2 Jun 2023 11:29:26 -0700 (PDT)
Date:   Fri, 2 Jun 2023 11:29:26 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Feng Tang <feng.tang@intel.com>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>, rui.zhang@intel.com,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC] x86/tsc: Make recalibration default on for
 TSC_KNOWN_FREQ cases
Message-ID: <934e9008-36db-492b-b744-9d68183c6d32@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20230522033018.1276836-1-feng.tang@intel.com>
 <87h6s4ye9b.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87h6s4ye9b.ffs@tglx>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 22, 2023 at 10:14:08AM +0200, Thomas Gleixner wrote:
> On Mon, May 22 2023 at 11:30, Feng Tang wrote:
> > Commit a7ec817d5542 ("x86/tsc: Add option to force frequency
> > recalibration with HW timer") was added to handle cases that the
> > firmware has bug and provides a wrong TSC frequency number, and it
> > is optional given that this kind of firmware issue rarely happens
> > (Paul reported once [1]).
> >
> > But Rui reported that some Sapphire Rapids platform met this issue
> > again recently, and as firmware is also a kind of 'software' which
> > can't be bug free, make the recalibration default on. When the
> > values from firmware and HW timer's calibration have big gap,
> > raise a warning and let vendor to check which side is broken.
> 
> Sure firmware can have bugs, but if firmware validation does not even
> catch such a trivially to detect bug, then their validation is nothing
> else than rubber stamping. Seriously.
> 
> Are any of these affected platforms shipping already or is this just
> Intel internal muck?
> 
> > One downside is, many VMs also has X86_FEATURE_TSC_KNOWN_FREQ set,
> > and they will also do this recalibration.
> 
> It's also pointless for those SoCs which lack legacy hardware.
> 
> So why do you force this on everyone?

Just for the record, this patch could be helpful in allowing victims
of TSC mis-synchronization to more easily provide a more complete bug
report to the firmware people.  There is of course no point if there is
already a fix available.

But it is not all that hard to work around not having this patch upstream.
This can be hand-applied as needed, NTP drift rates can be pressed
into service for those of us having atomic clocks near all our servers,
or the firmware guys can be tasked with figuring it out.

So this patch would be nice to have, but we could live without it.

							Thanx, Paul
