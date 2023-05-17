Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E03370607C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 08:55:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229645AbjEQGzO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 02:55:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjEQGzL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 02:55:11 -0400
Received: from smtp.gentoo.org (woodpecker.gentoo.org [IPv6:2001:470:ea4a:1:5054:ff:fec7:86e4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E1AB131;
        Tue, 16 May 2023 23:55:08 -0700 (PDT)
Message-ID: <2535e812-7cde-f37b-6aba-124860fa88f7@gentoo.org>
Date:   Wed, 17 May 2023 08:55:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
From:   zzam@gentoo.org
Subject: Re: [PATCH 07/24] media: dvb-usb-v2: rtl28xxu: fix null-ptr-deref in
 rtl28xxu_i2c_xfer
Content-Language: en-GB
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Zhang Shurong <zhang_shurong@foxmail.com>,
        Antti Palosaari <crope@iki.fi>, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org
References: <53558de2b5c4f4ee6bfcfbe34e27071c2d0073d5.1684000646.git.mchehab@kernel.org>
 <77c81598e4c5abbc444844108f71cabc562a50d7.1684000646.git.mchehab@kernel.org>
In-Reply-To: <77c81598e4c5abbc444844108f71cabc562a50d7.1684000646.git.mchehab@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 13.05.23 um 19:57 schrieb Mauro Carvalho Chehab:
> From: Zhang Shurong <zhang_shurong@foxmail.com>
> 
> In rtl28xxu_i2c_xfer, msg is controlled by user. When msg[i].buf
> is null and msg[i].len is zero, former checks on msg[i].buf would be
> passed. Malicious data finally reach rtl28xxu_i2c_xfer. If accessing
> msg[i].buf[0] without sanity check, null ptr deref would happen.
> We add check on msg[i].len to prevent crash.
> 
> Similar commit:
> commit 0ed554fd769a
> ("media: dvb-usb: az6027: fix null-ptr-deref in az6027_i2c_xfer()")
> 
> Link: https://lore.kernel.org/linux-media/tencent_3623572106754AC2F266B316798B0F6CCA05@qq.com
> Signed-off-by: Zhang Shurong <zhang_shurong@foxmail.com>
> Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
> ---
>   drivers/media/usb/dvb-usb-v2/rtl28xxu.c | 20 ++++++++++++++++++++
>   1 file changed, 20 insertions(+)
> 
> diff --git a/drivers/media/usb/dvb-usb-v2/rtl28xxu.c b/drivers/media/usb/dvb-usb-v2/rtl28xxu.c
> index 795a012d4020..f7884bb56fcc 100644
> --- a/drivers/media/usb/dvb-usb-v2/rtl28xxu.c
> +++ b/drivers/media/usb/dvb-usb-v2/rtl28xxu.c
> @@ -176,6 +176,10 @@ static int rtl28xxu_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msg[],
>   			ret = -EOPNOTSUPP;
>   			goto err_mutex_unlock;
>   		} else if (msg[0].addr == 0x10) {

Is there a need to compare msg[0].addr and msg[1].addr for the combined 
write+read transfer?

@Mauro: It seems a lot of i2c_xfer functions do only partial checking of 
address and direction for these combined write+read transfers. Is this a 
problem?

> +			if (msg[0].len < 1 || msg[1].len < 1) {
> +				ret = -EOPNOTSUPP;
> +				goto err_mutex_unlock;
> +			}
>   			/* method 1 - integrated demod */
>   			if (msg[0].buf[0] == 0x00) {
>   				/* return demod page from driver cache */
> @@ -189,6 +193,10 @@ static int rtl28xxu_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msg[],
>   				ret = rtl28xxu_ctrl_msg(d, &req);
>   			}
>   		} else if (msg[0].len < 2) {
> +			if (msg[0].len < 1) {
The code sequence is correct, but looks a bit strange. Maybe this is better:
	} else if (msg[0].len < 1) {
		ret = -EOPNOTSUPP;
		goto err_mutex_unlock;
	} else if (msg[0].len < 2) {

> +				ret = -EOPNOTSUPP;
> +				goto err_mutex_unlock;
> +			}
>   			/* method 2 - old I2C */
>   			req.value = (msg[0].buf[0] << 8) | (msg[0].addr << 1);
>   			req.index = CMD_I2C_RD;
> @@ -217,8 +225,16 @@ static int rtl28xxu_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msg[],
>   			ret = -EOPNOTSUPP;
>   			goto err_mutex_unlock;
>   		} else if (msg[0].addr == 0x10) {
> +			if (msg[0].len < 1) {
Is a write of a single byte fine? req.size below will be 0.

> +				ret = -EOPNOTSUPP;
> +				goto err_mutex_unlock;
> +			}
>   			/* method 1 - integrated demod */
>   			if (msg[0].buf[0] == 0x00) {
> +				if (msg[0].len < 2) {
> +					ret = -EOPNOTSUPP;
> +					goto err_mutex_unlock;
> +				}
>   				/* save demod page for later demod access */
>   				dev->page = msg[0].buf[1];
>   				ret = 0;
> @@ -231,6 +247,10 @@ static int rtl28xxu_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msg[],
>   				ret = rtl28xxu_ctrl_msg(d, &req);
>   			}
>   		} else if ((msg[0].len < 23) && (!dev->new_i2c_write)) {
> +			if (msg[0].len < 1) {
> +				ret = -EOPNOTSUPP;
> +				goto err_mutex_unlock;
> +			}
>   			/* method 2 - old I2C */
>   			req.value = (msg[0].buf[0] << 8) | (msg[0].addr << 1);
>   			req.index = CMD_I2C_WR;

