Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69532669C3A
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 16:30:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229437AbjAMPaq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 10:30:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230250AbjAMPaD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 10:30:03 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 999BA8BABC
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 07:22:39 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id f34so33577090lfv.10
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 07:22:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9GR+M9kwc8eT2cs2wW/CNkkocF5x7PXcufqp311RRzs=;
        b=kee0KnZBB5mlhKrW/FuLH+F/KJSsHDofE6f9UQzffSBP4ulfmnjhL4JKmXnaA0DcEs
         TtbdNp5/m+YNQ6Uy8+L6Qua8t1AIj4uLIi7k1i25v0gU4EcH/79FUx+ZRveThzbMRTjv
         himR+KdZNmsmlCyUnJ6koe4eYp8PeC6DjN2sXkH4lh7qtfA3Erp99ayshijaf9HQ/H7Y
         EbVZf9Hg6b2U2+fLNPKU7yD+dfI7FPd2bZfzWfwjZMTNjKnGR7O1CdVA0M7fJqY4hXm4
         mmJ1d17F8BUhH8ArcePVHQ/bVJECXkEpW8Z3Vve6zS4wg5gt0m2bIkThr+DL4+KlAgt/
         BIMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9GR+M9kwc8eT2cs2wW/CNkkocF5x7PXcufqp311RRzs=;
        b=Ujlxr46QZWQ7Amwp+6osRXtqiqtVhBeRiYDirfGt74ofRoPDefwd5Y/+OyLLrxXTyd
         NPbtfbmDanvrfMuz9QGH2691q2ZL+nFIiV9GRomQFl7CYGdvm8mws/z/SW1pV32kivfp
         lQ9Sez0EZeo4u74j+YueWIQkJX/3eEMOuVy/Dx+108x0WewT+l0lo+T+hUhNdeKM05Uh
         bFui6S5Mtkxyv+eYIQiBxtHjKH+DKTi2Q8nnz3QXVN2S3IkG33RUloMaxjikHf6ZRgLF
         6pQ5HM71jFGrh6m2i/L3FFtz2NmY9pk8aaDL7/9xdcfjXi5z8Ovn80LzJrmSaEk3kFy/
         aIjQ==
X-Gm-Message-State: AFqh2kppd1qJCto5k7RfluRFwE3lA+bhIz6U06xdh3NrqoLUUiIFjX0S
        ZQo7EOHmhCW9KOvf1JYV7BR06w==
X-Google-Smtp-Source: AMrXdXsmpGytuMFvVR1ENG/ufgf35vTcwd7b2GrTF6pZoJA4+hamriWabozyn/h59ja0tLIbQknZTw==
X-Received: by 2002:a05:6512:2395:b0:4cb:4344:a786 with SMTP id c21-20020a056512239500b004cb4344a786mr14051198lfv.20.1673623357997;
        Fri, 13 Jan 2023 07:22:37 -0800 (PST)
Received: from localhost.localdomain (abym53.neoplus.adsl.tpnet.pl. [83.9.32.53])
        by smtp.gmail.com with ESMTPSA id c19-20020a056512325300b004cb3d77a936sm3875440lfr.46.2023.01.13.07.22.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 07:22:37 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     marijn.suijten@somainline.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org
Subject: [PATCH 2/2] Revert "dt-bindings: power: rpmpd: Add SM4250 support"
Date:   Fri, 13 Jan 2023 16:22:32 +0100
Message-Id: <20230113152232.2624545-2-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230113152232.2624545-1-konrad.dybcio@linaro.org>
References: <20230113152232.2624545-1-konrad.dybcio@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_HTTP,RCVD_IN_SORBS_SOCKS,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SM4250 and SM6115 use a shared device tree and the RPMPDs are
identical. There's no need for a separate entry, so remove it.

This reverts commit 45ac44ed10e58cf9b510e6552317ed7d2602346f.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 .../devicetree/bindings/power/qcom,rpmpd.yaml          |  1 -
 include/dt-bindings/power/qcom-rpmpd.h                 | 10 ----------
 2 files changed, 11 deletions(-)

diff --git a/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml b/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml
index 633d49884019..5bb9f59d196f 100644
--- a/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml
+++ b/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml
@@ -39,7 +39,6 @@ properties:
       - qcom,sdm845-rpmhpd
       - qcom,sdx55-rpmhpd
       - qcom,sdx65-rpmhpd
-      - qcom,sm4250-rpmpd
       - qcom,sm6115-rpmpd
       - qcom,sm6125-rpmpd
       - qcom,sm6350-rpmhpd
diff --git a/include/dt-bindings/power/qcom-rpmpd.h b/include/dt-bindings/power/qcom-rpmpd.h
index 278de6df425e..2d22a36c682a 100644
--- a/include/dt-bindings/power/qcom-rpmpd.h
+++ b/include/dt-bindings/power/qcom-rpmpd.h
@@ -307,16 +307,6 @@
 #define SDM660_SSCMX		8
 #define SDM660_SSCMX_VFL	9
 
-/* SM4250 Power Domains */
-#define SM4250_VDDCX		0
-#define SM4250_VDDCX_AO		1
-#define SM4250_VDDCX_VFL	2
-#define SM4250_VDDMX		3
-#define SM4250_VDDMX_AO		4
-#define SM4250_VDDMX_VFL	5
-#define SM4250_VDD_LPI_CX	6
-#define SM4250_VDD_LPI_MX	7
-
 /* SM6115 Power Domains */
 #define SM6115_VDDCX		0
 #define SM6115_VDDCX_AO		1
-- 
2.39.0

