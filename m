Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1450066987C
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 14:28:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240696AbjAMN2H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 08:28:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241202AbjAMN10 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 08:27:26 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2077.outbound.protection.outlook.com [40.107.223.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA3B6E40;
        Fri, 13 Jan 2023 05:19:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GhArSS/uIgg4DI7GL+/nP508cwU/zFMvt+LKVZNGP4cCNhXxbnHPXK3t0JxUp5+Cn247TlVlfJB80uFXOE+MT7Fupu4ZSp+ilWXMcIzRzJi0jKXIdwrU551EPtsnPKACJmo03UTu9Qgr5kxumEAfMWyxsPE4eSlw8kk7dYHyCqmtjLbO4updlk8FhyH9+KOSM9uJ9R+b+mdpN0imMItuIyAbV+i8O2UsnzL00920hcXu+TloQ/CqbnwnWu1juwY5wtwsJbwMewc+2TwsH8lBJal1knk1Lqg8VTKYASXoOjrk5kOIKVk9rBUuas8d9/nNxM4d9ErQ1JpW6Ssc4neL2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hF0L+gEdeD+olo/Uk1wGh3I3OXBZnkm3F+o8O4vrK8w=;
 b=BBHw/4b0dkfQfTGGj7jcOMiawv22a5te0DmhJZCXgx4lWx6auQ8ogvZ6DtZU0x2eeFDaDLLaOuzQ1ADtw6ik3G9YvXQx7UAzJTpP6IZnfu/BHHUo2tjndWehlKcvDHdv2oC5mOx4aYMUvjlmA6h+VTaShb9UDnuN/5vXgZAjRTIUOtSDJiLC8vjUwOx54L9o91h/dmoKw+yOD7LCE/+Nc71235zyLeqaVDxwTTkEHI7YJc+za4+uRU4QMNaUP25fVGUaroKyPBltN3+axMPfI/K6+jdHH8Kir+lV4YWXmzYCbkXhcMFq4qfnsLqj1iKZKrPQMOW8PPdG0+7cLRqdFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hF0L+gEdeD+olo/Uk1wGh3I3OXBZnkm3F+o8O4vrK8w=;
 b=d8NID1ioNriSVUTc0GAtPk7N0UnNkCKFa9rUax2kaaNnH9xE9aQNW6CKIkgNZQr4mVhrJ2UTyDX1/D18kI9zAtW9EaPEWt42jToupazQ+kTxMgIoDlw+DR0G7lrlpQ1z7ZVjd1RJhTAUa7UN0FkabMG+oYoLlS7WngunXyPhXzUD8mC2o85Q0+xTEgXle58sgAY64E5iTp8DmWodp5F8YCJc7dJ6vS337+ZIMZTrwduSfOs+tj3ILhjJz1UkJpA9M5rYbym0+0PkSMthG+AHzX/+Fym98KYyltrJTcqiHKcAnIFGRqOIu6PKTYWOJRkKKc2GaowxcbE7e3maJ37dxA==
Received: from MW4PR04CA0238.namprd04.prod.outlook.com (2603:10b6:303:87::33)
 by SA3PR12MB8000.namprd12.prod.outlook.com (2603:10b6:806:31f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Fri, 13 Jan
 2023 13:19:52 +0000
Received: from CO1NAM11FT078.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:87:cafe::f2) by MW4PR04CA0238.outlook.office365.com
 (2603:10b6:303:87::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.16 via Frontend
 Transport; Fri, 13 Jan 2023 13:19:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1NAM11FT078.mail.protection.outlook.com (10.13.175.177) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6002.13 via Frontend Transport; Fri, 13 Jan 2023 13:19:51 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Fri, 13 Jan
 2023 05:19:40 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Fri, 13 Jan
 2023 05:19:40 -0800
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36 via Frontend
 Transport; Fri, 13 Jan 2023 05:19:39 -0800
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
Subject: Re: [PATCH 5.15 00/10] 5.15.88-rc1 review
In-Reply-To: <20230112135326.689857506@linuxfoundation.org>
References: <20230112135326.689857506@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <b2f1d7ec-7cc8-4435-8547-997500d995e4@rnnvmail201.nvidia.com>
Date:   Fri, 13 Jan 2023 05:19:39 -0800
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT078:EE_|SA3PR12MB8000:EE_
X-MS-Office365-Filtering-Correlation-Id: 837bef13-6f39-4330-da99-08daf568da7d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fY19YmLfJyDbQ2mcKXy03Wuq8dNodt/c5F+hRau8qUrwFqFtFW0aD9wojfIKH83bnbidIsnBZcPFbQqvVOxW7YXBE8GwyjxSD+ZsehBBUChoFSA7fqKJ+2KvOagtK8d2CYQzOt5CgTPqWTThti0gyicHuBMRM4jgfsQUiGVrGrzu4ut+7BqoNLSRfUdLsnhXpnQalzqVyoCOCHJGEBqHWrmCKASqKxNFsx4mvLVuaxuhO6jatFxxb3594TmL2QvSX3Blek6jLE38gS2YXt1zsMnVU3MQucQW3xHnqar/n82rjiUQBJhNO1e9x14XtL9FjSUA4qftasM1iBWYwUHZjANj7bvXusHW1g4McPO/yhQkIsYtO2AKEGnA59VcWYob/iu4hOlbn5IAONbXxAPF5C/Ip+pB3sjqERibygAzKwHeLME0gOxy0i+e/BXOC93hf2r+r7URBK+kYeZYds69ey069+jz3HjYPgGS/MAj0uVvuRTHZXw6+e46B7i3hjPDUM+6LbpcOfYnr3p4oDruyopBH2nCcPZ4R8l+0MwZXGwoBKJDPVwu1QARPL4i0uae4hKTNUI6Qe3l/I2Dd3QtM5NKOsUFCFp2hVrS9rriRCWctQSORUT0h7DMSB0fZTOEKgD2hp6vwQHFVh89rLOmm+JcJoxEIDfRoV3wg/ubQ5A+WZMqg87LPDAdXGIRMhuMWkJ+sejtn/2eW4lRw6eXptNO+Sa0LwkCB+XOP5Iz2XfV/o7SOczsakXG0i9ZxwdKhL0/uBlFIDrVbV5TC+fMQDvzdfuHhEGhnuVNSDc/d+A=
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(136003)(396003)(39860400002)(451199015)(46966006)(36840700001)(40470700004)(31686004)(966005)(5660300002)(47076005)(336012)(478600001)(426003)(54906003)(26005)(7636003)(2906002)(40460700003)(186003)(82740400003)(8936002)(41300700001)(82310400005)(4326008)(7416002)(40480700001)(8676002)(70586007)(70206006)(31696002)(36860700001)(316002)(86362001)(356005)(6916009);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2023 13:19:51.5869
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 837bef13-6f39-4330-da99-08daf568da7d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT078.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8000
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Jan 2023 14:56:37 +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.88 release.
> There are 10 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 14 Jan 2023 13:53:18 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.88-rc1.gz
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

Linux version:	5.15.88-rc1-g14a059c00cd8
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
