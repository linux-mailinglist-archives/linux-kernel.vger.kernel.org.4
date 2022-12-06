Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4ABD6442B8
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 12:58:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234868AbiLFL6O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 06:58:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235171AbiLFL5s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 06:57:48 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CD526583
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 03:57:44 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id qk9so5617940ejc.3
        for <linux-kernel@vger.kernel.org>; Tue, 06 Dec 2022 03:57:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CcIt1IaTYEax5vtcXo6kulHEbyp3PY4P8eBt1nKytvc=;
        b=ctdptYH+HKK0dnEqg++UoD1XAweQtXUqNccU7/L76eMDHIErzeUt3U6s/1fqRzrUhl
         ecctv7dyhW5cwd9l1VdgZddpAJIitY/qqIw+l30VlveiezNqLurDmsyREuhuEu+jQBVl
         XANE5/Vkt/2QVxTzGgmiKZCKR3PbB6n8V+M4wiF3f+S0WlB2QaQEBrDmPe7JWmpZk3SU
         ruI8wuQsgk/pAjIHK5tfwAmyM95rn3BMpwDFpkmtL6nUy0kVGJFmpE8gqoKXbfHaXbgR
         KCmjLJxMyOc0lsBsd22XxQB6SA1j3UFFbS5oK1hU3140dnES75SaYSFu/XFgq+zSGpe6
         ldqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CcIt1IaTYEax5vtcXo6kulHEbyp3PY4P8eBt1nKytvc=;
        b=L9BrtEwu0+9JQ1/Yy//Iywt4bIUVP/afr2gH7AVjLD1cq9AebtJfqnYNggvsXyXnnB
         23HXVL2gArNfpwNMlrn3TGkFB1Pj1F+EQZMyHCiDlol1A7ZuO4ht9GNV3kmN5X2J2KNN
         xGhAma+mhuXr8zTdd0hoYOiTbR4hXtiJ6MEUw5gyZtF3WJjnbO30KaxEFlwUxJgnGBtP
         VBgbO/5CZzQ6nI3dQxF7t3IpIf+Llqt/oYipQta+4DOw6yVnlG0JxKOwrLwgAwB6+FnK
         sJifs3B5Wa1DN8n9obP5nkofauwyW2j0zggC0yfU3ISV5JFknYvFvzgF1/X0Fz8Y5bJj
         x//g==
X-Gm-Message-State: ANoB5pnZ82DA9h2kBpFt8Wiuqm6Bre2s5zReYEW1MxuMWdb0mAsSz1A3
        7hePrJAfO9HDMgmI8OG910GUAA==
X-Google-Smtp-Source: AA0mqf6Gdfe48BdCM2e+T5oQj3c783mk2Tdg5AY9Nt0wWI7EHcHGoFluXhjLuOUAWsy/ynzjwBg34w==
X-Received: by 2002:a17:907:8b06:b0:7c0:8e3a:9a54 with SMTP id sz6-20020a1709078b0600b007c08e3a9a54mr25879568ejc.619.1670327862671;
        Tue, 06 Dec 2022 03:57:42 -0800 (PST)
Received: from blmsp.fritz.box ([2001:4091:a245:805c:8713:84e4:2a9e:cbe8])
        by smtp.gmail.com with ESMTPSA id ky20-20020a170907779400b007c0ac4e6b6esm6472076ejc.143.2022.12.06.03.57.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Dec 2022 03:57:42 -0800 (PST)
From:   Markus Schneider-Pargmann <msp@baylibre.com>
To:     Chandrasekar Ramakrishnan <rcsekar@samsung.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Wolfgang Grandegger <wg@grandegger.com>
Cc:     linux-can@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Markus Schneider-Pargmann <msp@baylibre.com>
Subject: [PATCH v2 08/11] can: tcan4x5x: Remove invalid write in clear_interrupts
Date:   Tue,  6 Dec 2022 12:57:25 +0100
Message-Id: <20221206115728.1056014-9-msp@baylibre.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221206115728.1056014-1-msp@baylibre.com>
References: <20221206115728.1056014-1-msp@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Register 0x824 TCAN4X5X_MCAN_INT_REG is a read-only register. Any writes
to this register do not have any effect.

Remove this write. The m_can driver aldready clears the interrupts in
m_can_isr() by writing to M_CAN_IR which is translated to register
0x1050 which is a writable version of this register.

Fixes: 5443c226ba91 ("can: tcan4x5x: Add tcan4x5x driver to the kernel")
Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
---

Notes:
    v2:
     - Add fixes tag

 drivers/net/can/m_can/tcan4x5x-core.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/net/can/m_can/tcan4x5x-core.c b/drivers/net/can/m_can/tcan4x5x-core.c
index 41645a24384c..1fec394b3517 100644
--- a/drivers/net/can/m_can/tcan4x5x-core.c
+++ b/drivers/net/can/m_can/tcan4x5x-core.c
@@ -204,11 +204,6 @@ static int tcan4x5x_clear_interrupts(struct m_can_classdev *cdev)
 	if (ret)
 		return ret;
 
-	ret = tcan4x5x_write_tcan_reg(cdev, TCAN4X5X_MCAN_INT_REG,
-				      TCAN4X5X_ENABLE_MCAN_INT);
-	if (ret)
-		return ret;
-
 	ret = tcan4x5x_write_tcan_reg(cdev, TCAN4X5X_INT_FLAGS,
 				      TCAN4X5X_CLEAR_ALL_INT);
 	if (ret)
-- 
2.38.1

