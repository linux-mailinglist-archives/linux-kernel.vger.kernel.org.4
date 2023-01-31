Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81DB8682EB7
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 15:03:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230193AbjAaODU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 09:03:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231129AbjAaODO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 09:03:14 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80CFFE3BD
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 06:03:12 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id bk16so14286317wrb.11
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 06:03:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pUQAfjtzy6EHxBJwfhCl4n1J2zAjSrYnuYq1+Ya8AU8=;
        b=5EwBkRx2phRr/ZYJsMhNxJp2z4S/F3F98Kq/UdYpIR3RcPcor5lLTFXR1/fm07VojA
         zW5bwxslz2w40u2E9045YdCmf+hQ9FMtyG3jwT2TxvpKWsQ2plFY33sN5/0EovkDTFlq
         zOqLumxbaDqV/N1yKDKsuoq2/8INuGx87WOCyBwH9vR343msq4ZFOFZ+Nwd+5WwgYfFW
         W+ovpD29+RzBWaZCmFdt6Pv03+LkJP6cudNiGBIQibOdGgv6rnUDIzqpcHXGRUMuJwwM
         s81PM0sovgrdRLmQDf9OzhxedNbR3BAeF6Pqlt9oFrWreDt71G8iu/XFhfiRpcUTJgHh
         a81Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pUQAfjtzy6EHxBJwfhCl4n1J2zAjSrYnuYq1+Ya8AU8=;
        b=hTrb5IX1OPdmRi6af+XzG9CEgOHQ98fmt5ruI3DjuqqCvf3cObXP/lL2cl3uidjeJu
         M8lBMmqAx7AyijykUnzhAOIlr8+jikKoyV4Icw9xhJvIoHusgE2a539ia1v+hf8u3xZa
         Ya7KnJ/mRBbBkJKAOEsWXwGRbfab87h5xGN3gIfjQ3mXNKRSffJUpNEkZmstcRbsqwTN
         qJoY4JHKoYl2DZNB8TUayfQFObuJQxYh8sSudcgTcdlxVwZ9Gg2om5kboszyklaR8hsj
         1Bi+EO1/Bmkq0cASNGa3K0XTvc1MptYITTFr17YCBumpxNVZliQuXjfDD2tD3z/4JcvE
         cr1Q==
X-Gm-Message-State: AO0yUKWB5Dj8NizzqHegoR91P/RRWnBykyZEgRkHEhE2m3O/i8gX0/13
        bWI3otzMEnyeLZrFThRyArh+Ew==
X-Google-Smtp-Source: AK7set/1e9CI63BRGdwQ0kdmY/hhRzptTQlu8l+kfqIz/ymeJkNJepvsqjiXzfSIUu4MCudn8yt7dA==
X-Received: by 2002:a5d:6549:0:b0:2bf:b5bd:8f60 with SMTP id z9-20020a5d6549000000b002bfb5bd8f60mr23116076wrv.61.1675173790523;
        Tue, 31 Jan 2023 06:03:10 -0800 (PST)
Received: from localhost.localdomain (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id z12-20020adff74c000000b00291f1a5ced6sm14950847wrp.53.2023.01.31.06.03.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Jan 2023 06:03:09 -0800 (PST)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     lee@kernel.org, linus.walleij@linaro.org, pavel@ucw.cz,
        robh+dt@kernel.org, jacek.anaszewski@gmail.com,
        krzysztof.kozlowski+dt@linaro.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org, Corentin Labbe <clabbe@baylibre.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v5 1/2] dt-bindings: leds: common: add disk write/read and usb-host/usb-gadget
Date:   Tue, 31 Jan 2023 14:03:03 +0000
Message-Id: <20230131140304.626779-1-clabbe@baylibre.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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

Changes since v3:
- rebased on recent tree

Changes since v4:
- rebased on recent tree

 Documentation/devicetree/bindings/leds/common.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/leds/common.yaml b/Documentation/devicetree/bindings/leds/common.yaml
index d34bb58c0037..60c8611c6611 100644
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
       - pattern: "^cpu[0-9]*$"
       - pattern: "^hci[0-9]+-power$"
         # LED is triggered by Bluetooth activity
-- 
2.39.1

