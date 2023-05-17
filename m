Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 747CF705F1D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 07:10:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232127AbjEQFKj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 01:10:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231691AbjEQFKh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 01:10:37 -0400
Received: from smtp.gentoo.org (smtp.gentoo.org [IPv6:2001:470:ea4a:1:5054:ff:fec7:86e4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A2D22136;
        Tue, 16 May 2023 22:10:27 -0700 (PDT)
Message-ID: <9f0a43e5-9f9b-b77b-d882-627251e585cc@gentoo.org>
Date:   Wed, 17 May 2023 07:10:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
From:   zzam@gentoo.org
Subject: Re: [PATCH 05/24] media: dvb-usb-v2: ec168: fix null-ptr-deref in
 ec168_i2c_xfer()
Content-Language: en-GB
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Wei Chen <harperchen1110@gmail.com>,
        Antti Palosaari <crope@iki.fi>, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org
References: <53558de2b5c4f4ee6bfcfbe34e27071c2d0073d5.1684000646.git.mchehab@kernel.org>
 <7ced9f219d36cb0d3319b556dc0b0f4f81247fa6.1684000646.git.mchehab@kernel.org>
In-Reply-To: <7ced9f219d36cb0d3319b556dc0b0f4f81247fa6.1684000646.git.mchehab@kernel.org>
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
> From: Wei Chen <harperchen1110@gmail.com>
> 
> In ec168_i2c_xfer, msg is controlled by user. When msg[i].buf is null
> and msg[i].len is zero, former checks on msg[i].buf would be passed.
> If accessing msg[i].buf[0] without sanity check, null pointer deref
> would happen. We add check on msg[i].len to prevent crash.
> 
> Similar commit:
> commit 0ed554fd769a ("media: dvb-usb: az6027: fix null-ptr-deref in az6027_i2c_xfer()")
> 
Review comment below.

> Link: https://lore.kernel.org/linux-media/20230313085853.3252349-1-harperchen1110@gmail.com
> Signed-off-by: Wei Chen <harperchen1110@gmail.com>
> Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
> ---
>   drivers/media/usb/dvb-usb-v2/ec168.c | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/media/usb/dvb-usb-v2/ec168.c b/drivers/media/usb/dvb-usb-v2/ec168.c
> index 7ed0ab9e429b..0e4773fc025c 100644
> --- a/drivers/media/usb/dvb-usb-v2/ec168.c
> +++ b/drivers/media/usb/dvb-usb-v2/ec168.c
> @@ -115,6 +115,10 @@ static int ec168_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msg[],
>   	while (i < num) {
>   		if (num > i + 1 && (msg[i+1].flags & I2C_M_RD)) {
>   			if (msg[i].addr == ec168_ec100_config.demod_address) {
> +				if (msg[i].len < 1) {
> +					i = -EOPNOTSUPP;
> +					break;
> +				}
>   				req.cmd = READ_DEMOD;
>   				req.value = 0;
>   				req.index = 0xff00 + msg[i].buf[0]; /* reg */
> @@ -131,6 +135,10 @@ static int ec168_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msg[],
>   			}
>   		} else {
>   			if (msg[i].addr == ec168_ec100_config.demod_address) {
> +				if (msg[i].len < 1) {
> +					i = -EOPNOTSUPP;
> +					break;
> +				}
The check condition should be msg[i].len < 2 or != 2. The following 
lines access msg[i].buf elements 0 and 1.
>   				req.cmd = WRITE_DEMOD;
>   				req.value = msg[i].buf[1]; /* val */
>   				req.index = 0xff00 + msg[i].buf[0]; /* reg */
> @@ -139,6 +147,10 @@ static int ec168_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msg[],
>   				ret = ec168_ctrl_msg(d, &req);
>   				i += 1;
>   			} else {
> +				if (msg[i].len < 1) {
> +					i = -EOPNOTSUPP;
> +					break;
> +				}
>   				req.cmd = WRITE_I2C;
>   				req.value = msg[i].buf[0]; /* val */
>   				req.index = 0x0100 + msg[i].addr; /* I2C addr */

