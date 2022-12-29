Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF9ED658A07
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 08:39:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232973AbiL2Hji (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 02:39:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233073AbiL2Hj1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 02:39:27 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2049.outbound.protection.outlook.com [40.107.93.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AD3DBCA0;
        Wed, 28 Dec 2022 23:39:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E5LpDvK/4PHiX9ds/72mQsgvRmwBSpS3U28N/8UXYAD+CKwuYaTQRo33qO853SVv3Dip72gB9vJD62PgeM4NEl73qAW2ZYN/Q3oJoaGYM1JkVZ5j1f93SyuPgZl03jATaT/MJpd2LKyS0hQ4iGJbiRaH+6UTK+IU4Lbd2DWKonut+wcKFP9r4HlUyADgkpm4nm99OdLdXv8KG9elC0KNwRxL4FOfb49EitDBFYv5ye8efuDM6ab0QQWhSN+sbON2RjSSzPZ8PC2XZc6I0xUvAYApolQlGQKfrxr1bsFxnOpkNG96D332Jhzg+2sewEusiR1QdkX5K+h5gf2Q41qg1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ISla2KzwdGKbx40zDdCH6Ug7J2rnuC25J7ztpXKAKGQ=;
 b=FRxlSv5WATkheeORogsgcM7FV6f68GCmRdOJQ98EoMOzK5hGX/qbl99atKXU6eOzd1c39PqPkPVY9eWuIuj7IZSwDFC2lQsSJW6yfzpztEGN0F09Q4qBCLLjjBsyv8aiTyfgIHlX5oeZX+zqLhO+I9cfczxmBC+PXYyXtvkMrGsyg3tbYcd3HMuO5r/UXTbq14ZT9cnkTcn2MyUjSOAZmr2rk2rXBLxC4+4qAYT5U9t1BJK28Ws3xw2p35uGjdepoc6g0EHesDv3+sy52VpN3oseoEoot740Er9R3gXMaQ2YnIytYvnXVua2rXJNzXew4C4IGE7z19kGwNx5rsnmSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ISla2KzwdGKbx40zDdCH6Ug7J2rnuC25J7ztpXKAKGQ=;
 b=EemYFvFnV2jfs/JhAVHdYFZIaUWgxhs7r77FvBN+0S9qnQSq/HwHisKHLgOn/MERhkzt+YC/dKt3co7+3dbA9v6WguYvvMVY+w96vopOuvZvZLAbm95HTGGT9Ii0M460mpaF/4F8xzZc7ojzgqz0nYkcrQL1dmOti2Xq8euhRD9f72bLI7TmrD0Zhw0cNt6C7SHozzJrDsOaYe6Pek5rG21oNceFZ+MEvHrdDx8RXjSZ/J+yuwXVm17b2+70sruy3CISxfw/Eh6rKYbIfWOlu96zqDmMPkETebN0etUo92DcjQs2G/P4cXUOtH5HQCt087IW1Ki3A1un7RyJLW4s4g==
Received: from DM6PR08CA0065.namprd08.prod.outlook.com (2603:10b6:5:1e0::39)
 by PH0PR12MB8029.namprd12.prod.outlook.com (2603:10b6:510:26c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.13; Thu, 29 Dec
 2022 07:39:25 +0000
Received: from DM6NAM11FT105.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1e0:cafe::a) by DM6PR08CA0065.outlook.office365.com
 (2603:10b6:5:1e0::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5966.17 via Frontend
 Transport; Thu, 29 Dec 2022 07:39:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DM6NAM11FT105.mail.protection.outlook.com (10.13.173.164) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5966.18 via Frontend Transport; Thu, 29 Dec 2022 07:39:24 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Wed, 28 Dec
 2022 23:39:13 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Wed, 28 Dec
 2022 23:39:13 -0800
Received: from orome.fritz.box (10.127.8.9) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36 via Frontend
 Transport; Wed, 28 Dec 2022 23:39:09 -0800
From:   Thierry Reding <treding@nvidia.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <patches@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        <torvalds@linux-foundation.org>, <akpm@linux-foundation.org>,
        <linux@roeck-us.net>, <shuah@kernel.org>, <patches@kernelci.org>,
        <lkft-triage@lists.linaro.org>, <pavel@denx.de>,
        <jonathanh@nvidia.com>, <f.fainelli@gmail.com>,
        <sudipm.mukherjee@gmail.com>, <srw@sladewatkins.net>,
        <rwarsow@gmx.de>, <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH 6.0 0000/1073] 6.0.16-rc1 review
In-Reply-To: <20221228144328.162723588@linuxfoundation.org>
References: <20221228144328.162723588@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Message-ID: <cd6ac4a3-a2cc-4dc0-9bc1-762722f8a6b9@rnnvmail205.nvidia.com>
Date:   Wed, 28 Dec 2022 23:39:09 -0800
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT105:EE_|PH0PR12MB8029:EE_
X-MS-Office365-Filtering-Correlation-Id: fe6ce46a-3b83-4ae1-0b53-08dae96fcf16
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: v5G37g9dEPPhfwv33WHh6YleUSoNqidfae52QgeUOctR951ZTpeDQVXUkeOUqrEa/DgNTntK0cGyvdn33t6FFtn18YhddlJWQsuFZZorby/zpNQN+Nm0thwKl/DKJtxyANJZ5IlE8Y2oqmMToldOCd6SIOIqPDV1r9t8ngqTA1KbOmiBWCwnDSgI7VnKpFEHjQwcvYerX8WrwAPh7iFlIE433iZdgWuSy3e+1S3NqFAPHyn5fZWMhPqwmwL81l6lQ0rONqtS3m2NfxAWEdg4Pi/9FXSibaYzAKWjjrMfmNb2dBeCb5X5B+5gBsBwWNDwI5116miCGxN2FMoHsie29zAY5QKx2EoPmhrcYFgDeN8uLof82HslM6UKbZKg2B4EJUehDUeVDwsyTkXa1HHMXJ+yyk9+yET5p601WYdvUZcQzgyjWKguaTIkiGEmDERurMYvXys7GCvnvanPu9GiIb+SoaqENNJ50mo0Zloh5sGZwp1q7yVaYBqI/tX+T+TVMBeL1R7f6YWmBlaUB+CIKKg6Pr796J+TVN+Fctc5IoXbU7dVaCkJkWc0fS3/NB/E7TlyRsD2n0MULVtVJWbIWuvrHauEfPeQOxniZsk70ip72sdzUUB6OgC8ti/YPZqpRpza1H0tj5VrXyIBWUzepVh3MQs/yuMpT1fq/Yhd4iqC89/WFCrSc498USelSnyCGN0U4XGhOoo8Jk+f/ELHp//x5eYY6uOsNPF3IMGUigBdt7ktTIrk13LHFyh3UxIGQRXe2fu3G1csAPNrTG554BGkuTcBdbyEmQuaIuW8z90=
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(396003)(346002)(39860400002)(451199015)(40470700004)(36840700001)(46966006)(2906002)(31686004)(26005)(5660300002)(7416002)(8936002)(316002)(41300700001)(70206006)(70586007)(4326008)(8676002)(478600001)(7636003)(356005)(82740400003)(54906003)(186003)(966005)(82310400005)(6916009)(426003)(47076005)(86362001)(36860700001)(31696002)(40460700003)(40480700001)(336012);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Dec 2022 07:39:24.9754
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fe6ce46a-3b83-4ae1-0b53-08dae96fcf16
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT105.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8029
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Dec 2022 15:26:28 +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.0.16 release.
> There are 1073 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>=20
> Responses should be made by Fri, 30 Dec 2022 14:41:34 +0000.
> Anything received after that time might be too late.
>=20
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.0.16-rc=
1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git l=
inux-6.0.y
> and the diffstat can be found below.
>=20
> thanks,
>=20
> greg k-h

All tests passing for Tegra ...

Test results for stable-v6.0:
    11 builds:	11 pass, 0 fail
    28 boots:	28 pass, 0 fail
    130 tests:	130 pass, 0 fail

Linux version:	6.0.16-rc1-ga1ecccf7f610
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Thierry Reding <treding@nvidia.com>

