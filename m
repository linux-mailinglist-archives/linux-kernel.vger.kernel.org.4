Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83542708363
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 15:59:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231452AbjERN74 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 09:59:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230169AbjERN7y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 09:59:54 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7AF910DA;
        Thu, 18 May 2023 06:59:51 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-510dabb39aeso2286704a12.2;
        Thu, 18 May 2023 06:59:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684418390; x=1687010390;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MOCIa/CAbEbWwY2wcBgLkKevxCcqHsPJBCWi4Dwjoy8=;
        b=MYElUonJ2j2KjZKx7Twde5yHiRkQvW/PdI3AGMfGxdtGnfN8dXzGvaimrUD8FcBHJe
         PW54Pz8LSWQBma9IT0kE53k8gko9rFIW2YurwaQuJxnFYTKMl5d8gF8V9/FjpFJZfKra
         MtoJ4mo7QjDTy6dxI47j70KtPuKqnrFrHqmzq9tPTt26NFJV3fshXz1NujNyfwXsayKM
         uxoMGUHgvudN7OEJ7UWVa/U7NMPGrCrGNrK2Bw+raikLhdQZWdbBjWSyiuoDVlDYomcQ
         cZukX+z5eDJPjtvS9iwxXOki9iYqcHStNTO6C79TkxzgX9ewtkz2Vet5L8QblPa3dk1K
         SqOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684418390; x=1687010390;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MOCIa/CAbEbWwY2wcBgLkKevxCcqHsPJBCWi4Dwjoy8=;
        b=LTfCPL09JFwoSowWLr3BkFvMj67CGwRL6xMdWQvsKWMNUjWMf4wU4z1CbZQ88ZKgUc
         UE7dhlNEgLyvyU4D5VTZ1m/bVg0Qw01oCc/kXd83+USFpYVBxMa3RFVYQf6FUnter2Gr
         sA/OXr85ka+lw7ftmEGQeJ+UW/ZFRtyW/9Ue9H0bOnwX32DBu+QykX/6VVo+2fzrnmNA
         yg/cCI9CCLMK03mSydZ4VB6ryVfDhtlwlUVmc8FXw6YigmyqJwFiDYlmCKnSEOo90fcR
         hqHGZxiwGIu0g5bBIy4p122h8fDQQ7AH32y+B8MQL55O12f5R6LVYL3fXYdjCjAxCrIC
         /0GA==
X-Gm-Message-State: AC+VfDyqOunkKLtl3D/xkjFspJDKvzvv2Tti1drtFrHz8wGtuJ0PTW4r
        c62nqzO6P9AT9HzwgtrurSg=
X-Google-Smtp-Source: ACHHUZ5Y0by3v8Yl1Lw6NT7oS57WKekUeoZOfbdpm/ePKEDwLD2A/FGlPgTnC7gDk/Gr0b1JWxM8hA==
X-Received: by 2002:aa7:dd51:0:b0:50c:52d:7197 with SMTP id o17-20020aa7dd51000000b0050c052d7197mr4459858edw.2.1684418390174;
        Thu, 18 May 2023 06:59:50 -0700 (PDT)
Received: from fedora.. (cpezg-94-253-130-143-cbl.xnet.hr. [94.253.130.143])
        by smtp.googlemail.com with ESMTPSA id t28-20020a50d71c000000b0050d89daaa70sm669003edi.2.2023.05.18.06.59.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 May 2023 06:59:49 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     agross@kernel.org, andersson@kernel.orgm, konrad.dybcio@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_srichara@quicinc.com
Cc:     Robert Marko <robimarko@gmail.com>
Subject: [PATCH 1/2] firmware: qcom: scm: Add SDI disable support
Date:   Thu, 18 May 2023 15:59:44 +0200
Message-Id: <20230518135945.2248451-1-robimarko@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
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

