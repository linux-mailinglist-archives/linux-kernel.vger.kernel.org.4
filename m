Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21FF3628783
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 18:53:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237712AbiKNRwi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 12:52:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237720AbiKNRwQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 12:52:16 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2047.outbound.protection.outlook.com [40.107.243.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E85392611F;
        Mon, 14 Nov 2022 09:52:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RzqE5UqWs+rwPB3YQZKCmgkTmhFHIr0S/KYC49Ct5yIpYMAl8+ocXO8zYJwi4A15n2PtVFhCP6jQL3+8ynDwg3F0/dnZa+87rh1hXnZU7IqkL74TEErvci8Mx1w8xlehWG/zf7tfwLDmltZWygk3SWjJCPBJtJKapHn6vfOvv/ECOKZAyz9HASSof3dbN5m7B+T40ez+XYK5OP14CzEwvyJ0oBO9A+vH6EnTNMecDTqdq+piBcCskDHFOkah9REws7nTxNv0AivnhT4wDxwrYefQ7Fsl7P3oexVsaWI1D6lUN1AIFEQcnqlKcKAypTMxcC2CKgerUqNYw5uZFDSeNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wX9EAr5WGBTYv9iW0x3FWT904oNdx/3aYQ9/Rr5sfo0=;
 b=fmozHD9un9ONkqfBtkRaxD7Rr0iK14Ubv00A32RSAxD45H6hRmWEX1LjN4WvpeSHEjw+eB2RzOojOWDhaf/OBp2Cfy+MDKgQ7wbk1UIH6tP5ZjBFgYyx4kAuD0ll/fe5xyiV7DXd28HMxYnhstxG0yYaDo1mYDKvDXgHljAlDD1HixBVPFnQDGd8VGlheKZaqyGO1rAxcb1Lb4ZO7g6eI8LYp8EeN94QB5uc8OTUqV60tYwgdMK+O/z3oLP8BGHQv+kpe3dyGoE6A0GpJOGlJu+xdrRO2z3rMF96JEz9KcFnuXkL5npiTc0TAmApFrV4rfVLLoKpIQFfLnoB2SHJLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wX9EAr5WGBTYv9iW0x3FWT904oNdx/3aYQ9/Rr5sfo0=;
 b=Z0BSi5k90jv+sKvudLKSbKLdI5RAc5ZRhfVGxJp0CxzW80EEMl/64ZcE87q4o1RljQRA6W70mAs3m2Lz5h1YkerUTYRF0yQh/zmqoLiNFSuu5ZveFt2xPRt0b6HMJOlfwT/MkT7aooOIiO9oYyZAgN5TpHJkf9KS6BHQ9INV6o58MR/r9fMCfcZOgKy++zCkL4TRlEPFvT5sGnROdEt0w5cOsavp4GjBOYaBi12EPJUGOvt029Ger/fWRA7Li2Wb5JrfWhd9GPILvH0HOKmMhDqM62LxO6kKKuKflX/qXnVRZe0ndv7OvmSRCM3u2h75z0BA/0CAuiYDFbCWTSfGFA==
Received: from BN0PR08CA0013.namprd08.prod.outlook.com (2603:10b6:408:142::21)
 by DM4PR12MB6232.namprd12.prod.outlook.com (2603:10b6:8:a5::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5813.17; Mon, 14 Nov 2022 17:52:13 +0000
Received: from BN8NAM11FT049.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:142:cafe::8b) by BN0PR08CA0013.outlook.office365.com
 (2603:10b6:408:142::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17 via Frontend
 Transport; Mon, 14 Nov 2022 17:52:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN8NAM11FT049.mail.protection.outlook.com (10.13.177.157) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5813.12 via Frontend Transport; Mon, 14 Nov 2022 17:52:12 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Mon, 14 Nov
 2022 09:52:07 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Mon, 14 Nov 2022 09:52:07 -0800
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36 via Frontend
 Transport; Mon, 14 Nov 2022 09:52:07 -0800
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
Subject: Re: [PATCH 6.0 000/190] 6.0.9-rc1 review
In-Reply-To: <20221114124458.806324402@linuxfoundation.org>
References: <20221114124458.806324402@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <1f0959de-76fd-4227-85f5-c1e7679838e9@drhqmail203.nvidia.com>
Date:   Mon, 14 Nov 2022 09:52:07 -0800
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT049:EE_|DM4PR12MB6232:EE_
X-MS-Office365-Filtering-Correlation-Id: 687fdb63-8090-4d39-e979-08dac668f5e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kMGjeDzgY5MZ0KmVlEfOoR6QxPHHvvveuqv4Xx7OIT4CqiLfQWB+v8G66z//ydPEpA8k/eNbFjG3EYD6+irrIihm5RZUo4VgSzMEAvEuTwF8m+T+xJysHOC1kdXRTLfBSED4yM4AuYVZpVa2IdEYRnPWXHr3tcG3iJtgTSgvWgri++cp1cA6ErPHELg6O5IKeFtZ1njbVc4eEXjPtD8cpEMt4AuqZhEK5RY02pOLNBKnyOAmSD9OqasaZgMQn8pFEp/0EaJLARjJTiGAk81pAno+SUljfcSrZ10t6IZNCuS9lbVmhuI30B9yIFD9YtVbtKr9mu5hspTWG+J/0n1A4iO902lxt2AqiPT12zu4zAbdVL1nTPVw8/S76emFhp5yTwUvArK4Kv49wYmQ07dkHURa/upchF+SOULk1673GMb4LTC0P2wQKlLUbPXbJsD9uSIUu8lwkCpl8ylYdpiW50+CXGZz/tyWcrvAQsEpsq/fcY21HZNx73VZKsxuHqwDXVhi20iwWvKjP3OEnTMh9AxlQIENP9VdKwS/E+2z4vUVseoDceetlCrxXHYdjjmxHewCd2jjF4EMre5CNcaTDljHeWmX7n2EEoQKw5L3Alv1VvYu9TIDSmd5WYibRqwZnDrlJRPHxlOa07IIe+CGf2OezNorWzxEDpLOVgWdCy0LCvTeiOg5u2W7OcJ8sO7Pyw15V+I1bVQckYTcNrSLnfPt2AXv1pj6ScyHUh7FOH1UZUP7ry8e1DA0jzT3lAf7PoXFQuyi4GwdjH49hGp8pArOsyyRkej2ydJhuPrZDLCkCWadVr4F+lp/d1ld58Oa9fjz87f/t5ME/qk26AO3QdblyREuv1dG2R0slrM4cHY=
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(376002)(396003)(346002)(136003)(39860400002)(451199015)(36840700001)(40470700004)(46966006)(31686004)(82740400003)(478600001)(40480700001)(356005)(7636003)(82310400005)(36860700001)(86362001)(31696002)(2906002)(7416002)(336012)(426003)(47076005)(40460700003)(966005)(4326008)(70586007)(8676002)(70206006)(8936002)(186003)(5660300002)(26005)(41300700001)(6916009)(316002)(54906003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2022 17:52:12.8568
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 687fdb63-8090-4d39-e979-08dac668f5e3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT049.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6232
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Nov 2022 13:43:44 +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.0.9 release.
> There are 190 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 16 Nov 2022 12:44:21 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.0.9-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.0.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

All tests passing for Tegra ...

Test results for stable-v6.0:
    11 builds:	11 pass, 0 fail
    28 boots:	28 pass, 0 fail
    130 tests:	130 pass, 0 fail

Linux version:	6.0.9-rc1-gf8896c3ebbcf
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
