Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEF5068C6F0
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 20:38:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbjBFTiL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 14:38:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjBFTiK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 14:38:10 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B11D913D69;
        Mon,  6 Feb 2023 11:38:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4EAB060FFD;
        Mon,  6 Feb 2023 19:38:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BB14C433D2;
        Mon,  6 Feb 2023 19:38:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675712288;
        bh=bG9YLGEhBjFz6zXj4NzQ4x+3+ALPum4dN/AWK0u8uEg=;
        h=From:To:Cc:Subject:Date:From;
        b=FYMLuiiXykEsb6hGNWJG9d5xTC+yMuyR45nOkmcZ/Hib+HGgsTHqrhMPDSYKnjg0f
         osNS8re5r97xLusDW5Rhu6Ri95Gti5Av+ba2JQ+bR4qt4EjAg1GOF+L7CjqZ8lnnkf
         cjleuAKlvdGXWP/sUk3TFnfbze7mKEMczoWI9cl7BH1oEa+v5eKWpHizHDFGfgA56X
         nwwHmPwoUtIPdceMrS5EzNkBF4kaDtJS6dPcRneJIOkcyuttAT6Jn6iDzIpts0/T/L
         5Vy0IHurU6VdArKoFoAoJ3MblCIcZGItnT+xGL1Ax4QsuNDh5+mrZODiBae4z61BN0
         yit3H4d2MCq5Q==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Souradeep Chowdhury <quic_schowdhu@quicinc.com>,
        YueHaibing <yuehaibing@huawei.com>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] soc: qcom: pmic_glink: add CONFIG_NET/CONFIG_OF dependencies
Date:   Mon,  6 Feb 2023 20:37:58 +0100
Message-Id: <20230206193804.191343-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

QMI is a network protocol, so anything using requires CONFIG_NET
to be enabled as well:

WARNING: unmet direct dependencies detected for QCOM_QMI_HELPERS
  Depends on [n]: NET [=n]
  Selected by [m]:
  - QCOM_PDR_HELPERS [=m]
arm-linux-gnueabi-ld: drivers/soc/qcom/qmi_interface.o: in function `qmi_send_new_lookup':
qmi_interface.c:(.text+0xf0): undefined reference to `kernel_sendmsg'

Add the dependency to both QCOM_PDR_HELPERS and QCOM_PMIC_GLINK to make
it clearly what the dependency is when another PDR user is added.

pmic_glink also needs CONFIG_OF:

drivers/soc/qcom/pmic_glink_altmode.c: In function 'pmic_glink_altmode_probe':
drivers/soc/qcom/pmic_glink_altmode.c:418:33: error: 'struct drm_bridge' has no member named 'of_node'

Fixes: 58ef4ece1e41 ("soc: qcom: pmic_glink: Introduce base PMIC GLINK driver")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/soc/qcom/Kconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
index 348fde2a8aae..a8f283086a21 100644
--- a/drivers/soc/qcom/Kconfig
+++ b/drivers/soc/qcom/Kconfig
@@ -91,12 +91,15 @@ config QCOM_OCMEM
 config QCOM_PDR_HELPERS
 	tristate
 	select QCOM_QMI_HELPERS
+	depends on NET
 
 config QCOM_PMIC_GLINK
 	tristate "Qualcomm PMIC GLINK driver"
 	depends on RPMSG
 	depends on TYPEC
 	depends on DRM
+	depends on NET
+	depends on OF
 	select AUXILIARY_BUS
 	select QCOM_PDR_HELPERS
 	help
-- 
2.39.0

