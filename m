Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D54E729FF7
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 18:18:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241984AbjFIQSM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 12:18:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242103AbjFIQSE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 12:18:04 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2088.outbound.protection.outlook.com [40.107.237.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E3A63A8F;
        Fri,  9 Jun 2023 09:18:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V32+jC/MT5wKs+T+M0S66u2AIGLfNJogICOMM2hITN3aJfE0CQ4nmVoUdnpN/VVJzomAtY+83KCGDm4VMYKNa/QmafMliRPqDGA5achviFZUdcinUhboYFAYmpXzdgCgohl/cvc26fLDw0nTeBWD5p3340yLgPWJ31MaOvcGwqG6Wlw4OwkBtsVdQpyjKQ0T9llC4+CELRSnsZkxs3+NdgOB2Kt83RpWe17jPsEwqvrufU4Dsf9KVbgJgTZ2YncGsHPSNTJv2GMxByQZcDBxkrBxhHd5438CjJl8AzDiQ1506EoRE02n7ysglhnT8R803WO2G0leBZLi1WFU4NwG9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nIzRxEgXPObQtKnDmOhUbUuCFQX+mxaPRezD4h9kxfw=;
 b=Kjo2lXsARWXrY0lDBu8n3bwy3Uixk7vAxlVRoQlbBu5UcpRh5sxxt9ztoevXpGlt3kxey4kJJ5pNOZHzJqouBqZ2rMFW2Ziq0oPSx4+txEhtidlw9efKt95BpokbYvnI46SqVVBfUKfX2HsrbH31L0qHTZ+elX46Fffh/RZUDCBQNcmqeQ4W+CsTU9cFx2APKMX5fIU6/q5UI9x1fKOTntyZCeK29/vIgGn6wLHBMuqQidolNFDFQGEMRvtgBjuOyl6hpE6WQpO2CcCXKVLuKaKeCfbRy48hIc09oTne6X6com05WIOWa33kXhLQBP3smAC6rGU7i6StMX0eqHpo8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nIzRxEgXPObQtKnDmOhUbUuCFQX+mxaPRezD4h9kxfw=;
 b=Ml4VJyXAPlJiRTiDUgh3cwhlEUU8a4vKU85lrB6h3E5B7MH6HaTPOcRtrfG2SNcPqMz2bD4eVsjtgK1w7qNMcSeI6+nEq59xG1tk9lhwHpkUCGaLk02zbBdaFERNZtpmIvtrWXt6UVbjrurz3FWqvAenLlKM9WAJ4fskdbGdm5KXYckDO8DyzPmfndLQWNshrN1t2uwlsFetx3l5ea0ZwMizHiU2TwEn0BnsbyFvpA1XbXQdTwAGv/0/bYGZMzN3N6nHuuPCyGgYyhwZWhqR0SJnqy9qHejyfta7JyjA6yqaB5Oz/gnWRtVNn4phLeUU95T3ejVS18mESHI4GDM8mw==
Received: from DS7PR03CA0137.namprd03.prod.outlook.com (2603:10b6:5:3b4::22)
 by BL1PR12MB5031.namprd12.prod.outlook.com (2603:10b6:208:31a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Fri, 9 Jun
 2023 16:18:01 +0000
Received: from CY4PEPF0000EE33.namprd05.prod.outlook.com
 (2603:10b6:5:3b4:cafe::d4) by DS7PR03CA0137.outlook.office365.com
 (2603:10b6:5:3b4::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.27 via Frontend
 Transport; Fri, 9 Jun 2023 16:18:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000EE33.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6477.13 via Frontend Transport; Fri, 9 Jun 2023 16:18:01 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Fri, 9 Jun 2023
 09:17:45 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Fri, 9 Jun 2023
 09:17:45 -0700
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Fri, 9 Jun 2023 09:17:45 -0700
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
Subject: Re: [PATCH 5.4 00/99] 5.4.246-rc1 review
In-Reply-To: <20230607200900.195572674@linuxfoundation.org>
References: <20230607200900.195572674@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <1532f7e4-4bc7-4bf3-964e-24c2f92393b3@rnnvmail201.nvidia.com>
Date:   Fri, 9 Jun 2023 09:17:45 -0700
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE33:EE_|BL1PR12MB5031:EE_
X-MS-Office365-Filtering-Correlation-Id: a71b36ee-6e92-4e51-d817-08db690518c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HZpQIfvHMo8niW6C50g04kHRUkW4mm5wb7u64dNxPlQMfwnHeAL8GX7RlkciCrmRCu4pIzqrn2GHUKPnCY6e6oJIwSR2r340v8wE5gMtoECsEQXH1kppXL2c+/Uau0i6hCEBTZzfIUnlGUmC2emHB89zf1bNj9OYTByEh3RdcwqSd/ka95YOgXGFpJAxGjEs3Lk4e/zJHaESklJ+FGu61LZbE+8/WS0BfGSvtuZxnM7F99L5L34ivTIl23q1r7FM0y6m7P53a6sCCZLW6zwgKDN5+jgAqE+8BYE1wSlSx9dNoSeM4pfDRsthk0I1oqFf4ipMj0spASuJ8oNTZbqWTy8yDFga7q89Kci4/vBPI/RrMTbWhbwAQn17/TlESbZOKHAmfGAIUwEvl7LW6Vc3/zS/aSc3cgikcdJBY33wF6zRyjy0l6dsRs5VEWEw28Fzksd4VeqPsK/JhiiHmnJadE4xiqOrHg24Ve2yiqzgEoUeOejxo0dS2i70qEbTZzZs1meOwp7JkhWpNfhuEISaJXHLiSa57MlORzt/vCFYeesgkpttYObyRSQQjO26orQ4+lDpTP4BNlbxQCbFBjCvkjkpdtZoGZ7dIETZ6EvbfsDUj487vSDbeS6HdS6aS6zs4UP4+Am/VLzmqVYTbGRZsuftFoETTWpCrKm5akik7FBYjiJjv1MBW99rsaQ/gTKqa0P/QqhCJQaVV8D69f+R3eHmp+E8IUWn9Rnr0PL2YPkjpfC2uCrN7WJfDgMILkZFJDiz7x+Oy3+GbrSpNdg6sOwD0tQQ3RYrYpdjhX+PRKs=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(39860400002)(136003)(346002)(451199021)(46966006)(40470700004)(36840700001)(40480700001)(40460700003)(966005)(54906003)(478600001)(82740400003)(356005)(7636003)(8936002)(4326008)(70206006)(316002)(6916009)(41300700001)(8676002)(70586007)(426003)(186003)(36860700001)(47076005)(336012)(26005)(5660300002)(7416002)(86362001)(82310400005)(31696002)(2906002)(31686004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2023 16:18:01.3597
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a71b36ee-6e92-4e51-d817-08db690518c9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE33.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5031
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

On Wed, 07 Jun 2023 22:15:52 +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.246 release.
> There are 99 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 09 Jun 2023 20:07:31 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.246-rc1.gz
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

Linux version:	5.4.246-rc1-g21d8ae1f2aa0
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra20-ventana,
                tegra210-p2371-2180, tegra210-p3450-0000,
                tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
