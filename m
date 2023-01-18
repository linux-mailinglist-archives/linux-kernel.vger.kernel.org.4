Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC18F671B8A
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 13:10:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbjARMKK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 07:10:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230021AbjARMHm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 07:07:42 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2081.outbound.protection.outlook.com [40.107.243.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08F9D38E82;
        Wed, 18 Jan 2023 03:27:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e0xuVBE6DNzNZM00Y2BMRMBe5/ZVWHjjdcID7J0XWqCE5HKNsiX2W6HmZJnNFcczP0JTzuJpU+XTa58eMZzEtO0N/emzs4DP8+iySdwBRVuxC238ixrPiMgMWcnFdRZAGRR3DzcxmkmzyyBKbgzRRSLbQktByzFBJVNTsdrQV2FYlnyaHa3KOyLIukw+L/TXsA8qqO8JU54Ry6/MYPGODvCb/ucI9w7XHTGD9tf1FRk6IXy3K6ZuZaqvtTYz03EG1W/vBSq18ElYAjmZpGvVLFV5I6o+189MaqdqEPz2UzRaNo8pYmo38P4rANx6NWsZdoaxTec4Mu15CoAVypGleQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yCHTUx1k+lLE4cqSDggVB+snXgLTlpbMzVk29jjKAyA=;
 b=Z3YTReh1dfyrvOGqxKjurWkn4koqs9Tbi1ZmE71Z4TqN2uFMAP6/bHqSH93DnqhlssFzq/Xf4k10vj91Gramww1e+23qM53CthnevM6d8OhCEKD4OCv3yhFtGUJBdKA2YByKyub59qAIvXjUBhpl+JFs7Pr6YRTd4EcDL9qd2Wx411cCQKNmfXCT52npY0NRv4aR4mL7Zw7nmrEPaNCDDkaUiNPMw+EgEygNxFsve1nXrJ3zayuasPylC2xT5B4OaIF0HBv3bxVpah2Y/bFT3lkbxYiKIZ/YYY3wlN41KM0BUKD12kzQbL0V514bTSE94LJbrjPWTsIb+KUuwtQuHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yCHTUx1k+lLE4cqSDggVB+snXgLTlpbMzVk29jjKAyA=;
 b=PCVM411lW5t8SGMTPZOnSCDE/sKgsUaBd86oaox+ygufOj02YGQZurXTKUpGYIPE7eNfvblvlpAjWGOPwXjtPWlquYOG3YI/lPRmqKuFXHMaF+Z1EAMXKTBHG0Ka1pQxXFO6PA7Aau2+odRqvKGk8qKa5aN2Bz3RuY41NnqWfAdZgdrojZjCAYKGFArCJzrnKuBDjg4Nl9WqL96m/NQZd4wrSye86C18iiTOSJr7jsPrkvIw8ri1fWhTsO9UGn11mRCQrNIOG41ehaaNDpyGiCEYNli7Z5Wz/JpsAey/+o1QtfObXtBhIZ60opOOratuj+9IAPF7JSS7f1KYOyw3Mg==
Received: from BN9PR03CA0088.namprd03.prod.outlook.com (2603:10b6:408:fc::33)
 by MN2PR12MB4487.namprd12.prod.outlook.com (2603:10b6:208:264::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.24; Wed, 18 Jan
 2023 11:27:07 +0000
Received: from BN8NAM11FT055.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fc:cafe::26) by BN9PR03CA0088.outlook.office365.com
 (2603:10b6:408:fc::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.19 via Frontend
 Transport; Wed, 18 Jan 2023 11:27:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN8NAM11FT055.mail.protection.outlook.com (10.13.177.62) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6002.13 via Frontend Transport; Wed, 18 Jan 2023 11:27:07 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Wed, 18 Jan
 2023 03:26:53 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Wed, 18 Jan
 2023 03:26:53 -0800
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36 via Frontend
 Transport; Wed, 18 Jan 2023 03:26:53 -0800
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
Subject: Re: [PATCH 4.19 000/477] 4.19.270-rc2 review
In-Reply-To: <20230117124624.496082438@linuxfoundation.org>
References: <20230117124624.496082438@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <5474d433-2f5f-4f8d-99f2-12af4fb94b69@rnnvmail202.nvidia.com>
Date:   Wed, 18 Jan 2023 03:26:53 -0800
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT055:EE_|MN2PR12MB4487:EE_
X-MS-Office365-Filtering-Correlation-Id: 83368d73-44aa-434f-6f86-08daf946eeb2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cPzkPTP/8Q0kC205o3TB3QWfHgf6TRf6yvPMvwxQl8ld+gZkypPnFk30Cgf9AYMx4DhnmS5w0y2zcWWwhaONl5VS7XU8R0DCyFfYPSk4prh0TmEYIERCzbpOhtwQE722GiMTKEgFFzjuJzZs3VyfJtFH2LCXmREhp8nmHguKpP8F2m0RI+8Mn53KCqFSDFkVOqtrFSONuFnhJ0yxLfuw6UZ9MIeE0b61qlsYGwiluatwhqvIvH6NIvWwZZbHty+SfhpHAt3FeJYJOd5613IEre2R1w/5ehwSS1+nfh8i2qtGqPSgpd4Em+FVjqvnzSooR3rpOa2Crth2nwjxyeADPOSEZfJ0KHP+FMXrFJm2XzicvE6is1Q2MDBZm5Wd4k16yM2EHETBHlKeTtS4Od3pgJZpGnSbZXLyYZuSU5LPQUPH5fFn//GcqgOTWnXtjowB+Tm6uweqfZGfjibtxNqDpwBu16SE3Z5TUcN/0xWWn06Iy1yfxxT2tlofLL8TMjHfI7M/Dd7Q5vf9m21NtClK97seV38JvOKyVQrPxNVrrTfDMGeghx/Iev6EyfoNFiRVizKFU/imlMNDNrSZm3WpzP2+HgpH7fNLydX63sKRry1ihc924ImWkIu3e6GdeIKu0X9ghiM6gT8cJG8cqddb7NibAHk3w43iChFDk5nSfMj9m4+aL4MEBTtHXTJQMjdBkDluj748ga0OIei/GlX52/az1lTUrRfoIskvEPAHbsrjafmx5snyxmW/qiANlrKcmR9Sn/SL7gf3oG+z9kJSC++luZt5AtZfsvrr4a6V03E=
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(346002)(39860400002)(376002)(136003)(396003)(451199015)(46966006)(40470700004)(36840700001)(31686004)(356005)(86362001)(2906002)(70206006)(7416002)(70586007)(5660300002)(8936002)(82740400003)(36860700001)(7636003)(31696002)(316002)(54906003)(47076005)(426003)(966005)(478600001)(82310400005)(8676002)(40480700001)(4326008)(41300700001)(186003)(336012)(6916009)(40460700003)(26005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2023 11:27:07.2170
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 83368d73-44aa-434f-6f86-08daf946eeb2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT055.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4487
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Jan 2023 13:47:51 +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.270 release.
> There are 477 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 19 Jan 2023 12:45:11 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.270-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.19.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

All tests passing for Tegra ...

Test results for stable-v4.19:
    10 builds:	10 pass, 0 fail
    22 boots:	22 pass, 0 fail
    40 tests:	40 pass, 0 fail

Linux version:	4.19.270-rc2-g2738270a8760
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra20-ventana,
                tegra210-p2371-2180, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
