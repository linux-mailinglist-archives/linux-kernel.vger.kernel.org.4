Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D52975BE0D6
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 10:55:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231463AbiITIzg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 04:55:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231513AbiITIzR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 04:55:17 -0400
Received: from outbound-smtp18.blacknight.com (outbound-smtp18.blacknight.com [46.22.139.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FB095E569
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 01:55:10 -0700 (PDT)
Received: from mail.blacknight.com (pemlinmail02.blacknight.ie [81.17.254.11])
        by outbound-smtp18.blacknight.com (Postfix) with ESMTPS id 22B111C392B
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 09:55:09 +0100 (IST)
Received: (qmail 17326 invoked from network); 20 Sep 2022 08:55:08 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.198.246])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 20 Sep 2022 08:55:08 -0000
Date:   Tue, 20 Sep 2022 09:55:02 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     "zhaoyang.huang" <zhaoyang.huang@unisoc.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Zhaoyang Huang <huangzhaoyang@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, ke.wang@unisoc.com
Subject: Re: [PATCHv2] mm: check high-order page when free it to pcp
Message-ID: <20220920085437.ngyrzgxe2uoi7g4a@techsingularity.net>
References: <1663634940-6515-1-git-send-email-zhaoyang.huang@unisoc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <1663634940-6515-1-git-send-email-zhaoyang.huang@unisoc.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 20, 2022 at 08:49:00AM +0800, zhaoyang.huang wrote:
> From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> 
> High-order pcp page escaped from checking when both of DEBUG_VM and debug_pagealloc
> are all disabled if it allocated again from pcp_list without going to global
> free list, which should be introduced by 44042b4498.
> 
> fix:44042b4498
> 
> Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>

Why is the order check needed? In this case, I think the comment itself was
wrong and should be corrected. free_pcp_prepare is called when dealing with
a PCP page being freed and these days that may order-0 or high-order pages.
Wieh DEBUG_VM disabled, the pages are checked in by bulkfree_pcp_prepare
when freeing pages from PCP to the core allocator. Why would just
high-order pages be checked in free_pcp_prepare and checked again in
bulkfree_pcp_prepare?

-- 
Mel Gorman
SUSE Labs
