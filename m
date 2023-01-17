Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEE5966E7A4
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 21:22:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232375AbjAQUWL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 15:22:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235634AbjAQUPX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 15:15:23 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECB0910A90
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 11:11:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5A3536152B
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 19:11:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00A0DC433EF;
        Tue, 17 Jan 2023 19:11:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673982671;
        bh=fF8gp2hSR6+JJn7LTuIwE4xKl7pKegt4qrFJr/3TmQI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IP2SlV7FAbCxTKuKD83g0Aqt+q0bIf/PP1hl8zSoMy9ZG/zIaFVd4CCwkoS3XpZB9
         7Cg4Dx+F4aAXVi5y19f6td9OMtAeakfR0YXpIUjPpj6gBuz76uPcbNN3XCFxFRiTEF
         RmpBuuU313btpOh/ZLYLDlUz8yu+aTBo9ammh2Q8dezChyC0XKSlhUN22S6NerjN/k
         M2HVcWKdzQ8a+2eIt/W+wBr9sYInx37oy9+B9zIpxLsBbxG1nGNdJOaHDhPNaq00DW
         8n+Tb3Wtt7Tv1ANEhnfizKVm3cYVpGZDOeISB1IS7QKSU6wRhmoc6i7TU4gf4xKJga
         uoq9pm9B4M3YA==
From:   SeongJae Park <sj@kernel.org>
To:     Liam Howlett <liam.howlett@oracle.com>
Cc:     brendanhiggins@google.com, kunit-dev@googlegroups.com,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        SeongJae Park <sj@kernel.org>,
        "damon@lists.linux.dev" <damon@lists.linux.dev>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v3 30/48] mm/damon: Stop using vma_mas_store() for maple tree store
Date:   Tue, 17 Jan 2023 19:11:09 +0000
Message-Id: <20230117191109.116438-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230117023335.1690727-31-Liam.Howlett@oracle.com>
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

Cc-ing kunit people.

Hi Liam,


Could we put touching file name on the summary?
E.g., mm/damon/vaddr-test: Stop using ...

On Tue, 17 Jan 2023 02:34:19 +0000 Liam Howlett <liam.howlett@oracle.com> wrote:

> From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
> 
> Prepare for the removal of the vma_mas_store() function by open coding
> the maple tree store in this test code.  Set the range of the maple
> state and call the store function directly.
> 
> Cc: SeongJae Park <sj@kernel.org>
> Cc: damon@lists.linux.dev
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> ---
>  mm/damon/vaddr-test.h | 19 +++++++++++++------
>  1 file changed, 13 insertions(+), 6 deletions(-)
> 
> diff --git a/mm/damon/vaddr-test.h b/mm/damon/vaddr-test.h
> index bce37c487540..6098933d3272 100644
> --- a/mm/damon/vaddr-test.h
> +++ b/mm/damon/vaddr-test.h
> @@ -14,19 +14,26 @@
>  
>  #include <kunit/test.h>
>  
> -static void __link_vmas(struct maple_tree *mt, struct vm_area_struct *vmas,
> +static int __link_vmas(struct maple_tree *mt, struct vm_area_struct *vmas,
>  			ssize_t nr_vmas)
>  {
> -	int i;
> +	int i, ret = -ENOMEM;
>  	MA_STATE(mas, mt, 0, 0);
>  
>  	if (!nr_vmas)
> -		return;
> +		return -ENOENT;
>  
>  	mas_lock(&mas);
> -	for (i = 0; i < nr_vmas; i++)
> -		vma_mas_store(&vmas[i], &mas);
> +	for (i = 0; i < nr_vmas; i++) {
> +		mas_set_range(&mas, vmas[i].vm_start, vmas[i].vm_end - 1);
> +		if (mas_store_gfp(&mas, &vmas[i], GFP_KERNEL))
> +			goto failed;
> +	}
> +	ret = 0;
> +
> +failed:
>  	mas_unlock(&mas);
> +	return ret;
>  }
>  
>  /*
> @@ -71,7 +78,7 @@ static void damon_test_three_regions_in_vmas(struct kunit *test)
>  	};
>  
>  	mt_init_flags(&mm.mm_mt, MM_MT_FLAGS);
> -	__link_vmas(&mm.mm_mt, vmas, ARRAY_SIZE(vmas));
> +	KUNIT_EXPECT_EQ(test, __link_vmas(&mm.mm_mt, vmas, ARRAY_SIZE(vmas)), 0);

In case of the __link_vmas() failure, I think we should skip this test using
'kunit_skip()', rather marking this test failed.


Thanks,
SJ

>  
>  	__damon_va_three_regions(&mm, regions);
>  
> -- 
> 2.35.1
