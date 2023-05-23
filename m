Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C861670D4BA
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 09:17:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235379AbjEWHQb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 03:16:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235427AbjEWHQQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 03:16:16 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A4871AC
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 00:15:58 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-30644c18072so4439535f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 00:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684826156; x=1687418156;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BIFzUJ/Fo8Ahtm/+Q0i0RdjV4Wsb9+gZKMClGpdw4TU=;
        b=y1pRU7i1YZlPtpVTMvlPg7VJjN5SENwi2EO1DAZDBQatuebpBOu+bvFsXCmpdIQ6e9
         2En8H8JNUeTFMDGTgtAPQ6eJHaBReX77CCJECOfqVoRMohVv6yVs9knWduoJBD+4tYqb
         krU4QFJWHqmQjTrHEVB718oUAE6igdkEWME90QzwkmQ/XcgkeBe5yy6azQ9XechYb5cg
         HGe0BhsyUdEWgRKaJaUMXtowhpmzVGYIU/gbVbHjypAUwLEBbeiKq428V5wQB5DtzVa6
         E0XoMPIGmj9Y3GRNOvFhPxQMGHKkXqY2rt6D3wJ6cx0yp3mrfoLEdRtRpHD8u5+3TIG4
         yzfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684826156; x=1687418156;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BIFzUJ/Fo8Ahtm/+Q0i0RdjV4Wsb9+gZKMClGpdw4TU=;
        b=iYG3eRJeM41yqDdZz4jRZfBZuzkvRfyZ4ti12QprKapAeZD7vVn9YaJHhVD4R9b2P2
         pOb2M33dsZS1vcI+JxqjHgZXnVf7z+6VR1trYNz2OXpZSpQCVM0AF83B6EhtQDqzlijo
         Y9LAD5hTo3IpnsFwF7O4k7hnM6TNyNiRMiOPNTITlZRwS57M6hlTn46SYcHzc3pmGEFt
         IbTTZ9jb1fPGQh8XXbnxE8iEw3xsE3sgGxHQE9tVtMO/8Y+KnufyNstkAyxi4U8+3Gjo
         U7qvLjaljf9Mty0Z1cC8ikY190vNh0UrtsYxujEPo+3PrV9RAj/1h6hkE5imRXdTXZ0L
         PQQQ==
X-Gm-Message-State: AC+VfDxAvUK7Rr7RDLqIAmf51hswQfsu0DpozTB8EzKhhaai/l4RhVOs
        AmFEi7NlwMdBWOO/Qq1aZAMQUw==
X-Google-Smtp-Source: ACHHUZ5swly8Ef9OlVNzaWFCSNvV/5xAtLoC4oKSesRPpd8XQCqS6VROE3AbYDBRqNj7UHKdNrz0Iw==
X-Received: by 2002:adf:ce08:0:b0:2f2:783f:ae4a with SMTP id p8-20020adfce08000000b002f2783fae4amr9255461wrn.32.1684826156668;
        Tue, 23 May 2023 00:15:56 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id x15-20020a5d490f000000b00306299be5a2sm10096239wrq.72.2023.05.23.00.15.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 00:15:56 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Tue, 23 May 2023 09:15:49 +0200
Subject: [PATCH v3 5/6] arm64: defconfig: enable FSA4480 driver as module
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230503-topic-sm8450-graphics-dp-next-v3-5-6c43d293995f@linaro.org>
References: <20230503-topic-sm8450-graphics-dp-next-v3-0-6c43d293995f@linaro.org>
In-Reply-To: <20230503-topic-sm8450-graphics-dp-next-v3-0-6c43d293995f@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=734;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=B3Sqs44Cj2/7LrYQ/8MFFmf/0AlhDqUQcfHJIvUSGLY=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBkbGgmrjeORaFDWpBBmGeK+GzFZuWvuDn0ehBtZ7qL
 bhu1YTaJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZGxoJgAKCRB33NvayMhJ0f4ND/
 wO1tb/ixvvyAtMGcDKbTh4uaw90aBRWSOLKwlB/y8Tfh7Xb5vTQJNWCZFT62V8jndi4xitBfuhvRL2
 3Wuuw10qxsbV1CTsRpCJDdgTCgwwmMQUqzlgFVFs9fhR0mfbsueWV5SlSi4FnoqVAx/2ljS1G2g8MA
 4vaDc63w3gHc6rbGGz5fTObpdKn6nPHg0cM1ZHTVqte57VxiNqUU1CJN4lvye6/JI6+/82yOFepX65
 y4TdaJECEa5hRYJnPRrsUZ49r7ps34N47RVyxM5Fs/M8YS+aeopKMds3XM5kDWAdzC8KH4t4VWJksb
 VxhPpxvsAhvX0TC9ea81lhblZJnj0D8vU2fLXi7RYRRhpScVF05Hit9009yPnsunJfUABswgYPueTv
 u+3yeZj2IJl80Cc56pcefuMj9O9MT08B0W6WZjlk/KyzPcXvaID6WW9bAfv4IcTihByNXovi6HLjQK
 e63YkRFGhVnHwYmxAnvnUSch75rRBelMGoGQpZVMKfSgof/1F2o5P6lfPkK9LGwkMqBMM+JXl4xA3c
 Th+j0PRp8KzpJidaFjdxwcKUOhklbZtj0Ii5ZVze+2SzzOl7DZ928rD6QmbQPxCloy3JOFA3bdcZ0l
 5XA/6loF1hXjZqGCvTxYhoFfAeGA9Zh9Alw0L0FKua2nPkIcD91YGCDAkBOQ==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable the FSA4480 driver as module for Qualcomm HDK8350 and HDK8450
platforms to permit USB-C Altmode support.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 052e83197760..57ceb528426d 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -996,6 +996,7 @@ CONFIG_TYPEC_FUSB302=m
 CONFIG_TYPEC_TPS6598X=m
 CONFIG_TYPEC_HD3SS3220=m
 CONFIG_TYPEC_UCSI=m
+CONFIG_TYPEC_MUX_FSA4480=m
 CONFIG_UCSI_CCG=m
 CONFIG_TYPEC_MUX_GPIO_SBU=m
 CONFIG_MMC=y

-- 
2.34.1

