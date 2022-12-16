Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3673564EBD0
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 14:05:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229863AbiLPNF0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 08:05:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230305AbiLPNFP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 08:05:15 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2065.outbound.protection.outlook.com [40.107.94.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 812A9165BA;
        Fri, 16 Dec 2022 05:05:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=elhCXVF+a1Fxx1ID09krTveUrAiTT6HuiNs6Snqmb+17UL+As+22zu12nnWebmHMm/F6vCcSMg7ARyzfQ7tCazrQPeNwb7j30VlnfPBKfJmWJzthrA2ydvw7+l5zBPGfInjQgBekjlDFP+F2/+3GQEpzykCpe7gxol8JoniDejulUq88z8ZfWLdiYkSFg0/8QHIi47uH5Vsgl4GRCjd6g3gxe+5pLGkJTriMJu7d4XvszCM7DYef6DL7vDYNH5x9ruI1agiQM4nJQ2xUlajqpIDU3zrJH3lBWhKsQUZx6uSeiEWT2Lz9DoUIL+VT0xMMoKYC76ShWgPPvByg9lDfPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0IbzxJOBcMCYhl9SPs4BQBgb2ByfGfYBFnwTxXFFdZY=;
 b=EKmufRU0/5AUHwTNyOemCtaw3tREpXTjKdhdyQ9cPP4nkhUIjfWYvKluhmKgaZaSK7lrYG73b5w12Jpa9qD1+P+TF/J5JQVruLa6RU1aezCnEyd3uNilbO/M6ODzZPk7y82T6jeUCEhys/ylBJrzpEsTcgrczk8ZO6dOtal0nBFJsBk5XxBv9M0wcIoaSLU2enr3ABnpS/XYzxmyRCQI5+ltZxsBLJh2a77Qwp3lJZUzGXMd2rpEQsTEcm9Nh6CjnW9wJohcrL+4/N/oNKiG0fswwi71V0+3FIFHK8Btj4pxoRKDB79JbDYoXDhugGB89OBxrjiMsmDO8MljRYhpdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0IbzxJOBcMCYhl9SPs4BQBgb2ByfGfYBFnwTxXFFdZY=;
 b=HR6RoKffnJ1dixauB6n00q8YL8BMSsIqjNAFY7FJuH2T/67MaVhc22hPOdTOazkF7pdaDp5B5gzfS4lBGDXTZIRgs3gbC0E3QvHGj2Ot8upnpPCwU1NyXI5j8ox12v7BXLZD8c6P60+76CB/7wh/vcWZCBeNM96/RC9fl6ZNQ65LNlhkDMGmCD1ytejah0gGQXzo8Oz5DGDkWWCEC8fATUBFJrg4zLXIkRl4D3kvPDMZt1eRwYaqAkUGjMPbxhtR/Ftlmv+7K5setd1IerIxk+q1LAqR4dJ2Tm5+8ow5lwveEaf9YeAsbGMBY9qlX9aHBLZjwbVLmf1epE6UNZgzJQ==
Received: from DS7PR03CA0147.namprd03.prod.outlook.com (2603:10b6:5:3b4::32)
 by DM6PR12MB4433.namprd12.prod.outlook.com (2603:10b6:5:2a1::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.15; Fri, 16 Dec
 2022 13:05:07 +0000
Received: from DM6NAM11FT014.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b4:cafe::1f) by DS7PR03CA0147.outlook.office365.com
 (2603:10b6:5:3b4::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16 via Frontend
 Transport; Fri, 16 Dec 2022 13:05:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DM6NAM11FT014.mail.protection.outlook.com (10.13.173.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5924.15 via Frontend Transport; Fri, 16 Dec 2022 13:05:07 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Fri, 16 Dec
 2022 05:04:52 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Fri, 16 Dec
 2022 05:04:52 -0800
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36 via Frontend
 Transport; Fri, 16 Dec 2022 05:04:51 -0800
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
Subject: Re: [PATCH 5.10 00/15] 5.10.160-rc1 review
In-Reply-To: <20221215172906.638553794@linuxfoundation.org>
References: <20221215172906.638553794@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <67d89c13-87c8-4e62-a4fc-8dd40b875605@rnnvmail201.nvidia.com>
Date:   Fri, 16 Dec 2022 05:04:51 -0800
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT014:EE_|DM6PR12MB4433:EE_
X-MS-Office365-Filtering-Correlation-Id: 162f632e-53f9-4f45-336f-08dadf6627de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TVYqdRJ/h5pxodi9FX1HN5oFUWkvGU/8qig+l27212lCpBF1R4smH4Ou1zYcjI7OpVKEM/ZDcXiEVRllWk5O9OCdk736jCyPavXw50pQwzsMGgEcGl4NEUZOsHvRAkYImKBmsilVblolsykZR6tjHq83dbQ5ewceVQpd/H2MC2i1IXNPDJvmlZBqdOqi6ZfQKKR8WJk5tQR5w3WqvRY7YxeHFVjYQAczK0uQ5UkNRxD9oW7UA8AXE6qGFK8OvhJB/4028uyCMkoMoq4OV/ouBWugbkjua5jnly/codnZf680qcDWzaQT9ymptdm+GbQqWLlFjh0meGWfJhF84nZBHBDQ8yEv+MGLficMrRXIutC4kjwPpeCKl/QNMJfA9BGBRmMyFAUZcqdehJVy9WSjFViCWI1C4D0yQn90sndDOFqlmm5BhSTJyo5VhhL3eCYLXRC1VJPdmXM20OhOKncE4twFAK8qtRhyKrSEGUlN9Iy8+6hm8O0YZCnaNhcgF4AKQkaPwb+4z+YPg9Z0wRM86e/llaf1bdhf1C7Jlu5NKdf0G+HPW+vHSL+n2w2UbSVrfok1945ARNeaK/jSJaBvdTaoJMDoOrmHo37/fIQH9f+1HTc+/SjPpHMgN2pi9qZAxVi9NrIopyyYYdwajcw6aJz0C2+wCVv574gF4IBHAvht3IwU7b2wffr9RcQeqVMZ1efTbZaqdrHdkLvzuuNzCtLZTUADrDOPyu/nJygttiK8x2RHLps+p4RTR+6ZNaIdbDHaVbMYr5r9I9+AW8yzi+6N+teciLggUXvc3scbpco=
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(396003)(346002)(376002)(39860400002)(136003)(451199015)(46966006)(36840700001)(40470700004)(2906002)(7416002)(5660300002)(40460700003)(31686004)(426003)(356005)(36860700001)(31696002)(86362001)(336012)(47076005)(186003)(26005)(966005)(478600001)(82310400005)(70206006)(316002)(6916009)(54906003)(8936002)(4326008)(8676002)(70586007)(41300700001)(40480700001)(7636003)(82740400003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2022 13:05:07.3315
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 162f632e-53f9-4f45-336f-08dadf6627de
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT014.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4433
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Dec 2022 19:10:27 +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.160 release.
> There are 15 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 17 Dec 2022 17:28:57 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.160-rc1.gz
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

Linux version:	5.10.160-rc1-ga66782e1af75
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
