Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84045658A11
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 08:44:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233049AbiL2HoE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 02:44:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233055AbiL2Hn4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 02:43:56 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2088.outbound.protection.outlook.com [40.107.92.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FD4813CDA;
        Wed, 28 Dec 2022 23:43:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N1zxid3Ep0etv43d3w8KQZU80qRMJ5EnoYk6PjK/Pu2zl2NTHy9ygYzDwYbx6IA+PUHeyRgnd7lf8vmm4/USb7buKyot8CS9HVSiB8vY559j5s4i+2IKSn/t6nKUY9AaLgWGsvWqtk+IUIMYs+i6+TVZKIMes1MXiMlq99VE49kGOfRk7PKPNpY79wqdS4eW6sQgVk9A+LOa7oTkqCgF7toDmofOdqLdqAZ6rHBm3HWPhhCdZDw/uRTDNC8E6+OQrNB7piUCIldFBi5isYkqfl6AtW8M49B0UUZtNTKTOK2NTx7nUZv2Gx3LAUMpYcMkCQZT8XfkLbgVW8+XqXZu1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e3CbsPL87SyxkevnyZw0QBoY2ny9iwqqDFXcnDc8SGw=;
 b=EMt//j+KVx+9+5KcERI8KToLHLqMnqhBaWEQ1E+C6SPXDO/1vYKGjtUTgamORrJo2T28sZQlTWR7XEwLg6+1xh0uJ11uhvDiPYiahFUQ50hMewqgTm8kc6FVVwz7U4bAObx41IktRzVyIlOPNjHyRiTARhsQjcU1ODhDpl10RdID7qpNrM4n6QyN8tTYe5GwizSB13nlJGEfeOLz8oNd/gxEHwqFpMPq7LPF/ijfD+dk36dsgnWtf/hvPtPqqAcu01dJrWL7ReFgIjFocE16+QjY1v7c23Kerf1uLsQ/jK6goO3O5d6RikWTk/OJ0S+oAMOchEWsfMnhdztW//cuDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e3CbsPL87SyxkevnyZw0QBoY2ny9iwqqDFXcnDc8SGw=;
 b=qMgz1IYgiXM02tC0JFRdipSvYB11LgyWz04AnLc7e00XjOjmrPSr+x4edHWq1kuxOLgAloOWF5osfxP9Ew5+50x2/IX3toSgMQz/Sthlh/cgl8S+B8E8NKaSkA7Gsr+gJvMPz/S9eW1OtSNWqmGmF23H2/n3IIB48cuoYL/cbO1mDs2jDWewLnhAEIpnxBii/XuNUGNumK1g9OdQa3NwqFfZw3U9lerk2SNe+7tk8S61ukq886iLYxkxCXembO5+DBBP8bklADIt2iBVIO5JX8rCQfwwJqYDGETLf5qNccBNTCy3bImntFmgDFo2JB8MzrvZ24M2iAkRl5bDLQ1jTg==
Received: from DM6PR01CA0028.prod.exchangelabs.com (2603:10b6:5:296::33) by
 SA0PR12MB4383.namprd12.prod.outlook.com (2603:10b6:806:94::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5944.16; Thu, 29 Dec 2022 07:43:54 +0000
Received: from DM6NAM11FT112.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:296:cafe::57) by DM6PR01CA0028.outlook.office365.com
 (2603:10b6:5:296::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.14 via Frontend
 Transport; Thu, 29 Dec 2022 07:43:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DM6NAM11FT112.mail.protection.outlook.com (10.13.173.77) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5966.18 via Frontend Transport; Thu, 29 Dec 2022 07:43:53 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Wed, 28 Dec
 2022 23:43:44 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Wed, 28 Dec
 2022 23:43:43 -0800
Received: from orome.fritz.box (10.127.8.9) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36 via Frontend
 Transport; Wed, 28 Dec 2022 23:43:40 -0800
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
Subject: Re: [PATCH 5.15 000/731] 5.15.86-rc1 review
In-Reply-To: <20221228144256.536395940@linuxfoundation.org>
References: <20221228144256.536395940@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Message-ID: <f6031584-f46d-4af6-ae12-5fd8966a15be@rnnvmail204.nvidia.com>
Date:   Wed, 28 Dec 2022 23:43:40 -0800
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT112:EE_|SA0PR12MB4383:EE_
X-MS-Office365-Filtering-Correlation-Id: e4ce593d-8016-42c8-fdab-08dae9706eef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NNscPI15cKZ789/3/F8F5LwEE6zQx/bgPdpgeVsGXjbn+CVpqRKrGu8rmODRan17CgWxftWArcreTQe8SSuatuvJmWV1zvGKN0WYdMy2aCWuzHqcz1uPzJ+dz4Isu+VxconvNALMlx6BKXHEClwEL/w+T0klbDjbl3E+dfDpDEzIPiVk2DiKZ3i3n7vUIeUkbv3jCabo3xSDfFaffkckhnWnqnJB3uHmAn6onZRYVNA73tMNDcWXKrTQ8iZaWGE32StlOdwRvkQOp5pyK/Gi7GCowdyWI7ZRNtzT6CI5qwSAfZBs5kWVEa0icuW+64xArmn007f6u51iU8wji/8suyiY8p+/XYEaYSMqiYcfDjG1NxEZvVoi7VBCfpizfwbU9BAWU5k+QK5BkvH3nOWQg/YagTg/piQSpK7vDv2W09gJ7pV1MWYOKXqdewK2G4dUaQsGBD64u+g98M379oV3Qk6pSZNJqlfS9C3iYsTk5HfYDNeO3NmNFo+5xnFDPu0QXz60GDbIPSMKcQtbn+7rtpbFOSguNPTN3vg3OjByBHqQOToIcqcM5pdiyO9fKfJ9yzGqx7WvVQQHwnba3xVYPKUiv8Ll+0WD1HohMRpOOVgeVdY8WVl3wNXLrvWXpIU3wFvSxPjcNtiF4cSO9mO3PBy5WYhFueaL8ceP7bK2VWuSVDlODUxygrf5GCUlTzLwpUPbQg4caHV1e6A/sj4BxnCTZW2SERvhosMEIcC40YHIps5tD8nyr721lWsPeJhPNNI1BSH5FwN9GPv8C+X/XdcLQst6FOBUR6DIs2quRh8=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(346002)(39860400002)(136003)(396003)(376002)(451199015)(40470700004)(36840700001)(46966006)(82310400005)(31686004)(41300700001)(40480700001)(7416002)(8936002)(5660300002)(70206006)(70586007)(4326008)(8676002)(31696002)(2906002)(86362001)(54906003)(6916009)(336012)(356005)(316002)(7636003)(36860700001)(82740400003)(966005)(478600001)(426003)(47076005)(40460700003)(186003)(26005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Dec 2022 07:43:53.1768
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e4ce593d-8016-42c8-fdab-08dae9706eef
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT112.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4383
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Dec 2022 15:31:47 +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.86 release.
> There are 731 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>=20
> Responses should be made by Fri, 30 Dec 2022 14:41:39 +0000.
> Anything received after that time might be too late.
>=20
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.86-r=
c1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git l=
inux-5.15.y
> and the diffstat can be found below.
>=20
> thanks,
>=20
> greg k-h

All tests passing for Tegra ...

Test results for stable-v5.15:
    11 builds:	11 pass, 0 fail
    28 boots:	28 pass, 0 fail
    114 tests:	114 pass, 0 fail

Linux version:	5.15.86-rc1-g87d5d5cae7d9
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Thierry Reding <treding@nvidia.com>

