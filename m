Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17C7D708374
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 16:02:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231563AbjEROCe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 10:02:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230144AbjEROCb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 10:02:31 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEF5A1B5;
        Thu, 18 May 2023 07:02:29 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-9661047f8b8so373186166b.0;
        Thu, 18 May 2023 07:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684418548; x=1687010548;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MOCIa/CAbEbWwY2wcBgLkKevxCcqHsPJBCWi4Dwjoy8=;
        b=C71hGwpN1sn4os+rxtfcFFLDRAcsUmHzUvZcQQdWItrerPLa7/A1kb5Fzh9rgsn4vD
         1S8jPUf5hvxMUQ4UncqPvoqz4RvTIP1FSkwgidBtXYrRtEuEWMiglnx5aThi6T8afSWr
         ltow4vfCDDeagoBVWmA23ANXpM2PfXbr3Wg6fUz9nBmQa0iokEknbj+NnwbQBJ/lTZQm
         DOABSrpi8bKwOKcEQjnzvmgA1RcJeFXvL1+X8zBCss+K5/YoeLy/Xfl0XMK4AOVpaKyD
         vHA7srwVMihmRlG0MzW5zciTpTRarPcAawWgvwboUfwZZ9yBEV8N8X3477iXJgFIla78
         aRqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684418548; x=1687010548;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MOCIa/CAbEbWwY2wcBgLkKevxCcqHsPJBCWi4Dwjoy8=;
        b=QLsQw6DFMWZlfXQlbisiTZrtFdCs0WCvPjINjfkYyi1ZOZXOtBgdrMdHEo0/bhObjM
         f7+2SVK9BdBBwmKPDtodXiXQmUPOBAxeVvamERC1DrQ/P/T1D30JNuY+c8LSTlfap8xC
         qC5Z48VVrqD8gZTJimmxM3zoQfL+hnLooNIYjCyzW5MLMjUrnGNtd1XaF1LRm/i8vVQH
         fiapD0zZnuojYV5i5bo7SxuyN97aDXDSQTf/wTpO5AVy/i0kGLthNhRbmKoR25vsCzRj
         zREAE3Ro4/ngd4XvgOGE09GPC+vWFs0IqETIgVDy4PDA1np4CXm/Z7INKGpxEFDR23Fd
         osiA==
X-Gm-Message-State: AC+VfDzDrSVeXvZwORujnXpq4a5QNfyIUOuzKB0gDcxmFOYpjhfPJ7r/
        hNXULD+Zd+/S8PZbdTXPA2g=
X-Google-Smtp-Source: ACHHUZ5yEfv+aruz/676vESMFZQ46eNevoOBKZ+cDkl8XVfpdiGcx/CKfSiSJ8A8Os+//kkUPn/tyQ==
X-Received: by 2002:a17:907:2d92:b0:966:612b:c292 with SMTP id gt18-20020a1709072d9200b00966612bc292mr40975307ejc.11.1684418548073;
        Thu, 18 May 2023 07:02:28 -0700 (PDT)
Received: from fedora.. (cpezg-94-253-130-143-cbl.xnet.hr. [94.253.130.143])
        by smtp.googlemail.com with ESMTPSA id m14-20020a170906258e00b0096f272206b3sm997025ejb.125.2023.05.18.07.02.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 May 2023 07:02:27 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        srichara@quicinc.com
Cc:     Robert Marko <robimarko@gmail.com>
Subject: [RESEND,PATCH 1/2] firmware: qcom: scm: Add SDI disable support
Date:   Thu, 18 May 2023 16:02:23 +0200
Message-Id: <20230518140224.2248782-1-robimarko@gmail.com>
X-Mailer: git-send-email 2.40.1
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

Some SoC-s like IPQ5018 require SDI(Secure Debug Image) to be disabled
before trying to reboot, otherwise board will just hang after reboot has
been issued via PSCI.

So, provide a call to SCM that allows disabling it.

Signed-off-by: Robert Marko <robimarko@gmail.com>
---
 drivers/firmware/qcom_scm.c | 23 +++++++++++++++++++++++
 drivers/firmware/qcom_scm.h |  1 +
 2 files changed, 24 insertions(+)

diff --git a/drivers/firmware/qcom_scm.c b/drivers/firmware/qcom_scm.c
index fde33acd46b7..bdc9324d4e62 100644
--- a/drivers/firmware/qcom_scm.c
+++ b/drivers/firmware/qcom_scm.c
@@ -407,6 +407,29 @@ int qcom_scm_set_remote_state(u32 state, u32 id)
 }
 EXPORT_SYMBOL(qcom_scm_set_remote_state);
 
+static int qcom_scm_disable_sdi(void)
+{
+	int ret;
+	struct qcom_scm_desc desc = {
+		.svc = QCOM_SCM_SVC_BOOT,
+		.cmd = QCOM_SCM_BOOT_SDI_CONFIG,
+		.args[0] = 1, /* Disable watchdog debug */
+		.args[1] = 0, /* Disable SDI */
+		.arginfo = QCOM_SCM_ARGS(2),
+		.owner = ARM_SMCCC_OWNER_SIP,
+	};
+	struct qcom_scm_res res;
+
+	ret = qcom_scm_clk_enable();
+	if (ret)
+		return ret;
+	ret = qcom_scm_call(__scm->dev, &desc, &res);
+
+	qcom_scm_clk_disable();
+
+	return ret ? : res.result[0];
+}
+
 static int __qcom_scm_set_dload_mode(struct device *dev, bool enable)
 {
 	struct qcom_scm_desc desc = {
diff --git a/drivers/firmware/qcom_scm.h b/drivers/firmware/qcom_scm.h
index e6e512bd57d1..7b68fa820495 100644
--- a/drivers/firmware/qcom_scm.h
+++ b/drivers/firmware/qcom_scm.h
@@ -80,6 +80,7 @@ extern int scm_legacy_call(struct device *dev, const struct qcom_scm_desc *desc,
 #define QCOM_SCM_SVC_BOOT		0x01
 #define QCOM_SCM_BOOT_SET_ADDR		0x01
 #define QCOM_SCM_BOOT_TERMINATE_PC	0x02
+#define QCOM_SCM_BOOT_SDI_CONFIG	0x09
 #define QCOM_SCM_BOOT_SET_DLOAD_MODE	0x10
 #define QCOM_SCM_BOOT_SET_ADDR_MC	0x11
 #define QCOM_SCM_BOOT_SET_REMOTE_STATE	0x0a
-- 
2.40.1

