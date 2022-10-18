Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD0C4602CD5
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 15:24:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230391AbiJRNYQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 09:24:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbiJRNYN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 09:24:13 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2079.outbound.protection.outlook.com [40.107.94.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 563C6C90DC;
        Tue, 18 Oct 2022 06:24:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f4m6zYIVdFVTkQag0r1wcRHykMFLI+EC+1oxOgXVJqmGCmV7KXUHWNXl0hwBV3ZqWLha5nMP/wf5dQsi99i4jfViKLxlNdJzc9NgDuHmpEmryeimE8p3cmHw5FgAt7gzlyZIb3m/m/cG5vTpYdpp2UREXGqGZK85fg1iEv6QmRFdWZYQo4RHn4dc6TAs9KAXE+ZGfm39l9mBQsH4PyAmIQITq3LPfZSaRMTIaGS4kwOMDExo0wpbzb7Dc0NdWQEEeu35Byp0PdTwidgDrR0yQ3Erdr/YWEA8+jcPhS2gISSI11z8PPkZN2YwfW2DJF1POQwIPydWb8UTDIHVrVdvsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f/a9B99D9lL5e4OLFYu9Rds+YYIxrhyEH/lIibAjCuc=;
 b=Jd1G3itwddBUPSmh3CD6OFAfvUAocMdM6pX8GpfnSh3XlwDcn8k70y2RX1zhqAy3HBl6DcVlt3Ruz1Z4/bKeCvjVXtGefUskq189pqgI3Ft/BE46JBdLxF45Jf2cgbyLBkqXdA6R2Q0iwproJfqZveNp2DsttudKpMgAkVijXXPwOCqqQgzJCP+zFiOLkNh5yiN8vGNy2KjBy4C8KGdG8waCMI2dLw+QV4ie+N6Kji8+7jaDP+AbA/Ld6lq49PHZLub3vfQIX7M/Hoh3fzT+tQ3BRzHSqOPwt8poj9/Fa6slLm1hash+5cIiL3LDA5sHE22j1mU+5K4eaOXdaG1tdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f/a9B99D9lL5e4OLFYu9Rds+YYIxrhyEH/lIibAjCuc=;
 b=gsuadDpu/BBZL7lgDFf3kZlGQolagQCYIC+tjf/GTu2PXxl6EtWXlxx3rspCQ3O8UAHpkn6R8OfR8gIlrfcaRKihipwJyy1RUlDsSoV4qHUef7+e0LrN08KZliNHFhYMYL4EEtJasYsdK5J+gtT2TUxl+42Y9/dw0Pq7KHf+b68=
Received: from BN9PR03CA0982.namprd03.prod.outlook.com (2603:10b6:408:109::27)
 by DS7PR12MB6214.namprd12.prod.outlook.com (2603:10b6:8:96::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.33; Tue, 18 Oct
 2022 13:24:08 +0000
Received: from BN8NAM11FT033.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:109:cafe::b2) by BN9PR03CA0982.outlook.office365.com
 (2603:10b6:408:109::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.30 via Frontend
 Transport; Tue, 18 Oct 2022 13:24:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT033.mail.protection.outlook.com (10.13.177.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5723.20 via Frontend Transport; Tue, 18 Oct 2022 13:24:08 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 18 Oct
 2022 08:24:05 -0500
From:   Robert Richter <rrichter@amd.com>
To:     Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        "Davidlohr Bueso" <dave@stgolabs.net>,
        Robert Richter <rrichter@amd.com>,
        "kernel test robot" <lkp@intel.com>
Subject: [PATCH v2 01/12] cxl/core: Remove duplicate declaration of devm_cxl_iomap_block()
Date:   Tue, 18 Oct 2022 15:23:29 +0200
Message-ID: <20221018132341.76259-2-rrichter@amd.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221018132341.76259-1-rrichter@amd.com>
References: <20221018132341.76259-1-rrichter@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT033:EE_|DS7PR12MB6214:EE_
X-MS-Office365-Filtering-Correlation-Id: df98865c-7bc1-41b2-50aa-08dab10c0978
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +QjmsPqXIgcFQ1yCSlA1XCmF5MhTj6JvfvMQHVUHRBDNk18wz2qR+mxRELEcaROu6t02d9EVeQVqjkkiymfsJp2u/JGJUA1VAXKrFdbo11mDwQ2/UlM8ZiHuECg5H+qa685YU2HxerQsuKfM5KrdkyIZR85ExGrWjT2wtcQFem8F7EAhwKyekCe2EMxmMIWjRLrFriUJnbQLDRPNpr5TorQRlPPiusujpnIGJPR3mraTz8HFbJSLu241j+DaFFfsUoMjlYusqViEvDuXq5Xuly0B0Lk8tVoSkW+Ro1Zyrx1VOcLJqKYBUqP8V2ZnINmGyMoIwIYIJZgw4QZcT0W1FFDEp8epXTQ/ISscBCGYZd0a16CmfeHODVNXNyiw5GVq9a/Vr7V4nSulPh2hPZx6qDGeRLTUwPBgZ1KXRb1HpXWIBX8SoJg8lmGuzQAu/W1Rl67w6aMSeHiBat57tXtUR86t93ijnQAif99W1q5/mjHetNePf66n8PRTZsdDzgYg/yJDRcr30k8IP05GkFvRY1z30ORhoc8RnuMMBni7NXJ5q6QnrM6ibXPT4H45HNxtBct+UzRSC2NOwEIcPkw1KtbA7HXmgb83o72nEzAisCQxz4ACDKBLqZFadnouCQ0a9Tau3JuGl3NzhUnieyeQZFrMGidrvbS9s4qIWhfxG+6a2q/vJ5jkcGRyqvNSZez6URDj8loHdnZ+NlAacj/qLcgZSi8k2exDTALaV9RDkWUKARabCd37Rc2ZJwn2vM6FNOTJQOqxBr2DblwjkuGUrXNPn4KbosKx3rYxOj+NawNxMgK8A4QwN4K/X24btSK5
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(136003)(376002)(396003)(346002)(451199015)(46966006)(36840700001)(40470700004)(40480700001)(54906003)(316002)(110136005)(478600001)(6666004)(41300700001)(26005)(8676002)(4326008)(8936002)(2616005)(36756003)(5660300002)(70586007)(70206006)(2906002)(186003)(1076003)(16526019)(7416002)(83380400001)(81166007)(356005)(40460700003)(36860700001)(47076005)(426003)(336012)(82740400003)(82310400005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2022 13:24:08.2481
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: df98865c-7bc1-41b2-50aa-08dab10c0978
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT033.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6214
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function devm_cxl_iomap_block() is only used in the core
code. There are two declarations in header files of it, in
drivers/cxl/core/core.h and drivers/cxl/cxl.h. Remove its unused
declaration in drivers/cxl/cxl.h.

Fixing build error in regs.c found by kernel test robot by including
"core.h" there.

Signed-off-by: Robert Richter <rrichter@amd.com>
Reported-by: kernel test robot <lkp@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/core/regs.c | 2 ++
 drivers/cxl/cxl.h       | 2 --
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
index 39a129c57d40..6522931df3f7 100644
--- a/drivers/cxl/core/regs.c
+++ b/drivers/cxl/core/regs.c
@@ -7,6 +7,8 @@
 #include <cxlmem.h>
 #include <cxlpci.h>
 
+#include "core.h"
+
 /**
  * DOC: cxl registers
  *
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index f680450f0b16..ac8998b627b5 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -218,8 +218,6 @@ int cxl_map_device_regs(struct pci_dev *pdev,
 enum cxl_regloc_type;
 int cxl_find_regblock(struct pci_dev *pdev, enum cxl_regloc_type type,
 		      struct cxl_register_map *map);
-void __iomem *devm_cxl_iomap_block(struct device *dev, resource_size_t addr,
-				   resource_size_t length);
 
 #define CXL_RESOURCE_NONE ((resource_size_t) -1)
 #define CXL_TARGET_STRLEN 20
-- 
2.30.2

