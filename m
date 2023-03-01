Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D51F46A6D5B
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 14:48:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229911AbjCANsM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 08:48:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjCANsK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 08:48:10 -0500
Received: from mail.kapsi.fi (mail.kapsi.fi [IPv6:2001:67c:1be8::25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93B8FCC2A;
        Wed,  1 Mar 2023 05:48:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
        s=20161220; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=Kd+nymaq2tPM+K80HnMXKwoP04WoIX8FOTWHoWNUJg8=; b=z+VMdF4/cpEtwZTVo9sHtzTRwf
        cvxdF6MCFRAkiDP6qMSnlHEPUG4Zb21Wuzbnqrx1uA8W/efKbmiP6LfIIiebdLOsoEtq+eGLG9JOc
        RtsbQZJsLJEZd2ndDQGkw6Um2/iLRH0Scsg9ebIZ6cvBI/Gj45zSNXGFQYAIhJFRpaS+TfO9HVcjJ
        dsM19AO359GBT9fu0ML/97xO33TLpSRw1rvaRPoqI4kDSfoQA6t1aRNrBBqXSsDnW65oxdnUgWeFZ
        4kT6/9TDT9neSCF5KacPq/bWx54UwL9tI01nEmSv3ORKxj4RW0DpZPGg/BWwcXWSIlAaSNCrJ9XYZ
        9v6eZIHQ==;
Received: from 91-158-25-70.elisa-laajakaista.fi ([91.158.25.70] helo=toshino.localdomain)
        by mail.kapsi.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <cyndis@kapsi.fi>)
        id 1pXMoQ-00Dvjx-Qs; Wed, 01 Mar 2023 15:48:06 +0200
From:   Mikko Perttunen <cyndis@kapsi.fi>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     Mikko Perttunen <mperttunen@nvidia.com>,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] soc/tegra: bpmp: Actually free memory on error path
Date:   Wed,  1 Mar 2023 15:47:56 +0200
Message-Id: <20230301134756.999169-2-cyndis@kapsi.fi>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230301134756.999169-1-cyndis@kapsi.fi>
References: <20230301134756.999169-1-cyndis@kapsi.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 91.158.25.70
X-SA-Exim-Mail-From: cyndis@kapsi.fi
X-SA-Exim-Scanned: No (on mail.kapsi.fi); SAEximRunCond expanded to false
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mikko Perttunen <mperttunen@nvidia.com>

Within the error path, genpd->domains has not been set, so we need
to pass the domains variable to kfree instead.

Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
---
 drivers/soc/tegra/powergate-bpmp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/tegra/powergate-bpmp.c b/drivers/soc/tegra/powergate-bpmp.c
index 8eaf50d0b6af..179ed895c279 100644
--- a/drivers/soc/tegra/powergate-bpmp.c
+++ b/drivers/soc/tegra/powergate-bpmp.c
@@ -286,7 +286,7 @@ static int tegra_bpmp_add_powergates(struct tegra_bpmp *bpmp,
 		tegra_powergate_remove(powergate);
 	}
 
-	kfree(genpd->domains);
+	kfree(domains);
 	return err;
 }
 
-- 
2.39.2

