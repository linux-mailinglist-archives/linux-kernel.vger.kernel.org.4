Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D96869E236
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 15:21:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234445AbjBUOVf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 09:21:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233944AbjBUOV0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 09:21:26 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2066.outbound.protection.outlook.com [40.107.244.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC9412B61A;
        Tue, 21 Feb 2023 06:20:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I7opcA2Tkkvfy754T4tcT5EfVWEvtSplvZICGVyIXAQME3u6fjCpYWhU4hateHlxHMnQkkN0R59nfHCGwIP0A3NuCvs2U8WQxpQy3vpwfdRkNFQoiz9KOQCFVDaw94P6FzxVb8NwXe0cxi/SSCicl1r4HuCT0K875AfFb56x9f2xsV5jpCBloBaaF8KJD0H1toPDOV/ttnO1FrjjIWx/7+vm+cMsSUMp2MGVO3UXT9lB1dCmW7S72okEyJ6GObbsPBQG9V/RAGGcBmbccEk/f5jviY4d10Bv9pV7s2VaJTJrySGOzwyzP1YI+MAV3/5RDh93oyw4Jr1XgW21YGYssA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Csa5VaSUFyB3nkmpzRp/CL5iX88xIjB2lUGXVsitlsI=;
 b=HeUg4yrLIqNlJx5/zxx/09FmKdTljWUNnT6bJJJnIGDwaPKACDqImJdcS+AXJ5eV2Yc5pVMWNA7p8ok3tIcVJBg1PicCCWK+scqwk90URkrjlAxFOPdwi9YWVv/RQFj5oaVjReMWlM0gIm1+fxQhXDtIXa79tRVNd+oEqGEpNlnSZ8s/0H9EkUyoIBEfiKX/NloP+YBulNigsJT8W3veR1jbmyPQPDH3DsmNxeHeHq1R9pyQf2aXRgx3cf4dyaGrBnpU+0Ud7WrlQxU4U870xNgq/dFtpXcW9Dazve1fWKCSZj6v8WxJU+MA2DW58PCIrTK45gbsMLiXc7RrGjpzjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Csa5VaSUFyB3nkmpzRp/CL5iX88xIjB2lUGXVsitlsI=;
 b=KkUEwjtLKiWMrwgLMZHJ22t9k/rIdxB8OzeB0Nod2m23Nf543oYV/NnzwX+XSHZmZWyl+NapHEHy8T7YFjz/yKwtS6Gxfs85aaEFpUmRxmSzQ+eqcinqvMVg5pgTGWvpOoex3uyOQAvtj9FBzvngYMpdEz+2CxfmyGioz5Fibx5xLNdJlFV/4rh94O5voZmc2l3srvgfM3l+s0jQVhYttZknO8vh3JuXFLJ13UEmNJG8UWBFvbS6HDeeRc04M4lF8uDuiHZFviGydjk1XwSEZCbAVthNNxAj1aGK9mzSK10174O5BwC5ZHfP9b0GNPjKewyeF+JeF1HW37GtJqzLqg==
Received: from BL1PR13CA0273.namprd13.prod.outlook.com (2603:10b6:208:2bc::8)
 by PH7PR12MB5904.namprd12.prod.outlook.com (2603:10b6:510:1d8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.21; Tue, 21 Feb
 2023 14:20:56 +0000
Received: from BL02EPF0000C404.namprd05.prod.outlook.com
 (2603:10b6:208:2bc:cafe::ff) by BL1PR13CA0273.outlook.office365.com
 (2603:10b6:208:2bc::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.17 via Frontend
 Transport; Tue, 21 Feb 2023 14:20:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF0000C404.mail.protection.outlook.com (10.167.241.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6134.14 via Frontend Transport; Tue, 21 Feb 2023 14:20:55 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 21 Feb
 2023 06:20:38 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 21 Feb
 2023 06:20:38 -0800
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36 via Frontend
 Transport; Tue, 21 Feb 2023 06:20:37 -0800
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
Subject: Re: [PATCH 6.1 000/118] 6.1.13-rc1 review
In-Reply-To: <20230220133600.368809650@linuxfoundation.org>
References: <20230220133600.368809650@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <89060917-e8b4-4753-a6e5-b6e5a0e0d410@rnnvmail203.nvidia.com>
Date:   Tue, 21 Feb 2023 06:20:37 -0800
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0000C404:EE_|PH7PR12MB5904:EE_
X-MS-Office365-Filtering-Correlation-Id: bfd1d36e-1c62-4265-432d-08db1416d8ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x5N14Jf9ktZW7K0709wH+vaZVZ+kde66BzEJuQbjqGQYkOdYhMKv7NhM9jxTmoHirIBf2TnJOYj0N29xT26y1FaDKWlTfbmTMUPtUkL1l/tkptwSNrU+xC2QyrWNx/gmawgx0hivwKrHrEQI5jDa5RQ5XW6/ywXucsqI1G+mWxmdXXZxZFo+V+SIl6A0mSpMCvIyl0udxlflwmB6+NKIMgNkV1ZMAKvJyWWV2uhtr7/w7TRpMxy09GKJDqdyn48iTzJd1cBpH95mq+wyRLNcXlIwNfMf3ZrktWjMCYHoywSGYQKg2qrS9ud0LR5ptebPpBawCkDTggzuQPlOBYtcF7M/MAfuEt31xzkcNQNgVsugQ/kxQvPz6Bp0JUFHaxSOLVYqd3BeJwRLa/hE5tMwxeseIRGLoYiegEECfpkrzbyVqMdLPe4uln8qRrNTHq517WR34UfeaAEF+pOYMtIR3iXJrs4XESE6L190jbEd5g/WV3FegN0d1Ewyq3FM9cuGuCAS8IenMtOtB7vCczM4d0MgTupFDPnnLEECqph67VCfAK0Jk3KhpomQiXUZz6GPZB59+jgcovyyPhITPYhyWgxiCoVcA8JCZxNhneTBwAFkSDwXlB8vuqwpo6rWQyZER40H5uyvPh8CgY8ocnl3hXnlPpbz5PBMEF/OB3Wkv7niRqer9rLwth5KJ9J9fY9eP96epfZajFa4WdWv9R7UeDCJfL3iFBwMxZPqveOXxoNn0R3rS4GqFC4wCu2ACcHT
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(346002)(39860400002)(376002)(396003)(136003)(451199018)(36840700001)(46966006)(40470700004)(336012)(31686004)(966005)(5660300002)(36860700001)(7416002)(26005)(186003)(426003)(47076005)(478600001)(316002)(356005)(8676002)(6916009)(41300700001)(8936002)(40480700001)(4326008)(40460700003)(70206006)(70586007)(7636003)(54906003)(82310400005)(86362001)(31696002)(82740400003)(2906002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2023 14:20:55.7964
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bfd1d36e-1c62-4265-432d-08db1416d8ab
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0000C404.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5904
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Feb 2023 14:35:16 +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.13 release.
> There are 118 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 22 Feb 2023 13:35:35 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.13-rc1.gz
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

Linux version:	6.1.13-rc1-gfc84fcf24fda
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
