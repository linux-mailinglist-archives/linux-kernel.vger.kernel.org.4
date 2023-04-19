Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45CA26E77C1
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 12:52:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232589AbjDSKv5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 06:51:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231722AbjDSKvz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 06:51:55 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10hn2244.outbound.protection.outlook.com [52.100.156.244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA6586A4E;
        Wed, 19 Apr 2023 03:51:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YmQdnsTvuClE0o0M++helI2Vs+1zzn/gCj2AU37B0J283eYTZ8PCZyUukJyy1mEwGSM82K0TBJ+gd/pTjCfDHuj28BHdvDgx9TkHEKCfIYLkNnbazfoB2fcAa2JoJFuWYvrltx9JLBBHlr2U3FLcdnm3igOFlEXAJOSNiRzC29x1CgTnk088KwbEo1ksohCsT7Et/vS0qVQCgi3YoULfBEWYuqks9LmTBhyQMTZDjFSjoDTX58Vy2Iq14WFI4vGdeInKrx700SRcX8YUt3YLgVsN2MSCpAcOodiHf+nJnatH5jNQOxRYrgtQe9C41jg4TOm8EdlS5GAz5wuFqNb4vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lZUYKm5uQnW2gecD5pUe8LdygzZce4wFpdxBce04eaQ=;
 b=JsYhCQbshkf60etnnZ4rAFmnRaikKZOQYsUoAQX59yXUesSaxVDOyoWUpccwehpNZejSVRs5AHUKOhKNoSdtiNR403L4ERMSSi2iPY8y/PjsW0evRr7D4FmBLtXQjF+z6ty4/xG8sKHh0/Ef89jiRokrYBPhxdjP+VlG1ZVhkn2DY8Ju6xVkXZw95NuVGjGbnYuTW6ZBk3ekNp+3qlDCbx+TvmTnrGh5pGN64pZvjxuwx0RdJ37EHpgmqMTjFkMQbtbHfSqeBglTan5IJ0NEC79tHqLwJFNIaJbqpB3Me63nXNS4mc4sB6M25re/Vrd7whIMyFIzbdyKA8opphOTgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lZUYKm5uQnW2gecD5pUe8LdygzZce4wFpdxBce04eaQ=;
 b=DrtLg0EJvkL04adhQq298OVQnXOG1KxM6OQAAGpvB8Yi9wMPKWKk45h3wUglXy++4Y9ZvgkkkzePkkLnbAHbE1jcoBPwonNOLv545YPKJB7W/+DeVS7e03XJB1vQ4xtar30kITx16odj+WxTAylLZhQG7UNlZXsw2SQw0KdhahAxQsANtm14qPMpR1hwK06ydqpawfrorOcYaHBI0829f8BiootoagFNdtvFZp1MGmSkdJN7VHcC8k+g2ObGVo0lN/fGvMmEyYmT2iPEa192/4ccdSewj6UNOW5GrJ8d6TKipbQTkx1aKM7ThuQ35RlCKq91wZ9XJadsUeNeVkAV4w==
Received: from DM6PR12CA0019.namprd12.prod.outlook.com (2603:10b6:5:1c0::32)
 by DS0PR12MB8219.namprd12.prod.outlook.com (2603:10b6:8:de::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.45; Wed, 19 Apr
 2023 10:51:50 +0000
Received: from DM6NAM11FT091.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1c0:cafe::11) by DM6PR12CA0019.outlook.office365.com
 (2603:10b6:5:1c0::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.22 via Frontend
 Transport; Wed, 19 Apr 2023 10:51:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DM6NAM11FT091.mail.protection.outlook.com (10.13.173.108) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6319.22 via Frontend Transport; Wed, 19 Apr 2023 10:51:50 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 19 Apr 2023
 03:51:45 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Wed, 19 Apr 2023 03:51:45 -0700
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Wed, 19 Apr 2023 03:51:45 -0700
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
Subject: Re: [PATCH 5.4 00/92] 5.4.241-rc1 review
In-Reply-To: <20230418120304.658273364@linuxfoundation.org>
References: <20230418120304.658273364@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <83f2b54a-27df-4077-ab16-d66a8e68b622@drhqmail201.nvidia.com>
Date:   Wed, 19 Apr 2023 03:51:45 -0700
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT091:EE_|DS0PR12MB8219:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c588a56-f4c3-4a46-7497-08db40c4149a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PMIWHSfom9qNQqUaO8MugztFMKdfU7O3gGiYw1KUBvpQK5xFt5dufga4gGGFzB6XoPxsTaevJwRtA66hgs936uTj3bMKIzj22Tu+9ocXuK9mq8rHrlIKbQmZdJjCqbE8EPCxUcTFEbCeO3zT4N/S0EO4amLJzKa3QkuO7nCUJrGw4WGzHE76P1/t539u9nlf+1RmWg8Mscf+xqCjiOVMi+ltq9CCQzSAu16C1cfmGNxHCS6hQ8dpl8iXGaBdjCMpUVt9J/xJpY2ajMIm/EsmaW25vl3yzCyyvQ19dDFjIXxdYpeYxv6tGynwyzL1XooSDRurj+uBQo+5dJB3DwagxLIn5M+zZivwlQk6lYC8uh9JHYoK8aTa859hb9I1C8uuWqg8CXNoLpOgviwlFeQoZAJAVB5vxCL7ni/U+TBRVBsiiQFIC2z29dxoBTc2rGKMSqzv2Z3oCrlgCWbT18iWYSwkeTxiFgo8zXU3Qbb9roFBAT4JE5k9HWAi+IDp8YXn1QPHbFUGJdP94Y+oFQ+zZjjNQCDyDmPtCJGGoaba6uXwlenf/7mO0Mewmh977CaRiYbXE307gyWjboEDTb0JjrqmKZkahbJc6Mx9SV2iXw9lFtIgl3uPYmP3mvsCY9N8cIVJyk28gwDZbTi21St7Q4ereemeo1tMm/Rs17mZx4dBq1OmxGz1l2+UmXB4XfpUWcD2o9d9zvGqyOPTwFnjFajJ+8hTWxSfNSL4c1knlYEKn61u8OwGsd/4wL2EpAvpBZhgc5Uky7WEGi5ZZ97HF5jEaa5le6e//KRyups84ax215KAU16BKp2n0Z1NFCg9JRkMQrgSQHyDPsYFGp60NbSH+1Whpu1zDluSX10RLik=
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(346002)(39860400002)(376002)(5400799015)(451199021)(36840700001)(46966006)(40470700004)(34070700002)(31686004)(5660300002)(86362001)(426003)(6916009)(40480700001)(40460700003)(31696002)(82740400003)(7636003)(356005)(47076005)(36860700001)(316002)(336012)(26005)(186003)(82310400005)(966005)(54906003)(478600001)(41300700001)(8676002)(70586007)(70206006)(4326008)(8936002)(2906002)(7416002)(12100799027);DIR:OUT;SFP:1501;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2023 10:51:50.5085
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c588a56-f4c3-4a46-7497-08db40c4149a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT091.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8219
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

On Tue, 18 Apr 2023 14:20:35 +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.241 release.
> There are 92 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 20 Apr 2023 12:02:44 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.241-rc1.gz
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

Linux version:	5.4.241-rc1-g230f1bde44b6
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra20-ventana,
                tegra210-p2371-2180, tegra210-p3450-0000,
                tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
