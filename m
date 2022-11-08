Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D57A621073
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 13:24:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233702AbiKHMYz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 07:24:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234231AbiKHMYq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 07:24:46 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13A874FFA7
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 04:24:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A375561503
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 12:24:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D24AC433D6;
        Tue,  8 Nov 2022 12:24:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1667910282;
        bh=DIgP7uPQKj0lwA2YB9gPgcW4fnH+W7WgHIsSh/Cgwt8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XLzezLU97ctWJIIz/k8E9MMSMNTMfFqBpXh6PJaunmdTM/169PtNdVX+ufSSaZzIL
         L/ueI4AhoprqGnU4JiKPeAYGKavd91uo+Lu6esW20CEeaV0JaOpUzE1c7TEd0Trj2j
         bBnMk0J4aBRAV5/EY+HzNhE/hq9oFMKkXk3zMQf8=
Date:   Tue, 8 Nov 2022 13:24:39 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Vishal Chourasia <vishalc@linux.vnet.ibm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        vincent.guittot@linaro.org, vschneid@redhat.com,
        srikar@linux.vnet.ibm.com, sshegde@linux.ibm.com,
        linuxppc-dev@lists.ozlabs.org, ritesh.list@gmail.com,
        aneesh.kumar@linux.ibm.com
Subject: Re: sched/debug: CPU hotplug operation suffers in a large cpu systems
Message-ID: <Y2pKh3H0Ukvmfuco@kroah.com>
References: <Y01UWQL2y2r69sBX@li-05afa54c-330e-11b2-a85c-e3f3aa0db1e9.ibm.com>
 <Y01kc4g9CVmoyOxj@hirez.programming.kicks-ass.net>
 <Y01sk3l8yCMvhvYm@kroah.com>
 <Y06B0pr8hpwzxEzI@li-05afa54c-330e-11b2-a85c-e3f3aa0db1e9.ibm.com>
 <Y06ISBWhJflnV+NI@kroah.com>
 <Y1jVjX9FUuUilcjA@li-05afa54c-330e-11b2-a85c-e3f3aa0db1e9.ibm.com>
 <Y1jbhCYfktL51zNB@kroah.com>
 <Y1j5cqbyZCDlyaTn@hirez.programming.kicks-ass.net>
 <Y2oozs/YgqqRV5hq@li-05afa54c-330e-11b2-a85c-e3f3aa0db1e9.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2oozs/YgqqRV5hq@li-05afa54c-330e-11b2-a85c-e3f3aa0db1e9.ibm.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 08, 2022 at 03:30:46PM +0530, Vishal Chourasia wrote:
> 
> Thanks Greg & Peter for your direction. 
> 
> While we pursue the idea of having debugfs based on kernfs, we thought about
> having a boot time parameter which would disable creating and updating of the
> sched_domain debugfs files and this would also be useful even when the kernfs
> solution kicks in, as users who may not care about these debugfs files would
> benefit from a faster CPU hotplug operation.

Ick, no, you would be adding a new user/kernel api that you will be
required to support for the next 20+ years.  Just to get over a
short-term issue before you solve the problem properly.

If you really do not want these debugfs files, just disable debugfs from
your system.  That should be a better short-term solution, right?

Or better yet, disable SCHED_DEBUG, why can't you do that?

thanks,

greg k-h
