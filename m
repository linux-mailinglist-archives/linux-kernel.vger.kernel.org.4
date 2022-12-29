Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CD78658A13
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 08:45:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233068AbiL2HpV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 02:45:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232969AbiL2HpE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 02:45:04 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2052.outbound.protection.outlook.com [40.107.220.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D11C813CFF;
        Wed, 28 Dec 2022 23:45:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KTYyWmQJoFM9pQnU+TH6FjKbc2r9w5oF5KoQwh/wiv9kI73ZPp3xmTWq8/VHdeIUT7h1SW3FqxOrh6iRQ2o3s3w7na6c1/yWB0HiH+oZlYo/pwJMfc0HcQie1J9bMpwhyam4YA79iUD+I9M2JFZ2N5t0ARLn4+Ub4V1PHSnI35CeknxYYwwUDgDA5zXPba9aQTm1mlkRALfGIPXaESmQqrVYncTYZCTJd0TnBGxnKOXz+lcnwkOrJPzOE0GYNYT+1+mD6EmH09RO4g7BtvP8Gm804lxDrrYeqHID0N5miac6LFK3sLWD7hJ4W3VB8Phiu8nE7Gk3kBoohUwj/Rqbkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GCPNLNVnqs0BQ2OBIJ1JSZN1IKN9WFwQ1+HxqmnrRG8=;
 b=IvgviwpekfCOVEt4e3OJ5zi/fLt5AM5Blo1EQVP0cVGKn+WeiRfgA/F6bYNYwkDsFlUItGWNLRq0iJ/bqOZ9d8GQA7VkK606cP5bVVoCBuSOUjsgeOfA1/LFfs0/iXA0hygJHM8s90dkZWCqAXMY7Qso2Eu5WbIZeuzEWiBjkzSCM0vuqseDU0nGCubDPSyNxx/MKw19OCbglv89yP3Cdh4jTwKDQmbu9wNZQcVsd5t3km1iDEtwjniRTmYMPccZUIa/XKWLPmqARWkF5rqo2CX6vR6QAKTfA6oh1cnqs3FMHbZo8S9kMqNY4TnRoWXGh5VRr2zYmciKE8ficN+jXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GCPNLNVnqs0BQ2OBIJ1JSZN1IKN9WFwQ1+HxqmnrRG8=;
 b=nqquAVVT5D3XoA4uTLGUWO2tJ/7gRlHgxkCj8IjXkqeRsDDGd5uStLWlqv1/NqHQbA7ASoZkBzlWyVQ2WtxUVaZTyMcp9mPZGa0E++crtal7CRqLAYexyrofSYq48Jwy5JzpBJqLRZr8t4HLtx+XAi6mP/VF95uE94s5cOILpG/U2EbdtgBygaYsIx+lBc3ktWFtSTzDNzUi87NDImXceAh4NtS/7Jz8F/96HKipzu2REfWY3BgH/Q7oomXSCvHj0dHzgxOgc71v7+XxXD5anW7rV3oNwmQQWpmbqh3ORRbhqIOHB9otl2G3RfkVfNILfqLkDALlszGCrjRtlVbOJw==
Received: from BN9PR03CA0535.namprd03.prod.outlook.com (2603:10b6:408:131::30)
 by DS0PR12MB8502.namprd12.prod.outlook.com (2603:10b6:8:15b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.16; Thu, 29 Dec
 2022 07:45:02 +0000
Received: from BL02EPF00010207.namprd05.prod.outlook.com
 (2603:10b6:408:131:cafe::85) by BN9PR03CA0535.outlook.office365.com
 (2603:10b6:408:131::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.17 via Frontend
 Transport; Thu, 29 Dec 2022 07:45:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF00010207.mail.protection.outlook.com (10.167.241.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5944.8 via Frontend Transport; Thu, 29 Dec 2022 07:45:02 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Wed, 28 Dec
 2022 23:44:48 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Wed, 28 Dec
 2022 23:44:48 -0800
Received: from orome.fritz.box (10.127.8.9) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36 via Frontend
 Transport; Wed, 28 Dec 2022 23:44:44 -0800
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
Message-ID: <a810edde-667f-4b70-9c5f-3947e319218b@rnnvmail205.nvidia.com>
Date:   Wed, 28 Dec 2022 23:44:44 -0800
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00010207:EE_|DS0PR12MB8502:EE_
X-MS-Office365-Filtering-Correlation-Id: bc15d239-8933-4975-e0eb-08dae9709816
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yPk0xwaxzU1yBCyss4zdWvahcKLreQBuK1pwoSa0lpxVgy0MNP79B8clgdVdxULwjvHUwhozfgk2EO5C0n4S2hyuxb8mNrtnJ9m7h3H8Zx3Vx0koTVd/PnGkAhyrPkrlzgOrE0nivr9806GwcbWoQwmXLiPI+PvAhip3wdWR+Jdhdt5PsJinYBe0kITIKQlQPpECRV/AGZzDsm/kwPaFwggLecDnJb0UboPW7M64E29B6Io4yeBWgu/6yQc3QNGxydh8iTeXPpAzRcVOEl196oR/UBDONKbih1IXO7s3Ly/X/PjqVp2x6GU/Ov0Cc8XpGZt8PRckbexw9ZRDchcbFE9+POXF3UxGhLqw1Y5hIvvEslTUuUrZ62XC4H0DW4GC9nFhKfCx8bMmW0/MHIgs2ofG+r9Vi1HvV4G+uX5ZRNQJwHuJ4adQVmnPs6JkNWkA2ja5bc5Q506FSTtOqQya45x8grg7oPESwyMQueL9pYbmfd7J+mdtzhc14J7HHAgsV4vt4SxdoVfcwPPAjXqDzqSyQ/bJcgNyHbo0Q/HLinLSwjYeIIfqzXH8VZZ0ko+8Pf78M6ALypgQO4miZZqyky8B5WEKdjg7noAwnM6Uyh64lgQBi0g24Ky4DsfFhcu+rRQBHvUmfXJoM7XIlNuw+Y2Aqo6odD1kHPXfhcD4N/pRdsTYxBpVCx4V/Ha3A0zrpmJUElpLtlkQQh1XhsUStfOYov+mjV6Ku4ozuyGWogOXjSGxFdUwr9+FwIC9EAtbB0Miy6nSEpa7wZ+9urEBIWMUsxTNcdSBNDT/JY8nNVQ=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(346002)(39860400002)(396003)(451199015)(46966006)(40470700004)(36840700001)(2906002)(356005)(7416002)(8936002)(41300700001)(5660300002)(426003)(36860700001)(336012)(47076005)(31696002)(86362001)(316002)(6916009)(54906003)(8676002)(31686004)(7636003)(40480700001)(478600001)(82310400005)(82740400003)(40460700003)(70206006)(4326008)(966005)(186003)(26005)(70586007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Dec 2022 07:45:02.1559
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bc15d239-8933-4975-e0eb-08dae9709816
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00010207.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8502
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
    120 tests:	120 pass, 0 fail

Linux version:	6.0.16-rc1-g05397cfe6e37
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Thierry Reding <treding@nvidia.com>

