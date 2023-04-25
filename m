Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 425FA6EE096
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 12:45:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233910AbjDYKpe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 06:45:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233831AbjDYKpC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 06:45:02 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2041.outbound.protection.outlook.com [40.107.237.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 322CE3AAD;
        Tue, 25 Apr 2023 03:45:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lvd8yKG1MlXVsJvzlQKsxQqFFbrWjUc1N4QarLYZ9ttkJde6Rc5qzofYqlT3dyP6s9Hd+V7TQA+99ekoDKIfYqe9A0jmfCFRUXz0ZXAHJ7ZafVOZyvreyZmD+t+4U2XGlz/AYuPT315CgOaeSHxzJLe+K69WcUgYEmWUGZhBROFShsvs5kWooZE3XOo1rbjfrdqT1Cv6M1/x9Uf7FdVIIfdBk+z3O/5w+U2jspQLCBzL+IA0psltocShW3G8nhHinfHh2rSNTyEHML0JcevuXtdOS1hALvsaBligs95dR7Ka4DHOC3EuSv9K2X9BG4SiYl/VgMPWUaJt1G0yntFU8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xj4B1J3pd870Ukr/pxgEw5b2FtPB6UVLA9A4E6foKt0=;
 b=S+PLVXJ89/TdJ7yK4IZZvYw/H9MAlhLmNFWwpFiq2m0IuOWo66uqOnx/tfdCgRNr8WeKP73verCgx/e2byJ2Xm7J7NT7SdGlvFvk2c8dzhdLQWIGyBirlcgJDUqYJMkxJJxT30Rin5rmzgLovvFt9dMA+vb6y5tiNUzvB+EHYQ4XvfAhG3kvoj1Jh2fQNpN/pnFk/ZujItyPrPJKujTeGrblHtvCxsgy2Q46jUIGWSXwA5ZE75ka2khNhABvE3ZNNfKYRsTIYVS/Evcpca7z8YxWOMSTkVNadd6VlLu1h5HH6sxfRRpJPALgg2zCpkho27cmaZF+K4JMtA/fT5XeUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xj4B1J3pd870Ukr/pxgEw5b2FtPB6UVLA9A4E6foKt0=;
 b=ccNXJhnkfUbGwVKAPYf6iyvs4oXi4mNy79LcGF4e8bRjA4DmgDLLbtGZcCwdMxvfFRl+vLeBViGuPZtw1jFOYn8+FPa4WwPzPC2fDo23CcJtJpI3LrKkO2/4zzPoKPfjsf/aRTVSNk7NTELXoWebbAqfT9BZHUvi5wNPvjytOvWLVvzdJ2VaaySmTke0cZwF5mvjfehkNCjo/3rWMrmUBILYCJaFlZ/z1Y/3fKt2K7sdIpZpQzBu8yeWPFMQy9qooxJ1YNeah6tNTW0zzJdA7+V2/GFusPnnMcGhSsDQqmilnnSF3VzLrgXVJ+DhvsfhonNhxjqeaiZKr6ye0AiEfw==
Received: from MN2PR11CA0021.namprd11.prod.outlook.com (2603:10b6:208:23b::26)
 by SJ1PR12MB6362.namprd12.prod.outlook.com (2603:10b6:a03:454::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.33; Tue, 25 Apr
 2023 10:44:59 +0000
Received: from BL02EPF0000C404.namprd05.prod.outlook.com
 (2603:10b6:208:23b:cafe::ac) by MN2PR11CA0021.outlook.office365.com
 (2603:10b6:208:23b::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.20 via Frontend
 Transport; Tue, 25 Apr 2023 10:44:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF0000C404.mail.protection.outlook.com (10.167.241.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6340.15 via Frontend Transport; Tue, 25 Apr 2023 10:44:58 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Tue, 25 Apr 2023
 03:44:42 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Tue, 25 Apr
 2023 03:44:42 -0700
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Tue, 25 Apr 2023 03:44:41 -0700
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
Subject: Re: [PATCH 5.10 00/68] 5.10.179-rc1 review
In-Reply-To: <20230424131127.653885914@linuxfoundation.org>
References: <20230424131127.653885914@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <b32fcd12-c419-4dd4-8cac-ffa5809f2fb3@rnnvmail201.nvidia.com>
Date:   Tue, 25 Apr 2023 03:44:41 -0700
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0000C404:EE_|SJ1PR12MB6362:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ecb6569-d47a-477d-d094-08db457a1d8e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ab0sVbTsvwMYDS9GFu3DfYhPrinxdbenijb3NSm5KxipysagleYDbn0RqOerK3YFyFZG5AqEsHMS9OK0BJ1VzS4Rrqbj3mZax10fvB+oIyy/FV2iB2ZMeOaqTxRhIMNIaVtkgjqteMDVDqcUvxZG7S6EAifColJwKQKPYPBwKKOKaXj7TTSrGWL/wgZnGhw2MvMde4AYZAbCq7teXtCuuL4Or+sONvKRKl/Bqeu/LYBNItjwsSkYL4LIkAymyzNyDtiI17WpS6pWEDpJVK1pPTaqLCoiRm/m6Y7U7fG/FJcSid3JhlGXmZceXNt5Sbnfb8KYC2lNwhU4206MYxB0efI28o5FF0as3wQZSgh1lF8tSzueWkhz94Qt/vmX9WRI2bDwDMB5fZ8zYcZ+U4M1qzWU3lcIbL8NriJPh0isPCLqz0SZvRaCWlPgWF7LwRYjXhaIeY7HpiBDoWW4AAKQtGkObVLXuHSmGejHvX2ixiluUHUez6QuxjV0d6QwUkxGP0hUELXR+yMdSldSVPt1u1ytAF+Cd/avVja8smdaudSo8OyKug1FliGKDoAFcnERLc9mel3Y5FCYICGxAnnzCRw7W2L6D7jVBtDMyQ3L4V4ZU5sg9/pXXxkfB8Obvtu4M7BSXSFXEu4lazWO+bXS7TRVdqEUAGKVtgvrEQ9A1fNggMk9Eiy2xyu1E4WhYPzvUq/U1vMQuR0LiZTVevhJhRmi9/i8ynLttf+PQFazPrEuwucB3JfyDhWxO0aB8QlD
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(376002)(396003)(39860400002)(451199021)(40470700004)(46966006)(36840700001)(8676002)(31686004)(54906003)(7416002)(8936002)(478600001)(31696002)(70206006)(6916009)(86362001)(70586007)(82310400005)(41300700001)(2906002)(316002)(4326008)(5660300002)(966005)(26005)(186003)(47076005)(82740400003)(7636003)(356005)(40460700003)(336012)(426003)(40480700001)(36860700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2023 10:44:58.5251
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ecb6569-d47a-477d-d094-08db457a1d8e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0000C404.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6362
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Apr 2023 15:17:31 +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.179 release.
> There are 68 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 26 Apr 2023 13:11:11 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.179-rc1.gz
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

Linux version:	5.10.179-rc1-g1ef2000b94cb
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
