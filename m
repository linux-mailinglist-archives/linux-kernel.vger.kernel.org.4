Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0F1D671B8D
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 13:10:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbjARMKS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 07:10:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230209AbjARMHs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 07:07:48 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2089.outbound.protection.outlook.com [40.107.243.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76B1F4346F;
        Wed, 18 Jan 2023 03:27:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OLN0LPcPXyokU4AJtNR5xgI7STYItld183mQeOmOU6D/A9hzT82POLZq802wORVmp1EKUIqxl2YHkh0aNreZyo46kh3tGFT4ViCqrvIoJad0/+S3dLWikV+JrnmUBmOG0yi/tDx4ow59XaTaDXgvIg3tMrNsifYoHZsKko7OwJR9NQVmx9LtQT8HKZcCT/bExsBmDX4+cSqHlvsvFRFS7mo2SS+oosJgq898MECGZQUj4HFAdN17yMtVNuuK47LMc0vxMaBRW9xcYMmaGicA2wBE6pYPTCIe2iqU/3I2aBmgfPkACOXF/OocqbaqeEWwG7nII1ojge/HzPBQusEQSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vC0UZnHaP79WhPPdWt13CGQ3PeoIpA2a0PWh57wKMpk=;
 b=TIUipXt1+rv2EEJX+BuIUNeLwGAR3bx8UTJ5taXkZiTqYq70v3N5dhFdW/ooGGqrbAbAOx+9XtR0wg01TkG/qvhevaS6pTPJxzWge5Cv8EgJ9afBRlymBli3emA8nDLm8FiKqOFC43YpEdiqssWfIs5khuhGZ5H/P9xp2OKyzYcL3m6C9Epj0jD2v8KnvEH3789xVlBMm+dmSTySKPtXLfIXyuVZkL8p5/BNfyQBiQzSnGwwlsYRmu7hIagkp0wtSIWMCyYvd2KKQ3VGFGF6cFazmi2yjdwSO6TxnTmipvdKk/0a++fFGnSEGHvlWv5Bo+sBZJx4gzolv6LJcwBPvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vC0UZnHaP79WhPPdWt13CGQ3PeoIpA2a0PWh57wKMpk=;
 b=RSM+jov0vrQAi7Jbd99GzcARfDUK1DVV+y/3rvmdCsKfLfTVDql48bT8kcKzXNXyn4lkNcKXscqQ8mTf2UZWTTr2UMd9NeVNSWdJ/8fdamGu6eCmH/twDwM+xtls2xJ1fa/r0DUOcLpCX/RTEGVdwkcouV1llzPD9lBPMHKzOiCq3hbJtgy5lVuulhI0ZCBAVZPJxWwJrTru/uixlzRaud9TbP0sO1QtIpdEUcsiW7BA2dIvxgEqcfu0tuuvcQAmJ+heI++V/im284L9epWXGmJAjg3m6KanNCSAYsXWJDUtGSDDaXSrWCww1ZnK3+HemhD2IoNA5+lRXdnS7kvZJQ==
Received: from MW4P223CA0028.NAMP223.PROD.OUTLOOK.COM (2603:10b6:303:80::33)
 by PH7PR12MB6420.namprd12.prod.outlook.com (2603:10b6:510:1fc::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.23; Wed, 18 Jan
 2023 11:27:45 +0000
Received: from CO1NAM11FT114.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:80:cafe::48) by MW4P223CA0028.outlook.office365.com
 (2603:10b6:303:80::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.19 via Frontend
 Transport; Wed, 18 Jan 2023 11:27:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1NAM11FT114.mail.protection.outlook.com (10.13.174.103) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6002.13 via Frontend Transport; Wed, 18 Jan 2023 11:27:45 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Wed, 18 Jan
 2023 03:27:35 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Wed, 18 Jan
 2023 03:27:35 -0800
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36 via Frontend
 Transport; Wed, 18 Jan 2023 03:27:35 -0800
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
Subject: Re: [PATCH 6.1 000/176] 6.1.7-rc2 review
In-Reply-To: <20230117124546.116438951@linuxfoundation.org>
References: <20230117124546.116438951@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <79265b30-278c-40d8-b7d8-b7116279e542@rnnvmail202.nvidia.com>
Date:   Wed, 18 Jan 2023 03:27:35 -0800
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT114:EE_|PH7PR12MB6420:EE_
X-MS-Office365-Filtering-Correlation-Id: 2085a718-e743-4a89-fb3e-08daf947055d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gfjEc/CX2bqBuNJUIrSvqzbArdoHRr/RcDZQkBsDa53Ue/KshX63eQToXepbr5DbDGJM4TySWR8EjEti37sjyrBoQYeSOtEJL8DBgkWzc9FvYBXALcJ6WdJex2P5YQw2oZXTCQS49xJMlAfssOOLxCiY3MnpYfkp/vimq6fAbqk1U0RxIcqdAf8ObC6o1Y2aE62Psl58ZmP8vIl00MmvBxmL70AQ6ZW2EM6EIZ/00Cli1i1ylCbDdG2X4YAfNtETw6VWXGP7S5TJZCQ7HgeoqKyNAVU0rqkzI7+WOutEnKm2urhpnCrYKrVboeqeLEIZq2uu5X6S1AW0zZ9PB+2S444cl+kYwxbj6lYBuZoB65f8eoSy9wip1P9DqxlouHwfz+fYlfd+ld0kz/U1p9PRz5ChTI/xSUYSnRqf0r5nPA2KTwXZkR9q2YsXyqiCe6RAPgsHxPHQU3gNglc0AhOOsZ5ElMZTIA2yVI/Z9VjXaPGw1K08Y9px0QN8SmE1aDeHkQ8k1eOOl8xY6JeRtR8cabZ65hUdWvKbLQOhOWY6mJmk601HlZc+7jySeIlvejQGkYnJIk1zkOgkhjjF2rMISbId8TfTZddaN3mta6cZU30bftwQ1Jc1HXddSTXwvFX+t/fpbPGgrEoCfEb3T+7rbYp3Y48kznehorDAODUeYONQkaUN3BYJbaIWW4/n3YjW6puUHpnmdLTH+OQwW0ukzrjkolYaXiEF0zeGftuDvCpxeDyfcXK5j0UjVS9qJjqy
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(396003)(376002)(346002)(39860400002)(136003)(451199015)(36840700001)(46966006)(31686004)(2906002)(356005)(86362001)(70586007)(8676002)(31696002)(4326008)(70206006)(8936002)(5660300002)(7416002)(6916009)(7636003)(82740400003)(36860700001)(966005)(316002)(426003)(478600001)(54906003)(40480700001)(82310400005)(41300700001)(336012)(47076005)(26005)(186003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2023 11:27:45.3448
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2085a718-e743-4a89-fb3e-08daf947055d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT114.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6420
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Jan 2023 13:48:13 +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.7 release.
> There are 176 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 19 Jan 2023 12:45:11 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.7-rc2.gz
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

Linux version:	6.1.7-rc2-g507f83506c2b
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
