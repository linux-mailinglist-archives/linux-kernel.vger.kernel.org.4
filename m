Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B11C0658A16
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 08:47:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232910AbiL2Hri (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 02:47:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbiL2Hrf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 02:47:35 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2047.outbound.protection.outlook.com [40.107.94.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BDAB187;
        Wed, 28 Dec 2022 23:47:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V8srLhGkKEujRZsxtciMeX/7glTgPn6++cJ2LHOkaaEC2RvjZGAv8vbaydVKpoCuBhzKVWofcYGi5nXK45kM8jCHRvVY0TI3iqVkC7toLpHllRuAX5KVCWsI1dN+ycJlX1aOihAtLo7g7GgPxY/GD+7NagUr3+P0iOE5DQQGXHKXsnxUxnghG3kvr18wEHmOKoUJcHDeuAORO9gvyCy7AweY+6FqW6zkVljVJMSocYQe3EcMYQZCJDIfCz3Tii0p0av6kjBjZA2iA5XB6io2B9iQrH5kUOBq/CJa78ett7Y4rNSTq9JaJz+auPD64ZSaCUbxCbmQHrBKTSj9dlLGYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MzSPhROzUl8JI5NMMwjpHgrOEfBUcnNZul3tPmPSeGc=;
 b=UTcyHX2y/JuAyot9qOWcp/5/RGrv1dZvWZ9ZQ0hkS6W9YFoCog8zbnkpy6QHodxOO5KVzRpyQ5EUT5QQtQxQXUlMhDn0HXtP0ufZvMGFpYW5yHAlH8ZASWtKoxz1tSJMpcXKwwic9c9Lrc/Yd6ncafkKMkKX41789zpBcEWE9RsxpCo0f67snQlXTqK5lc0DgZ0PrqfI0SfRmb4JJUN+caLYMkEk7pvZWrK/EF7KeAJrUW935j4GI9viAtDCMNpzLH36cKOICJBLAM6/vBHx9vapwW8pUFPdy4nIGmCdY7byJPxXJXwpCV3Axb00/EirDwM+qSP4HIIuxhJ5P2cpyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MzSPhROzUl8JI5NMMwjpHgrOEfBUcnNZul3tPmPSeGc=;
 b=rFyOnibPa/i1iUsNhY+WYAgaO/9zlwgQEkVDuTpeFjFNVwHYixdXLgos1hRxNWbo301QuJngTax78SHG3YJ1XahHQaH8T2X7WzMxjeewEO3Dd0OBFAjv2ujY9PABYoV1xEddmssmAJj8xIwxLILvb34aNyyjhwU9xeI2Xp79ZkoIoNoz6fNSHTvKYpN+8lZqvAJVvbZHA/cy/HiJ14VPDIGZpXnpD4yf2NI/pD3ivj/A0Fgn2+Det62aJtzFWB+Be1lFks+cwWWQYPCaDz0lbh436DfNejjHTT3LchukjNmdVTDjephODDNwpbQJ3RJBAWpl3IqFX4wpfu+u+UZNSQ==
Received: from MW4P220CA0025.NAMP220.PROD.OUTLOOK.COM (2603:10b6:303:115::30)
 by DS7PR12MB8251.namprd12.prod.outlook.com (2603:10b6:8:e3::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5944.16; Thu, 29 Dec 2022 07:47:32 +0000
Received: from CO1NAM11FT036.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:115:cafe::6a) by MW4P220CA0025.outlook.office365.com
 (2603:10b6:303:115::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.17 via Frontend
 Transport; Thu, 29 Dec 2022 07:47:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CO1NAM11FT036.mail.protection.outlook.com (10.13.174.124) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5966.17 via Frontend Transport; Thu, 29 Dec 2022 07:47:32 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Wed, 28 Dec
 2022 23:47:22 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Wed, 28 Dec 2022 23:47:22 -0800
Received: from orome.fritz.box (10.127.8.9) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36 via Frontend
 Transport; Wed, 28 Dec 2022 23:47:19 -0800
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
Message-ID: <3a1390de-c750-46f9-9226-4ea3768f5524@drhqmail201.nvidia.com>
Date:   Wed, 28 Dec 2022 23:47:19 -0800
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT036:EE_|DS7PR12MB8251:EE_
X-MS-Office365-Filtering-Correlation-Id: 88dd5b62-424d-430c-7c85-08dae970f19c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fVg3VQBYox7zSyLjhQJzIiKXwEPqtqikeV3BY+Lcwo70N1A4eFpqVioKRLqBf2p4/9r5ZM+9GNe2K6T2OOOopiIVm21UiaYmoNfXaU9af3IKWfVwDc6xqxTsQvrfFbgxRFKtQJm/chD9xsmNmtyJS6FqTqlbPfFYk5JDIKzbKhgSQ1ccJHfo2c4fPoZh9Pv8rDkGEDuqrTbS4QkbyySvXoPJfT/tyNdVDFbvQxVV0z50cgQpbkS1EW2s17evzTPnHB7OHvPurabgvWvl5/agKTwR5E5w/wMemSlJ443XcHlO5o000BBvKyAJmrFiV29MTiRgRV+0nnpdHjgQ5YLV+gT1EvFUTrWGLjurbKSrFD01+5gHItXXVDapJovb2iCPsZ6R5gCyFPnOnHfg8t/YF5LuwyvAxQmRgsEt1VnswMYv+Tl4ncgc4YDJaM4NRgstWgqnWtsVMoQbh49z7JO2UYh5Gq6DqFLQvouKneOa2MA+pXKyjaLpFn0s9zHjPuDpr60k6GUYJvAYi6fpVaBYThg3hpazziGyhCEq0e1FOiGr1+reRJ+hAJJS1ObNT6KP26O2h8dAWc1jC7RcQOHTlLc+sXa8rNhTAGnb2KuYEa2VoylJMhgcGVQL9LQMDMqiSk3LTtm8kGibZ6vSPxb9L0Uu6Fn4nQb7rlTE/0iW5FhoJ2t814WBLU54/XNl1QpHa0cm/GQAJBjUAfUkKoFcce682Dqk4Cb1UB/BERO6qMZyyA6eme5RPGVKy3NpsdlcOZqPNDtX3ARG8RyoBcHVVXfrxITFAGvpV5PVZImdQg4=
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(136003)(346002)(39860400002)(376002)(396003)(451199015)(40470700004)(46966006)(36840700001)(336012)(966005)(426003)(478600001)(356005)(26005)(82310400005)(40480700001)(47076005)(86362001)(31696002)(36860700001)(40460700003)(5660300002)(7636003)(31686004)(186003)(82740400003)(8936002)(7416002)(2906002)(54906003)(6916009)(316002)(4326008)(8676002)(70206006)(41300700001)(70586007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Dec 2022 07:47:32.4582
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 88dd5b62-424d-430c-7c85-08dae970f19c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT036.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8251
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
    116 tests:	116 pass, 0 fail

Linux version:	6.0.16-rc1-g4c258f770fed
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Thierry Reding <treding@nvidia.com>

