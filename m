Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FDDD6422C5
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 06:36:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231573AbiLEFg2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 00:36:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231199AbiLEFg1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 00:36:27 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA41C1260E;
        Sun,  4 Dec 2022 21:36:24 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id q1so9536047pgl.11;
        Sun, 04 Dec 2022 21:36:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NyezxOLPpgI0ujPJLu0RSoByClkj6oV1IvI/jxTrBZc=;
        b=ZYuUab64tcyq1qkg64/PsE0wdDNYnQUXsueFA8yfzqG3oCtqZXJxKarIXBNx4EOGUm
         K3wU+BpKtkLV4EfcKpBe+nTQkfgAdRzMu6vHj/ULNQMDFMyvVU4NfbVGDZwKZrcR1fAq
         n02rsk8geFrVxp7QsdWt7RVKICX0PfYciUzZ5OqvttLrKNqV/0OBDjJq19zb2VNjtM++
         qTDJIwGYL6hq3u6BcFdMaPrcAcJxvUG8XGcdLhoUzXvEU73Ov0ZyeY+Sd9OCqkoXYmox
         1YhICvMbNINx0ypSEFo+qx4GPdzGpbWnnTX+3xFVVOURcAi1rbbYOAGK49VnPPjHQXkX
         lRMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NyezxOLPpgI0ujPJLu0RSoByClkj6oV1IvI/jxTrBZc=;
        b=tEVs4DsX384X4i/ARsYgJoNKMP8YKyAHDK23cmlentwz8YQ2FZmI8QxS3ybcH4yeQz
         DPbacLxEGrCP35YRqhSsulig/W75talazl0hwk8fFnyPhI3Hv8m0vXdauGvpkN7Bd3oF
         EqyN8ymNxATJXSKV0DO/7GGS5dCzqubcOxN5Hke1rfQnY/USRusjtPZgEp1cNP652uw0
         asshOg+ZF9dxS3BVIERgmmTYT6VUBNJZ9Gttg+X0syC67EbtSWOnSXj/f+IY00C7HvbW
         0uSruVXMf9I0y/D8H4zZMvKkfsyMqz5W2lmxcQyD2yFKppZuq7wnU3/Gi7dr83WCUFQX
         oiyw==
X-Gm-Message-State: ANoB5plAEIZVCHKGcH0nAnElcTowv6fTq96LkEumUDz5vQBz4HDAF/Os
        b0JWdGaV+e6LWoN0pzlmiEKnYJJSbqc=
X-Google-Smtp-Source: AA0mqf76P7RH4HeKIUnzaiYmQ7/o2npNmXtEBqBzpZMB4qFCVDbhJEGMHqYA6VmhB0fiHk4LsGNIIg==
X-Received: by 2002:aa7:8c54:0:b0:574:2f5a:18d0 with SMTP id e20-20020aa78c54000000b005742f5a18d0mr58443701pfd.23.1670218583965;
        Sun, 04 Dec 2022 21:36:23 -0800 (PST)
Received: from localhost.localdomain (2001-b400-e2d4-7fe5-c00b-8015-d148-489d.emome-ip6.hinet.net. [2001:b400:e2d4:7fe5:c00b:8015:d148:489d])
        by smtp.gmail.com with ESMTPSA id b14-20020a17090a6ace00b00218e8a0d7f0sm10079693pjm.22.2022.12.04.21.36.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Dec 2022 21:36:23 -0800 (PST)
From:   Owen Yang <ecs.taipeikernel@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Gavin Lee <gavin.lee@ecs.com.tw>,
        Doug Anderson <dianders@chromium.org>,
        Abner Yen <abner.yen@ecs.com.tw>,
        Matthias Kaehlcke <mka@google.com>,
        Stephen Boyd <swboyd@chromium.org>, Harvey <hunge@google.com>,
        Bob Moragues <moragues@google.com>,
        Owen Yang <ecs.taipeikernel@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH v15 1/2] dt-bindings: arm: qcom: Add zombie
Date:   Mon,  5 Dec 2022 13:36:14 +0800
Message-Id: <20221205133603.v15.1.Idfcba5344b7995b44b7fa2e20f1aa4351defeca6@changeid>
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

Changes in v15:
- None.

Changes in v14:
- None.

Changes in v13:
- None.

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

