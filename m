Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39D4D63638C
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 16:27:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238369AbiKWP1o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 10:27:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238888AbiKWP1J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 10:27:09 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7CFB769F3;
        Wed, 23 Nov 2022 07:26:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=arTj8WAifC0TiLtXuZmZeH05GWridcmtfCC23KPSdv0a8u8ReQKg9SlZfECI+mdhBXRqnVEvJZx8KvtndmGhFu4vZ4SaPtyxPlntowb4j+AofWLs+cx4hr2RqnhyZQDRizQ8WD6ycwkJw14p28fqP0mwVIwugcuhYwlZn3JNMYZyJCPUIBmgnIjf1SuDQGsASrDHjzyiltsbiQr4WKCho/0aJyEYU3I6kYcgsDGp8NKUPia/0IqfeoLyybGnHVlKwfqXriPfYOM6SsFYRaAYmPkvuqjg7IvbEXuBsJ+LNAKcgYTxiFV93waWT2Tts88mxxuhHIKhWqgOFju7Tt8oqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3sIXsHqINFNnZnsAGZxXV2KYG/CT703DoIeJ2vOYyk0=;
 b=KlXW06FHCw8o+TDToXL9/Ydyj46J3BI0oNX4jR4qY/AqhgtB+SeSpthfPwxW0j9/cUwUJa2SmeHzlB8Qv4Ioceo7dqhvGCqd3TJZcM8CUd76nXqF8gqHPUb5XODj5NeuZ0N27tB/SshfaqXDLSQpVKyW2vZsTS5ahSQ9aqVIjYJCwwAw0oAV2QZI8dzdXsgXBN04USWfsMiE9O9RCl11SaX04u9iwsEwWdCgu1vMqOeaa9gOibXvM63IQXHlzd2WkfHxEETgozbJo/YnCix0WpqhncTFTe9Kg6ZKoiobdqh7Qq/jbDbvd9vDWLlyuxTUYl/cUl/MXH+tiAKReMNrqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3sIXsHqINFNnZnsAGZxXV2KYG/CT703DoIeJ2vOYyk0=;
 b=c468IhcyqHlPH8MiFbJkI8zCtnHKvc3yHXIwAnx/3PRLeX7zne+6wUvq4/HhUHoRpmdzTiAh+O9vGkdaZLHZ97Mpe5XgiFU8JtrNJkn7uhnF2H16Zf3tbC8Cedq9wpK7A5zPfhpc3g8juqv8xe1QWHWYBa/sm5FEHpgfez2jvFhVbqo0NaZr9ETPMCUE06ebMMNwQ6oSqZgO+smOEPP57wjJPJDs2zGh3GbtvD/Pw99KzdRNNUgYEQL2FcyTlWh3ETWT5fzAd6QB9nlCRh0j4jJxEX1MQTHrHzzOkWe+Aoh4Mmx2ydAgCDmHISUnMD8OWpvdFYbegQKmmAmHo8iriA==
Received: from MW4PR04CA0225.namprd04.prod.outlook.com (2603:10b6:303:87::20)
 by PH0PR12MB7096.namprd12.prod.outlook.com (2603:10b6:510:21d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Wed, 23 Nov
 2022 15:26:45 +0000
Received: from CO1NAM11FT074.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:87:cafe::79) by MW4PR04CA0225.outlook.office365.com
 (2603:10b6:303:87::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.18 via Frontend
 Transport; Wed, 23 Nov 2022 15:26:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CO1NAM11FT074.mail.protection.outlook.com (10.13.174.254) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5834.8 via Frontend Transport; Wed, 23 Nov 2022 15:26:45 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Wed, 23 Nov
 2022 07:26:36 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Wed, 23 Nov 2022 07:26:36 -0800
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36 via Frontend
 Transport; Wed, 23 Nov 2022 07:26:36 -0800
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
Subject: Re: [PATCH 4.19 000/114] 4.19.267-rc1 review
In-Reply-To: <20221123084551.864610302@linuxfoundation.org>
References: <20221123084551.864610302@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <e571706f-4a8c-40e1-a050-69260573433c@drhqmail203.nvidia.com>
Date:   Wed, 23 Nov 2022 07:26:36 -0800
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT074:EE_|PH0PR12MB7096:EE_
X-MS-Office365-Filtering-Correlation-Id: 1fb02c8e-df0c-43eb-8f6c-08dacd672187
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jBkI75k1bxY7/ptYi7OSbbF65U5+eHqrPNU6P95cXW+JgfRKjP7hKk3EZQXMnYa/kUSAkDOL70p6uIB16AGTzNEzr2julgT1PWyDxwVZWO3HWscTTZxQlUcUwLZqGIaq36lxGlCi3c2Fm1+4U0Cy1dAAYBsIEJS9L614FmYthHdug20a85/QSZHLlBAvsAdpymbwgfFelV9n7aRibQF1prD7VxxLrgmynTEvpI4Q51vNVksS9ik3vHCBKCsIHqg0ThUnLhK8eB5HZR6SiBL9X+xPr2b7bF58Ftj257fZnnk3uwcc2T87lpe/YTr3JkMoEkRQE8XIGXIN/ivwqzj7Hp3bqXrgm+cMAyilT4W6LvAEvDO0USlIdcgKa9A/nORo5faocqGmugeM7Maj6sx76G8QfPfPbtv8o4J/nCg6gUg8UhycAPyg6kmarNZyoOG27vxpQgD+szDYbP0Gv4rjc0FVGhDmJVzQCY+ubEiowF7Keobq3niM3Erqx9XF1w4Io00rzwDl/Ni8YWBxAIPsTdnfxaHxinWFFg5OgxROp8vD6r+vGrWih7xqG5dCBuFLBCJSdoaKWK55xKNNacdXQagAwYPHDYFVNTEzw3LfuNwBF0vBPltY3o66XYTrY1XVcNe9FDT3DGbc3BdIl0lCt+g+HXGQx3iEOQTIP/BaRpoeAdZAzTIvxQT9D4aSB0rhQs50r9PZF3SjqxlJwSv0+eI2/h3Jcr7dKHiXxqHY1LfA6M46fA1XrnN1G7pMsRcfNyAk9CVO8/0F1P6+S5QPGY0b3uC0yw7NVg4cl6X52ng=
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(346002)(376002)(396003)(136003)(451199015)(40470700004)(36840700001)(46966006)(2906002)(336012)(47076005)(186003)(426003)(966005)(26005)(478600001)(36860700001)(7636003)(86362001)(40480700001)(356005)(40460700003)(82740400003)(31696002)(82310400005)(8936002)(7416002)(41300700001)(8676002)(31686004)(4326008)(70586007)(6916009)(54906003)(70206006)(316002)(5660300002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2022 15:26:45.3266
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fb02c8e-df0c-43eb-8f6c-08dacd672187
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT074.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7096
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Nov 2022 09:49:47 +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.267 release.
> There are 114 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 25 Nov 2022 08:45:20 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.267-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.19.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

All tests passing for Tegra ...

Test results for stable-v4.19:
    10 builds:	10 pass, 0 fail
    22 boots:	22 pass, 0 fail
    40 tests:	40 pass, 0 fail

Linux version:	4.19.267-rc1-gf65c47c3f336
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra20-ventana,
                tegra210-p2371-2180, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
