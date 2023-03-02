Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C64356A7BD8
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 08:27:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229983AbjCBH1l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 02:27:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229958AbjCBH1g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 02:27:36 -0500
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02hn2229.outbound.protection.outlook.com [52.100.158.229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 636B125965;
        Wed,  1 Mar 2023 23:27:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ROZx95Ag2qWCz2PGHmybD0PiuHUsWZUUe5fff8EbNWZ/sBNGvyRppyApR/8HfwFj+fUfMIMpd0mNWyDXoDBk/CqvQ2390T1ug03iyrsnEWPLt+7Zvm2ivXcSFNRL0VfnEeEkWKml/0Xi8VCN7VKlGMXajQUCXtwGKhHS+STf5ddGFl64gwFIZpjcLs2aV1H7iBcHcFmX1NP3VOiPYMOB0Zd9cSTUMuNgJ7NuSpl2anrZjuvqh9gKCO1SEkhE0wUlAlRRHk2LeGH2b93zhStGakc3GA4Tj4YoaHClfBdmLjUVNMNmncw0F08hcOn6tk1DLSr7K1+zB7mZ+5e9OfzIAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V4DlewRtgx4I23ABQJJxtjlDah93wivz//e5pJg2Jhk=;
 b=iYT7sbMMASlNpb2vFlvUzuNEZ6rbfVP57DGkyIMQln11BG46EHJCkG4dLGpE0smzxtdeNdNRmFA8UzK6FxhRHn9rfyYoGavSVEgOGmd+TCJKjfGGEp5H8dO3ze4ZPyJXFW77k4pLOLoIaDTx78r78i2glaRr2pS/wvhb7WHpPf+IOr/ByyMC8yRpnvAOnVHcMcz8VATUPeKrC45kD6O+34LVXfFlUxvGFDnReTTNpwiNlf17lqdUwPBR7U+Y6y2+bXPeDrFRqB8nmqx1A+gs7rrbSnoh+gdkZh572bl0koNTMyURGIpfulw1D0VSCHmImnqfmPuwNDI6x1zkwzjHJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V4DlewRtgx4I23ABQJJxtjlDah93wivz//e5pJg2Jhk=;
 b=uhr7qjPcM6X8/Dg/Iz+ALA0hI328zPr/Tw6FDla3XM6+fpSiypPo1dvxFIKrzcAfzuaXbbSUrsQg1AgJ1Z9urlpqHdQyu34EiVEAqB6G7gBLM2mHgD6AXJCasNZfzsuAX2OlmX/PUJA68Lq4Xsz/14GkCWJ36w7iCRJkaa9FkDGu8cLOE8y84BBsKqRTinf9znIFkrlG0zevIXNhMP9HG9r4VStxwyE/iv0RqgLHz+BSuMdULIaLhqM6kvFGFbzZF2VrW8ZS2RWJTckGUmp/xzC8wEVmi+JFLqwrPefbguHO2Qudsn5PfTZp/2xbYQl4AL0NUnyVLiKwlUsU+jIfIw==
Received: from DM5PR07CA0085.namprd07.prod.outlook.com (2603:10b6:4:ae::14) by
 CH3PR12MB7763.namprd12.prod.outlook.com (2603:10b6:610:145::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.19; Thu, 2 Mar
 2023 07:27:33 +0000
Received: from DM6NAM11FT103.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:ae:cafe::83) by DM5PR07CA0085.outlook.office365.com
 (2603:10b6:4:ae::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.30 via Frontend
 Transport; Thu, 2 Mar 2023 07:27:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DM6NAM11FT103.mail.protection.outlook.com (10.13.172.75) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6156.19 via Frontend Transport; Thu, 2 Mar 2023 07:27:33 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 1 Mar 2023
 23:27:23 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Wed, 1 Mar 2023
 23:27:23 -0800
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5 via Frontend
 Transport; Wed, 1 Mar 2023 23:27:23 -0800
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
Subject: Re: [PATCH 6.2 00/16] 6.2.2-rc1 review
In-Reply-To: <20230301180653.263532453@linuxfoundation.org>
References: <20230301180653.263532453@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <82215d1a-2029-4c62-ab22-4c46b470f15d@rnnvmail204.nvidia.com>
Date:   Wed, 1 Mar 2023 23:27:23 -0800
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT103:EE_|CH3PR12MB7763:EE_
X-MS-Office365-Filtering-Correlation-Id: 29f8d2b4-235a-4c5d-ea58-08db1aef96fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aI3anh+Y8qAJSSdmnxBPiIHPRF9+ErxmZ+cmng6K9cElHZ9N4Ag3mLR8EUX1y7xzwSd5XJIdPmFrmEr7XHcjigD/XelpeNtazzssS40gLWV0J/zBtjtmWira1zYzpWur1tR667aDb0mm/c41TIHsPfulMo6E/dRsrMrIECnDTp4tA+d9iu4DGMALAOyCacNNo74TrcIlHB2Kn4jRoI5HvXGAxLokblLUuKdHzOQjutihlqp9yDBlJ9e5PdomC5xkZpPbaJxy7amwjvNvlZ7FeY4jQyvwoIGzJNBgXYg1KQQtlHDnyNRgfX3LonW2ozbQ40It4XDVL32OpuOQMrXapOsM/bcHn5lRvb3CGTcvndv4I/vejf0l1EaiYMmSbh6BnKHeac7N1kr0JMEEUDWJuFASODp8lAr/vWuG1gKnvwddqxVOFqM2Ycl/Ya8sGQtQlMaExHkBXeSZ82S6WO+Z8w6gRlxoKbuJ8lcqoljoN4cS1C2rTAVVYH+hpGlSZko7X0noT8wTkJl7SoU2mf7kZD4EwMmMyOWXX774m11S4EitmI9mAdeDeiJeJIUXqKKuAd45qladaHSmvOm9Rf5oZS+IfpjwRoPYFxPDZBig5K6l1rxJzx8HILV9gFN8CObPBGtQvpKzAF+IFfvjriDm9asgOF4zKboI0E4GMIdpOyFUqD4J1UZAvHCqulyDCChjJC/49JPDvD7Ylo4Dm9GqCrGP3x58dohTFywglfToX27+KfxlKcOJKS8zQ6+Lecgzyms9dirlJ1lRJKUzog9jK77XUYCJQ4WrmbCRdhjckcKJ4LOjJzbS6IMf2JCn4AkK
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(346002)(136003)(396003)(376002)(451199018)(5400799012)(40470700004)(46966006)(36840700001)(36860700001)(34020700004)(31686004)(426003)(47076005)(40460700003)(8936002)(5660300002)(478600001)(7636003)(82740400003)(7416002)(356005)(40480700001)(86362001)(31696002)(82310400005)(186003)(336012)(26005)(966005)(8676002)(70586007)(70206006)(2906002)(6916009)(316002)(4326008)(41300700001)(54906003)(12100799018);DIR:OUT;SFP:1501;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2023 07:27:33.4223
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 29f8d2b4-235a-4c5d-ea58-08db1aef96fd
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT103.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7763
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 01 Mar 2023 19:07:36 +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.2.2 release.
> There are 16 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 03 Mar 2023 18:06:43 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.2.2-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.2.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

All tests passing for Tegra ...

Test results for stable-v6.2:
    11 builds:	11 pass, 0 fail
    28 boots:	28 pass, 0 fail
    130 tests:	130 pass, 0 fail

Linux version:	6.2.2-rc1-gea5e1e557437
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
