Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62D0569FB0F
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 19:35:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232310AbjBVSe5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 13:34:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230291AbjBVSez (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 13:34:55 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2082.outbound.protection.outlook.com [40.107.237.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D9393E60B;
        Wed, 22 Feb 2023 10:34:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=joSGo43kl8pYjvJk9sECxXnwwgrP1hX1B7nNr2QKiSwOJccUwATQxZ3biqfBj1KsT0P0sWdWDgF5UfFZB2c7MtTWjk88zN85vZnfNXonmhWlDTNoSCabRLxcOna+Ge4NmB6sFfmVIFxMy9CTTfkqutNFeU12xuoxrWLVswKk8Yxuzk9DwbdbCEESHSpkhN7ZLWJFMtwBJhMsL0OQfAs4rdae2Cdvl0qCgeKC0PJ+fH2b61Gf1L5BufyZ65JzJOvbMakCw/JFJC7TodP8V2DhpMAx2Q0N4d3JThuIxG4I+MPlvB+4Y3wIw+gkeR00w9dCzPKwJ+Tt+PppE/Vo9Nu+Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dq9E29Giboj6XsmzOA7ADNWw2jvAVh402cn6kRaS3i8=;
 b=lmFJUJDyLlxhm+e5Pb6fltZe5c5JzVhLWkHoHJKXOdui31nZqUx5a+ULhNZXc0Me/OWW5+NUvni+Z0S/ghBkMcGYiIJRjmCzx4/5rBjGz8tW36fHS3FhyC2F0zwsDxbyQP1MUa0Ll/WI4qiDtLUNnxvDVi6Vaq3D2Q/J8P4fbaYdVweCY4PhPD2QhsDILF2VcWXua5FRetUPgS22k0CfI0wVGJvZrRFEuc7QFp2q/GKbE6k10nyMZ5PcVxejVjraq+DfKZUCKPPr0+nvS19xs3xztvyeu/dwMCNG0kz8ADyqVz2prlpSHPGrkGdJR8rbCcf3TM2cvaUQ3MSuUPnsUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dq9E29Giboj6XsmzOA7ADNWw2jvAVh402cn6kRaS3i8=;
 b=buJsC4n4mzUw9XGtvnZbuA29iZ6t8UZPTC8+2LKNu8HRIIcZYZVdaFa9T4X251GJCHr+fiHGK3FDwgbVJuZ9tfh3uXc+eftSrUvu4znHEVd8r7Fcsr6MktXQqvGTO+V1IiqBvGKeFO2el6xyjqNauOwJB1qjrck3R51R5D+5SPA=
Received: from BN9PR03CA0111.namprd03.prod.outlook.com (2603:10b6:408:fd::26)
 by IA1PR12MB6258.namprd12.prod.outlook.com (2603:10b6:208:3e6::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.19; Wed, 22 Feb
 2023 18:34:52 +0000
Received: from BN8NAM11FT071.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fd:cafe::ac) by BN9PR03CA0111.outlook.office365.com
 (2603:10b6:408:fd::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.23 via Frontend
 Transport; Wed, 22 Feb 2023 18:34:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT071.mail.protection.outlook.com (10.13.177.92) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6134.19 via Frontend Transport; Wed, 22 Feb 2023 18:34:52 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 22 Feb
 2023 12:34:51 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 22 Feb
 2023 12:34:51 -0600
Received: from iron-maiden.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Wed, 22 Feb 2023 12:34:50 -0600
From:   Carlos Bilbao <carlos.bilbao@amd.com>
To:     <corbet@lwn.net>
CC:     <kaiwan.billimoria@gmail.com>, <rlove@rlove.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Carlos Bilbao <carlos.bilbao@amd.com>
Subject: [PATCH v2] docs: Add relevant kernel publications to list of books
Date:   Wed, 22 Feb 2023 12:34:45 -0600
Message-ID: <20230222183445.3127324-1-carlos.bilbao@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT071:EE_|IA1PR12MB6258:EE_
X-MS-Office365-Filtering-Correlation-Id: e54772e2-f643-4d91-51fb-08db15037c7f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2KgeBodjl4roK8aZAVaOTzpy9PVVtlvzahgjK2fnSKaOejVsqlBcvJMurFMqsl1BJRjFNN2pqiJmOiC6qpfqNI5/Dl6UGGN87edhDbJgVQxJkHXOX6vc1lnJ/TLaqnsK36BThDIKn/pI0EllWRrslygZHCEpK+uvH63DDQegIbW5wueoGIXMLfJlQKRSsottlioDuORescxfoCW678nC+T8j+8b7ZUyoUusMOZ2EngMUE/ou87rBP83i0skj84nUHAjc3Loh3KN0RaFKwqQlASqZcwI4v/mcGbwuXM5hgdtRD4h46Khk1XNnZeTnof4zOKXezY5ON+5eIEvqjsdis4jwk2sTloKdLDTYFl1CuKTuIgKbLonSsr/8C4kBVc9Z3dPQx2tIUjutep/kzCLcwTRw02PiQMG3G6j+2qgxVb9f+63+x9BoRnbVqg7CVgRjqrS7U7oCOD2oA0l0mgoZlIYJjxgDQaDAQ2jvwVomFubAQWQwbO0Qq3Ln0h/tSu8Sax0pbsL87lGPofnVfteeDBBWLTr0saYbTX3RaDUrhSDCq1OI0zYfSomqu2df7WaHD9wWky9iAOw69fVIuyND6fmq9fITpFdNFd7xREJsmmVpc3JvJgRT/qgIOKUbUTpCwQgX5WhBGAzDCyEm3t/f/MhVha34Xg7a3xXLIQh8PPYD0ppW4EBVye3UJnZzfdON8m+kasgrORjpMeIdrch7WjLi3Od3NV9/tyMkB0JeIQo=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(396003)(39860400002)(376002)(346002)(136003)(451199018)(40470700004)(46966006)(36840700001)(36756003)(40460700003)(83380400001)(426003)(47076005)(7696005)(36860700001)(1076003)(186003)(336012)(26005)(2616005)(40480700001)(478600001)(4326008)(8676002)(6916009)(86362001)(70206006)(44832011)(70586007)(2906002)(5660300002)(8936002)(41300700001)(81166007)(54906003)(82740400003)(316002)(6666004)(356005)(82310400005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2023 18:34:52.0548
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e54772e2-f643-4d91-51fb-08db15037c7f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT071.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6258
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
debugging from August, 2022 (ISBN 978-1801075039) and one from March, 2021
on the topic of char device drivers and kernel synchronization (ISBN
978-1801079518). Also add foundational book from Robert Love (ISBN
978-1449339531) and remove extra spaces.

Co-developed-by: Carlos Bilbao <carlos.bilbao@amd.com>
Signed-off-by: Kaiwan N Billimoria <kaiwan.billimoria@gmail.com>
Signed-off-by: Carlos Bilbao <carlos.bilbao@amd.com>

---

Changes since v1:

 - Fix name of author Kaiwan N Billimoria.
 - Include other book, from 2021, also authored by Kaiwan.
 - Include Kaiwan's SoB.

---
 Documentation/process/kernel-docs.rst | 36 +++++++++++++++++++++++----
 1 file changed, 31 insertions(+), 5 deletions(-)

diff --git a/Documentation/process/kernel-docs.rst b/Documentation/process/kernel-docs.rst
index 1c6e2ab92f4e..46f927aae6eb 100644
--- a/Documentation/process/kernel-docs.rst
+++ b/Documentation/process/kernel-docs.rst
@@ -75,13 +75,39 @@ On-line docs
 Published books
 ---------------
 
+    * Title: **Linux Kernel Debugging: Leverage proven tools and advanced techniques to effectively debug Linux kernels and kernel modules**
+
+      :Author: Kaiwan N Billimoria
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
+      :Author: Kaiwan N Billimoria
+      :Publisher: Packt Publishing Ltd
+      :Date: March, 2021
+      :Pages: 754
+      :ISBN: 978-1789953435
+
+    * Title: **Linux Kernel Programming Part 2 - Char Device Drivers and Kernel Synchronization: Create user-kernel interfaces, work with peripheral I/O, and handle hardware interrupts**
+
+      :Author: Kaiwan N Billimoria
+      :Publisher: Packt Publishing Ltd
+      :Date: March, 2021
+      :Pages: 452
+      :ISBN: 978-1801079518
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
 
-- 
2.34.1

