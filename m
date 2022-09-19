Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 501885BC9C6
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 12:47:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230095AbiISKrO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 06:47:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229778AbiISKqo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 06:46:44 -0400
Received: from outbound-smtp55.blacknight.com (outbound-smtp55.blacknight.com [46.22.136.239])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF1F427FE3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 03:31:39 -0700 (PDT)
Received: from mail.blacknight.com (pemlinmail02.blacknight.ie [81.17.254.11])
        by outbound-smtp55.blacknight.com (Postfix) with ESMTPS id EA4AFFA79E
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 11:22:26 +0100 (IST)
Received: (qmail 20035 invoked from network); 19 Sep 2022 10:22:26 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.198.246])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 19 Sep 2022 10:22:26 -0000
Date:   Mon, 19 Sep 2022 11:16:29 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     "zhaoyang.huang" <zhaoyang.huang@unisoc.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Zhaoyang Huang <huangzhaoyang@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, ke.wang@unisoc.com
Subject: Re: [RFC PATCH] mm: check global free_list if there is ongoing
 reclaiming when pcp fail
Message-ID: <20220919101629.xlafi2y2dk357wk3@techsingularity.net>
References: <1663325892-9825-1-git-send-email-zhaoyang.huang@unisoc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <1663325892-9825-1-git-send-email-zhaoyang.huang@unisoc.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 16, 2022 at 06:58:12PM +0800, zhaoyang.huang wrote:
> From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> 
> Check the global free list again even if rmqueue_bulk failed for pcp pages when
> there is ongoing reclaiming, which could eliminate potential direct reclaim by
> chance.
> 
> Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>

Patch does not apply and may be based on a custom kernel that introduced
a problem. There is no description of what problem this is trying to
fix. Checking the status of reclaim for a specific zone in this path would
be a little unexpected.  If allocation pressure is exceeding the ability
of reclaim to make progress then the caller likely needs to take action
like direct reclaim. If the allocation failure is due to a high-order
failure then it may need to enter direct compaction etc.

-- 
Mel Gorman
SUSE Labs
