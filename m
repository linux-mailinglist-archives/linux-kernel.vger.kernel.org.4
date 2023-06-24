Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15DFC73CADC
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jun 2023 14:24:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233179AbjFXMX5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Jun 2023 08:23:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233153AbjFXMXw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jun 2023 08:23:52 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3461E45
        for <linux-kernel@vger.kernel.org>; Sat, 24 Jun 2023 05:23:50 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2b47a15ca10so24751091fa.1
        for <linux-kernel@vger.kernel.org>; Sat, 24 Jun 2023 05:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687609429; x=1690201429;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SdwUD4ja8kl0C3si3v+OvYMyCtcQIhX5wG+ZPdgw56w=;
        b=hWJrUE+yTMBo33EWAQ3Fuij490p7Z6ilnJGULElb6XCef93PXynQsqdx65ZyA9hvMP
         w+j0Rm3iw7Anuz0b7KQ5oLmrSxm82yiCBW2dPS7ToTeJI/MONb1/+v+owUk5iSuUTy1F
         erDe/Ii8RS6H+eMWDHfzeWu1RzWmVh80oRQyplQLmXi2QHoCLwLAbxqUwsN26va8QJ+W
         NfRYg+rmlgHipqH8hXioYWNcI6I0tr9thcD4aYq7aPt0q7MQVR3CHnMEjWrSckPqYegX
         hEsWpGxbNyr5rKUw61VFdhSEIBrYE55sJuHwiHSUkdcys/fD0OV7ckiWTGxOTOwLOkya
         ekqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687609429; x=1690201429;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SdwUD4ja8kl0C3si3v+OvYMyCtcQIhX5wG+ZPdgw56w=;
        b=FnxkYlYgncaIG2ghPLSQ3+vhCOkU55W+atumnkvXKAkSieZeEoJguvmbF0fEtyDCN5
         u8Dix2oGw6XE/E5A4Rd4r85q9k+ZZPdi1g2uxj+RGLAVPnlOG92oOkQDmP0S2FM4GnmO
         j9UXSVX/kVGb032snD4tbog9A5lG9f4MxfEdyK9XE8rOqhfmpie9gfUyPZRcx9JOVEW2
         mrhplyGL5WNPHrLvOPj9cV+M6X3liHBlvt2NMljc3TJj+n5tzbIXnQobv3pva1j5f4sB
         YRU7DOtXWSe/XqxR/6zHjYTyoMKXEdiwOuDQkBvOXUJOOeSWXjJbU1S8eu9bUN8oyB8G
         Is3Q==
X-Gm-Message-State: AC+VfDzIJ3ACeif8CedNCabetMSOLDjRfsCB4Vvwe1esR5Wla6GLYSqz
        fC5TVqN8KQoEIsPjmdDiznH26w==
X-Google-Smtp-Source: ACHHUZ7yuVQdFm4WKHzI+HOH8HyATj9c84QUrWlItmCnDxat+7yp+Tg9zXqsWsAlNAN1iTEDfufRVQ==
X-Received: by 2002:a19:5050:0:b0:4f8:598b:e62d with SMTP id z16-20020a195050000000b004f8598be62dmr13826809lfj.56.1687609429133;
        Sat, 24 Jun 2023 05:23:49 -0700 (PDT)
Received: from [192.168.1.101] (abyk197.neoplus.adsl.tpnet.pl. [83.9.30.197])
        by smtp.gmail.com with ESMTPSA id s13-20020a19ad4d000000b004f00189e1dcsm260200lfd.117.2023.06.24.05.23.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Jun 2023 05:23:48 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Sat, 24 Jun 2023 14:23:46 +0200
Subject: [PATCH v2 2/3] firmware: qcom_scm: Always return
 devm_clk_get_optional errors
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230623-topic-scm_cleanup-v2-2-9db8c583138d@linaro.org>
References: <20230623-topic-scm_cleanup-v2-0-9db8c583138d@linaro.org>
In-Reply-To: <20230623-topic-scm_cleanup-v2-0-9db8c583138d@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1687609426; l=1572;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=LId2EVrQK5HfRRaxbRB0VnCSfdSPSyuZN4O6GtpVCuM=;
 b=TGAD5/2nSgKWjnQ1tOb5GK/LXL4aWbiquVPfQsfgiWQ9LZowwvQHrOdjJzXUbK3Q9yl5l/+ra
 qMQ6GwEnkJpDNQdO6nYIpMZmx15RuochA73XruUynPQoYXNWr7DlCmW
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

If devm_clk_get_optional throws an error, something is really wrong.
It may be a probe deferral, or it may be a problem with the clock
provider.

Regardless of what it may be, it should definitely not be ignored.
Stop doing that.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/firmware/qcom_scm.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/firmware/qcom_scm.c b/drivers/firmware/qcom_scm.c
index 237d05d6208b..b8398002205d 100644
--- a/drivers/firmware/qcom_scm.c
+++ b/drivers/firmware/qcom_scm.c
@@ -1419,22 +1419,16 @@ static int qcom_scm_probe(struct platform_device *pdev)
 				     "failed to acquire interconnect path\n");
 
 	scm->core_clk = devm_clk_get_optional(&pdev->dev, "core");
-	if (IS_ERR(scm->core_clk)) {
-		if (PTR_ERR(scm->core_clk) == -EPROBE_DEFER)
-			return PTR_ERR(scm->core_clk);
-	}
+	if (IS_ERR(scm->core_clk))
+		return PTR_ERR(scm->core_clk);
 
 	scm->iface_clk = devm_clk_get_optional(&pdev->dev, "iface");
-	if (IS_ERR(scm->iface_clk)) {
-		if (PTR_ERR(scm->iface_clk) == -EPROBE_DEFER)
-			return PTR_ERR(scm->iface_clk);
-	}
+	if (IS_ERR(scm->iface_clk))
+		return PTR_ERR(scm->iface_clk);
 
 	scm->bus_clk = devm_clk_get_optional(&pdev->dev, "bus");
-	if (IS_ERR(scm->bus_clk)) {
-		if (PTR_ERR(scm->bus_clk) == -EPROBE_DEFER)
-			return PTR_ERR(scm->bus_clk);
-	}
+	if (IS_ERR(scm->bus_clk))
+		return PTR_ERR(scm->bus_clk);
 
 	scm->reset.ops = &qcom_scm_pas_reset_ops;
 	scm->reset.nr_resets = 1;

-- 
2.41.0

