Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96C58637DF4
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 18:03:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbiKXRC6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 12:02:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbiKXRCt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 12:02:49 -0500
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2043.outbound.protection.outlook.com [40.107.212.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FEAD2B1BB;
        Thu, 24 Nov 2022 09:02:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pl4kYrQrHORdw5cwvz+dslxaBuDsGlyBynUYBpvfmhPCphGwi9JKXkGaSnQpeefSVDFTyajx4oqEtz8P1kNtoL8xzLEfKTbzUY98x1Hxg5RY4zOjqzTspQ9IzacNXmAkNZs1qeXD4gv4clIDFSNBFoWu0VVTPmpavtsx355j2tDambVuphCi9O4XWZpA5oF7WegfSVOjtJ47BEtLO57NoL0j1+gj13PGQQ1jhlxbNmnzRsgWMQ02LFVCEQrV9grAwumaFrH993lF+7yylGh4cw+ClZPuo0pun85NknINTVUxqrf8Nu1ormYVHXmnDMucSPXosYUVC+LmEqN39LOvZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w7Z6vC4vyHthNCtaqY18LDj/TklJNDVKOARGNkN2GaU=;
 b=PtJ/G7gTX8XzS2pyzE6quaLwkVGrQIpppOg3u7ZBBZbMnaZQZy7T52fwguBDLoH0P7yDVTJZqQPqWTOdNhsQPEOwHDoPD/1yDvXs7BN0Zcd19MEu0iSRCOqZdIL8TT+RGdfPoesIy212ko6js1ImTksTvc0egg/PoCLgOH6L62dLiVT9mnIXyDpxFUQLof1MOh6qsumT1WcVFqFshaR1qRWdYUUzIuxu7dCKMwVYrC1RuWuPL9LSZSutLFFGtNnbDwSbZR4tEUjoJW4lVT9SamnmLOC2wo2HRGp0MnEb7oK4izlWGTvyOBNNcjJH2ZCn+bbMCYH5kKhT4J1I5RPFBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w7Z6vC4vyHthNCtaqY18LDj/TklJNDVKOARGNkN2GaU=;
 b=qPm6SGLWEMMgH+EQh9dCigrD1Tzmq6huid0HLPL73mvFy9GwHND6rR4NF2892wR70xYIDo1tGHVxSAx1DOSvKEkG5GsIPtn4NcQya5WpnqyiA1OOW3KwYVvjJYdYHMek4/ms2uUO6YmYgkwmH6pwB+m3z5GjOPpKYRjT463lLdY=
Received: from MW4PR03CA0196.namprd03.prod.outlook.com (2603:10b6:303:b8::21)
 by PH7PR12MB6658.namprd12.prod.outlook.com (2603:10b6:510:211::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.18; Thu, 24 Nov
 2022 17:02:47 +0000
Received: from CO1NAM11FT059.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b8:cafe::fb) by MW4PR03CA0196.outlook.office365.com
 (2603:10b6:303:b8::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.19 via Frontend
 Transport; Thu, 24 Nov 2022 17:02:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT059.mail.protection.outlook.com (10.13.174.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5857.18 via Frontend Transport; Thu, 24 Nov 2022 17:02:46 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 24 Nov
 2022 11:02:45 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 24 Nov
 2022 11:02:45 -0600
Received: from iron-maiden.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Thu, 24 Nov 2022 11:02:45 -0600
From:   Carlos Bilbao <carlos.bilbao@amd.com>
To:     <corbet@lwn.net>, <lukas.bulwahn@gmail.com>, <ojeda@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <bilbao@vt.edu>, Carlos Bilbao <carlos.bilbao@amd.com>
Subject: [PATCH 3/6] docs: Add book to process/kernel-docs.rst
Date:   Thu, 24 Nov 2022 11:02:39 -0600
Message-ID: <20221124170242.1892751-4-carlos.bilbao@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221124170242.1892751-1-carlos.bilbao@amd.com>
References: <20221124170242.1892751-1-carlos.bilbao@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT059:EE_|PH7PR12MB6658:EE_
X-MS-Office365-Filtering-Correlation-Id: 92f45339-59d7-4ff4-fb64-08dace3db5ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RufIFUTsJKBr4txsSNtnzeBjxX9NC6QL4dgRkcbjfD40UKu9mrJu0laM9+WbeFHXFJnX3yjeWpIFsV5m4D1/VP1m6/zVO63ZEuf8jzKTS7upUml2HmIiTjc4carXStZGOh/TuWeqJAzkjVpJIgX1Ie/s5FjCRoX3HaUM0TPxq76NC00S7CiTLInc3jVGlhjPzv5Lcvsj6apqnvW3zqwLLgDGzVDf67NdY6Wa1aMCzUtHHnDJYP7QzaErnYg8d5hhkjMchOuqhfUGCBwG2qHUqGdbnbjgNRrvPKILq3YLiMVnPCLrSBoOMGt24WyAuPyFo1omE70F1m8K7Nolg5tVuW3Q4oyvABukEPXyOoUcGkI8xyvokYxAI9v3r9004ClnYAmpZhCGzPeKGdLs6cdfVpM/9+dSYov1Cew4grSh7LtH4ajbHsX8HXP5gzYjMj/BPGfC2Uh57CqgiBOqNbr/H4zXBiOqLmtsMXDKXZl3+BBdQIwQIxjlEN3jc08yDDzsAvIFjbCEE3w5rdI2pEmYMc0rNeyR0mtK1zqa3qvygvrdbt/qoar1LILbSL3rkxADF2FpY8zBsBqMdcJwzDl6vO+QhO7Vlmie9fHv37aGmqwlB+T5Xb/3Get8Sia7dPF4rzlIFZ8Gb/NttNK/RSSWAM7uIMBa9QpE3Uj9MG/7hmv+RvjlyYML84KDg7w0EUyvrKZVvsCkc1jGlaNZI8WLFp+2jttqxZl5nSga/BnRD8A=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(396003)(346002)(136003)(39860400002)(376002)(451199015)(40470700004)(46966006)(36840700001)(36860700001)(2906002)(86362001)(8936002)(82740400003)(356005)(4744005)(81166007)(44832011)(4326008)(8676002)(41300700001)(5660300002)(40460700003)(70206006)(7696005)(6666004)(26005)(426003)(47076005)(336012)(1076003)(110136005)(316002)(2616005)(54906003)(82310400005)(478600001)(40480700001)(186003)(70586007)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2022 17:02:46.5670
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 92f45339-59d7-4ff4-fb64-08dace3db5ef
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT059.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6658
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Include to process/kernel-docs.rst a book on Linux kernel development
published in 2021 (with ISBN 978-1789953435).

Signed-off-by: Carlos Bilbao <carlos.bilbao@amd.com>
---
 Documentation/process/kernel-docs.rst | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/process/kernel-docs.rst b/Documentation/process/kernel-docs.rst
index d66ac26e2f27..1c6e2ab92f4e 100644
--- a/Documentation/process/kernel-docs.rst
+++ b/Documentation/process/kernel-docs.rst
@@ -75,6 +75,14 @@ On-line docs
 Published books
 ---------------
 
+    * Title: **Linux Kernel Programming: A Comprehensive Guide to Kernel Internals, Writing Kernel Modules, and Kernel Synchronization**
+
+          :Author: Kaiwan N. Billimoria
+          :Publisher: Packt Publishing Ltd
+          :Date: 2021
+          :Pages: 754
+          :ISBN: 978-1789953435
+
     * Title: **Linux Kernel Development, 3rd Edition**
 
       :Author: Robert Love
-- 
2.34.1

