Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE1156931D3
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Feb 2023 15:58:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229546AbjBKO6E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Feb 2023 09:58:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjBKO6C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Feb 2023 09:58:02 -0500
Received: from smtp.smtpout.orange.fr (smtp-13.smtpout.orange.fr [80.12.242.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10FA61B56F
        for <linux-kernel@vger.kernel.org>; Sat, 11 Feb 2023 06:58:01 -0800 (PST)
Received: from [192.168.1.18] ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id QrK9pJcJMsavKQrK9pxr1Z; Sat, 11 Feb 2023 15:58:00 +0100
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 11 Feb 2023 15:58:00 +0100
X-ME-IP: 86.243.2.178
Message-ID: <1f9d31ad-db91-a6b9-3a70-cfc983cd99b7@wanadoo.fr>
Date:   Sat, 11 Feb 2023 15:57:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] iio: frequency: adf4377: remove duplicate/repeating
 constant
Content-Language: fr
To:     Deepak R Varma <drv@mailo.com>,
        Antoniu Miclaus <antoniu.miclaus@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Saurabh Singh Sengar <ssengar@microsoft.com>,
        Praveen Kumar <kumarpraveen@linux.microsoft.com>
References: <Y+c+mwNnlPpSH49/@ubun2204.myguest.virtualbox.org>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <Y+c+mwNnlPpSH49/@ubun2204.myguest.virtualbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 11/02/2023 à 08:07, Deepak R Varma a écrit :
> Constant ADF4377_0000_SOFT_RESET_R_MSK is unnecessarily or'ed with
> itself. Remove the redundant constant from the expression.
> Issue identified using doublebitand.cocci Coccinelle semantic patch.
> 
> Signed-off-by: Deepak R Varma <drv@mailo.com>
> ---
>   drivers/iio/frequency/adf4377.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/frequency/adf4377.c b/drivers/iio/frequency/adf4377.c
> index 26abecbd51e0..caefd7ea6b14 100644
> --- a/drivers/iio/frequency/adf4377.c
> +++ b/drivers/iio/frequency/adf4377.c
> @@ -495,8 +495,8 @@ static int adf4377_soft_reset(struct adf4377_state *st)
>   		return ret;
>   
>   	return regmap_read_poll_timeout(st->regmap, 0x0, read_val,
> -					!(read_val & (ADF4377_0000_SOFT_RESET_R_MSK |
> -					ADF4377_0000_SOFT_RESET_R_MSK)), 200, 200 * 100);
> +					!(read_val & ADF4377_0000_SOFT_RESET_R_MSK),
> +					200, 200 * 100);

Based on the code just above, it is likely that one is expected to be 
ADF4377_0000_SOFT_RESET_MSK.

CJ

>   }
>   
>   static int adf4377_get_freq(struct adf4377_state *st, u64 *freq)

