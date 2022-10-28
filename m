Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67677610A6D
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 08:42:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbiJ1GmS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 02:42:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229870AbiJ1Glw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 02:41:52 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1067415B305
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 23:41:49 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id bg9-20020a05600c3c8900b003bf249616b0so2849062wmb.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 23:41:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pW67w54VW6hMiwBpE+8e4feStlkLZps5VX75c4wE11Q=;
        b=vzESmk/pqrKW0wWW8snVPstmmTABNdIAlBU5Vnebpsdu9zEU/vvi0ukbWnHaddtL+j
         1m1Hyk6dxr+NCsQL4QBnO05peXndx8IWFxZCIutHo1M/6cy23CQyJj71po6K/fWwXoC7
         Poh2RFiv6FypKR/8IYfEVoeKWxYKi8qfy8W3RO6HEhbrXx1KJf7XRm2Svc8xE+EgU3R9
         lOBKTbsvATwvgdVEY3ryAkMnxOZ46XVndz+AB1xnrJVMaO+fHCI8OR3y9mTlEpxre4Ke
         Z8Ss2e45hN0Y6xzH15MgGRMf6bI5LfLFAW8tRYmtD2PDGlC9lYQKKB+uRKjQTs/6J8gm
         1/LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pW67w54VW6hMiwBpE+8e4feStlkLZps5VX75c4wE11Q=;
        b=jRhQcRGb78NeKFpzZ9pS8J1Pz1XspQRGxDHIrBbPVyj635RyqGb5TOgn+0uizHqyvw
         oCSqgPne2hH7gxz0M45C7SSBzbYzW7XnRP/NAKv00ojNCZJJmktKSQ5OYLmJDIbsQ+zB
         zKTcaW5+H4EjbH8MhMm9p5DaFWCYKuLY7he+B1Mu2n3rwhS+jQXlI+3EGrW8CjZlihPI
         SMB3mMzu1sNUw6tm4jj1GwG2zQ7U6K8rh8dClvp6mjxD7R7RWNZon7OunsVMmZ0GgirI
         FpKN5EmerBwat8N8BGYzQyWwf4yBhD7ld8VJL92W5i5XKzXlsAAQDfHLWFqYEeOKKoJP
         B4gA==
X-Gm-Message-State: ACrzQf0TYPnEDs3jVA1pR9zRBmF+TA2WxamgFL5AzksEblLt/cgvUZkr
        vgDevUlv+rLwgweXyyHrqvEeFg==
X-Google-Smtp-Source: AMsMyM6MF6iXF3Vbr8+9LVdv/dLucMkGE6IxQEIr1BfhoAdfJj2zxG0tSODIPtiImospUL3ffmOGSg==
X-Received: by 2002:a7b:c34a:0:b0:3c6:e069:d41c with SMTP id l10-20020a7bc34a000000b003c6e069d41cmr8316994wmj.180.1666939307626;
        Thu, 27 Oct 2022 23:41:47 -0700 (PDT)
Received: from localhost.localdomain (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id h17-20020a05600c351100b003c7087f6c9asm7253979wmq.32.2022.10.27.23.41.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Oct 2022 23:41:47 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     pavel@ucw.cz, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linus.walleij@linaro.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org, Corentin Labbe <clabbe@baylibre.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v3 1/2] dt-bindings: leds: common: add disk write/read and usb-host/usb-gadget
Date:   Fri, 28 Oct 2022 06:41:40 +0000
Message-Id: <20221028064141.2171405-1-clabbe@baylibre.com>
X-Mailer: git-send-email 2.25.1
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

The triggers enum misses 3 cases used by gemini DT.
usb-host was added via commit 0cfbd328d60f ("usb: Add LED triggers for USB activity")
so we add also as valid trigger usb-gadget which was added along in this
commit.

disk-read/disk-write were added by commit d1ed7c558612 ("leds: Extends disk trigger for reads and writes")
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Acked-by: Rob Herring <robh@kernel.org>

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
V1 can be seen at https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20210508193654.2596119-1-clabbe@baylibre.com/
Changes since v1:
- rebased on recent tree

Changes since v2:
- rebased on recent tree

 Documentation/devicetree/bindings/leds/common.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/leds/common.yaml b/Documentation/devicetree/bindings/leds/common.yaml
index f5c57a580078..8ebe602419b5 100644
--- a/Documentation/devicetree/bindings/leds/common.yaml
+++ b/Documentation/devicetree/bindings/leds/common.yaml
@@ -90,6 +90,8 @@ properties:
           - heartbeat
             # LED indicates disk activity
           - disk-activity
+          - disk-read
+          - disk-write
             # LED indicates IDE disk activity (deprecated), in new implementations
             # use "disk-activity"
           - ide-disk
@@ -98,6 +100,8 @@ properties:
             # LED alters the brightness for the specified duration with one software
             # timer (requires "led-pattern" property)
           - pattern
+          - usb-gadget
+          - usb-host
         # LED is triggered by SD/MMC activity
       - pattern: "^mmc[0-9]+$"
       - pattern: "^cpu[0-9]*$"
-- 
2.37.4

