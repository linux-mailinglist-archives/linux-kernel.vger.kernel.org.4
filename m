Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA4B56E736C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 08:43:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231795AbjDSGnY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 02:43:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbjDSGnW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 02:43:22 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE2ED4C20
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 23:43:19 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-2f8405b3dc1so1901497f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 23:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681886598; x=1684478598;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vhxUwUWRohOPjZhWDP3j04bcw+cL6izauK/Xp7HHiAg=;
        b=hLSYx1Tvk/HwDF3uFB3Vq35thgOk+tj9rVGMn0pAqTXWTJE/Nv+KwOwUpJ3LGVOYH9
         0AjqXwYMmFLxYG4XnO6nZ2EUPmtsfcXwSkqtOOxhNnAJ0gynO8s8wOq2i+kaJFdUW4Ir
         UTwb7HtrWr2hUgKhxEnCyR5ZsdRndgR2gTciMkU/EBcYYjVLQ9OrpYzjXdp43ZBHV3pt
         JvPXalwBagnNN7fkxzBuIQTLynDxhusSIzjaQhK9gFJBZvLukLZIzLDjxaqucyMVBnWA
         76aw5Bt4QwDz0zu/yt+myvVH6MoMPGWhH8vP4uVfJvvrj21DMOLTJ1ofWcyUcapHWG3M
         KRSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681886598; x=1684478598;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vhxUwUWRohOPjZhWDP3j04bcw+cL6izauK/Xp7HHiAg=;
        b=dks6tjCQW+l1MRi0yBjpnlb1OytxRhw7PKzU5YzNWhhF5VU4GRecOOnKoqEYZTr8E2
         uKKBYYjEfRquD5VtuE4hYoeiD9HS5za7/33nX2ecVJfYjxaJe1Vhd00ngCcnP+zpGcSg
         39sPLWUmsPAcL8Z04Ik7CiLOmxm0u75LiWFLSFu2kXFt3LBNz7t8btso3bbXEuqIZvrL
         18Qft+GMMLeKtbLP0799+XcmzGSvPvPk5nUKEYCsvSEpaPyDzxWbLhmPTWFFMjthPsh6
         B2RBqkhnDja1+ij74u04nSWsFcWkB5Dt2S1BuPv0dsQ2J3QyF4xCs9E9KcTAWxaohxaH
         C52Q==
X-Gm-Message-State: AAQBX9cv69uDp3TWi/TZvTkIh23lpAMN42bFC3JSztUCbjzSVDfLgMLk
        eUGHGqWTdN5jmCad6U0mDXz+ow==
X-Google-Smtp-Source: AKy350Ya9wpX2nuUQCn9BwezmxC7PUbDZwPwMclKRujV5Cj3J+JleNT1eSMQvvxsDIbSxztMmw5MSg==
X-Received: by 2002:a5d:50c5:0:b0:2f4:f7b2:9dd5 with SMTP id f5-20020a5d50c5000000b002f4f7b29dd5mr3158465wrt.39.1681886598067;
        Tue, 18 Apr 2023 23:43:18 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id r5-20020adfdc85000000b002f985eee030sm8673287wrj.84.2023.04.18.23.43.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 23:43:17 -0700 (PDT)
From:   Dan Carpenter <dan.carpenter@linaro.org>
X-Google-Original-From: Dan Carpenter <error27@gmail.com>
Date:   Thu, 13 Apr 2023 13:06:50 +0300
To:     Baisong Zhong <zhongbaisong@huawei.com>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        mchehab@kernel.org, Adams.xu@azwave.com.cn,
        Harshit Mogalapalli <harshit.m.mogalapalli@gmail.com>
Subject: Re: [PATCH -next] media: dvb-usb: az6027: fix null-ptr-deref in
 az6027_i2c_xfer()
Message-ID: <dfcb3291-9090-4e24-b23e-42f31f63a123@kili.mountain>
References: <20221120065918.2160782-1-zhongbaisong@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="3Z6ry1NJPUttm+1w"
Content-Disposition: inline
In-Reply-To: <20221120065918.2160782-1-zhongbaisong@huawei.com>
X-Spam-Status: No, score=1.3 required=5.0 tests=BAYES_00,DATE_IN_PAST_96_XX,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3Z6ry1NJPUttm+1w
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Nov 20, 2022 at 02:59:18PM +0800, Baisong Zhong wrote:
> Wei Chen reports a kernel bug as blew:
> 
> general protection fault, probably for non-canonical address
> KASAN: null-ptr-deref in range [0x0000000000000010-0x0000000000000017]
> ...
> Call Trace:
> <TASK>
> __i2c_transfer+0x77e/0x1930 drivers/i2c/i2c-core-base.c:2109
> i2c_transfer+0x1d5/0x3d0 drivers/i2c/i2c-core-base.c:2170
> i2cdev_ioctl_rdwr+0x393/0x660 drivers/i2c/i2c-dev.c:297
> i2cdev_ioctl+0x75d/0x9f0 drivers/i2c/i2c-dev.c:458
> vfs_ioctl fs/ioctl.c:51 [inline]
> __do_sys_ioctl fs/ioctl.c:870 [inline]
> __se_sys_ioctl+0xfb/0x170 fs/ioctl.c:856
> do_syscall_x64 arch/x86/entry/common.c:50 [inline]
> do_syscall_64+0x3d/0x90 arch/x86/entry/common.c:80
> entry_SYSCALL_64_after_hwframe+0x63/0xcd
> RIP: 0033:0x7fd834a8bded
> 
> In az6027_i2c_xfer(), if msg[i].addr is 0x99,
> a null-ptr-deref will caused when accessing msg[i].buf.
> For msg[i].len is 0 and msg[i].buf is null.
> 
> Fix this by checking msg[i].len in az6027_i2c_xfer().
> 
> Fixes: 76f9a820c867 ("V4L/DVB: AZ6027: Initial import of the driver")
> Link: https://lore.kernel.org/lkml/CAO4mrfcPHB5aQJO=mpqV+p8mPLNg-Fok0gw8gZ=zemAfMGTzMg@mail.gmail.com/
> Reported-by: Wei Chen <harperchen1110@gmail.com>
> Signed-off-by: Baisong Zhong <zhongbaisong@huawei.com>
> ---
>  drivers/media/usb/dvb-usb/az6027.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/media/usb/dvb-usb/az6027.c b/drivers/media/usb/dvb-usb/az6027.c
> index cf15988dfb51..7d78ee09be5e 100644
> --- a/drivers/media/usb/dvb-usb/az6027.c
> +++ b/drivers/media/usb/dvb-usb/az6027.c
> @@ -975,6 +975,10 @@ static int az6027_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msg[], int n
>  		if (msg[i].addr == 0x99) {
>  			req = 0xBE;
>  			index = 0;
> +			if (msg[i].len < 1) {
> +				i = -EOPNOTSUPP;
> +				break;
> +			}
>  			value = msg[i].buf[0] & 0x00ff;

This is CVE-2023-28328 now.  Why aren't the other msg[i].buf[0] accesses
checked?  Is there a rule we could create so this could be detected by
Smatch?

I created a first draft Smatch warning that says whenever we access
msg[i].buf[] then we have to verify that msg[i].len was checked.
Attached.

  CHECK   drivers/media/usb/dvb-usb/az6027.c
drivers/media/usb/dvb-usb/az6027.c:991 az6027_i2c_xfer() warn: i2c_msg ->buf not checked 'msg[i]->len'
drivers/media/usb/dvb-usb/az6027.c:991 az6027_i2c_xfer() warn: i2c_msg ->buf not checked 'msg[i]->len'
drivers/media/usb/dvb-usb/az6027.c:1004 az6027_i2c_xfer() warn: i2c_msg ->buf not checked 'msg[i]->len'
drivers/media/usb/dvb-usb/az6027.c:1004 az6027_i2c_xfer() warn: i2c_msg ->buf not checked 'msg[i]->len'
drivers/media/usb/dvb-usb/az6027.c:1009 az6027_i2c_xfer() warn: i2c_msg ->buf not checked 'msg[i]->len'
drivers/media/usb/dvb-usb/az6027.c:1029 az6027_i2c_xfer() warn: i2c_msg ->buf not checked 'msg[i]->len'

It's a bug in Smatch that it's printing "msg[i]->len" instead of
"msg[i].len".  :(

regards,
dan carpenter


drivers/media/usb/dvb-usb/az6027.c
   973          for (i = 0; i < num; i++) {
   974  
   975                  if (msg[i].addr == 0x99) {
   976                          req = 0xBE;
   977                          index = 0;
   978                          if (msg[i].len < 1) {
                                    ^^^^^^^^^^^^^^
The new check is here.

   979                                  i = -EOPNOTSUPP;
   980                                  break;
   981                          }
   982                          value = msg[i].buf[0] & 0x00ff;
   983                          length = 1;
   984                          az6027_usb_out_op(d, req, value, index, data, length);
   985                  }
   986  
   987                  if (msg[i].addr == 0xd0) {
   988                          /* write/read request */
   989                          if (i + 1 < num && (msg[i + 1].flags & I2C_M_RD)) {
   990                                  req = 0xB9;
   991                                  index = (((msg[i].buf[0] << 8) & 0xff00) | (msg[i].buf[1] & 0x00ff));
                                                   ^^^^^^^^^^^^^                    ^^^^^^^^^^^^^
Two unchecked here.

   992                                  value = msg[i].addr + (msg[i].len << 8);
   993                                  length = msg[i + 1].len + 6;
   994                                  az6027_usb_in_op(d, req, value, index, data, length);
   995                                  len = msg[i + 1].len;
   996                                  for (j = 0; j < len; j++)
   997                                          msg[i + 1].buf[j] = data[j + 5];
   998  
   999                                  i++;
  1000                          } else {
  1001  
  1002                                  /* demod 16bit addr */
  1003                                  req = 0xBD;
  1004                                  index = (((msg[i].buf[0] << 8) & 0xff00) | (msg[i].buf[1] & 0x00ff));
                                                   ^^^^^^^^^^^^^                    ^^^^^^^^^^^^^
And here.

  1005                                  value = msg[i].addr + (2 << 8);
  1006                                  length = msg[i].len - 2;
  1007                                  len = msg[i].len - 2;
  1008                                  for (j = 0; j < len; j++)
  1009                                          data[j] = msg[i].buf[j + 2];

This is a false positive because Smatch is not smart enough to track
that "len = msg[i].len - 2;" and "j < len;" means that "j + 2" is less
than < msg[i].len.

  1010                                  az6027_usb_out_op(d, req, value, index, data, length);
  1011                          }
  1012                  }
  1013  
  1014                  if (msg[i].addr == 0xc0) {
  1015                          if (msg[i].flags & I2C_M_RD) {
  1016  
  1017                                  req = 0xB9;
  1018                                  index = 0x0;
  1019                                  value = msg[i].addr;
  1020                                  length = msg[i].len + 6;
  1021                                  az6027_usb_in_op(d, req, value, index, data, length);
  1022                                  len = msg[i].len;
  1023                                  for (j = 0; j < len; j++)
  1024                                          msg[i].buf[j] = data[j + 5];
  1025  
  1026                          } else {
  1027  
  1028                                  req = 0xBD;
  1029                                  index = msg[i].buf[0] & 0x00FF;
                                                ^^^^^^^^^^^^^
And here.

  1030                                  value = msg[i].addr + (1 << 8);
  1031                                  length = msg[i].len - 1;
  1032                                  len = msg[i].len - 1;
  1033  
  1034                                  for (j = 0; j < len; j++)
  1035                                          data[j] = msg[i].buf[j + 1];

Apparently Smatch can figure this one out...  Weird.  I wonder if past
me made + 1 a special case...

  1036  
  1037                                  az6027_usb_out_op(d, req, value, index, data, length);
  1038                          }
  1039                  }
  1040          }
  1041          mutex_unlock(&d->i2c_mutex);
  1042          kfree(data);
  1043  
  1044          return i;
  1045  }

regards,
dan carpenter

--3Z6ry1NJPUttm+1w
Content-Type: text/x-csrc; charset=us-ascii
Content-Disposition: attachment; filename="check_i2c_msg_buf.c"

/*
 * Copyright (C) 2023 Dan Carpenter.
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License
 * as published by the Free Software Foundation; either version 2
 * of the License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, see http://www.gnu.org/copyleft/gpl.txt
 */

#include "smatch.h"
#include "smatch_slist.h"
#include "smatch_extra.h"

static int my_id;

static struct expression *get_len_expr(struct expression *expr)
{
	struct expression *deref;

	if (expr->type != EXPR_DEREF)
		return NULL;
	deref = strip_expr(expr->deref);

	if (local_debug)
		sm_msg("%s: expr='%s' op='%c'", __func__, expr_to_str(expr), expr->op);

	return gen_expression_from_key(deref, (expr->op == '.') ? "$.len" : "$->len");
}

static void array_check(struct expression *expr)
{
	struct expression *array_expr, *offset, *len;
	char *member, *name;
	int comparison;

	expr = strip_expr(expr);
	array_expr = get_array_base(expr);
	offset = get_array_offset(expr);
	if (!array_expr || !offset)
		return;

	member = get_member_name(array_expr);
	if (!member || strcmp(member, "(struct i2c_msg)->buf") != 0)
		goto free;
	len = get_len_expr(array_expr);
	if (!len)
		goto free;

	comparison = get_comparison(offset, len);
	if (comparison == '<')
		goto free;

	name = expr_to_str(len);
	sm_warning("i2c_msg ->buf not checked '%s'", name);
	free_string(name);

free:
	free_string(member);
}

void check_i2c_msg_buf(int id)
{
	my_id = id;

	if (option_project != PROJ_KERNEL)
		return;

	add_hook(&array_check, OP_HOOK);
}


--3Z6ry1NJPUttm+1w--
