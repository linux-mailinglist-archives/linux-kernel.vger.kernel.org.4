Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27C0C6CD859
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 13:20:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229779AbjC2LUi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 07:20:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbjC2LUe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 07:20:34 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10hn2220.outbound.protection.outlook.com [52.100.155.220])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D297D469E;
        Wed, 29 Mar 2023 04:20:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fCjJlPHI6w/OOg68Qx6srt++e9CykxGrS9trerYxQyP/1eEjWn0xZ6YLXgMkzv87Tv2X7WxKK2WHsmBqiOn0qGE9FNyDpE0r1zh5o4O6IiopMJOlZ9tAXBqOxnVrOdBvdAWDgZdRgoxr6MgPGv8kb9I5LH0CCpHjseQq0zDtrElqMufAiBffEmFM/zopwzecm5afh+YhswuUB7EOuBIYYmpV1sweRN6vmEgcbIbStJOsOUV4e8dYpWZjPjAyD1iX6MyK18SwORmc7TXczOmxDZthzMbn5ZFfSIdJGilIbUyumO6S5kPKiVRaJUtjbYyHucpet0yZyJTGVlhXoaaAfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9NmeFGdtil6cSnUF48EHtZgRafFpzq2PmhxSRyD1mn0=;
 b=RLEBGhhWqMfK1IVoXjtaIplCHIfVeZyqTJ33wn9a4+xc90X490JnXnWuCfIDnGkFurOtBv3ozunhGtLpVvKosXbGqFrV8TG8Hd3XKEVw04bfPRSkgT38occCEJpDn6KflS7d06q4ZQqDD4boivhY/WHE0gVGtcuw7c7bkYys/Ew15YFXGJjS8PiCSvGiIpc+RezCi7nTbM5h2oM49Cm8652tlg+W0JnBLhrEBK3dEQTdYLRVf58Mm0P4RzOKNnzxojE7ayUurmDgIrs/BWqYEoe5qYwWPeIEQyQpcN2EkYmLHWIWQWNMcve+Hc+u2WrVP02qsuRWxeGWsQZJW49Nrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9NmeFGdtil6cSnUF48EHtZgRafFpzq2PmhxSRyD1mn0=;
 b=l+egowTRwsdns+gYOOn9B/vK1j3x1J/KXHRR1itMQ741KBarBu2xsr2C74dvzowdNcW04b/dNc2AWgKs6dxTi9B8ZFHu/SaerwkI+xY6Lb02Hv/IN/tTzEAeU9k6p1L4fKavdq8nNyzVsuqP8Czts4lCC5yPBFF0PBVxYdY6uT6jw+0cBjcx784kkv2lZgQ8y58N23yjyhY7vmSQdQjxTMil+ZyNAsvZxwUN/g3ZX9cg2EnvyoHls7D6WLrAQ2HSofnn7ANHzFZUDcw7WkuGp7zs1G4S162l3uEqxYoCDgSZqLhuQmQORPFW2HDy58Exw4r90xlyD8Feaz+KkljyTA==
Received: from MW4PR03CA0210.namprd03.prod.outlook.com (2603:10b6:303:b8::35)
 by SA3PR12MB7805.namprd12.prod.outlook.com (2603:10b6:806:319::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.33; Wed, 29 Mar
 2023 11:20:31 +0000
Received: from CO1NAM11FT028.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b8:cafe::44) by MW4PR03CA0210.outlook.office365.com
 (2603:10b6:303:b8::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.20 via Frontend
 Transport; Wed, 29 Mar 2023 11:20:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CO1NAM11FT028.mail.protection.outlook.com (10.13.175.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6222.22 via Frontend Transport; Wed, 29 Mar 2023 11:20:31 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 29 Mar 2023
 04:20:18 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Wed, 29 Mar 2023 04:20:17 -0700
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5 via Frontend
 Transport; Wed, 29 Mar 2023 04:20:17 -0700
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
Subject: Re: [PATCH 6.2 000/240] 6.2.9-rc1 review
In-Reply-To: <20230328142619.643313678@linuxfoundation.org>
References: <20230328142619.643313678@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <c1241136-a35c-4318-a105-02dfb97ce02a@drhqmail203.nvidia.com>
Date:   Wed, 29 Mar 2023 04:20:17 -0700
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT028:EE_|SA3PR12MB7805:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e68efd4-cb4c-485f-074f-08db30479b77
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DVgGITm8GgvxRjmSpczVCbvKDfeb5ZSQxuhBHT06kz0MywPQTBiK8TER6KTQMGCWQJLYLrDIX3p3Ytgx/N3c2VfXOiSqXuSP7D5C7yJRT2WF4sBxa+Tx/YuXEeR5hPRIjQr0ZYcvCJCkhcYvaPfXe56QeU2KvKRPs1cK9urCrg8C/CkqhTwzdJ/ovogetS3jvgyreN2hu+PaQmZrkefnGUEdMLRqh5UuZtKLnxa13LI38QQimx/xo/fWeNJVJEJdxk17EcIbPsRKVy/STBpQuK5/ahzR0VamkTPXNxGF6x009LFqQs/1zSybk9KuGaoZGXzv+ytfwVKyI/9mOzVfX8yoEgL6fYkZqMzH1asptECdKppgy1W6pD7tu2KRkUP7cHjvqBkNuO3MfDIN4Kl9srNZm37VAssrc9i5/K98OmkAi921IK4rvQgoa2BYptTEhGzMe4K+qNx5L9Iz5y+PCw8GlqD2lpUPoj7aAmsXytbifql6n69j8KnYXgQ1hJRIoApcNVr6eSzibxLCsnNJl7z+9iHbC7VtFpvLBxyRU88UtS79NAR1WHDuFEIDFdnvKrJCAAWbOPkoT+NqSYJs2r//zSle/xR2w7Pi+Saddu36Y9OBOe85ZHnmSk4weCMY7OaAL8wCq/44u0UGaLsnN8pWiX3ls6Y/2+v1IPKH4WLHG0oMBIeDwVEZgM1JEJJB/P9LW88NBoBjZfwxBOYkKdQ5pRfEUaPIPpMGHdZqQCESw40h0OfQwPWNz+1oIzluucJMLS7kXzbap6NTg0+9UNYbA0EX1DZuBzTAMg0GLnDv40BYteucKJleSTs21Zzg7NwQwcxq0YqX3r7rfahWL2rVZVjvg/5JXszCO2GDXDs=
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(396003)(39860400002)(136003)(451199021)(5400799015)(40470700004)(36840700001)(46966006)(478600001)(2906002)(36860700001)(336012)(426003)(7416002)(31686004)(966005)(356005)(31696002)(5660300002)(8936002)(54906003)(7636003)(316002)(40460700003)(82740400003)(86362001)(186003)(82310400005)(26005)(40480700001)(34020700004)(70586007)(47076005)(41300700001)(70206006)(4326008)(6916009)(8676002)(12100799027);DIR:OUT;SFP:1501;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2023 11:20:31.1356
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e68efd4-cb4c-485f-074f-08db30479b77
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT028.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7805
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Mar 2023 16:39:23 +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.2.9 release.
> There are 240 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 30 Mar 2023 14:25:33 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.2.9-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.2.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

All tests passing for Tegra ...

Test results for stable-v6.2:
    11 builds:	11 pass, 0 fail
    28 boots:	28 pass, 0 fail
    130 tests:	130 pass, 0 fail

Linux version:	6.2.9-rc1-g09974c3d7666
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
