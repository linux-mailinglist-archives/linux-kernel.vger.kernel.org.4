Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EABF729FEF
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 18:18:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241982AbjFIQSU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 12:18:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242111AbjFIQSR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 12:18:17 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2075.outbound.protection.outlook.com [40.107.94.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38F8D3A89;
        Fri,  9 Jun 2023 09:18:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Eqtn768Xvw8XOR000wBXtkJfT5Im6CTP2eOpxL+vwKeLeAvF+jLNRs02TwzaNVXqKGl1/KYjaxTZ2q6v3MA3YtE5eIfno/Ra7aE9izTDMmAWqw15n9zD4FcmB5F78aFqSjZoNZJ6SxeaiW5YZ+Anx98OUNLiTpmG7YStv8Hi+ul+Rsnj7+mjIcIVBf23IxbVlaSblxMtHPfsXOewpvVVs0AlqYEbry4X6Deg4TOScLgm/ty8glhB2oFN/P0kKkXPPR6A9FYdDlNUp8GPvKVZ7cbKk4dI8/11x3TibhB/T5AAQpup2NmjdDKIekzRa25wpe0gHmSPqciy7PpiqC8hOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TBYP8gZfycKXjVec77e3yMUN9BmCJP8MWNXBw03Alwg=;
 b=IaUibW5/dBVxik6BXNJ1kPZiqROvy1VXg4mke08V5Upv84pTv8akDGCIbDcv5ZdY4IGEkyYHcV+y//nJIzR98PJQ+b06tCNVVaVJ5dkTSN2VHGlf8Mm1DDhzmpnid7gVmicrcDzeKjjne0A5La4983/64ZDxjnQpFLqDQ7mJyzHV3DT0jb6NDtur/8VihFsNfPoQk8YqJMGuLwdQYaJ7gtZnmVsXz4TS8+fTYjnZqzAeCt0mg7dUduQYlx/7QWOclTYxJASQ27+YOai3cm8VFLwqG/Mi5YNO9zwBkXi8KcX9+lXUecCZufCT/HdvJIeYDGCl05Dv7ckUiv2M5CWjbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TBYP8gZfycKXjVec77e3yMUN9BmCJP8MWNXBw03Alwg=;
 b=QAV1ShSLcgmBl3bKbn39qBzNTUMqgzjILYi3F3zNx1g+er67/fc69FB57qYaJNkpf7+Bin44+2JgRlYSSGu1LbjHTk11GWO/GdPczAWB6wJasmyFQcR/dJGVPsH4/rNnxZfC9/RuxFWaWzqOD9E3wytKrey6lbcgQE0L2SYjaOR2ToO5AFZkWIe7YuyBryim5R1oqZYVebjqiR9tWOn7PI7d4dC11LFuLh1k2r8Su4JqWPoImkwtXijEerf1lURVqkQQCpJdodSu88HBiN1VVS88tfB0aJEv9bMna5V1roNakvtekzpLMmapkPerYDcYIGYv20Twimhe8jBSOHnsag==
Received: from SA0PR11CA0039.namprd11.prod.outlook.com (2603:10b6:806:d0::14)
 by SA1PR12MB7341.namprd12.prod.outlook.com (2603:10b6:806:2ba::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.44; Fri, 9 Jun
 2023 16:18:13 +0000
Received: from SN1PEPF0002636C.namprd02.prod.outlook.com
 (2603:10b6:806:d0:cafe::8e) by SA0PR11CA0039.outlook.office365.com
 (2603:10b6:806:d0::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.27 via Frontend
 Transport; Fri, 9 Jun 2023 16:18:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF0002636C.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6477.24 via Frontend Transport; Fri, 9 Jun 2023 16:18:13 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Fri, 9 Jun 2023
 09:17:57 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Fri, 9 Jun 2023
 09:17:56 -0700
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Fri, 9 Jun 2023 09:17:56 -0700
From:   Jon Hunter <jonathanh@nvidia.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <patches@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        <torvalds@linux-foundation.org>, <akpm@linux-foundation.org>,
        <linux@roeck-us.net>, <shuah@kernel.org>, <patches@kernelci.org>,
        <lkft-triage@lists.linaro.org>, <pavel@denx.de>,
        <jonathanh@nvidia.com>, <f.fainelli@gmail.com>,
        <sudipm.mukherjee@gmail.com>, <srw@sladewatkins.net>,
        <rwarsow@gmx.de>, <linux-tegra@vger.kernel.org>,
        <stable@vger.kernel.org>
Subject: Re: [PATCH 5.15 000/159] 5.15.116-rc1 review
In-Reply-To: <20230607200903.652580797@linuxfoundation.org>
References: <20230607200903.652580797@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <b24cd0bb-0311-49d3-9e06-f0d1fe33b000@rnnvmail203.nvidia.com>
Date:   Fri, 9 Jun 2023 09:17:56 -0700
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636C:EE_|SA1PR12MB7341:EE_
X-MS-Office365-Filtering-Correlation-Id: 1dcfd24d-a91c-4179-26f7-08db6905202b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZroK5B/yPx3GHQ50EE+i8fBYSyQOobgb2QLexXZZF+5dxdTUyFQTeoAw/b2ilrjbua557NMD9cEPy07S8BwO/gfam5n+FZoI9W4YM/kIvrDSr0+N0zynIa3/tV/OvNSR84VDL/ec9AfOvsQ3PN95MV/L664qG1OvxGO6+sWLcSzB96WtruNG8Ihn/h4/nxjuB/JsMb5Tr5ITqPppogXWXJVH9yhl31N85qzw0JEoSCyu5eJvTP+JqFRFVlzKklkknXFyDEmitz3ZTQgAaVMR4w33cquv0Bnpea4LK1iCsygHf85Kq7R5s1LzMOgGlmNEGoK3FgBtpgz5kyhtL5uSygQCaVts/uaEkWPww7IFkJRZkHcteJhBpGyjcXwJF9ZN68+nz4qbcMWuwWHK4gCpcBNF+fakRBr5QC6jKd+VDmzd7DFOwBqZwo4DbnY2IuNv3dfQ9h522NWZMCqmaJBhTrvY2W1q/3gHUvRm9oEIYP/VqIl7TlXBlTL3Nc0NIU2Y1CqYYfxno9y4BFqVjyLj4W25ej7tQQWW0F6ehEa43jWy3d6j4CxDI+z86VeC+0hgE6K6bpb8yK7sCjzpinHa4xYPt5UvKVWrfd0WHyFlb9fP7z6nsuHZsoq9AKo/8cJWrTdgNVGLXFqs5/NrJ4Pd24DgAkUGchp4EnyO3JxC04rwsiGCymfAKbtREpBpgLbqlrV2t1rqIuVqu9AZ7qnAPH/Xgi0b3irfgZBkvkzVKXx3pEs0SbQt/0VFZvsAcPL5renFKmq6cSkLybddDqzStFiFmJoTojQbA4oPbYNNN2c=
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(346002)(376002)(136003)(451199021)(46966006)(40470700004)(36840700001)(70586007)(70206006)(7416002)(316002)(6916009)(4326008)(41300700001)(54906003)(31686004)(5660300002)(2906002)(8676002)(8936002)(478600001)(36860700001)(40460700003)(966005)(7636003)(356005)(40480700001)(26005)(186003)(426003)(336012)(47076005)(82740400003)(86362001)(82310400005)(31696002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2023 16:18:13.7259
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1dcfd24d-a91c-4179-26f7-08db6905202b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7341
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 07 Jun 2023 22:15:03 +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.116 release.
> There are 159 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 09 Jun 2023 20:07:31 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.116-rc1.gz
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

Linux version:	5.15.116-rc1-g00621f2608ac
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
