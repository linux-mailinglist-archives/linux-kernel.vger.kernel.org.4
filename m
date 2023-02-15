Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 451336981E4
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 18:25:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230042AbjBORZo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 12:25:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbjBORZm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 12:25:42 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2052.outbound.protection.outlook.com [40.107.93.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B796BAD31;
        Wed, 15 Feb 2023 09:25:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nsi2G34RsT0eR/wVvungwa2txk6yHhr4sYUmdru4qQ+sKh17w11nE8xJOzlmdbT3bTJw8n0unO4zhThe0Fn2T0Jqepc62ir+W6DctwyXqN0mFsExugvAl6bVX12uBp2P5UUuF7HaPF17YMw/9JBy46jfBFgByjbLoQrhakv6lgIE0roj/Qz7V2cXJTugDbODSFAoBNBlk2rpzcjCnbKdb9wu7j5/tDmxJPR9jiw5i3W+1jrcz1CR5CNSovQpft2rRwUK5jledFPYBvXSX6RM9AJSoII2W6p3oUYSFRnYjJU3J9VQdn3vWiC2BacnKkX79FEejtph94s0HjY+Dc8e2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cAi6DsO32l7bI21HmO77vVnT3Jx6/Dv1Rs2HBFHD8Lg=;
 b=dLaqr0Bv0vUinY1U3v618ZmVAmKvnB1y6TKWUw+5RhNCq+Z/IuF+7kSeRj53WV+YCrfTsZzwgt7wXtKrDrHez93cdsUpQjcp7Av3KVrBenniSSTs9UcVaBuyRGEHRv0wmV7cLtjyjeT4hNKMfrmU2WJMFDzJaul8AaxfXz8bPFdEgzAFKaI7u0i4q4iQNfNMHMIYB2TOZy3v5AJhd0fOUE4uXfC5r9y4gF+9OX5RoriZ8fm0slB4YGlltR0AGWIErJ7t7KLUR8aaEs2FT5DKIwMoj6vOtCNGMHFp5MnN8C/zLbkyB/vQigzd+t0bMoVXpIfWt/nN0O4UKYY8FUgd5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cAi6DsO32l7bI21HmO77vVnT3Jx6/Dv1Rs2HBFHD8Lg=;
 b=gqv+TRf56wghGt+Vnr+JE3wb4+Qe+FEAQ9VHBAFTjmBtD6DSe7XVXtGw4wDa4mM+RFQMoH2GYAbyT5Jgw/jskNrWZo96Np2ovvr8qo0C7vPrRYIxN5NWQZrqRfbJ5a0hu6QmmxxkKydb9rlrlDW9j8WF7RBxIKLC32c7RioRrRE=
Received: from BN9PR03CA0079.namprd03.prod.outlook.com (2603:10b6:408:fc::24)
 by DS0PR12MB6438.namprd12.prod.outlook.com (2603:10b6:8:ca::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.26; Wed, 15 Feb
 2023 17:25:35 +0000
Received: from BN8NAM11FT056.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fc:cafe::52) by BN9PR03CA0079.outlook.office365.com
 (2603:10b6:408:fc::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.12 via Frontend
 Transport; Wed, 15 Feb 2023 17:25:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT056.mail.protection.outlook.com (10.13.177.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6111.12 via Frontend Transport; Wed, 15 Feb 2023 17:25:34 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 15 Feb
 2023 11:25:34 -0600
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        <linux-usb@vger.kernel.org>
CC:     <Sanju.Mehta@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 0/2] Fix problems fetching TBT3 DROM from AMD USB4 routers
Date:   Wed, 15 Feb 2023 11:25:18 -0600
Message-ID: <20230215172520.8925-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT056:EE_|DS0PR12MB6438:EE_
X-MS-Office365-Filtering-Correlation-Id: c788cdb3-fb67-4435-bf29-08db0f79a5bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SJvi/RuebE9NhiQ+f9SVAX/e1Zvl62jfTTTyX9acS+i2EJaD4xl2ahQKD7YcpFVSXobhF7skxdI4sNFIcuNZxkJDGIXtxEiAKKhZ2y7Pb0iY19K57K+ns5/7/oeulUeLjDTbwHD7FX/Klc5jUWiIKvv4P5/artXvNjnqtuOFo3gKdPEKdIxnkv+vCBPXxmNVhdt7aMMo8IYZ/Y/OpQ/q5M+RINv7cAN5jNdIKxfoGV8466t6vsILl04aHRGLkNfjPY05mp09M0uIJeHMCSd9ipKqYXfMuhNdmY5wwlsYwo5+bjR1lOwIHYa57nzVSbpwW/H4fYf4/LNs3uHaFRQv9u1okVCSrInRQFqrHy+v7sd7lMQXQme5zgVd03zjaeimtd4SDipgxJefvsOl2U3GJGKeGdYQvc2fKyq4FEMFfPuFiy7GQW55L/bs5oYLWNTqGTTqZPR0PP7bKlUP3QToit6GubBEY/DBoj1TgvisWQBYABeB6+JKUnyMsVrwdempmk8REoYxchGc3J4t7DQ4ZBDpDIHcXEt/mEKUzHCkft2VECmSu3dglmy5W/8PwHyoWtq3zg+0EQbMj9djYLnBwXvcnYjXlEWWCF+GHoRnh9rNqibqqfEjJdheTphNdDbyRoC0Hdvm5fZNNacfbDpptIu9eJT/WA39jNXjRTv9Ub3EBbPbXzxoeN7DGzgMhJNuownEK9b0FUKjRxQJFv7SPWJ5d2cJbE/H+ZwhL1edSl0=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(136003)(376002)(396003)(346002)(39860400002)(451199018)(46966006)(36840700001)(40470700004)(41300700001)(5660300002)(40480700001)(8936002)(426003)(36756003)(83380400001)(36860700001)(66574015)(478600001)(86362001)(356005)(40460700003)(81166007)(316002)(70206006)(54906003)(7696005)(110136005)(82740400003)(4326008)(70586007)(8676002)(16526019)(26005)(2616005)(336012)(1076003)(6666004)(186003)(47076005)(82310400005)(44832011)(2906002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2023 17:25:34.8723
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c788cdb3-fb67-4435-bf29-08db0f79a5bd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT056.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6438
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TBT3 devices when connected to an AMD USB4 router occasionally fail to
properly respond to requests for the DROM via bit banging.

Depending upon which part of the request failed will impact the severity.
A number of workarounds have been put in place to let the driver handle
the failed requests:

commit e87491a9fd4e3 ("thunderbolt: Retry DROM reads for more failure scenarios")
commit a283de3ec646f ("thunderbolt: Do not resume routers if UID is not set")
commit 6915812bbd109 ("thunderbolt: Do not make DROM read success compulsory")
commit f022ff7bf377 ("thunderbolt: Retry DROM read once if parsing fails")

Still even with these changes the failures do make it through. In comparing
other CM implementations utilized on AMD systems, they all access the
DROM directly from the NVM.

To avoid triggering this issue, try to get the DROM directly from the NVM
in Linux as well before resorting to bitbanging.

Mario Limonciello (2):
  thunderbolt: Adjust how NVM reading works
  thunderbolt: use `tb_eeprom_get_drom_offset` to discover DROM offset

 drivers/thunderbolt/eeprom.c | 150 +++++++++++++++++++----------------
 1 file changed, 82 insertions(+), 68 deletions(-)

-- 
2.34.1

