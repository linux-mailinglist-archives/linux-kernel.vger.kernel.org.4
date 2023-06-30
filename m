Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3AA374424B
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 20:34:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233113AbjF3SeY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 14:34:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbjF3SeP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 14:34:15 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8C9C4229;
        Fri, 30 Jun 2023 11:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688150054; x=1719686054;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tVvPfhy1pq/F5VIaRT5AzqUsJQrfr238yG1EqHj9ZCg=;
  b=QRrfJT04F7BuafSiynybP6fzgMVDmeWfQbIjtCGSrXtXV9+mTsjaj+pG
   gngr32B424SulTba877S3943ZaSchOj07M5fULn46YZbC1xnJzz6NxR2M
   j5HOMeeI+k3Bxx0dPav7Nt87AAmAdFa3SoypZmEjwAiGjkJddYHt4iN0c
   0m5QZzDSj43ipDKkukLrVMfkEb/57H8hBqpjUGeaoJ5RSqi53Er0lx9VZ
   pzKjTBfd6EUu55PLKeB676kmAR9rWbnzt2HinJvvg+5Opwsg+oEFe8vTm
   ZPc8y/0xAkJmzFB4rzICk4NDgW7R3vctYCv7hsqgw4M2ESLedMXe4VCbb
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10757"; a="365949934"
X-IronPort-AV: E=Sophos;i="6.01,171,1684825200"; 
   d="scan'208";a="365949934"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2023 11:34:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10757"; a="717896431"
X-IronPort-AV: E=Sophos;i="6.01,171,1684825200"; 
   d="scan'208";a="717896431"
Received: from powerlab.fi.intel.com ([10.237.71.25])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2023 11:34:10 -0700
From:   Michal Wilczynski <michal.wilczynski@intel.com>
To:     linux-acpi@vger.kernel.org
Cc:     rafael@kernel.org, dan.j.williams@intel.com,
        vishal.l.verma@intel.com, lenb@kernel.org, dave.jiang@intel.com,
        ira.weiny@intel.com, rui.zhang@intel.com,
        linux-kernel@vger.kernel.org, nvdimm@lists.linux.dev,
        Michal Wilczynski <michal.wilczynski@intel.com>
Subject: [PATCH v6 2/9] acpi/bus: Set driver_data to NULL every time .add() fails
Date:   Fri, 30 Jun 2023 21:33:37 +0300
Message-ID: <20230630183344.891077-3-michal.wilczynski@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230630183344.891077-1-michal.wilczynski@intel.com>
References: <20230630183344.891077-1-michal.wilczynski@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Most drivers set driver_data during .add() callback, but usually
they don't set it back to NULL in case of a failure. Set driver_data to
NULL in acpi_device_probe() to avoid code duplication.

Signed-off-by: Michal Wilczynski <michal.wilczynski@intel.com>
---
 drivers/acpi/bus.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index 2d6f1f45d44e..c087fd6e8398 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -1014,8 +1014,10 @@ static int acpi_device_probe(struct device *dev)
 		return -ENOSYS;
 
 	ret = acpi_drv->ops.add(acpi_dev);
-	if (ret)
+	if (ret) {
+		acpi_dev->driver_data = NULL;
 		return ret;
+	}
 
 	pr_debug("Driver [%s] successfully bound to device [%s]\n",
 		 acpi_drv->name, acpi_dev->pnp.bus_id);
-- 
2.41.0

