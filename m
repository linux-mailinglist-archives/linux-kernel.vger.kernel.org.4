Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA6D2745CFE
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 15:19:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231359AbjGCNTw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 09:19:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjGCNTv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 09:19:51 -0400
Received: from www.kot-begemot.co.uk (ns1.kot-begemot.co.uk [217.160.28.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A982ADD
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 06:19:50 -0700 (PDT)
Received: from [192.168.17.6] (helo=jain.kot-begemot.co.uk)
        by www.kot-begemot.co.uk with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <anton.ivanov@cambridgegreys.com>)
        id 1qGJSt-00GBX4-SU; Mon, 03 Jul 2023 13:19:41 +0000
Received: from jain.kot-begemot.co.uk ([192.168.3.3])
        by jain.kot-begemot.co.uk with esmtp (Exim 4.94.2)
        (envelope-from <anton.ivanov@cambridgegreys.com>)
        id 1qGJSt-009o8A-0T; Mon, 03 Jul 2023 14:19:41 +0100
Message-ID: <aa29acfe-0973-54dc-a4d8-2b0f06dc805c@cambridgegreys.com>
Date:   Mon, 3 Jul 2023 14:19:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2] drivers: use free_netdev before return
Content-Language: en-US
To:     Minjie Du <duminjie@vivo.com>, richard@nod.at,
        johannes@sipsolutions.net, sfr@canb.auug.org.au,
        linux-um@lists.infradead.org, linux-kernel@vger.kernel.org,
        11162212@vivo.com
Cc:     opensource.kernel@vivo.com
References: <20230703131129.8588-1-duminjie@vivo.com>
From:   Anton Ivanov <anton.ivanov@cambridgegreys.com>
In-Reply-To: <20230703131129.8588-1-duminjie@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -2.0
X-Spam-Score: -2.0
X-Clacks-Overhead: GNU Terry Pratchett
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 03/07/2023 14:11, Minjie Du wrote:
> We will replace the old version of
> undo_user_init and use out_free_netdev
> 
> Signed-off-by: Minjie Du <duminjie@vivo.com>
> ---
>   arch/um/drivers/vector_kern.c | 5 +----
>   1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/arch/um/drivers/vector_kern.c b/arch/um/drivers/vector_kern.c
> index af7f6fd4c..7ae6ab8df 100644
> --- a/arch/um/drivers/vector_kern.c
> +++ b/arch/um/drivers/vector_kern.c
> @@ -1646,7 +1646,7 @@ static void vector_eth_configure(
>   	err = register_netdevice(dev);
>   	rtnl_unlock();
>   	if (err)
> -		goto out_undo_user_init;
> +		goto out_free_netdev;
>   
>   	spin_lock(&vector_devices_lock);
>   	list_add(&device->list, &vector_devices);
> @@ -1654,9 +1654,6 @@ static void vector_eth_configure(
>   
>   	return;
>   
> -out_undo_user_init:
> -	free_netdev(dev);
> -	return;
>   out_free_netdev:
>   	free_netdev(dev);
>   out_free_device:

Acked-By: "Anton Ivanov" <anton.ivanov@cambridgegreys.com>

-- 
Anton R. Ivanov
Cambridgegreys Limited. Registered in England. Company Number 10273661
https://www.cambridgegreys.com/
