Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C553664245
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 14:49:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232769AbjAJNtl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 08:49:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237872AbjAJNtd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 08:49:33 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50F907CDD2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 05:49:30 -0800 (PST)
Received: from dggpemm100011.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4NrsZP3slxzRqq2;
        Tue, 10 Jan 2023 21:47:41 +0800 (CST)
Received: from [10.174.179.155] (10.174.179.155) by
 dggpemm100011.china.huawei.com (7.185.36.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Tue, 10 Jan 2023 21:49:21 +0800
Message-ID: <f0af597f-0c56-87e1-995a-e0c55e645f7e@huawei.com>
Date:   Tue, 10 Jan 2023 21:49:21 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:104.0) Gecko/20100101
 Thunderbird/104.0
Subject: Re: [PATCH-next v2] lib: parser: optimize match_NUMER apis to use
 local array
To:     <linux-kernel@vger.kernel.org>
CC:     <tj@kernel.org>, <jack@suse.cz>, <bingjingc@synology.com>,
        <ebiggers@google.com>, <james.smart@broadcom.com>,
        <houtao1@huawei.com>, <yi.zhang@huawei.com>,
        <yangerkun@huawei.com>, <yukuai3@huawei.com>
References: <20221213141755.768643-1-lilingfeng3@huawei.com>
From:   "lilingfeng (A)" <lilingfeng3@huawei.com>
In-Reply-To: <20221213141755.768643-1-lilingfeng3@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.155]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm100011.china.huawei.com (7.185.36.112)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2022/12/13 22:17, Li Lingfeng 写道:
> Memory will be allocated to store substring_t in match_strdup(), which means
> the caller of match_strdup() may need to be scheduled out to wait for reclaiming
> memory.
>
> Using local array to store substring_t to remove the restriction.
>
> Link: https://lore.kernel.org/all/20221104023938.2346986-5-yukuai1@huaweicloud.com/
> Signed-off-by: Li Lingfeng <lilingfeng3@huawei.com>
> ---
>   v1->v2:
>     change the name of buffer's length
>     use match_strlcpy() to copy string and keep string length check
>   lib/parser.c | 42 +++++++++++++++++++++++-------------------
>   1 file changed, 23 insertions(+), 19 deletions(-)
>
> diff --git a/lib/parser.c b/lib/parser.c

I can't find the maintainer of this module through the script, does 
anyone know?

[lilingfeng@ceph-admin linux-next]$ ./scripts/get_maintainer.pl 
0001-lib-parser-optimize-match_NUMER-apis-to-use-local-ar.patch

Bad divisor in main::vcs_assign: 0
"GitAuthor: Li Lingfeng" <lilingfeng3@huawei.com> 
(authored:1/1=100%,added_lines:23/23=100%,removed_lines:19/19=100%)
linux-kernel@vger.kernel.org (open list)

Thanks.

> index bcb23484100e..0d00f0adb063 100644
> --- a/lib/parser.c
> +++ b/lib/parser.c
> @@ -11,6 +11,15 @@
>   #include <linux/slab.h>
>   #include <linux/string.h>
>   
> +/*
> + * max size needed by diffrent bases to express U64
> + * HEX: "0xFFFFFFFFFFFFFFFF" --> 18
> + * DEC: "18446744073709551615" --> 20
> + * OCT: "01777777777777777777777" --> 23
> + * pick the max one to define NUMBER_BUF_LEN
> + */
> +#define NUMBER_BUF_LEN 24
> +
>   /**
>    * match_one - Determines if a string matches a simple pattern
>    * @s: the string to examine for presence of the pattern
> @@ -129,14 +138,13 @@ EXPORT_SYMBOL(match_token);
>   static int match_number(substring_t *s, int *result, int base)
>   {
>   	char *endp;
> -	char *buf;
> +	char buf[NUMBER_BUF_LEN];
>   	int ret;
>   	long val;
>   
> -	buf = match_strdup(s);
> -	if (!buf)
> -		return -ENOMEM;
> -
> +	if ((s->to - s->from) >= NUMBER_BUF_LEN)
> +		return -ERANGE;
> +	match_strlcpy(buf, s, NUMBER_BUF_LEN);
>   	ret = 0;
>   	val = simple_strtol(buf, &endp, base);
>   	if (endp == buf)
> @@ -145,7 +153,6 @@ static int match_number(substring_t *s, int *result, int base)
>   		ret = -ERANGE;
>   	else
>   		*result = (int) val;
> -	kfree(buf);
>   	return ret;
>   }
>   
> @@ -163,18 +170,16 @@ static int match_number(substring_t *s, int *result, int base)
>    */
>   static int match_u64int(substring_t *s, u64 *result, int base)
>   {
> -	char *buf;
> +	char buf[NUMBER_BUF_LEN];
>   	int ret;
>   	u64 val;
>   
> -	buf = match_strdup(s);
> -	if (!buf)
> -		return -ENOMEM;
> -
> +	if ((s->to - s->from) >= NUMBER_BUF_LEN)
> +		return -ERANGE;
> +	match_strlcpy(buf, s, NUMBER_BUF_LEN);
>   	ret = kstrtoull(buf, base, &val);
>   	if (!ret)
>   		*result = val;
> -	kfree(buf);
>   	return ret;
>   }
>   
> @@ -206,14 +211,13 @@ EXPORT_SYMBOL(match_int);
>    */
>   int match_uint(substring_t *s, unsigned int *result)
>   {
> -	int err = -ENOMEM;
> -	char *buf = match_strdup(s);
> +	char buf[NUMBER_BUF_LEN];
>   
> -	if (buf) {
> -		err = kstrtouint(buf, 10, result);
> -		kfree(buf);
> -	}
> -	return err;
> +	if ((s->to - s->from) >= NUMBER_BUF_LEN)
> +		return -ERANGE;
> +	match_strlcpy(buf, s, NUMBER_BUF_LEN);
> +
> +	return kstrtouint(buf, 10, result);
>   }
>   EXPORT_SYMBOL(match_uint);
>   
