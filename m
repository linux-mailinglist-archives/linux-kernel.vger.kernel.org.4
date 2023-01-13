Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E3FD669874
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 14:27:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240584AbjAMN12 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 08:27:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241411AbjAMN1C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 08:27:02 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2087.outbound.protection.outlook.com [40.107.237.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBA20736FD;
        Fri, 13 Jan 2023 05:18:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JxyADPuqJGqx5hjgKcu5cxdvCg1u2RuwepQ5L3c4DadcHbyl8C+fJ+20gBtGGdgSibzKhpGnJlhh06uOYl1lssuVlCe6CHJ3mgSGMsOaWtME8n0hGFu9Zo5yfxY6bWitshoFPwefxUJRVa9aqOT4ozF9i1tCH0I4cVAx2HyzrM22gG74kQOCh/OLRGBzXwkbCqFSgJmMQnBxu7xvj1lAuvmh3XRvEZ/d/5eAiR9ueieY35EQ9mAU16/kVmnqiGYJrbzyagvOABskFJOUGKNt5kOQy/K5hxDfMwTCPOoXGL05aUDOkW4n4UaoKvVIlB8Yv+kpVI62xqdhzrjzRTaE/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cO1al7zjvmQQMJeexHhTn2NQVGSX0cdB0sPkCZK8eR0=;
 b=QBsQHNgdggDgWkeF9oBiS643th5zOa1Ifaa0CNFooE3bK/PPYrEtYlM9W0Kvjw8suCpetkzkpJ8OrD6qdCEm83HSkwwYmAMQ6N/UAXsh+94WocXA0j6PqMz8nHtPIfV3zAoWBrB/t04RMvWvWI18wDVYqk5tfEsMWGWfqTP/DHbXqKe95nkR6OReEt7PLh/preMb3zbN999kcT5xNLWcPmIdtVy1flwH5T8IFq43tRojt61BPn0eDktuTkk9kJjw30+FHEXY1hevriPvii5kPg92oVTEZbWtgYncu21hJ0fu/sLy6SqFUnclZH+4zHHpKbb3yD3kJSqyh75GjMcwGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cO1al7zjvmQQMJeexHhTn2NQVGSX0cdB0sPkCZK8eR0=;
 b=cPkrMUyU7sNiPx8+J5XNm+1BVvUKZaEXmNDfz04lLTh1/67W+Wii/In9Kndgya0cl2cm7xufLyfmMVGtZk+tH5us94R6IxkDnedOduiWlTy+bIDTKl/FQQt2Nn/SANhYZIbNqqJRZ8OIDEyb3elvC0WdN4VFlRLPhJKc3LMlXoRXmzVcjbTUvpplSp9ZPiYK+/ZGN9gbgwwyos6TNW2dxNGivyFXwrGTafLgaU7LiI5QVGxP6/LgEIP+CDDDvDwjsrYkgqYVXTcu83tTK5lRPmlU2+OpTf+jlyr00tF9V8GsZloD25nYAMiQRD88Uletoq8jHpH3My13ehmpVzeZmg==
Received: from MW4PR03CA0043.namprd03.prod.outlook.com (2603:10b6:303:8e::18)
 by MN2PR12MB4406.namprd12.prod.outlook.com (2603:10b6:208:268::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.19; Fri, 13 Jan
 2023 13:18:11 +0000
Received: from CO1NAM11FT024.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8e:cafe::1c) by MW4PR03CA0043.outlook.office365.com
 (2603:10b6:303:8e::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.14 via Frontend
 Transport; Fri, 13 Jan 2023 13:18:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CO1NAM11FT024.mail.protection.outlook.com (10.13.174.162) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6002.13 via Frontend Transport; Fri, 13 Jan 2023 13:18:10 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Fri, 13 Jan
 2023 05:18:03 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Fri, 13 Jan 2023 05:18:02 -0800
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36 via Frontend
 Transport; Fri, 13 Jan 2023 05:18:02 -0800
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
Subject: Re: [PATCH 6.1 00/10] 6.1.6-rc1 review
In-Reply-To: <20230112135326.981869724@linuxfoundation.org>
References: <20230112135326.981869724@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <598fdcfc-9517-4ef6-bca1-8a5062af6209@drhqmail202.nvidia.com>
Date:   Fri, 13 Jan 2023 05:18:02 -0800
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT024:EE_|MN2PR12MB4406:EE_
X-MS-Office365-Filtering-Correlation-Id: d4614808-2be2-4b63-d132-08daf5689e2f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xqtfNEpKRrRQpJAna/OrYBrqZTmYYofo9xSTBtx+NsPPRHu0JtT6OHgi7AKTh6fmLzsdvrJpMRuq/3Y6vLzEu8LGslaTaN6qC62KlgWcFpF/HpcsTqAy8RuGIyLLXLpFWrAfUcbdzttmag8jxHX3n04VkNbnGomOeX29mjFP0SZAXp3oOrRd6nGGgIHey0JGqwkafwi7W/7QaXyY6ZipfgD48/hw/ZQ8fr2XtVqUg8gHczzAnDienI322HMYrxCS1pNEgSDFH+XpAH4Y7QvXOqWh0u8skdoutB3k40YkP3hseh/gWmxuV8Vn3AAvs3XAz42r0NYVT9VDlyCGO1RwxsUesHY2MMWfdWLFlMQGBuBg7WqxjzMs7+jFifhS5UBvKao0yoIHBB9J74XQNSFwhwRKVjJBMR9tiNmzsRi7NpVLZ89y436+A3wkZc8xcIX+N73we/aH0V+BOxtqJm2y3aM1CfvYi7R8N+e3CC7gdn6LoNwytHvgDLfpYu40i8GPcRmJArxnKCdVQl4Nsry6fWYZXz9OxMxkuwApcKoV53DoUPOg6K7gntAJvNlQydWlhLoQ+eoVBuj7+ok7/ZMX8sNGvlckQUhYOpKA7FV3IKoWiHukM+VJeOZyyaQ0uV+XzHqrYKFrKIfyCksaGOn+g782xK8NdtQz40zeGSsOVtgqDy27avp4hrLdsR9IhoV1L6mFVeRoDkuHaLCfP07f5+7rGfj9j7/32ogDHW2noyAwKFiHAbz03zuBi4xeKNyr+xJhlhuNW/B7uEZJNYE/4PyTzUlsbCxWS1uAHevVjEY=
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(136003)(346002)(396003)(376002)(39860400002)(451199015)(46966006)(40470700004)(36840700001)(82740400003)(31686004)(6916009)(82310400005)(54906003)(36860700001)(7636003)(186003)(966005)(478600001)(31696002)(2906002)(41300700001)(7416002)(356005)(40460700003)(8936002)(5660300002)(26005)(40480700001)(316002)(8676002)(4326008)(336012)(86362001)(47076005)(70206006)(426003)(70586007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2023 13:18:10.4746
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d4614808-2be2-4b63-d132-08daf5689e2f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT024.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4406
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Jan 2023 14:56:21 +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.6 release.
> There are 10 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 14 Jan 2023 13:53:18 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.6-rc1.gz
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

Linux version:	6.1.6-rc1-g5eedeabf82ee
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
