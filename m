Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E5BC61419D
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 00:23:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbiJaXXF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 19:23:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229938AbiJaXWl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 19:22:41 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0EE015821;
        Mon, 31 Oct 2022 16:22:19 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id v1so18027624wrt.11;
        Mon, 31 Oct 2022 16:22:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w4n/PVXJaI0AZ90mJ+ujyPK1tladHQFvLZoHvifyNgE=;
        b=iriYmRi7F+gUWdk3CPDtwYWNytgMeCCV/+jNmQm6VV/pFm3r10jPG3b9nufXlYb46A
         r8nnGnkDk/PB4ktZNp5DFh+M3g9gSt9alapkjnhh96+ew4Yjuxtfv4b9fv8G0+Iv1jnf
         90bEyDhop8d1D+CE3TihTTtp5mlp8Kpl/Rrl0DMCXYLgpdw/eFeUDYYwcEb+PK7jcnTE
         Zf5nRXuLiod6Pe4Cgqb48vJnkjpcT5YQEtBgW7zbQCbL2zNo0LsSeLwEUgOXfRWtSbCz
         hHvR7V6fWN0uylB3E+Hf80ugSYzmjZaUBhcWYRx/lXQccg88/fG/GvSwLJwV1dypLY6m
         T3YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w4n/PVXJaI0AZ90mJ+ujyPK1tladHQFvLZoHvifyNgE=;
        b=rfzOm1zO0b471p2GhDzzMDl6LsyxtkhYYVWrW1g+1LEonR+ycMYNGBaoWdzRDPh5d8
         Itrh63dzq8xsur0yntdJybApRZhtuH7IpPziU28fd6vgYoZni5JRh4MuurzNQxOO09rk
         doZYEBKcFuerBw2xDr4ZB4ycAI08FK19aTFKQ8AMB6RTAuFWIhKDKKn3O8AJloXt4VjF
         In9I9UmB5d0LP9h7EqI+iUEBOxthIsAO38+m2AyytDS6jToOI45aALPrfrnf8bMexrvz
         36CJwcoLpR6yaXYp5Jdz0ppUsc49t1Vja9Qm85zFmRVxFkU9V4SVdFrogtpfSwsULYmg
         XOKw==
X-Gm-Message-State: ACrzQf1IpXvfi8mlL7SFbufbtx/T85dgnsYjO8VyGVCLup2vHOTj7zJM
        q54pdQ1Glcalt9SvCLGNg1U=
X-Google-Smtp-Source: AMsMyM6TyZvntfj8dZLfSz4qg5QK2s6ccmOhWhLCF/L7jN7iiEWR70pxBXfHuyGjjbod1jZaStISWQ==
X-Received: by 2002:adf:ed01:0:b0:230:d7c8:9a91 with SMTP id a1-20020adfed01000000b00230d7c89a91mr9737366wro.511.1667258538245;
        Mon, 31 Oct 2022 16:22:18 -0700 (PDT)
Received: from prasmi.home ([2a00:23c8:2501:c701:15da:d6ab:ec79:436])
        by smtp.gmail.com with ESMTPSA id l24-20020a1c7918000000b003cf7928e731sm2190343wme.9.2022.10.31.16.22.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 16:22:17 -0700 (PDT)
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
Subject: [PATCH v4 9/9] media: i2c: ov5645: Call ov5645_entity_init_cfg() before registering the subdev
Date:   Mon, 31 Oct 2022 23:22:02 +0000
Message-Id: <20221031232202.131945-10-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221031232202.131945-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20221031232202.131945-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
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
v3->v4
* No change

v2->v3
* Included RB tag from Laurent.

v1->v2
* New patch
---
 drivers/media/i2c/ov5645.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/i2c/ov5645.c b/drivers/media/i2c/ov5645.c
index 0a889283da36..c8999fc4f26f 100644
--- a/drivers/media/i2c/ov5645.c
+++ b/drivers/media/i2c/ov5645.c
@@ -1220,6 +1220,8 @@ static int ov5645_probe(struct i2c_client *client)
 	pm_runtime_get_noresume(dev);
 	pm_runtime_enable(dev);
 
+	ov5645_entity_init_cfg(&ov5645->sd, NULL);
+
 	ret = v4l2_async_register_subdev(&ov5645->sd);
 	if (ret < 0) {
 		dev_err(dev, "could not register v4l2 device\n");
@@ -1231,8 +1233,6 @@ static int ov5645_probe(struct i2c_client *client)
 	pm_runtime_mark_last_busy(dev);
 	pm_runtime_put_autosuspend(dev);
 
-	ov5645_entity_init_cfg(&ov5645->sd, NULL);
-
 	return 0;
 
 err_pm_runtime:
-- 
2.25.1

