Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09151705F13
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 07:06:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232056AbjEQFGI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 01:06:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbjEQFGG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 01:06:06 -0400
Received: from smtp.gentoo.org (dev.gentoo.org [IPv6:2001:470:ea4a:1:5054:ff:fec7:86e4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0673B213B;
        Tue, 16 May 2023 22:06:02 -0700 (PDT)
Message-ID: <3f451539-3e3b-a7ca-b8ee-f89f4c723770@gentoo.org>
Date:   Wed, 17 May 2023 07:06:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
From:   zzam@gentoo.org
Subject: Re: [PATCH 04/24] media: dvb-usb: az6027: fix three null-ptr-deref in
 az6027_i2c_xfer()
Content-Language: en-GB
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Wei Chen <harperchen1110@gmail.com>, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org
References: <53558de2b5c4f4ee6bfcfbe34e27071c2d0073d5.1684000646.git.mchehab@kernel.org>
 <db96cbf981898a8fce928b93f8ffc93288ea46f0.1684000646.git.mchehab@kernel.org>
In-Reply-To: <db96cbf981898a8fce928b93f8ffc93288ea46f0.1684000646.git.mchehab@kernel.org>
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
> In az6027_i2c_xfer, msg is controlled by user. When msg[i].buf is null,
> commit 0ed554fd769a ("media: dvb-usb: az6027: fix null-ptr-deref in az6027_i2c_xfer()")
> fix the null-ptr-deref bug when msg[i].addr is 0x99. However, null-ptr-deref
> also happens when msg[i].addr is 0xd0 and 0xc0. We add check on msg[i].len to
> prevent null-ptr-deref.
> 
Some added checks still allow too short buffers.
> Link: https://lore.kernel.org/linux-media/20230310165604.3093483-1-harperchen1110@gmail.com
> Signed-off-by: Wei Chen <harperchen1110@gmail.com>
> Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
> ---
>   drivers/media/usb/dvb-usb/az6027.c | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/media/usb/dvb-usb/az6027.c b/drivers/media/usb/dvb-usb/az6027.c
> index 7d78ee09be5e..a31c6f82f4e9 100644
> --- a/drivers/media/usb/dvb-usb/az6027.c
> +++ b/drivers/media/usb/dvb-usb/az6027.c
> @@ -988,6 +988,10 @@ static int az6027_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msg[], int n
>   			/* write/read request */
>   			if (i + 1 < num && (msg[i + 1].flags & I2C_M_RD)) {
>   				req = 0xB9;
> +				if (msg[i].len < 1) {
> +					i = -EOPNOTSUPP;
> +					break;
> +				}

The following line accesses the elements 0 and 1. Shouldn't this code 
check for msg[i].len < 2.
Or even msg[i].len != 2? Too long input seems just to get ignored.

>   				index = (((msg[i].buf[0] << 8) & 0xff00) | (msg[i].buf[1] & 0x00ff));
>   				value = msg[i].addr + (msg[i].len << 8);
>   				length = msg[i + 1].len + 6;
> @@ -1001,6 +1005,10 @@ static int az6027_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msg[], int n
>   
>   				/* demod 16bit addr */
>   				req = 0xBD;
> +				if (msg[i].len < 1) {
> +					i = -EOPNOTSUPP;
> +					break;
> +				}
Same here, at least two elements are used.

>   				index = (((msg[i].buf[0] << 8) & 0xff00) | (msg[i].buf[1] & 0x00ff));
>   				value = msg[i].addr + (2 << 8);
>   				length = msg[i].len - 2;
> @@ -1026,6 +1034,10 @@ static int az6027_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msg[], int n
>   			} else {
>   
>   				req = 0xBD;
> +				if (msg[i].len < 1) {
> +					i = -EOPNOTSUPP;
> +					break;
> +				}
>   				index = msg[i].buf[0] & 0x00FF;
>   				value = msg[i].addr + (1 << 8);
>   				length = msg[i].len - 1;

