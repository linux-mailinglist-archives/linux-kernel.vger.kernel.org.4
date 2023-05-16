Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCEFB704FB6
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 15:45:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233758AbjEPNp0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 09:45:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233747AbjEPNpX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 09:45:23 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2085.outbound.protection.outlook.com [40.107.223.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A8277284
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 06:45:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FnxHrrPy2HI1nRte2joHcDXjgRdudf/doGRmyNP6R21W4KvthMk1/s041izJfuHOvALW/PEZA2+TFg7dMl6kCV+pXbeBwEOFH10KFOxBnNmV/fEYXaOYglQqUB6X9LYMn0bUsJpEWIxcdAL8dHkFHGMipZ+i0GNktw5sLDzwTgLjMU965SknwHjtzNMN1f15dQ3lCaqPCq0NycjoCazvaGlDa9G5ANLf56vKg0ZTQnD5ptTZS48HY35yVBMWeA4ikkZrgC9saa86l+F9DEYztP4xmob0LW8y2QGbxgpP0jUZFP0H5ssMQ1eYC/74JFjeiJ0UjdoEu17tSrSJmyHM9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dirKoxDCtCRF31u0L3RhJj6VdD/51wAlPbs3Da0WNPE=;
 b=CjXqSiHsD6Wybenp+p+X+K8RvrwE5BY5FYRIbwPIL+WB1Zg/x2CtdBeY5BXL0YRlO/ysfP3a1SbZq9pyj/qcu1NDi9GQ9cp00LcFhDZw2MwOERMggq8SzxPiHhSGQMBFr/ZMiYYN8/uEO0ZP0GAe4YGBegj3wwvZo+0A1KzVkrqid1XPnw38FwjLa0njpIb5BfWk1/0+4qN+LRqm4dUli7zUAqkekGllaw8APRp+9k6SN5rvnJF2JOThLFWyR4/020XL1CZLirVd+pGs/1jEgTdyP2eVSWkJrOeZcb1daDQUh9ZaVlNHDQ88Ed89gRxW9s5nAmkoFzfcfXlbps/L1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dirKoxDCtCRF31u0L3RhJj6VdD/51wAlPbs3Da0WNPE=;
 b=C+lkPhRQ3yIHQ86AvXk8NK9YU7X1K7f/IADOPTBOrHzFLdpzidb432lAJfBNxIjVrmD34LaoAhEHuVqQLts8bLZKn40pxUqYxtdcEgFnzkbRI+dhTMqUaA0qiNidjtRrEGVtTz7O/5VdCQyzSNde3di3dV9i/0HkEx/GTBiEW30=
Received: from MW4PR03CA0188.namprd03.prod.outlook.com (2603:10b6:303:b8::13)
 by SA1PR12MB7319.namprd12.prod.outlook.com (2603:10b6:806:2b5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Tue, 16 May
 2023 13:45:13 +0000
Received: from CO1NAM11FT106.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b8:cafe::6d) by MW4PR03CA0188.outlook.office365.com
 (2603:10b6:303:b8::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.33 via Frontend
 Transport; Tue, 16 May 2023 13:45:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT106.mail.protection.outlook.com (10.13.175.44) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.15 via Frontend Transport; Tue, 16 May 2023 13:45:13 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 16 May
 2023 08:45:11 -0500
From:   Michal Simek <michal.simek@amd.com>
To:     <nava.kishore.manne@amd.com>, <linux-kernel@vger.kernel.org>,
        <monstr@monstr.eu>, <michal.simek@xilinx.com>, <git@xilinx.com>
CC:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH] nvmem: zynqmp: Switch @xilinx.com emails to @amd.com
Date:   Tue, 16 May 2023 15:45:03 +0200
Message-ID: <28f30fb7695d8719b45edebb9a01508f8d7e5e30.1684244701.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=845; i=michal.simek@amd.com; h=from:subject:message-id; bh=fA7YHyQv3SFO29R/Gl2qYvIKEhvHY2d1rUCCWIFlhU8=; b=owGbwMvMwCR4yjP1tKYXjyLjabUkhpTkjrsZ2v+OFnw6o3A5iP2T7fovD08+vvbp7nX3efuab 53U3rTkbkcsC4MgE4OsmCKLtM2VM3srZ0wRvnhYDmYOKxPIEAYuTgGYyFw2hvlpu1L3nN0vPUU4 XmCt+aLNe9T6tQUY5rvaRj9hj+158f7l5427zgdfF+P5dQIA
X-Developer-Key: i=michal.simek@amd.com; a=openpgp; fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT106:EE_|SA1PR12MB7319:EE_
X-MS-Office365-Filtering-Correlation-Id: e458c607-c57e-4ba2-3e67-08db5613c63c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6Shxxi8zUNiQFmmfwjSnoIQO0QZ0YWfr7PUlY4tguCbi0iIhZaWS6rulGXAx2RzdC+7hxzCZnJx0qsEGnz5gUrc9W5kZR5jXP/xtjVEMTkLIaJ9BDFNgkAJf9+ZWS0zOC2JjFaBU1vj2SzPjLy0Txpu1xXNNAFVoTEKgjghcPV98HkdV+6CqcMvb3MeldDPCo1CVxFqkmzKYkvQSO1eO9y572TKPTSnGYgdLkxizeacENEKwVgutaqRbNbT0Hdz0kVXcZX57Q8fldV7Z+zf03i1Wcc+psZH23b6rMIy9liRY9KnI5u1XQhVwVCX+A7IsNtLgQCrQXGOicmORz+V5DAuYv7UoLPxq4Dj+F2M0i1SHW4DCzjMSTEiDVcep9qVbnTCZk1J4QT/RH7LcP65OS774cmSPWGknIt1ecEahWUji5A0TUq/J2m6Upj/F+se8aC/HiIgyosDFF1qdSjtOtVpTylWsX5brRTdXNr7ckNW1dFO/3CwXCme6xGcDA4Ureav4n4tTu1pD9mdZJVlBWXGw8+DzA6wodBhYHeyaSTFpBCI1ooVwqABOis+U9Ld6TXyq1Vwb8ZNY8UL+MglNtVLmEG1oD7oahcEjA7Z77BST8QR+9upqIW4DuO1WSQ3f8ek/Gb+20gzuoBrGBCJAUMNMGx2laNQz+/A4oOq1soTR7+Vr6fIVnbjVImJ9/z+9u8oQTVO81Kv8zmTEXx6Ka+K2d0oI+tyaPKV8TEC1X/0Aq6DJtLaLtn4w+Ek/yTJ+JgObZtbRqR5YqJg/8JvauWTLfK6cJuJKBF7bfCmG8YE=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(39860400002)(396003)(376002)(451199021)(40470700004)(46966006)(36840700001)(44832011)(478600001)(40460700003)(54906003)(110136005)(8676002)(86362001)(8936002)(5660300002)(36756003)(2906002)(4744005)(82310400005)(70586007)(4326008)(70206006)(82740400003)(356005)(40480700001)(81166007)(316002)(41300700001)(36860700001)(47076005)(186003)(16526019)(2616005)(26005)(83380400001)(336012)(426003)(6666004)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2023 13:45:13.1542
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e458c607-c57e-4ba2-3e67-08db5613c63c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT106.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7319
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

@xilinx.com is still working but better to switch to new amd.com after
AMD/Xilinx acquisition.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 drivers/nvmem/zynqmp_nvmem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvmem/zynqmp_nvmem.c b/drivers/nvmem/zynqmp_nvmem.c
index e28d7b133e11..f49bb9a26d05 100644
--- a/drivers/nvmem/zynqmp_nvmem.c
+++ b/drivers/nvmem/zynqmp_nvmem.c
@@ -76,6 +76,6 @@ static struct platform_driver zynqmp_nvmem_driver = {
 
 module_platform_driver(zynqmp_nvmem_driver);
 
-MODULE_AUTHOR("Michal Simek <michal.simek@xilinx.com>, Nava kishore Manne <navam@xilinx.com>");
+MODULE_AUTHOR("Michal Simek <michal.simek@amd.com>, Nava kishore Manne <nava.kishore.manne@amd.com>");
 MODULE_DESCRIPTION("ZynqMP NVMEM driver");
 MODULE_LICENSE("GPL");
-- 
2.36.1

