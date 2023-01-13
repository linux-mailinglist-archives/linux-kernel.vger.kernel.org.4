Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 841FE669D09
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 16:59:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230028AbjAMP7V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 10:59:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230321AbjAMP6S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 10:58:18 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2523F4D4A6
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 07:49:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=DfT9q9lHXCcgDHj3l3lHi+8c/GVJ6aWRtQZ+lLWf7NY=; b=X9t2JmdQaeUH4e+OTEXdJApJ2c
        H8l5getZ8VtJbbGhMqAZHqAUgILjmF2UCOp40bGNbTiMVSmPn6pNzXaY+sHTHHQRMeiOXEiHHfrX8
        SL1zzfDhfX8AWeh5yJnhIbLPqmjTi7e/Pd+VnmrGK8iV3usDOqP0OtrZLqk3scBdv1vxrbv1vizif
        kK9cu8Ty8sywVbbaTx1xZjWfrrbdsLGWmj2rFGxW1Xa4tSq3W0gEZsrzm4n379gkUKanC2A+NLCZl
        OEHVCMVVTtQQCOtoKDPyRCEe/lwZbOupiMMO3iHDsDjnK5YR56tkTJtAwEh34m1ux6/sJROJLvStu
        n2GneenA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pGMJg-006DgR-BH; Fri, 13 Jan 2023 15:50:04 +0000
Date:   Fri, 13 Jan 2023 15:50:04 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next 7/7] mm: swap: remove unneeded
 cgroup_throttle_swaprate()
Message-ID: <Y8F9rHVHu7XsBg49@casper.infradead.org>
References: <20230112083006.163393-1-wangkefeng.wang@huawei.com>
 <20230112083006.163393-8-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230112083006.163393-8-wangkefeng.wang@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 12, 2023 at 04:30:06PM +0800, Kefeng Wang wrote:
> All the callers of cgroup_throttle_swaprate() are converted to
> folio_throttle_swaprate(), so make __cgroup_throttle_swaprate()
> to take a folio, and drop unused cgroup_throttle_swaprate().

Shouldn't __cgroup_throttle_swaprate() then be called
__folio_throttle_swaprate()?

> +extern void __cgroup_throttle_swaprate(struct folio *folio, gfp_t gfp_mask);

Also you can drop the 'extern'.

> +static inline void folio_throttle_swaprate(struct folio *folio, gfp_t gfp_mask)

And it's not a gfp mask.  It's gfp_flags (we have this mistake all
through the mm).  Or you can just call it 'gfp'.

