Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75ED5682E2F
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 14:41:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232240AbjAaNlx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 08:41:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230259AbjAaNlv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 08:41:51 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2044.outbound.protection.outlook.com [40.107.93.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E7145087B;
        Tue, 31 Jan 2023 05:41:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L1omOYZGgxSUYxPv83N4/HGiP5mtESqMovZOHcIF9eg4zirtz6IE+IffXK3uNedAWNB/cjQIrqHxNgp0cATQT3kasO96nci7zOc0s5GmP9pRi/4FhjHCVjRVW51hpiaznbazIjm14bBSFYopHgzUaCfJgS8ONHNao96n49VcssdYiUy3BiZ7DKk8dqF9tqgntAzKaFDcusAVzfZMedu/Q+Xi2dgb5ASAvPDzBEIJBdJEjaLYlsN7bCOCiebB8PDgJ0JFaYcy6llxY24jU/l0ha1eKie5HiDUb+pYweLb24F/NtLzqSmr9hV0IJXWOv7zD30tv+XP7RgDdg36wBLn/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u8h1omCq15xkpUH0vU1RasckCMZpgqEMHJhK+1mdgBc=;
 b=bmsaD5UrsBx3yythI76rEL4tiK/tDL89CG2o2+G1wkwZPqVoulW6BOGhSvpe8MTpifDPIHZiVXqntgvNvfbNLB5hKEWT65NmT161cIZxm8b8VTzCo6kSMf5vGSl6G6puG/uTA2Ab/1+sbI/z62REBwH/EX+3GkpB4blHpmOjFHkANchzteU65GIwJRKqt6galb3yzYbGme1IzE49VqedeGKYOyJWOvZUvHM0yJ1ObGGPdLhyWxqRxeK7Ufi2CNpWkZCJaCiFimOxY/6zYTE3X1sffnkhbuNVV8a7FxjIe+sxRPllH8Dv7c56IeYzlZEd5Wl3LC4/pV8B4pAOO7gWmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u8h1omCq15xkpUH0vU1RasckCMZpgqEMHJhK+1mdgBc=;
 b=mW0n6JhWo0HDDFckjmNbpxEf5ClCtlGSDqaeMrWEZNGzYhYazqmkQMHBVsgliCzXfOwjYsQBJm2P2wWyBO5Ndl6rgS3vrVlqq/KK0bEc9xYZZ/sD4fA465KbUix9HVRUZdDnJcjeBnzehP6WpZxN+BxKX1v7hM/Z9/qf/V46bM1jWRQHrBoa4+YxfEL5Se14RVaGK3veBT4uEh6sI+P+gy1gHyNBPIQOmo6vjdqpATXr7B8BmMqjHw5QOzSiYUNo86Guy1g3nHv9OJHBjvDyaMgVHvXc5KQfTIWpKvZf1C8Bp6aD07duYL5mcnPB+ScLuCSA+1Ca7ObObM88ZS0bpw==
Received: from BN1PR10CA0026.namprd10.prod.outlook.com (2603:10b6:408:e0::31)
 by PH8PR12MB6913.namprd12.prod.outlook.com (2603:10b6:510:1ca::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.38; Tue, 31 Jan
 2023 13:41:45 +0000
Received: from BN8NAM11FT054.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e0:cafe::67) by BN1PR10CA0026.outlook.office365.com
 (2603:10b6:408:e0::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.38 via Frontend
 Transport; Tue, 31 Jan 2023 13:41:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BN8NAM11FT054.mail.protection.outlook.com (10.13.177.102) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6043.38 via Frontend Transport; Tue, 31 Jan 2023 13:41:45 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 31 Jan
 2023 05:41:38 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Tue, 31 Jan 2023 05:41:38 -0800
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36 via Frontend
 Transport; Tue, 31 Jan 2023 05:41:38 -0800
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
Subject: Re: [PATCH 5.15 000/204] 5.15.91-rc1 review
In-Reply-To: <20230130134316.327556078@linuxfoundation.org>
References: <20230130134316.327556078@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <636a6f6b-e76e-47af-b891-b51d870ab42f@drhqmail201.nvidia.com>
Date:   Tue, 31 Jan 2023 05:41:38 -0800
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT054:EE_|PH8PR12MB6913:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a52a0f1-1bed-4c1f-6b20-08db0390e51a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VCy9hSa/3XhXZ0xYHKJtRlgI0qQT+SreRdn+2M7Qy2+sVoVBYrED5y871OuxkSF1VjcFDuVL/7D+cvyt5OePqfTc/6KOcNlZcDsT5QerWwoBYIiTG7B7FXujO2ggWpMpQ9OYuvXwa+Fh7Gwotxl3anF6RG4TfXqnaXNbTS4kl1de5mX02l7Az2HbwX7d0YrJ4uVKOggZQzf9S0z3N+GCEgtXwrJcWn/hQMLu5bEOhkcAj6thx+A8RxKjle34CONs8k8/C4sWbbw8JhENzf8zr9ngyQRoE9j9wGWw45SvqiWJmqQAM/HMAwuoT8IMoV9JeB4IsfNO2roqPjz2iljLDBZLtjujn84qysp9xjclU6QOUh+nfC7jhkYwQZzAZ26q6tAmgYrmVP6yNEj3n/RvSbXCdTXzNx6eTeumLDI+fa7phy75N8jsJiYTG5Si9hYlRKe3gqY9S49l/6cJj3isSaVddrGQhgEenIeh/wtD/qi9S5B+mTCneVzEnpFp7itqV/TC3dzhQK5ipEizhoVtR7Vi/3+n8ZsZGCXiZweYU+kW91veBxylElL2fevc8u5+o3I20NfwH28Km7q8+NYPKoMcePgCYYag3n15J8thdzLevHrb+ys3d4VV9JPrGPi76ISBWt+cWkIy4FrN4FAucMzNFyZ+rsZQSJy3gTGyVY848bVsNf1H0iPT4+xwutl1FeI5RReTcD6DfXxc2IFCRzlW9DDkEIVZCWl482UMCKyXnXX+RJiFt9oVIcgnFOJxctSXoC7joleGiUxej0Ea/NN5nYKadDKqFHbkWETuK2c=
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(376002)(396003)(346002)(39860400002)(136003)(451199018)(36840700001)(46966006)(40470700004)(478600001)(26005)(4326008)(186003)(6916009)(8676002)(966005)(70206006)(70586007)(31686004)(7636003)(336012)(47076005)(41300700001)(426003)(2906002)(82740400003)(40460700003)(86362001)(8936002)(7416002)(36860700001)(82310400005)(40480700001)(356005)(316002)(5660300002)(31696002)(54906003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2023 13:41:45.5070
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a52a0f1-1bed-4c1f-6b20-08db0390e51a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT054.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6913
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Jan 2023 14:49:25 +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.91 release.
> There are 204 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 01 Feb 2023 13:42:39 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.91-rc1.gz
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

Linux version:	5.15.91-rc1-g5605d15db022
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
