Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 514D061E352
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Nov 2022 17:08:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230083AbiKFQIw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 11:08:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229841AbiKFQIo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 11:08:44 -0500
Received: from smtp.smtpout.orange.fr (smtp-14.smtpout.orange.fr [80.12.242.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 079462DFF
        for <linux-kernel@vger.kernel.org>; Sun,  6 Nov 2022 08:08:42 -0800 (PST)
Received: from [192.168.1.18] ([86.243.100.34])
        by smtp.orange.fr with ESMTPA
        id riCForZc23VQxriCFoI6AX; Sun, 06 Nov 2022 17:08:41 +0100
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 06 Nov 2022 17:08:41 +0100
X-ME-IP: 86.243.100.34
Message-ID: <f4c81b9a-ba70-3dea-e4f6-9ff62a3e27e8@wanadoo.fr>
Date:   Sun, 6 Nov 2022 17:08:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH] macintosh: Fix warning comparing pointer to 0
Content-Language: fr
To:     wangkailong@jari.cn, benh@kernel.crashing.org,
        christophe.leroy@csgroup.eu, mpe@ellerman.id.au
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <c31207c.c3.1844d85a6aa.Coremail.wangkailong@jari.cn>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <c31207c.c3.1844d85a6aa.Coremail.wangkailong@jari.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 06/11/2022 à 16:18, wangkailong@jari.cn a écrit :
> Fix the following coccicheck warning:
> 
> drivers/macintosh/macio-adb.c:103:13-14: WARNING comparing pointer to 0.
> 
> Signed-off-by: KaiLong Wang <wangkailong@jari.cn>
> ---
>   drivers/macintosh/macio-adb.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/macintosh/macio-adb.c b/drivers/macintosh/macio-adb.c
> index 9b63bd2551c6..1c1c375a817d 100644
> --- a/drivers/macintosh/macio-adb.c
> +++ b/drivers/macintosh/macio-adb.c
> @@ -100,7 +100,7 @@ int macio_init(void)
>   	unsigned int irq;
>   
>   	adbs = of_find_compatible_node(NULL, "adb", "chrp,adb0");
> -	if (adbs == 0)
> +	if (adbs)

Hi
no, this should be "if (!adbs)"

CJ

>   		return -ENXIO;
>   
>   	if (of_address_to_resource(adbs, 0, &r)) {

