Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA25461E343
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Nov 2022 16:53:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230012AbiKFPxb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 10:53:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229835AbiKFPx3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 10:53:29 -0500
Received: from smtp.smtpout.orange.fr (smtp-18.smtpout.orange.fr [80.12.242.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30238BC94
        for <linux-kernel@vger.kernel.org>; Sun,  6 Nov 2022 07:53:26 -0800 (PST)
Received: from [192.168.1.18] ([86.243.100.34])
        by smtp.orange.fr with ESMTPA
        id rhxHo61YXtk1arhxHobRD1; Sun, 06 Nov 2022 16:53:12 +0100
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 06 Nov 2022 16:53:12 +0100
X-ME-IP: 86.243.100.34
Message-ID: <49a39f01-3457-e049-d16e-d0d729aa0a73@wanadoo.fr>
Date:   Sun, 6 Nov 2022 16:53:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH] mailbox: platform-mhu: Remove unnecessary print function
 dev_err()
Content-Language: fr, en-US
To:     wangkailong@jari.cn, jassisinghbrar@gmail.com
Cc:     linux-kernel@vger.kernel.org
References: <6745733c.be.1844d54f4b9.Coremail.wangkailong@jari.cn>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <6745733c.be.1844d54f4b9.Coremail.wangkailong@jari.cn>
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

Le 06/11/2022 à 15:25, wangkailong@jari.cn a écrit :
> Eliminate the follow coccicheck warning:
> 
> ./drivers/mailbox/platform_mhu.c:139:3-10: line 139 is redundant because
> platform_get_irq() already prints an error
> 
> Signed-off-by: KaiLong Wang <wangkailong@jari.cn>
> ---
>   drivers/mailbox/platform_mhu.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/mailbox/platform_mhu.c b/drivers/mailbox/platform_mhu.c
> index a5922ac0b0bf..08e0eedea860 100644
> --- a/drivers/mailbox/platform_mhu.c
> +++ b/drivers/mailbox/platform_mhu.c
> @@ -136,7 +136,6 @@ static int platform_mhu_probe(struct platform_device *pdev)
>   		mhu->chan[i].con_priv = &mhu->mlink[i];
>   		mhu->mlink[i].irq = platform_get_irq(pdev, i);
>   		if (mhu->mlink[i].irq < 0) {
> -			dev_err(dev, "failed to get irq%d\n", i);
>   			return mhu->mlink[i].irq;
>   		}

Hi,

apparently, you sent several patches like this one.

When doing such cleanups, you should also remove the now useless { } 
when there is just one statement left, after the "if".

CJ

>   		mhu->mlink[i].rx_reg = mhu->base + platform_mhu_reg[i];

