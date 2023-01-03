Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A17BA65C88A
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 22:02:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230212AbjACVCf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 16:02:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238641AbjACVCT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 16:02:19 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2078.outbound.protection.outlook.com [40.107.94.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0432314026;
        Tue,  3 Jan 2023 13:02:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B4x2ejntCzSjmNB1zZ59Ypq/JbinX7uaB669IcD2DMlaZly+orfSf9J7ymUVdRDAi2tZXYkmXjPRS0ZirKxiZneW3H8113RYKjrt+iqutPXOJ+ZMmH+5YFhBdq9wwVCCIKELdW35/VPRrdKY4sfrNHZ3Yk7c6+aRwxtaeL/PMVbAjvKDYMzB2Md84ZO71EHD60znPknZJMY0+yZR2FMGQjr4SkO0zLm/mmaB95V5Y9A+zilTwFRrZUec7Z9/1DB5Ryg5nTo2HC8YGhdtsdAQ/67BuwMiUUUnaqv+fqAtWHRX2BwDiswUDjYZ/gIsGK0Z+bPUMpOVzfzAa7ekEJVOmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gDvo+Yo3SgHnW+TkukKTvC6Z7O38C34tarW/+4dD2n4=;
 b=gJVtcKFB5bBn6oYT1GxYV8xzdbm8CtSnbn0qFNWTO0t3iGSxzE1ikYZR5ufLpKvShOW2Z87qt89Wv4D/Qp3h6U9pkg8R96Sk6cTqKHKYYz0DkBLINoHHca/a7h9DB/Aqq/cM460Sc61bXtQiQxhTB/9QSp90WYjQwJ0NcWw1Z19Y6QwS/TMw91DiLWwz7zeiRiucOGIrhNBoeeeiGwf8/IGXOFyuANbFj59CCqAg+sqDs0TL/VVvmFGuHU880BXpDfWayq2ywHsL1FFGDawiZXl5OzygG9Sk1KN0SZ7AsVUOfY7aonRjZ61j1s3bJq0bTD6Wd0fx4CQUfSElWw9z4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gDvo+Yo3SgHnW+TkukKTvC6Z7O38C34tarW/+4dD2n4=;
 b=gQOJ1lWKOtqEvshSepf7UqS+PcON3oTiqU96AyCVHfT0S6YT5kbSQ6M9noXcxfTXjQOSTiN7oFTMAUBD55vUJW4PzOj/d38FCHF5c9hi3F8rSYIsF4GYMCctjfeTmGiXvMdLdKfD5CofX7Af45lCiZpiAOQTx225nF1Q2khdy6U=
Received: from DM6PR13CA0014.namprd13.prod.outlook.com (2603:10b6:5:bc::27) by
 PH7PR12MB8179.namprd12.prod.outlook.com (2603:10b6:510:2b8::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Tue, 3 Jan
 2023 21:02:13 +0000
Received: from DM6NAM11FT070.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:bc:cafe::18) by DM6PR13CA0014.outlook.office365.com
 (2603:10b6:5:bc::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.14 via Frontend
 Transport; Tue, 3 Jan 2023 21:02:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT070.mail.protection.outlook.com (10.13.173.51) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5966.17 via Frontend Transport; Tue, 3 Jan 2023 21:02:13 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 3 Jan
 2023 15:02:10 -0600
From:   Robert Richter <rrichter@amd.com>
To:     Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>
CC:     Robert Richter <rrichter@amd.com>, <linux-cxl@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] cxl/pci: Show opcode in debug messages when sending a command
Date:   Tue, 3 Jan 2023 22:01:50 +0100
Message-ID: <20230103210151.1126873-1-rrichter@amd.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT070:EE_|PH7PR12MB8179:EE_
X-MS-Office365-Filtering-Correlation-Id: a390916f-4d18-459a-bb60-08daedcdc99a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rWdLhmBaW0En1600fQ3SF9bkGlJyGg8CpekmW5va+oIcAM7i5Vw5pVg08vQ5TaOWlW4zYTTTGEPqh9YsjSSDgrW5fXktOgpOGabC8a2CEeWOMS4DH0r0ZlfPWH3tGP6Cfnvwft3gUS5RtgqVpp02DgOJK4+1foIyrLL5rRbLIOV3hqmWZSxMXR5yTgo3q4TYVT7ggab2wOZgCSO4vGENo2Kuw/pTjkGZeLGM/fRRv+4oMqkz5UesCY71ZLuTKPiWLvLbR+E+S25ZSCJ54NrkWXEl+AvSxCKG8Zcj0v2cDKlaOERe6ywAIld/T11uj0t/dUkndKkrctC/VMSq6KJaoKbosh17GU3XmfsIB8yNTqafoHdknZg0Deen2jPeGXD7t1ZEq9t5oe5nDm4rf94Dy3NPVG4tfrn3YRDoskyZ4W3x1PWzpKAJSLjifptPH5AYvnvBzGm+hqgUquEoXPrJMnpCTUvut6ib4U2eNAVX/JXI2OzYe+/MIilnlIq7vCXh+6qXJYZJ2ss9SH+WCRDNt7wy0JWr1Fb1yI6WLKFVQ8dmgiFf+5WMw7pQq97/IFn7tBl3gMsfA2YtVavxhr977gCiaHBFyZyVgIbUOGbUThkzKf8x+a02d3EwheFgCBFtflQARqtVkOAlemjUljbT08V9ISeZbI8sCTJhprvx4HAh6v6a0HW5qk6ZbYkveefqTIV5lIHFHLpkkYPcEgGskVGiowFX6p/iQu0b1FyF6mwHjWIiGmhtktDg7tHz4SElis+JfdbVruUqkpph/ScaRQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(396003)(346002)(136003)(376002)(39860400002)(451199015)(46966006)(36840700001)(40470700004)(83380400001)(47076005)(426003)(1076003)(336012)(16526019)(26005)(82310400005)(6666004)(40480700001)(40460700003)(36860700001)(36756003)(81166007)(82740400003)(356005)(2616005)(186003)(478600001)(15650500001)(41300700001)(8676002)(4326008)(2906002)(5660300002)(8936002)(4744005)(316002)(70586007)(70206006)(110136005)(54906003)(22166006)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2023 21:02:13.2161
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a390916f-4d18-459a-bb60-08daedcdc99a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT070.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8179
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For debugging it is very helpful to see which commands are sent. Add
it to the debug message.

Signed-off-by: Robert Richter <rrichter@amd.com>
---
 drivers/cxl/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 33083a522fd1..316089a393d0 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -162,7 +162,7 @@ static int __cxl_pci_mbox_send_cmd(struct cxl_dev_state *cxlds,
 	writeq(cmd_reg, cxlds->regs.mbox + CXLDEV_MBOX_CMD_OFFSET);
 
 	/* #4 */
-	dev_dbg(dev, "Sending command\n");
+	dev_dbg(dev, "Sending command: 0x%04x\n", mbox_cmd->opcode);
 	writel(CXLDEV_MBOX_CTRL_DOORBELL,
 	       cxlds->regs.mbox + CXLDEV_MBOX_CTRL_OFFSET);
 
-- 
2.30.2

