Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4BEC7092D3
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 11:17:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231358AbjESJRR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 05:17:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230102AbjESJRP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 05:17:15 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E415B18F;
        Fri, 19 May 2023 02:17:14 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-64ab2a37812so438783b3a.1;
        Fri, 19 May 2023 02:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684487834; x=1687079834;
        h=content-transfer-encoding:mime-version:user-agent:reply-to
         :references:in-reply-to:message-id:date:cc:subject:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pML/CJ5AzO8Y1Q5MVMGAt5BklSevbhhmDurHzLv15/w=;
        b=ZnzRDcW+7ojFFAswCyMiTb0N5L4YQNNImaKTkczdq0Wmhm98cK8tKbIzG/4qNo0JA2
         eoJpEcQyPJh4VjaLsTTX+F81vK+OmS1/e4kiJT2ydMjERvbwA1u9iYOwg2Q+C73Dx3OE
         8emO2qdiBlBytAHrhivalCuXK9VEyAQRPuWYZzQ1YEVfVKR8QQMuWw3dAUrBFBipt+BV
         YLqLZBkCI5C1AWxPzgpFoxg3GBAj09irkEXnDiP55STttJX9RRoO6vOqVu1QxqFu58yT
         6NjIosOmKBIO5rChaQ1VVbks5SDDkMImSU6VPBAXoKBMI/mYDmjJ2f0S5UPlNnndFDBD
         2Gyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684487834; x=1687079834;
        h=content-transfer-encoding:mime-version:user-agent:reply-to
         :references:in-reply-to:message-id:date:cc:subject:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pML/CJ5AzO8Y1Q5MVMGAt5BklSevbhhmDurHzLv15/w=;
        b=KSbWR0ZfiwIqAYWc9RbYHZOxrxU1LNJdrGC/NSBMklXBUrwk6xIgJykCKVYWrmjRqC
         yaNGeM6d1478Gzki3hXoB5F/biNHBzVjZO5yeH26KVjaqG+aAzSuD5zqroE4kroAs2W8
         Qt7/HSubFdHiU0v1VNSHf16x3kFZLy03mthEjGfoyhkuiDCi+iYZxvWyE0BUB63dYvpl
         nyTkm153dZMf1nA7nhFnIDroXW4Kw7SA5y3WZ41Dgx5mhuhEYpPCsZ6Sfn/W26k+XqCO
         JiYaSNQU3QLFfdUJLplZ9zHauyeEFcjmK6ljEL/KkjTZe9vA6PFcd2/Xpu/K0N8Os79o
         im6w==
X-Gm-Message-State: AC+VfDy9KW75eWPLvYz5rASZs+h9eUzlZwH4D/i4B8c3OKozzcbE1Je8
        7dc6CQT0DAOxvgeEfFvJt0Q=
X-Google-Smtp-Source: ACHHUZ7WvZXvQtaH6Xlv2rBuSqwBTvgbH045gBp6/5i5F2P2POLbDSPLnckiMb1Q/VE48QHhSBet1w==
X-Received: by 2002:a17:902:e851:b0:1a9:57b4:9d5a with SMTP id t17-20020a170902e85100b001a957b49d5amr1863542plg.31.1684487834220;
        Fri, 19 May 2023 02:17:14 -0700 (PDT)
Received: from [10.79.86.7] (wf122-007.ust.hk. [175.159.122.7])
        by smtp.gmail.com with ESMTPSA id p16-20020a1709027ed000b001a96a6877fdsm3011491plb.3.2023.05.19.02.17.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 May 2023 02:17:13 -0700 (PDT)
From:   "Wei Chen" <harperchen1110@gmail.com>
To:     zzam@gentoo.org, "Mauro Carvalho Chehab" <mchehab@kernel.org>
Subject: Re: [PATCH 05/24] media: dvb-usb-v2: ec168: fix null-ptr-deref in
 ec168_i2c_xfer()
Cc:     "Antti Palosaari" <crope@iki.fi>, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org
Date:   Fri, 19 May 2023 09:17:10 +0000
Message-Id: <em460c2fef-d14b-4cd9-97dd-ef7b52090a48@bb0cba59.com>
In-Reply-To: <9f0a43e5-9f9b-b77b-d882-627251e585cc@gentoo.org>
References: <53558de2b5c4f4ee6bfcfbe34e27071c2d0073d5.1684000646.git.mchehab@kernel.org>
 <7ced9f219d36cb0d3319b556dc0b0f4f81247fa6.1684000646.git.mchehab@kernel.org>
 <9f0a43e5-9f9b-b77b-d882-627251e585cc@gentoo.org>
Reply-To: "Wei Chen" <harperchen1110@gmail.com>
User-Agent: eM_Client/9.2.1818.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Linux Developers,

Thank you for the review for my patch in driver az6027 and ec168.

Yes, I agree with you. Sorry for my mistake. Since these two patches has al=
ready been accepted and merged in git tree media, should I send a new patch =
to revise this problem? Or how could I revise an accepted patch?

Thanks,
Wei


------ Original Message ------
From zzam@gentoo.org
To "Mauro Carvalho Chehab" <mchehab@kernel.org>
Cc "Wei Chen" <harperchen1110@gmail.com>; "Antti Palosaari" <crope@iki.fi>; =
linux-kernel@vger.kernel.org; linux-media@vger.kernel.org
Date 2023/5/17 13:10:34
Subject Re: [PATCH 05/24] media: dvb-usb-v2: ec168: fix null-ptr-deref in e=
c168_i2c_xfer()

>Am 13.05.23 um 19:57 schrieb Mauro Carvalho Chehab:
>>From: Wei Chen <harperchen1110@gmail.com>
>>
>>In ec168_i2c_xfer, msg is controlled by user. When msg[i].buf is null
>>and msg[i].len is zero, former checks on msg[i].buf would be passed.
>>If accessing msg[i].buf[0] without sanity check, null pointer deref
>>would happen. We add check on msg[i].len to prevent crash.
>>
>>Similar commit:
>>commit 0ed554fd769a ("media: dvb-usb: az6027: fix null-ptr-deref in az602=
7_i2c_xfer()")
>>
>Review comment below.
>
>>Link: https://lore.kernel.org/linux-media/20230313085853.3252349-1-harper=
chen1110@gmail.com
>>Signed-off-by: Wei Chen <harperchen1110@gmail.com>
>>Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
>>---
>>   drivers/media/usb/dvb-usb-v2/ec168.c | 12 ++++++++++++
>>   1 file changed, 12 insertions(+)
>>
>>diff --git a/drivers/media/usb/dvb-usb-v2/ec168.c b/drivers/media/usb/dvb=
-usb-v2/ec168.c
>>index 7ed0ab9e429b..0e4773fc025c 100644
>>--- a/drivers/media/usb/dvb-usb-v2/ec168.c
>>+++ b/drivers/media/usb/dvb-usb-v2/ec168.c
>>@@ -115,6 +115,10 @@ static int ec168_i2c_xfer(struct i2c_adapter *adap,=
 struct i2c_msg msg[],
>>   	while (i < num) {
>>   		if (num > i + 1 && (msg[i+1].flags & I2C_M_RD)) {
>>   			if (msg[i].addr =3D=3D ec168_ec100_config.demod_address) {
>>+				if (msg[i].len < 1) {
>>+					i =3D -EOPNOTSUPP;
>>+					break;
>>+				}
>>   				req.cmd =3D READ_DEMOD;
>>   				req.value =3D 0;
>>   				req.index =3D 0xff00 + msg[i].buf[0]; /* reg */
>>@@ -131,6 +135,10 @@ static int ec168_i2c_xfer(struct i2c_adapter *adap,=
 struct i2c_msg msg[],
>>   			}
>>   		} else {
>>   			if (msg[i].addr =3D=3D ec168_ec100_config.demod_address) {
>>+				if (msg[i].len < 1) {
>>+					i =3D -EOPNOTSUPP;
>>+					break;
>>+				}
>The check condition should be msg[i].len < 2 or !=3D 2. The following line=
s access msg[i].buf elements 0 and 1.
>>   				req.cmd =3D WRITE_DEMOD;
>>   				req.value =3D msg[i].buf[1]; /* val */
>>   				req.index =3D 0xff00 + msg[i].buf[0]; /* reg */
>>@@ -139,6 +147,10 @@ static int ec168_i2c_xfer(struct i2c_adapter *adap,=
 struct i2c_msg msg[],
>>   				ret =3D ec168_ctrl_msg(d, &req);
>>   				i +=3D 1;
>>   			} else {
>>+				if (msg[i].len < 1) {
>>+					i =3D -EOPNOTSUPP;
>>+					break;
>>+				}
>>   				req.cmd =3D WRITE_I2C;
>>   				req.value =3D msg[i].buf[0]; /* val */
>>   				req.index =3D 0x0100 + msg[i].addr; /* I2C addr */
>
