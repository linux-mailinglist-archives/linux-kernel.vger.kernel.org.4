Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BBC16E77C7
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 12:52:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232730AbjDSKw0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 06:52:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232713AbjDSKwW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 06:52:22 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10hn2219.outbound.protection.outlook.com [52.100.157.219])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EB0849E6;
        Wed, 19 Apr 2023 03:52:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K6bGgK6FJzlAsekV802Obz18Wliw9Dc+GmZRRs8TwNERy2AWq0CiS/1vnkgozS5ZRbhhsBGA1vfENpF7fyCepM9IXh563R1TMoF1iCZdXtMkV9EI3v2NrjTCSWUcWg92BZEl4JH1C8N7HLl1w+GgG84KVxAS8UICKOWSQuHujbxaKBUYncBq2K9vyBQuPitqPHZVIK0EsjKOeYYRNNTxbjFerkNuYTKAOMwM3qiJ8kgzK4/JlZLBr+aKE1ibZPHWNge6lO/NU5Ac7suymcJBBbavXUfnANOgFN17wkQXB9djp5eu71z7glrE348CtEtp9Jer8TiXOVgNU30medQvQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gpSrE14tZLe+ahdTFbBax4gE5mLXTEGTuHWfuwYsMLA=;
 b=NlD3lQ6xxXWv0kuaKvJl9FpZeHCYywDdNQiCyfvNgAV2Okz6JKBBK3/5qev3scQp6ex5NI7CwAwCvcvvPtwuvhTmI/AdFOst3+fSCm/AOHT+X3NqZL7i1qE+J+HVQLYll+SK/wBnjsqDbv/C7ZycDjSID/ovkc8X+3waxpOQAyHhD+7vHluyMWMU6IyjQa9uMLitsLIzJaFROw+NpzQTKPojYjGhaPKV5FOC/IfAJ6MjUP9d5rw0YjEdskqJ7E/zIVXIydH2SCAPr9FmkivStdz9mlqG7BR2aWIvozTnOrjPM8ABw3TqgPugHtg8u/gz/XhhnPZBp7205d+urNNLkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gpSrE14tZLe+ahdTFbBax4gE5mLXTEGTuHWfuwYsMLA=;
 b=s8b2zy3/2N8kg4fbb2sKSrLgkDz5F1v0hI4te08JvHWaylsIc3hBv1SNMssQ1/cQQxdoX1dQyheqVZLYCom1Dv1AAwDRWCcOxvaaZdwyxfkBOV3WHiL7Ms9+v6N0tUII/vLu2D4QF2StQ4aiM1NZuN7hkTSkd2noC85ZYNXBCkqPILns1aySwxY9YYAqUUNHuFSVwJLaRlt7yzeWsliEc4zip3M2n2iQqbr1a0VobGFlQC0EAfKGrk9f3xRaiTTwGsFqYLDuyd9QgfaUPcFf1VNlMFnawRXMGmu4OQdOi1UxgqrbdjZzRdowxlYrTWv3RBF6vcGiFgbqbZcg7l7Gag==
Received: from BN0PR08CA0024.namprd08.prod.outlook.com (2603:10b6:408:142::14)
 by IA1PR12MB8554.namprd12.prod.outlook.com (2603:10b6:208:450::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.45; Wed, 19 Apr
 2023 10:52:17 +0000
Received: from BN8NAM11FT116.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:142:cafe::39) by BN0PR08CA0024.outlook.office365.com
 (2603:10b6:408:142::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.47 via Frontend
 Transport; Wed, 19 Apr 2023 10:52:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN8NAM11FT116.mail.protection.outlook.com (10.13.176.67) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6319.22 via Frontend Transport; Wed, 19 Apr 2023 10:52:17 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 19 Apr 2023
 03:52:05 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Wed, 19 Apr
 2023 03:52:04 -0700
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Wed, 19 Apr 2023 03:52:04 -0700
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
Subject: Re: [PATCH 5.10 000/120] 5.10.178-rc2 review
In-Reply-To: <20230419072207.996418578@linuxfoundation.org>
References: <20230419072207.996418578@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <5958cfac-a99e-4fc2-85e8-4c8b677ea294@rnnvmail205.nvidia.com>
Date:   Wed, 19 Apr 2023 03:52:04 -0700
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT116:EE_|IA1PR12MB8554:EE_
X-MS-Office365-Filtering-Correlation-Id: ab8d420b-5bc1-4130-007d-08db40c4248d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4+VfQGl66nmpYfVJLqnMgXOd+cu5BlpxWInEYD9C6XXefWPiB750mfXaYLZNKRq8L7fuWVRvh/gKFMnDcndpI87/ogiRJxqFLtuNF7i9+FtSi2x+eKSvPiHtFm8sp8656kIp917TUWmI5zCWRoqkkTA6QEDLlHJR9ss6oa2lPw/unWRqvOTfvl3/VvNba0qMOpuOVd012YIYiP6ycSItyqDNeDmZLy8A/YsMmcqUljXi9o8omBHC1FTQdR4v/sutGiNzQCu9zj49SqJDWv0U4Ooh1IbBiS2Rf6ly+qBCqYmvqivzUZDDvv7NHvRRRSh1Ma5Y3u9QAsTO9ibLvASK9hsFfFAKY9bWbsQS/1ETG8wiM6ml6plmQAUr+W0RhsO/bWzRiLQZsBJFnjRlyYm7Ph/luJkg/rymp91ZIxlchjvUHtr++Jwq1gbaXy+x/NQR2xZHnOdT67yZyWsT69VqsHQbZkOEEAJh8r+w68fL6fBOgF/eApZlTood8Ps/pHtd8eP7pRdL5dO/UFpMQIzNPsWemhSMBwpyftXtTHiMH7Xt17i2UE6f6zU4FDrn13HdIq/ubCzqV6SaYuJsgM6k/yJhhluIwu5I3UQTG5FCup5o3MPMiOPc8RKW5UigwHEAY32zpSfVgvrTGTWUZN2oSAr6SwcBGGe9ej3iV59iyr/K+DundnO2dw9Y0tF1Y3ltNS/wi3gnvPPnYfUgUzmRDD2bxwfgx+y63FJj7V8qePG9a1o1cwl4PUFy1QaTXvirHravNqTU4kqcJENEU+Svp9I8Ue5W5CuVbUE2UEdHTk0USpln9jdiUMkxrzc5Fbm0PSGxaYOaamZmGWTAHBLN0haWsIFymHqGbVb1tBdxpjo=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(396003)(39860400002)(376002)(5400799015)(451199021)(36840700001)(40470700004)(46966006)(31696002)(86362001)(26005)(336012)(186003)(426003)(47076005)(82310400005)(40460700003)(2906002)(7416002)(36860700001)(31686004)(966005)(5660300002)(8936002)(34070700002)(8676002)(478600001)(7636003)(54906003)(356005)(82740400003)(41300700001)(316002)(70206006)(70586007)(40480700001)(6916009)(4326008)(12100799027);DIR:OUT;SFP:1501;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2023 10:52:17.2014
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ab8d420b-5bc1-4130-007d-08db40c4248d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT116.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8554
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Apr 2023 09:23:38 +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.178 release.
> There are 120 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 21 Apr 2023 07:21:43 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.178-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

All tests passing for Tegra ...

Test results for stable-v5.10:
    11 builds:	11 pass, 0 fail
    28 boots:	28 pass, 0 fail
    75 tests:	75 pass, 0 fail

Linux version:	5.10.178-rc2-gabbd2e43cd45
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
