Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DD3968B7CB
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 09:56:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229922AbjBFI45 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 03:56:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjBFI4z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 03:56:55 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2053.outbound.protection.outlook.com [40.107.243.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE79A4C1E;
        Mon,  6 Feb 2023 00:56:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NQEllHLbHxEYteM4J+HKtYWwcL1ayFGuS9L/R8uXjKkXAy+gPEvz/ggdbHGJfwbpXnUuKrIKqWntw9RhjHtmK8L5bcG/aSZbnrF7eD97CJf8DZPqXEYvIejx36djrmSH9qDM2iIsJnkfcqh6tGOfiAep/3CGEcMMFN/nUz+6uE0mf5t62esRfFheBmX2/MuMFqI69whdb4Aoo9w5dWWtPppVSyjWbVNZm1/OT93Xy6jt+HYKIjymzTgD1vwKxKzAAdRIMO5qq/MK2bbRNis05CjLMHu0k9KecxynPJ5NOC/rpHJKXUHsSDNwmuyQHVEkY/KVSPNXKcuOEo3r7D4FvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G4O4bPJqfnHMr2he+EqBswZIggkGGIjuL2Ztd1QjCjk=;
 b=BEoVbRa++RYc6NbUDhjWB0KbH6abWBvuiHRANNofHJ4mtH7UmhJG0br53OVJMk0SKQlCfaehKa0q4/xmmH2eJaLm1zf+Sny828GYw3cNUofT9+xGFtFoVwszXcxbydjvbGwk7Z2YDfj2qPzmNWhHAu4dmd3HFmAdR64aQcKSH/cH4+/ne0WfgSThmFQ1wMv51mNGo6QfUh3EMJbSgAL3KeRcX5X1Z6fo2GetsT/AoT9AyiufKs9Fpmifi6oLz3b4lmMGOm8bDDwA7NUaF6zg3QyMP2OLEOSeEjpbvqCeoDKOvDHNXv7uMZIAX4IiKt/aTJQan7WRyec/vaCahYuOXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G4O4bPJqfnHMr2he+EqBswZIggkGGIjuL2Ztd1QjCjk=;
 b=OrH/Gy+itQc/X8JmV2AJhSCZ3QEEON+8xQshlPCVwxiqYC8IcVj19j7N0d+ij7YIsQYgCKqPytPInYDxlCR7iknJb9svz0FLPtN4St7NL1N26Af+N/zFsmxqMyRxxCLR6+PZChMpA3GvVE5MYpc2cmOClxTDYz7vuaj7ZJjePO10/3z0gSR7LFxjNMq/B76LAFUHmIp7SavenzIJBCsnhgXDzhRWJ4Amp/RclB1fNu457QtCS+9KHQKlrcnCT8neD0GWGDGR983BH5hTxjLCPMKUNTWh27P4SKbR6jjbbUwqMruf/xoOwgr8sDOUk8gi2E3Z3f74k84aly6ulrYJsw==
Received: from MW4PR04CA0379.namprd04.prod.outlook.com (2603:10b6:303:81::24)
 by MW3PR12MB4394.namprd12.prod.outlook.com (2603:10b6:303:54::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.31; Mon, 6 Feb
 2023 08:56:52 +0000
Received: from CO1NAM11FT072.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:81:cafe::5f) by MW4PR04CA0379.outlook.office365.com
 (2603:10b6:303:81::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.34 via Frontend
 Transport; Mon, 6 Feb 2023 08:56:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CO1NAM11FT072.mail.protection.outlook.com (10.13.174.106) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6064.34 via Frontend Transport; Mon, 6 Feb 2023 08:56:51 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Mon, 6 Feb 2023
 00:56:48 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Mon, 6 Feb 2023 00:56:48 -0800
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36 via Frontend
 Transport; Mon, 6 Feb 2023 00:56:48 -0800
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
Subject: Re: [PATCH 5.4 000/134] 5.4.231-rc2 review
In-Reply-To: <20230204143608.813973353@linuxfoundation.org>
References: <20230204143608.813973353@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <cd45e983-880d-4261-81d3-52c2f4db4af5@drhqmail201.nvidia.com>
Date:   Mon, 6 Feb 2023 00:56:48 -0800
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT072:EE_|MW3PR12MB4394:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e2b57f7-37d0-44a7-b399-08db082016e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o4rwz4fq6JZXDTrSVm8wnGKvvsBmkd3h2+bqoOqQm8YfcI2JOBppsqBo3aPP7MMKfy/WO0R6wnkuWx6B8mAM+f9q+Wu9kYX79tILfJqV2qCs8g/5LmcXzKWKxlUdb8FC+YY2P48DK5Zw1BIrmxAaptkr2cW5fOiVmrjCrniTyL3v15MO2en9azXbM2+BovPyy8/eBuq5HM0CoVLJbAiS7w3yy6Xh24nJn4QYhdJHd/H0Gcy/e3rdUUSYSEB9K0bkxwQbEOxzdfeSO3SDbPV0mVVCOUULiFLjfjLtamTMmI3vpb7MxbnVKpSNavYKq6vDbeWoaG372q1rGC74PJQZ73iEgwiJHFVZvlc/Kk5k6FqTUlK4Dh+kMiEulkkj46XYHZ1dg1OnDyXEuavnCehHqDzaDMgslDMPB3fE740e8kfJtEZnmF/EkTehlqM6n4gmxQNPRZMWm5oZ7T1OjWG7Swro1heUGCc8lVamxyKyEuEWJV7w4u7faurLEtr5Q/Y/Xxf4o0Odz1fVSh+yGQpJXJfvaXtwQIYB2/swgKXOKGHqnSK/1zZhge2IM/q4FX/ABSO07DZATKoi7PIBRESt4Tvn5Tj/tlj7500qH0/Ujcsb2+t3eI/AsooRoM97T2H2Ac0svFqNh/1RE7WvTLbhk9D+mcW6At22kA6XexVtJAUH24xnlgYjNDh2Ohu1efKMvMPHozfyGGPIPguX2HDDE3OcNhW7b1Ve8jmIXTamQMFoFXa2SFttIuhGHwf8j6UDuehCgGvM8C4EfT+TsBndvqP8P9pyijr0eSWWtYoGaQo=
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(136003)(346002)(396003)(39860400002)(376002)(451199018)(40470700004)(46966006)(36840700001)(31686004)(2906002)(5660300002)(7416002)(426003)(47076005)(36860700001)(41300700001)(8936002)(966005)(478600001)(26005)(186003)(336012)(7636003)(82740400003)(40480700001)(356005)(86362001)(40460700003)(31696002)(6916009)(8676002)(70206006)(316002)(4326008)(70586007)(82310400005)(54906003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2023 08:56:51.8353
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e2b57f7-37d0-44a7-b399-08db082016e9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT072.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4394
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 04 Feb 2023 15:42:39 +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.231 release.
> There are 134 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Mon, 06 Feb 2023 14:35:41 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.231-rc2.gz
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

Linux version:	5.4.231-rc2-g9d36c855cb4a
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra20-ventana,
                tegra210-p2371-2180, tegra210-p3450-0000,
                tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
