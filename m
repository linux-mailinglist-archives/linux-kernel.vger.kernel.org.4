Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7492E5F5AE9
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 22:23:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229917AbiJEUXv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 16:23:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbiJEUXq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 16:23:46 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2067.outbound.protection.outlook.com [40.107.237.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4C0C6CD14;
        Wed,  5 Oct 2022 13:23:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hVTIfbl79Ot+R4iahMvOFnRiHqC3KJSVTnYG1s9SwPNTVE0mQPi3pCLOUNsoIEb0IrZHCp7ZgI0eXrXHSmvrKNp52EQhy8C7IK4V7bUJSPKhpXebWvTwN9JoJTFKdfqO6THNY4sK1iG+uNKFDuagTWF95kikqkTzTUIJdr2baqwoPG3vxc901dwvZ40NCpgTvZB42zwBRHPNbHGtvaeMRnYJcf3ME2uFA+8pgLQVo4Ly0MlJpdPWdwvRvQ5Tm4w/SeAIw8v0hX2uN01tB746dyrXGjrH2EPET5TMn3R0vIJeEU/fIA/wERZHIFz1I4dOMLP0udujrpw4nm8ScBNqhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WFgFS+xh2IXuNhxVgXUSMMVziDRfATrJemElJwWw9L8=;
 b=d3ZBLjXfcC1P7LTQUMBilJvxI+PUB01KSOXqI3XS2i9/AQZxOLbH70fHdazoIjt+i9hy6irAawsyeN/nMIFgLXpV7Myy8Vl0LYWFaovwuuGfbPJFsqsiqJiwiQlnnXipwgwJje4kX/jskUZ6Oo24AcQdvivlpQqdolUz8ITBRCqxHoiQgENqerC7gk25doN8WTybyaVe6y3DYRCg1EfU0uIgM6k/V5ABJijTbhMdTpmhPza8tjgEV1vEHbBIYa9k/9wMiRbjVfjK9663vIeD9PvpAsPsYdJligj9vLnLVCg7DEft2tZ4QZOjul9dwISL9VOVUWQcrt1VnL5V7luCgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WFgFS+xh2IXuNhxVgXUSMMVziDRfATrJemElJwWw9L8=;
 b=vmIt546KuULnI2LtBtRCje45V5gZDjVArSmrFHKs9f+WiFi2+lh137GmfYHWsXj/3HepMEAxBgRh0NfFW8SMEAJTx76CrATLKrtsgsJwrgUwSzHCZo0fPs/ELyUHNrdoSJgwSNlDU9TUZjiEezKaasGc2dPhow4BJjsIlrvdw8M=
Received: from DM6PR03CA0047.namprd03.prod.outlook.com (2603:10b6:5:100::24)
 by PH7PR12MB7140.namprd12.prod.outlook.com (2603:10b6:510:200::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.24; Wed, 5 Oct
 2022 20:23:41 +0000
Received: from DM6NAM11FT009.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:100:cafe::c7) by DM6PR03CA0047.outlook.office365.com
 (2603:10b6:5:100::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.28 via Frontend
 Transport; Wed, 5 Oct 2022 20:23:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT009.mail.protection.outlook.com (10.13.173.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5709.10 via Frontend Transport; Wed, 5 Oct 2022 20:23:40 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 5 Oct
 2022 15:23:39 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     <mathias.nyman@intel.com>, <mika.westerberg@linux.intel.com>,
        <linux-usb@vger.kernel.org>
CC:     <Sanju.Mehta@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/4] Enable runtime PM more broadly
Date:   Wed, 5 Oct 2022 15:23:48 -0500
Message-ID: <20221005202353.1269-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT009:EE_|PH7PR12MB7140:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c2b8ab3-44d7-4a9d-e73a-08daa70f7e2c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tv0jik0iRwr0heYGz3vEkL/T02Bw69AJCzqNhPyr7LDg8U6lyZ4p4H7n0t47U5G5bNmCYVFEYQwVeW19sHLUSsahAizyRkQGnjiNQ0xSq/wZG/KjgmqmeVNQPflvlKCwoAwIsWdnVymf8uz9mM9ycdAkT9LM++gGEAY41I0SLKF1THu/5BQmrPZPobc024CWQVRoAUOgMU7Ax5HqVGgbqtgq+NVhs6OKfaC4AGCSY7gHLUwsGGeMv4zq8nWVenOtghiDAXCwh4UPP4/VStYONV4/VpmYXIcUwazc1PbaJ/pvkN6DTSgp8DxCAlgIX7L8an6fPivapstyiyNDYB/RnruKzyMFsVYTkKkk2ziFuPcEoFedInD97y1Xgr+Mmjx0lCmhBCE+LhGNOX8yAeFTHPUCzb9+TSbnOK6A5vM3I+nz0xMuh6qERo0jYqwEQ+67Obh3LxfQkeOritf1W4kIOp2GGOeY0FZRAKfPWUFMdDDTD4RyyXrxfX3lI5T5CVtoJcOp36BO01LDtG/5C1/2We1Lh5EbMg9qbA2khXZyfyvnkVqL6Ig95txOzmN2nMjPUsxGhQa+A6fVGVCqMPT5Hj8wQE/w+MtMX5Lyg+V3KGpjdRhi8kVOjaehwUiGp9s+JsoEMfPbB3ioXVC9M3otijP+E05zG1jWt2hrH8gb1NBGeoAXCVgtW9NVLXMs3kx7YR0Y/XRV+llrQ/k93cHmJl65sWZ4RXj+Mfw9FhH/BGRie8w6d6rhHs1gyWa+r3QcUU43In1eG5hvTdo4Ge39ydT5K/aVghpGgsHpNljjpWQWnV5zrJRzKF7G201r9C9PyfYqylBYZwnZjfbL9TGjXUeYRvvE7HZsorhacx1KqsE=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(376002)(396003)(346002)(39860400002)(136003)(451199015)(40470700004)(46966006)(36840700001)(47076005)(81166007)(83380400001)(44832011)(40460700003)(966005)(110136005)(54906003)(478600001)(336012)(36860700001)(5660300002)(8676002)(4326008)(2616005)(36756003)(8936002)(316002)(26005)(40480700001)(356005)(16526019)(70586007)(70206006)(82310400005)(426003)(41300700001)(82740400003)(7696005)(6666004)(2906002)(86362001)(1076003)(186003)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2022 20:23:40.8472
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c2b8ab3-44d7-4a9d-e73a-08daa70f7e2c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT009.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7140
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently every time a vendor introduces a new USB4 controller changes
need to be made in xhci-pci to add the PCI IDs representing the XHCI
controller used for tunneling.

Due to low power management needs every single integrated Intel and
AMD controller have needed to be added.  As we already know which
controller is used for tunneling by the device links specified in
ACPI tables, this is a very good heuristic.

This series uses that as a heuristic, pulls out all the IDs added to
xhci-pci and then adds the new IDs for those *not* used for tunneling
on AMD's Pink Sardine (those are covered by the kernel today).

The original RFC that lead to this series and discussion related to
it is available here:
Link: https://lore.kernel.org/linux-usb/20221004041225.1462336-1-mario.limonciello@amd.com/T/#t

Mario Limonciello (4):
  USB: ACPI: Look for `usb4-host-interface` property
  xhci-pci: Move PCI IDs for runtime allow into a table
  xhci-pci: Remove a number of controllers from the runtime PM allowlist
  xhci-pci: Allow host runtime PM as default for AMD Pink Sardine

 drivers/usb/core/usb-acpi.c |  9 +++++
 drivers/usb/host/xhci-pci.c | 74 +++++++++++++++++--------------------
 2 files changed, 43 insertions(+), 40 deletions(-)

-- 
2.34.1

