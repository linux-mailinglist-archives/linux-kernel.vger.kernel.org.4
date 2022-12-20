Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44364651FF2
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 12:53:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232937AbiLTLxD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 06:53:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbiLTLxB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 06:53:01 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12A3163DD;
        Tue, 20 Dec 2022 03:53:01 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id m4so12022943pls.4;
        Tue, 20 Dec 2022 03:53:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Lso547JX5vTY2uG06uoFIFztgpYecJYWXqOFJKfCq9A=;
        b=NZBmBWT0pXX5TaRDccE1wmua0oWib2GxgHdFapwRZJovA6yEJLwSuHqnjdnlGzvdFx
         sbJoX6yb8Ubb1qa/54JSFrn8/KVPrk6Zgz6ksxwgK7Hge+QQx4JOp44XYTbyOv7c4QrN
         9dmddS+pG07psJp1LojSHEDz6xCj+gviFXyTAPvuGbyard1kB/iP+sfVUeNMN05dsEKw
         a4LoQ/J+rOjMQgkXk7qHVIwsgnkqkVeZENxlDA/NMfH20WJ9u/+M3Di90NUfk9/r76RN
         6+MJ9C/BG2GMl8fCxkMRohgwfz6z8QRM3msAgJv1RLsrde9Niq4pBZ11iPtgjvhGD3BP
         BX6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Lso547JX5vTY2uG06uoFIFztgpYecJYWXqOFJKfCq9A=;
        b=AGcuIoxtEJDvEqzVXux+3AKB9iqro+Iwq+zJA/Zy+29Jgs7BpgfcFObrPiDWSsP97e
         w34Rsmx4VNT75qip9xgDbPUGEBjoAgRKP4tzN9MVMeUH1BiY7VBP2osqairxI3dp2Pfp
         YVwUMbT+EgxiTU0g/G9jKUm4fAC8jG+sXgpXpQwC+nnu0rdKf0oIN7f5EzI+PkcOrZR/
         yGKFrnvofaet+Ee2U+N7z9XZvex6PQIBNqMt4LQxvvp/3aZXp8GZAh6B9oJjcmPUn8jL
         TLztXZmyQ7oC/cWOc+ZZrcvbxoBSjFOK5J105u2DzPLXuSfn8/2l7LO60eAArnQfWssd
         CKCw==
X-Gm-Message-State: ANoB5pkGisgo6dpC/Hr8TwzXBm2xhRDJhrJOqpNC0wYe4Z7gxT4saA5X
        gxanCK/BT4eEfS9UbBzlryc=
X-Google-Smtp-Source: AA0mqf74eIrv2LcbZ4UdOuZq35RVyjX2oL4FLp5h/Guu7OQyM9gJa2Y4Kvx4rn4wBkEUJM22lye9Ug==
X-Received: by 2002:a17:903:515:b0:189:ec2d:89c0 with SMTP id jn21-20020a170903051500b00189ec2d89c0mr46662475plb.59.1671537180573;
        Tue, 20 Dec 2022 03:53:00 -0800 (PST)
Received: from localhost.localdomain ([202.120.234.246])
        by smtp.googlemail.com with ESMTPSA id j5-20020a170902c3c500b00172fad607b3sm9140276plj.207.2022.12.20.03.52.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Dec 2022 03:52:59 -0800 (PST)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Miaoqian Lin <linmq006@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Eric Anholt <eric@anholt.net>, linux-input@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] input: raspberrypi-ts: Fix refcount leak in rpi_ts_probe
Date:   Tue, 20 Dec 2022 15:52:43 +0400
Message-Id: <20221220115246.1522054-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
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

rpi_firmware_get() take reference, we need to release it in error paths
as well. Add missing rpi_firmware_put() in the error handling to fix it.

Fixes: 0b9f28fed3f7 ("Input: add official Raspberry Pi's touchscreen driver")
Fixes: 3b8ddff780b7 ("input: raspberrypi-ts: Release firmware handle when not needed")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/input/touchscreen/raspberrypi-ts.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/input/touchscreen/raspberrypi-ts.c b/drivers/input/touchscreen/raspberrypi-ts.c
index 5000f5fd9ec3..114237c76378 100644
--- a/drivers/input/touchscreen/raspberrypi-ts.c
+++ b/drivers/input/touchscreen/raspberrypi-ts.c
@@ -140,21 +140,24 @@ static int rpi_ts_probe(struct platform_device *pdev)
 		return -EPROBE_DEFER;
 
 	ts = devm_kzalloc(dev, sizeof(*ts), GFP_KERNEL);
-	if (!ts)
-		return -ENOMEM;
+	if (!ts) {
+		error = -ENOMEM;
+		goto err_put_fw;
+	}
 	ts->pdev = pdev;
 
 	ts->fw_regs_va = dma_alloc_coherent(dev, PAGE_SIZE, &ts->fw_regs_phys,
 					    GFP_KERNEL);
 	if (!ts->fw_regs_va) {
 		dev_err(dev, "failed to dma_alloc_coherent\n");
-		return -ENOMEM;
+		error = -ENOMEM;
+		goto err_put_fw;
 	}
 
 	error = devm_add_action_or_reset(dev, rpi_ts_dma_cleanup, ts);
 	if (error) {
 		dev_err(dev, "failed to devm_add_action_or_reset, %d\n", error);
-		return error;
+		goto err_put_fw;
 	}
 
 	touchbuf = (u32)ts->fw_regs_phys;
@@ -206,6 +209,10 @@ static int rpi_ts_probe(struct platform_device *pdev)
 	}
 
 	return 0;
+
+err_put_fw:
+	rpi_firmware_put(fw);
+	return error;
 }
 
 static const struct of_device_id rpi_ts_match[] = {
-- 
2.25.1

