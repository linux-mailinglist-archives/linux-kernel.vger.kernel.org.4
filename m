Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD91364BD3D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 20:26:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236542AbiLMT0j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 14:26:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236155AbiLMT0h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 14:26:37 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B12A22531
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 11:26:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9B26E61598
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 19:26:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B7ADC433D2;
        Tue, 13 Dec 2022 19:26:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670959596;
        bh=QK2oIpKFkW8Y+pz74LHORvAxoSG1SnUXy4S3zV/L44U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uT2x8oDPFQmOBhB06fHpXNUG8BIaSfysV1d0mSqOFUvwRfazhlQuGTCRhl/ICwcX3
         atRzYdVQCI2MxWZGJ1fhvuz2tWgKyT8mgq9/hsMktCizQBril30G86ftXB/uZb8pF0
         76nhXKgy3S1DoVKbelp+0TX6l9LPsW7tJwAtk6Iek7gBQ0SjSbZ3UBHB0gJpL47izZ
         pdTzrj9cns4eE1fHszq2m+KhynY2QYJ9/omZdazrJSvek/492QSB63e7XoGfVNWc+L
         ShQIINlai/aocSwdyFEL+yE/VsHVs9UD8/HtoIVHIlpH+HyTxC/Mi4ZPqmU0uKksKa
         i0z/sQc+VdkaA==
From:   SeongJae Park <sj@kernel.org>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        SeongJae Park <sj@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, damon@lists.linux.dev,
        vishal.moola@gmail.com, willy@infradead.org
Subject: Re: [PATCH -next 8/8] mm: damon: remove unneed damon_get_page()
Date:   Tue, 13 Dec 2022 19:26:33 +0000
Message-Id: <20221213192633.138774-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221213092735.187924-9-wangkefeng.wang@huawei.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kefeng,

On Tue, 13 Dec 2022 17:27:35 +0800 Kefeng Wang <wangkefeng.wang@huawei.com> wrote:

> After all damon_get_page() callers are converted to damon_get_folio(),
> remove unneed wrapper damon_get_page().
> 
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
>  mm/damon/ops-common.h | 7 -------
>  1 file changed, 7 deletions(-)
> 
> diff --git a/mm/damon/ops-common.h b/mm/damon/ops-common.h
> index 4ee607813981..35a2e42a27da 100644
> --- a/mm/damon/ops-common.h
> +++ b/mm/damon/ops-common.h
> @@ -8,13 +8,6 @@
>  #include <linux/damon.h>
>  
>  struct folio *damon_get_folio(unsigned long pfn);
> -static inline struct page *damon_get_page(unsigned long pfn)
> -{
> -	struct folio *folio = damon_get_folio(pfn);
> -
> -	return &folio->page;
> -}
> -
>  void damon_ptep_mkold(pte_t *pte, struct mm_struct *mm, unsigned long addr);

Let's keep the one blank line before damon_ptep_mkold().

>  void damon_pmdp_mkold(pmd_t *pmd, struct mm_struct *mm, unsigned long addr);
>  
> -- 
> 2.35.3

Thanks,
SJ
