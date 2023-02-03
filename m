Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E486068A0B7
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 18:47:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232166AbjBCRrF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 12:47:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230042AbjBCRrD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 12:47:03 -0500
Received: from out-210.mta0.migadu.com (out-210.mta0.migadu.com [91.218.175.210])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C906A77A7
        for <linux-kernel@vger.kernel.org>; Fri,  3 Feb 2023 09:46:40 -0800 (PST)
Date:   Fri, 3 Feb 2023 09:45:39 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1675446351;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=If6qMCH+MeO2e7BB/5ZAKXFEX/HC4bkB0xMZK67fLA8=;
        b=O7RvhPr6/35tirAqMZ5Lt0K+gb9yokE+lCl/n5MKZWLzZwvcP/mayCFCB9G1VDZmkP2wGk
        8Mo1nOL4/oxPII9d6kWT/1gbFgBZwAxuirBs9tZ8u6sNu4x73iMT2RvjGAfTMcIJ55Crqm
        aTcn4yvLVHM4JisnOgpagP9Lj5RJnbY=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     Qi Zheng <zhengqi.arch@bytedance.com>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH] mm: shrinkers: fix deadlock in shrinker debugfs
Message-ID: <Y91IQ1vdaofq40JQ@P9FQF9L96D.corp.robot.car>
References: <20230202105612.64641-1-zhengqi.arch@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230202105612.64641-1-zhengqi.arch@bytedance.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 02, 2023 at 06:56:12PM +0800, Qi Zheng wrote:
> The debugfs_remove_recursive() is invoked by unregister_shrinker(),
> which is holding the write lock of shrinker_rwsem. It will waits
> for the handler of debugfs file complete. The handler also needs
> to hold the read lock of shrinker_rwsem to do something. So it
> may cause the following deadlock:
> 
>  	CPU0				CPU1
> 
> debugfs_file_get()
> shrinker_debugfs_count_show()/shrinker_debugfs_scan_write()
> 
>      				unregister_shrinker()
> 				--> down_write(&shrinker_rwsem);
> 				    debugfs_remove_recursive()
> 					// wait for (A)
> 				    --> wait_for_completion();
> 
>     // wait for (B)
> --> down_read_killable(&shrinker_rwsem)
> debugfs_file_put() -- (A)
> 
> 				    up_write() -- (B)
> 
> The down_read_killable() can be killed, so that the above deadlock
> can be recovered. But it still requires an extra kill action,
> otherwise it will block all subsequent shrinker-related operations,
> so it's better to fix it.

Oh, indeed, great catch!

With Andrew's fixup:
Reviewed-by: Roman Gushchin <roman.gushchin@linux.dev>

Thank you!
