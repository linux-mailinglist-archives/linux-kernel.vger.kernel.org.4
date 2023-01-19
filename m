Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9C41672FC9
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 04:54:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229915AbjASDx1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 22:53:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbjASDmT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 22:42:19 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 362E66CCE9
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 19:40:08 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id 207so522100pfv.5
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 19:40:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pensando.io; s=google;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xYpFuG7rsB150mQqKa3m6yy9plhtCt+6ntf6ZKE6kws=;
        b=fXT7KGLDxcy2HX2T5nggcNCeQd1iYbyc8TVLnQKtTHOPV2VmStrOFWCPJj38WnpY3W
         ryKHVHIOFfH02a7eEfoUqjfjSBcUDyOIAkKP8PjbsdIupndv/Iov1dBL6fGT+pgkCYy3
         GiTPUytiZQwXxfabJNiHklmp7MXi50+pYIT9oNhUh9M9v0FfIrkFVe645HFnLl2GUVp1
         7ZYQFkB9pCcIdp07Q6ZZHtO7sb2Ap36rqOEHLDQlA0zNfq4D423PBQ/CHQssJhurai3+
         NAByR0TuEVKDf53jsiayBQONSZ9mVldzZcp1EIvRabg4neR/7E9KIonKcrcC7kjLe7tM
         atFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xYpFuG7rsB150mQqKa3m6yy9plhtCt+6ntf6ZKE6kws=;
        b=cigumNVoJ2aJowHzTE7gISjjH1QfC5AEl/ncmB7muno40KpoNaSwGXZ9QaDM5+mu8y
         balHZTb6DWnCV6XLp8jN331q6tTSX9VImBexgtSD4pj8frvlqC3JgyuFT5YdA6Qa5Bsd
         zxSFrUCgQAxoBZZLpQdzpmy9jIp1NC2dx3o6bPMHF/JooY6KUCzVlk1R1FDdv1ZusPCx
         EPo5ImfdBhOALU8pTzD7Qu0ljyc5XIW7/9mmioaRMx3VUq46mlsnDvxA6i6q9Xv6m4rC
         sfz1GnnHWEwyxNeYAeNyyCQGc/A/4NUH8iJLukrpgOPPRIr7uELeVh71dsTEiWYLrFSA
         KD3w==
X-Gm-Message-State: AFqh2krWo4jS6LxqvFl9nv1ccHoZArHBN5G7YStPqHkvPQkAjgTMtkDs
        CE+L9gdgb/0trJQMstezjzedkg==
X-Google-Smtp-Source: AMrXdXtJq4GAplJ+2gspI2mSfbNVQ2Icv7j240rdu74ICuoFTk1+eFoiULcymtV1EnrbrIvrRi0jZA==
X-Received: by 2002:aa7:85c4:0:b0:58d:bb58:e928 with SMTP id z4-20020aa785c4000000b0058dbb58e928mr9139648pfn.32.1674099607772;
        Wed, 18 Jan 2023 19:40:07 -0800 (PST)
Received: from platform-dev1.pensando.io ([12.226.153.42])
        by smtp.gmail.com with ESMTPSA id f13-20020aa7968d000000b0056b4c5dde61sm11097879pfk.98.2023.01.18.19.40.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 19:40:07 -0800 (PST)
From:   Brad Larson <brad@pensando.io>
X-Google-Original-From: Brad Larson <blarson@amd.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-spi@vger.kernel.org, adrian.hunter@intel.com,
        alcooperx@gmail.com, andy.shevchenko@gmail.com, arnd@arndb.de,
        brad@pensando.io, blarson@amd.com, brendan.higgins@linux.dev,
        briannorris@chromium.org, brijeshkumar.singh@amd.com,
        catalin.marinas@arm.com, davidgow@google.com, gsomlo@gmail.com,
        gerg@linux-m68k.org, krzk@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, lee@kernel.org,
        lee.jones@linaro.org, broonie@kernel.org,
        yamada.masahiro@socionext.com, p.zabel@pengutronix.de,
        piotrs@cadence.com, p.yadav@ti.com, rdunlap@infradead.org,
        robh+dt@kernel.org, samuel@sholland.org, fancer.lancer@gmail.com,
        skhan@linuxfoundation.org, suravee.suthikulpanit@amd.com,
        thomas.lendacky@amd.com, tonyhuang.sunplus@gmail.com,
        ulf.hansson@linaro.org, vaishnav.a@ti.com, will@kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v9 04/15] dt-bindings: spi: dw: Add AMD Pensando Elba SoC SPI Controller bindings
Date:   Wed, 18 Jan 2023 19:39:07 -0800
Message-Id: <20230119033918.44117-5-blarson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230119033918.44117-1-blarson@amd.com>
References: <20230119033918.44117-1-blarson@amd.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The AMD Pensando Elba SoC has integrated the DW APB SPI Controller

Signed-off-by: Brad Larson <blarson@amd.com>
---

Changes since v6:
- Define property amd,pensando-elba-syscon
- Move compatible amd,pensando-elba-spi ahead of baikal,bt1-ssi

---
 .../devicetree/bindings/spi/snps,dw-apb-ssi.yaml   | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
index d33b72fabc5d..96b072835de0 100644
--- a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
+++ b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
@@ -37,6 +37,18 @@ allOf:
     else:
       required:
         - interrupts
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: amd,pensando-elba-spi
+    then:
+      properties:
+        amd,pensando-elba-syscon:
+          $ref: /schemas/types.yaml#/definitions/phandle-array
+          description: AMD Pensando Elba SoC system controller
+      required:
+        - amd,pensando-elba-syscon
 
 properties:
   compatible:
@@ -63,6 +75,8 @@ properties:
         const: intel,keembay-ssi
       - description: Intel Thunder Bay SPI Controller
         const: intel,thunderbay-ssi
+      - description: AMD Pensando Elba SoC SPI Controller
+        const: amd,pensando-elba-spi
       - description: Baikal-T1 SPI Controller
         const: baikal,bt1-ssi
       - description: Baikal-T1 System Boot SPI Controller
-- 
2.17.1

