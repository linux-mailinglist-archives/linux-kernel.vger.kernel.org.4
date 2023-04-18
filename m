Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CA7B6E64A8
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 14:51:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232168AbjDRMvR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 08:51:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232169AbjDRMvP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 08:51:15 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3265716B14
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 05:50:53 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-63b5fca48bcso1709370b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 05:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1681822252; x=1684414252;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y4OHoFWLVHVOU1gGJFIZyvFQwj4I/n5rmO4u4kQqp5s=;
        b=NaZDAMGrk+xiKbfMXkfc+hiiltFD0LlTuSqiIbDBkpzWQgLVSgj/O48zJ7VMGlzp68
         pCDOEKpcmGwFU7dSgwQqjWorn5Z13vwzcfdi34+M2L5EwoQEbckdcNX1V9iuSn4j74qB
         2IMNQfjqpLvm8WWUqmBcV11cHsW5gXqch7xqo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681822252; x=1684414252;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y4OHoFWLVHVOU1gGJFIZyvFQwj4I/n5rmO4u4kQqp5s=;
        b=JHGaqnaUaIUY+bpfM77v6IZYCU14s+Xb5uRK+kA1vXfWx+QvBXUDkLyC/PM2ytxzEl
         jif4nHtKorcEsW8EBEdpE8H92XKB/3nvBjyW/OMWFUUFDhZRhk7D8eWwOshyOAWRXAgh
         SgAaS/bLh7ApzklDd6wkPf+U4XpmoNwQS/DkIcDjaLZr2Oevr8DeCa5jaysPtFFgoFy1
         K8+deOvjqf41jKeZgAraURKCySbmS5uaPCrb9937XdIbnXysmDXy28TKrv+I0ha5Cnc7
         mVOo9h+gMr67fKlBhXkGCV+mbL2bdlfjfpOwU8x3Hk4n4xLJjTLWGKgbCDWufa89Mokx
         tP/Q==
X-Gm-Message-State: AAQBX9dDOmZpIntqrP0ioBv/f2Z5LlX3pYOPobg63GhdFcf9Gny2ImeO
        35SkQJBt5ueODqLZ03ZSipJ7XQ==
X-Google-Smtp-Source: AKy350YD/mHUZFPaUut90TfJLzOLDCDlzOufYyFO14OjgVg1t2eEm+ULWpBI96mTSUIsyi0jY51ohg==
X-Received: by 2002:a05:6a00:1483:b0:638:f0b1:4df1 with SMTP id v3-20020a056a00148300b00638f0b14df1mr25744364pfu.24.1681822252585;
        Tue, 18 Apr 2023 05:50:52 -0700 (PDT)
Received: from fshao-glinux.tpe.corp.google.com ([2401:fa00:1:10:2fb7:301d:6083:752b])
        by smtp.gmail.com with ESMTPSA id v11-20020a62a50b000000b0063afb08afeesm9323733pfm.67.2023.04.18.05.50.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 05:50:52 -0700 (PDT)
From:   Fei Shao <fshao@chromium.org>
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Douglas Anderson <dianders@chromium.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-mediatek <linux-mediatek@lists.infradead.org>,
        Fei Shao <fshao@chromium.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: input: goodix: Add powered-in-suspend property
Date:   Tue, 18 Apr 2023 20:49:51 +0800
Message-ID: <20230418124953.3170028-2-fshao@chromium.org>
X-Mailer: git-send-email 2.40.0.634.g4ca3ef3211-goog
In-Reply-To: <20230418124953.3170028-1-fshao@chromium.org>
References: <20230418124953.3170028-1-fshao@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We observed that on Chromebook device Steelix, if Goodix GT7375P
touchscreen is powered in suspend (because, for example, it connects to
an always-on regulator) and with the reset GPIO asserted, it will
introduce about 14mW power leakage.

This property is used to indicate that the touchscreen is powered in
suspend. If it's set, the driver will stop asserting the reset GPIO in
power-down, and it will do it in power-up instead to ensure that the
state is always reset after resuming.

Signed-off-by: Fei Shao <fshao@chromium.org>
---

 Documentation/devicetree/bindings/input/goodix,gt7375p.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/input/goodix,gt7375p.yaml b/Documentation/devicetree/bindings/input/goodix,gt7375p.yaml
index ce18d7dadae2..942acb286d77 100644
--- a/Documentation/devicetree/bindings/input/goodix,gt7375p.yaml
+++ b/Documentation/devicetree/bindings/input/goodix,gt7375p.yaml
@@ -43,6 +43,12 @@ properties:
       itself as long as it allows the main board to make signals compatible
       with what the touchscreen is expecting for its IO rails.
 
+  powered-in-suspend:
+    description:
+      This indicates that the touchscreen is powered in suspend, so the driver
+      will not assert the reset GPIO in power-down to prevent power leakage.
+    type: boolean
+
 required:
   - compatible
   - reg
-- 
2.40.0.634.g4ca3ef3211-goog

