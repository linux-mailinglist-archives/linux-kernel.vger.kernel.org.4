Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B66D62487E
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 18:41:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229938AbiKJRlL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 12:41:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbiKJRlF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 12:41:05 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C573624973;
        Thu, 10 Nov 2022 09:41:04 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id bs21so3338800wrb.4;
        Thu, 10 Nov 2022 09:41:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q30MdsvArEgZPhyUIGZqou5nUz1ampzE4lOdExQos5I=;
        b=o2Vpt+YPvLhZHweh7xAdlR3+YrVGNhjp7NJmTPeDosfsOLlkBDscJ4Kd7LTBciMF2K
         hd3vLMn3MTRljbMGeRPuZqSj7O7WdY8kPGUHjFO0awo7787oqIv1h14zgr62jBSbvKqK
         os4lbL/cMqHdO6LMvThAmTy8oJukp8f7k6no9Fb/47tW+9edra2HMhElNFY1Y3Wr9SbF
         JsCSCYqpkKm/e7EsXwWRTsAaz5N6UhisR+UG7FyGsj4OlYKOZSZ7/VpxqeJQnOvCIr7+
         0kWltduRXMdIp6MBAVa2nY0kS2yz/aMyoilvkzHkqLF1kFk2VxVl4d+8Nrf66fwP5UXL
         q70g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q30MdsvArEgZPhyUIGZqou5nUz1ampzE4lOdExQos5I=;
        b=hfaiyUjHC9YsSkn4APzTYXhKTiHETH/icJXafNMWewyiqqiF6RENRbrDX4X79lBnPx
         fa7SR3Tb5Em34l4WjAJPPh9qzST46C8TOPsu0jD7l21ROOZFkRAIDPQYLLpKunBTWNDh
         7eV9d6rvgLqOPTpCY/2HvxsP2Cue2Lyc4YvbU8+gtA/8ULRrVTbfBBz1RLIjjTv4CFCL
         go/ctf89iig8iw+LMcx/yl9tupq+997sFbcJ8tCDFkv42jXvc69NEZCzPXOVpNgDNKcK
         pZNBsYzF80rHiPLE+FvKCecLGayGZWOlq2g6FCQ6dM7RhiCmsQIBjtFx17TkdxE+ZtvV
         wS4Q==
X-Gm-Message-State: ACrzQf25sH/4+QvTkjvhecXrPygOQ3YPO2Nx36Btk7i9NBLD2KUvu0lq
        hb6g57c898WPYA/+T9Msh/iiLsbyMKIcnw==
X-Google-Smtp-Source: AMsMyM5oFQ6QmBQ9pr5nV9+hLAIoMBYD2C3HMQlxM6yOu+E5xJ+UML6xiCEdkYUL+Ldel+LiKMtTeg==
X-Received: by 2002:adf:e510:0:b0:235:de50:72ff with SMTP id j16-20020adfe510000000b00235de5072ffmr40259764wrm.100.1668102063125;
        Thu, 10 Nov 2022 09:41:03 -0800 (PST)
Received: from localhost.localdomain ([94.73.35.109])
        by smtp.gmail.com with ESMTPSA id n10-20020a5d420a000000b0023682011c1dsm16268026wrq.104.2022.11.10.09.41.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 09:41:02 -0800 (PST)
From:   =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To:     jikos@kernel.org
Cc:     benjamin.tissoires@redhat.com, openglfreak@googlemail.com,
        alex@alexyzhang.dev, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Subject: [PATCH 1/1] HID: uclogic: Add HID_QUIRK_HIDINPUT_FORCE quirk
Date:   Thu, 10 Nov 2022 18:40:56 +0100
Message-Id: <20221110174056.393697-2-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221110174056.393697-1-jose.exposito89@gmail.com>
References: <20221110174056.393697-1-jose.exposito89@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit f7d8e387d9ae ("HID: uclogic: Switch to Digitizer usage for
styluses") changed the usage used in UCLogic from "Pen" to "Digitizer".

However, the IS_INPUT_APPLICATION() macro evaluates to false for
HID_DG_DIGITIZER causing issues with the XP-Pen Star G640 tablet.

Add the HID_QUIRK_HIDINPUT_FORCE quirk to bypass the
IS_INPUT_APPLICATION() check.

Reported-by: Torge Matthies <openglfreak@googlemail.com>
Reported-by: Alexander Zhang <alex@alexyzhang.dev>
Signed-off-by: José Expósito <jose.exposito89@gmail.com>
---
 drivers/hid/hid-uclogic-core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hid/hid-uclogic-core.c b/drivers/hid/hid-uclogic-core.c
index 0fbc408c2607..7fa6fe04f1b2 100644
--- a/drivers/hid/hid-uclogic-core.c
+++ b/drivers/hid/hid-uclogic-core.c
@@ -192,6 +192,7 @@ static int uclogic_probe(struct hid_device *hdev,
 	 * than the pen, so use QUIRK_MULTI_INPUT for all tablets.
 	 */
 	hdev->quirks |= HID_QUIRK_MULTI_INPUT;
+	hdev->quirks |= HID_QUIRK_HIDINPUT_FORCE;
 
 	/* Allocate and assign driver data */
 	drvdata = devm_kzalloc(&hdev->dev, sizeof(*drvdata), GFP_KERNEL);
-- 
2.25.1

