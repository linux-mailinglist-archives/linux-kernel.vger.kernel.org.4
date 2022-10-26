Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EE9160E19D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 15:08:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233514AbiJZNIF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 09:08:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233962AbiJZNH6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 09:07:58 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED10BFB735;
        Wed, 26 Oct 2022 06:07:28 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id az22-20020a05600c601600b003c6b72797fdso1506926wmb.5;
        Wed, 26 Oct 2022 06:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L0jiMTSBmquugDzo1rVzLGgWnpe8YQDdbS4JQdF2oe0=;
        b=MAVaFUOx/nc/Tlqs7/GJJy2togIYrAqyxRla3MZEdmldp/7TOH4Md8XmrKIeB/407T
         9CWwhffHjgDpoUKCpncsUNQrdagWzmOe66eZ0cyF7snK/oWaSZiVjF5lJe9syxJUPrUz
         974mpN3MP9cVl1wZbtP4LgrW1s+S42bj39pf9dcGd7sGdbg5Rzt4+D64OyspzVMNGJ5w
         ZSHQ3EHZrdeenCXSWz+g3VLb4y68jzy+HWOHsPs6PkCejoG2uEBXVVrLdTKev8ColhpT
         KBmMh1+F/EWcipKHI5UauJUQecTdeaBNP2z+a/aoTmWdtFqH8gxsqDh7ffHUQQlXtUv1
         Ue7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L0jiMTSBmquugDzo1rVzLGgWnpe8YQDdbS4JQdF2oe0=;
        b=GfoGfzAzpBIuAo5NpYbxzSxysit41sWPELslvtGPgt4QZaWRYgSAfx6nDGYs4vKmmO
         R1jG5OAZ+kdvbV3Fmt7xkAfJduP4TVmMi3/s+SmSDI8ePJtus5qf42U2fpsTPpnogPTU
         d29pobY8jq9jlMPT6nin2XebRYUkk/5cKw6iVFdwvy+cnENnai16q4K9QzAfTnEX7V8Y
         mV1U3gx4kxB6R2OFTAACCI0IF7Fi17HfwLpP7ca8XfHSXMaa0VH00ZdnX7ajUFcj26Au
         hMZSnjSjkj5TJaf2O6PnNSFBUncxOWMvPqy/oYIGm2X59zU9qlMapjikjHAoSmyAYI1U
         eacA==
X-Gm-Message-State: ACrzQf1pNZ42PUn14YCNByof2YPCwJ+AWRYmGyHd1DILVcsJZ2cn/IgT
        0xd2OyN4yMYZMYISW8GWyyQ=
X-Google-Smtp-Source: AMsMyM4Er4WKAbIRWgF2gLUapvRVsqBjj5aTQoG1761EBBrIC+UZB72u0L0sSE79mM2YekoYDezymg==
X-Received: by 2002:a05:600c:16c7:b0:3cf:4dbf:f360 with SMTP id l7-20020a05600c16c700b003cf4dbff360mr1218450wmn.74.1666789647537;
        Wed, 26 Oct 2022 06:07:27 -0700 (PDT)
Received: from prasmi.home ([2a00:23c8:2501:c701:cc:c67c:46e:319e])
        by smtp.gmail.com with ESMTPSA id l3-20020adfa383000000b002366eb01e07sm5245433wrb.114.2022.10.26.06.07.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 06:07:26 -0700 (PDT)
From:   Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Hans Verkuil <hverkuil@xs4all.nl>
Cc:     Shawn Tu <shawnx.tu@intel.com>, Jacopo Mondi <jacopo@jmondi.org>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v3 9/9] media: i2c: ov5645: Call ov5645_entity_init_cfg() before registering the subdev
Date:   Wed, 26 Oct 2022 14:06:58 +0100
Message-Id: <20221026130658.45601-10-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221026130658.45601-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20221026130658.45601-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
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

Make sure we call ov5645_entity_init_cfg() before registering the subdev
to make sure default formats are set up.

Suggested-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
v2->v3
* Included RB tag from Laurent.

v1->v2
* New patch
---
 drivers/media/i2c/ov5645.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/i2c/ov5645.c b/drivers/media/i2c/ov5645.c
index 5702a55607fc..73cf6716f3ed 100644
--- a/drivers/media/i2c/ov5645.c
+++ b/drivers/media/i2c/ov5645.c
@@ -1223,6 +1223,8 @@ static int ov5645_probe(struct i2c_client *client)
 		goto err_pm_runtime;
 	}
 
+	ov5645_entity_init_cfg(&ov5645->sd, NULL);
+
 	ret = v4l2_async_register_subdev(&ov5645->sd);
 	if (ret < 0) {
 		dev_err(dev, "could not register v4l2 device\n");
@@ -1234,8 +1236,6 @@ static int ov5645_probe(struct i2c_client *client)
 	pm_runtime_mark_last_busy(dev);
 	pm_runtime_put_autosuspend(dev);
 
-	ov5645_entity_init_cfg(&ov5645->sd, NULL);
-
 	return 0;
 
 err_pm_runtime:
-- 
2.25.1

