Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C50795F0CDC
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 15:58:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231651AbiI3N6k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 09:58:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231686AbiI3N6d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 09:58:33 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2053.outbound.protection.outlook.com [40.107.92.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D3D615C1D6;
        Fri, 30 Sep 2022 06:58:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cx5wyHVPRIc9vS184dGuWOZM+jgN4lpusiT/Qfxxlm/cAWcLS8BvCInKbWDVe1RCJyYE6KcgvMXq7in1r1Wf/r7B9KW23kTpSX5C2G1ATmWFlhsHUPPywBMSkrwkkymDLRp/WlNNbFgjmkLa3pOrF+lOXUWMwKhZ8t0awfrCVjq8a/4c8beLV7CpJOfdaZ9LghRLX5C9Y+EqsYbb/J6gXFunkUNRQm6Ub0cFWpTwdfH2zU9Qk+ZqeL26T63wWZZBfWi6JQr1oNehYYClhvyRzbbZsmeqSWXAidpBZxngVJ3EBjpNTcMFXmErk9ryXi+akpoNgK4ELVWeWu/4f+KrmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xjq0RDd3EuZ82uOR+3ccOhJgThI7rR+cHnd9LaGTIxc=;
 b=n+vGwKBonjr3/9WIuLRjUM1kpyQjgFrfpmQtd7Om+TaUhPpwfv/0Mghigon8Lqcr4mDQ/tk1iidasF6haN7lGUlxyY6HW+ESNoryI+hDWz0n7Pn7vfiNmBDXYIptSgBMzE7JymhMc3eq5kwFRHihi/LErglSQaM38h2x5UGxdl3w4V5O1eJx8lEVwVxdGislBZzls3grdxEE4u3gHDn0uJb/aPglSAnICCesBQiuxLTh4J42xd03CJNXYllPTNxXngDnfdDtouh9zLqUXX2KOM8+scvpRYpVEs23mY96OBXYfvgWj2F4Jvx3O/EEhgP+PXNY/3Xg5xQDuf1qSVMqaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xjq0RDd3EuZ82uOR+3ccOhJgThI7rR+cHnd9LaGTIxc=;
 b=VlTlGbu9agJmf3jISvH/vOsZ+32tsbybs7rgeN9XCGfNY8HFn5BzuoTrprO6Z5WmMHhEeXXZ+IiNXhY4nIbMweMIuIPwfiCbzhAHfM17dL6cttalzkipbrUNTTzyc3bi6BnUCKJCW39qPb5JNQTMGuJK1+QCHbU5Dcwe1wGnUvfapM1+Pl2EHWknWwl3VrqGRosca3UkQ5rig4Rsap0IWYexNyQ+ZppuMvWiL4SR50091oARIfZF1rapahiSj9cmpo8JiNi59MY/kpk7Ls6bw2rTE6tzSYtEpYes3zlQ1CAO9Y+HMjsvJszFpmy5WivD/scr7jCNSisUYeL98PMeHg==
Received: from BN8PR16CA0028.namprd16.prod.outlook.com (2603:10b6:408:4c::41)
 by SJ1PR12MB6195.namprd12.prod.outlook.com (2603:10b6:a03:457::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.19; Fri, 30 Sep
 2022 13:58:29 +0000
Received: from BN8NAM11FT039.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:4c:cafe::c2) by BN8PR16CA0028.outlook.office365.com
 (2603:10b6:408:4c::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.23 via Frontend
 Transport; Fri, 30 Sep 2022 13:58:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN8NAM11FT039.mail.protection.outlook.com (10.13.177.169) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5676.17 via Frontend Transport; Fri, 30 Sep 2022 13:58:28 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Fri, 30 Sep
 2022 06:58:12 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Fri, 30 Sep 2022 06:58:11 -0700
Received: from audio.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Fri, 30 Sep 2022 06:58:09 -0700
From:   Sameer Pujar <spujar@nvidia.com>
To:     <catalin.marinas@arm.com>, <will@kernel.org>, <broonie@kernel.org>,
        <treding@gmail.com>, <linux-arm-kernel@lists.infradead.org>
CC:     <linux-kernel@vger.kernel.org>, <jonathanh@nvidia.com>,
        <linux-tegra@vger.kernel.org>, Sameer Pujar <spujar@nvidia.com>
Subject: [PATCH 0/2] Audio configs for NVIDIA Jetson platforms
Date:   Fri, 30 Sep 2022 19:26:32 +0530
Message-ID: <1664546194-735-1-git-send-email-spujar@nvidia.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT039:EE_|SJ1PR12MB6195:EE_
X-MS-Office365-Filtering-Correlation-Id: 5af487ba-6c69-488b-7745-08daa2ebda35
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MkqAj1ptvxYcW+rt+Fwd6cKpZlNCeMVb8WclRWNCYXV+bBBz7Sl1hHjpx9gPoAof4Ye9vCwnFV9PhcsLINKq4Bkm0AuGa2ZNeC3ZfWnooscutEkN+jVtQsbo1CL5Y4BdttEr06ljXntO1XabN4dqo4bTdz3+oSPxLNqkWW84ZDXvMPiMJOFmsJIY1OhDulIBdpBuym/qTbBkfMoJx63SNhRzptIT/m4j8aKzSZhjMZVB1uh38H9Ha5qSTRvxDTGMftblJeLx4mvJvB8uEygd3+aufIT88kWiRNcxiWU16rYoABn9/foCBwsGx5dNoQRk1mIH5cICAI4eLqkP/nYPVhjDXdZiLIFvRdJY76zTJN/11moihHe0TGyqavwv+1dkRpFUT0UkEIaMwxzXRlHTLntVZk4vsUiVZkBpT/kcGb6H5VkP+pvN4bi36SMesJ25lg/kjym+XNu929olf+iVlt3p3ibE0tMt4gUPKjYcQioAYSrBy5VF9oIeSvNIJKtSyUo9clEWdFSYOifApoughT0I+oHNq6jZLqWpyWqe+01BCv0Wt3LLJacUz4Nzt7J0avWD68c5ZOQ820rBKAeKD8uybOXC/o4Cm7AXIw4lC5MmSW+5UudEqOEgK+d5Pxef3lAwn9JG9R33I8GckyGjcxemJmyI6I6FBdF21oFZrRidrl1q0YoxCOzowpgdcNB0BHT+SCqEvoF45kOeodubY+e4Fnwp4ZYdQuKL8b60D0WdMNaP6z+FtZpqNErFqhixb/NQt4gnsOAUHzAQGeHLBw==
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(376002)(396003)(39860400002)(136003)(346002)(451199015)(36840700001)(46966006)(40470700004)(41300700001)(2906002)(4744005)(5660300002)(40460700003)(426003)(7636003)(6666004)(107886003)(316002)(82310400005)(47076005)(110136005)(70586007)(70206006)(54906003)(40480700001)(82740400003)(356005)(4326008)(8676002)(36756003)(86362001)(478600001)(8936002)(26005)(7696005)(336012)(2616005)(186003)(36860700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2022 13:58:28.6110
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5af487ba-6c69-488b-7745-08daa2ebda35
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT039.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6195
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable configs for RT5640 and TAS2552 audio codecs.
Also enable SND_ALOOP loopback card and these find
applications in NVIDIA Jetson platforms.

Sameer Pujar (2):
  arm64: defconfig: Enable couple of audio codecs
  arm64: defconfig: Enable SND_ALOOP

 arch/arm64/configs/defconfig | 3 +++
 1 file changed, 3 insertions(+)

-- 
2.7.4

