Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA362727854
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 09:11:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235246AbjFHHLY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 03:11:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235284AbjFHHLR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 03:11:17 -0400
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [81.169.146.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F2021FDC;
        Thu,  8 Jun 2023 00:11:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1686208272; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=lg6Om4QDsNWs7+FmoQcziCTJNt5U599S2HuIu4zJaLFlBnfQdQT/955Z+4mKmBt5kh
    oYqvsSumL8qmZb+/NbJoJfug2LM05H13kfEfghOFulheg6tA1ol9iYmceq4RQ2sFdDuV
    B5lED/7td6WComqqIaIsQu/YrrIkmdrwZE1NxD/Xy22mhUPayO++N9NoghDiSeqNXzD/
    pP3IE8UPur6dSKUsYWmgvGacz/vJ/9CQtFUsswv0OInoLbntV3pwmLRw5Lm64M8HYj5w
    eybQ3NXj4ILey3ty3Pbew1l5WBk+OyLg1w67DZabdwgrWD+nTMyLI4X3W7aSGbaBlsIP
    bXog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1686208272;
    s=strato-dkim-0002; d=strato.com;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=zIP6Ad+n6GtTcdAN99toMZU1nMdvUwM/xKmNfiwoI/o=;
    b=H8oP07qbE+mBJJJzVh0Rn4FRDOviNnuVfxLLPpMpJ/Zi389aZE/fY/RKAA5i6pnp/b
    /5ypSCInaII7caP0n3zh6WeGjU4BN5Ka/rsIlK6AwpEMqzC0Jx3ocB41nrZLCRQyUKGj
    Os8LRbi+FfXsHTL06Za9Otj+bepHa7Q+DI283UgpdW8I765Nj1LbwvDRfU3favy9yGfj
    EfShtXWeyH3IhU8ozRrnRilTke3Bq+Z3cC/Ylkv40Pc/F388ifjy+vVr3jZItMrKoqSy
    nDMq/Hj0emDAtrUllaJ+vpQfPUYeRzEs5X6ECPGR0BoJn9tG1K3iqBJHj0M5t7s28Sg6
    N4qQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1686208272;
    s=strato-dkim-0002; d=gerhold.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=zIP6Ad+n6GtTcdAN99toMZU1nMdvUwM/xKmNfiwoI/o=;
    b=EbfbsfgV0Sv8mh6sgknLefjtuDEzgECz/O3uhsscBRmgGtHCVpQ0lpD61FpoExMkKO
    YHeWU1N2pPbxZf9ZiwCREBP7FJIvq77QLDsK5E035CYCUmFfCnUB324KrHJeM0/zUVMp
    Vm+/dePHnwlP+CxvyJn2nX90Q617Ns6CVuRgoXrP29zlUhMF6psN6IhyNm5lPH4ykZAY
    nGKFN21wR0IzjOA/x2ZtkidHlHMbw6V/2Wqvia3nTLlYdiXHKTOrNOcvl0cwJaTbR9o3
    vxjlSqKtZDgBte/ZZ8AhES4M//zOp5u8oaqdPetCr688qD5vQg0IvoKyy4RcKDYjxwAP
    2Feg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1686208272;
    s=strato-dkim-0003; d=gerhold.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=zIP6Ad+n6GtTcdAN99toMZU1nMdvUwM/xKmNfiwoI/o=;
    b=n+dmEAkCytzWFOoiLThsrzpfCUlIjJePl3kJDrdrrHW/AvQiA9EcOGawv6Sk0YTLRU
    rebnGBOOUmwQnbXPv3Cg==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQjVd4CteZ/7jYgS+mLFY+H0JAn8u4ly9TY="
Received: from [192.168.244.3]
    by smtp.strato.de (RZmta 49.5.3 DYNA|AUTH)
    with ESMTPSA id Z82ec2z587BBKHv
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Thu, 8 Jun 2023 09:11:11 +0200 (CEST)
From:   Stephan Gerhold <stephan@gerhold.net>
Date:   Thu, 08 Jun 2023 09:10:22 +0200
Subject: [PATCH v2 02/12] dt-bindings: soc: qcom: smd-rpm: Add MSM8909 to
 qcom,smd-channels
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230531-rpm-rproc-v2-2-56a4a00c8260@gerhold.net>
References: <20230531-rpm-rproc-v2-0-56a4a00c8260@gerhold.net>
In-Reply-To: <20230531-rpm-rproc-v2-0-56a4a00c8260@gerhold.net>
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        Stephan Gerhold <stephan@gerhold.net>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MSM8909 is using qcom,smd-channels but is missing in the list, add it
there as well.

Fixes: 709d473dd5e1 ("dt-bindings: soc: qcom: smd-rpm: Add MSM8909")
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
 Documentation/devicetree/bindings/soc/qcom/qcom,smd-rpm.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,smd-rpm.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom,smd-rpm.yaml
index fe814b991559..78822315edeb 100644
--- a/Documentation/devicetree/bindings/soc/qcom/qcom,smd-rpm.yaml
+++ b/Documentation/devicetree/bindings/soc/qcom/qcom,smd-rpm.yaml
@@ -82,6 +82,7 @@ if:
         enum:
           - qcom,rpm-apq8084
           - qcom,rpm-msm8226
+          - qcom,rpm-msm8909
           - qcom,rpm-msm8916
           - qcom,rpm-msm8936
           - qcom,rpm-msm8953

-- 
2.40.1

