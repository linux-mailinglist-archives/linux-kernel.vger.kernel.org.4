Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F19D6C7263
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 22:38:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230456AbjCWViW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 17:38:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbjCWViU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 17:38:20 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2071.outbound.protection.outlook.com [40.107.243.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D41E26B8;
        Thu, 23 Mar 2023 14:38:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H45gABeuK7IiFCzjW100x+vQY+9T0V23A7AGgEYIZBcAE/OvwsQFo8dEQhFzVZBrVNH1z/jDuZyIpH2RcN561jrOe/RNqEjVhVA6eN+aTEnrCIsyUWFxzheP7DDJ2qy32ttd9TZ9Rlc1hb+Ogg+Ml6bR1MpY/JvzQ/JPPVpKxoAc+xIM3BXjHDb6hlvoJCigwAaDe94uCepnjL8GnUzJsd8oURrlPKvy2zzUbBbHBQiir7bnJ48TbuHFzgGV7wpVOcE83sPl+gBD0tc+/8rPSUB2WACD4iYeTqDWpiUUUhn3KIpct40FRYXe4DcKIOII/Lfkd/GM2ma8eTdXt+j5QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hJ6p1MUywn9zav2DD2FF3gP4Q6zmxUS3UtMtpB9Dvwo=;
 b=RFhY8z8Njv6EtGio/49GDIHo5P3NAPi2nk0KNxtf0zjoNRycamXFzBGCmCc/bW0ohOa8IGVfwvR5KR8ggbbb7qlo3nCqHUWnXeXNZniZqlUp0UacenQGCE3GBxWHIeFxRlAuH4GdJrJtRRAM1VY3fVJl0qbQHOygnMxBrZZ/Zyxr8UvmGZ76GGAsWTgfx02HMzsqnstnSivij7UrItOaBQgOa/es9jwDT1b16/3n76zrOps/HFPvf5UBJH8f3n0sfr/djQJ5nZvckFYwLj5UqQopVeIHjTfsKUITDPedVRbz5Kg5qpPvFXKZHPmJp3+m0yhzBUqQSOhuawniVD/Gkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hJ6p1MUywn9zav2DD2FF3gP4Q6zmxUS3UtMtpB9Dvwo=;
 b=3UgWZXo4Ez7+S5G8AVFbhE74kUs+PpeyB413UYCUaYtSpijtB9CbA5sfECsvMRbVrOoaoiIvuskxoIZNA8kpuJai5BDdoUmBVOukxbrIPasbrGFOD0w8H9YQBj0aNPjnLKSLBwHHs2VbRrbsBMsw9axNbfiDoNpzr5fmDzN38kY=
Received: from DM6PR11CA0028.namprd11.prod.outlook.com (2603:10b6:5:190::41)
 by PH8PR12MB7376.namprd12.prod.outlook.com (2603:10b6:510:214::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Thu, 23 Mar
 2023 21:38:15 +0000
Received: from DM6NAM11FT029.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:190:cafe::ea) by DM6PR11CA0028.outlook.office365.com
 (2603:10b6:5:190::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38 via Frontend
 Transport; Thu, 23 Mar 2023 21:38:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT029.mail.protection.outlook.com (10.13.173.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6222.22 via Frontend Transport; Thu, 23 Mar 2023 21:38:15 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 23 Mar
 2023 16:38:14 -0500
From:   Terry Bowman <terry.bowman@amd.com>
To:     <terry.bowman@amd.com>, <alison.schofield@intel.com>,
        <vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
        <bwidawsk@kernel.org>, <dan.j.williams@intel.com>,
        <dave.jiang@intel.com>, <Jonathan.Cameron@huawei.com>,
        <linux-cxl@vger.kernel.org>, <rrichter@amd.com>
CC:     <linux-kernel@vger.kernel.org>, <bhelgaas@google.com>
Subject: [PATCH v2 0/5] cxl/pci: Add support for RCH RAS error handling
Date:   Thu, 23 Mar 2023 16:38:03 -0500
Message-ID: <20230323213808.398039-1-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT029:EE_|PH8PR12MB7376:EE_
X-MS-Office365-Filtering-Correlation-Id: c7c6e527-a192-4d77-9955-08db2be6e8eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rP3qwz7ZD7gh8IkEVt3u0rjDsg1wACQyjlUYvhu7EGBwS2wh9cYUzCkqrB6dtthMcH8aqKD/9pd+oYgFpoVGstooqG30e5GdzdNRVhhoRlbG1rPG+7sow4burbSRjh3UEvddEH35kyfxEMvJGGzk2gXinitNeGSNiCIEaT8DH/ttV19/opLXHgZFbys6sIz0dYOwfBK+F1ZK+Goe4TYGeLC3eNu61T3afKmH1S1DHmJh/Ots1hQVWwGGdQQo/nqq609Z/eHbP6XAf9hh9POdO5bzk+/0m0LgRIx7apR2UmOwjN8XQNK+Y9QJktUW4vNUCKYMdH9bjTOXZ4+LjMrLrDcbKIHo+IMO3cjx2bCfZAFbedWbCctqv/c42TCt37MJWTdXnNRjGjasGqdoVAFtT1ycsp6qqv+d7El/HPDSJXJJneoRtrKJPLP/hAJYinTDRFoyrA0aWRmXPFbiq5/REqHhsd5GMSauZKQLK4En8/iV6hAXZNJcwAHdIwtUUqEJl0J23tircMxlObxJgBgdoyk+PbIk0pT8FWSt7APN1igZAZ96pdfDhcHwaU3WuDjFllb71GgJT76GsASm8hyRry1AoedWnol/WfLPnAl9kt8qwEuKN9bgzdw9YWFkNLZrRfbcKuW5a0vZmCesDUE2yYLqqaurx3wjYMyJ5NI4AbepjguUsr2y1CeBPYsA37CvMrsBcyhMVNvtcEQBHEQtEnIaAO5S9Nmkcix7zz2K/Z0=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(396003)(136003)(346002)(39860400002)(376002)(451199018)(40470700004)(36840700001)(46966006)(40460700003)(36860700001)(8676002)(4326008)(70586007)(70206006)(54906003)(6636002)(41300700001)(5660300002)(7416002)(44832011)(82740400003)(26005)(47076005)(426003)(81166007)(1076003)(8936002)(6666004)(16526019)(316002)(186003)(478600001)(83380400001)(2616005)(336012)(966005)(7696005)(110136005)(36756003)(82310400005)(86362001)(40480700001)(2906002)(921005)(356005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2023 21:38:15.2502
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c7c6e527-a192-4d77-9955-08db2be6e8eb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT029.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7376
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds error handling support for restricted CXL host (RCH)
downstream ports. This is necessary because RCH downstream ports are
implemented in RCRBs and report protocol errors through a root complex
event collector (RCEC). The RCH error reporting flow is not currently
supported by the CXL driver and will be added by this patchset.

This patchset uses an updated subject line and is a continuation of:
https://lore.kernel.org/all/20221021185615.605233-1-terry.bowman@amd.com/

The first patch discovers the RCH dport AER and RAS registers. These will
be mapped later and used in CXL driver error logging.

The second patch exports cper_mem_err_unpack(). cper_mem_err_unpack() is a
dependency for using the cper_print_aer() AER trace logging.

The third patch exports cper_print_aer(). cper_print_aer() is used for
CXL AER error logging because it provides a common format for logging
into dmesg.

The fourth patch is AER port driver changes for forwarding RCH errors to
the RCiEP RCH handler.

The fifth patch maps the AER and RAS registers. This patch also adds the
RCH handler for logging downstream port AER and RAS information. 

This is based on cxl/next commit
e686c32590f4 ("dax/kmem: Fix leak of memory-hotplug resources")'

Robert Richter (1):
  cxl/pci: Forward RCH downstream port-detected errors to the CXL.mem
    dev handler

Terry Bowman (4):
  cxl/pci: Add RCH downstream port AER and RAS register discovery
  efi/cper: Export cper_mem_err_unpack() for CXL logging
  pci/aer: Export cper_print_aer() for CXL driver logging
  cxl/pci: Add RCH downstream port error logging

 drivers/cxl/core/pci.c      | 126 +++++++++++++++++++++++---
 drivers/cxl/core/regs.c     |  94 +++++++++++++++++---
 drivers/cxl/cxl.h           |  18 ++++
 drivers/cxl/mem.c           | 173 +++++++++++++++++++++++++++++++++---
 drivers/firmware/efi/cper.c |   1 +
 drivers/pci/pcie/aer.c      |  46 ++++++++++
 6 files changed, 423 insertions(+), 35 deletions(-)

-- 
2.34.1

