Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DB2C7159D2
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 11:20:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230371AbjE3JT7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 05:19:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230337AbjE3JTb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 05:19:31 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2085.outbound.protection.outlook.com [40.107.243.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0D74129;
        Tue, 30 May 2023 02:19:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=md86a5lX5r0Zlo5e8/n+Y/QOIw1Pgu35TCkMa1upKAumrNF9k5Vu+MsEBpFlV4IR8iddgjuIqIKIXPOIKCmM+UgjeRT3ovaDBNdQJA+LYdm+e+53CKwb8LUWjzIiYY3FMa12AOBaqzaR0I54yD9PioXYFjv9SHhZALwVjzRM3RFZnjEz7ygJOVbc0qObiU2HBXyQUfDc4ri/kdMP/SNecHocGYzJp8+XfVOZ94y28rV1rglN9Yuh4cQuesxKuJWgPG1kfQNgFVF8lJnIx+cmYtjKAsDaYbD+ekUkn32zyLql3ruPu0nKDz6bJw7iW9Zk2/C7YmSawJaxMF5I2v7cXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J8iol3Oiu8U/EZqlXVAgO/QnolSPxM3o6e8B2DqHSxo=;
 b=ikX2qhrWSFab1RUp/Fpysjtr9Tuc2WAhd+ZZ+esWqitCb0OWBdvEoSsS6sjixyJPnsg4yPGU+ef3Tvr20Ozke+/pZN7lccoSC+/4qExXg9+BBmErtSGjTVqXEWYx7Lgpub5uJyMNuvx348aEuOpL4ZKLDHh5AQC92XgaQ9z5IfX8Q5Dx7KpB5W6LU8e3aL/U8PKZetolTL44yUapfoeg/7WEYsSfc9NUoeHpQsMIyqyXdGM34Fvzzyhz/dYXKpsBeAPfA/ca/Nje8Dfe39RsHMePXijbpy46ktq4A+QWUJ4rQ/jwZbPNPempge1+uyOW0hSER8EbuRN1EcPtX4OjBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J8iol3Oiu8U/EZqlXVAgO/QnolSPxM3o6e8B2DqHSxo=;
 b=cJgNbVSzYLDXnGEDcDjK+zi5T4JNtrdHehy5u5xn1BHvjtCpcKK4TqW3qaKUjnmEswmtVQp4bGxLnkW8KgR2WdQ5JKBaOXGpMOE3mYMYcTMEi+86xX9ISH5lHUvmP2UHx8CRV/gR6j/6KcJKtzKPC3oajzxrDh95vj8Wy8NwHZ8yNp/8m5iTXwy+UM3958cu76w1MIqTGvbSfvUXsPm3zUB3Xg4YR0k6WaBK9vNXM+EZIjU/ngmakBn+Xzi9RMyRdAMnW3J9s6mDhksm65Mn4dP4wGEiQV54VuLpfd/GgrtiiVUvCISeB1Z8E+GpEkEHrrsTG5g6yl9pzBFwGSM31Q==
Received: from DM6PR06CA0075.namprd06.prod.outlook.com (2603:10b6:5:336::8) by
 DS0PR12MB8199.namprd12.prod.outlook.com (2603:10b6:8:de::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6433.23; Tue, 30 May 2023 09:19:24 +0000
Received: from DM6NAM11FT081.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:336:cafe::f4) by DM6PR06CA0075.outlook.office365.com
 (2603:10b6:5:336::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23 via Frontend
 Transport; Tue, 30 May 2023 09:19:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DM6NAM11FT081.mail.protection.outlook.com (10.13.172.136) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.22 via Frontend Transport; Tue, 30 May 2023 09:19:24 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Tue, 30 May 2023
 02:19:07 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Tue, 30 May 2023 02:19:07 -0700
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Tue, 30 May 2023 02:19:07 -0700
From:   Jon Hunter <jonathanh@nvidia.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <patches@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        <torvalds@linux-foundation.org>, <akpm@linux-foundation.org>,
        <linux@roeck-us.net>, <shuah@kernel.org>, <patches@kernelci.org>,
        <lkft-triage@lists.linaro.org>, <pavel@denx.de>,
        <jonathanh@nvidia.com>, <f.fainelli@gmail.com>,
        <sudipm.mukherjee@gmail.com>, <srw@sladewatkins.net>,
        <rwarsow@gmx.de>, <linux-tegra@vger.kernel.org>,
        <stable@vger.kernel.org>
Subject: Re: [PATCH 6.1 000/119] 6.1.31-rc1 review
In-Reply-To: <20230528190835.386670951@linuxfoundation.org>
References: <20230528190835.386670951@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <b28f548b-911d-49b1-80ad-5d7462237ecb@drhqmail202.nvidia.com>
Date:   Tue, 30 May 2023 02:19:07 -0700
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT081:EE_|DS0PR12MB8199:EE_
X-MS-Office365-Filtering-Correlation-Id: f9f4a344-690c-4798-5bfe-08db60eef5d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 22TGPtO7Cf6ocgo1lfb11XQN5VA7UGGJIVy3djJr7czAYdDLwzObrgC4D319dLIUCnBXHNUwHTy10bsT5xagn0zPRj2rjBOVluGcIUsPfeYs3b53sOhFxyopavW0qWYiNDA1zF/PjA0ltmFlbttxRI22Q/NftCNMBYPjTtUC0KsX3WpgIU4TiMojfWbeXRKB/JBMs7o8TL4cEmYshw3yHIEcBnxqofy3QwF3euXkVATGHx1wkM/NS8lvaoEugzdu8PcCiJYegv2N5gSl83aMAWcZOdMYWhwkN2BAbNB1hEU4YfI/GinMM+O4FcUAMMdXmXHja3YM873rzHQJqy3pBRdrrF8luy3lVC3l5TS0rfbYY2wnrT2zJo2TARvfDWOLjOCuv1PxhPAAKUROQqMPt/bb1hDXT+zVBSFnCEd/rvrr26ySm1hAtYnB+v9Wz5dx8gWQvPSm9VI2gEIZbdM5hJ8w0m7qw8Tj9l0BDzlEamGofNdawzgki25TefKKqTVPmjWEKYyNsGl9yHC56S7YLrWHEBCzJUwaUxLbr+Z9QFPWnnAzKdrW7+OW2bTTuqWgvz2ByNYjfcb3x2zVPJy7n0847kuADfqLDPe1jC9fgzaA0J8sf4EFadWokJcJ/J8lO0pNgk9l4wAiVtuVbX7JFfGHR5+aV/DqpVAcKRYp13rL1D843G2AIoPL0ITLrbeRQVTX/JMTq9tzoLLN3jgOoHbQX3pwU8tEZF1JS6EMdEDq32yuIvnXbx0DP9wN4NcsAnE2rXmg2ZdD27oPGeX2sCx5bLz85wpmvT21FKPsuGM=
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(346002)(136003)(396003)(451199021)(36840700001)(46966006)(40470700004)(86362001)(31696002)(54906003)(4326008)(6916009)(70586007)(70206006)(966005)(478600001)(316002)(40480700001)(82310400005)(8936002)(8676002)(5660300002)(41300700001)(2906002)(7416002)(82740400003)(356005)(7636003)(426003)(336012)(26005)(186003)(36860700001)(47076005)(40460700003)(31686004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2023 09:19:24.4050
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f9f4a344-690c-4798-5bfe-08db60eef5d0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT081.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8199
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 28 May 2023 20:10:00 +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.31 release.
> There are 119 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Tue, 30 May 2023 19:08:13 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.31-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

All tests passing for Tegra ...

Test results for stable-v6.1:
    11 builds:	11 pass, 0 fail
    28 boots:	28 pass, 0 fail
    130 tests:	130 pass, 0 fail

Linux version:	6.1.31-rc1-g8482df0ff7e7
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
