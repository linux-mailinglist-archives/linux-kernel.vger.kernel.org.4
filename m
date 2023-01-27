Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06E8B67E19B
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 11:29:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231590AbjA0K3c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 05:29:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231522AbjA0K3b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 05:29:31 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB83E1E9CB;
        Fri, 27 Jan 2023 02:29:29 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id bk15so12440573ejb.9;
        Fri, 27 Jan 2023 02:29:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Kl4vvs/mNFqcvRMUjQB6MZEBYyzmISH11LLZs+X1CO4=;
        b=irrwnmVUWs7xcQXObqZW8LOuUQ4STYokXf3xo0hwMdm2SNHUrbV1RYueQF57z3XtzW
         Hhz/ieiHGSao8BYNOeeWiAuv4Kxla/RI5bZjpR3WMNARgHhCuKj+IKrw2OSIIPE7VQIZ
         2mWn65gMvU61oRKJffsgzQ+3OszBQSSVYpAUTIStDAroQ6dQj5aTjca9TbawTIWL63l0
         ZGuKVEcRCSW3uYrDOpIZNiWYcyr6NAhVTJhc1jHJjFGPv5FbKGKurotF/uXaNT9w/0to
         9Q65kpsMeXVtZ7Kp79Rd44ckMe4kzUoYrAUtCi12bXhgmPn24Ek1vrFw/0vccZ6Hy29C
         groA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Kl4vvs/mNFqcvRMUjQB6MZEBYyzmISH11LLZs+X1CO4=;
        b=mnFAjWTQfn+hgejDfcSWHbxZXOkS2ulSJGKU/FpBdzdBHs/JLA4/nEnsVAlUB8UsYY
         8A9rQW9vKIyXghMbir9gVP14evn9AruXtFzhrR83ayW5q/R+lBXoeK9c5U7We/DA1NVk
         imr7lpxFZrh/lYDgbzsGY6m3NemojwmWV7mJcMQ14Dd3GPuuF/qYW7yfEZsZLfQh/ySy
         TfGzN9LWO/K6lxcL1VA6z6AxBnPraTvXs8VXJOpAjbT9KuPpPqS+5wNbspZPeCu3dFCB
         dje/Te0hPCHzwcUEBHOCUT1F5O7ddwzNbh3BAgp0JIBzCI2FCotJQDtJUor9i9RFshbW
         xslQ==
X-Gm-Message-State: AFqh2kppGf7ogQAN7jDjYxi95qqCgQuLxTTFCXFfVvZ+xUYWmedjr2VU
        7d9yPfZubSUBZn+755YTstvz57iawJk=
X-Google-Smtp-Source: AMrXdXu1S8QSuCwn3lnDyLAH/K3ImzWyRibvemHp3ZDDHYsyeTklqfAnwTD50xdqkaDuWmpTMc8SCg==
X-Received: by 2002:a17:906:9411:b0:870:2aa7:64fc with SMTP id q17-20020a170906941100b008702aa764fcmr38898717ejx.38.1674815368100;
        Fri, 27 Jan 2023 02:29:28 -0800 (PST)
Received: from localhost.localdomain ([195.242.46.66])
        by smtp.gmail.com with ESMTPSA id r25-20020a170906c29900b0084d4b907ff8sm1990023ejz.120.2023.01.27.02.29.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 02:29:27 -0800 (PST)
From:   Richard Kjerstadius <kjerstadius@gmail.com>
X-Google-Original-From: Richard Kjerstadius <richard.kjerstadius@teledyne.com>
To:     linux-input@vger.kernel.org
Cc:     Richard Kjerstadius <richard.kjerstadius@teledyne.com>,
        linus.walleij@linaro.org, dmitry.torokhov@gmail.com,
        alistair@alistair23.me, linux-kernel@vger.kernel.org
Subject: [PATCH] input: cyttsp5: Fix bitmask for touch buttons
Date:   Fri, 27 Jan 2023 11:29:03 +0100
Message-Id: <20230127102903.3317089-1-richard.kjerstadius@teledyne.com>
X-Mailer: git-send-email 2.39.1
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

Prior to this patch, the bitmask ends up being 0x3, as opposed to 0x1
which likely was the intention. The erroneous bit results in the driver
reporting 2 different button activations in designs with 2 or more
buttons.

To detect which button has been pressed, cyttsp5_btn_attention() uses a
for loop to iterate through the input buffer, while shifting and
applying a bitmask to determine the state for each button.
Unfortunately, when the bitmask is 0x3 and there are multiple buttons,
this procedure falls apart.

Consider a design with 3 buttons. Pressing the third button will result
in a call to cyttsp5_btn_attention() with the input buffer containing
0x4 (binary 0100). In the first iteration of the for loop cur_btn_state
will be:

(0x4 >> 0 * 1) & 0x3 = 0x4 & 0x3 = 0x0

This is correct. However, in the next iteration this happens:

(0x4 >> 1 * 1) & 0x3 = 0x2 & 0x3 = 0x2

Which means that a key event for key 1 is generated, even though it's
not really active. In the third iteration, the loop detects the button
that was actually pressed:

(0x4 >> 2 * 1) & 0x3 = 0x1 & 0x3 = 0x1

This key event is the only one that should have been detected, but it is
accompanied by the preceding key. Ensuring the applied mask is 0x1
solves this problem.

Signed-off-by: Richard Kjerstadius <richard.kjerstadius@teledyne.com>
---
 drivers/input/touchscreen/cyttsp5.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/touchscreen/cyttsp5.c b/drivers/input/touchscreen/cyttsp5.c
index 4a23d6231382..16caffa35dd9 100644
--- a/drivers/input/touchscreen/cyttsp5.c
+++ b/drivers/input/touchscreen/cyttsp5.c
@@ -29,7 +29,7 @@
 #define CY_MAX_INPUT				512
 #define CYTTSP5_PREALLOCATED_CMD_BUFFER		32
 #define CY_BITS_PER_BTN				1
-#define CY_NUM_BTN_EVENT_ID			GENMASK(CY_BITS_PER_BTN, 0)
+#define CY_NUM_BTN_EVENT_ID			GENMASK(CY_BITS_PER_BTN - 1, 0)
 
 #define MAX_AREA				255
 #define HID_OUTPUT_BL_SOP			0x1
-- 
2.39.0

