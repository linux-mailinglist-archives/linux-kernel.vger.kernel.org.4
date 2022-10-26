Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8F8760DBAB
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 09:01:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233067AbiJZHBv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 03:01:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233062AbiJZHBp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 03:01:45 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46CF63384D
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 00:01:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 397C3CE1DF0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 07:01:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBF68C433D7;
        Wed, 26 Oct 2022 07:01:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1666767695;
        bh=4EA7mnqZIfsfgQs35vZ0Oeva6CAWg2MlREbIG63FG2w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vAaNfkKpnq6T2ATH2P1eptSG2vWxLS48UV729kmn80ggth23fKRVR16O31dRmB5xC
         3/3oubYXCu6pzFNa3rX/Y2AIowlybdzHmSoYv7fzNEBWy7uHZublQgNzKKA3E8Iv1B
         u/CI7+/Ptf433yt9tcoBj59n/2lidNrMgwAz9fBE=
Date:   Wed, 26 Oct 2022 09:02:28 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Vishal Chourasia <vishalc@linux.vnet.ibm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        vincent.guittot@linaro.org, vschneid@redhat.com,
        srikar@linux.vnet.ibm.com, sshegde@linux.ibm.com,
        linuxppc-dev@lists.ozlabs.org, ritesh.list@gmail.com,
        aneesh.kumar@linux.ibm.com
Subject: Re: sched/debug: CPU hotplug operation suffers in a large cpu systems
Message-ID: <Y1jbhCYfktL51zNB@kroah.com>
References: <Y01UWQL2y2r69sBX@li-05afa54c-330e-11b2-a85c-e3f3aa0db1e9.ibm.com>
 <Y01kc4g9CVmoyOxj@hirez.programming.kicks-ass.net>
 <Y01sk3l8yCMvhvYm@kroah.com>
 <Y06B0pr8hpwzxEzI@li-05afa54c-330e-11b2-a85c-e3f3aa0db1e9.ibm.com>
 <Y06ISBWhJflnV+NI@kroah.com>
 <Y1jVjX9FUuUilcjA@li-05afa54c-330e-11b2-a85c-e3f3aa0db1e9.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y1jVjX9FUuUilcjA@li-05afa54c-330e-11b2-a85c-e3f3aa0db1e9.ibm.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 26, 2022 at 12:07:01PM +0530, Vishal Chourasia wrote:
> On Tue, Oct 18, 2022 at 01:04:40PM +0200, Greg Kroah-Hartman wrote:
> 
> > Why do you need to?  What tools require these debugfs files to be
> > present?
> 
> We are not entirely sure what applications (if any) might be using this interface.

Then just disable it and see what happens :)

> > And if you only have 7-8 files per CPU, that does not seem like a lot of
> > files overall (14000-16000)?  If you only offline 1 cpu, how is removing
> > 7 or 8 files a bottleneck?  Do you really offline 1999 cpus for a 2k
> > system?
> 
> It's 7-8 files per domain per cpu, so, in a system with approx 2k cpus and five
> domains, the total file count goes above 70k-80k files. And, when we offline 1
> CPU, the entire directory is rebuilt, resulting in creation of all the files
> again.

Perhaps change the logic to not rebuild the whole thing and instead just
remove the required files?

Or as I mentioned before, you can move debugfs to use kernfs, which
should resolve most of these issues automatically.  Why not take the
time to do that which will solve the problem no matter what gets added
in the future in other subsystems?

thanks,

greg k-h
