Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45B8468FF0C
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 05:32:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230186AbjBIEce (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 23:32:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230033AbjBIEbs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 23:31:48 -0500
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 038A0410A4;
        Wed,  8 Feb 2023 20:31:24 -0800 (PST)
Received: by mail-qt1-x82a.google.com with SMTP id cr22so740513qtb.10;
        Wed, 08 Feb 2023 20:31:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VYWiP+RsM80H7wNl1WU3UTCyecPhj1rDTS0XQ6/EiJw=;
        b=hbYjs18CuQ0IQIi/4UFBBwFlt4MSIr6vr81jKyijX8hbDAOoyJN3fTFZjDoMHUG1bM
         0iIhI3c62lP2A4OrZEnGXHLhMTNnGsO1RnuaHvqAiPT66Z/L0AcirFHqvngA05AA2WvT
         NFAm7bgGiHeu/JNV2zkLZdWEyRXt9JeOXCVKbaeRnU5sfmkKE8mWIqR2bEtMy24mM0QK
         XKjnLUFEIz07fE1krRmq/21MV48wsOFCIbomIIM8oqgbxQRfsM+K5aPe7IfKIwPXdqBz
         tSkSj4WVRYZy9I4VIe5nSz/kjjvZd/Bnc1T/rX1pQsvv/0wCxWZsmWl5/dw2GKaFU2FF
         JJNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VYWiP+RsM80H7wNl1WU3UTCyecPhj1rDTS0XQ6/EiJw=;
        b=PdyzyKYa8PoIVlFIhxIFVbAPzTqni0sUUhbgGW6onEh+XWFXU++9L5JOjrTGcAbyWA
         midH2vVQqB390AEJGkLcl7MO9W9vQ5Om/YQD3Zt/qEJnmx8YtnXMZ9JdIySbfu74NxeJ
         E/8U1xGe4t990gQf8l5szDMkVYak905jsMK74qcTapcmVuskPfmq29hdAqip1tUA3fqH
         o2//gmAVi087uYizEeL2x1JQyJDjswC18jjZvlyZknsEcbFuoAayBWxTbhEnksepyEgE
         z3aDapJiGIDmieGUl4af3P0o5Ls+wA/GJCUg5QgM/Vk3kUYEHBLHwBGVtfHF92A3j0oG
         b5vg==
X-Gm-Message-State: AO0yUKVPPzPwAEirZL0qlqLI+NT30QyLqjkaYtWcOCMApd879gUmdhIJ
        ezetJQgBRQL7CdaM/tR3M41LWi8UF4k=
X-Google-Smtp-Source: AK7set8dGL84ssKLZLSeE60Lv0RqogRPo+cGf2+zrA1Ok1ed4iVWSrC5cSgmpAS+7CG0FqkagsDylw==
X-Received: by 2002:ac8:48cd:0:b0:3b9:bc8c:c213 with SMTP id l13-20020ac848cd000000b003b9bc8cc213mr844571qtr.30.1675917076899;
        Wed, 08 Feb 2023 20:31:16 -0800 (PST)
Received: from localhost.localdomain (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id ca16-20020a05622a1f1000b003a7e38055c9sm548560qtb.63.2023.02.08.20.31.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Feb 2023 20:31:16 -0800 (PST)
From:   Trevor Woerner <twoerner@gmail.com>
To:     linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v2] dt-bindings: gpio: nxp,pcf8575: add gpio-line-names
Date:   Wed,  8 Feb 2023 23:31:00 -0500
Message-Id: <20230209043100.1508-1-twoerner@gmail.com>
X-Mailer: git-send-email 2.36.0.rc2.17.g4027e30c53
In-Reply-To: <20230209041752.35380-1-twoerner@gmail.com>
References: <20230209041752.35380-1-twoerner@gmail.com>
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

The family of PCF857x-compatible chips describe 8-bit i2c i/o expanders.
Allow the user to specify names for the 8 gpio lines.

Signed-off-by: Trevor Woerner <twoerner@gmail.com>
---
changes in v2:
- the original said [PATCH 1/2], there is no 2/2

---
 Documentation/devicetree/bindings/gpio/nxp,pcf8575.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/gpio/nxp,pcf8575.yaml b/Documentation/devicetree/bindings/gpio/nxp,pcf8575.yaml
index f0ff66c4c74e..81b825a4353c 100644
--- a/Documentation/devicetree/bindings/gpio/nxp,pcf8575.yaml
+++ b/Documentation/devicetree/bindings/gpio/nxp,pcf8575.yaml
@@ -39,6 +39,10 @@ properties:
   reg:
     maxItems: 1
 
+  gpio-line-names:
+    minItems: 1
+    maxItems: 8
+
   gpio-controller: true
 
   '#gpio-cells':
-- 
2.36.0.rc2.17.g4027e30c53

