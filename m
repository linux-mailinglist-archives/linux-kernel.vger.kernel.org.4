Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 560AB5FE20B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 20:51:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232071AbiJMSvo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 14:51:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231927AbiJMSvK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 14:51:10 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2057.outbound.protection.outlook.com [40.107.220.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17D2B40E2D;
        Thu, 13 Oct 2022 11:49:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UCCPFck972/LWiSwHP9ee0dOuKKIg22BPvalwSIeAmEDX4ov63SDZ+e+drPpuv7xX4qqLdOzeBzQRPXrDmYUr+pt4U/E24GKOlBQjeBGWPW1L0cUQvxOIGVHx9E5BxORhdCQyXKZKt4YPY3Zx4eZ4WpMjFDX7Y/3DeYjpEbM+QL+One2vH1DXumNLu4uoMJome4s3ETskA2YcnBcHmmekDFSD0x9VpvE3XlFgyXluZZ/k4x1WefFzFvCAw7nceamtdXuBp59VdwXHuzkug26qMzdLa70ZygG5+vdQth45//Gh6wZlk2tzTf8UytMTdglNkcC5sxy16Kk8Rx9cm5AUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6fQhXxV7ZyPHiodi6MSm8RH6inUL+zXQhWxMgej6LU8=;
 b=FFG9vkTAnwzKaX11cEzIBU2qNGALO7nY8VkMyZrJxRVmM3FRraXj1+DNe/k2KInuSDePOu7qc0VpQ49BSJLc8WVVDHQvr5+wgCOrrok/B8M5PeQAVQm3QVTZpkdGCNQDqqB4OjXqdV4Wj9j1S3RaJl8n/6E6aq5bBsGdZMcJ/gykDgws6KO3JSG+R8IeKoFrHYi//cJUJTaATAuVbHfJY+excrQYUFTExTwoSIB2rwaccPRnw3aICVarKFnausY8gNEFoeplzyWU4vVBmRCwrdvFpXGDcKMQZeukerh/znvqd9NA66p6+EQcsqROM1oHIeenv4PrAsUOJneVralPtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6fQhXxV7ZyPHiodi6MSm8RH6inUL+zXQhWxMgej6LU8=;
 b=htgu1oSvdqN5nlZNNpX6S3406dghvmGRi2Wito2ESaFjnxLdhTgIscDZbhQTrZ3gRjzkOSeA6Qbi06espmmB0EuQsdMFNAxCXUGV+qLPyn3ygiOIdwf86h4ZamvW4Z/JcaO3hdcIgRvZx8gfZZ82CBPkt5ObjSxnh+Xh3BIpxpg=
Received: from DS7PR06CA0035.namprd06.prod.outlook.com (2603:10b6:8:54::9) by
 SA0PR12MB4509.namprd12.prod.outlook.com (2603:10b6:806:9e::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5709.22; Thu, 13 Oct 2022 18:48:18 +0000
Received: from DM6NAM11FT003.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:54:cafe::6e) by DS7PR06CA0035.outlook.office365.com
 (2603:10b6:8:54::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.22 via Frontend
 Transport; Thu, 13 Oct 2022 18:48:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT003.mail.protection.outlook.com (10.13.173.162) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5723.20 via Frontend Transport; Thu, 13 Oct 2022 18:48:18 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 13 Oct
 2022 13:48:17 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 13 Oct
 2022 13:48:17 -0500
Received: from iron-maiden.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Thu, 13 Oct 2022 13:48:17 -0500
From:   Carlos Bilbao <carlos.bilbao@amd.com>
To:     <corbet@lwn.net>
CC:     <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <carlos.bilbao@amd.com>, <bilbao@vt.edu>, <ojeda@kernel.org>
Subject: [PATCH 0/2] Documentation: Start Spanish translation and include HOWTO
Date:   Thu, 13 Oct 2022 13:48:14 -0500
Message-ID: <20221013184816.354278-1-carlos.bilbao@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT003:EE_|SA0PR12MB4509:EE_
X-MS-Office365-Filtering-Correlation-Id: 6adacc23-d1d5-4e9c-9c70-08daad4b7e69
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ozRjzOAh8ATjQ5Go11CuF41ZaLW3kRmX5UrWeOliyF4Zp+kO8QF2+2zwnHZCy6d8tLTfvsqQyaWBiIzRCJ15L7cMZl1R+/hDfhTeEL9XnJ+nE2p0KpFI35ZRi6IrlF/4CDMCM2OkcZ+j0mUeyjjElFkJYmZR9r6kveze8066WOrZ/F+4NSxGiXF68L3gEOaVNtQkCzPO9w15elZK1bAITC3e27R+P7tx/9/JPhG7Qlw1OUDNfAphWVlEauGwvn0qPG5rgNOvO21AtA2HfIK2B9eA8/BzZmpCFtRoMvu/nirkJPbYJ64kcWchNsIzcKHiFmw6r1KpVAcdBtw8bTw1LF65ut2Cj2y5tbD1KfCpx5HVTOQQ+7F8o2ylT0dwcASOZThJEJyFAfwPcJFDv9PW2AVlb4l8TimKxORggXRp8PBCrKjDoYmXi/OYXUWIuxA4Pu3nLX4v9e4LmCX8UgOKrCar9VToSw4rW0a+dzo6JcaRoB7zwaeiHprbMweUeZ9ZjstzD0jBrUIjINyYM+i4aGvQNxHyGG030LZQxx2dkmNllt4LBfLIBzqm2bEnPrz48LiQWzAyKc076DLcq3jQIJo5YhMSfMCpocob2guVdohlezciATRlWsEnL2s2ZQ67hNSmFdhCf+LbyZPVkwdgMcMw+MhJJulArQcpEkSUp6iLPdnbGLHOAK+bK1r5v/KFq8Z+VhnKWWmzqmHOntjCqrErzBH01+nzv/k3aJJ0ZvDN4KpoUV3puYtHuWjKc7rgl0bHnEaEihdRUSVBT4Js2nHUIuQi0goMgSlJ87yTVbNZ/kvnadRi1WiYXwApXr/8469NkpgRc/MSEazKm+XYNq+fU5tMQ1pX1eek2RXHOSg=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(39860400002)(346002)(396003)(451199015)(40470700004)(36840700001)(46966006)(86362001)(36860700001)(1076003)(40460700003)(2616005)(6916009)(36756003)(336012)(54906003)(186003)(47076005)(316002)(426003)(6666004)(26005)(2906002)(7696005)(4744005)(82310400005)(40480700001)(478600001)(44832011)(5660300002)(41300700001)(8936002)(8676002)(4326008)(82740400003)(356005)(81166007)(70206006)(70586007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2022 18:48:18.0568
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6adacc23-d1d5-4e9c-9c70-08daad4b7e69
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT003.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4509
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Spanish is the second most spoken language in the world. This patch set
starts the process of translating critical kernel documentation into the
Spanish language.

Carlos Bilbao (2):
  Documentation: Start translations to Spanish
  Documentation: Add HOWTO Spanish translation into rst based build system

 Documentation/translations/index.rst          |   1 +
 .../translations/sp_SP/disclaimer-sp.rst      |   6 +
 Documentation/translations/sp_SP/howto.rst    | 619 ++++++++++++++++++
 Documentation/translations/sp_SP/index.rst    |  80 +++
 4 files changed, 706 insertions(+)
 create mode 100644 Documentation/translations/sp_SP/disclaimer-sp.rst
 create mode 100644 Documentation/translations/sp_SP/howto.rst
 create mode 100644 Documentation/translations/sp_SP/index.rst
