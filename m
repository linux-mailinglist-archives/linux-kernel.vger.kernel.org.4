Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 067F46EB4CB
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Apr 2023 00:32:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233859AbjDUWcA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 18:32:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233848AbjDUWbx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 18:31:53 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D01472D52
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 15:31:48 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-94f1a6e66c9so372634966b.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 15:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1682116307; x=1684708307;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZkjYt4mw101Fn1FDm2krRVM0ItuEL6OGEkn3fLZXgCE=;
        b=rfeh0H18X+JG11bS/C3nMsf+iCZrRjOckBqyn6Upmoo1n5cIIOhuJABGjaX7+jZy3F
         SVHKjS15YQhH1pA7tkBHvhZILkgiTaViDY4crbK6yuO9Kj/R1Li9dAUKZ/EKXjOi/LK0
         MzYHcD2QMP042hLaGVy1s4/LKcsfiScH8GVzE4dRFpVticMzYUGp/qa5zlxg4Jx9jIs7
         BCk4nhuVI1nhwHPR1vKfwgaIz+Dibv9te9Vg7stmTUjZVZOTJVZQNnSevnVl9eZzUigN
         7iihnYTUuAXC0tVjPQpwxzwU3joqrw+pRD9WmzslETYW3BMG+zgexT7RkQ9dai+WwkJO
         2+aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682116307; x=1684708307;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZkjYt4mw101Fn1FDm2krRVM0ItuEL6OGEkn3fLZXgCE=;
        b=kNBLzplWWmiUCDHePRZpPhQOl1TS2DqEdzNQWdheDuYUbDAS1QWhFsKkMS49ZwUat0
         D8x1SlM470R3XeX9GCBs1BdWDJxA2nlBlrzKWOnNtgocbC6X5w82M5JPQY+9w9HR8J35
         OUj5JylVItTV69sYmKLQzD84TBe2k5ESM69QLjh9otRQgtgsTe01HBE8K3RlhkcWc3Mm
         fXKpbD02zBJkiHpGQRYMXwB8/GQEyddMabCGKGNHBKLoVISekgV8MNr1GfdxzeoUfwAI
         9XClWbc/++86xyCS/XsDNLoRV+NvJVcYja/x5AjMGcD4oC8++catr8UtuMh8XYhEO1xi
         8QPA==
X-Gm-Message-State: AAQBX9dALNCz5y0KPPJVBceMq7Y2jbXozi/8L38Gz0syL2gXDKI3ra/9
        NuYraTpMgFF69pM4jAHndZEl7w==
X-Google-Smtp-Source: AKy350Z68GLkomNSitCwgRxFlKgEdwjwd4Sxn9PniDZWQAA2CHpywEyTxO4nx7VxYxMbaN5P4DlWng==
X-Received: by 2002:a05:6402:187:b0:508:3ff8:afe7 with SMTP id r7-20020a056402018700b005083ff8afe7mr5826520edv.6.1682116306919;
        Fri, 21 Apr 2023 15:31:46 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:687d:8c5:41cb:9883])
        by smtp.gmail.com with ESMTPSA id n20-20020aa7d054000000b004fc01b0aa55sm2292882edo.4.2023.04.21.15.31.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Apr 2023 15:31:46 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Jisheng Zhang <jszhang@kernel.org>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] arm64: dts: synaptics: add missing cache properties
Date:   Sat, 22 Apr 2023 00:31:45 +0200
Message-Id: <20230421223145.115129-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As all level 2 and level 3 caches are unified, add required
cache-unified and cache-level properties to fix warnings like:

  berlin4ct-stb.dtb: cache: 'cache-level' is a required property
  berlin4ct-stb.dtb: cache: 'cache-unified' is a required property

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Please take the patch via sub-arch SoC tree.
---
 arch/arm64/boot/dts/synaptics/berlin4ct.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/synaptics/berlin4ct.dtsi b/arch/arm64/boot/dts/synaptics/berlin4ct.dtsi
index dc12350b9fc8..53d616c3cfed 100644
--- a/arch/arm64/boot/dts/synaptics/berlin4ct.dtsi
+++ b/arch/arm64/boot/dts/synaptics/berlin4ct.dtsi
@@ -64,6 +64,8 @@ cpu3: cpu@3 {
 
 		l2: cache {
 			compatible = "cache";
+			cache-level = <2>;
+			cache-unified;
 		};
 
 		idle-states {
-- 
2.34.1

