Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD44F6EB4D6
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Apr 2023 00:32:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233930AbjDUWck (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 18:32:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232177AbjDUWcO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 18:32:14 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9D983C0D
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 15:31:57 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-953343581a4so311261366b.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 15:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1682116315; x=1684708315;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8Z57WYnQQP1HPZgtk587OfMPEiorkqcLq8WhGjDrtFQ=;
        b=Vsd54nlojsLlgVg83g7erP7SU0dhy/DTnazUDlps+y806zfOUbCKN3/WsNJoAyVC9I
         FIz5WO4bFvv1u0vu4Nenz7fDV+hhHAFgZ3jg4QjSaiZbr3NmKu87SEfZjGB1hpz4ryFG
         7xCqX92IdDJLIiglDQrJYS+XC4AeLrrJxSVoBGAuGgxkyi4o2IXzZEag4XGTr99kzzGc
         Mcweg98cjn2oO6SjRnJncDBA6SfeQ8tw0k4285j24NeZ1jZOnaIgZ5VoaZrejZfMBdIn
         bA+FCfizBtbfFBVoKyq5w78UALV81Z/RonANEBFubM4eDbbZCD3B3XkPju6dYMo0jD6Z
         aZUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682116315; x=1684708315;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8Z57WYnQQP1HPZgtk587OfMPEiorkqcLq8WhGjDrtFQ=;
        b=kTtll8HtxBL2ecIlIdLOiZx4L90JHFB0e4bXf/+9zZTkWPUfZOXnO4pcahIoXVMYDG
         bdF2osuUn4h5ttIHo0vwVpgNBxNNq54xQW/Hq4HEghu924hH8Ba3b0zwgsraMBqTn8eH
         ErOBdd8hyEATFDKWr+Mp4zBvP07ZzhUkqK9CG/5+AP35cYCeY1oCa+nJYODe+BByz/DD
         gmel8sgZ7J5TPp5ZpFQY5VTezUpejUX2DQHiN36hAj4zrg4l0HxLxbSwA4tUvUeLJXE9
         96tPIRym+BnB5kHDclcJrKEOzJ6YIhA7bgyXtKuq2CR2Q25HD/v8OwTA65ZaMfqZLWgB
         PsxQ==
X-Gm-Message-State: AAQBX9cOJuwrEzUpRX/w6XmEf6qlnU9rO87ylHkL7jeW+OYFI7LQVJ+k
        eOImDQkATWL6mcCX4lMyY2FrSw==
X-Google-Smtp-Source: AKy350aJx6f2WzN7HzQ2ivtM3burNpkS45X4pLMD7mtH9aU8+isiIBQ4kWt4oi1r2r6Tzg2eFaZe5g==
X-Received: by 2002:a17:906:f55:b0:94e:e5fe:b54f with SMTP id h21-20020a1709060f5500b0094ee5feb54fmr3520159ejj.23.1682116315690;
        Fri, 21 Apr 2023 15:31:55 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:687d:8c5:41cb:9883])
        by smtp.gmail.com with ESMTPSA id sd14-20020a170906ce2e00b0094f5d1bbb21sm2572367ejb.102.2023.04.21.15.31.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Apr 2023 15:31:55 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        openbmc@lists.ozlabs.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] arm64: dts: nuvoton: add missing cache properties
Date:   Sat, 22 Apr 2023 00:31:54 +0200
Message-Id: <20230421223154.115312-1-krzysztof.kozlowski@linaro.org>
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

  nuvoton-npcm845-evb.dtb: l2-cache: 'cache-level' is a required property
  nuvoton-npcm845-evb.dtb: l2-cache: 'cache-unified' is a required property

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Please take the patch via sub-arch SoC tree.
---
 arch/arm64/boot/dts/nuvoton/nuvoton-npcm845.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/nuvoton/nuvoton-npcm845.dtsi b/arch/arm64/boot/dts/nuvoton/nuvoton-npcm845.dtsi
index 12118b75c0e6..383938dcd3ce 100644
--- a/arch/arm64/boot/dts/nuvoton/nuvoton-npcm845.dtsi
+++ b/arch/arm64/boot/dts/nuvoton/nuvoton-npcm845.dtsi
@@ -49,6 +49,8 @@ cpu3: cpu@3 {
 
 		l2: l2-cache {
 			compatible = "cache";
+			cache-level = <2>;
+			cache-unified;
 		};
 	};
 
-- 
2.34.1

