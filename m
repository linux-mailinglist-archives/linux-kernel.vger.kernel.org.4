Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39B3269E6B1
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 19:00:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231582AbjBUSA5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 13:00:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbjBUSAy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 13:00:54 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2088.outbound.protection.outlook.com [40.107.243.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3F972C64C;
        Tue, 21 Feb 2023 10:00:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZXDXyehuNbQitNPomzzc/W8GeI/lQ7HSPM0um2dF8ovDjvonvg/vKE/dATpkkynHt4lX7hIBrHhA29XmFNnbr/6JIyeBQnKtO5rDYVKXHADBISROslmt7DLaIMeFQFAC/mefK6OYNuBp3crs/uoExtP6SzX5arDUnrC4TCbbm/mXCcOM5btInnv/cliGE+M6vxnhq0r4LgQKJMEopMVDo9V1nRps7YFtYwn0CfgRO8qgz3TiLsb4cXY4Bw1Bgnt1nk0W5YRqUMpc9m50HOBLS8lkdnQOMG5zDmfs9hq6+s3GcVTcqnNR3KFfvKzkq1ghJNmxNIMRGj7eFcwkS6UrnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BFf3qfIwQgnE00JUxncxe4pj6pAVHIyw2fhtE+NclkE=;
 b=PCJ3MmMxl277C2uilAl3xUWPuujNqyNO7t379kSHsmm5wmvq5hBs9BmYbMmT7E38/0lKt++c6ZQE1z/9ltfye1gzS4GYwFhlWDQElbDWYICar+2Yc5HBH8S3zb7SOpm/4GaUiM1EQ5/PoyByAH5kYuh6PxtjCJcGoHhZFz52UC6SHo5BSxNbh5xOAxRdDlTEJPL6BOA6qvyzNTgTs0uZEIJBNNUOXbk09puPVAmrkagtHhmk6mfRXkvwqg6SUuvxFi8rYVmWPc7h+oJCTdvvsGBHhSbghcSC4KEcAtFlIHcyIAE0MmEa0ibiCq8WOM9uVjUL+pVYUhPlDHxhhGoEhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BFf3qfIwQgnE00JUxncxe4pj6pAVHIyw2fhtE+NclkE=;
 b=bDeH8vLAXOMGyzr+yOPXC/SuaQev9O0Z07DzV6ctEpK8vhksXs3ffFL4pEOq0H4vPxhuLIlX3hcr7bv/QmdJsNejq4KZUsXWNew3y42QvVG3TFhR1UOOxtOoqB3eQ67btd9+Gkd7YM2IEzdJRnI7M2WUNMzt5okmLBjENhVt9fQ=
Received: from DM6PR02CA0158.namprd02.prod.outlook.com (2603:10b6:5:332::25)
 by SA0PR12MB4495.namprd12.prod.outlook.com (2603:10b6:806:70::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.21; Tue, 21 Feb
 2023 18:00:51 +0000
Received: from DS1PEPF0000E64E.namprd02.prod.outlook.com
 (2603:10b6:5:332:cafe::6a) by DM6PR02CA0158.outlook.office365.com
 (2603:10b6:5:332::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.21 via Frontend
 Transport; Tue, 21 Feb 2023 18:00:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS1PEPF0000E64E.mail.protection.outlook.com (10.167.18.4) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6134.14 via Frontend Transport; Tue, 21 Feb 2023 18:00:50 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 21 Feb
 2023 12:00:50 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 21 Feb
 2023 10:00:50 -0800
Received: from iron-maiden.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Tue, 21 Feb 2023 12:00:50 -0600
From:   Carlos Bilbao <carlos.bilbao@amd.com>
To:     <corbet@lwn.net>, <rlove@rlove.org>, <kaiwan.billimoria@gmail.com>
CC:     <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Carlos Bilbao <carlos.bilbao@amd.com>
Subject: [PATCH 1/1] docs: Add relevant kernel publications to list of books
Date:   Tue, 21 Feb 2023 12:00:49 -0600
Message-ID: <20230221180049.2501495-2-carlos.bilbao@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230221180049.2501495-1-carlos.bilbao@amd.com>
References: <20230221180049.2501495-1-carlos.bilbao@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000E64E:EE_|SA0PR12MB4495:EE_
X-MS-Office365-Filtering-Correlation-Id: 1eb8aea6-167d-40b8-c999-08db1435917e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Dmd+E8zJS1ccd0cX5G+6CvD1C0dOeOdDe+2m7IWi0hwlmD7jwdEESK3qgIdT9uj17niGOzIPXPk/z1bArcjgg8xjL+fb19I6nnp2jYUyokchR+C+n/u1G902c4823Knx4441+o5cbFR6VNcmXN9Cj27bxUleNsI+wGE7rN5iDPDQhM+N6vDhqX+qvu8fElAwlCktouwyclHag//9oEPQekabT7R58OCochUu5D2NLcm+AzJFWPllcbSx6sNWK4nP3YDajzynBWnzkofVC/syX4fa3J0HzXVR2nI3KX7IqOrEleHGRkSaRm103OsyKwvCl8vnE+GZJUaczuh7ZA4tCBswXkp0ktHsAbSasvKuSrZk6CO9L/TB6QZGBjRbKVGaf7/YZfep5AaUinvA0tNEfNs4l49G1FmnCf0zE4zWb0/KHTep0BqpU2eskAzhyZyrnLgM3rb7mxJikAtJhyRrJUBNBKMkKIIVCjgd1SC2m4s0mqifKH212zUfOhpvtWzL0C+3zBkxX/K+9CqGDzblccbgznqQ3jxrxNHrsee3h5PTONMioVtLmPBK6la/f5l5Ec2fypCgluEup0OKpPm7n8isWVVM0vWdt0MXiIb9JtcAm1hBas3Z3F4Ka4zW8GuLlKE0E1l7WGfBrOIzdoyA54otFlVSqBpvp0YSUGqYJBnIZD27ABCsPLI4cxDG9rYfH5WzqEV6BWGenfD3LqZ7eR5gCggygxeawD9IjTaxxbA=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(396003)(136003)(376002)(39860400002)(346002)(451199018)(40470700004)(36840700001)(46966006)(82310400005)(336012)(83380400001)(316002)(110136005)(426003)(47076005)(54906003)(36756003)(82740400003)(70206006)(8676002)(36860700001)(70586007)(1076003)(2616005)(41300700001)(186003)(26005)(40460700003)(81166007)(7696005)(4326008)(44832011)(5660300002)(478600001)(356005)(8936002)(86362001)(40480700001)(2906002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2023 18:00:50.9103
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1eb8aea6-167d-40b8-c999-08db1435917e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000E64E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4495
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For the list of kernel published books, include publication covering kernel
debugging from August, 2022 (ISBN 978-1801075039). Also add foundational
book from Robert Love (ISBN 978-1449339531) and remove extra spaces.

Signed-off-by: Carlos Bilbao <carlos.bilbao@amd.com>
---
 Documentation/process/kernel-docs.rst | 29 ++++++++++++++++++++++-----
 1 file changed, 24 insertions(+), 5 deletions(-)

diff --git a/Documentation/process/kernel-docs.rst b/Documentation/process/kernel-docs.rst
index 1c6e2ab92f4e..ce461d981d0a 100644
--- a/Documentation/process/kernel-docs.rst
+++ b/Documentation/process/kernel-docs.rst
@@ -75,13 +75,31 @@ On-line docs
 Published books
 ---------------
 
+    * Title: **Linux Kernel Debugging: Leverage proven tools and advanced techniques to effectively debug Linux kernels and kernel modules**
+
+      :Author: Kaiwan N. Billimoria
+      :Publisher: Packt Publishing Ltd
+      :Date: August, 2022
+      :Pages: 638
+      :ISBN: 978-1801075039
+      :Notes: Debugging book
+
     * Title: **Linux Kernel Programming: A Comprehensive Guide to Kernel Internals, Writing Kernel Modules, and Kernel Synchronization**
 
-          :Author: Kaiwan N. Billimoria
-          :Publisher: Packt Publishing Ltd
-          :Date: 2021
-          :Pages: 754
-          :ISBN: 978-1789953435
+      :Author: Kaiwan N. Billimoria
+      :Publisher: Packt Publishing Ltd
+      :Date: 2021
+      :Pages: 754
+      :ISBN: 978-1789953435
+
+    * Title: **Linux System Programming: Talking Directly to the Kernel and C Library**
+
+      :Author: Robert Love
+      :Publisher: O'Reilly Media
+      :Date: June, 2013
+      :Pages: 456
+      :ISBN: 978-1449339531
+      :Notes: Foundational book
 
     * Title: **Linux Kernel Development, 3rd Edition**
 
@@ -92,6 +110,7 @@ Published books
       :ISBN: 978-0672329463
       :Notes: Foundational book
 
+
 .. _ldd3_published:
 
     * Title: **Linux Device Drivers, 3rd Edition**
-- 
2.34.1

