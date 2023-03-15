Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A59A76BBD77
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 20:43:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232009AbjCOTnQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 15:43:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230369AbjCOTnO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 15:43:14 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A837894A4F
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 12:43:09 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id i24so1345435qtm.6
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 12:43:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678909389;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ms61MPG4grbrr20EEED6cJ0Mv4lkKhi5d9EK9H3ZypY=;
        b=zNdlvKK2I7ZEzwLkENduEJjfo7YlDmbGRnwRCPz6us9u/51FjOo5YvV3aM8uCro7BF
         r0auxGnmk7QcnLWESZkQrXWCyHcvm/hYp1m4VDB7jzqSUEDbWriwJofHtlPGbMkmaHVg
         kUWGL0PRU9q5DDgwR+gjUDpBKsPzubknocExoiU/ytHSaomj3ZlPnYeafyVbLMWG9i6V
         wf4EAm77aP1gmKa5nUTSHHPre6pmm5lZWLWOG92hQy+uMIBY5Y35Ff0KuiYTJuIJTW9M
         8QpJ2+NjVe4etupf9QpEH/SVD3fAL5EUokXDL6br7fppWjwvq1J2PTCrBzX916VMiE6Y
         +fqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678909389;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ms61MPG4grbrr20EEED6cJ0Mv4lkKhi5d9EK9H3ZypY=;
        b=EPSRd/bMhP4YASiohCw1piy5PWdiW05sdHsBjOUG+6EdQSwiYkpYyH+Fsix5vP/TTN
         vTTr3rzM0ZaY3WT+4mymFVrPNBaJz089uy21MXWU31lrcm3mB2wnWRvZ4Mp7HTgBqjcK
         YCw89VPqqiO6zqY83CwAe9VblEAo7a9unQQn1AIKYYZ1VrygyHX2ppozS87qdN/P4Pfn
         7E73t+NlP5CYt6RZqxcf7HZjek5RPelviZrIjczNpK1TJ0IZPrPhKuujN8lKgIfESvqK
         qlfjBCGBUR1TyxeyzLajIzx0a7R8Z5kOsroCsaUyxcYcPH4GclheyD93fFFX3nniB/o2
         +32g==
X-Gm-Message-State: AO0yUKWHMnRZwLnjo9sEN+pIRKPvFg6xh38+j7bpDtt7QmNpIbsBxvsC
        OTTSwS0Ak+PaqEuiaIarHU/8IA==
X-Google-Smtp-Source: AK7set/x5UBMtqCy9v/PIxIZJDrWNhq9W52nDHQwWHAzKvFDSqNltXTu5PRSW6B1V9gpEkB6cDIQ+g==
X-Received: by 2002:a05:622a:1991:b0:3d6:43fc:2a52 with SMTP id u17-20020a05622a199100b003d643fc2a52mr1692100qtc.42.1678909388628;
        Wed, 15 Mar 2023 12:43:08 -0700 (PDT)
Received: from localhost.localdomain ([98.61.227.136])
        by smtp.gmail.com with ESMTPSA id g126-20020a37b684000000b00742a23cada8sm4246382qkf.131.2023.03.15.12.43.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 12:43:08 -0700 (PDT)
From:   Alex Elder <elder@linaro.org>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     andersson@kernel.org, konrad.dybcio@linaro.org, agross@kernel.org,
        devicetree@vger.kernel.org, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        elder@kernel.org, netdev@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Simon Horman <simon.horman@corigine.com>
Subject: [PATCH v2] dt-bindings: net: qcom,ipa: add SDX65 compatible
Date:   Wed, 15 Mar 2023 14:43:05 -0500
Message-Id: <20230315194305.1647311-1-elder@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for SDX65, which uses IPA v5.0.

Reviewed-by: Simon Horman <simon.horman@corigine.com>
Signed-off-by: Alex Elder <elder@linaro.org>
---
v2: Add review tag; base on linux-next/master; drop "net-next" in subject

It is my intention to have this patch be taken via the Qualcomm
repository (not net-next).

 Documentation/devicetree/bindings/net/qcom,ipa.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/net/qcom,ipa.yaml b/Documentation/devicetree/bindings/net/qcom,ipa.yaml
index 4aeda379726fa..2d5e4ffb2f9ef 100644
--- a/Documentation/devicetree/bindings/net/qcom,ipa.yaml
+++ b/Documentation/devicetree/bindings/net/qcom,ipa.yaml
@@ -49,6 +49,7 @@ properties:
       - qcom,sc7280-ipa
       - qcom,sdm845-ipa
       - qcom,sdx55-ipa
+      - qcom,sdx65-ipa
       - qcom,sm6350-ipa
       - qcom,sm8350-ipa
 
-- 
2.34.1

