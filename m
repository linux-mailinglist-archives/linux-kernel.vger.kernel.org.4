Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 939C074CF37
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 09:56:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232294AbjGJH4o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 03:56:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232276AbjGJH4j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 03:56:39 -0400
Received: from out-24.mta1.migadu.com (out-24.mta1.migadu.com [95.215.58.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95305102
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 00:56:37 -0700 (PDT)
Date:   Mon, 10 Jul 2023 16:56:29 +0900
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1688975794;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vh+sVUb6EpExqidiOoU657ohaTJ+4PLiupOU3kMGhgo=;
        b=XJHHkkQBwCS2yPSjgk53hE8LAHmHvPptVCTz777HzFEiL3tL8/FUiXdabD0kceMPi/hBl4
        y2Rp3svjUriygtlKMbyDqFe7fejdcWaGJLuK8979Dkz9l4q05xkJNJFYoeYeCOmt2NDWQv
        1D2RwCbUMYROmofHbnQYLnnNqXz+K0M=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Naoya Horiguchi <naoya.horiguchi@linux.dev>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     akpm@linux-foundation.org, naoya.horiguchi@nec.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/8] mm: memory-failure: ensure moving HWPoison flag to
 the raw error pages
Message-ID: <20230710075629.GB1686200@ik1-406-35019.vs.sakura.ne.jp>
References: <20230708085744.3599311-1-linmiaohe@huawei.com>
 <20230708085744.3599311-3-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230708085744.3599311-3-linmiaohe@huawei.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 08, 2023 at 04:57:38PM +0800, Miaohe Lin wrote:
> If hugetlb_vmemmap_optimized is enabled, folio_clear_hugetlb_hwpoison()
> called from try_memory_failure_hugetlb() won't transfer HWPoison flag to
> subpages while folio's HWPoison flag is cleared. So when trying to free
> this hugetlb page into buddy, folio_clear_hugetlb_hwpoison() is not called
> to move HWPoison flag from head page to the raw error pages even if now
> hugetlb_vmemmap_optimized is cleared. This will results in HWPoisoned page
> being used again and raw_hwp_page leak.
> 
> Fixes: ac5fcde0a96a ("mm, hwpoison: make unpoison aware of raw error info in hwpoisoned hugepage")
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

Acked-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
