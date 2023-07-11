Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C1AC74EDA0
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 14:09:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230455AbjGKMJO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 08:09:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230352AbjGKMJJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 08:09:09 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2056.outbound.protection.outlook.com [40.107.6.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C81E10FA;
        Tue, 11 Jul 2023 05:08:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M16r+oNjxIyDB36OU4kTuIppoeS9mt2cNbbbwYCA5GciqqhHU+T3AxpNC7xDdgrGvzkY3+rjbrSPETxE9jZBABkOt/kSrxy1lN4cB9NUqdVaQqpPEMlvH6VkZ+DydIzV15O3V0gm0a2fLy4Ly3WvfFybbgtnLd55197Wj6YvVa7af7z4ENcWwhhatr3Goy0TRjdLF2KqkpO+QtBpDdUlAzTlU8ml4u25XSbIftROWdpjB9lEEUs0ST/5qwxWbiYWzAoGgyqdxOp9vAuo/uzG0fDNSYFn4IxZwK73LMHbSaAu/pCUSs3mFQHor5EUjx0cCCoP6p3yGgCfjX/qgTXPOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K7OkhIarVXB3Ym6fNrE2sJl68n1Sp+LO0BLsyONYEPY=;
 b=Z2rbpt5ernGB9bpUDACeUqd5jNXRLJeMLQDg1tVaimdCoo8Xczyba1/VUYRI+TSwFQzwHSgKy+TfruhzE25k01hw+OtOY3aZTYP9a0ppE/a10qfZxJ8jpB2AzbjOaJqSMhZDfmncnB+Cq//CXk6FsqVpwIfCYe7gX6kF1TgFnXHqzCn8TjdkVVYeS4oJ7kiOt0SZsSCIUAMKB2HEvi2MnUF//WYgjEfkvBmdaOx0cWyVhc4fB81/426Ao5wTRxLUtxWXyu0UASWWaEgbL1dmuKJpv6kN/KBhf+LqjgnWaIPD+Tgxy6R1t6/33SeDWZoMDNcNF3vBCPPDBcFWfci2Sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.76) smtp.rcpttodomain=redhat.com smtp.mailfrom=siemens.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K7OkhIarVXB3Ym6fNrE2sJl68n1Sp+LO0BLsyONYEPY=;
 b=nLuaUPcMJuNLLU8S3vTBQ/d4aiHEVKru/TidudPgY0E1L5vqRNMGzZ0Bg52+LNnHlHEyfyaQ6pJgz2eFXbfYsmcGbUX4hFp9xrJkN1EXldAQqfyKChsZyvi52HPLAl/sk4CmhN+wkP8CaVV3oOcGMqFgEqURdwW2O/j9lWSQJYz2zgF1NaQc6UpyvN3OwyQ0xK8EmWjLAjqi98WJp1haFbcJdFagFVR41hvvpsw8VcXgRSgeCHRPF6jb4Kb3wcRrMnBnlKcQkIJzvBgv8NdpBPMKZiaGMj5RYRH0QhfunRWDddLRmlSYZxUaYxBbNEE862bH4lifPVGzrllwwgccoA==
Received: from DB8P191CA0009.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:130::19)
 by AS2PR10MB6950.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:57a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.31; Tue, 11 Jul
 2023 12:08:54 +0000
Received: from DB5EUR01FT021.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:10:130:cafe::7f) by DB8P191CA0009.outlook.office365.com
 (2603:10a6:10:130::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.31 via Frontend
 Transport; Tue, 11 Jul 2023 12:08:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.76)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.76 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.76; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.76) by
 DB5EUR01FT021.mail.protection.outlook.com (10.152.4.245) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6588.16 via Frontend Transport; Tue, 11 Jul 2023 12:08:53 +0000
Received: from DEMCHDC8WAA.ad011.siemens.net (139.25.226.104) by
 DEMCHDC8VSA.ad011.siemens.net (194.138.21.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Tue, 11 Jul 2023 14:08:53 +0200
Received: from md1za8fc.ppmd.siemens.net (139.25.68.237) by
 DEMCHDC8WAA.ad011.siemens.net (139.25.226.104) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Tue, 11 Jul 2023 14:08:53 +0200
From:   Henning Schild <henning.schild@siemens.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        <platform-driver-x86@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Tobias Schaffner <tobias.schaffner@siemens.com>,
        Gerd Haeussler <gerd.haeussler.ext@siemens.com>,
        Henning Schild <henning.schild@siemens.com>
Subject: [PATCH 0/2] platform/x86: simatic-ipc: add another model and hwmon module loading
Date:   Tue, 11 Jul 2023 14:08:40 +0200
Message-ID: <20230711120842.30044-1-henning.schild@siemens.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [139.25.68.237]
X-ClientProxiedBy: DEMCHDC8WBA.ad011.siemens.net (139.25.226.105) To
 DEMCHDC8WAA.ad011.siemens.net (139.25.226.104)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5EUR01FT021:EE_|AS2PR10MB6950:EE_
X-MS-Office365-Filtering-Correlation-Id: 76d53f7f-1e35-4861-d403-08db820798a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: q5INs2sgN29fg8RIVuk6nDy4+6z2lkTZr5wv15jN7G1Up7TSKI0hymRcVudxWkDO4DBrE9YLxwttsTQsz7FM3l9Orp/YYTLgyEnpvfnJ2cDSVcZ8IY7sKa34l3mjw9SvH8OE179DI6nvTJyY/bF+tUI0RlyhUStU9r/zpdHnyl1cMy0YVZf5SxVoqbHodCXp666V33u8OJoj2Qez062XtJOGUfuAAD5g5B6YsmAOoGDSWd4t8ACVQ3I3QcX/Ucee3/CkP3Alrn/UtVamXIbdGJNdMa3PayMvlWRVeTeEFOvBkHr65ZuY3frRzIAR2o+4abo7mEl5x/nCx2swZYOvbzeBw29f9UQo4wBatvxwyyGC7oYqfhW6F6u23dVmgjUfNNyMFHzgmvjzO5Srkm8smP8NtmBGv3VmkvvH3HtLfLk+GzKkZmJyVqL01AV7I4q06pZAffjataYJm+kRPPu2EAztddtvvPX/tTS1rbA9OLTQgU4r/ZPOsvlVS7x21lsaAptoXvxTUWhpK9+MXvxFox7cy7YUo+GtywLWWSNqpn4BXcFOtC3gA7v/5sRrzsGawDqZfTaogCDr3A7hGNbnoaN6V2kHpJwzYWnFdSb0XXqw7ipozOq7arJs9v7Fi/y/pTljqdy8kB8/c3f9D/89lEhZ3j46BZpg+RKYC+oYMbe6SyFutNI5e4Io8TymRlaYqCwCfmP0bqRXi4r0bCZQt+sdrpuBuvRUbHIoLt8ey/S/I8vLpRyUgNPihbcDqtmMlwdBR+0d5Sxpp4/K0gDyDg==
X-Forefront-Antispam-Report: CIP:194.138.21.76;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(376002)(39860400002)(346002)(451199021)(46966006)(36840700001)(40470700004)(8936002)(8676002)(36860700001)(5660300002)(47076005)(956004)(2616005)(83380400001)(16526019)(186003)(86362001)(41300700001)(107886003)(26005)(44832011)(54906003)(316002)(6666004)(1076003)(82310400005)(70206006)(356005)(36756003)(2906002)(4326008)(336012)(82960400001)(82740400003)(40480700001)(70586007)(40460700003)(4744005)(110136005)(478600001)(81166007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2023 12:08:53.9689
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 76d53f7f-1e35-4861-d403-08db820798a5
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.76];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5EUR01FT021.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB6950
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The second patch loads modules for hwmon support, should they be
available. That will save users the need to detect and manually load
those modules after a machine has been clearly identified by its Siemens
Simatic IPC station id.

The first patch just adds a device that is pretty similar to another one
we already had here.

Henning Schild (2):
  platform/x86: simatic-ipc: add another model
  platform/x86: simatic-ipc: add auto-loading of hwmon modules

 drivers/platform/x86/simatic-ipc.c            | 19 +++++++++++++++++++
 include/linux/platform_data/x86/simatic-ipc.h |  1 +
 2 files changed, 20 insertions(+)

-- 
2.41.0

