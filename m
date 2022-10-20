Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 545FB605F14
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 13:38:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231377AbiJTLie (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 07:38:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231403AbiJTLi3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 07:38:29 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2053.outbound.protection.outlook.com [40.107.92.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4875A1DD881;
        Thu, 20 Oct 2022 04:38:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kytn24hIHyuMjIE7dKGkb8b1djifKtKiSnw8za2h/hBEGWiRWj4lBiI2219mXozo0h8solaJApl1EQ4KqZs9retvVHjA031fRCQuY13uxhzE5SnOlI4EFQDKHtIqcWGpeDHRpTtdjidBBk84dmAGA7mMOo+9DnWTBoOcwSlY/It/aayXKCD2q9ihwg42VmfOLlW8muSPwiPwIp9kV7jtjwSBg0AHQYHdHXyKsybfmWwRZgQ9cSDJ+zfeXw9koHqb4cnjBwTBToY+Sa3eGOoClwRZTsPyQA2G0qAUD1g7gm1Oo9Gn+IHlCPSARJROCdq6CeS5bhV3ATRMB2QcVJlTqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5j4hiN/dacg/D3orTspYD0PJJz0JJHWCpTMzVnPIDhY=;
 b=M7eUx0ssHVlhDx0C2SN/lVan6DX2TerEd/ExEdLU4CFJXX5BI9S+8ELsk4xg2nwV0FUKi3mSlj+M+avZM/0/h9wUpNmhUHMImctfU227hcYL2jr0oS9lFh00Mebgq0Mz3faiWk2ZjPragEewRjoutoAchSSC7nezPr+54fP2VPgKb2+ddBBkR4/kH4KjuubsFoJau4A30xfsFnlkIMnjJN2aXlhL9DIF2vGfm6AZPZ3xksHLUX3sCnpLntC2RqXr/UJmObsEMn/NenmU4ep8TMlJY2HqWr3uiHIj0szWDROgCiyTs5YQiVOli5aNuMpaJot80HsKR/LReBLUBXGzyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5j4hiN/dacg/D3orTspYD0PJJz0JJHWCpTMzVnPIDhY=;
 b=LGOze1sYrqM6wTDVweb4vbIV4AJzaMBfyKORsqeVa/BXKCX4NiscUPzh2l6pGIR67q8+TQAHuCwAwmp07+biUYfk8EzukL8PNAa60DPWr/MWPq4oMFJoh911fUCUzwBvm26nrX93U+nyZczT15MIf/lLzSJkzVxPn6G9pT7nzsQ=
Received: from BN9PR03CA0760.namprd03.prod.outlook.com (2603:10b6:408:13a::15)
 by PH7PR12MB5595.namprd12.prod.outlook.com (2603:10b6:510:135::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.26; Thu, 20 Oct
 2022 11:37:58 +0000
Received: from BN8NAM11FT018.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13a:cafe::cb) by BN9PR03CA0760.outlook.office365.com
 (2603:10b6:408:13a::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.35 via Frontend
 Transport; Thu, 20 Oct 2022 11:37:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT018.mail.protection.outlook.com (10.13.176.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5746.16 via Frontend Transport; Thu, 20 Oct 2022 11:37:57 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 20 Oct
 2022 06:37:56 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     <mario.limonciello@amd.com>, Hans de Goede <hdegoede@redhat.com>,
        <platform-driver-x86@vger.kernel.org>
CC:     Anson Tsao <anson.tsao@amd.com>,
        You-Sheng Yang <vicamo.yang@canonical.com>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/1] Fix using rtcwake on Cezanne platforms
Date:   Thu, 20 Oct 2022 06:37:48 -0500
Message-ID: <20221020113749.6621-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT018:EE_|PH7PR12MB5595:EE_
X-MS-Office365-Filtering-Correlation-Id: 69116e30-1757-445d-6a75-08dab28f8942
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qh4vmm0oRJgvamLn9EuirJnzgwNHuSAG59E4cNcnwpTPUEFBDV1Jk1T7YkZKsJ+hlWxdpntfPM2bYefPtwzV/FW8mixJ21/bTnnAVkH11udirohn//6rm5age5tULZp9vSvLFoWUsFC8zQnJbe+sxqPSmpJYn1LL0Djs9k/xeziSpsvNGdWY73Cr++/mAN1Rx6FPUwvZ9iknfOiP3czEKiNQpxccv9iNQD9Xv9tcjGmGlUr0slW4Yaw4vrmfpdGdSUnuLyeMo8Kvxfmn6F47XO/T4lt1djoFl7aaViEPpQcaqFX5vVBvPVXOaZn/tfAxCcQpFoEKbJJxABJ6bOsIHDkAr0N2mua8i8Vp5VpX+Dwtj3a+kgMjlJ3Dey5uJ3Gs8q01Vr4cEtPUQUczix6o307UR6CnxwwHgO+7/7ZzPrtxprMahYK8yROfHoUWDRRj/MHbAJPUBHq+q89rERysnj/rsRuFTvExhEgNgnvNKzVwcT/ILxAvzD2f7srvDII2zRMa2KCOXiZ9HLlloUpyC4gGVjnuB6jigzrZEm+kw8JCAsIU9Dl2BDhC8+mIWlS77xyl4uDjI4FjvoihvwD9eqPSGJNT5iPyZVRZAwQWezZX5SwWaNh3tYpGqbMmb5DsBMp2lCwiM7Kn1Tg3wM/IGZn0wa5vRg+OAu+8Ok420HCvARDOi4SLJucyxFL2HEqywJ6HajDUkxAha0mGgqzacYlUiSu2+zaQXkqxavGO4LDT++4ZaQot+FLoWk1JAHAgeGmJrC1E2veqaGZesgv4WmCkQGrf5DfA31QKmMkev4o=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(376002)(396003)(346002)(136003)(451199015)(40470700004)(36840700001)(46966006)(356005)(86362001)(36756003)(82740400003)(81166007)(36860700001)(83380400001)(336012)(40480700001)(40460700003)(6666004)(5660300002)(44832011)(4744005)(7696005)(26005)(2616005)(2906002)(47076005)(478600001)(186003)(426003)(1076003)(110136005)(316002)(16526019)(82310400005)(8936002)(70206006)(70586007)(54906003)(4326008)(41300700001)(8676002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2022 11:37:57.8776
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 69116e30-1757-445d-6a75-08dab28f8942
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT018.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5595
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Vicamo reports that rtcwake is not working properly on 6.0 kernel, but
worked properly on 5.17 kernel.  He bisected it down to:

commit b0c07116c8943 ("platform/x86: amd-pmc: Avoid reading SMU version at
probe time")

The issue is that commit made it possible to issue a suspend where SMU
version isn't known, meaning amd-pmc can't decide whether to activate
behavior to add a timer value to the OS_HINT message.

This wasn't reproduced on AMD's side initially because the testing
scripts were reading the idle mask from debugfs which would cache the
value in the driver.

This patch ensures that SMU version has been read even if debugfs hasn't
been accessed so that rtcwake can work again.

Mario Limonciello (1):
  platform/x86/amd: pmc: Read SMU version during suspend on Cezanne
    systems

 drivers/platform/x86/amd/pmc.c | 7 +++++++
 1 file changed, 7 insertions(+)

-- 
2.34.1

