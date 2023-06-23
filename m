Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFDE573C349
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 23:50:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231272AbjFWVuX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 17:50:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232775AbjFWVtq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 17:49:46 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2DAD26BC
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 14:49:44 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2b4619ef079so18477541fa.2
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 14:49:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687556983; x=1690148983;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hREtLTaOr1vxm3oiuZ2o7EtfUAU7I8iGuHkim3fangU=;
        b=g7c6bkTr17TtpoaApZ/bdpavw/HGtwa70Gn2FM6Xv0wVpFqg4MYqWNIIhndepStsq7
         gco9S6d1XQuxhds1a0lRRcbDyBmmrwyOAJxmlcz+U+EZnr7o4+Kmiv3PCbaiZWV33uVg
         j+q+U5IxqYsVMUjyJNkZ6t4sN7vevmnhcEc9wB7oGitX+hgoaRTQDjlI+f/SHTvhzLws
         U1B//V5ZiubbWQ1jvEOLEMEO5uP0INd5yIXV2sXF3Dt13WCZlgofyZBdwzRLUmGk0eOK
         b/W7tMaDSn+GYgd8z2KmmGYo0LCyf7c0RAmO+9hM9Qx5EmDT5P1dzwZ9gOxYl0yXEzH0
         5Xpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687556983; x=1690148983;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hREtLTaOr1vxm3oiuZ2o7EtfUAU7I8iGuHkim3fangU=;
        b=BzCBUGWiDBVNHxiMZdpVyR67thCudxZ+KeqTKf/Zvk4IlYu3k9eSBmkViJuqEGAoTU
         wUQrYOOxIv/mTajzjV9J6Eow4ZxhtbL2ajSQe4asCEbrgbul21WMPIwgDompDbI0L0ii
         BcDH6wiRBSEMkT6Q5OTYkXTmr6fqAoLbuw2wtkxrpXVgvjRbeo4U04HkOIvt3CnU/OBZ
         F+eynLRO1ywmtKWrwS1W0NkxM76PeSYRHisMi2Q8C98AZ+xK9wmqpyjY7gww9qm1t4QE
         +NfrW2z0d4A0/BNYmiNWt2HJkxQyUaHPBJ9AsRJk4gThpAQ2H2UbBYZB9yUfdasjEZ1U
         EQ4w==
X-Gm-Message-State: AC+VfDxKhdbAgo+ZBKbBUlQ+Il7FtDyH3GmZzRbg1ROXi9K6iL8gByGH
        E1jK5MddtjWI3AUco11hUbDFqw==
X-Google-Smtp-Source: ACHHUZ5+nzWpyjpmyT6Ls3TJRfLuztc6p8qXFVmYXtvG+mxHeGBvc/XJw8yPRrqygjXiREF3vcUEWw==
X-Received: by 2002:a2e:b601:0:b0:2b4:8623:cf74 with SMTP id r1-20020a2eb601000000b002b48623cf74mr9767508ljn.18.1687556982892;
        Fri, 23 Jun 2023 14:49:42 -0700 (PDT)
Received: from [192.168.1.101] (abyk30.neoplus.adsl.tpnet.pl. [83.9.30.30])
        by smtp.gmail.com with ESMTPSA id x20-20020a2e9c94000000b002b48437dcaasm1840919lji.103.2023.06.23.14.49.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jun 2023 14:49:42 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: [PATCH 0/3] Drop useless compatibles from the SCM driver
Date:   Fri, 23 Jun 2023 23:49:41 +0200
Message-Id: <20230623-topic-scm_cleanup-v1-0-383089eae98d@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHUTlmQC/x2N0QrCMAwAf2Xk2UKbjT74KyKSxegCNSutE2Hs3
 w0+3sFxO3RpKh3Oww5NPtp1NYd0GoAXsqcEvTsDRhxjxjG816ocOr9uXIRsq4GnjHHKKWEm8G6
 mLmFuZLx4aVspLmuTh37/o8v1OH645br9eAAAAA==
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1687556981; l=793;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=bEI5FKrJkRFgUfQ2VOKFIcFc8axCW1G8JnUFD99njlw=;
 b=6KyNmJREHOrMriOKjwufbKhSjFXkwQ18Z4H4Ro8FFGSKbcarvxrR/RtBTH8cgW1lYlKlNuOqg
 fi6vQ0RFcHMBKNm9dEf2h0gUXAAd2prQD4Bn9mJF/WThoYIVZhYEOGd
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

The compatibles, apart from some ancient ones kept for backwards compat
due to no generic fallback, are largely useless and we can easily remove
them. This series attempts to do that with hopefully no harm.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
Konrad Dybcio (3):
      firmware: qcom_scm: Always try to consume all three clocks
      firmware: qcom_scm: Always return devm_clk_get_optional errors
      firmware: qcom_scm: Drop useless compatibles

 drivers/firmware/qcom_scm.c | 87 +++++++++------------------------------------
 1 file changed, 16 insertions(+), 71 deletions(-)
---
base-commit: c87d46a9e8ebd2f2c3960927b1d21687096d1109
change-id: 20230623-topic-scm_cleanup-c4620461126a

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>

