Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C24A703203
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 17:58:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242460AbjEOP6B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 11:58:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240334AbjEOP5z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 11:57:55 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA6D026B9
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 08:57:51 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-50bc040c7b8so19609279a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 08:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684166270; x=1686758270;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=N44qBs+/LT+cRlOP5z8nHjZf1DtaB9wj003fafSrmqs=;
        b=EpTkWaQ1fCz5WVnLJRhuCVM58P3m2LJ9vsvcYlBxjHIoXkQDTbMD0+kPBFJcQmvOoL
         O6WRsD6awQcp2u05901XRiRVTxd7oGtlaAPCRYP5Zj2RKd9wm+m9WLuFpO3VFtJ/8xgw
         L5lWMK5UD6n7r4k9t/CkllKxqoyhdiCVgMTPiYnKCkx6nv3zWE+FAA0yRA7aQUQhyy5W
         edXilxKMV8Flh/y+sik6OXxI8bic9gshFnxYgT/tSJSvan7xJXMHDgBDdhDfnIVKZ0d3
         C7syKvkQEtfo5pbZXkLYKw1Rp/VPKxzLvpfN5wu9P1q4uYElM6uQW5WN6dILOvtp3SJa
         1pew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684166270; x=1686758270;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N44qBs+/LT+cRlOP5z8nHjZf1DtaB9wj003fafSrmqs=;
        b=WEWgWZpE8Rfdyj9yoQ8oU4Or3qd6w6VA9cYjx4naypgcapNKe1wt4ROHn27QmuXnF2
         fDFegkcHAlijYnyZK8nzupEvsVgfEMm22oYsY6sabyYfG/IruTmXSx/nXfCmP5eO+c5i
         ttCuc8PEGLfFUcoHVL6+gjP15nvRicJZGjmf7UwtVvW5txgGKuOMmveZx9ztk0bRZci9
         slF/2eT8Dhz/sbbuVKKWpbzP8mNH3NdmdjhAhDlPpp6zFQ4lYNNxjQQb+RS/AUqlICqt
         qiYK3SYjEBLx7vtixeaauK4r9mcw7uEvJVmB6pppd+ejuyNWsCuX8c7po+7iAZ+v0e7o
         VzNw==
X-Gm-Message-State: AC+VfDxAaKqX2+www3jcMKtaW8PjZ2BD/g9a686cpJXz31GJJmrOC6N9
        OD/5ruxz657EIMHnNP7G9e4TRw==
X-Google-Smtp-Source: ACHHUZ7NT0Y5GoL/YpdcQtWvtqFV+rnrFZAUKYumGeb7FEoYpZ3FAe+d8ZwLsbJmsLDK47ObaroKbw==
X-Received: by 2002:a05:6402:160e:b0:50b:ca4a:8451 with SMTP id f14-20020a056402160e00b0050bca4a8451mr26810793edv.14.1684166270112;
        Mon, 15 May 2023 08:57:50 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:6470:25b8:7c2d:1992])
        by smtp.gmail.com with ESMTPSA id r16-20020aa7cfd0000000b0050bd245d39esm7506574edy.6.2023.05.15.08.57.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 May 2023 08:57:49 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andreas Kemnade <andreas@kemnade.info>
Subject: [PATCH] dt-bindings: vendor-prefixes: document TeeJet
Date:   Mon, 15 May 2023 17:57:47 +0200
Message-Id: <20230515155747.499371-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document TeeJet vendor prefix (used in am3517_mt_ventoux.dts board).

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Cc: Andreas Kemnade <andreas@kemnade.info>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index c3d426509e7e..5258090e2e02 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -1341,6 +1341,8 @@ patternProperties:
     description: Technologic Systems
   "^techstar,.*":
     description: Shenzhen Techstar Electronics Co., Ltd.
+  "^teejet,.*":
+    description: TeeJet
   "^teltonika,.*":
     description: Teltonika Networks
   "^tempo,.*":
-- 
2.34.1

