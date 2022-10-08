Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9628D5F8533
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Oct 2022 14:21:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbiJHMV2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Oct 2022 08:21:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbiJHMVZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Oct 2022 08:21:25 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9975431DFF
        for <linux-kernel@vger.kernel.org>; Sat,  8 Oct 2022 05:21:23 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Ml4191YLFzVhvd;
        Sat,  8 Oct 2022 20:17:01 +0800 (CST)
Received: from [10.174.151.185] (10.174.151.185) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 8 Oct 2022 20:21:21 +0800
Subject: Re: [PATCH 1/1] mm/mmap_lock: Remove unnecessary 'NULL' values from
 Pointer
To:     XU pengfei <xupengfei@nfschina.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20221008093942.3982-1-xupengfei@nfschina.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <45e6ce25-f0b6-4461-b88d-5b6bb78cabba@huawei.com>
Date:   Sat, 8 Oct 2022 20:21:21 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20221008093942.3982-1-xupengfei@nfschina.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.151.185]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/10/8 17:39, XU pengfei wrote:
> Pointer variables allocate memory first, and then judge. There is no
> need to initialize the assignment.
> 
> Signed-off-by: XU pengfei <xupengfei@nfschina.com>
> ---
>  mm/mmap_lock.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/mmap_lock.c b/mm/mmap_lock.c
> index 1854850b4b89..65a57731aa15 100644
> --- a/mm/mmap_lock.c
> +++ b/mm/mmap_lock.c
> @@ -198,7 +198,7 @@ void trace_mmap_lock_unreg(void)
>   */
>  static const char *get_mm_memcg_path(struct mm_struct *mm)
>  {
> -	char *buf = NULL;
> +	char *buf;
>  	struct mem_cgroup *memcg = get_mem_cgroup_from_mm(mm);
>  
>  	if (memcg == NULL)

It seems if memcg == NULL, the code will go to out and return uninitialized @buf?

Thanks,
Miaohe Lin




