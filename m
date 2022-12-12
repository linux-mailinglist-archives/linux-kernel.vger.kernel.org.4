Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CF9364A881
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 21:12:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233482AbiLLUMK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 15:12:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233333AbiLLUL4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 15:11:56 -0500
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2086.outbound.protection.outlook.com [40.107.212.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDCAA17A8D;
        Mon, 12 Dec 2022 12:11:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZnaBZzZzEyVXwrD4NeMe//br1JGrKXzYSrA4B/SN5BOzPlWZaVN0Hww04ZhFGJ9q8wyUyMM/Lfv8zv2FM3YLZ7eMDZMl4vQlIJxj7H8FwE97s1biY/tfDChREkvdJ2rxzwQSpBJSv1VWzegPOQWo9/tnfd6tdNezu3OpBUOaOXYlM3XnnIcUj3tE+7KEBWhvZ7wale2eCvI22d/Ssr9VU/nldElOtYMwEUDTGevWZtaDWBdw/tpnXXIZyuN0sPfFcUxOYRHc8r6D+O62Gi4SP12zAJjxAzXR4wy2xXXtlHqXFRAL64xqY/5xyvECjImqplY7TZAb844URdBc9mEe7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DSx6ITGvu1V55nCXhq1luy2DURMzXA07g4rB1XQ+fs8=;
 b=nTXJhu4NpStqGpJkRKI8cEXoCI+I1RtfLp16QY+jaZqyiMmHjDvwH8pgTnLhYCFhnq88krsettvTlg8oXuJOuoja9bfi6WpRJnjKuO3W19ctQHjLt3PhCsHpuOFv7lcOcvszWHBv+QFtNkAKVdzSnfm5FXO4TL03FRU896bK+7BhZ8rBAXDG7Lu1o75ZYkvy+HDlo+JnsStLN2iiUJml+k+5zwr7vJmGCQ5z1GsRUqNWgvYjgGB2C5ZhWn6X6qRRVlmdegrDiANRYVkrklgUrWm5HlgnqPXGJHmGURfYWgjyuIdymEhnHwzizzNbwMBFn9eyfkwD6aDMM4x+5z4Hiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DSx6ITGvu1V55nCXhq1luy2DURMzXA07g4rB1XQ+fs8=;
 b=XBCz9B4nPmQ7oZ20h05TphjULMCI5SCe34rfgvVImTrodcghoCWbjTuj4J1TzL3IRGz/DctVrXGHG8pPfaZcz3UD2jJbZS2Ta9hybksWM0yqhjBMu4UejMrgny+kyApsSn8NQoZC4sXyu7/C6UjNZv6On4vPBpvru4v6VgtEPY7aX7TTNPT2kUMNFx2PFDzsrF35AfkMBt3Qyn2lm+v3WqU9vVDUWnb3TJH1jfpukGVP0M76UY+VSQzA3nvg0JCEPRqeRFAPCzD3nUb3wxbbLYAwL+sc3X4QsRGj3ruaIMHZjZ1thNsO0Uh3TV6THdhefH7AiRmIgOzC/ItTZr0Bzw==
Received: from BN9PR03CA0775.namprd03.prod.outlook.com (2603:10b6:408:13a::30)
 by LV2PR12MB5943.namprd12.prod.outlook.com (2603:10b6:408:170::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Mon, 12 Dec
 2022 20:11:52 +0000
Received: from BN8NAM11FT075.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13a:cafe::f6) by BN9PR03CA0775.outlook.office365.com
 (2603:10b6:408:13a::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19 via Frontend
 Transport; Mon, 12 Dec 2022 20:11:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN8NAM11FT075.mail.protection.outlook.com (10.13.176.208) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5901.21 via Frontend Transport; Mon, 12 Dec 2022 20:11:51 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Mon, 12 Dec
 2022 12:11:41 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Mon, 12 Dec
 2022 12:11:41 -0800
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36 via Frontend
 Transport; Mon, 12 Dec 2022 12:11:41 -0800
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
Subject: Re: [PATCH 4.14 00/38] 4.14.302-rc1 review
In-Reply-To: <20221212130912.069170932@linuxfoundation.org>
References: <20221212130912.069170932@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <406c6602-353a-4630-bc98-8ae5c1d46fa6@rnnvmail202.nvidia.com>
Date:   Mon, 12 Dec 2022 12:11:41 -0800
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT075:EE_|LV2PR12MB5943:EE_
X-MS-Office365-Filtering-Correlation-Id: 37af3646-00d2-44c1-6a60-08dadc7d1bcf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8+IPRaLgvFgW/WOUATI9dSWDJXcdeHvH0eAtluHSRbi7LtqZ9HVc2moBj9yqBqHp1NEm+XZERoyzEfS7EFrbbZ0YZIETG63CKuw3rLxuOyZHkwedZ9a1uysSItPu+aloiIzqc7vJ7djT8mqoWZGBv7HaCSH9+smo20LCe/W2TDJ86DQOuWTSLtdeAxJ6afvi4quHAqCZJvsX0zOfbw+O4czScIw24vWLyJt+Vh/IeaYRNsfXZAgNvAgg5iWoGoCkZ2AVASN2bMx76r9Qh/keGTADFUJYFvjsmi5YUpJHMI75PYRp3x2VcZ/HH4HkTqC1ZyuLsv48gs8HzA38rGmBfIZl9aR0/osN1qrZTggfqZfMdx1R1LUw8seZxd4FMVf0xUa/nwC8pRbMKQa8qos9k0LY03mb1xlXKV0kBVU3/02D6Bz8OUvFDS8aMkNV30zpBrENxa4M0GJN35hokQBqX+IWzWYfkL54dOf0LDDl0qyP+VvVbcVUNGw9Rh7Cx0D6nDdKLZ+1o9gtiqGR0GuLPI6gycSnwLJB7y0l9LCed3R7B5TBAQbVMDpdphLN3dgBB+COULT9+gIzHnZqy3RRDnstzD2oZNEUarY5EhK85JvxtxMI65miCXeCdHgKmP3nq2g6bCBVGAzVBr1JDLPQY6MPwjFUQKh3/xBD0KcEb7di+UKtZInF1dLA1fSgcFVRehDXRo6Px91P81j5NBn1UkwgCkShyzIaPmTmMPzNL9DKHGKZEES9ouOKA44KtdGFrGPFQMHkSCFIhr57uOK9X7u3Nz7PILSoF/xQHTKgIEg=
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(396003)(136003)(346002)(376002)(39860400002)(451199015)(46966006)(40470700004)(36840700001)(7636003)(356005)(31686004)(2906002)(40480700001)(82740400003)(26005)(36860700001)(41300700001)(4326008)(31696002)(8676002)(86362001)(82310400005)(70206006)(54906003)(6916009)(70586007)(316002)(5660300002)(7416002)(8936002)(478600001)(47076005)(966005)(186003)(336012)(40460700003)(426003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2022 20:11:51.9759
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 37af3646-00d2-44c1-6a60-08dadc7d1bcf
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT075.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5943
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Dec 2022 14:19:01 +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.302 release.
> There are 38 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 14 Dec 2022 13:08:57 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.302-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.14.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

All tests passing for Tegra ...

Test results for stable-v4.14:
    8 builds:	8 pass, 0 fail
    16 boots:	16 pass, 0 fail
    32 tests:	32 pass, 0 fail

Linux version:	4.14.302-rc1-g30e132795eb8
Boards tested:	tegra124-jetson-tk1, tegra20-ventana,
                tegra210-p2371-2180, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
