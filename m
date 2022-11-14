Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97465628580
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 17:34:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237891AbiKNQeC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 11:34:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237753AbiKNQdp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 11:33:45 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7351331230;
        Mon, 14 Nov 2022 08:30:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6B161B8104F;
        Mon, 14 Nov 2022 16:30:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B60DC433C1;
        Mon, 14 Nov 2022 16:30:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668443410;
        bh=i3fM5D45EHtL70h2VJLiq8sI4O+TUzWx3M5h1tIWM9g=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=XPZr1PmapyZe0sVbruVI4r4CRgFK6lmvv0GjXf9DywfwyH8eKbIXC1exNdeIK+/R/
         xr/wjGH+llrwx23Kwlyi1Zmzt/gMSuCPVfpgtjuBuXwNsGD0ON7D13Knd+Yfhhwdm+
         pHVw5Z00Pnx3Sw2pRynr4doEbE4crJau8Kb7llQ2rbDeMMPX8iJwecf8JimlNTaCKA
         8vZKvFAFH+2aIhL9GWC5ERWRzTet8sgT6e0XfaCQ/616JNhuG1n4H8dODVXwox9I+h
         Vp5ZEmXuvqd1Ok7EU0ZxbyuNsL9cILPjscoj0Rw6n1M8fMkVGfRYZg+hsKxFeNNFAP
         qyxzPAG8A5ewg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id B83D85C0F9C; Mon, 14 Nov 2022 08:30:09 -0800 (PST)
Date:   Mon, 14 Nov 2022 08:30:09 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Sven Schnelle <svens@linux.ibm.com>
Cc:     Davidlohr Bueso <dave@stgolabs.net>,
        Josh Triplett <josh@joshtriplett.org>,
        linux-kernel@vger.kernel.org, rcu@vger.kernel.org
Subject: Re: [PATCH 1/2] torture: use for_each_present() loop in
 torture_online_all()
Message-ID: <20221114163009.GE4001@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20221111125126.3319474-1-svens@linux.ibm.com>
 <20221111125126.3319474-2-svens@linux.ibm.com>
 <20221111185331.GA725751@paulmck-ThinkPad-P17-Gen-1>
 <yt9dtu31k0r9.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yt9dtu31k0r9.fsf@linux.ibm.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 14, 2022 at 04:35:06PM +0100, Sven Schnelle wrote:
> "Paul E. McKenney" <paulmck@kernel.org> writes:
> 
> > On Fri, Nov 11, 2022 at 01:51:24PM +0100, Sven Schnelle wrote:
> >> A CPU listed in the possible mask doesn't have to be present, in
> >> which case it would crash the kernel in torture_online_all().
> >> To prevent this use a for_each_present() loop.
> >> 
> >> Signed-off-by: Sven Schnelle <svens@linux.ibm.com>
> >
> > Looks good to me!  Any reason for no mailing list on CC?
> 
> No, my fault. I setup get_maintainer.pl to be called from git
> send-email, but looks like i did it wrong :-)

Been there, done that!  ;-)

> > Ah, and any synchronization required in case it is possible for a CPU
> > to leave the cpu_present_mask?  Or can they only be added?
> 
> Hmm... I think the main question is, whether it is ok for a cpu to be
> removed from the system when rcutorture is running? In both cases it
> would disappear from the cpu online mask, so i don't think the patch
> would change the behaviour. But i can check and send additional patches
> if there are other places that needs adjustment.

Yes, rcutorture has lower-level checks for CPUs being hotplugged
behind its back.  Which might be sufficient.  But this patch is in
response to something bad happening if the CPU is also not present in
the cpu_present_mask.  Would that same bad thing happen if rcutorture saw
the CPU in cpu_online_mask, but by the time it attempted to CPU-hotplug
it, that CPU was gone not just from cpu_online_mask, but also from
cpu_present_mask?

Or are CPUs never removed from cpu_present_mask?

							Thanx, Paul
