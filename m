Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD059629AD3
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 14:41:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238277AbiKONlp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 08:41:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238293AbiKONln (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 08:41:43 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32DA613FA6;
        Tue, 15 Nov 2022 05:41:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E42F7B8162B;
        Tue, 15 Nov 2022 13:41:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97D14C433C1;
        Tue, 15 Nov 2022 13:41:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668519699;
        bh=mKox1DaCdoOGN/b/rv48hmEDDIpYcldE8+6d+IFTW6g=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=NSu8PpvvI0ptwXg2ezuzWCu8XxXJMJkPRmPQF16lz9GzZhCQQxkoITCiGXvcO3+0n
         WRgUNcimy7nGeAVK00ZHkuRKeGVggHsRbZXEZvSfsn6A1KvSJxqjU5Q8T/AtFNYw6z
         we82+NWA/DJsR3batXpSXeQwmQAHcaL5B7ER4J8n3tnZIj1NSYaqlrJ2IwKZIGCrf6
         6nLLRelbHB+pFuoVUXYMmF8hXL8U6PFAosNOjV49sCoFYI/V9E9z/+0WyI9IDMYnsO
         dUVNMSXYgcrlrsTP+DOSymt5xiKhckrcE7+nWIrJvK47J4nEt39l4/LeomRJuZVZ7G
         4U5UwgMMrEKcA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 3A0A45C118E; Tue, 15 Nov 2022 05:41:39 -0800 (PST)
Date:   Tue, 15 Nov 2022 05:41:39 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Sven Schnelle <svens@linux.ibm.com>
Cc:     Davidlohr Bueso <dave@stgolabs.net>,
        Josh Triplett <josh@joshtriplett.org>,
        linux-kernel@vger.kernel.org, rcu@vger.kernel.org
Subject: Re: [PATCH 1/2] torture: use for_each_present() loop in
 torture_online_all()
Message-ID: <20221115134139.GI4001@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20221111125126.3319474-1-svens@linux.ibm.com>
 <20221111125126.3319474-2-svens@linux.ibm.com>
 <20221111185331.GA725751@paulmck-ThinkPad-P17-Gen-1>
 <yt9dtu31k0r9.fsf@linux.ibm.com>
 <20221114163009.GE4001@paulmck-ThinkPad-P17-Gen-1>
 <yt9dzgcsiu4p.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yt9dzgcsiu4p.fsf@linux.ibm.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 15, 2022 at 07:55:50AM +0100, Sven Schnelle wrote:
> Hi Paul,
> 
> "Paul E. McKenney" <paulmck@kernel.org> writes:
> 
> > On Mon, Nov 14, 2022 at 04:35:06PM +0100, Sven Schnelle wrote:
> >> "Paul E. McKenney" <paulmck@kernel.org> writes:
> >> 
> >> > On Fri, Nov 11, 2022 at 01:51:24PM +0100, Sven Schnelle wrote:
> >> >> A CPU listed in the possible mask doesn't have to be present, in
> >> >> which case it would crash the kernel in torture_online_all().
> >> >> To prevent this use a for_each_present() loop.
> >> >> 
> >> >> Signed-off-by: Sven Schnelle <svens@linux.ibm.com>
> >> >
> >> > Looks good to me!  Any reason for no mailing list on CC?
> >> 
> >> No, my fault. I setup get_maintainer.pl to be called from git
> >> send-email, but looks like i did it wrong :-)
> >
> > Been there, done that!  ;-)
> >
> >> > Ah, and any synchronization required in case it is possible for a CPU
> >> > to leave the cpu_present_mask?  Or can they only be added?
> >> 
> >> Hmm... I think the main question is, whether it is ok for a cpu to be
> >> removed from the system when rcutorture is running? In both cases it
> >> would disappear from the cpu online mask, so i don't think the patch
> >> would change the behaviour. But i can check and send additional patches
> >> if there are other places that needs adjustment.
> >
> > Yes, rcutorture has lower-level checks for CPUs being hotplugged
> > behind its back.  Which might be sufficient.  But this patch is in
> > response to something bad happening if the CPU is also not present in
> > the cpu_present_mask.  Would that same bad thing happen if rcutorture saw
> > the CPU in cpu_online_mask, but by the time it attempted to CPU-hotplug
> > it, that CPU was gone not just from cpu_online_mask, but also from
> > cpu_present_mask?
> >
> > Or are CPUs never removed from cpu_present_mask?
> 
> In the current implementation CPUs can only be added to the
> cpu_present_mask, but never removed. This might change in the future
> when we get support from firmware for that, but the current s390 code
> doesn't do that.

Very good!

Then could the patch please check that bits are never removed?
That way the code will complain should firmware support be added.

							Thanx, Paul
