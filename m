Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C10BC6EF13B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 11:33:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239936AbjDZJdo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 05:33:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240299AbjDZJdj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 05:33:39 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7997D1702
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 02:33:38 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id 41be03b00d2f7-517bb01bac9so4929183a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 02:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1682501618; x=1685093618;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uvPQ+p6p7LPXccnkrXRgDzY3F78Ex853x9Swf3yMEqY=;
        b=UN9smnlgDaW5ESWDJZoeDD7OlyBxrsIf28fmOhRxgm4lMwF6p8cR8ZIYRXZbuDIspr
         YybIhG7VpOorRriLB+GvVyUHM/p1Hb6FjJ+OLjzchNz19jZmWkbZgywjgs17uqCMeIlf
         fA4mCMYzACCi0X1GaK4qaVvMvfnlCYLoP87mI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682501618; x=1685093618;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uvPQ+p6p7LPXccnkrXRgDzY3F78Ex853x9Swf3yMEqY=;
        b=W2533xQljCVv5gB390zGF2Riw2/9JsKUD5CWemfD5RogpMpbLE7VvbRNr4dLapCdJU
         BOI+LZRLWytsjicLKL3Avb+q4FKBneiJKQwlFm1RFTy5NuF9vR1QmmZGQB9btndnR3+N
         fkHe2i7RA7PFwxcHoXl7vwowAeuzNimTMSjsZlJjrfC1L6NzyBz7/zYNFD3G6wMJcenM
         VU8H+ahdNfkj7WVFwS8BrbYKSNrIMAlG3tu6mXHb2JJVVxo9jEDgXOlep8eyRjn8abuV
         YP7Crtq4uH/ZkexXMSLXxtOOjISw+1PbYjareEElNfvFn+T/FbQnehfg3ae7ybm17yQG
         BhUw==
X-Gm-Message-State: AAQBX9eqQUx9cgiVb4uTwLg0NyqJHR7NuQMvtymshZtXUfB9w1YjbSHP
        qEDuFUXPU/8qV7QCc7szNyRuOA==
X-Google-Smtp-Source: AKy350YjtwjO/wAtSJ0FYazTCI27tdYfzjYulYfZEnuLWJzP+p7+c5W5QWYGIc03oOV+EW2KT9YN/g==
X-Received: by 2002:a05:6a20:7350:b0:f2:745a:b87e with SMTP id v16-20020a056a20735000b000f2745ab87emr22849547pzc.12.1682501617975;
        Wed, 26 Apr 2023 02:33:37 -0700 (PDT)
Received: from fshao-glinux.tpe.corp.google.com ([2401:fa00:1:10:dcf6:797f:140d:6d])
        by smtp.gmail.com with ESMTPSA id g1-20020a056a00078100b005810c4286d6sm10730075pfu.0.2023.04.26.02.33.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Apr 2023 02:33:37 -0700 (PDT)
From:   Fei Shao <fshao@chromium.org>
To:     Jeff LaBundy <jeff@labundy.com>,
        Douglas Anderson <dianders@chromium.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-mediatek <linux-mediatek@lists.infradead.org>,
        Fei Shao <fshao@chromium.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] dt-bindings: input: goodix: Add "goodix,no-reset-during-suspend" property
Date:   Wed, 26 Apr 2023 17:32:29 +0800
Message-ID: <20230426093231.1466984-2-fshao@chromium.org>
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
In-Reply-To: <20230426093231.1466984-1-fshao@chromium.org>
References: <20230426093231.1466984-1-fshao@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

To address that, we add this property to skip reset during suspend.
If it's set, the driver will stop asserting the reset GPIO during
power-down. Refer to the comments in the driver for details.

Signed-off-by: Fei Shao <fshao@chromium.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
---

Changes in v2:
- Use a more accurate property name and with "goodix," prefix.

 .../devicetree/bindings/input/goodix,gt7375p.yaml        | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/devicetree/bindings/input/goodix,gt7375p.yaml b/Documentation/devicetree/bindings/input/goodix,gt7375p.yaml
index ce18d7dadae2..1edad1da1196 100644
--- a/Documentation/devicetree/bindings/input/goodix,gt7375p.yaml
+++ b/Documentation/devicetree/bindings/input/goodix,gt7375p.yaml
@@ -43,6 +43,15 @@ properties:
       itself as long as it allows the main board to make signals compatible
       with what the touchscreen is expecting for its IO rails.
 
+  goodix,no-reset-during-suspend:
+    description:
+      Set this to true to enforce the driver to not assert the reset GPIO
+      during suspend.
+      Due to potential touchscreen hardware flaw, back-powering could happen in
+      suspend if the power supply is on and with active-low reset GPIO asserted.
+      This property is used to avoid the back-powering issue.
+    type: boolean
+
 required:
   - compatible
   - reg
-- 
2.40.1.495.gc816e09b53d-goog

