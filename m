Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74A236FDD0F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 13:44:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237007AbjEJLoV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 07:44:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236623AbjEJLoT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 07:44:19 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 117FF139;
        Wed, 10 May 2023 04:44:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H1amMV8FVvEJ8XmLoKjFAVDpAZ90aFnh0+1I22l6cdhggKB1P/WcbtEA2ziL0hwKIs0VcSFgNSSyG4Z1NtT+Ub0lns1Vkf0cc4p0ksxA4M6WIOSDY1xAF8GGVd57qaww9TPH60jcM7SUtINzC3dvXNLPUhQySRR3Wo9UsVPQwWF9hLoYVKYI/zFfw0mZb54eMDYh4WPlTkiNPcnfc0nGNCdqYQCAX59zZ18KuiOiW6srwmARCCyVnPs55OFMR9hVc/NMvyQUdmjhzD3Glim0uB2uvIyF7Igxo+ZK+Zhj6vc5PBzifAC/ylbsbZyZpoJpmdLQQzzc3gnPfD+O3YMfvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9x8TMLu5CAF6YrYbx9lnza1YKxgGnpMMNrRl1POcQOM=;
 b=XkGJHnKo0AqEJHBHsxSAjYUDHC5BeQ9y5rjTr/JqNvNo4zf/bKyToODnbvkighx0jcJGNtkcsinRuU3sq0Y7l1NNaa/tSaDxSRASIFxagybJJ0cYKD+QThD5LVP2APVvj0kHiIkBhzZNfPr0DK1+17iu7YO/oeR2ojhr5L4ZMDC3vjKaQbr7qgwMV5bnHTKmmqLzTQqCC6CPtFRjyQAUWixQm+fHmdzfBbcIXNkWhlxEY8JSfuDmAL3bLCHPemDoP02O0MLuWdYTRrB4uqmQ/56QMv1OZQWzBskKZFFp22AE1Xjca+iE8I5T6loVXTo3g5J8jbNI14rY2S+y5Pwi+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9x8TMLu5CAF6YrYbx9lnza1YKxgGnpMMNrRl1POcQOM=;
 b=PCvpBxlOkcN0b4pP82GQv4r5rhayQGRkUctAxCpx9bfGc3JSvWzuboCyqBI+f12WmjP4tvorn1trCqNSUJMZxNXgMf2Fg3AGdRib2mOzYM75UzsovXLVcOhCrGFReeLcnPCsxE0w1CXKjbjkXBwJ/8Sztd6z0ysM52RRVsm90mn9d/+b/g/dvEGCKfSJeyaxorKAsB6GHhsh+SVSd+13uP8gloM/bz0G62syXTINut3XfUNm/2TP+qF0vB1tev5OuXmdaXDMTdhmdeJw4Ch7cS6sebJV/1XhoIiSrjJbw74q04A9lmES8jGHXly0NXMCbGhO30bWfPoJORDX7ndpOQ==
Received: from DM6PR02CA0050.namprd02.prod.outlook.com (2603:10b6:5:177::27)
 by CH0PR12MB5044.namprd12.prod.outlook.com (2603:10b6:610:e3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.20; Wed, 10 May
 2023 11:44:15 +0000
Received: from DS1PEPF0000E63E.namprd02.prod.outlook.com
 (2603:10b6:5:177:cafe::dd) by DM6PR02CA0050.outlook.office365.com
 (2603:10b6:5:177::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.34 via Frontend
 Transport; Wed, 10 May 2023 11:44:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS1PEPF0000E63E.mail.protection.outlook.com (10.167.17.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6387.20 via Frontend Transport; Wed, 10 May 2023 11:44:14 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 10 May 2023
 04:44:04 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Wed, 10 May
 2023 04:44:04 -0700
Received: from localhost (10.127.8.9) by mail.nvidia.com (10.129.68.7) with
 Microsoft SMTP Server id 15.2.986.37 via Frontend Transport; Wed, 10 May 2023
 04:44:03 -0700
Date:   Wed, 10 May 2023 14:44:02 +0300
From:   Peter De Schrijver <pdeschrijver@nvidia.com>
To:     <stefank@nvidia.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>
CC:     <jassisinghbrar@gmail.com>, <linux-kernel@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH v2 0/6] firmware: tegra: Add MRQ support for Tegra264.
Message-ID: <ZFuDgmLXmTs91FqI@44189d9-lcedt>
References: <20230510113129.4167493-1-pdeschrijver@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230510113129.4167493-1-pdeschrijver@nvidia.com>
X-NVConfidentiality: public
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000E63E:EE_|CH0PR12MB5044:EE_
X-MS-Office365-Filtering-Correlation-Id: ff1f52f2-8a8f-4173-bb6d-08db514be169
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3sD77dQTqr+04QMdS5/gkjXjzYP20Og9zO0EUYxd56qBVbNOZ648//wmhiU2soSGT9E50H+hD+tbdT8Zr/sJ3BkeS6WXPQxpHAdfEKON/IP1B+RKO5tNfvtpJdt28/DY2RbvMW8YgCxqUuiT6kIysv5LGfvB5RqPxx7ekWx3rVc5fDK6sFigd/wv0dMmv6B9S9oPM4r1bHBiH9BilTDCH2EILo7x5vYdNw5hIcIfR0u0+kCkPvoHT20rWmhwOzZN+nz+rvbQKA/vDj1GhPt2TID6paaCWppnENoqpBZe1tkv/5BWUtGPwEaRtUMTZlBJHm3LSmJkuapCdao+MZvmpmFqwXZwGAqTuV+9DlqW+X58SVgahT1XcoDP8neY3AjZALE4mntyHbf/jV0qMdNistZdveFcfmpBr+pqV6A2wVqcm/O/StYV2+F6RxBU7DTFF7Zt2esN7OvHVQZcKBbn0JA55JAPXG22+TolC/RZilOZwG//d3Hk71xpPrOTzL6Epfi6yfrOwXzovTom8aFB6uwZ7gxCvkCK54UA/Din6YPHRgTJPruU09Cw3wWhIXFTllr2fLYcbRAp0YYWvqwD46hLJj+P5VPLWqbGL8aZqbZFa++Xu1Po6H141gSIMf3P65Rj5turpl0uJkEUWe80M9qHa7PrvN3bgBOzV2aki3C9WFR4EQdV7Eio5a2zCztR4Tsn1uSQwlUN0+DWtv7dPGjx65mNsxMJofhCytxc93mRz+Bg6xWbkN3hu1PrCXkw
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(7916004)(39860400002)(346002)(136003)(396003)(376002)(451199021)(36840700001)(40470700004)(46966006)(40460700003)(426003)(336012)(47076005)(83380400001)(186003)(2906002)(4744005)(86362001)(33716001)(82310400005)(82740400003)(356005)(7636003)(36860700001)(40480700001)(8936002)(8676002)(316002)(41300700001)(5660300002)(478600001)(54906003)(110136005)(70586007)(70206006)(4326008)(6636002)(26005)(9686003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2023 11:44:14.7694
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ff1f52f2-8a8f-4173-bb6d-08db514be169
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000E63E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5044
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 10, 2023 at 02:31:24PM +0300, Peter De Schrijver wrote:
> In Tegra264 the carveouts (GSCs) used to communicate between BPMP and
> CPU-NS may reside in DRAM. The location will be signalled using reserved
> memory node in DT. Additionally some minor updates to the HSP driver are
> done to support the new chip.
> 
> Peter De Schrijver (4):
>   dt-bindings: mailbox: tegra: Document Tegra264 HSP
>   dt-bindings: Add bindings to support DRAM MRQ GSCs
>   dt-bindings: memory-region property for tegra186-bpmp
>   firmware: tegra: bpmp: Add support for DRAM MRQ GSCs
> 
> Stefan Kristiansson (2):
>   mailbox: tegra: add support for Tegra264
>   soc: tegra: fuse: add support for Tegra264

Changes in v2:

- Added signoff messages
- Updated bindings to support DRAM MRQ GSCs
- Split out memory-region property for tegra186-bpmp
- Addressed sparse errors in bpmp-tegra186.c
