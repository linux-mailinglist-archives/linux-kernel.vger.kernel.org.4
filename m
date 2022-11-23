Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DBCA636399
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 16:29:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238699AbiKWP3C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 10:29:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235513AbiKWP2X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 10:28:23 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2073.outbound.protection.outlook.com [40.107.93.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5AB162D0;
        Wed, 23 Nov 2022 07:27:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KuHm/b8G+haz0nKsJ2rLQ/GDVgx69ftWiif7aBqNaTN9PvtcRb9qv4a6SMM7xbcdGAyNjwWOIRyNhN4NS/pw7s/yKuR0HaRuG7aTXw6iJHKyFx0QyNi2nm/ULdz2A62hVNErced4wlk9+7l4GgvFrP3p7x26u+dx/s+YMde1eu4eXBRq1UDV0c06BSK8XnAZoxT9kN83UzMghfw7Sj3G1QazlxQm8WaIUk25U664pGZOAeDugAwA7/NhFg0WTure3vK0/avXfB/YmoFt6JG3iqreJknqHk9zbXA0iT7HTUmpDC+sN+Bst5eZ99UWuXBqzu62lYH/o5yyv9j8jAiIIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=edbsUgGGSSDabtqoHmavUlfEPHiBz4oY1VJ3pl2xw7k=;
 b=JhEmDeanBA2gEmBbUrNx1ikH4+Pk5bLnImFP6be+JWS4H4X96UcP0MD+zf5QPKSBGwujxfUP0DqjRJG6NK+64sCdtkNfAL+7R4IXq/NxN6yKhK5WiclQkaManROXGBZO/RJ4rCoUewIWCkOaKyauAHuJHV6BUg5veoePP5dk/BdtEUnCsTMxGY5akgsVu+HucFp4W5Q3CZNTrM8KCp9PGlaUchTSYiEQaJDwBT4+yERZPWjiIx+n1Tdi90N8L7qoMwKcFczeo98jJrf80L57ACbCHjEDHVdsJnME8bfvyk6mBRXAmpyy2Q+61dYP1f3mWLlwDCTHG046GnR1XL+aiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=edbsUgGGSSDabtqoHmavUlfEPHiBz4oY1VJ3pl2xw7k=;
 b=ln3JhyriZ9kBGEJTStUC7gZfYgmiZpoebXR3DNd6/D46ZTwJrOFIh7r+T+jZy39An1uTEB8i7S6bOo7rSwwTMmf9GETYJQxi7Sl2XG3xZ76zfPY8xT/VLo3X28nOX/d4lREcnOtnYndOX3OrqhQbLuBu5XOoZOceDQP/jXmlye5cO1qfHasMj6RByixxsS5b8Hhybxm4ZF44OYGltKGvq+n6XsyZBMRUp5pBbh1KD2q7J7jyktXIleTbKUuUEGCJYT4t5ZLDQSTfkBEg19rZvtp0ZL3dJP6ecXMke0PTIbBjWjxLVJ2qbSq8GHNjT2u8rJHGlex32SJJUvfhnf4pzQ==
Received: from DM6PR18CA0035.namprd18.prod.outlook.com (2603:10b6:5:15b::48)
 by PH0PR12MB5483.namprd12.prod.outlook.com (2603:10b6:510:ee::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.17; Wed, 23 Nov
 2022 15:27:27 +0000
Received: from DM6NAM11FT012.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:15b:cafe::44) by DM6PR18CA0035.outlook.office365.com
 (2603:10b6:5:15b::48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.9 via Frontend
 Transport; Wed, 23 Nov 2022 15:27:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DM6NAM11FT012.mail.protection.outlook.com (10.13.173.109) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5834.8 via Frontend Transport; Wed, 23 Nov 2022 15:27:27 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Wed, 23 Nov
 2022 07:27:19 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Wed, 23 Nov
 2022 07:27:18 -0800
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36 via Frontend
 Transport; Wed, 23 Nov 2022 07:27:18 -0800
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
Subject: Re: [PATCH 5.4 000/156] 5.4.225-rc1 review
In-Reply-To: <20221123084557.816085212@linuxfoundation.org>
References: <20221123084557.816085212@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <0f3cb19e-f572-4178-861e-16f7f32cef2d@rnnvmail201.nvidia.com>
Date:   Wed, 23 Nov 2022 07:27:18 -0800
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT012:EE_|PH0PR12MB5483:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e634977-6c3c-4cd9-65b4-08dacd673aab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xWzuwn2Ti0P/wsWpGncbCHNvVXdS1cmhxhKmFeNX5TZ1PIP131zaW++K2eip9JB9uh74u6rHNlENJv6v4JsW1Fc6zY0nJuy59Ad3OHcwJgk/bI5YDcqXPYggy9YCYjE2uSPtV1s9MhL/Y1gzHmlpMNHj449C3nBpefUSeeXVL7X+OIwWA1pcQfjTT9LvMfFbRI37DCc5MzeaVDmo1OtDTgFPdVHn7Era0eFgVbBYVlmS0RgHEwjtcqsHrVjwKBecAon2XieLdFO3EEtOYIEp9LvRfACH+inQ+AUNKBesF7m85zjlPKmkldqtE6kRPmJRNQtIY2VWMBDlX/0SqDrY25H+T+o0E9HMNAOF7VonhGlv9/hPBKEYZYRpkaJYXOAk+8yavOqgfMIHBG9BKYmoSZBdVLWh6/mt33RIfgZNIx8V75smcfKmnKLA9Jp2JgeyON40zmZmWaXEw7a96GB3aThnk9Eh5MU445h3TNkNICNY14/mpBQIR+9YAn6OZ3d/lBpVzlZK5BjFdESXkxAyU6ZE4OoXWcVnpgmXkTv3C4JL4jzztH+FG2VmOvZTHC7hjJQwVVwF61iQ8qgl0KBy/TYSo+3n8HHRQcVrFe8FZNA77ksJ2iSSawu5KkKpuYKb/RCOXBkm0DgXCzanI/FLJjDb8UU+sUz4jlGAWfmgbPu6MhGyyY2HdLZ10S4o1bdLhPYSgME5On95MR4FkXYFv2gn+4rk/7sTaCwqqMZTLMhnDDcT7+n45GtS1RLgmnYuwTgG9PjwQhyf+FqlSDWwCp3m+oXkdrGXekzHVaHAgKI=
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(396003)(136003)(376002)(346002)(39860400002)(451199015)(46966006)(36840700001)(40470700004)(31686004)(4326008)(41300700001)(8676002)(186003)(82310400005)(478600001)(70586007)(31696002)(966005)(70206006)(2906002)(36860700001)(336012)(8936002)(26005)(40460700003)(40480700001)(7416002)(86362001)(5660300002)(7636003)(316002)(6916009)(54906003)(47076005)(426003)(82740400003)(356005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2022 15:27:27.4420
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e634977-6c3c-4cd9-65b4-08dacd673aab
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT012.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5483
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Nov 2022 09:49:17 +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.225 release.
> There are 156 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 25 Nov 2022 08:45:20 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.225-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

All tests passing for Tegra ...

Test results for stable-v5.4:
    10 builds:	10 pass, 0 fail
    26 boots:	26 pass, 0 fail
    59 tests:	59 pass, 0 fail

Linux version:	5.4.225-rc1-g3e1fbfce73e5
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra20-ventana,
                tegra210-p2371-2180, tegra210-p3450-0000,
                tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
