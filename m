Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42A4C62C39B
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 17:10:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233978AbiKPQK1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 11:10:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230204AbiKPQKL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 11:10:11 -0500
Received: from www.kot-begemot.co.uk (ns1.kot-begemot.co.uk [217.160.28.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B8FF56ED4
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 08:10:09 -0800 (PST)
Received: from [192.168.17.6] (helo=jain.kot-begemot.co.uk)
        by www.kot-begemot.co.uk with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <anton.ivanov@cambridgegreys.com>)
        id 1ovKyw-002vdR-5F; Wed, 16 Nov 2022 16:09:46 +0000
Received: from jain.kot-begemot.co.uk ([192.168.3.3])
        by jain.kot-begemot.co.uk with esmtp (Exim 4.94.2)
        (envelope-from <anton.ivanov@cambridgegreys.com>)
        id 1ovKyt-002AiB-IG; Wed, 16 Nov 2022 16:09:45 +0000
Message-ID: <9a106cdc-03ea-cec6-1ef7-3c6fbf5ae753@cambridgegreys.com>
Date:   Wed, 16 Nov 2022 16:09:43 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH -next] um: vector: Fix memory leak in vector_config
Content-Language: en-US
To:     Xiang Yang <xiangyang3@huawei.com>, patchwork@huawei.com,
        kuba@kernel.org, richard@nod.at, johannes@sipsolutions.net
Cc:     linux-um@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20221115073225.161592-1-xiangyang3@huawei.com>
From:   Anton Ivanov <anton.ivanov@cambridgegreys.com>
In-Reply-To: <20221115073225.161592-1-xiangyang3@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -2.0
X-Spam-Score: -2.0
X-Clacks-Overhead: GNU Terry Pratchett
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 15/11/2022 07:32, Xiang Yang wrote:
> If the return value of the uml_parse_vector_ifspec function is NULL,
> we should call kfree(params) to prevent memory leak.
> 
> Fixes: 49da7e64f33e ("High Performance UML Vector Network Driver")
> Signed-off-by: Xiang Yang <xiangyang3@huawei.com>
> ---
>   arch/um/drivers/vector_kern.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/arch/um/drivers/vector_kern.c b/arch/um/drivers/vector_kern.c
> index ded7c47d2fbe..131b7cb29576 100644
> --- a/arch/um/drivers/vector_kern.c
> +++ b/arch/um/drivers/vector_kern.c
> @@ -767,6 +767,7 @@ static int vector_config(char *str, char **error_out)
>   
>   	if (parsed == NULL) {
>   		*error_out = "vector_config failed to parse parameters";
> +		kfree(params);
>   		return -EINVAL;
>   	}
>   

Acked-By: Anton Ivanov <anton.ivanov@kot-begemot.co.uk>
-- 
Anton R. Ivanov
Cambridgegreys Limited. Registered in England. Company Number 10273661
https://www.cambridgegreys.com/
