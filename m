Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EFAA6B3A8D
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 10:32:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230102AbjCJJcf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 04:32:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229929AbjCJJcH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 04:32:07 -0500
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E1E1F8F03
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 01:29:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1678440566; x=1709976566;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=syIX6OCm2m5QwIQSEcFQtWFJltEyQOmZDTDFEKeyNp8=;
  b=lWeWhChZ+bBYhs5XSaFWlodBOjLHKSssxmHufToGIma9jVfMwwFhhpfP
   UBhit4dqYYuhk19+v7gj/unDGY9YWHjhYw0/3MBAD6BuXQk3h+34TDc93
   /Mk82NjJb+sh0zLT3L5Hip8t9Scd8HqtLvmGHjN2tFM39UPdWcb+vaKC7
   I8AEgGiK6TdBzKKJHwoNgsArY311GAdkk1UZuJgsXypJ/vbgmUEWfq4Uz
   COOCGP+Sj5nq8IyX+OvPF2a/AVlol0QHFf/Pb4+pGK4qJJqKIWudWxkQZ
   SWcahTLP5xC5Kso+lh7fIY7E+2oE5EOTDNyvuDYNwhpj0FAv7E6THR6R4
   A==;
X-IronPort-AV: E=Sophos;i="5.98,249,1673910000"; 
   d="scan'208";a="29601737"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 10 Mar 2023 10:29:05 +0100
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Fri, 10 Mar 2023 10:29:04 +0100
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Fri, 10 Mar 2023 10:29:04 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1678440545; x=1709976545;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=syIX6OCm2m5QwIQSEcFQtWFJltEyQOmZDTDFEKeyNp8=;
  b=B/VAqFPNuulPon4/dPDylomZ6+QkbEgdTcEXYmAvKF6QCdq30QPLI9Jr
   74lW2Xj0VsawUMJjknrbvqJ6Pa6aIuofTtGJs0gE2fgrzshHmVb1B17Ip
   HFzRiJPao+n1PFY/uf5v4cNowEZ0sxeFb5l/Q5cj0XKG9YCmooIUodUuK
   MNP0O2p9SQbRWJIoz6aPQURAQ6xjXPAUrVZxxtSg/5u7gNWERiM0vrpwD
   GgWEi1OpOC1yLF+yd9YprMfHERCvlcFDjvaBzykAIDx0ax+U+kcJaLwTN
   UiarUr6bCheoORbtPN7hgqlp9qBGLZkNvWGI/bFnfAwmPwm6sU4NlPtwO
   g==;
X-IronPort-AV: E=Sophos;i="5.98,249,1673910000"; 
   d="scan'208";a="29601736"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 10 Mar 2023 10:29:04 +0100
Received: from steina-w.tq-net.de (unknown [10.123.53.21])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 41E01280056;
        Fri, 10 Mar 2023 10:29:04 +0100 (CET)
From:   Alexander Stein <alexander.stein@ew.tq-group.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Robin Gong <yibin.gong@nxp.com>
Cc:     Alexander Stein <alexander.stein@ew.tq-group.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] regulator: pca9450: Fix BUCK2 enable_mask
Date:   Fri, 10 Mar 2023 10:28:57 +0100
Message-Id: <20230310092857.3555187-1-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes a copy & paste error.

Fixes: 0935ff5f1f0a ("regulator: pca9450: add pca9450 pmic driver")
Originally-from: Robin Gong <yibin.gong@nxp.com>
Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
This diff is extracted from a downstream commit authored by Robin Gong.
I'm not sure if adding Originally-from: is enough here or I do have to
change From: as well.

 drivers/regulator/pca9450-regulator.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/pca9450-regulator.c b/drivers/regulator/pca9450-regulator.c
index c84d95b11e9c..544e741f7108 100644
--- a/drivers/regulator/pca9450-regulator.c
+++ b/drivers/regulator/pca9450-regulator.c
@@ -265,7 +265,7 @@ static const struct pca9450_regulator_desc pca9450a_regulators[] = {
 			.vsel_reg = PCA9450_REG_BUCK2OUT_DVS0,
 			.vsel_mask = BUCK2OUT_DVS0_MASK,
 			.enable_reg = PCA9450_REG_BUCK2CTRL,
-			.enable_mask = BUCK1_ENMODE_MASK,
+			.enable_mask = BUCK2_ENMODE_MASK,
 			.enable_val = BUCK_ENMODE_ONREQ_STBYREQ,
 			.ramp_reg = PCA9450_REG_BUCK2CTRL,
 			.ramp_mask = BUCK2_RAMP_MASK,
@@ -509,7 +509,7 @@ static const struct pca9450_regulator_desc pca9450bc_regulators[] = {
 			.vsel_reg = PCA9450_REG_BUCK2OUT_DVS0,
 			.vsel_mask = BUCK2OUT_DVS0_MASK,
 			.enable_reg = PCA9450_REG_BUCK2CTRL,
-			.enable_mask = BUCK1_ENMODE_MASK,
+			.enable_mask = BUCK2_ENMODE_MASK,
 			.enable_val = BUCK_ENMODE_ONREQ_STBYREQ,
 			.ramp_reg = PCA9450_REG_BUCK2CTRL,
 			.ramp_mask = BUCK2_RAMP_MASK,
-- 
2.34.1

