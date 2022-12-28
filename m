Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC0196571B5
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 02:45:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232225AbiL1Bpa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 20:45:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232207AbiL1BpF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 20:45:05 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 454ABD2FC;
        Tue, 27 Dec 2022 17:45:04 -0800 (PST)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4NhZ7H326fzJqkF;
        Wed, 28 Dec 2022 09:43:55 +0800 (CST)
Received: from [10.174.151.185] (10.174.151.185) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Wed, 28 Dec 2022 09:45:00 +0800
Subject: Re: [PATCH v2] mm/page_reporting: replace rcu_access_pointer() with
 rcu_dereference_protected()
To:     SeongJae Park <sj@kernel.org>, <akpm@linux-foundation.org>
CC:     <alexander.h.duyck@linux.intel.com>, <paulmck@kernel.org>,
        <linux-mm@kvack.org>, <rcu@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20221228012902.1510901-1-sj@kernel.org>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <4bc4ab74-3ccd-f892-b387-d48451463d3c@huawei.com>
Date:   Wed, 28 Dec 2022 09:45:00 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20221228012902.1510901-1-sj@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.151.185]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/12/28 9:29, SeongJae Park wrote:
> Page reporting fetches pr_dev_info using rcu_access_pointer(), which is
> for safely fetching a pointer that will not be dereferenced but could
> concurrently updated.  The code indeed does not dereference pr_dev_info
> after fetcing it using rcu_access_pointer(), but it fetches the pointer

Thanks for your work. Might something to improve.

s/fetcing/fetching/

> while concurrent updtes to the pointer is avoided by holding the update

s/updtes/updates/

> side lock, page_reporting_mutex.
> 
> In the case, rcu_dereference_protected() is recommended because it
> provides better readability and performance on some cases, as
> rcu_dereference_protected() avoids use of READ_ONCE().  Replace the
> rcu_access_pointer() calls with rcu_dereference_protected().
> 
> Signed-off-by: SeongJae Park <sj@kernel.org>
> ---
> Changes from v1
> (https://lore.kernel.org/linux-mm/20221227192158.2553-1-sj@kernel.org/)
> - Explicitly set the protection condition (Matthew Wilcox)
> 
>  mm/page_reporting.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/page_reporting.c b/mm/page_reporting.c
> index 79a8554f024c..5c557a3e1423 100644
> --- a/mm/page_reporting.c
> +++ b/mm/page_reporting.c
> @@ -356,7 +356,8 @@ int page_reporting_register(struct page_reporting_dev_info *prdev)
>  	mutex_lock(&page_reporting_mutex);
>  
>  	/* nothing to do if already in use */
> -	if (rcu_access_pointer(pr_dev_info)) {
> +	if (rcu_dereference_protected(pr_dev_info,
> +				lockdep_is_held(&page_reporting_order))) {

I think it should be lockdep_is_held(&page_reporting_mutex) instead of lockdep_is_held(&page_reporting_order) here?

Thanks,
Miaohe Lin

