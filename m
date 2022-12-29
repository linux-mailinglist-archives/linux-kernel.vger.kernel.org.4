Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8963B6589FF
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 08:36:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233044AbiL2HgY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 02:36:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229992AbiL2HgV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 02:36:21 -0500
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2081.outbound.protection.outlook.com [40.107.101.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53B5EA46C;
        Wed, 28 Dec 2022 23:36:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NRbKImvxw4kKmLqoG494Zzn0sEemKLsGZPsp/yN03neSXKk/P/iT1uyeleZ4NiK1pffLyZoZ52tpjCNqdq5pDATuuD8HXw8Qv4H7VKrdzU7t7hyWgH60jBqARj6Hp9XRz4YfWH6NeeqBe+DXe7PwKTtxwNPGbfH5QVOKZu9UpqEQ4Te9VD6LeS1CjQ2USjNVEcxDZzPABjTjjulcDwMwp5Ila0flcYYr0Qoccz9uGLXiDdBZ4WIV7jN9PBj86EcR1TDqPfdbxDz04R85uIwnBmOlfi3NeeNpY2Z+XV7iZNbl3R9kKxPSwWqUfwx6wMq6wNHIFsMjfZaB8TLtwD7WUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HShoMvEBtnfqSL+jtkU7x0f8yJWWxyO3v5XYzh7Mr+U=;
 b=hqblRLzrx3B0dAHMNE9XzldYIjBfaVf0antigHs9dsxTL+pT+p4TrC6kg1iEevJFkM/kCUz/JIv0xmcb4qR4AOmPkVmiI9IhiT7Ugvq3F6qwVwwS2+Fp9xQjilYEmOIASVnBm8+UqqtJhFYSnKL/e9ygFsvh0RPOfRhe1wPrfwajsJVWnMQ0k/RGdA6vlXFao8j5rtVsUmu7KdUhs3AO0ShSUaIpVTz4kdKlUfBJn2xk9X6gpY576OC4soBcJ+HuvzQP0g4VjluaQRWw1Xw3Dtoe0wbppEIgMGMWloOGdx8u5zIuAHv4G/2vr3pdgie94vMMULBTxQwuZwalgz4txw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HShoMvEBtnfqSL+jtkU7x0f8yJWWxyO3v5XYzh7Mr+U=;
 b=LFy0ff9QaPsrtPTBJi0Gh348NJl3xjwUwg7JYFtmDK0tcehx6YaBLRfI+qMaZ7vdYmPGHTl8WuNg/Dz984grJ7UyE14FKPU9k9RwOHEVJhm2zA5HyYzCj/zr6aTEPCD47Qb1I+PPs6sJq3SSc7B+EJK2H9EN9aMetFvnGX6wpzLuZQ+RFgJpvoYX4qX9/aYENkVZIpf1RR7eVOhHlS2f5Z38j/xh5O1IqsDcgXkr2L7JQWb97IaFcf+E0NIrnwUHOB0viq4Qvc6AsvwV5iSRSwpL79nVM0jlAYMgT6Ajh3D5y8Y1EXCLuwwdHJEn4RXsG3LU8k0AI++x7dPCCBxv9A==
Received: from MW4P220CA0013.NAMP220.PROD.OUTLOOK.COM (2603:10b6:303:115::18)
 by BL1PR12MB5174.namprd12.prod.outlook.com (2603:10b6:208:31c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.16; Thu, 29 Dec
 2022 07:36:16 +0000
Received: from CO1NAM11FT104.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:115:cafe::4d) by MW4P220CA0013.outlook.office365.com
 (2603:10b6:303:115::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.17 via Frontend
 Transport; Thu, 29 Dec 2022 07:36:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CO1NAM11FT104.mail.protection.outlook.com (10.13.174.220) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5944.17 via Frontend Transport; Thu, 29 Dec 2022 07:36:15 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Wed, 28 Dec
 2022 23:36:04 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Wed, 28 Dec 2022 23:36:04 -0800
Received: from orome.fritz.box (10.127.8.9) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36 via Frontend
 Transport; Wed, 28 Dec 2022 23:36:00 -0800
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
Subject: Re: [PATCH 6.1 00/25] 6.1.1-rc1 review
In-Reply-To: <20221219182943.395169070@linuxfoundation.org>
References: <20221219182943.395169070@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Message-ID: <7906b589-d73d-4b0a-935e-7a15a1bcbe9a@drhqmail201.nvidia.com>
Date:   Wed, 28 Dec 2022 23:36:00 -0800
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT104:EE_|BL1PR12MB5174:EE_
X-MS-Office365-Filtering-Correlation-Id: b3d49088-edca-4069-28c6-08dae96f5e2e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: p7RfBrNg1qX/d5bUWc+kLAKRzRE3c6GtfCKQ46lBpTgraJqoOIM0mrXg1jm4GVaA3+JUgtCE78h+37C76wriccxncPyOEFXAJKJx0ZoxC4UULiKv8oskAmnsjXmVP+zGyVvtgIJMLczUCUx/3o2la0OWfGdcbXwHtfb3d6QLrSDFaOUL2gsB8NYdsHT+LgIjsRGrirgKgVjlPLRmRv3+zXO+Ivyczri0U034KxjjVfoCRlmpW2lZVCMEvVAF06bddDMCw8aDgqjfqclGWa4ETww2Y7CoVGM3DWdoNRrdUBTzTJbzcHYpQPM2H09K6Kf4rvnugbESdN5p9JI5HNEkufXBbvIaoIce8XIKxtwlvI+P6KCijjkwFKGUGAeme8AukATpf+2ruSY+2VdDX2mJgUNjVDsxy/6sCmTnhA59RxpBANv/KhriGM7UOi+QJUjjcAVGj2WGcX7OAKMT8CgkqElCZN/45my3ihVnJB0NXLIdjUs1JV+GMewLNJpw0w05Wpa5YQPMgokKXcm1tskWpGv/AuZq9dVz9iEATi5ntweCajYkixzJfgnh6yIgcZZ1FKUgtQxB4ZyxsdbFFdp17aVdH/jahNJ8GW/IlYvPG7ZQzs3MW6BKYuzr4vZtFvc3On04j0aXvdxJoF6ON3MEClr1uOkwKMYMNv3Ep6VHXu/YCZXerGvTLb79ZKce/taQ5ndl3LEBRgfws8VzhvSicp+M0vSrWhelpV4owaGAxcFkkYSXZ96lZJRzY5N4J0p6/BH1loAcZLt+swXFj0oq+toyxt0OO+BYuejAVUB0DI0=
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(376002)(136003)(396003)(346002)(451199015)(40470700004)(46966006)(36840700001)(6916009)(40460700003)(54906003)(7416002)(316002)(2906002)(82740400003)(478600001)(356005)(186003)(26005)(82310400005)(47076005)(966005)(336012)(7636003)(426003)(40480700001)(4326008)(8676002)(70586007)(70206006)(31696002)(41300700001)(86362001)(31686004)(8936002)(5660300002)(36860700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Dec 2022 07:36:15.6134
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b3d49088-edca-4069-28c6-08dae96f5e2e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT104.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5174
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Dec 2022 20:22:39 +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.1 release.
> There are 25 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>=20
> Responses should be made by Wed, 21 Dec 2022 18:29:31 +0000.
> Anything received after that time might be too late.
>=20
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.1-rc1=
.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git l=
inux-6.1.y
> and the diffstat can be found below.
>=20
> thanks,
>=20
> greg k-h

All tests passing for Tegra ...

Test results for stable-v6.1:
    11 builds:	11 pass, 0 fail
    28 boots:	28 pass, 0 fail
    130 tests:	130 pass, 0 fail

Linux version:	6.1.1-rc1-g4478ff938eb5
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Thierry Reding <treding@nvidia.com>

