Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3014622FA3
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 17:07:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231185AbiKIQH3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 11:07:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbiKIQH2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 11:07:28 -0500
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DB6120F53
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 08:07:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1668010046;
  x=1699546046;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=YgabzxKTXgysBcMfO1IfjanutclXzioMtt7d8m0oLoE=;
  b=Nqxhv9yhr1XAjrbDa00ZEOjdWBPN8fNZS/NnhGET3Qc4do3kQYAv/OOx
   9ze8XChcC6Lcx9mZmNcRlM7hfmr5pPo1jAFHzQVSyRNb1eXJUBh2Qgfc4
   2l1H4rifEtd9XwcQEpAUEida8KxedmV416sTfKkanLKORBxEUTgrmbs6R
   Ej5ovwFTCoCfck/dgaLHTr4aFRBpqxcyimh7wzrC5LRYKvq1qJdgO9H3R
   Vo+kDULP+XbgwZqsSN4deM7kHE1I/YbkBj6dYMCjlbbXd0huHpXVVHbc7
   OeSgIVEVFjQJ6PNYET8MWj56H7CVsP69+F3khraBGhzqwVgPeC4T+2YFq
   g==;
From:   =?UTF-8?q?Ludvig=20P=C3=A4rsson?= <ludvig.parsson@axis.com>
To:     Jens Wiklander <jens.wiklander@linaro.org>
CC:     <kernel@axis.com>,
        =?UTF-8?q?Ludvig=20P=C3=A4rsson?= <ludvig.parsson@axis.com>,
        Sumit Garg <sumit.garg@linaro.org>,
        <op-tee@lists.trustedfirmware.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] tee: optee: Populate child nodes in probe function
Date:   Wed, 9 Nov 2022 17:07:08 +0100
Message-ID: <20221109160708.507481-1-ludvig.parsson@axis.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently there is no dependency between the "linaro,scmi-optee" driver
and the tee_core. If the scmi-optee driver gets probed before the
tee_bus_type is initialized, then we will get an unwanted error print.

This patch enables putting scmi-optee nodes as children to the optee
node in devicetree, which indirectly creates the missing dependency.

Signed-off-by: Ludvig Pärsson <ludvig.parsson@axis.com>
---
 drivers/tee/optee/smc_abi.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/tee/optee/smc_abi.c b/drivers/tee/optee/smc_abi.c
index a1c1fa1a9c28..be6f02fd5a7f 100644
--- a/drivers/tee/optee/smc_abi.c
+++ b/drivers/tee/optee/smc_abi.c
@@ -1533,6 +1533,11 @@ static int optee_probe(struct platform_device *pdev)
 	if (rc)
 		goto err_disable_shm_cache;
 
+	/* Populate any dependent child node (if any) */
+	rc = devm_of_platform_populate(&pdev->dev);
+	if (rc)
+		goto err_disable_shm_cache;
+
 	pr_info("initialized driver\n");
 	return 0;
 
-- 
2.30.2

