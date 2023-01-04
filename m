Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9392365CE55
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 09:30:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234010AbjADIay (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 03:30:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234126AbjADIab (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 03:30:31 -0500
Received: from www.kot-begemot.co.uk (ns1.kot-begemot.co.uk [217.160.28.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 387EE1BE94
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 00:30:01 -0800 (PST)
Received: from [192.168.17.6] (helo=jain.kot-begemot.co.uk)
        by www.kot-begemot.co.uk with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <anton.ivanov@cambridgegreys.com>)
        id 1pCz9j-005EGa-9e; Wed, 04 Jan 2023 08:29:51 +0000
Received: from jain.kot-begemot.co.uk ([192.168.3.3])
        by jain.kot-begemot.co.uk with esmtp (Exim 4.94.2)
        (envelope-from <anton.ivanov@cambridgegreys.com>)
        id 1pCz9f-00617y-UC; Wed, 04 Jan 2023 08:29:50 +0000
Message-ID: <7bd5ca75-5e97-5afb-5da2-fd35d7ef8b80@cambridgegreys.com>
Date:   Wed, 4 Jan 2023 08:29:47 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v2] um: vector: Fix memory leak in vector_config
Content-Language: en-US
To:     Miaoqian Lin <linmq006@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Johannes Berg <johannes@sipsolutions.net>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, linux-um@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20230104081408.4074275-1-linmq006@gmail.com>
From:   Anton Ivanov <anton.ivanov@cambridgegreys.com>
In-Reply-To: <20230104081408.4074275-1-linmq006@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -2.0
X-Spam-Score: -2.0
X-Clacks-Overhead: GNU Terry Pratchett
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04/01/2023 08:14, Miaoqian Lin wrote:
> kstrdup() return newly allocated copy of the string.
> Call kfree() to release the memory when uml_parse_vector_ifspec() fails.
> 
> Fixes: 49da7e64f33e ("High Performance UML Vector Network Driver")
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
> ---
> changes in v2:
> - only call kfree() when uml_parse_vector_ifspec() fails.
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

Acked-By: Anton Ivanov <anton.ivanov@cambridgegreys.com>

-- 
Anton R. Ivanov
Cambridgegreys Limited. Registered in England. Company Number 10273661
https://www.cambridgegreys.com/
