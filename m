Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 701056467FA
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 04:44:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbiLHDoI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 22:44:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiLHDoG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 22:44:06 -0500
Received: from out-5.mta0.migadu.com (out-5.mta0.migadu.com [IPv6:2001:41d0:1004:224b::5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E49987E413
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 19:44:04 -0800 (PST)
Date:   Wed, 7 Dec 2022 19:43:54 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1670471039;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PHzE9f0IRUY0L+BGXdPC0ZZnOe1x/EoBD8nxdnVzP/M=;
        b=vpawLfoYzk62tmgVNEmN5i8T2NCxM8fyGPGuFK7gqTTc/b4UNKhdNtVkDsglOiD7bxhqUE
        6//7BfzL6tZuikORiTWga4fKG87s+XhgCLh0x6R+ICFivUvBWSSNyjRNTBg5DqVbbx6L8J
        YvqLamYDqJLmT4kHILPITmgw/sC4M8E=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     Tejun Heo <tj@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Jann Horn <jannh@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <songmuchun@bytedance.com>, cgroups@vger.kernel.org
Subject: Re: [PATCH for-6.1-fixes] memcg: Fix possible use-after-free in
 memcg_write_event_control()
Message-ID: <Y5FdetSY9mF0uOvy@P9FQF9L96D>
References: <Y5FRm/cfcKPGzWwl@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y5FRm/cfcKPGzWwl@slm.duckdns.org>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 07, 2022 at 04:53:15PM -1000, Tejun Heo wrote:
> memcg_write_event_control() accesses the dentry->d_name of the specified
> control fd to route the write call. As a cgroup interface file can't be
> renamed, it's safe to access d_name as long as the specified file is a
> regular cgroup file. Also, as these cgroup interface files can't be removed
> before the directory, it's safe to access the parent too.
> 
> Prior to 347c4a874710 ("memcg: remove cgroup_event->cft"), there was a call
> to __file_cft() which verified that the specified file is a regular cgroupfs
> file before further accesses. The cftype pointer returned from __file_cft()
> was no longer necessary and the commit inadvertently dropped the file type
> check with it allowing any file to slip through. With the invarients broken,
> the d_name and parent accesses can now race against renames and removals of
> arbitrary files and cause use-after-free's.
> 
> Fix the bug by resurrecting the file type check in __file_cft(). Now that
> cgroupfs is implemented through kernfs, checking the file operations needs
> to go through a layer of indirection. Instead, let's check the superblock
> and dentry type.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Fixes: 347c4a874710 ("memcg: remove cgroup_event->cft")
> Cc: stable@vger.kernel.org # v3.14+
> Reported-by: Jann Horn <jannh@google.com>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>

Acked-by: Roman Gushchin <roman.gushchin@linux.dev>

Thanks!
