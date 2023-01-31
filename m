Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71177682CA3
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 13:35:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231712AbjAaMfg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 07:35:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231303AbjAaMfd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 07:35:33 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C49237F19;
        Tue, 31 Jan 2023 04:35:26 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id z1so7366781plg.6;
        Tue, 31 Jan 2023 04:35:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=p3Bprh6qzi6N7O5JqZWzaWLkqDk7+Hs/nJb9oKk2rCs=;
        b=Qxp+RbCuOAmMF9JjQ+UQypcN6aXfqx66Bou0GHmm2nWOGeeVzhoKKs7NpSVLLgVo/2
         L45/OgdoBBBkwVbOVqlA9s8JMAFfy6FviT++JVIUSyZ8D+KuI/iMheytzplsjedXFQOr
         qxlqx7DW6ZbISA1TCJyXt0YXAokehOGs53J3C6hMwEx+0TpNnk3oEXMhvoKLg9hwVZuV
         ImHe0wYjUIVo3Zvq4X9X+TizGGi2BPi2IDrnAr82SvfwSbTRThjHhiZp6bruw8kodHMN
         igDB8EwyTk1Gso7QIK49ltx8y3eFaJgjLcrXaiCDs2WNNgB/TL7n1b+8jeCU7t1XyRW+
         kcgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p3Bprh6qzi6N7O5JqZWzaWLkqDk7+Hs/nJb9oKk2rCs=;
        b=4pQzXbWi0iUvfD/UUJ/zySgvXyBw63QrPfh0A3BXVSyCjLd0/wC5/g32ZrMfN4pQZj
         Scewrw5xrY1d0KQeo4RBkoPtOXBAWf4tJXdY1GHDTmM5sY5n4lisH4ViCq8fkth8yJX4
         ASrDuqQRcUJ/nbJ35sm/cVie495rhN6RoQtrU3J1s/+ATcMHuqJuHolWOuXfzYUojk4M
         7/P2uGJiQxAR6vTyd8tQ8uDyPggkV5l1blNsncSo4MDALvzqqchP5//K/dK1IPf5GRe4
         KDTO5ujC3XQRvtINBvMzteW/1t/wBpHqn3znKBL3i51K61xLTRi71szY4xiWnUKRnwXX
         o8sQ==
X-Gm-Message-State: AO0yUKWI2bNcyDRstPwUWCq10m4XkL4osEDOLMSNIY3ueea1KWRNJIMG
        338/shc3QNIJdXawyzuLvLQ=
X-Google-Smtp-Source: AK7set9meLUleoPPOYf2CHYo3cG+8acjn9MkDPxNVatdfbc06w9tOYQyqkqlBg1GBLUllXq6+pmRXw==
X-Received: by 2002:a05:6a20:1596:b0:b8:54a2:b8d1 with SMTP id h22-20020a056a20159600b000b854a2b8d1mr22995794pzj.57.1675168525734;
        Tue, 31 Jan 2023 04:35:25 -0800 (PST)
Received: from localhost.localdomain (n220246252084.netvigator.com. [220.246.252.84])
        by smtp.gmail.com with ESMTPSA id r19-20020a170902c61300b0018544ad1e8esm9692527plr.238.2023.01.31.04.35.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Jan 2023 04:35:25 -0800 (PST)
From:   Jianhua Lu <lujianhua000@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kees Cook <keescook@chromium.org>,
        Tony Luck <tony.luck@intel.com>,
        "Guilherme G . Piccoli" <gpiccoli@igalia.com>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Jianhua Lu <lujianhua000@gmail.com>
Subject: [PATCH v4 1/2] dt-bindings: arm: qcom: Add Xiaomi Mi Pad 5 Pro (xiaomi-elish)
Date:   Tue, 31 Jan 2023 20:35:14 +0800
Message-Id: <20230131123515.833-1-lujianhua000@gmail.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a compatible for Xiaomi Mi Pad 5 Pro.

Signed-off-by: Jianhua Lu <lujianhua000@gmail.com>
---
No changes in v4

Changes in v3:
  - Pick up Krzysztof's A-b

Changes in v2:
  - Move compatible "xiaomi-elish" down.

 Documentation/devicetree/bindings/arm/qcom.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index 22553637c519..398ff26e6e0e 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -875,6 +875,7 @@ properties:
               - qcom,sm8250-mtp
               - sony,pdx203-generic
               - sony,pdx206-generic
+              - xiaomi,elish
           - const: qcom,sm8250
 
       - items:
-- 
2.39.1

