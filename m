Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D2F87324D2
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 03:48:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232912AbjFPBsf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 21:48:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjFPBse (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 21:48:34 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8C5610F7
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 18:48:32 -0700 (PDT)
Received: from dggpemm500001.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Qj29T20dRzTkqW;
        Fri, 16 Jun 2023 09:47:57 +0800 (CST)
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 16 Jun 2023 09:48:30 +0800
Message-ID: <f0aa8017-9136-0c77-291c-0db5c3c6fde3@huawei.com>
Date:   Fri, 16 Jun 2023 09:48:30 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH] mm/damon/core-test: add a test for damon_set_attrs()
Content-Language: en-US
To:     SeongJae Park <sj@kernel.org>, <akpm@linux-foundation.org>
CC:     <damon@lists.linux.dev>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
References: <20230615183323.87561-1-sj@kernel.org>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <20230615183323.87561-1-sj@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/6/16 2:33, SeongJae Park wrote:
> Commit 5ff6e2fff88e ("mm/damon/core: fix divide error in
> damon_nr_accesses_to_accesses_bp()") fixed a bug by adding arguments
> validation in damon_set_attrs().  Add a unit test for the added
> validation to ensure the bug cannot occur again.
> 
> Signed-off-by: SeongJae Park <sj@kernel.org>


Reviewed-by: Kefeng Wang <wangkefeng.wang@huawei.com>

> ---
>   mm/damon/core-test.h | 24 ++++++++++++++++++++++++
>   1 file changed, 24 insertions(+)
> 
> diff --git a/mm/damon/core-test.h b/mm/damon/core-test.h
> index fae64d32b925..c11210124344 100644
> --- a/mm/damon/core-test.h
> +++ b/mm/damon/core-test.h
> @@ -318,6 +318,29 @@ static void damon_test_update_monitoring_result(struct kunit *test)
>   	KUNIT_EXPECT_EQ(test, r->age, 20);
>   }
>   
> +static void damon_test_set_attrs(struct kunit *test)
> +{
> +	struct damon_ctx ctx;
> +	struct damon_attrs valid_attrs = {
> +		.min_nr_regions = 10, .max_nr_regions = 1000,
> +		.sample_interval = 5000, .aggr_interval = 100000,};
> +	struct damon_attrs invalid_attrs;
> +
> +	KUNIT_EXPECT_EQ(test, damon_set_attrs(&ctx, &valid_attrs), 0);
> +
> +	invalid_attrs = valid_attrs;
> +	invalid_attrs.min_nr_regions = 1;
> +	KUNIT_EXPECT_EQ(test, damon_set_attrs(&ctx, &invalid_attrs), -EINVAL);
> +
> +	invalid_attrs = valid_attrs;
> +	invalid_attrs.max_nr_regions = 9;
> +	KUNIT_EXPECT_EQ(test, damon_set_attrs(&ctx, &invalid_attrs), -EINVAL);
> +
> +	invalid_attrs = valid_attrs;
> +	invalid_attrs.aggr_interval = 4999;
> +	KUNIT_EXPECT_EQ(test, damon_set_attrs(&ctx, &invalid_attrs), -EINVAL);
> +}
> +
>   static struct kunit_case damon_test_cases[] = {
>   	KUNIT_CASE(damon_test_target),
>   	KUNIT_CASE(damon_test_regions),
> @@ -329,6 +352,7 @@ static struct kunit_case damon_test_cases[] = {
>   	KUNIT_CASE(damon_test_ops_registration),
>   	KUNIT_CASE(damon_test_set_regions),
>   	KUNIT_CASE(damon_test_update_monitoring_result),
> +	KUNIT_CASE(damon_test_set_attrs),
>   	{},
>   };
>   
