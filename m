Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF88F7199C5
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 12:31:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232066AbjFAKb3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 06:31:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230399AbjFAKb0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 06:31:26 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46CBB8E;
        Thu,  1 Jun 2023 03:31:25 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1685615483;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TgVq7drZsJEBdL8AdFHKWacRbn4TiHQy0G4VwBLZWg8=;
        b=qQ8ijTwtVbkGlFTXxnt/uY1ol7lxQwHP3oCigXefjoA2dlYMXXRCSa7uHBQu7kILHooIJi
        LMMHexiFC/VCp3YLjLISvUgfUWA6H4wRd++fPz80U9UygbIGTl+0vguAqtVv1axTxRyLdJ
        2BSEsPgVm1f611w7Vm46vT3KZP3phnUqACE/gAdUTS+0PIlizJYcxdKH5zkvhRnNBLotlS
        nHkQxo4Y1Hj0OdKilbvrLV8yvRJjAoDyqVeZ/RYNgPDt5tn7gK4dgjWap4e9pTqpHH1VpR
        obFeiSPLwF2xLrHVRwl85gv63VSmpkKUspNAE5CGKpdAkhBgi6c0O8nXV7biWA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1685615483;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TgVq7drZsJEBdL8AdFHKWacRbn4TiHQy0G4VwBLZWg8=;
        b=OVUPsZJRJR6sR2J3EcBU7/UWxlDpug4m+eclZl8j12J4HOgjghePNUsGty6A/DvSfafVwi
        MGZ/5QoUOWTFEgBQ==
To:     Peter Zijlstra <peterz@infradead.org>,
        Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc:     Jonathan Corbet <corbet@lwn.net>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Steven Noonan <steven@uplinklabs.net>, kernel@collabora.com
Subject: Re: Direct rdtsc call side-effect
In-Reply-To: <20230601085602.GR4253@hirez.programming.kicks-ass.net>
References: <6719fb05-382c-8ec4-ccda-72798906a54b@collabora.com>
 <20230601085602.GR4253@hirez.programming.kicks-ass.net>
Date:   Thu, 01 Jun 2023 12:31:22 +0200
Message-ID: <87jzwneao5.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 01 2023 at 10:56, Peter Zijlstra wrote:
> On Thu, Jun 01, 2023 at 01:45:35PM +0500, Muhammad Usama Anjum wrote:
>> We are thinking of saving and restoring the timestamp counter at suspend
>> and resume time respectively. In theory it can work on Intel because of
>> TSC_ADJUST register. But it'll never work on AMD until:
>> * AMD supports the same kind of adjust register. (AMD has said that the
>> adjust register cannot be implemented in their firmware. They'll have to
>> add it to their hardware.)
>> * by manual synchronization in kernel (I know you don't like this idea. But
>> there is something Windows is doing to save/restore and sync the TSC)
>
> Wine could set TIF_NOTSC, which will cause it to run with CR4.TSD
> cleared and cause RDTSC to #GP, at which point you can emulate it.

We should ask Microsoft to do the same. That'll fix the direct RDTSC
usage quickly. :)
