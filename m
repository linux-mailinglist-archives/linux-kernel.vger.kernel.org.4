Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6A276B46E9
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 15:47:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233066AbjCJOri (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 09:47:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232944AbjCJOrV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 09:47:21 -0500
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 985BF1220A7;
        Fri, 10 Mar 2023 06:47:02 -0800 (PST)
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-176d93cd0daso6076337fac.4;
        Fri, 10 Mar 2023 06:47:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678459617;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ruOCIyrCu4R3myaePZjbY/+wVIokIQ8xguXTZPHNbVU=;
        b=75B9krWdutRf5YCAu2+hLcotaXmtB+9jxoDAcN3GJ2TI+Ml6PH9J2CHeRlwJZIE/LM
         D3SEW/JD7uiTLXDwugiVupKnTxzlAfjyIoboOwgWBb20wixj3yGDv73IfNr8DW2Me53/
         0LMXkVr+9WGwWIWFFQrxSCJijAfRpENShAwqh6qBTSVJpKCiH3K4xwYKfm5IyuGOGxb+
         YKPJMy7sFnCCGzpgM+c2o2FGsk3YMUZQJpX1oZYumgNASRP9hdLaqOfz2XHFMSuw9n4n
         Ii/CuHhWvXpHVi1A2lg6rfi11RqVgxaQa1vLLjdapAm9Zl1j0ALMxWdbxVkuCRd3MNVu
         SRlg==
X-Gm-Message-State: AO0yUKV7UZzlr5eRVTV6G4TAVqgG5orEeZvsLFGkkdH17W1eBtuVHgiA
        EiHCLi5zFhKFSljy8F7qtQ==
X-Google-Smtp-Source: AK7set/ItsnsH5x0zLLeP4WfD3sVpmDCzdySo7lTckXI9tTIYbLIQcFnseIv5HnKDBmV90/O4hldLQ==
X-Received: by 2002:a05:6870:b251:b0:172:28a0:6dde with SMTP id b17-20020a056870b25100b0017228a06ddemr16164067oam.30.1678459616941;
        Fri, 10 Mar 2023 06:46:56 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id w4-20020a056870a2c400b00172ac40356csm74075oak.50.2023.03.10.06.46.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 06:46:56 -0800 (PST)
Received: (nullmailer pid 1540750 invoked by uid 1000);
        Fri, 10 Mar 2023 14:46:55 -0000
From:   Rob Herring <robh@kernel.org>
To:     Russell King <linux@armlinux.org.uk>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: imx: Use of_property_read_bool() for boolean properties
Date:   Fri, 10 Mar 2023 08:46:55 -0600
Message-Id: <20230310144655.1540724-1-robh@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is preferred to use typed property access functions (i.e.
of_property_read_<type> functions) rather than low-level
of_get_property/of_find_property functions for reading properties.
Convert reading boolean properties to to of_property_read_bool().

Signed-off-by: Rob Herring <robh@kernel.org>
---
 arch/arm/mach-imx/gpc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-imx/gpc.c b/arch/arm/mach-imx/gpc.c
index ebc4339b8be4..5909088d5482 100644
--- a/arch/arm/mach-imx/gpc.c
+++ b/arch/arm/mach-imx/gpc.c
@@ -275,7 +275,7 @@ void __init imx_gpc_check_dt(void)
 	if (WARN_ON(!np))
 		return;
 
-	if (WARN_ON(!of_find_property(np, "interrupt-controller", NULL))) {
+	if (WARN_ON(!of_property_read_bool(np, "interrupt-controller"))) {
 		pr_warn("Outdated DT detected, suspend/resume will NOT work\n");
 
 		/* map GPC, so that at least CPUidle and WARs keep working */
-- 
2.39.2

