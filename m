Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0668745A69
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 12:37:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230493AbjGCKhP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 06:37:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231243AbjGCKhM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 06:37:12 -0400
X-Greylist: delayed 1450 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 03 Jul 2023 03:37:09 PDT
Received: from www.kot-begemot.co.uk (ns1.kot-begemot.co.uk [217.160.28.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5341E3
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 03:37:09 -0700 (PDT)
Received: from [192.168.17.6] (helo=jain.kot-begemot.co.uk)
        by www.kot-begemot.co.uk with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <anton.ivanov@cambridgegreys.com>)
        id 1qGGXt-00GBFP-J6; Mon, 03 Jul 2023 10:12:39 +0000
Received: from jain.kot-begemot.co.uk ([192.168.3.3])
        by jain.kot-begemot.co.uk with esmtp (Exim 4.94.2)
        (envelope-from <anton.ivanov@cambridgegreys.com>)
        id 1qGGXs-009cOI-P3; Mon, 03 Jul 2023 11:12:38 +0100
Message-ID: <69e863ac-192d-2f63-62bb-8decdd719282@cambridgegreys.com>
Date:   Mon, 3 Jul 2023 11:12:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v1] drivers: use free_netdev before return
Content-Language: en-US
To:     Minjie Du <duminjie@vivo.com>, richard@nod.at,
        johannes@sipsolutions.net, sfr@canb.auug.org.au,
        linux-um@lists.infradead.org, linux-kernel@vger.kernel.org,
        machel@vivo.com
Cc:     opensource.kernel@vivo.com
References: <20230703094135.6443-1-duminjie@vivo.com>
From:   Anton Ivanov <anton.ivanov@cambridgegreys.com>
In-Reply-To: <20230703094135.6443-1-duminjie@vivo.com>
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



On 03/07/2023 10:41, Minjie Du wrote:
> We fixed a bug where the variable dev
> was not freed before return.
> 
> Signed-off-by: Minjie Du <duminjie@vivo.com>
> ---
>   arch/um/drivers/vector_kern.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/arch/um/drivers/vector_kern.c b/arch/um/drivers/vector_kern.c
> index 131b7cb29..af7f6fd4c 100644
> --- a/arch/um/drivers/vector_kern.c
> +++ b/arch/um/drivers/vector_kern.c
> @@ -1655,6 +1655,7 @@ static void vector_eth_configure(
>   	return;
>   
>   out_undo_user_init:

undo_user_init looks like an orphan from older code versions.

It should go away completely - jump to out_free_netdev instead.

> +	free_netdev(dev);
>   	return;
>   out_free_netdev:
>   	free_netdev(dev);

-- 
Anton R. Ivanov
Cambridgegreys Limited. Registered in England. Company Number 10273661
https://www.cambridgegreys.com/
