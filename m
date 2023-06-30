Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2662B743BA1
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 14:10:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232302AbjF3MKZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 08:10:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232717AbjF3MJl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 08:09:41 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2056.outbound.protection.outlook.com [40.107.100.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1BBA49EF;
        Fri, 30 Jun 2023 05:08:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b1O8lZrAr6gT20P6kFMEhs2Zov/RkzvjfLEn2bKLTtDdbTix86Ob5E5Wk+OwRDPxvsS9HOEaszPCc+7T3ysqkqLgxaePcP7TE9rFNz3aXU01KdA3PYIshP33aXPZZGqLbUKoP6IqVho3mHV+rmaO7p1IFufF71MncBICKNNItx8462inj8toUn92j1R1ILrI1t+i3Q18j68fC0ETREq+XBaqo1dESCk9frihZmUjYh5yJhKxp0IwMBLdztvTok6cqkoRwe7wlvbQdh/n9ocvfuPh/SZZKo4XRef3RPurwJoEOZBqXmknHNrTCjaXLi4BmMqTfYJ70IXmAxm850izsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hfvzhNXZE+FGcCpDrymfPJT99hGeJmEBnaokpr4WdfU=;
 b=AiJQsIeCgwUYOH5Dy1u87KjsxAg0NB1LRdfMcIrvq+96IWrmBd4fhwxxBpoz9vGgZtVp4CMFR9hNCEfTd/u3bOOchf44ONHWGnx4CTDj9hdGYE8zwOVmsq0r/aTIehLt0T3k6PVVnCplY7YrJ/We9dz69gMPzoHM0IYeUL2PwiWUeegv2Zyd0grEbV39UghVyn5DrcLrGTeJ2MuQX9OGyXHjCfqUdv/TJ0Zipi8SiJsW2vQmYeQ10w+cEXFDcgFF9xQdVNqSUYwdOc6PAHNYMfYYDUMaTTBs0a+zlupyP5YISG1zCoRwCjT0mcQUbeX4AHJSx1z3Kbfzb/FPyhK7Qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hfvzhNXZE+FGcCpDrymfPJT99hGeJmEBnaokpr4WdfU=;
 b=CValdsVe9iSktF27lcU1ndHBiwG6QTpq7Lc8D2sRNvszKWNOyCHcXzaRzyQVrgoo/AYCoPTGgBIyOe5Ctwsf2DSeQ6wbCj/KG5JJYEgdUhPqr0PpPMsl/jA/lkWeBsb2orkb1wgkShpmQiH5g7kfXP1vFfJ+ZR7r9TbCSdf5RruxrX47riG0z8lLo1sbEgtD6HUrAiiIIAPItRAx3ubGLkivyoSrMlSsi8cun/0q7g/vtbUQw0fsTOt+iVzcsgnzEoQlDu+03+U4EgCY59R7aMmEkEA3XQEn1FsLSzmTt8RwhKfl5jxtzvKLJYYvlG5Sj4ClIBu4bWv/RSvyojCv0g==
Received: from BN9PR03CA0645.namprd03.prod.outlook.com (2603:10b6:408:13b::20)
 by CH3PR12MB8756.namprd12.prod.outlook.com (2603:10b6:610:17f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.47; Fri, 30 Jun
 2023 12:08:38 +0000
Received: from BN8NAM11FT057.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13b:cafe::ad) by BN9PR03CA0645.outlook.office365.com
 (2603:10b6:408:13b::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.22 via Frontend
 Transport; Fri, 30 Jun 2023 12:08:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN8NAM11FT057.mail.protection.outlook.com (10.13.177.49) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6500.49 via Frontend Transport; Fri, 30 Jun 2023 12:08:37 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Fri, 30 Jun 2023
 05:08:35 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Fri, 30 Jun 2023 05:08:34 -0700
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Fri, 30 Jun 2023 05:08:34 -0700
From:   Jon Hunter <jonathanh@nvidia.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <patches@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        <torvalds@linux-foundation.org>, <akpm@linux-foundation.org>,
        <linux@roeck-us.net>, <shuah@kernel.org>, <patches@kernelci.org>,
        <lkft-triage@lists.linaro.org>, <pavel@denx.de>,
        <jonathanh@nvidia.com>, <f.fainelli@gmail.com>,
        <sudipm.mukherjee@gmail.com>, <srw@sladewatkins.net>,
        <rwarsow@gmx.de>, <conor@kernel.org>,
        <linux-tegra@vger.kernel.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH 6.3 00/32] 6.3.11-rc4 review
In-Reply-To: <20230630072120.689306958@linuxfoundation.org>
References: <20230630072120.689306958@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <d9f625cf-cc94-44ce-b4f1-dacb638aa33b@drhqmail201.nvidia.com>
Date:   Fri, 30 Jun 2023 05:08:34 -0700
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT057:EE_|CH3PR12MB8756:EE_
X-MS-Office365-Filtering-Correlation-Id: aeaa2347-aac4-4646-c541-08db7962bc73
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nUWVkPcYBzV7OFLUuWn7nUkFueXVqi0wAmSzG071O9w4jS7O4kocXVHKPWvBaBiAcGVP1sDTma6C1ihkhXsWcmHGgq/xX2zGPmjR0EHxzA2ZvxQSHRfcB6Hqg9zpOLD5hxyM5qCWSp+XZ1bYqYdz0RZaz9y5ploN0LVqsm/NNvtTNWP1n9zA+EYi2OrQ81K7mMoHiqOBVqkkWZ65F+Tep2efubafvKHGi3xSGCm265dupgRXTJNNDFFvraJEHYLEpiZycFD7sH5/b10VlvVpkNu+1DphkhgTrRywEcON62wkijIxlsD8iZ494culY5SpHB8hOP7L+92m2v+/8H+PmzwFzchcoj4IOzLXf+tQWzqUYD2jMXp8QyWfcUb3wW8Ex3BuxGNRtXxBg0I5f4TcvWGVP1TdaU7ls25PQ6/FfwDmNO+ooXx74yNOTThhPkFKf+FdVW5ZqjLjQEM2OgAANcBas6jBY+T5blQr26doP76fmix3d2BalgiEg5nhRGb0BCqOTirCTSVha7wbE14E/u/teeid3DaxFiTcRiSt8gX0ZE4WeBBlMlDBjoFBD9w5Zp1V6KWH3I8n39Zj57I9qVFFiIcyTRyra3gxcNIQI1fc84EPlavmhaK15ZG6E2N/p6him2ZdQtqS0JPloBR6aZgFGDgdNT7tiIumnObsVtvBpgPvrt2kQY/AV9fePwaTPb/Y4jfMhca2DdjXESv3nLnD/b/vOF7g7gLb/U8/3b7e5a0lCznsJ+fU1A16zhzPhswZtwOuVJt/mD3jv14lM+VpcNK/LGmEpwfB7Sps36c=
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(136003)(376002)(396003)(451199021)(36840700001)(40470700004)(46966006)(966005)(356005)(478600001)(26005)(7636003)(54906003)(70586007)(70206006)(4326008)(316002)(6916009)(8936002)(8676002)(41300700001)(186003)(82740400003)(7416002)(5660300002)(47076005)(336012)(2906002)(426003)(31686004)(31696002)(86362001)(36860700001)(82310400005)(40460700003)(40480700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2023 12:08:37.6641
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aeaa2347-aac4-4646-c541-08db7962bc73
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT057.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8756
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

On Fri, 30 Jun 2023 09:33:36 +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.3.11 release.
> There are 32 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 02 Jul 2023 07:21:08 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.3.11-rc4.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.3.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

All tests passing for Tegra ...

Test results for stable-v6.3:
    11 builds:	11 pass, 0 fail
    28 boots:	28 pass, 0 fail
    130 tests:	130 pass, 0 fail

Linux version:	6.3.11-rc4-g45e606c9f23d
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
