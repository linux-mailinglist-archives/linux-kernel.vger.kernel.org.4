Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E47DD5EE659
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 22:01:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234805AbiI1UBB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 16:01:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234739AbiI1UAR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 16:00:17 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CC4F64DF;
        Wed, 28 Sep 2022 12:59:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1664395175; x=1695931175;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6oQz+Ilwb7H/uceQOKMBX7gSuoaNnlVyYZlEI3/uvrQ=;
  b=aiPeCHsHtkjPsNYRnqcnJT0n4dZ3mHC74j1G/3cO4B9lW90B8itMWJ4b
   W7VLhKcYLOF5pk6JUmqYpWdXfwVBeSnvo4I42bUZ0990SxH9Zw33Bro4T
   8YVLstxbHVtveHTS+jlIk3lfkw4rxMajk4NwI2tleM87aOBoDW+YlnzC+
   U=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 28 Sep 2022 12:57:32 -0700
X-QCInternal: smtphost
Received: from nasanex01b.na.qualcomm.com ([10.46.141.250])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2022 12:57:32 -0700
Received: from hu-eberman-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Wed, 28 Sep 2022 12:57:31 -0700
From:   Elliot Berman <quic_eberman@quicinc.com>
To:     Bjorn Andersson <quic_bjorande@quicinc.com>
CC:     Elliot Berman <quic_eberman@quicinc.com>,
        Murali Nalajala <quic_mnalajal@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        "Srivatsa Vaddagiri" <quic_svaddagi@quicinc.com>,
        Carl van Schaik <quic_cvanscha@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        <linux-arm-kernel@lists.infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "Will Deacon" <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Arnd Bergmann" <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <devicetree@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 13/14] gunyah: rsc_mgr: Add auxiliary devices for console
Date:   Wed, 28 Sep 2022 12:56:32 -0700
Message-ID: <20220928195633.2348848-14-quic_eberman@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220928195633.2348848-1-quic_eberman@quicinc.com>
References: <20220928195633.2348848-1-quic_eberman@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Gunyah resource manager exposes a concrete functionalities which
complicate a single resource manager driver. Use auxiliary bus
to help split high level functions for the resource manager and keep the
primary resource manager driver focused on the RPC with RM itself.
Delegate Resource Manager's console functionality to the auxiliary bus.

Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
---
 drivers/virt/gunyah/Kconfig   |  1 +
 drivers/virt/gunyah/rsc_mgr.c | 21 +++++++++++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/drivers/virt/gunyah/Kconfig b/drivers/virt/gunyah/Kconfig
index 78deed3c4562..610c8586005b 100644
--- a/drivers/virt/gunyah/Kconfig
+++ b/drivers/virt/gunyah/Kconfig
@@ -17,6 +17,7 @@ config GUNYAH_RESORUCE_MANAGER
 	tristate "Gunyah Resource Manager"
 	select MAILBOX
 	select GUNYAH_MESSAGE_QUEUES
+	select AUXILIARY_BUS
 	default y
 	help
 	  The resource manager (RM) is a privileged application VM supporting
diff --git a/drivers/virt/gunyah/rsc_mgr.c b/drivers/virt/gunyah/rsc_mgr.c
index 7f7e89a6436b..435fe0149915 100644
--- a/drivers/virt/gunyah/rsc_mgr.c
+++ b/drivers/virt/gunyah/rsc_mgr.c
@@ -16,6 +16,7 @@
 #include <linux/notifier.h>
 #include <linux/workqueue.h>
 #include <linux/completion.h>
+#include <linux/auxiliary_bus.h>
 #include <linux/gunyah_rsc_mgr.h>
 #include <linux/platform_device.h>
 
@@ -98,6 +99,8 @@ struct gh_rsc_mgr {
 	struct mutex send_lock;
 
 	struct work_struct recv_work;
+
+	struct auxiliary_device console_adev;
 };
 
 static struct gh_rsc_mgr *__rsc_mgr;
@@ -573,13 +576,31 @@ static int gh_rm_drv_probe(struct platform_device *pdev)
 
 	__rsc_mgr = rsc_mgr;
 
+	rsc_mgr->console_adev.dev.parent = &pdev->dev;
+	rsc_mgr->console_adev.name = "console";
+	ret = auxiliary_device_init(&rsc_mgr->console_adev);
+	if (ret)
+		goto err_msgq;
+	ret = auxiliary_device_add(&rsc_mgr->console_adev);
+	if (ret)
+		goto err_console_adev_uninit;
+
 	return 0;
+
+err_console_adev_uninit:
+	auxiliary_device_uninit(&rsc_mgr->console_adev);
+err_msgq:
+	gunyah_msgq_remove(&rsc_mgr->msgq);
+	return ret;
 }
 
 static int gh_rm_drv_remove(struct platform_device *pdev)
 {
 	struct gh_rsc_mgr *rsc_mgr = platform_get_drvdata(pdev);
 
+	auxiliary_device_delete(&rsc_mgr->console_adev);
+	auxiliary_device_uninit(&rsc_mgr->console_adev);
+
 	__rsc_mgr = NULL;
 
 	mbox_free_channel(gunyah_msgq_chan(&rsc_mgr->msgq));
-- 
2.25.1

