Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 362A0602591
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 09:22:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229998AbiJRHWD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 03:22:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229963AbiJRHV6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 03:21:58 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on20626.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe5b::626])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43C057FE43;
        Tue, 18 Oct 2022 00:21:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jCXF5bQ7n2GtAvk89aykkemi4wp4la9xoo6aHxuvV6icEnPPIrDPLL6uzXfJqIEv6WRIJFt7MJvFh8vH59VQoCMdHYbnQB1D+oB58z3riEjq8mzt/5IQTlJJUoDMgOE5LwW+BHv091dSpu3LSD6UfKMJlVlrIODEoJi2VML+G5TT6zEv7IC7KkBoc0LZ7AWIk95nqjoUXqeBeE3/eSA6KapSRH/9A4T7WnrOdomMmDZlL9qIQphbBoXTdQdATHRqF/yXljH3nvwmAF1GPCp/8FALNnaMnSDVCXii0a98k11fXrwp5CQXhFxGSq9hBGr+crRQk1BOiZ7Hi41cUuhFPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dRAJalTtBzjtEjDvJ14LUpiBSmJ8fy03Fr7GFH2DTt0=;
 b=FpIUFkf6ED59pn/owTZNOMF4vUAYwQwoO/ofHmVYHwAk/+tjpOJn3DfYrG5A+pPRvXsHrs62TQdjtNwzmNBosIAkwFMnfy78Sltx3fEEMz2KNW0HX85dU8B1bAZvnNCcAB/fszJj905hIqlwX7fdMNDFDRH8ouMlZ/mUcEcR0rHnTxv46QjXdaZ/442ElhgxEpNXXLfMnI0VNILbZqO/IJ4e++jPs8tuwTdaoHjySCDfEZLuWOZn8H86mrA5fSng58tmylYFq+vMJYdqUphdc32C5KwlA8ZHk3JERAl9up2i+StV8aloMYYvBsyYgs96ilwL3eZSQIPCt0wuei0Hxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dRAJalTtBzjtEjDvJ14LUpiBSmJ8fy03Fr7GFH2DTt0=;
 b=OInBFEwf8BR34YmWdLLhNlulZZrIs4bWmiCYTo8hMhBmK9sL2FPxDFaKC02lxzSbPJL1jAl9Pey89oYxAoXAuZzgxSr/tucq5sE9+t5AFgcp5rTafmEJBfm6k/pNhLWSQUtKVS07U9SiulS+pCAMNPpUTf8Azn4oj2ItVD4q5boLAAzIS7vQd6fKfbzKylMHlxkvndVLCM2DwrSdHTQM3MOrX4KzG1xjj0rAuWba1qmLzFbG8jFJrIsgeaATvqNcelSuQICSDwFTEAyLMP5UbJ4FLvPNzrN+IDFbmcLQ8+pIKBp8ZZ9gZthvMSrJmpmDQRjNi5l7pLjVLgiq9aMGVQ==
Received: from DS7PR06CA0041.namprd06.prod.outlook.com (2603:10b6:8:54::10) by
 CH2PR12MB4168.namprd12.prod.outlook.com (2603:10b6:610:a8::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5723.30; Tue, 18 Oct 2022 07:21:54 +0000
Received: from DM6NAM11FT073.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:54:cafe::8f) by DS7PR06CA0041.outlook.office365.com
 (2603:10b6:8:54::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.30 via Frontend
 Transport; Tue, 18 Oct 2022 07:21:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DM6NAM11FT073.mail.protection.outlook.com (10.13.173.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5723.20 via Frontend Transport; Tue, 18 Oct 2022 07:21:54 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Tue, 18 Oct
 2022 00:21:52 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Tue, 18 Oct 2022 00:21:52 -0700
Received: from kkartik-desktop.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Tue, 18 Oct 2022 00:21:48 -0700
From:   Kartik <kkartik@nvidia.com>
To:     <gregkh@linuxfoundation.org>
CC:     <akhilrajeev@nvidia.com>, <jirislaby@kernel.org>,
        <jonathanh@nvidia.com>, <kkartik@nvidia.com>,
        <ldewangan@nvidia.com>, <linux-kernel@vger.kernel.org>,
        <linux-serial@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <swarren@nvidia.com>, <thierry.reding@gmail.com>
Subject: Re: [PATCH] serial: tegra: read DMA status before terminating
Date:   Tue, 18 Oct 2022 12:51:47 +0530
Message-ID: <1666077707-13117-1-git-send-email-kkartik@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <Y05Pma6GLVtXVCrg@kroah.com>
References: <Y05Pma6GLVtXVCrg@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT073:EE_|CH2PR12MB4168:EE_
X-MS-Office365-Filtering-Correlation-Id: c105ecd5-d147-4153-b541-08dab0d96f2a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vJc35nx5jhrREz7NOyHMg7K39+tJFtdyhzO2GdKaJBFrTm1cqx0StS3qtf7gD0MJJaEizygmI2XpgMUGX9m5NyW88Lj7hvax/tIyrKY53Uv9s+RVoTbJxxTDIVontOib0JUBOzclfjmQxIv+wXSNQn/qWsEoQ0FeuPeKTCAY5LPcpDhkRFcyDJM7UjBSgKQpR/OSv3A9FE97mHNShM7Uvx17FiiktaVeMC/sDeOx4/KItOG3BUq1EBPp6oAmhFYj25OsdstMVQ54MNkmO+IyYhzsu1TT7zoMgMee1ApgXjzXMSa3cnVbnhY9xeDt4agFGvgUIMocEMT9HK1U/nku3UXiKkJUuZc+onmSgT2n5YQtb2G5sdtAkRPeqvQPrVSAURg664g24VTaB5w/uuHXpOqmBG3G8QLH5o3jgz97R8+AXX0JjbFMFNuaEJSX2EXeIfCcFG3rBsprgUeZzsV/5Cxn0kEXt0gwNKk+A19eHuJy2k/angqPv7klL8TQc3CJWoH8lK/W74r9hRxOozbmsxAvy/AgADhoqxqbB3s/Na661g1XogS8raGzl0yzkYFaN0PTXrsSXhal4QazXeupzECJpFjgXNr4Xyt2/3jbHHK6hYWqiL2j8x/ALbHBzI0fpWiVlJQzM57MmX7q6YuAhdkrw38l5/Fsp6/Xjf4v3beHr7S4EBdZ7BSUOMnmpV/O7h/k/vA883pUy31T16UH+wnAYcS/vBXXzvohblc/xKa78kMIqk6Fkr6/G2v5eFhEKt3RZxAYQ1sqsYmiT+PPeQ==
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(396003)(376002)(136003)(346002)(451199015)(46966006)(40470700004)(36840700001)(86362001)(82740400003)(41300700001)(7696005)(82310400005)(316002)(53546011)(6916009)(26005)(5660300002)(54906003)(40460700003)(8936002)(40480700001)(7636003)(356005)(4326008)(478600001)(36756003)(70586007)(8676002)(70206006)(47076005)(186003)(2906002)(2616005)(426003)(36860700001)(336012)(558084003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2022 07:21:54.4402
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c105ecd5-d147-4153-b541-08dab0d96f2a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT073.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4168
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 18, 2022 at 12:32, Greg KH wrote:
> So which one is correct?
They are basically the same patch. I goofed up while sending it.
Please ignore the previous patch.

Regards,
Kartik
