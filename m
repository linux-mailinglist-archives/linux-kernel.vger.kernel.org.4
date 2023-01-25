Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D4CB67AFBA
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 11:32:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235611AbjAYKcX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 05:32:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232306AbjAYKcN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 05:32:13 -0500
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2042.outbound.protection.outlook.com [40.107.102.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF7BC4617E;
        Wed, 25 Jan 2023 02:32:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HCN+nVXB0VUx7BDuphjO0HFFb44TQcZ/lFJ3xrqksZNK2yjMl7zD1VoHL/EU0B2CW1sXPRaU9OY3XXLo11shGy5UNx6Icm8VatKzACAJkhnElLPTvKed5jNkpSC+gAGXt7Lv0AQTGozh3Ryd9nqUcksg7BHBa5N8U/cXSbW1Qzc6iDL6hXD/rM23jwnxvpyzI7KD5LxyZe9Z9wDs9gNf2CpU6sz4d30kA6UGqTXID4lAh/0lNedfLDGq6/GkHtR7gqLkP65ramgCEZrARW+I7MLOYf7A3O48FiRhPkxQAzkyHzclMaL87+JZlSGkItSI9F1Wt2kPvoXVbn3Rx4c8HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xAurrTbbSvTtrcHPtbeay0DFllA34yjk8trlK+LWUEw=;
 b=GhV4jmcFOkhbw/zaRxoMM0aui/5PYr05jBsP9AE3zOS8SShTXwf3UEvssneJRo6WHaN9XshGPycmZCT4CCLEjbOgAoySukX9JW/gX5dgToBfggyBBOO7WSfJe5a8hFDdLhvXAUwE+hx5/fT3iSsBGbKHXrZlRtaEPIwGx5LDeplCeypu3Qg7Cxns33AOPmtUdkjFnX6VPsMYUTIWilButM2dasC0axZqf3Z6SXZVOXcPEAo3q5P+breSmhZ4qT/1dSdkZGc+5A0UGbt1CV0l8a9Tk+Wbsu9TYpBadpN/DCa8RH7QbGf3UKgNRZhaAzY3Te/jY7SYWrAxMLlFcX/Fwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xAurrTbbSvTtrcHPtbeay0DFllA34yjk8trlK+LWUEw=;
 b=kdZsQQGmKZf0r3TT1PzNbYQfM4HS7lMdrgvSWT+OJjV48NeOpqk+D0TB8BJPOh9oqeCQ5EzQmJtIGdT6abinvg4poDhjhGzLoysl+yZ9Y5oxhBnc3dYxKBgOCoRHnbzf69GbXz8RGbHsWli6m+dkxqYBbs9bWsKAuehoN2gk0iGxAkeYolKUO5f7DnvMFaAnpznfsDxZTn9PisYigABKKP9pKdkpFifXYUOhYzItVHCjYdPDr7SUtBjyICDrRtVzan+IBUTntidjfZfI+EPkxV52cL+/v51i6xR7/HJ5+boj1FRxjp/qavmF/6gAe5ituSktb0c5mSpiQA6g6oqw5g==
Received: from MW2PR16CA0015.namprd16.prod.outlook.com (2603:10b6:907::28) by
 BY5PR12MB4226.namprd12.prod.outlook.com (2603:10b6:a03:203::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.21; Wed, 25 Jan
 2023 10:32:01 +0000
Received: from CO1NAM11FT020.eop-nam11.prod.protection.outlook.com
 (2603:10b6:907:0:cafe::3e) by MW2PR16CA0015.outlook.office365.com
 (2603:10b6:907::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.21 via Frontend
 Transport; Wed, 25 Jan 2023 10:32:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CO1NAM11FT020.mail.protection.outlook.com (10.13.174.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6043.21 via Frontend Transport; Wed, 25 Jan 2023 10:32:01 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Wed, 25 Jan
 2023 02:31:50 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Wed, 25 Jan 2023 02:31:50 -0800
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36 via Frontend
 Transport; Wed, 25 Jan 2023 02:31:50 -0800
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
Subject: Re: [PATCH 6.1 000/188] 6.1.8-rc2 review
In-Reply-To: <20230123094931.568794202@linuxfoundation.org>
References: <20230123094931.568794202@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <c189c19e-8cca-44c6-8d9e-818f3683ae19@drhqmail201.nvidia.com>
Date:   Wed, 25 Jan 2023 02:31:50 -0800
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT020:EE_|BY5PR12MB4226:EE_
X-MS-Office365-Filtering-Correlation-Id: 4cd20b94-e8a1-4a34-3996-08dafebf6507
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HWVB6fWnW4w2h+mPIrVu69Lj7HejL3COyuVBoEKyRAOTiBB+EfIrCbxPBK+1APm5NtiKNB0f8wPr/jJUHfLyU74Oox8/DUbpiHzmjqzL6LwUiJnHmeov1Am5hWV9NFdqiFI3cPejTj65emadc1naqmdR4yMtlbqltubVPwEp9wEln4Fvxnga4ov1lrVY7od+30KKDI0RXlyzYSaxR7iyLHnhZTB4T4o9D6e72PGoa9pTlZi0qMssV30UDmE+Gn9N5l2uzWPBtUY5I4mOdtQMM+aC7oFZEx/b4yLXSI83UM8MDLYksPN9NKtVsKoNDamjDWgS3pef6neFcazdBcQRLyyZNptK8821Jeav3NURyiC34dpsX6YxDmpkJ5fEumIDWSOdwHeINXst2o4G7nzZ0FWT4Vw2Mnl5zOyS2w2+A892Czk8oWjDQwZ813MopY5D1VAfWYVpOCAOxplE/txSxWwfgJ3w66ZzjFJdJ+fBt2HqmkvHCHPWKzLJsgEcInZhVimkio4kGiRFXU/L8cJyNffQSTQDlp6EKQBD1y0VxU5Jn5t82VJxYrS2XTEvem3qRS88J/qGkwWx14w2G9v+9K14lCFa+J3sNouUPu2dBA+Ep9nU964qAEVlW3oFeDHfCjEpy5EhBhd2+lixkskzxJlNzKth3bMVLDtAUhPXYKUwz1SKt2ZcSHiolJkCC5/k5cqFtkB+4ZOBYILkv6k5x8HW2UFAPVi5m/sjrvOMNOQr+NF9BrXl3++aMVb/W4wKffkQnUdwf0vGnl5ac9cjbJDRqhOaRFE3X8NRzzVNlVs=
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(396003)(136003)(346002)(376002)(451199018)(40470700004)(36840700001)(46966006)(47076005)(82310400005)(54906003)(31696002)(86362001)(40460700003)(40480700001)(356005)(36860700001)(7636003)(82740400003)(7416002)(316002)(2906002)(31686004)(41300700001)(4326008)(8936002)(70206006)(70586007)(6916009)(8676002)(5660300002)(186003)(26005)(426003)(966005)(478600001)(336012);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2023 10:32:01.2746
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cd20b94-e8a1-4a34-3996-08dafebf6507
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT020.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4226
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Jan 2023 10:52:24 +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.8 release.
> There are 188 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 25 Jan 2023 09:48:53 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.8-rc2.gz
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

Linux version:	6.1.8-rc2-gfca9634405d4
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
