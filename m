Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D58E74DF13
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 22:18:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230527AbjGJUSa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 16:18:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231224AbjGJUSY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 16:18:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 804EB198
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 13:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689020256;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YmlAnwDpnt7QnZH9R1+eVRqHntPGLtyJNksmlK12GAU=;
        b=EOkQN6twhZrgUcYmbPrfnWduq5z+Beqp4QwpmPbVKca1sFR4o28fzHL8eHxF3lo2/wWoK+
        Yr5bkI4ILbZg0t8YecAngOG5aphu/vvbZfDk0AVYcn3ozYeSLIDNEHb4sZUzYBhVcI6Cud
        O7A+BHxx7H4rlgWAxaE0CA7Wvq2xU4o=
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com
 [209.85.160.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-636-xPsx2sS_PEKw8R3Mym_dpw-1; Mon, 10 Jul 2023 16:17:35 -0400
X-MC-Unique: xPsx2sS_PEKw8R3Mym_dpw-1
Received: by mail-oa1-f70.google.com with SMTP id 586e51a60fabf-1b74e921a7aso351954fac.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 13:17:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689020254; x=1691612254;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YmlAnwDpnt7QnZH9R1+eVRqHntPGLtyJNksmlK12GAU=;
        b=PeDLRCP5hWqZitSPE1QqLwCFw2/WAQnZPIkMHxj+76N8Bs2h5iUmhv5RTRrvfOSWp2
         hznE+2K+C7GMqSOIKxcj991tK6mCK1QjEnPKlmAwgwAYT07BQka7cXiYsaxJcjpQHXSL
         7dFe/3rzoBAMTqFNFTCW6jYMPBbLWd84+d25fVE45maCDbR8fZjCRNic0xrXBNvS4+zG
         W7ktNtVMW96xyQUhTw5ab1qit59Gw89nswj8581BZMFuefXnBghSwHYMGPnGS0bXtOKp
         4F2CGo+h0XcKntjhWUnNbbk0JPIiuZrsh+3PJh2sySebGiuN4P+ZzzFI54ZxP+jFqs4l
         vGtw==
X-Gm-Message-State: ABy/qLb2yPzOv5cl2FJxKDVr/OL0ASIFHLuVjrQp3ecp6kzwK/FY7355
        pmsEuVbVzapi1EQlcuN3uxm7C8TtLEOJlE7eJ+Xm15h2+K62gzjzZX/Oh0SUUZV2fN9sgfXiRTt
        cdlLXtYS3OrOV8fx51nkvX+TktdIpoH2KdZxK6aTN3CU1TXcrAWNBB7V67Lm5w5jH2iGRica1Yy
        zVYHdCWEgw
X-Received: by 2002:a05:6870:5254:b0:1b0:4fc5:2e4b with SMTP id o20-20020a056870525400b001b04fc52e4bmr13438916oai.9.1689020254731;
        Mon, 10 Jul 2023 13:17:34 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFmKqPEtPtyW1H2DGn/G9uxqGi6UQiom7uSU/SpIgU9Y6/TP9FG19pTfynkVg73dr92H4bGyw==
X-Received: by 2002:a05:6870:5254:b0:1b0:4fc5:2e4b with SMTP id o20-20020a056870525400b001b04fc52e4bmr13438882oai.9.1689020254461;
        Mon, 10 Jul 2023 13:17:34 -0700 (PDT)
Received: from halaney-x13s.attlocal.net ([2600:1700:1ff0:d0e0::22])
        by smtp.gmail.com with ESMTPSA id j12-20020a81920c000000b0056d2a19ad91sm155097ywg.103.2023.07.10.13.17.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 13:17:34 -0700 (PDT)
From:   Andrew Halaney <ahalaney@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com, netdev@vger.kernel.org,
        mcoquelin.stm32@gmail.com, pabeni@redhat.com, kuba@kernel.org,
        edumazet@google.com, davem@davemloft.net, joabreu@synopsys.com,
        alexandre.torgue@foss.st.com, peppe.cavallaro@st.com,
        bhupesh.sharma@linaro.org, vkoul@kernel.org,
        linux-arm-msm@vger.kernel.org, andrew@lunn.ch,
        simon.horman@corigine.com, Andrew Halaney <ahalaney@redhat.com>
Subject: [PATCH net-next v2 1/3] net: stmmac: dwmac-qcom-ethqos: Use of_get_phy_mode() over device_get_phy_mode()
Date:   Mon, 10 Jul 2023 15:06:37 -0500
Message-ID: <20230710201636.200412-2-ahalaney@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230710201636.200412-1-ahalaney@redhat.com>
References: <20230710201636.200412-1-ahalaney@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since this driver only uses devicetree, let's move over to
of_get_phy_mode(). That API has an explicit error return and produces a
phy_interface_t directly instead of an int when representing the phy
mode.

Signed-off-by: Andrew Halaney <ahalaney@redhat.com>
---

Changes since v1:
    * Convert to using of_get_phy_mode() instead of continuing to use
      device_get_phy_mode() (Andrew Lunn)

 .../net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c    | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
index e62940414e54..ebafdadb28d5 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
@@ -4,10 +4,10 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
+#include <linux/of_net.h>
 #include <linux/platform_device.h>
 #include <linux/phy.h>
 #include <linux/phy/phy.h>
-#include <linux/property.h>
 
 #include "stmmac.h"
 #include "stmmac_platform.h"
@@ -104,7 +104,7 @@ struct qcom_ethqos {
 	struct clk *link_clk;
 	struct phy *serdes_phy;
 	unsigned int speed;
-	int phy_mode;
+	phy_interface_t phy_mode;
 
 	const struct ethqos_emac_por *por;
 	unsigned int num_por;
@@ -720,7 +720,9 @@ static int qcom_ethqos_probe(struct platform_device *pdev)
 	if (!ethqos)
 		return -ENOMEM;
 
-	ethqos->phy_mode = device_get_phy_mode(dev);
+	ret = of_get_phy_mode(np, &ethqos->phy_mode);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to get phy mode\n");
 	switch (ethqos->phy_mode) {
 	case PHY_INTERFACE_MODE_RGMII:
 	case PHY_INTERFACE_MODE_RGMII_ID:
@@ -731,8 +733,6 @@ static int qcom_ethqos_probe(struct platform_device *pdev)
 	case PHY_INTERFACE_MODE_SGMII:
 		ethqos->configure_func = ethqos_configure_sgmii;
 		break;
-	case -ENODEV:
-		return -ENODEV;
 	default:
 		return -EINVAL;
 	}
-- 
2.41.0

