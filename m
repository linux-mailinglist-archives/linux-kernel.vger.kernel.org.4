Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15CA26C82C9
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 18:03:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231934AbjCXRDI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 13:03:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231899AbjCXRDC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 13:03:02 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFF4FC158;
        Fri, 24 Mar 2023 10:03:00 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id z10so1455912pgr.8;
        Fri, 24 Mar 2023 10:03:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679677379;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N5G/syVam4SknjFsEw80vzFCuD6BG5cs1b0YrLZ+gNk=;
        b=Cas8Gt9ektgQ2rcRR2JeaOYXS/1ps49r5/wx0KyMKgbqMR5bH0afftcvn5CtT8bPhf
         kPJ7JKJp8BIUceMpo9qfNqNAczsIXboLCUDqXQVJRE92ZqfwIAJQnnlhtYBilTjuwhrb
         Nko2PwaB6nHe2J6B4KqeRL1Iq42JQQaf3lRdM2f9GOSXvgG1pYn4LtsAeds/J6nmblls
         qpEdNyGRmYp8g1pMAv5cH8SnDwLBtyVQ0D7FNm+cK1LmhuMyWJory5Noczg2pKJNL61+
         38SGoEaFXnk+LzGn5Ec5B2k6X9Q0/DImArSzyKnVkNm3+Tq1RLhKOimwRylMmclspZQp
         0TKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679677379;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N5G/syVam4SknjFsEw80vzFCuD6BG5cs1b0YrLZ+gNk=;
        b=3/JN8wot07q3RFUpuI2Q+5z5lzDXOaJhkMqeXUfXq8sfq6ABJIYypAj6fIs2VyVOtl
         fI4/vAYe1BhlwLPwsDApxqgbtxQGsM08KphJ1YFSd+v2W045OlsGW1XXYq0Nq5mDzZkw
         YxUvhRa/2YgV6kK69/wm53HFNw/GRVK3u4f2hLedSgFpQhDSCmNWWBM7icJCKzRf7OWe
         mDfLyeZiZ4ZOJ8AOCoCjzHrx+qQhBIAd5WfO/QNfVOrGvVd32Vbop/7v/aEWQlE46Ift
         mA5i5asHWHKGtKGDLimIjRv8DC95iADJ+PmBMHJbiasbR9q6hSjKaVIyQY6ObBWZgtyX
         vKuA==
X-Gm-Message-State: AAQBX9eltAABKR5xGq6J7xatzG9SDvOzgNK/2/bGD/wMrMhcj1BXQelL
        J/B2UROAxVADJk+i9D0saCCOWqEcLvc=
X-Google-Smtp-Source: AKy350b3wyhVDacuWzIEl+/UsWhf4h3NsPr2BPhwZPpPDsN8HToPQbiu8WNu78rM3EYfQa6ulfOTsQ==
X-Received: by 2002:a62:5b04:0:b0:623:6131:66ca with SMTP id p4-20020a625b04000000b00623613166camr3283138pfb.32.1679677379543;
        Fri, 24 Mar 2023 10:02:59 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id h4-20020a62b404000000b005a8bfe3b241sm14019591pfn.167.2023.03.24.10.02.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Mar 2023 10:02:58 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     bcm-kernel-feedback-list@broadcom.com,
        Florian Fainelli <f.fainelli@gmail.com>,
        Matthew Lear <matthew.lear@broadcom.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sean Young <sean@mess.org>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Ravi Kumar V <kumarrav@codeaurora.org>,
        linux-media@vger.kernel.org (open list:MEDIA INPUT INFRASTRUCTURE
        (V4L/DVB)),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS)
Subject: [PATCH 2/2] media: rc: gpio-ir-recv: Fix support for wake-up
Date:   Fri, 24 Mar 2023 10:02:14 -0700
Message-Id: <20230324170214.3470675-3-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230324170214.3470675-1-f.fainelli@gmail.com>
References: <20230324170214.3470675-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver was intended from the start to be a wake-up source for the
system, however due to the absence of a suitable call to
device_set_wakeup_capable(), the device_may_wakeup() call used to decide
whether to enable the GPIO interrupt as a wake-up source would never
happen. Lookup the DT standard "wakeup-source" property and call
device_init_wakeup() to ensure the device is flagged as being wakeup
capable.

Reported-by: Matthew Lear <matthew.lear@broadcom.com>
Fixes: fd0f6851eb46 ("[media] rc: Add support for GPIO based IR Receiver driver")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/media/rc/gpio-ir-recv.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/media/rc/gpio-ir-recv.c b/drivers/media/rc/gpio-ir-recv.c
index 8dbe780dae4e..41ef8cdba28c 100644
--- a/drivers/media/rc/gpio-ir-recv.c
+++ b/drivers/media/rc/gpio-ir-recv.c
@@ -103,6 +103,8 @@ static int gpio_ir_recv_probe(struct platform_device *pdev)
 		rcdev->map_name = RC_MAP_EMPTY;
 
 	gpio_dev->rcdev = rcdev;
+	if (of_property_read_bool(np, "wakeup-source"))
+		device_init_wakeup(dev, true);
 
 	rc = devm_rc_register_device(dev, rcdev);
 	if (rc < 0) {
-- 
2.34.1

