Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5C2C69E6B7
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 19:01:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230341AbjBUSBd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 13:01:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230399AbjBUSB3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 13:01:29 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2085.outbound.protection.outlook.com [40.107.94.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BD132C64C;
        Tue, 21 Feb 2023 10:01:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S9zx8ToymYDBo8fZ/QP6TiN3L2U6Btug4x2AafFqLmAG0Rc/Ig1siBK/f2lJaha+1iQQeOXTjMtZwJgxVJnRylhhruvDlNxPltQSu3DazQ9dRWjGfErvQszupkQ4JS072EoxLtrsb76LUv4PIRjGd6O30b+42aUu4Z2WWW2xEZA3OMQBFwATtvOid8oY0froF23Fd+bSq0MK4JHb2c29bMBYz2s/wkNshqRnIh+lrEgNC5TaWTTP0tib7kOt5DsnGpq8iTIqK8E8CK6OS0HJfB/2Ig26BdMnv5BgrWYXMNL8tePlIW4ZANuWqdTPWccUZuDX1+w+w7mmROaEHnFlEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SkEImxe9j3StQFQ+21imjsMhjucqQoUqph+gNM2Xjs8=;
 b=h5EvaIoVJ+1Wn03x2pqHJjNxHsL9TaLKvIx6SGh3lumh1I5CuOVlp+oDTcab2W3MTLxpYcY7n45zADE/9mj0oUm5IQel2GxboxJ2qECESbxRGp5rdxzqkjFRD28PcEYKQT9qkT0LzbPiCr4oGH2Y/cYdbqzRznjc5qQewOfdgbEai0kPTzKege//b/O/vidL5B0aldXWb3zlv2ZOh//kRDKt+xBlU5958ioBexzZ3Ooryg2jzKDZqCbKieb0PcjRlKc/JQSgt70M3U01zG9j9T/5nVugzk1EfEjfWPEwK5OsR1nr0iKpkDE7+p4x7GCv/28F9JFwQXuFWB00be4Gfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SkEImxe9j3StQFQ+21imjsMhjucqQoUqph+gNM2Xjs8=;
 b=0y9qGQE1poTYxogcaW5u3ey7KrfZZkZz68qAVz3wpjaeUEkC3aE1W2mAF137p6JkozYyka8SOmg4jzZRbFlvkxh1NIWotnP7MxfEeiCewXu+Oz5Ha9at2lDnHB8LFiG3o/6E4g03PlZtwhsUor7XBaXonqYF5cb0asOsNLDQESw=
Received: from MW4PR04CA0380.namprd04.prod.outlook.com (2603:10b6:303:81::25)
 by BY5PR12MB4115.namprd12.prod.outlook.com (2603:10b6:a03:20f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.21; Tue, 21 Feb
 2023 18:01:25 +0000
Received: from CO1NAM11FT106.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:81:cafe::de) by MW4PR04CA0380.outlook.office365.com
 (2603:10b6:303:81::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.20 via Frontend
 Transport; Tue, 21 Feb 2023 18:01:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT106.mail.protection.outlook.com (10.13.175.44) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6134.17 via Frontend Transport; Tue, 21 Feb 2023 18:01:25 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 21 Feb
 2023 12:00:50 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 21 Feb
 2023 12:00:49 -0600
Received: from iron-maiden.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Tue, 21 Feb 2023 12:00:49 -0600
From:   Carlos Bilbao <carlos.bilbao@amd.com>
To:     <corbet@lwn.net>, <rlove@rlove.org>, <kaiwan.billimoria@gmail.com>
CC:     <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Carlos Bilbao <carlos.bilbao@amd.com>
Subject: [PATCH 0/1] docs: Add relevant kernel publications to list of books
Date:   Tue, 21 Feb 2023 12:00:48 -0600
Message-ID: <20230221180049.2501495-1-carlos.bilbao@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT106:EE_|BY5PR12MB4115:EE_
X-MS-Office365-Filtering-Correlation-Id: e2c961ce-6a5f-4429-588b-08db1435a618
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2ZxZPQOshnMUDg0rB9XAFmsVk5yGjWVlFLEs8ZvlJEcPs6rZ3hvTKnL3hNdJ5MuSWJPteMCDfJqEwS6+wlBOB2ZnZr7/hRKoYp3ufO4135PhtuUNkoFJFRjUriPkv54dw7eryZl5hnuopW7YJmTtV31uXQC9pCkfMr1kf6jBL1CCfKAplH2E25gSLLtF48eIJtUXX9ypHMPF1F8jgBbfgyOkwqo/Ue8MPMHuu0i6H8E98WOlILc+aIer9RcdFVGG9OFqo0JESHm3FjpcMXMwwymFs+xZsJIO6j9tmW7Tj0SGLRnEfwbpahMf+Ft50WqLj61Z0PP7n+xekpJ73H+Uy1bnYW0/8Pr6Uo3FAWH07onxGKY10ETszn2ATcc4YXwfPRPx1HQsce66yhQPcdQVL7maP8mVI+KoPK18kZfWPV2dt+iIyBfaCj5nhhiWNkcEu1apCDovr/U84Z7CG7Q/HWN2d/CO5R2ztF76EMtIKZj8P7HsEeXJTD04AuoCsdLzwlU8bRDe3gx85fel7D7KUPpIyhoez3tqz/Zq7Vl81UmcuXidEFWTfXXlTmdA/mNGTaShB17a5U2BNfN3Pa7pTXPQme7MHQ+qTKZo41OjE3GozlLlO7tFXTDCsc9Lb3dVED6zMaPjozcuRO4xQL/owYJx7XW/dnojdxfLz5X/A4YjQfIPTlSzabnNKV10t1KwIz0mTTRL3PyZaAtpeDp4gB5jSZoUSrZkpHqanXqutco=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(136003)(396003)(376002)(346002)(39860400002)(451199018)(46966006)(36840700001)(40470700004)(36860700001)(110136005)(86362001)(478600001)(54906003)(356005)(2616005)(82310400005)(40460700003)(426003)(47076005)(316002)(7696005)(4326008)(40480700001)(1076003)(26005)(186003)(336012)(44832011)(4744005)(2906002)(36756003)(41300700001)(8676002)(5660300002)(70206006)(70586007)(83380400001)(8936002)(82740400003)(81166007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2023 18:01:25.3930
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e2c961ce-6a5f-4429-588b-08db1435a618
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT106.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4115
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kaiwan and Robert, I'm including your publications to the list of books
that are recommended reading in kernel-docs.rst.

Please, if you publish in the future, contact me so I know to add your
new material. This goes to other people working on new kernel books too.

Signed-off-by: Carlos Bilbao <carlos.bilbao@amd.com>
---
 Documentation/process/kernel-docs.rst | 29 ++++++++++++++++++++++-----
 1 file changed, 24 insertions(+), 5 deletions(-)

