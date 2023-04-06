Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7974A6D93E6
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 12:24:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237046AbjDFKX7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 06:23:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236968AbjDFKXl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 06:23:41 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93DFBE6A
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 03:22:57 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id E13931FF44;
        Thu,  6 Apr 2023 10:22:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1680776562; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KmZpdSSRqedV0L7p5sCVaHyO+NhMzOfLvKiiIVQfLvg=;
        b=p8twOzyMqekzYVHbnSfUCGsRvaWbAlJVrUr4lF2JYoaz6PuMrR7t8MCEvG4DT+mBuiXHzk
        GhkSOtOiTUENZe4KTkUFzIRIbqhgBmmLoq+aOXY9LTKelXrumvsGM3r/Y0QnpBFvcKwsgW
        lYccqJholuEk/e7jSCLUc05rNKGqOnY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1680776562;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KmZpdSSRqedV0L7p5sCVaHyO+NhMzOfLvKiiIVQfLvg=;
        b=fvEb94UkWMbvJiMXj0MmBfL2BzXpKfqnksEu7MQ5Ex+xNNR/rRfIUKyFJSfrv73FxRd2qL
        JJnnxwJHTZGg2SAA==
Received: from suse.de (unknown [10.163.43.106])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 2F06C2C142;
        Thu,  6 Apr 2023 10:22:39 +0000 (UTC)
Date:   Thu, 6 Apr 2023 11:22:38 +0100
From:   Mel Gorman <mgorman@suse.de>
To:     Qi Zheng <zhengqi.arch@bytedance.com>
Cc:     akpm@linux-foundation.org, willy@infradead.org, lstoakes@gmail.com,
        vbabka@suse.cz, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] mm: swap: fix performance regression on
 sparsetruncate-tiny
Message-ID: <20230406102238.i7jhmjl3vggncog5@suse.de>
References: <20230405161854.6931-1-zhengqi.arch@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20230405161854.6931-1-zhengqi.arch@bytedance.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 06, 2023 at 12:18:53AM +0800, Qi Zheng wrote:
> The ->percpu_pvec_drained was originally introduced by
> commit d9ed0d08b6c6 ("mm: only drain per-cpu pagevecs once per
> pagevec usage") to drain per-cpu pagevecs only once per pagevec
> usage. But after converting the swap code to be more folio-based,
> the commit c2bc16817aa0 ("mm/swap: add folio_batch_move_lru()")
> breaks this logic, which would cause ->percpu_pvec_drained to be
> reset to false, that means per-cpu pagevecs will be drained
> multiple times per pagevec usage.
> 
> In theory, there should be no functional changes when converting
> code to be more folio-based. We should call folio_batch_reinit()
> in folio_batch_move_lru() instead of folio_batch_init(). And to
> verify that we still need ->percpu_pvec_drained, I ran
> mmtests/sparsetruncate-tiny and got the following data:
> 
>                              baseline                   with
>                             baseline/                 patch/
> Min       Time      326.00 (   0.00%)      328.00 (  -0.61%)
> 1st-qrtle Time      334.00 (   0.00%)      336.00 (  -0.60%)
> 2nd-qrtle Time      338.00 (   0.00%)      341.00 (  -0.89%)
> 3rd-qrtle Time      343.00 (   0.00%)      347.00 (  -1.17%)
> Max-1     Time      326.00 (   0.00%)      328.00 (  -0.61%)
> Max-5     Time      327.00 (   0.00%)      330.00 (  -0.92%)
> Max-10    Time      328.00 (   0.00%)      331.00 (  -0.91%)
> Max-90    Time      350.00 (   0.00%)      357.00 (  -2.00%)
> Max-95    Time      395.00 (   0.00%)      390.00 (   1.27%)
> Max-99    Time      508.00 (   0.00%)      434.00 (  14.57%)
> Max       Time      547.00 (   0.00%)      476.00 (  12.98%)
> Amean     Time      344.61 (   0.00%)      345.56 *  -0.28%*
> Stddev    Time       30.34 (   0.00%)       19.51 (  35.69%)
> CoeffVar  Time        8.81 (   0.00%)        5.65 (  35.87%)
> BAmean-99 Time      342.38 (   0.00%)      344.27 (  -0.55%)
> BAmean-95 Time      338.58 (   0.00%)      341.87 (  -0.97%)
> BAmean-90 Time      336.89 (   0.00%)      340.26 (  -1.00%)
> BAmean-75 Time      335.18 (   0.00%)      338.40 (  -0.96%)
> BAmean-50 Time      332.54 (   0.00%)      335.42 (  -0.87%)
> BAmean-25 Time      329.30 (   0.00%)      332.00 (  -0.82%)
> 
> From the above it can be seen that we get similar data to when
> ->percpu_pvec_drained was introduced, so we still need it. Let's
> call folio_batch_reinit() in folio_batch_move_lru() to restore
> the original logic.
> 
> Fixes: c2bc16817aa0 ("mm/swap: add folio_batch_move_lru()")
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>

Well spotted,

Acked-by: Mel Gorman <mgorman@suse.de>

-- 
Mel Gorman
SUSE Labs
