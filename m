Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16FEE6D7F98
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 16:34:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238451AbjDEOef (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 10:34:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238315AbjDEOee (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 10:34:34 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on20601.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eae::601])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13886C1;
        Wed,  5 Apr 2023 07:34:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fW0Ggo+RwJkQbH+gW+BeHaH4+rwcVtHKA1+KSVJK3yxS32Qn/uo1VPAPCujSUu+Wi+nbNwZqEfCULl7UyRp0eDLGE+/0tWzoYU9RAAda5k4jXjLQtUzCpLLCXX1pZdBD35NOE9BRlRAAV0fsMIGirwAhzcnIq2IBZCn5mD9Brh9Cs7Vmf6Y85OKSYioyXW7diBmUwI+M3nKBfEcjTo5l3adcbr3Av5XyXXE/ndWo4CXMCJZ2A3FGhW/DlIXGmwT37fW5tICeU9PE5vZxoPlEEG7ZIt5wNWw8Fw33XS1+zbgfTEf5OXSbjOvqaaFKKPLc1lGaGtY8gA9sgK2d666nKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kt3PY0ud7Ku92JLK+3YPx0QObceEiWNazVg6asdO2lc=;
 b=HFrVeyeirC/lqdllW/FbBO9mFBjfTW22h5SNbozN8qf+Joun80Sc0P+9ALUBxqwlXTiNpQiMb3GJ0UT86CK9YmQzWU4v/1j0DIl1ZL6Xzg5p3WH2WfjeiVxD24z9IKgkNxbo7FrNhpmNiNlXAVqF60Qr/DO6pwKAuJB83YFinNm15BKSp2xBJJVIPFGi8LBhQeP9gii9MpZknhFlsMqATaCeuQRckmdHfsN+W9vc8cCyQHPfkHYP89v/iHR/rlj3kz69pXMzGMv8/v5aQ43knx/qadSKmcWcfGHodim2eUnr9dKy3H1J7/gcigrSLRfihLBbx5VyxAIGU4MW9DsrkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kt3PY0ud7Ku92JLK+3YPx0QObceEiWNazVg6asdO2lc=;
 b=T4NKlybN0bdvdWRWI0IsTDdVV8uqdtKbtuK+Xx3+d3iHMpiOq5u7uHwrat8+6njl2LUTFsRmGterYAohkdcfvlLjQlMKjKfQuKkHtnR9ViLFHuJJS4c8YnzgYvk9MuwGJijSrQ04tgxfxN7XLRyfnIJjYIcfOY82d551hUTaUVfP2QHZrZDecBfSksSUb0HAIerEp2jgjx09tcrQBkg0xGuvtnyXV/rj1/UDKhFvPfLiZ5fZ4qznbdYXggIwNeeH+z5ixuNaa3ZUqKQwLleRlHDiux2GXJFhonLBnAu6+B73NEcukWRn7hYkccfJQXyAiNypc6C7/SvqE4sd+fXL+w==
Received: from BN0PR04CA0123.namprd04.prod.outlook.com (2603:10b6:408:ed::8)
 by PH7PR12MB7161.namprd12.prod.outlook.com (2603:10b6:510:200::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.35; Wed, 5 Apr
 2023 14:34:29 +0000
Received: from BN8NAM11FT089.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ed:cafe::fa) by BN0PR04CA0123.outlook.office365.com
 (2603:10b6:408:ed::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.30 via Frontend
 Transport; Wed, 5 Apr 2023 14:34:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BN8NAM11FT089.mail.protection.outlook.com (10.13.176.105) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6277.30 via Frontend Transport; Wed, 5 Apr 2023 14:34:28 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 5 Apr 2023
 07:34:22 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Wed, 5 Apr 2023 07:34:21 -0700
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Wed, 5 Apr 2023 07:34:21 -0700
From:   Jon Hunter <jonathanh@nvidia.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <patches@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        <torvalds@linux-foundation.org>, <akpm@linux-foundation.org>,
        <linux@roeck-us.net>, <shuah@kernel.org>, <patches@kernelci.org>,
        <lkft-triage@lists.linaro.org>, <pavel@denx.de>,
        <jonathanh@nvidia.com>, <f.fainelli@gmail.com>,
        <sudipm.mukherjee@gmail.com>, <srw@sladewatkins.net>,
        <rwarsow@gmx.de>, <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH 5.15 00/99] 5.15.106-rc1 review
In-Reply-To: <20230403140356.079638751@linuxfoundation.org>
References: <20230403140356.079638751@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <ee0bde44-7c8b-4590-94e4-e255945577d1@drhqmail201.nvidia.com>
Date:   Wed, 5 Apr 2023 07:34:21 -0700
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT089:EE_|PH7PR12MB7161:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b9999b2-a839-49d5-af67-08db35e2dcfc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PVTqazNMcT919swYKXYGryepYGDuruDdtgHyE41/Svzw3UTu9g2tZN+IB6lDlN6SXnnmd+okR1TL+7rFNEEuDGtzINP/MkS2eR07QOdYx4ntNozm7itGFp2fe4lh57FTFeVmwE/9/ZMUpaatywjeZnQrEE/RuxXjgtUoLu1y3qPndoBeDO4vTlPXfBNctf+sNJ2v5Zlytqhd7b4JYvnliICdr/2NIK15MxmpEPa7h5fhHcRLCDVma5hTEZCll/fI1w8FeF+y5QZBMtD7FNJXmO66XzhbQtpXSIt7xa09m1wGDteW+QsM2I0GIxPtOCgjdnCZDBLSAkUMNHozxEkzYgy5AFH+F7uG6/LrIU5LlV+puwXncTaUL6rchoNA64fhUlXwnSlbwOqNwZCYQUUUo1bEJvX5fefF0SqKa8J7dPz1Jij1GrVdGVKoU4xp7T6JcwDRSDaAV+gBM1CxGxg99PZqlGdwoHUVzej97FXFLMhKF1DIUrqXA0HFzlctk6eQiColDx4vHAVp1i5JeUOGLbflMrK9tkHipsB3y5O1LxZeEmTjnlNhPL9UZ7wDrc6HltDL0kV7PrQ7p6RpTdlHAx8bwgn3L39ZpabZLaSE9KZNhY29l0ZsBFUxN1Y5iHpDawwGXIvF7LgJeAGuLY90ebEMLmmmLHG0abdnPCAh3OU1RVVKOOr9Jjt265FBaSWHTwPErAdT35RCKOkKhBfXXFMAJ8u5dXYeC9DcPqe/e9oGJusfnKFXOwyIjWXjP2TMo6ksyVe41U5rNrdi0JcrwH4iZZFuWFUgbVcZ89qDYf4=
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(396003)(136003)(376002)(451199021)(40470700004)(36840700001)(46966006)(31686004)(47076005)(426003)(336012)(40460700003)(86362001)(186003)(26005)(7636003)(31696002)(6916009)(2906002)(70206006)(70586007)(8676002)(82740400003)(41300700001)(40480700001)(356005)(4326008)(36860700001)(54906003)(316002)(478600001)(82310400005)(7416002)(8936002)(966005)(5660300002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2023 14:34:28.7610
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b9999b2-a839-49d5-af67-08db35e2dcfc
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT089.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7161
X-Spam-Status: No, score=0.8 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,SPF_HELO_PASS,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 03 Apr 2023 16:08:23 +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.106 release.
> There are 99 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 05 Apr 2023 14:03:18 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.106-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

All tests passing for Tegra ...

Test results for stable-v5.15:
    11 builds:	11 pass, 0 fail
    28 boots:	28 pass, 0 fail
    114 tests:	114 pass, 0 fail

Linux version:	5.15.106-rc1-gaacd62149991
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
