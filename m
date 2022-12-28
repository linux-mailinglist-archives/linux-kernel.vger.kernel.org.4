Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 284B86586DD
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 21:58:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231666AbiL1U6h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 15:58:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbiL1U6f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 15:58:35 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1359A167C8;
        Wed, 28 Dec 2022 12:58:35 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id vm8so33956338ejc.2;
        Wed, 28 Dec 2022 12:58:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:date:to:from
         :subject:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=+EjcY7YoO0rpM2U9BDoOIi8R/714b5mQZSttojJNkYo=;
        b=DBioYxUifXdL6edfAm4WJ17nVN/Q6xruvAGqXhFvl5K9Lgc/9MQ6WGk7Xb66ySMlgb
         iF8MPk0+RW1zfQjEwReWTkjBls9MLh19asHK9Vbi8kygyrXoeyTRDfawGVeuTLfTykeF
         Z/RuTUpqHNXpZCQnPqE/T3kBmpKrrhdCEirqF4h+OmC9a3VIfqbiJayRZwNOMtYtN+Lr
         Yey5O7pasS0GTDM3DfE5UgI53plGdjDZhvvYaJEZg+/TXk2tMn3NdP9GvsD4sDlR4bhp
         ODWCU8VGZ9xgc9Obyg8r+iAiULyk7S4AAZFOmth4mwpvtSHCSNLXpTyNyHPVkKAlXklM
         AQzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:date:to:from
         :subject:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+EjcY7YoO0rpM2U9BDoOIi8R/714b5mQZSttojJNkYo=;
        b=egwu/VQSXKcNzEoB8wpo3+H07Tnljyu1j+XYkryXfsAbcneIgfLw488nXH3Fe7S202
         pFjXjt+inndwXaox5MBRJFVmECNLJOPsjfmXGEtZk+8r32VKNw/9RZ+0tin8cssAt/ZR
         0vi1gFKSgZ6rCGCTGCbbE5cVLDJlex+rP2b90rArcaBnquRc+E8PyPKegPG+LZCi3UWD
         l+n1OgyHL84zdLBGEX8ktT09HSafjRE20MWxzBE5nh6i1WM0PtKxekOndp28lzEh5rWz
         9ZGvwVj0UoO/6GC0WJLxpWpJh8QpIHrcO1VXxK6vg+6orVXutKTud3vlCLEXn32xgI6b
         MUgQ==
X-Gm-Message-State: AFqh2kqQIELH9UsbvCgeIzobch5BQMoFI8k9sTO8bbEHAelUpaN/FyQZ
        rkuJKwuqsGkA83sDL/ZIrHs=
X-Google-Smtp-Source: AMrXdXsXzEOMDbuHar3p6QjnuZUk9Ygrar/HHfNGbLiAV4rYXlzVhza6nZQ6SaRhXqk9E/roNTMQXA==
X-Received: by 2002:a17:907:8b93:b0:7c1:1dc7:8837 with SMTP id tb19-20020a1709078b9300b007c11dc78837mr23364441ejc.66.1672261113492;
        Wed, 28 Dec 2022 12:58:33 -0800 (PST)
Received: from [192.168.0.239] (ip5f5ad5e2.dynamic.kabel-deutschland.de. [95.90.213.226])
        by smtp.gmail.com with ESMTPSA id q14-20020a17090676ce00b007ad94422cf6sm7759916ejn.198.2022.12.28.12.58.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Dec 2022 12:58:32 -0800 (PST)
Message-ID: <7f4fe87ef8a9995bc2c64bf2e5a03ef6948b8692.camel@gmail.com>
Subject: [PATCH] media: staging: media: omap4iss: Fix null dereference for
 iss
From:   Tanmay Bhushan <007047221b@gmail.com>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Date:   Wed, 28 Dec 2022 21:58:31 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu1 
MIME-Version: 1.0
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        FROM_STARTS_WITH_NUMS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From 7aa39c0d02bddf9cfa14762f115303b79bfa0ae3 Mon Sep 17 00:00:00 2001
From: Tanmay Bhushan <007047221b@gmail.com>
Date: Wed, 28 Dec 2022 21:01:16 +0100
Subject: [PATCH] media: staging: media: omap4iss: Fix null dereference
for iss

media_pad_remote_pad_first returns NULL in some cases but while using
the return value was used without NULL check which will lead to panic
in case of NULL return. iss_pipeline_is_last returns value check so
have returned 0 in case of NULL and csi2_configure is not documented
for such cases so returned EINVAL for it. Code is not tested
as it is only for NULL dereference verification.

Signed-off-by: Tanmay Bhushan <007047221b@gmail.com>
---
 drivers/staging/media/omap4iss/iss.c      | 6 +++++-
 drivers/staging/media/omap4iss/iss_csi2.c | 4 ++++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/media/omap4iss/iss.c
b/drivers/staging/media/omap4iss/iss.c
index fa2a36d829d3..3f01eeff40e7 100644
--- a/drivers/staging/media/omap4iss/iss.c
+++ b/drivers/staging/media/omap4iss/iss.c
@@ -552,7 +552,11 @@ static int iss_pipeline_is_last(struct
media_entity *me)
 	if (!pipe || pipe->stream_state =3D=3D
ISS_PIPELINE_STREAM_STOPPED)
 		return 0;
 	pad =3D media_pad_remote_pad_first(&pipe->output->pad);
-	return pad->entity =3D=3D me;
+
+	if (pad)
+		return pad->entity =3D=3D me;
+
+	return 0;
 }
=20
 static int iss_reset(struct iss_device *iss)
diff --git a/drivers/staging/media/omap4iss/iss_csi2.c
b/drivers/staging/media/omap4iss/iss_csi2.c
index 04ce0e7eb557..ab2c2ad64464 100644
--- a/drivers/staging/media/omap4iss/iss_csi2.c
+++ b/drivers/staging/media/omap4iss/iss_csi2.c
@@ -539,6 +539,10 @@ static int csi2_configure(struct iss_csi2_device
*csi2)
 		return -EBUSY;
=20
 	pad =3D media_pad_remote_pad_first(&csi2->pads[CSI2_PAD_SINK]);
+
+	if (!pad)
+		return -EINVAL;
+
 	sensor =3D media_entity_to_v4l2_subdev(pad->entity);
 	pdata =3D sensor->host_priv;
=20
--=20
2.34.1


