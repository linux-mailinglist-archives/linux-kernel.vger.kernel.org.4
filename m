Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2421B5FF3AF
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 20:36:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231182AbiJNSf4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 14:35:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231130AbiJNSfb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 14:35:31 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 857C4A7A99;
        Fri, 14 Oct 2022 11:35:23 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id r13so8846637wrj.11;
        Fri, 14 Oct 2022 11:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FPNinP5NcVb9ViQFD23z9JvBzsucMh06jMRDsBjL9jk=;
        b=K3ZIGnYTG2IW438XZKj0WhZ+OGMxdF8aRcvKK9NtgqDu/HP4htzpzZP5o4f6MqSCNn
         hoDyxzJP5TSGezWugWfiKaUdYwng+RoV0hCpMm+dava7Kf8Y7i0X09qMAxg58qrqFS56
         49X+On/sn8fp+tQfes6gRmGRmp6yJskbhBVD6gjINZ3nhKtrcNSe0b434f/2idDVba5S
         1ASPzAUmhBiGb6aXngjNu3ZSL78xhXOqlqgLmad4HP7ToGqNIUolv8EJgMdkr2CVv/4T
         1M4k2F5fpbP+82IboWoD+wVeYUnHJK19a3gP/dWYxvpiwZ7kxEjqe/N8cQM7oFz3e31Q
         PnMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FPNinP5NcVb9ViQFD23z9JvBzsucMh06jMRDsBjL9jk=;
        b=tbNvugd/stySTJmTLWIHLVs8t61V/u57XlkwRLBS0IKjTwpVH/u1dQ7q340BPOt9j2
         f1LQ4WlvbPHv2RTIsDVu0TX+/qtXWaIHOt441EXXopeaLlkVsDgRPO1PTbL/iMhwHn5v
         tR+cuc3bMa99UdkFCE20KeTJ15HmUpaLvEGseiuNCGhqJ7f44gQYLUgiKUWYO1HNucnw
         TxZzfV2WLrVG4FjmCKRcxhF62OUTH1cdaot3YJDGXoCM22J4n8X4y8lO3RBUyagw2TXj
         skZY6PeOr0P5H+xSuJr4pRhWxGzQxZ9h+WgCZUznh3iNjmim5iZIPGJVXkls4ObboeQb
         g1AA==
X-Gm-Message-State: ACrzQf0UFDVOWALkJKDvyXeoX1117ojsYK/tcOeZAt7SiyCCdNuxy/iP
        GrASPFoJRC/UUv4mcn0DEa8=
X-Google-Smtp-Source: AMsMyM7Hlq/qoUuIN7LZWt5FzuxUS5Vip9VOqXeP9bjmE6fswYv2HHk/IN4q6q5SaiDJTqoeH9XUgg==
X-Received: by 2002:a05:6000:1565:b0:22f:1407:9bfd with SMTP id 5-20020a056000156500b0022f14079bfdmr4240073wrz.620.1665772521673;
        Fri, 14 Oct 2022 11:35:21 -0700 (PDT)
Received: from prasmi.home ([2a00:23c8:2501:c701:fc4d:6548:d8bd:5bd])
        by smtp.gmail.com with ESMTPSA id h10-20020a5d504a000000b0022a403954c3sm2485410wrt.42.2022.10.14.11.35.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Oct 2022 11:35:21 -0700 (PDT)
From:   Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>
Cc:     Shawn Tu <shawnx.tu@intel.com>, Jacopo Mondi <jacopo@jmondi.org>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v2 4/5] media: i2c: ov5645: Return zero for s_stream(0)
Date:   Fri, 14 Oct 2022 19:34:58 +0100
Message-Id: <20221014183459.181567-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221014183459.181567-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20221014183459.181567-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Always return zero while stopping the stream as the caller will ignore the
return value.

This patch drops checking the return value of ov5645_write_reg() and
continues further in the code path while stopping stream. The user anyway
gets an error message in case ov5645_write_reg() fails.

Suggested-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
v1->v2
* New patch
---
 drivers/media/i2c/ov5645.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/media/i2c/ov5645.c b/drivers/media/i2c/ov5645.c
index a0b9d0c43b78..b3825294aaf1 100644
--- a/drivers/media/i2c/ov5645.c
+++ b/drivers/media/i2c/ov5645.c
@@ -995,14 +995,11 @@ static int ov5645_s_stream(struct v4l2_subdev *subdev, int enable)
 		if (ret < 0)
 			goto err_rpm_put;
 	} else {
-		ret = ov5645_write_reg(ov5645, OV5645_IO_MIPI_CTRL00, 0x40);
-		if (ret < 0)
-			return ret;
+		ov5645_write_reg(ov5645, OV5645_IO_MIPI_CTRL00, 0x40);
+
+		ov5645_write_reg(ov5645, OV5645_SYSTEM_CTRL0,
+				 OV5645_SYSTEM_CTRL0_STOP);
 
-		ret = ov5645_write_reg(ov5645, OV5645_SYSTEM_CTRL0,
-				       OV5645_SYSTEM_CTRL0_STOP);
-		if (ret < 0)
-			return ret;
 		pm_runtime_put(ov5645->dev);
 	}
 
-- 
2.25.1

