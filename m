Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C91DA63E8CD
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 05:13:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbiLAENT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 23:13:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbiLAENR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 23:13:17 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5807D1EAC6;
        Wed, 30 Nov 2022 20:13:16 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id s196so620663pgs.3;
        Wed, 30 Nov 2022 20:13:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QF2r6J7BAHI2Kf2K5YiTNrMP95FStPJT4HE2SBfjkZg=;
        b=p8EOD0a0qRqtBmYDlzyx5MLwTUf78uivg1uE6gVzSCMLOPPP8siMB0+mBFuikbCgCY
         xVjk9GetPcLBBluw300B4uizPm9IWMaCavlam76KizMrgSeXlQ75xdc5L7zWrN2D3Hry
         Du99VHdQYBR42UgTmEUgIHl6zJJm/UdmQML59NPpZ9nSql+tN6Hqxmx02G6WSLEZirUC
         KY7Rt37mBX3mU5miThIc9+kX2cpX8x1R4g4LcvQ4M9e8ePXvHW1OnykRrzfQ+Sh5rOsp
         dsFWAwbi0jWyDPi5nxJt2Tg73EnwEC9lLFCuplWEQOLHKHGkVZD+drXzGxOitzc/wBMa
         aIHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QF2r6J7BAHI2Kf2K5YiTNrMP95FStPJT4HE2SBfjkZg=;
        b=35C51f4dzSWZKwStQzY6p4IX3ASs1qBhSYOa0QQdBfpcA03xf+pqreabsTE1s23R/d
         8YQujd2MWcbiNbjZrQuqWLeNrYDZZfDs7HMHFWNSfLhqK/9EJkJyrReOyBKekv2EcIKJ
         6eglGkfvoJe0HJebmrLZn9cq2kpCcLJ8DNcQYVenWh/3fZyvQcmeMv6WaC4YMwy9HbbK
         urtxGrhy6agdzmA0hyoW+DkC8j+kR8pxWBluGd7wBJBY5mK/tVSQIVcrmr4mA1lvYbr7
         fPU55W3jVRwZ08Kz/7unkfJBkDogGtcvw93L2Rybeq4ia0IAApzQDJzL93QtbyYBiYLV
         Tu2g==
X-Gm-Message-State: ANoB5pn1vjoAeXlZV6ld4ej3DfGjSwhb9QaRMm07sW6bpZ4ofVhEE0ey
        Tjb1aUnlYw82mJDBKNym20S47N5Dyxc=
X-Google-Smtp-Source: AA0mqf5eJIs4nLzTq4V+fuC3ob9lkqYSL/s0HELaWVsbBCH/BB6f7kVPMCzPJsLO1KN92AIw8sBdTQ==
X-Received: by 2002:aa7:8c54:0:b0:574:2f5a:18d0 with SMTP id e20-20020aa78c54000000b005742f5a18d0mr41126814pfd.23.1669867995364;
        Wed, 30 Nov 2022 20:13:15 -0800 (PST)
Received: from localhost.localdomain (2001-b400-e2d4-7fe5-a80b-9fee-51f7-4bb8.emome-ip6.hinet.net. [2001:b400:e2d4:7fe5:a80b:9fee:51f7:4bb8])
        by smtp.gmail.com with ESMTPSA id ju10-20020a170903428a00b001782a6fbcacsm2321894plb.101.2022.11.30.20.13.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Nov 2022 20:13:14 -0800 (PST)
From:   Owen Yang <ecs.taipeikernel@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Bob Moragues <moragues@google.com>,
        Doug Anderson <dianders@chromium.org>,
        Abner Yen <abner.yen@ecs.com.tw>,
        Stephen Boyd <swboyd@chromium.org>,
        Gavin Lee <gavin.lee@ecs.com.tw>,
        Matthias Kaehlcke <mka@google.com>, Harvey <hunge@google.com>,
        Owen Yang <ecs.taipeikernel@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH v12 1/2] dt-bindings: arm: qcom: Add zombie
Date:   Thu,  1 Dec 2022 12:13:03 +0800
Message-Id: <20221201121235.v12.1.Idfcba5344b7995b44b7fa2e20f1aa4351defeca6@changeid>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add entries in the device tree binding for sc7280-zombie.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
Signed-off-by: Owen Yang <ecs.taipeikernel@gmail.com>
---

Changes in v12:
- None.

Changes in v11:
- Put all tags togather as As requested by Douglas.

Changes in v10:
- Add "Reviewed-by" tags in this patch log.
- Fixed history log list.

Changes in v9:
- Fixed version number (v7 and v8 were erroneously posted as v6)

Changes in v8:
- Correct commit log. Use "entries" instead of "an entry". As requested by Krzysztof, Matthias and Douglas.

Changes in v7:
- None.

Changes in v6:
- None.

Changes in v5:
- None.

Changes in v4:
- None.

Changes in v3:
- None.

Changes in v2:
- Fixed patch order.

 Documentation/devicetree/bindings/arm/qcom.yaml | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index 463509f0f23a..7ec6240311db 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -655,6 +655,16 @@ properties:
           - const: google,villager-sku512
           - const: qcom,sc7280
 
+      - description: Google Zombie (newest rev)
+        items:
+          - const: google,zombie
+          - const: qcom,sc7280
+
+      - description: Google Zombie with LTE (newest rev)
+        items:
+          - const: google,zombie-sku512
+          - const: qcom,sc7280
+
       - items:
           - enum:
               - lenovo,flex-5g
-- 
2.17.1

