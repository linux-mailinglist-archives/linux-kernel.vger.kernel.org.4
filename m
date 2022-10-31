Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDAB9614195
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 00:22:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229781AbiJaXWu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 19:22:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229885AbiJaXWS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 19:22:18 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FF9015831;
        Mon, 31 Oct 2022 16:22:17 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id cl5so6397330wrb.9;
        Mon, 31 Oct 2022 16:22:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fJBWoy7TJ47MfKlpeijbPHMAr4KHuBmcOIWaFpNesOo=;
        b=RF79MqPp6/jwnF0C2Wz9VR92XLalmz4Kv5718fsA8GaNwxe/y9LDw6Ar7MQ+7SPbx1
         4/vfpxIE9A/klzv9jdUckFRYf/IAq4IIYcc7MtfmFoA3P0g79UBDfMble2aN+h6kKVcZ
         4HWBQczK3nu/pRJHTI76YVlpKeB32xmA0PBiNLIkCHexeu57n9l79INx8D5Dqm9jZ/Iw
         y0N3TMwOu4jzTzNEoVmjert64dHTzYVd0MH8wKf+MH8M9JSbevpZkH/Gze2Agr1qLNU8
         YgzDDgbY4H/sZiSkD/8GEEHozPG+/AAaQ6BQk5uaTjCmhsA8BVrWcobHePPHhjfRRKdX
         iDQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fJBWoy7TJ47MfKlpeijbPHMAr4KHuBmcOIWaFpNesOo=;
        b=JeznquZCFxE4+9iigQKrymAd39RyM2JaXkXdLVuAQhMLrYHw1wguIRmo9X/a48dnQf
         VpU+9dt6rxVS1laYuPJj6li1HdPhDEccGSg0B5QaWV95Cq+HkO+vHvY5mr8h/wPWe0Cd
         4VFQQv9inT530FQpea3Pr3adcZ47XbFsotEsBKGQlQOSeDheVu4TW5zrkJV/G2Ehid6s
         F0p2im5RGJ/gORACp4G7mIIW5JOPDbr05udVOx2+gXNWPa1Fx3czCGbO9nLR43TEx9R0
         w3CKLrzuWV0wS18pUMSHcsB71P4gqYgGrHP+BfK60SpFwsLTx2UFlm0RcscxxS+YM7Am
         oBgQ==
X-Gm-Message-State: ACrzQf0RBAdUy750KGsgvM4IUdKsgq6qSMX7byuc414uvB2v2PAfg/mC
        mQFQx+fo+JovwjqeVGe0i5Q=
X-Google-Smtp-Source: AMsMyM79W/pa8L0mk+53L9ve6nBRik58aJo+npJd7mdZsnrVFKc4XVCuByLE1Y8QVs/egaaHybsPaA==
X-Received: by 2002:adf:e2c8:0:b0:230:ba81:cf0c with SMTP id d8-20020adfe2c8000000b00230ba81cf0cmr10102710wrj.357.1667258535600;
        Mon, 31 Oct 2022 16:22:15 -0700 (PDT)
Received: from prasmi.home ([2a00:23c8:2501:c701:15da:d6ab:ec79:436])
        by smtp.gmail.com with ESMTPSA id l24-20020a1c7918000000b003cf7928e731sm2190343wme.9.2022.10.31.16.22.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 16:22:14 -0700 (PDT)
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
Subject: [PATCH v4 7/9] media: i2c: ov5645: Drop empty comment
Date:   Mon, 31 Oct 2022 23:22:00 +0000
Message-Id: <20221031232202.131945-8-prabhakar.mahadev-lad.rj@bp.renesas.com>
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

Drop empty multiline comment.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
v3->v4
* No change

v2->v3
* Included RB tag from Laurent.

v1->v2
* No change
---
 drivers/media/i2c/ov5645.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/media/i2c/ov5645.c b/drivers/media/i2c/ov5645.c
index 2e6135d0a31a..6897f542737a 100644
--- a/drivers/media/i2c/ov5645.c
+++ b/drivers/media/i2c/ov5645.c
@@ -14,9 +14,6 @@
  *   https://www.mail-archive.com/linux-media%40vger.kernel.org/msg92671.html
  */
 
-/*
- */
-
 #include <linux/bitops.h>
 #include <linux/clk.h>
 #include <linux/delay.h>
-- 
2.25.1

