Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65A7D72531D
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 07:00:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234485AbjFGFAj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 01:00:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234395AbjFGFAe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 01:00:34 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 743D31725;
        Tue,  6 Jun 2023 22:00:33 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id af79cd13be357-75ec541f933so10499285a.0;
        Tue, 06 Jun 2023 22:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686114032; x=1688706032;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l9dG+oN5uOmuQYXLewl1nCF0/Os/UQTTZl0+MY2RxWE=;
        b=SdrAJREOI+sSk3AZUFjzv72WSD27GpJcA1nyiB2724Og5P+HW5QX9Xqth8+vQZtcEz
         mSZ4whmu3dTlsuDUt1TwUohJ3ksU37hR2kVL6IXdIqh6PlQ4gPyNqgjgDlv7OfkscSUm
         XodMdWWWj3Uh04ktiIZZkgHQTmppAyN07Cd+5/DLQNtlQ6BGz15H6z3G7A6uNJIH841b
         vIHs/j1KCsJ3z5lPEU33IcI098Vh2VfnLR9/i2NOg2CZ/y5grw3UZh5Iza7ww6QfwgwR
         Wf58VXE+D11mgZ3zpK+hZer6i08ITs8T+HbD+adeHSdpXpd/5QXwSctLmGAn58wrUZfN
         A3cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686114032; x=1688706032;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l9dG+oN5uOmuQYXLewl1nCF0/Os/UQTTZl0+MY2RxWE=;
        b=WlHMl7gTmdwRmy5kFNuCzsdrVqXNgoLZk3H5XcBt/3L1D/tWd530OGNSVOi5JBE3py
         gjqQ1q1vqkQDpqu0tzl7o64lJjUIc1EelDjdg7ff0Vrj4J+jPGjqPf+aHlpHc/vNgCb/
         LbGnMroW8D98PAkFhM90VvQIVSfLKEN1xurrX8NlZzGQeZmDzbJRz3U4WfH7Xp6McmHI
         fzg1SqG/pIPshNfSUTUXkXmdJisp8yLJHh59yWF8wYkghtLDddOl4fJsFT6nv4JyG9aa
         uNBz+u1Fui/AxQdDJGTgRYrlPPNhQfjd3hXWJv3aZ4zPJ6gs6s5bv8RELWvSPrg4EMxV
         LfKA==
X-Gm-Message-State: AC+VfDzP3zmcqru2N6BY+L+Mz/8/ZLVPcjqNg6DZ2KcTn2eKvrF+Z4j6
        X1qwGTm6hW+LP6ZNw5pIX/0NZy4UtLD8hw==
X-Google-Smtp-Source: ACHHUZ5C7dMvWXGT3YbALPD4bql/TD9qfA1bGA2rfy9uV4o0Ujf1mwt/wVFq0zAMLR6tB3wYq6eQnQ==
X-Received: by 2002:a05:620a:888:b0:75c:ca53:d5fd with SMTP id b8-20020a05620a088800b0075cca53d5fdmr587802qka.27.1686114032458;
        Tue, 06 Jun 2023 22:00:32 -0700 (PDT)
Received: from Latitude-E6420.mynetworksettings.com ([2600:4040:2007:9800:c358:f4f2:89b6:ca7d])
        by smtp.gmail.com with ESMTPSA id m1-20020ad44481000000b00621430707f7sm5848980qvt.83.2023.06.06.22.00.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jun 2023 22:00:32 -0700 (PDT)
From:   Rudraksha Gupta <guptarud@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        soc@kernel.org
Cc:     Rudraksha Gupta <guptarud@gmail.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v5 1/4] dt-bindings: arm: qcom: Add Samsung Galaxy Express
Date:   Wed,  7 Jun 2023 01:00:20 -0400
Message-Id: <20230607050025.86636-2-guptarud@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230607050025.86636-1-guptarud@gmail.com>
References: <20230607050025.86636-1-guptarud@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a compatible for Samsung Galaxy Express SGH-I437.

Signed-off-by: Rudraksha Gupta <guptarud@gmail.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
 Documentation/devicetree/bindings/arm/qcom.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index d9dd25695c3d..133d69b2b73d 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -191,6 +191,7 @@ properties:
       - items:
           - enum:
               - qcom,msm8960-cdp
+              - samsung,expressatt
           - const: qcom,msm8960
 
       - items:
-- 
2.34.1

