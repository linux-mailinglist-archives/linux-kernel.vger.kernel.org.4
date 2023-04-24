Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6A596ECB7A
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 13:41:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231695AbjDXLlD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 07:41:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231405AbjDXLlB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 07:41:01 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ECB83A8C;
        Mon, 24 Apr 2023 04:40:55 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-959a3e2dc72so197505366b.2;
        Mon, 24 Apr 2023 04:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682336453; x=1684928453;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Atxqe0IIK6VDLPs1BwgFpTOFx3cvy6f167JM1AHQk1Y=;
        b=rqR0Aznkpa/KhuYo7EPT5kkIe8+ouuxZJ9sHP4Qho9DYWp83KM6BlUpNAnn0xSGLIo
         ZFVgRHM6edU8MKhCgxxayxrDx5z7ZXNEcV5POFrJmPqOxzDgrG682DZ/ooLUjTJgqcSl
         SzIE183YMcanum737awhw51qB+Co0uWiRBMs2e8j/YldO2S7gwzBC8wKYptf02p0y5jg
         kSO7SjXB6h+RAHwXHci9NHdgrdwZdOtEUZaP8AWEYGsXYxJd8Qml/TsX1vpUfSV5ejM1
         4k/Pxlt1hskBtIrYsBYKUMXL5GIodI7MJCJuzU41DiBP/l1sVmqQgSRo/ysdB5P+YFaa
         ynhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682336453; x=1684928453;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Atxqe0IIK6VDLPs1BwgFpTOFx3cvy6f167JM1AHQk1Y=;
        b=HvVFyB4IVRnFukspLClR1EqpjRnmK7oR0EXF+k3fvnr1n+iiHFzEM3fgXSc7TFOU8b
         kdHNai8YGtN7oE+gtrsQFP0YrsYKPOFhgbSX1K4OQQtyHSxb9ZLoCQj6PC6G4yjse5YO
         wqhQTHmyNQVxfgxohZsSzVI5Iy7O+XfQeqHj2z2/hyi2AXOPp3c1qK2cK9nn5aNwMHq5
         EJDtxFNMUQtJtPCyfIRSm5QHlM/0MxQeIy5+WKBprSdejQpJ0oUAlAVThCgZA8VGYbqJ
         wuojjrc1Xyo7eWMqJJGZ+9jHavV8QRH1AV14a38/lyOhbySy0NqjusTnr7PvXMW3tF1f
         PD7w==
X-Gm-Message-State: AAQBX9fr7cHoct82UuAKVG3TER8Xus/nWuE3FIbaidNbTTcfuUOkN1GR
        X0b0thfhWShrSadS5vx+Hf1IVQemhxc=
X-Google-Smtp-Source: AKy350aX/xBxpt1PnTgQ8kFjllzm6KAbnrCFnpuubj37N4v9I3qsOO7RD9Jp4Yeguir8tzDIEGhL1w==
X-Received: by 2002:a17:906:cb94:b0:94a:826c:df57 with SMTP id mf20-20020a170906cb9400b0094a826cdf57mr8242043ejb.39.1682336453548;
        Mon, 24 Apr 2023 04:40:53 -0700 (PDT)
Received: from felia.fritz.box ([2a02:810d:2a40:1104:d8ac:5455:8f1f:51ef])
        by smtp.gmail.com with ESMTPSA id a8-20020a170906670800b0094f257e3e05sm5415705ejp.168.2023.04.24.04.40.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Apr 2023 04:40:53 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Sasha Finkelstein <7d578vix8hzw@opayq.net>,
        Thierry Reding <thierry.reding@gmail.com>,
        asahi@lists.linux.dev, linux-pwm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] MAINTAINERS: adjust file entry for ARM/APPLE MACHINE SUPPORT
Date:   Mon, 24 Apr 2023 13:40:43 +0200
Message-Id: <20230424114043.22475-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit de614ac31955 ("MAINTAINERS: Add entries for Apple PWM driver") adds
an entry for Documentation/devicetree/bindings/pwm/pwm-apple.yaml, but
commit 87a3a3929c71 ("dt-bindings: pwm: Add Apple PWM controller") from
the same patch series actually adds the devicetree binding file with the
name apple,s5l-fpwm.yaml.

Adjust the file entry to the file actually added.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 82bea269e242..a430ea8018ff 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1961,7 +1961,7 @@ F:	Documentation/devicetree/bindings/nvmem/apple,efuses.yaml
 F:	Documentation/devicetree/bindings/pci/apple,pcie.yaml
 F:	Documentation/devicetree/bindings/pinctrl/apple,pinctrl.yaml
 F:	Documentation/devicetree/bindings/power/apple*
-F:	Documentation/devicetree/bindings/pwm/pwm-apple.yaml
+F:	Documentation/devicetree/bindings/pwm/apple,s5l-fpwm.yaml
 F:	Documentation/devicetree/bindings/watchdog/apple,wdt.yaml
 F:	arch/arm64/boot/dts/apple/
 F:	drivers/bluetooth/hci_bcm4377.c
-- 
2.17.1

