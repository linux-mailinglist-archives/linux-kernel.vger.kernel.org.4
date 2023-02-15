Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D30C96978D9
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 10:21:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233818AbjBOJV4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 04:21:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230225AbjBOJVy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 04:21:54 -0500
Received: from smtp.smtpout.orange.fr (smtp-13.smtpout.orange.fr [80.12.242.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8D0BEC59
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 01:21:53 -0800 (PST)
Received: from [192.168.1.18] ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id SDz4pkY1ksavKSDz5p7jth; Wed, 15 Feb 2023 10:21:52 +0100
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Wed, 15 Feb 2023 10:21:52 +0100
X-ME-IP: 86.243.2.178
Message-ID: <d3c53024-2830-7bad-9d25-74b0070d5a0a@wanadoo.fr>
Date:   Wed, 15 Feb 2023 10:21:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] firmware: turris-mox-rwtm: Fix an error handling path in
 mox_get_board_info()
To:     =?UTF-8?Q?Marek_Beh=c3=ban?= <kabel@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <60b29f04b47a60ae6da754034a608aae1eba053a.1676452827.git.christophe.jaillet@wanadoo.fr>
Content-Language: fr
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <60b29f04b47a60ae6da754034a608aae1eba053a.1676452827.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 15/02/2023 à 10:20, Christophe JAILLET a écrit :
> wait_for_completion_timeout() returns 0 if timed out, and positive (at
> least 1, or number of jiffies left till timeout) if completed.
> 
> In case of timeout, return -ETIMEDOUT.
> 
> Fixes: 389711b37493 ("firmware: Add Turris Mox rWTM firmware driver")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> Compile tested only.
> ---
>   drivers/firmware/turris-mox-rwtm.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/firmware/turris-mox-rwtm.c b/drivers/firmware/turris-mox-rwtm.c
> index 6ea5789a89e2..577e87e1c6ee 100644
> --- a/drivers/firmware/turris-mox-rwtm.c
> +++ b/drivers/firmware/turris-mox-rwtm.c
> @@ -200,8 +200,8 @@ static int mox_get_board_info(struct mox_rwtm *rwtm)
>   		return ret;
>   
>   	ret = wait_for_completion_timeout(&rwtm->cmd_done, HZ / 2);
> -	if (ret < 0)
> -		return ret;
> +	if (ret == 0)
> +		return -ETIMEDOUT;
>   
>   	ret = mox_get_status(MBOX_CMD_BOARD_INFO, reply->retval);
>   	if (ret == -ENODATA) {

NACK, some other need to be fixed in the same file.
I'll send a V2.

CJ
