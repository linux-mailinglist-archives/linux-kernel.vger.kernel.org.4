Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 997D368BA17
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 11:28:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230420AbjBFK21 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 05:28:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230398AbjBFK2T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 05:28:19 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C94B7193E1
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 02:28:18 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id f47-20020a05600c492f00b003dc584a7b7eso10380311wmp.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 02:28:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ezl79ZrFtdgcZgpVVd2789IBH+ROi3SQvtmwb7LRshQ=;
        b=UNSfkNUHP69hesTqR03SnzmbojA+Dmgg4kFifjECdA+/zclot7jct5bEoB0o2rAyzz
         A/Wn4n1qMbD1cU5TaYpAJJp1ypoLYf6Re4N3NdRQAK5FmXRJ8fsjPVI8B+rIHuFwoTzp
         mmCIUi9+jIhNWqklzc078GzqNte0Ujmvb7tJMJAlhvQ74absFMsolncO6IbnuBpLsLwl
         qcYmsM6gZtUwjo0RnpXd1DiX5EjbwSQl6SmKJ5oTqXCd5HjtJJWmGiOL09gOTazYgdy3
         /zsRi+OFXT4EOv6RGdiowz3vo9RSCaO6Rg36EUK5wXMLFj68itIM16PSdHiIiQ7CNf1J
         MFEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ezl79ZrFtdgcZgpVVd2789IBH+ROi3SQvtmwb7LRshQ=;
        b=ZoYYTE8kF/7A/LEzC06h73NdTf02yedx2y/TdByULNAsE/MWCAC7P+9cbiy66243n+
         rqIeJOQbwQy7mRzz6RynfWFkn3Ydqht3lk/Pif0vQ/VtF3p1c4xhLL2VNvTAYSK01g/K
         lAGRZp5QmkEIyzaKYdrqJuGTQFTYUSVTymdaOgBi7SpmD1KJcZyZ+LQLHxRW6AyZbRh7
         3gjLdIFLzeOuyzF2nRFfiaCCLfWt8cnqN7+fozigk258UmCGvxvrPBQ6q7mZF0dribIC
         M+kdpsjkmlq7Ag9oGZea7Y4kAw+M+YpfCPIYWyleAZ++ozD19Gor1iEIZvbkSV1MOYTJ
         pqJQ==
X-Gm-Message-State: AO0yUKX/th9UlegSdvi0EqeBVc+sWVexcJQavFzcTcFMCYTYMH9skFYS
        LO8dOD0HiDJz1Svc5Xclmsf+Aw==
X-Google-Smtp-Source: AK7set9JpPzjJsoz9IO77uoRNncjB79BlEZMvBc9rjjA0hiIKvyxI3lCbDAcYmVa6X82AUFJC9dw4w==
X-Received: by 2002:a05:600c:3ba5:b0:3d3:4007:9c88 with SMTP id n37-20020a05600c3ba500b003d340079c88mr298709wms.18.1675679297369;
        Mon, 06 Feb 2023 02:28:17 -0800 (PST)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id g10-20020a05600c310a00b003de77597f16sm11002446wmo.21.2023.02.06.02.28.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 02:28:16 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Marijn Suijten <marijn.suijten@somainline.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [RESEND PATCH 03/37] dt-bindings: nvmem: Add compatible for MSM8976
Date:   Mon,  6 Feb 2023 10:27:25 +0000
Message-Id: <20230206102759.669838-4-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230206102759.669838-1-srinivas.kandagatla@linaro.org>
References: <20230206102759.669838-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marijn Suijten <marijn.suijten@somainline.org>

Document generic QFPROM compatibility on MSM8976.

Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml b/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml
index cc39514e8c84..48cfec0c9ece 100644
--- a/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml
+++ b/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml
@@ -21,6 +21,7 @@ properties:
           - qcom,ipq8064-qfprom
           - qcom,msm8916-qfprom
           - qcom,msm8974-qfprom
+          - qcom,msm8976-qfprom
           - qcom,msm8996-qfprom
           - qcom,msm8998-qfprom
           - qcom,qcs404-qfprom
-- 
2.25.1

