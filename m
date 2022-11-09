Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEB246228F3
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 11:48:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230152AbiKIKsJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 05:48:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229896AbiKIKrk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 05:47:40 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2070.outbound.protection.outlook.com [40.107.220.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EAFC2657B;
        Wed,  9 Nov 2022 02:47:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xe26P1+GmyohsEoVPw+Yb/+RRi8iy/cdTUD5Uzp0m+XP5sCUWEVM/2XHWqQbcXHe2r488C4tC6GHyamq2CYd67Hu7Ddd/NsrBmHi4Q7xkYtw3UNPomcr7Fwjs+WSgsQTEbFpuJxmrAdWxKKq9IJ1j51k35JClCqoOoiGoiOVnqM3o+3z4i5JgnFaANrfU/BIgKbyVh8n7whD84B/BBk8SvtYYhF5QtLxP6yOEDnOFUlkyTC02UsvZTtsS3uxj/XbFzJqeUiLqwYKMG8wYcs9xB3DVDXlXVmb144vaeWDWCr6blaFJAIf5PkCIenuQCccIxv2Ztdk9lcemya4F7eD4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aeuhYxm/FlcVy3+IDy98VpxnPCb2nuwuI/+AZBJbXDc=;
 b=iGloi7Iv8qtMyjgRJA+BMNvzgD2akzAmWQE0TEabQ2NEDnDX0TjpmLoBTRzM0JVm50sKvSfOS+jc5MF+SdoZPk53c7NBnnEiULDovpdMYqEdmK2VuDcW0cNndaW3Px5qJKZMzDrPFedUe+DNbjjmPU/xWRak2YcO2uPx33cuNN9u41/SBPG1j+OZRtsWCYGcisW7LaAT53iZV9OrzMejcH1lRXy9zIr7Y3+3ANuLTlbZ5aFhurTPOYxB+u0f45+uVUmG1/AiUNJBnYIJhGwPs2EMohwx/Ry/JOXzScNvksAsyAbkMo60VDwOT0alaPlAinhH8n3rp4Mf1lzc5XQKJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aeuhYxm/FlcVy3+IDy98VpxnPCb2nuwuI/+AZBJbXDc=;
 b=o23sbimSkcurg782IsAuo1hceOxI3V4iBo4oBTZYBDGJiFlq7+ndMpY0kIw+y+7l2YnNpHC9560LoOkjNPT8fnDGc88v3c6QcaLO8Li8ZW84/UQipppX4V3yjmdZ2ZsXVG51YZwDASekZ6kq0sANLcPpawBqSccXDYxAVwwc0MIwHlP+SovgwXNLhe0C/2OtLkvEabHri64geO9gaPJiisEvjufY+rUaTZm1P1eK7xypTowqYneQtFODcsROCPwDwbBkXw9CKwOAxHTELdKcAdcjPTRCPSI6ABPAJl4saAKp1WIQdGmyc9ICmASLJg4YPWz4PL83B3XRmGRRA9mc1Q==
Received: from DS7PR03CA0155.namprd03.prod.outlook.com (2603:10b6:5:3b2::10)
 by SJ1PR12MB6098.namprd12.prod.outlook.com (2603:10b6:a03:45f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.25; Wed, 9 Nov
 2022 10:47:36 +0000
Received: from DM6NAM11FT004.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b2:cafe::2b) by DS7PR03CA0155.outlook.office365.com
 (2603:10b6:5:3b2::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.27 via Frontend
 Transport; Wed, 9 Nov 2022 10:47:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DM6NAM11FT004.mail.protection.outlook.com (10.13.172.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5813.12 via Frontend Transport; Wed, 9 Nov 2022 10:47:36 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Wed, 9 Nov 2022
 02:47:28 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Wed, 9 Nov 2022
 02:47:28 -0800
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36 via Frontend
 Transport; Wed, 9 Nov 2022 02:47:27 -0800
From:   Jon Hunter <jonathanh@nvidia.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <patches@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        <torvalds@linux-foundation.org>, <akpm@linux-foundation.org>,
        <linux@roeck-us.net>, <shuah@kernel.org>, <patches@kernelci.org>,
        <lkft-triage@lists.linaro.org>, <pavel@denx.de>,
        <jonathanh@nvidia.com>, <f.fainelli@gmail.com>,
        <sudipm.mukherjee@gmail.com>, <srw@sladewatkins.net>,
        <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH 4.14 00/40] 4.14.299-rc1 review
In-Reply-To: <20221108133328.351887714@linuxfoundation.org>
References: <20221108133328.351887714@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <b28cf9c5-f998-4039-a8f3-9294aa222335@rnnvmail205.nvidia.com>
Date:   Wed, 9 Nov 2022 02:47:27 -0800
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT004:EE_|SJ1PR12MB6098:EE_
X-MS-Office365-Filtering-Correlation-Id: b646e864-bbd1-45f9-9f4c-08dac23fd0be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YUmifgbhxl9wE9H52J/YanZhjCmoqNyCJN6F3ObEeZbCHz/KPdyKG4CotIVz304A73u2ptQu8Ohpwfzi8nodxFvKa4+FFqNGVz9RPV1KqxFDNVLgoIUjjy0SV3lb5etnrgGbqnNz2LjJlISIjJuo2Uwf8Aha1mqDo9x8lzLUIoy51Mk14lcL2NrUF51akiMfX1styCu3jcvu9fCVsR1lCBAX1k3KgO1umik7NtAhsOVXY4FEJOW03XnMTR7zZflHd8deqq0M/beuhncIn8KnV7+fXqdFDnMVDroLdFrx/nXymKr9GIlx55W12zQVIHhDBsUbzTxt7v6bPZD3fNSd/OBGKtQAXPtf9yBHLvUUgsi9l1OrZfCQls1gcdk0lIJ9O1z6iwo0YkflRcxv+AJ/XhiG+r8SpRcTcSFMcMgtDD82NmqMw2Lw6+4QHUAdge/AKzWVpi0jcqGexg20DUfu3fhmz/UtB8IGp5LHAVDZJOpuJJrBLxIB56LjjovVsnyhnadZdbdzefk8Ib9KD5Tv3fB9dLF+29kEM4kbrQJEzmnSY8wUxpv64Z7oTw7Swp+rKGaBn9HOOW58weGuqZNg9Cj1VbFwTpjjWojXc3aok3ttQymA9AI+Iw6ggQriFL+nlZjlKA51cO2DKSzAuLlykSbSX23Wq0ydRFN/27tWHTZzc7vE7Uf/cfgO7DgCbcWwhEL4PsOMn2uRslT1+OmfuIBxEBwEYEYt5zixzqaKBg0j9URiDeQR2OQ01+Gi426vh2tNhPTTLcns2SsmHzzzbzzd0t2ZpGva2BV6yMpqzxa8qJ4tenfkKjhx+DHbAhctzUW19GT4jQlBwki7a7sxkcDJhu5+QyXUOVG7HTQCPQM=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(346002)(39860400002)(396003)(451199015)(40470700004)(36840700001)(46966006)(31686004)(40480700001)(7636003)(478600001)(966005)(26005)(8936002)(82740400003)(36860700001)(82310400005)(31696002)(86362001)(40460700003)(41300700001)(7416002)(336012)(186003)(356005)(70586007)(47076005)(426003)(70206006)(5660300002)(316002)(2906002)(6916009)(8676002)(54906003)(4326008);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2022 10:47:36.5822
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b646e864-bbd1-45f9-9f4c-08dac23fd0be
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT004.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6098
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 08 Nov 2022 14:38:45 +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.299 release.
> There are 40 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 10 Nov 2022 13:33:17 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.299-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.14.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

All tests passing for Tegra ...

Test results for stable-v4.14:
    8 builds:	8 pass, 0 fail
    16 boots:	16 pass, 0 fail
    32 tests:	32 pass, 0 fail

Linux version:	4.14.299-rc1-g85bb1cff28dd
Boards tested:	tegra124-jetson-tk1, tegra20-ventana,
                tegra210-p2371-2180, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
