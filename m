Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4515672A24A
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 20:32:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230395AbjFIScL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 14:32:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230458AbjFIScH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 14:32:07 -0400
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 352B93A89
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 11:31:58 -0700 (PDT)
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-777ac169033so117846939f.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jun 2023 11:31:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686335517; x=1688927517;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tXMDtdWN6nJZldqwpEUd7GnDVKNRMg93Z/FFZjfMFDo=;
        b=K0/pNO1NCb649ErGzLTp5cHVh2ITHTy9O+iR9Fr33DkYWQ+Iv+47fT/fKEbf6gnCd2
         x2Ln5ob8qgfgSFYADpnPudUWLpzkWdKiZfFQMHIn3G/70CVESSBEucXQeHOHTKKbbru7
         CfRxqfj/SxZOCX9PCr3+/B04LuVAwtZbgicmot2gq1HQiDaUgWf9b78bnHev3mrX2U2N
         bpzu5k9htHVK8hA+8fLjoX+xod4XeVy6WAtUztfKu4cmaTUzsklVn/0XUWgk0jz9qE1K
         hBEJ1MqzAJgJ05OLb2GRdUQofK/HIFh7mE8oWN8KjSF2VbfEYStJ+j6gWaO8wA6885Zo
         LPjw==
X-Gm-Message-State: AC+VfDxxNLMgt39/pqt/+CZFr61CtXrvA+2ZyHnNn3jt82/wOsed7J4+
        DZvuarpVW7myjFTRlqJvfw==
X-Google-Smtp-Source: ACHHUZ6BKEOfSW1H9tTyJANStK6mB/D2kcTclumsnvDTg5+rXrM1pBhCQZNmiN2c2Tm8s0XDxwJlew==
X-Received: by 2002:a5d:925a:0:b0:777:de8a:79a with SMTP id e26-20020a5d925a000000b00777de8a079amr3556373iol.7.1686335517420;
        Fri, 09 Jun 2023 11:31:57 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id y9-20020a02c009000000b004209b1863c4sm1097473jai.52.2023.06.09.11.31.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 11:31:56 -0700 (PDT)
Received: (nullmailer pid 1766355 invoked by uid 1000);
        Fri, 09 Jun 2023 18:31:55 -0000
From:   Rob Herring <robh@kernel.org>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc: fsl: Use of_property_read_reg() to parse "reg"
Date:   Fri,  9 Jun 2023 12:31:50 -0600
Message-Id: <20230609183151.1766261-1-robh@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the recently added of_property_read_reg() helper to get the
untranslated "reg" address value.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 arch/powerpc/sysdev/fsl_rio.c | 14 +++-----------
 arch/powerpc/sysdev/fsl_rmu.c |  9 +--------
 2 files changed, 4 insertions(+), 19 deletions(-)

diff --git a/arch/powerpc/sysdev/fsl_rio.c b/arch/powerpc/sysdev/fsl_rio.c
index 18176d0df612..33ba1676ef5a 100644
--- a/arch/powerpc/sysdev/fsl_rio.c
+++ b/arch/powerpc/sysdev/fsl_rio.c
@@ -448,13 +448,11 @@ int fsl_rio_setup(struct platform_device *dev)
 	struct rio_mport *port;
 	struct rio_priv *priv;
 	int rc = 0;
-	const u32 *dt_range, *cell, *port_index;
+	const u32 *cell, *port_index;
 	u32 active_ports = 0;
 	struct device_node *np, *rmu_node;
-	int rlen;
 	u32 ccsr;
 	u64 range_start;
-	int aw;
 	u32 i;
 	static int tmp;
 	struct device_node *rmu_np[MAX_MSG_UNIT_NUM] = {NULL};
@@ -528,15 +526,12 @@ int fsl_rio_setup(struct platform_device *dev)
 	dbell->bellirq = irq_of_parse_and_map(np, 1);
 	dev_info(&dev->dev, "bellirq: %d\n", dbell->bellirq);
 
-	aw = of_n_addr_cells(np);
-	dt_range = of_get_property(np, "reg", &rlen);
-	if (!dt_range) {
+	if (of_property_read_reg(np, 0, &range_start, NULL)) {
 		pr_err("%pOF: unable to find 'reg' property\n",
 			np);
 		rc = -ENOMEM;
 		goto err_pw;
 	}
-	range_start = of_read_number(dt_range, aw);
 	dbell->dbell_regs = (struct rio_dbell_regs *)(rmu_regs_win +
 				(u32)range_start);
 
@@ -556,15 +551,12 @@ int fsl_rio_setup(struct platform_device *dev)
 	pw->dev = &dev->dev;
 	pw->pwirq = irq_of_parse_and_map(np, 0);
 	dev_info(&dev->dev, "pwirq: %d\n", pw->pwirq);
-	aw = of_n_addr_cells(np);
-	dt_range = of_get_property(np, "reg", &rlen);
-	if (!dt_range) {
+	if (of_property_read_reg(np, 0, &range_start, NULL)) {
 		pr_err("%pOF: unable to find 'reg' property\n",
 			np);
 		rc = -ENOMEM;
 		goto err;
 	}
-	range_start = of_read_number(dt_range, aw);
 	pw->pw_regs = (struct rio_pw_regs *)(rmu_regs_win + (u32)range_start);
 
 	/*set up ports node*/
diff --git a/arch/powerpc/sysdev/fsl_rmu.c b/arch/powerpc/sysdev/fsl_rmu.c
index 7a5e2e2b9d06..e27c275c9c2e 100644
--- a/arch/powerpc/sysdev/fsl_rmu.c
+++ b/arch/powerpc/sysdev/fsl_rmu.c
@@ -1067,9 +1067,6 @@ int fsl_rio_setup_rmu(struct rio_mport *mport, struct device_node *node)
 	struct rio_priv *priv;
 	struct fsl_rmu *rmu;
 	u64 msg_start;
-	const u32 *msg_addr;
-	int mlen;
-	int aw;
 
 	if (!mport || !mport->priv)
 		return -EINVAL;
@@ -1086,16 +1083,12 @@ int fsl_rio_setup_rmu(struct rio_mport *mport, struct device_node *node)
 	if (!rmu)
 		return -ENOMEM;
 
-	aw = of_n_addr_cells(node);
-	msg_addr = of_get_property(node, "reg", &mlen);
-	if (!msg_addr) {
+	if (of_property_read_reg(node, 0, &msg_start, NULL)) {
 		pr_err("%pOF: unable to find 'reg' property of message-unit\n",
 			node);
 		kfree(rmu);
 		return -ENOMEM;
 	}
-	msg_start = of_read_number(msg_addr, aw);
-
 	rmu->msg_regs = (struct rio_msg_regs *)
 			(rmu_regs_win + (u32)msg_start);
 
-- 
2.39.2

