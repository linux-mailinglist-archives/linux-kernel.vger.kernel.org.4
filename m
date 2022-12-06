Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 438246449AD
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 17:47:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234861AbiLFQr3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 11:47:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235591AbiLFQrD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 11:47:03 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2061.outbound.protection.outlook.com [40.107.94.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 783CEDBA;
        Tue,  6 Dec 2022 08:47:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DhH8ajmk+nRmGjr5lTDGIFOA0FQNyos+05cjN81Jq5sFJtjgr1SWXb2J2NibUKyVrOwuIh8lwWAqrE6rm0vCkbgUdZLK2WHiTEBmHyESXJpEoPvM43+/mHlpgLoaS9Q3EdeExprlM3e/Nqo4A9il4Tw3crN5bJDBqVEK9aisU+FvRZ1mc9Wl18e+J0Raom4nDXkqPDUwlu+f2Yj0P6x2ErvTN7gqDYScLX78KQVTDhbs1v8f/3azvrkoqJGDxvlw09H7l8j7+I/GGNNQWQFMrYr7SOylLmk/+R3iP0INhv5KeFCVqIlif2Hs/Qdzsa9x8ao80W214h7L6sBrCfKxEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zb7c7ROXZ3KX6owu0tGuIOr/ocDw+zmrRBGD0P0lYao=;
 b=MvJ3iASTQLdkW1txMcmwANDJ0rhBkS/o6wENTjNCcx1DgmxZbXSAK/HKI9uB/Gsl5NDm96ONR7fz5CwF1DioP+o+sAFKnfLaJUVQQXbRAwSdHYDj2zqhS0H5uWzpWFSR1UXZGSgkm2iHUw8uE/SQuQI0IUYVuwsNawmsA++6iJQuEwr8AjHh83S9xtqX/wrSMhfSLph8RZNP6QwznLnHWDzbUQd7BxKfDRDKpS7ub6MYu97Kb7wq3CPbxrMstM7SuKXJ+Qqmr+CxdxrFI3M9o0ftXo+zzL0Kbhq/gfoq2MlMXev4RsGmAtpdoMnbB4R6r1iExiv9U35eEzlfma7tGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zb7c7ROXZ3KX6owu0tGuIOr/ocDw+zmrRBGD0P0lYao=;
 b=skmx7Tibucl5mWdjsRE4oUMB0/K8aPqH30H2pA8haI3QwR3nRhEIDwJxCC622TYIlWxgG1G+a+gusvqr6GUyutqjt7PSxPexaXCOhekd6E1kjvJmLwyc3rZaHk0R9S5B9FW0+yRtvb8XmGOj44v5zoGDKQic+ae9FzapRcnTEWIauFaamFnG2aK+9yeZYyi2e6V+BPXwgTnC9s+z7VXjkaH+hdnmX8Y5CYWvnmDvgou+qmom+1ABkcdGTV5G2wFKskwRIw9tTpYZHFyl7ZISQrv5cxK6pFDMMJ7yGAKVDIPoOG1zpT3hW4SKMo5cm6hJ7lOh/miwTqb5YIVyfHhS2Q==
Received: from BN9PR03CA0216.namprd03.prod.outlook.com (2603:10b6:408:f8::11)
 by IA1PR12MB7760.namprd12.prod.outlook.com (2603:10b6:208:422::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.13; Tue, 6 Dec
 2022 16:47:00 +0000
Received: from BN8NAM11FT052.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f8:cafe::fb) by BN9PR03CA0216.outlook.office365.com
 (2603:10b6:408:f8::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14 via Frontend
 Transport; Tue, 6 Dec 2022 16:46:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN8NAM11FT052.mail.protection.outlook.com (10.13.177.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5901.14 via Frontend Transport; Tue, 6 Dec 2022 16:46:59 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 6 Dec 2022
 08:46:45 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 6 Dec 2022
 08:46:45 -0800
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36 via Frontend
 Transport; Tue, 6 Dec 2022 08:46:45 -0800
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
Subject: Re: [PATCH 5.10 00/96] 5.10.158-rc2 review
In-Reply-To: <20221206124048.850573317@linuxfoundation.org>
References: <20221206124048.850573317@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <57507474-d654-4518-882c-3717f8f4e954@rnnvmail205.nvidia.com>
Date:   Tue, 6 Dec 2022 08:46:45 -0800
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT052:EE_|IA1PR12MB7760:EE_
X-MS-Office365-Filtering-Correlation-Id: c64906a0-5661-43ab-445e-08dad7a97e35
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: frCL3QKOjqVH91tb4Cvp/FidgxzEfMkplBTr0WhQu9MDI/sfgM/OYYmkIfGeDB/SR7109Pz3ZrDaYoH5K+3GqdzAzmvwQgp0ZWXrxs8qqBihIMifg0Sunu+HYzSKiyh+1GSEbcBEp1fnyB2gNnqL0DYlkLSIi1pWgIstVGnQxo4PpXsiOYagPKsK31/l6n7OVwOIS1yacQee+OG+3P50RivjZfUdykg8QrHFDpRgGsZWj1o5HMPOIXSUeefUDJOOSsQghRDK0rOnUMTI3m53vJXk5Aw05vHTQW/ocNCOTaAFY5LJ5F4Sdahskxsaz7QzRmBnx5OxyvDgJodt0akRINx2dA3SwJzxjJC0Jats1SYRxWuOiwnRvVowdBt1gTdEM/px0f3WNQ/dkHI6B7HIgMnan+UKRiwMdMZpiSzHtjtQzSb2nY9rPbWWw8hQGAWZNaSSYLuNuFyasAKmCqQuGaL2Ah68Qtn/FHYXkzu+Uv+in/NVerQvksn87ejg09OBd1NEGZQKALDRgAW1SlpFMHVZJ3WXFfukl7lW6AGoWsjgoJWdIJNLWRn9n6fcngJpPEqK5TmoZOXh5VNYKoOIa+zNTURmfVp5kdWUsFCHee5Rseil2NZu9mPgCRdivELtyy2pEd6NRqXrSA58Zrzznr14SevEHzOsG37DorbXaUSZO4DOt5DDNhYXfQEAsz6P+3Zlw24Dh/OY/5OoKi1uj9c7z9/1UkLEr2o+bhRuqro0w64gCfojn4GpbZ/v/AgnEvIpFZ35PhElHUlKsTdS0xmuJkhR0HIEM4YUw6X1rYg=
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(346002)(396003)(39860400002)(136003)(376002)(451199015)(40470700004)(36840700001)(46966006)(31686004)(426003)(47076005)(40460700003)(31696002)(86362001)(7636003)(966005)(356005)(478600001)(40480700001)(82740400003)(82310400005)(336012)(36860700001)(186003)(7416002)(8936002)(41300700001)(70586007)(8676002)(4326008)(26005)(70206006)(54906003)(6916009)(2906002)(5660300002)(316002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2022 16:46:59.1180
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c64906a0-5661-43ab-445e-08dad7a97e35
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT052.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7760
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 06 Dec 2022 13:42:33 +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.158 release.
> There are 96 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 08 Dec 2022 12:40:31 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.158-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

All tests passing for Tegra ...

Test results for stable-v5.10:
    11 builds:	11 pass, 0 fail
    28 boots:	28 pass, 0 fail
    75 tests:	75 pass, 0 fail

Linux version:	5.10.158-rc2-g8dca57ec68a7
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
