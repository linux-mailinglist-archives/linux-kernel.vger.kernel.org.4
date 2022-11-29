Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB80363BD9B
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 11:10:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231173AbiK2KKA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 05:10:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232461AbiK2KJF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 05:09:05 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D0925E3CD;
        Tue, 29 Nov 2022 02:08:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b+Xe0AV1cRy3KKunK2EetaS8g7dv2dLDKPANhqT2atCOpE/JkzYcq2ld8o/tj4WwAcoFFP7lobMsbEfZ0nsnakLdFBM3JdHQL1Ky8WDBrk9wmzoggIjR8+ZB5qaljqTWMbeCFyRGhREzII2GnsZ8xnlEzIzjP7oKmum4om+af3Pp9fZ1m640DcC+ckXy+WCNuwO+a8UHQGhLaVe1gL7yBCJT0TjD4sIJzcpDFGqkdNPTjt1Jd2g8sKVvEgJsKvVxJQip+t0Tm/bzXyWj3Wu82ZETYg1ni57+kTJa5jpg8e7VtYBp4/WR7AIqs3cF8FsptVi4Q+F5rr4WCI0uGm4kvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zoZe8Hp25AcXvY2UCfzezf6H1GGC9UiwiiNOH8DvPSU=;
 b=mFQ9EcVuUBsPSnY0qp2uzkFfnvRowhaY+tngcS4aOcixkFzAa2IY3sOFj6ZdChbjcCnqvwxPNJuKhX/nhdI2CyWkq1uUT1Sbqng1XZiY+aH1B32m2Xha6wJxBLytSEvYuHtjVReOyN1OF3oAb4GsmV8EuM0I1dFygRjDKAlcjU/ynNCnjyx9CtH3Rr2ELzfIQEk2/qdO/9X4w98xvsRLmcSWeZNGrBq91XVDF2WLVFjBoETMt5Z/1+s8DVjZ0s2gmrtRKezNubgkMscXIVtn2RZiLKhO4mYSY93ayLxeSD+5oeHgk6H87CsFyMDQ1Vwc+Ap72017iyf/TXhsp1KW7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zoZe8Hp25AcXvY2UCfzezf6H1GGC9UiwiiNOH8DvPSU=;
 b=AvVZfLtmf4FcyBSRn8sVDElJ19z9XwFXofix7eA5N71eRFyDiNMqk01uuajY3sB5tp9mw5vbJXcr9m3atYr/SA4Ub5nZilB+skHmbei1D/ktbi/2Wu57RKmm5HnlwoSbvv/mWqcpNBLa9NHOVXObtscdxrL3A/tZ7tqJThMzGkkQEvr+hen0erT5xjxgdG9rxAIx6TSouys26YwJm0EBOXFhTXdyyesThpLbjQ+QVnvgS25T4apMb6GwOVY2/XUB1hLvYKiGAPyy49T/jCboNZF9J4aIHfhCqr1v1/FFNCEPUsiiEywRxMwL+RSn2GYe/KnGUzIq/wLsiholk9x9Uw==
Received: from CY5PR19CA0063.namprd19.prod.outlook.com (2603:10b6:930:69::6)
 by DM6PR12MB4217.namprd12.prod.outlook.com (2603:10b6:5:219::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Tue, 29 Nov
 2022 10:08:26 +0000
Received: from CY4PEPF0000C97A.namprd02.prod.outlook.com
 (2603:10b6:930:69:cafe::13) by CY5PR19CA0063.outlook.office365.com
 (2603:10b6:930:69::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.18 via Frontend
 Transport; Tue, 29 Nov 2022 10:08:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000C97A.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5857.17 via Frontend Transport; Tue, 29 Nov 2022 10:08:26 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 29 Nov
 2022 02:08:17 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 29 Nov
 2022 02:08:16 -0800
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36 via Frontend
 Transport; Tue, 29 Nov 2022 02:08:16 -0800
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
Subject: Re: [PATCH 5.15 000/180] 5.15.80-rc2 review
In-Reply-To: <20221125075750.019489581@linuxfoundation.org>
References: <20221125075750.019489581@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <b3ad7446-7dfe-4e54-b220-9a47bab139b8@rnnvmail205.nvidia.com>
Date:   Tue, 29 Nov 2022 02:08:16 -0800
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000C97A:EE_|DM6PR12MB4217:EE_
X-MS-Office365-Filtering-Correlation-Id: 01a38abb-1840-436b-ac18-08dad1f1a830
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8Z3lwOR6QTWscjm7OUJVAJZ210fOBfkf1IEE55kKy2A4kZ4Fwcfv7Hvc5InJkpDHKI0di/nE80TD4YylVIKhhQcUvM+OjtSHrmlpYQ+E+ep3HLFZwNPUib0QKKhZml/mfOlk1NyCC+WiefS7yQNi8L4AUbClQbKyksgW2+8W5U3u2Cq7L7NwQt1pkDm1RVWh2inHo1LqZn35ZftZQEgGtg3PaSS1KsNxi+69K2zM9Tp114iM2UnoMbeKE50XOEeJb5J6j70OrKJuDyPhg2chIG0sJV3o3+um6KofwkVdBPzHMJDD6QhTJxafSctB/WkEwyVO7VEXOUEDwDxvVKBRMGvilxCbPcfGZsBjslE4VAx5g7ST9IVpjEbkI4jlAOpErzgYE4/mixDbyzrDWghBIkDwwb+3uFbA1s6x9cub7KkGklhHxKjyrg7ScC60vFksyD/P0bKRH+wFlTeDUgDFplZoFq6cLUgs+V84QRxv6GR5Y8pVLylVwKqktc7m2YjbZq5IDDD9BUcBpjrIuhQzIf1Lfi1uwsPpisEbwSTU0v1QPiW7NkJO/F4NipPbf8dkYxSB5SHzP5oZNBLfnwUbsZs4WyarqM+yP/nz9KgADPtyeL+obwGWz+WAAeCLoCd/wCrULrKhmli2DDY70vHxemgfDkSBPcZFxIXdP+4sgpv0hXaghzTJ/KbzBQ7JIuLzSGLlt9zJcI14NEWOuNT051tGGYrV/YDfZPJMmPrbX7FwBwWr6MAXLZvbgddVp1aOYOIJQhBS9Qpxej9JSc/HxXw/jBBsGZ4nXDzkttWPK3c=
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(396003)(376002)(136003)(346002)(451199015)(36840700001)(40470700004)(46966006)(336012)(426003)(47076005)(186003)(26005)(2906002)(7416002)(82740400003)(70206006)(5660300002)(31696002)(8936002)(31686004)(70586007)(966005)(36860700001)(478600001)(82310400005)(316002)(40460700003)(4326008)(8676002)(41300700001)(86362001)(6916009)(7636003)(54906003)(356005)(40480700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2022 10:08:26.3869
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 01a38abb-1840-436b-ac18-08dad1f1a830
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000C97A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4217
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Nov 2022 08:58:52 +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.80 release.
> There are 180 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 27 Nov 2022 07:57:16 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.80-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

All tests passing for Tegra ...

Test results for stable-v5.15:
    11 builds:	11 pass, 0 fail
    28 boots:	28 pass, 0 fail
    114 tests:	114 pass, 0 fail

Linux version:	5.15.80-rc2-gd0344da1eca6
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
