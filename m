Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A13475B3E82
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 20:05:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231338AbiIISFh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 14:05:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231233AbiIISF2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 14:05:28 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2081.outbound.protection.outlook.com [40.107.220.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C42F97B1F2;
        Fri,  9 Sep 2022 11:05:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L7mBugZtLTUfcVSxkYN24WSdaTJrNAjpvLzMEF0fjkosTs0HaM4CfXADQd6bblViB0uxqLLE8RcJ6KQ+z2P+nEbKjSgYXyx3V6SCYzzv2BVVS6K5hel8QH35l0kyWiqze+qTZ7qLTiqHhcRZdN3gapiW+quLmk+/btcQq+7hR5597dj1rufTV3JMYIgo64vDeXPdE/ep7f7FEmxyxEMfxtGJnAXfGlFtfp8LRC373EcUfZxts+FNJtEOm/rGSlWmj5kZRB1tLaBCW87PUPAijGtbmwcU1XqifOn4lfDs1MKO73The5y03Hmusoxo0i/XkEZJYgOCRQ9FsF9P0gw82A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9OFflL+wo3naA925hbTRfFdElNSoay7k3G1VL6R3VZ0=;
 b=lCLRa3Mb2ssJSQ8kSq6JML5d00utXBX2TGa8R54sOnnrg309OkBdDYnSYc/GiKVkEfOHOiNK2kUf5FN9+rs1uYRZO6x54Xbm7hrMC64O7mBjqzp1hwhEszpDkKZ48/ftBuTsf5inh35LrPuZHCcGlTgjueN2W8PsZeliHGQH0+SrPaSvyviXXhNYCFW8V60dlaHRon3ScG5fFzw+580Jna8w8ADfDEt3zURXZDRBRAAgzhb97J2ZxlKJTU3KYYjnDAet1q2vC9yd8gnDZ6MQdNObagzQ56lo2b6gBucZluL0XCQCzTXpKGlT/x7hjf9zd6kS04FWoz1A+3iH4V6dvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9OFflL+wo3naA925hbTRfFdElNSoay7k3G1VL6R3VZ0=;
 b=vPYOe/mN5FmCpmzzZ2sP6Lm3Q6Cwuc5LuYofvkfeCaS+DweBLdZSLvzLc5XlOfqC22Bnnkp46Xc5AhS22xaid0Nn+wDfwT35TTYL71kRA3Kkbcr45avEcVT/R9ngAGNOgRQbDi+ZAEpAp9hPDnNh0p9u17HVTrOPtlfEBT7XW34=
Received: from DS7PR07CA0001.namprd07.prod.outlook.com (2603:10b6:5:3af::10)
 by DM6PR12MB4369.namprd12.prod.outlook.com (2603:10b6:5:2a1::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.12; Fri, 9 Sep
 2022 18:05:24 +0000
Received: from DM6NAM11FT032.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3af:cafe::8d) by DS7PR07CA0001.outlook.office365.com
 (2603:10b6:5:3af::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.12 via Frontend
 Transport; Fri, 9 Sep 2022 18:05:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT032.mail.protection.outlook.com (10.13.173.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5612.13 via Frontend Transport; Fri, 9 Sep 2022 18:05:24 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 9 Sep
 2022 13:05:23 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     <rafael@kernel.org>
CC:     <catalin@antebit.com>, <Shyam-sundar.S-k@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Len Brown <lenb@kernel.org>, <linux-acpi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/4] Fixups for s2idle on ASUS Rembrandt laptop
Date:   Fri, 9 Sep 2022 13:05:05 -0500
Message-ID: <20220909180509.638-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT032:EE_|DM6PR12MB4369:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d473208-295f-48ca-2e8f-08da928dde40
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 83lB0ZVfaKMtz+sLTKS6TnFx0xKoeX34b/zq5g1c/bn6V/Rg2p5N2/mGCTKlV8M+mFVmeM6u2aJomj3bSYsSGS8HLUOJm+mgQfQ8LID5GinCI9l7Mu6W/PHX64rJC/HxLPIzOcly505kmIoUiQdyYc6o700yD0VVNyxQjC9pRxglo4acjlPoCLgeF50qx0+tvA97IqPfKnDL1iUb0xO0hzkQ30dNbVGyFxPQpOngYo0P7B2OwHvuZ+MPBWagf13BhrO6aiNS6Gv+vuxPHEtXAkql5dVzET9IK3XN23D1DYJYnZSxrQU2poyINLZBO93YrYGEooHi9X1T1r0gfpSVxU9GOYFuLjDCyv60et+ptTx32zF5Hr8EbTwEwsqmkujYY+PGbmChHHTSvDDW6KWsDGTm63SEIf+gX926J+6IYOG2wHWPgW0uMQKtTi49X0lZME0j3TwZ6m5fUPRdfmqECOsnH7IO75AjCupTiFMOaIMTGjZ2P1qrqwd+veoOkjxlkhDNqaN4YyYRUyVGHLkT/LcEJb1ZHpr392c6YujDuRplnbjxgX6Px93LOP/6bolFR6i14ZXumk8Z80RcAp1LuwSquW3oVomlf74pMMHszrfdBRES/rZxYcEdXSgPuK/ScR9y8w4QnuPUG7IchxMlo8CE0WAn246eCXwg3uelL382xq2sWyKgOww8mQkaiAxttY+3wajygPGuSX+imM+GAR6BUWZtOKL0GAqDVnZp/6fjOo+QWFF2zj5hqPU8U0yklVbYuB8mPiylDvS6UsYJNX/K1utzbF/LI+6gHrhTzoALAe/d7gBt0ja1gAz0y20V
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(136003)(39860400002)(396003)(376002)(346002)(46966006)(40470700004)(36840700001)(83380400001)(426003)(47076005)(16526019)(86362001)(186003)(26005)(336012)(2616005)(6666004)(7696005)(82740400003)(1076003)(41300700001)(81166007)(356005)(40460700003)(36860700001)(6916009)(316002)(5660300002)(8936002)(54906003)(8676002)(40480700001)(70586007)(36756003)(82310400005)(4326008)(70206006)(45080400002)(478600001)(44832011)(2906002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2022 18:05:24.2045
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d473208-295f-48ca-2e8f-08da928dde40
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT032.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4369
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It was reported that an ASUS Rembrandt laptop has problems with seemingly
unrelated ACPI events after resuming from s2idle. Debugging the issue
proved it's because ASUS has ASL that is only called when using the
Microsoft GUID, not the AMD GUID.

This is a bug from ASUS firmware but this series reworks the s2idle
handling for AMD to allow accounting for this in a quirk.

Additionally as this is a problem that may pop up again on other models
add a module parameter that can be used to try the Microsoft GUID on a
given system.

This module parameter intentionally applies to both Intel and AMD systems
as the same problem could potentially exist on Intel systems that support
both the Intel GUID or the Microsoft GUID.

Mario Limonciello (4):
  acpi/x86: s2idle: Move _HID handling for AMD systems into structures
  acpi/x86: s2idle: If a new AMD _HID is missing assume Rembrandt
  acpi/x86: s2idle: Add module parameter to prefer Microsoft GUID
  acpi/x86: s2idle: Add a quirk for ASUS TUF Gaming A17 FA707RE

 drivers/acpi/x86/s2idle.c | 97 +++++++++++++++++++++++++++++++--------
 1 file changed, 77 insertions(+), 20 deletions(-)

-- 
2.34.1

