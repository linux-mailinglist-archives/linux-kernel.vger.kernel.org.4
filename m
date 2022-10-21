Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C6E3606CBE
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 02:58:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229937AbiJUA6c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 20:58:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbiJUA61 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 20:58:27 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0385D1A16C2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 17:58:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8CA34B82A04
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 00:58:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 166E8C433C1;
        Fri, 21 Oct 2022 00:58:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1666313904;
        bh=5yLhVCUhBQBePRY5NTY6Rawpef5GL4cx0onubKzHul4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=DZDARGIgcLQ6LqDsLARjMxK9nxiMXV5WHH0hBOJJzwWjm3/Al8CwMwv+HAhatnX7q
         fS1JKZxzuEGDdFYzC2ByKgJyEGA080ILJ7Waxl+hjhMTUmb7/6Zrnk6l2VuJNWE67D
         3t+wF0NiXcwjoyrPIE5H6UNEVr+yXQm2SD237KJw=
Date:   Thu, 20 Oct 2022 17:58:23 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: Re: [PATCH] mm/kmemleak: Prevent soft lockup in kmemleak_scan()'s
 object iteration loops
Message-Id: <20221020175823.d7aa5cfeefd8673429f42081@linux-foundation.org>
In-Reply-To: <20221020175619.366317-1-longman@redhat.com>
References: <20221020175619.366317-1-longman@redhat.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Oct 2022 13:56:19 -0400 Waiman Long <longman@redhat.com> wrote:

> Commit 6edda04ccc7c ("mm/kmemleak: prevent soft lockup in first object
> iteration loop of kmemleak_scan()") adds cond_resched() in the first
> object iteration loop of kmemleak_scan(). However, it turns that the
> 2nd objection iteration loop can still cause soft lockup to happen in
> some cases. So add a cond_resched() call in the 2nd and 3rd loops as
> well to prevent that and for completeness.
> 

Seems reasonable, although not an object of beauty.

We didn't include a Fixes: or cc:stable in 6edda04ccc7c, even though it
addresses softlockups.  I think I'll add a cc:stable to this, with a
Fixes:6edda04ccc7c.  So any kenrel which included 6edda04ccc7c will
hopefully add this as well.


