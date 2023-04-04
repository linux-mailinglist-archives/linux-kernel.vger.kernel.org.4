Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8F6F6D6A78
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 19:24:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236229AbjDDRYI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 13:24:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236170AbjDDRXd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 13:23:33 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07B714EE8
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 10:23:01 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id y4so133662070edo.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Apr 2023 10:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680628979;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=37bCZm+jxTgsQHpxPJv4TAzYWO4tswcf/EDoUUR8XkY=;
        b=xgVjB+u9yK4UUU/QzhdxLC6mAlpp4wEOaFqzSmR3BgD1tnM2ORred3Nxpupt/VAs+/
         flP7G9bBAtILPb54iqBs/7fMxaQhaCrg37TazSDjiz8tYSc4pVBxd9Gs2DAL37InBECr
         3PycCyb2LHQrpmPl/e4V/gKNL6yFfuz/9ipW5PdNfwUqAjYNfl+4Hyt1wi/0TSHm5KwI
         Bi78dNSjiCvZ0U27Z8nNBBQuoN0npEuY9tWfyPPp50FdzxNBLmZBUYK+6acM378o71Xe
         1R/nFNCiIhRiczr+bWym+5XOpf7Dh2I1wC9YJ8NQexzl4bP1KuBg3mDdVwPJnQszgDeR
         WErQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680628979;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=37bCZm+jxTgsQHpxPJv4TAzYWO4tswcf/EDoUUR8XkY=;
        b=OyK+W03glAYz26y2qYLqfvFAZOF6raf/uG68qvTKDJA7ia8nzvGZqcFfayk8SGoNoQ
         /6eWAGwfxP/iTCvfTFQuFJi1sJt3hPhyKKZg82SYHsIzz5VhcgnMZ5+jlc/6DcdaT7qm
         dyd+V8DttwDlyKYonDteBaNCTVXWQ6kt9PhQ7Ljz0HCklmY9Iluk5JAuvKVX4bUrW2u3
         nDsTO1iuh/DocEmpk9Gk1HWrvNqmh2bhiA6wj63nSbdsG+FrHfG/Yl0dVqauP4K3mWxL
         DIaBmlbAGAhsOQhDyKRpCmQyC9iAZRb7rGLbImDPS8cL/KqnCnHGbjQgKIBp+D7gwKDs
         H9ew==
X-Gm-Message-State: AAQBX9ezLGzkdP0QAWnZ1/OzkjxDOjLtjXRT50uruSs6MPaddDSDX7Fk
        a2iYf1o9oQZIuffO6rtpYP0yYwZrC80nOwBsF20=
X-Google-Smtp-Source: AKy350Z/5JgVle7I7asDwRm9CSooysobkdscF8Oqz9hq9AAJ7HWH8BEo4q+KPlJXgnFcFCc/gnqsDg==
X-Received: by 2002:a17:906:ae8d:b0:947:d43f:8f06 with SMTP id md13-20020a170906ae8d00b00947d43f8f06mr301645ejb.27.1680628979476;
        Tue, 04 Apr 2023 10:22:59 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id bv20-20020a170906b1d400b009447277c2aasm6208333ejb.39.2023.04.04.10.22.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 10:22:58 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 26/40] nvmem: stm32-romem: mark OF related data as maybe unused
Date:   Tue,  4 Apr 2023 18:21:34 +0100
Message-Id: <20230404172148.82422-27-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230404172148.82422-1-srinivas.kandagatla@linaro.org>
References: <20230404172148.82422-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

The driver can be compile tested with !CONFIG_OF making certain data
unused:

  drivers/nvmem/stm32-romem.c:271:34: error: ‘stm32_romem_of_match’ defined but not used [-Werror=unused-const-variable=]

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/stm32-romem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvmem/stm32-romem.c b/drivers/nvmem/stm32-romem.c
index ba779e26937a..38d0bf557129 100644
--- a/drivers/nvmem/stm32-romem.c
+++ b/drivers/nvmem/stm32-romem.c
@@ -268,7 +268,7 @@ static const struct stm32_romem_cfg stm32mp13_bsec_cfg = {
 	.ta = true,
 };
 
-static const struct of_device_id stm32_romem_of_match[] = {
+static const struct of_device_id stm32_romem_of_match[] __maybe_unused = {
 	{ .compatible = "st,stm32f4-otp", }, {
 		.compatible = "st,stm32mp15-bsec",
 		.data = (void *)&stm32mp15_bsec_cfg,
-- 
2.25.1

