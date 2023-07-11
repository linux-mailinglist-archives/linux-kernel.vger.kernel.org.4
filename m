Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DC5774EDF3
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 14:18:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231694AbjGKMSd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 08:18:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231589AbjGKMSa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 08:18:30 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF2F7E77
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 05:18:28 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2b6f97c7115so85701751fa.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 05:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689077907; x=1691669907;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gXcfnAFG0ALqJ5wchl9zMk96ke46h0gdnZo33aXqC6o=;
        b=VonMOp0i5+expziTeWEBTHMUNC7qXDeGRqyBPoJ1wkAUuR3RhU2Ey3IYC+JawK9rh6
         bHI9uJjJTWpyxc+pRRnma1cuAF16RAAcxjDTqfJT6s4+9D2lvb1crKrbG6E4T7E3j3JE
         7MBA0ngRqYrmXBTmKhP8l+hs9rWnbXQSPVyMw7DbtLvV9/KjkIbn9stCTJCLeYJ8Siq5
         7i6lnvVM71Lo1lZSupzYng3WE+l4ju3i2NfEvdXOdYzXzUSKWLTohxXt0Q13+Y0mjbSM
         kXXdY0gVkT+n4/u+ipmWfAu03x0bq1UG9/bal13n2vWRq52X43EVZGTNJNQro/YhG8uU
         ocRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689077907; x=1691669907;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gXcfnAFG0ALqJ5wchl9zMk96ke46h0gdnZo33aXqC6o=;
        b=T91APu3vOr/Ai4Petge2yfIB2r0WgyUu5BFZRz2KJ7rHBnR3Qj7OBysBdeo/Nsom3w
         nXGMejBX0yfCXg/fNy3hKfBUPMRUYVc2LW4yFwqg/1t8mT2Kl0DrHOLTa2BVVeqwTxE9
         Te7oSjZpOQVJshCQnc5LIjUFWxxpKWwno37+U7VVJZPdQ42SrUPwwCBNRBgcs0BGYgwu
         Sm7zX9nTtibbjXJ2eimHuRVo0OTbrkZEKPMkwqVOuIkKeftBGe32CkxGUvvL29I39CsP
         oNTQ5Fb6HaAoWxhwEuOttJLqCqRqby2CdkER2yFj76Ltz9WwzCbEmKJMTKDKOMgoJoNd
         K3eg==
X-Gm-Message-State: ABy/qLYY09QOfibSkeSeTvRlwB/7cTCWCQMRAK+NeCh3F9o4Xmxyovnb
        fQBNBTHuPGA5WHBuDsIP4ykneA==
X-Google-Smtp-Source: APBJJlHATZyGrxjvNQ4UHts/OGjmEwK4EuBMFcRIRxrV1Y/bvqWGJbi81Vw/Tydk5ULRpDptO1qfDQ==
X-Received: by 2002:a2e:91d7:0:b0:2b6:e0b8:946e with SMTP id u23-20020a2e91d7000000b002b6e0b8946emr13108332ljg.51.1689077907043;
        Tue, 11 Jul 2023 05:18:27 -0700 (PDT)
Received: from [192.168.1.101] (abyl96.neoplus.adsl.tpnet.pl. [83.9.31.96])
        by smtp.gmail.com with ESMTPSA id d18-20020a2e96d2000000b002b708450951sm435563ljj.88.2023.07.11.05.18.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 05:18:26 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Tue, 11 Jul 2023 14:18:00 +0200
Subject: [PATCH 01/53] dt-bindings: interconnect: qcom,icc: Introduce fixed
 BCM voter indices
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230708-topic-rpmh_icc_rsc-v1-1-b223bd2ac8dd@linaro.org>
References: <20230708-topic-rpmh_icc_rsc-v1-0-b223bd2ac8dd@linaro.org>
In-Reply-To: <20230708-topic-rpmh_icc_rsc-v1-0-b223bd2ac8dd@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        cros-qcom-dts-watchers@chromium.org
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1689077904; l=1189;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=9/TmGzQ1xk3CQ8ToyRcpOQBYP1VhR10l+JU+aSmEvI0=;
 b=N1JxOuvEYm4h/wsNdORtSNFT8AF68EXhuMFZexG+clfwKvtG5+uxA4rn/Z4fouP9EkKmuRWz+
 7R/htFQncM5BE7iN2tU0kXbvvV7s3St2Rs+MKybBnVpLAaPzAPW+821
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It makes zero (or less) sense to consume BCM voters per interconnect
provider. They are shared throughout the entire system and it's enough
to keep a single reference to each of them.

Storing them in a shared array at fixed indices will let us improve both
the representation of the RPMh architecture (every RSC can hold a resource
vote on any bus, they're not limited in that regard) and save as much as
kilobytes worth of RAM.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 include/dt-bindings/interconnect/qcom,icc.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/dt-bindings/interconnect/qcom,icc.h b/include/dt-bindings/interconnect/qcom,icc.h
index cd34f36daaaa..9c13ef8a044e 100644
--- a/include/dt-bindings/interconnect/qcom,icc.h
+++ b/include/dt-bindings/interconnect/qcom,icc.h
@@ -23,4 +23,12 @@
 #define QCOM_ICC_TAG_ALWAYS		(QCOM_ICC_TAG_AMC | QCOM_ICC_TAG_WAKE |\
 					 QCOM_ICC_TAG_SLEEP)
 
+#define ICC_BCM_VOTER_APPS		0
+#define ICC_BCM_VOTER_DISP		1
+#define ICC_BCM_VOTER_CAM0		2
+#define ICC_BCM_VOTER_CAM1		3
+#define ICC_BCM_VOTER_CAM2		4
+
+#define ICC_BCM_VOTER_MAX		64
+
 #endif

-- 
2.41.0

