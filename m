Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D02E68B7D2
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 09:57:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230008AbjBFI5N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 03:57:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229960AbjBFI5A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 03:57:00 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on20630.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe5a::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B53131C30F;
        Mon,  6 Feb 2023 00:56:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QsXhwPE74Rel0CKpkxQoOjWhY9XrssezfoVoFlVfCIzR9j79/WZj3Pdw1Qg3t1QNGETRED81wlytcHFv4+PQu8xXmQyovkkif8OcO6EFAS7ZyfcfjPY7SONik3cEKSwLLfIV4290qEXdqCAM707WjmhZW06ADvoqR4irxhqmyn+Izn2nNas0EYgCjXnmYa1I0APCrrvTljUSoD3nXqkdq9PwOPUpHV/SoeUqfNnHqn+3wqk1NsgOZfTInHoc7RBpeHaSLmb2KiQyzl3rUuJh/jwfU+y6OHS3HbAgkKLNHrHhuXsJuSqaXN1iKWeZbBLOHNYwEJ/NRiVzylDbF5LT4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZzkYKrsXhwH0NVEfUADT4puwmOMmV5AgKBDyvFxQ1K4=;
 b=UzD0IGXAwgGvEMLvjddgjFF22NcvyMFwCqe0EhbSduArLdga14c3ma3vnq/5v1kXPqf03lgLusUo1tajMlbC972ZYglXYTpJp3quyrmaZCB3S9/++qv6DQjKt34pqnO+6SEfH38QTBHRljh5LMikW4G7kZZ0azBJKzsK/1pwTGbZVa+/xMaXbGitx2n5G5aUB4gNVvdG06N+zVC0JjX+F7j0UWzvC6S7/2K1G32n+KWxyHVkz3FFFsmbFzozn182egKiBOAHKDrB2vZ/ovX7Zg8O8avXnMCQNohHjS39bGJ/O591Uhv9hLjh8Kthr1jZgn7li6pP6wN3C461JJsCiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZzkYKrsXhwH0NVEfUADT4puwmOMmV5AgKBDyvFxQ1K4=;
 b=s9KZTlYmkzKs9jDV27gsikxF913OYS/jGcn9Lexpq/UrMhrNFouyy5yTx30j8YzUGvEN0A5V1Y1bhIf72ldXzg+8nOLFOGQwQ8t4w47DLGODguqVkG/DtzibFt5VJ79Rj0Mk7bPvY8Hb+7DgbpU9Td0XzIMC82NYiDce72V+K/fr6HP3IPxB9c4a9W4pGBm+ScskKkJy9Ne6SmRQjYN7EYEh3iH0/4UAqN0slPoWgLI7DOPjtD2YekX7FG5DZoKSPj+f3DT4cyABqKDGxcI7B619WkcDPAMBESzrC3PI8fYprfpdezLHbvREtEwfJo+NO4DQ+Lv+MHXxcbw71KNFIA==
Received: from BN9PR03CA0891.namprd03.prod.outlook.com (2603:10b6:408:13c::26)
 by DS0PR12MB7747.namprd12.prod.outlook.com (2603:10b6:8:138::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.34; Mon, 6 Feb
 2023 08:56:57 +0000
Received: from BN8NAM11FT028.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13c:cafe::a5) by BN9PR03CA0891.outlook.office365.com
 (2603:10b6:408:13c::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.34 via Frontend
 Transport; Mon, 6 Feb 2023 08:56:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN8NAM11FT028.mail.protection.outlook.com (10.13.176.225) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6064.32 via Frontend Transport; Mon, 6 Feb 2023 08:56:56 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Mon, 6 Feb 2023
 00:56:47 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Mon, 6 Feb 2023 00:56:47 -0800
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36 via Frontend
 Transport; Mon, 6 Feb 2023 00:56:47 -0800
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
Subject: Re: [PATCH 5.15 00/20] 5.15.92-rc1 review
In-Reply-To: <20230203101007.985835823@linuxfoundation.org>
References: <20230203101007.985835823@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <13e53ff8-b210-43d4-9048-6b08ee5067a2@drhqmail202.nvidia.com>
Date:   Mon, 6 Feb 2023 00:56:47 -0800
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT028:EE_|DS0PR12MB7747:EE_
X-MS-Office365-Filtering-Correlation-Id: 612385c7-ada6-4ccc-5928-08db082019ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: La3M/tDdvoLY6h5gxIH21LBKCRnH63Xhc+vQ7OnrHo13WL465JfVSLUR5c8oHN1zJy2LR1SY4ULTpIadlmfZTguo4DqZpJNzwg131epbHGs4BsGG5NpR9oElJJ/yEHSmfolPFTB1I7c0QB4vNVmeYtXgFTgVTMaUivtt56QS6yB2Jbp198tXDqkdvDhe18t+gdcRIpAEpZI0BOAgndf0dmV5MOBQITw2Fzme9DXhbeHpSjTC9UZXeQkeu9IhAOwRxJ9w/wKEYhvG5Ca5gvGC9Fc13XTu1WUP8SqGTaNKMB9lHiSYmDhtVYNhHNmNGd1Qw8UaZFMc/he+9grWOl0+WxcN+G/jrAfIOWx3f+mNUAyca+H1N16u99fk68gy/aXgWOFQ9p8m3hO66CyuL4ZZg3UY1E9t7Bp0Vr9EjitUhk3UGVg6Xg2RXpEjpy2Hi/KZZ1/GuePHOg23HyUcikbVujNJDzh9JtnTNVzgLnyBVK0n6MHJwcCbMvKlIQN/YNq9LbL0Ue36bXgJnQbbogHhWy6dSesPEhA3S1Q7RqrO/gBPXZTG6bDapSlemRvhkcFfEyy8OydU5UVqQ+0UoeCBasvzYQw7FsP9nuVNCK9uSQaIbcV3bSFW9S2vsM5k4vJ5W6TaelsCsz9nm1ieHftlsKgp+FZuzsBR4UEr3SWIZGlmcYEzfXMl/UM8wYEDOdwxbHvMaRmRp81cftgL5fuh24/tzF8dG6qeTS7pOZPKphJhT3tR16FxkJUsKa+7T57jvaHdVH4jzq8Ai/h2IN7AhAUVofWONJJ1iaZmoQTfuCU=
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(376002)(346002)(136003)(39860400002)(396003)(451199018)(46966006)(40470700004)(36840700001)(31686004)(82310400005)(47076005)(40460700003)(31696002)(356005)(40480700001)(86362001)(7636003)(82740400003)(26005)(36860700001)(186003)(426003)(336012)(8676002)(7416002)(966005)(54906003)(316002)(70206006)(4326008)(6916009)(41300700001)(8936002)(478600001)(70586007)(5660300002)(2906002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2023 08:56:56.8118
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 612385c7-ada6-4ccc-5928-08db082019ef
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT028.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7747
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 03 Feb 2023 11:13:27 +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.92 release.
> There are 20 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 05 Feb 2023 10:09:58 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.92-rc1.gz
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

Linux version:	5.15.92-rc1-gd8296a906e7a
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
