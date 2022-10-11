Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02D4F5FA8F3
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 02:09:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229886AbiJKAJa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 20:09:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbiJKAJZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 20:09:25 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3C5B7B29F;
        Mon, 10 Oct 2022 17:09:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1665446964; x=1696982964;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MrhwlQAfhZGplfbn4CVVzacAfeIm/Sjcv9oTY6XARX4=;
  b=gAD36LpA+Cq+ePYmwywbdYnk7JiKlZjkRXs3dIYoYSjx8vjBMbuxLusQ
   /XxoDMdH0EWl9Av3MYGEiVxV+rTumkt9uQi7M6+3dliDdIca0COUfRKVf
   ROmdWqlH8n+OAOnHocH5Rim0c7bmGme3dVMhjbUQAgaqYoxnuZsxn1PBs
   o=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 10 Oct 2022 17:09:24 -0700
X-QCInternal: smtphost
Received: from nasanex01b.na.qualcomm.com ([10.46.141.250])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2022 17:09:24 -0700
Received: from hu-eberman-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Mon, 10 Oct 2022 17:09:23 -0700
From:   Elliot Berman <quic_eberman@quicinc.com>
To:     Bjorn Andersson <quic_bjorande@quicinc.com>,
        Arnd Bergmann <arnd@arndb.de>
CC:     Elliot Berman <quic_eberman@quicinc.com>,
        Murali Nalajala <quic_mnalajal@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        "Srivatsa Vaddagiri" <quic_svaddagi@quicinc.com>,
        Carl van Schaik <quic_cvanscha@quicinc.com>,
        Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>,
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
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        <devicetree@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v5 03/13] gunyah: Common types and error codes for Gunyah hypercalls
Date:   Mon, 10 Oct 2022 17:08:30 -0700
Message-ID: <20221011000840.289033-4-quic_eberman@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221011000840.289033-1-quic_eberman@quicinc.com>
References: <20221011000840.289033-1-quic_eberman@quicinc.com>
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

Add architecture-independent standard error codes, types, and macros for
Gunyah hypercalls.

Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
---
 MAINTAINERS                  |  1 +
 include/asm-generic/gunyah.h | 74 ++++++++++++++++++++++++++++++++++++
 2 files changed, 75 insertions(+)
 create mode 100644 include/asm-generic/gunyah.h

diff --git a/MAINTAINERS b/MAINTAINERS
index ef6de7599d98..4fe8cec61551 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8886,6 +8886,7 @@ L:	linux-arm-msm@vger.kernel.org
 S:	Supported
 F:	Documentation/devicetree/bindings/firmware/gunyah-hypervisor.yaml
 F:	Documentation/virt/gunyah/
+F:	include/asm-generic/gunyah.h
 
 HABANALABS PCI DRIVER
 M:	Oded Gabbay <ogabbay@kernel.org>
diff --git a/include/asm-generic/gunyah.h b/include/asm-generic/gunyah.h
new file mode 100644
index 000000000000..64a02dd3b5ad
--- /dev/null
+++ b/include/asm-generic/gunyah.h
@@ -0,0 +1,74 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2022 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#ifndef _ASM_GUNYAH_H
+#define _ASM_GUNYAH_H
+
+#include <linux/types.h>
+#include <linux/errno.h>
+
+/* Common Gunyah macros */
+#define GH_CAPID_INVAL	U64_MAX
+#define GH_VMID_ROOT_VM	0xff
+
+#define GH_ERROR_OK			0
+
+#define GH_ERROR_UNIMPLEMENTED		-1
+#define GH_ERROR_RETRY			-2
+
+#define GH_ERROR_ARG_INVAL		1
+#define GH_ERROR_ARG_SIZE		2
+#define GH_ERROR_ARG_ALIGN		3
+
+#define GH_ERROR_NOMEM			10
+
+#define GH_ERROR_ADDR_OVFL		20
+#define GH_ERROR_ADDR_UNFL		21
+#define GH_ERROR_ADDR_INVAL		22
+
+#define GH_ERROR_DENIED			30
+#define GH_ERROR_BUSY			31
+#define GH_ERROR_IDLE			32
+
+#define GH_ERROR_IRQ_BOUND		40
+#define GH_ERROR_IRQ_UNBOUND		41
+
+#define GH_ERROR_CSPACE_CAP_NULL	50
+#define GH_ERROR_CSPACE_CAP_REVOKED	51
+#define GH_ERROR_CSPACE_WRONG_OBJ_TYPE	52
+#define GH_ERROR_CSPACE_INSUF_RIGHTS	53
+#define GH_ERROR_CSPACE_FULL		54
+
+#define GH_ERROR_MSGQUEUE_EMPTY		60
+#define GH_ERROR_MSGQUEUE_FULL		61
+
+static inline int gh_remap_error(int gh_error)
+{
+	switch (gh_error) {
+	case GH_ERROR_OK:
+		return 0;
+	case GH_ERROR_NOMEM:
+		return -ENOMEM;
+	case GH_ERROR_DENIED:
+	case GH_ERROR_CSPACE_CAP_NULL:
+	case GH_ERROR_CSPACE_CAP_REVOKED:
+	case GH_ERROR_CSPACE_WRONG_OBJ_TYPE:
+	case GH_ERROR_CSPACE_INSUF_RIGHTS:
+	case GH_ERROR_CSPACE_FULL:
+		return -EACCES;
+	case GH_ERROR_BUSY:
+	case GH_ERROR_IDLE:
+		return -EBUSY;
+	case GH_ERROR_IRQ_BOUND:
+	case GH_ERROR_IRQ_UNBOUND:
+	case GH_ERROR_MSGQUEUE_FULL:
+	case GH_ERROR_MSGQUEUE_EMPTY:
+		return -EPERM;
+	default:
+		return -EINVAL;
+	}
+}
+
+#endif
-- 
2.25.1

