Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 287C061E355
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Nov 2022 17:13:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230137AbiKFQND (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 11:13:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229841AbiKFQNC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 11:13:02 -0500
Received: from smtp.smtpout.orange.fr (smtp-17.smtpout.orange.fr [80.12.242.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61D9E38A0
        for <linux-kernel@vger.kernel.org>; Sun,  6 Nov 2022 08:13:01 -0800 (PST)
Received: from [192.168.1.18] ([86.243.100.34])
        by smtp.orange.fr with ESMTPA
        id riGKoGCAyXaJmriGKor48n; Sun, 06 Nov 2022 17:12:59 +0100
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 06 Nov 2022 17:12:59 +0100
X-ME-IP: 86.243.100.34
Message-ID: <7924fc05-02d7-a2b3-85e3-d30dfe081da3@wanadoo.fr>
Date:   Sun, 6 Nov 2022 17:12:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH] macintosh/adb: Fix warning comparing pointer to 0
Content-Language: fr
To:     wangkailong@jari.cn, benh@kernel.crashing.org, mpe@ellerman.id.au,
        gregkh@linuxfoundation.org, sohu0106@126.com,
        christophe.leroy@csgroup.eu
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <2ef267c.c4.1844d8ef2d8.Coremail.wangkailong@jari.cn>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <2ef267c.c4.1844d8ef2d8.Coremail.wangkailong@jari.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 06/11/2022 à 16:28, wangkailong@jari.cn a écrit :
> Fix the following coccicheck warning:
> 
> drivers/macintosh/adb.c:676:14-15: WARNING comparing pointer to 0.
> 
> Signed-off-by: KaiLong Wang <wangkailong@jari.cn>
> ---
>   drivers/macintosh/adb.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/macintosh/adb.c b/drivers/macintosh/adb.c
> index 1bbb9ca08d40..076253599bd4 100644
> --- a/drivers/macintosh/adb.c
> +++ b/drivers/macintosh/adb.c
> @@ -673,7 +673,7 @@ static int adb_open(struct inode *inode, struct file *file)
>   		goto out;
>   	}
>   	state = kmalloc(sizeof(struct adbdev_state), GFP_KERNEL);
> -	if (state == 0) {
> +	if (state) {

Hi
no, this should be "if (!state)"

CJ

>   		ret = -ENOMEM;
>   		goto out;
>   	}

