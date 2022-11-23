Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7389F636396
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 16:29:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238845AbiKWP26 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 10:28:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238531AbiKWP1q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 10:27:46 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2069.outbound.protection.outlook.com [40.107.223.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84CE1239;
        Wed, 23 Nov 2022 07:27:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gf3wmt776zHYEBs+00d9ugpdU52lsAD+RdKp/eQHAgsM4gj+MsEFahdSXydhO7onks88fGGEh433AD5YdKPGULOPGNdwM0mQ+JbYwEd/mTJ0XI4dITDV/vxLlfAToV2QDuNNg+/OA8xoc2dvQnZ9vp6FA7rpTKCf74a6DQ9KNwSTfkC3ooXRc/IOlzEvEBhhp+rrutoZa5XXJbzjlSHqGQRuaY0U5J7KzgfBeNr94hvbwcXori54iq4a2WnUbfa21gc7hPA7d9WD6TiPUSf7lZDZO4nojxi4YHdt9/WACTTiFrTRtSukGd/4w5swEimg38/V6e5ot+SOMaHflZJXog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a5vec8fQciFYsUjcfUePh5RppVcu1TTa8BQ2OGlOamk=;
 b=K5e6cGf4TyzDFHHw7y+5MiU9hvWtNrECFQFUtwUhpPj53aRsvm5aavbuoX63V3bCKXHiLrFAvApT+vxU7atOEjp6e5adox7rDXfG6FpvWgdyat7JodwF9l9reT+16YA98MOoyFZDCKaZpIzXRCgvvjiN7cpMkG61m/0X/HfRiczwnxlDud4C7n4L5xswb5/G51K8XbKlVBJIeXPTwNl1LVixnJlBgm+aTV5/2XTJx0Q3/WRXB57ISJaylznjjNHcveUz27VoHn3XSA18/FbXpmkmXfFS3+VNSH/ccgsJQPDl/O3jpp6XSmDi+M9+5j9PwOzdR/UOOGi4BVGp18fuVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a5vec8fQciFYsUjcfUePh5RppVcu1TTa8BQ2OGlOamk=;
 b=AYzScxo6KZkLWXKONFMC7lSjRzzaNj1Ce0yoTrEljmD9ipQBEYpQZmxnnsv18dtmutuI6jjGHuIy4CUwgCyrXbCigOsU6X4i6kSel0pJLbSs3eTfkl30tfB5sxdu0BzMRZxfVrH3aJr1kvMD9hMIjtM9T1yuCybKRPggtzEGq53okEgBtu5FdRCyjHoMuZGYzu7xiYL7ffk4iVkOHxonkAILfIsz2+bJQuftU2y8ytoqci7APrMwbj8pcSS0qL22TcUYCJmyv1BY4QxObJBN/QmOtPJNO1Z3ndoxi66bUylAUL9pIJW4/tDOumJszhLidgOyTV4GVRvQveqle47tHA==
Received: from MW4PR04CA0245.namprd04.prod.outlook.com (2603:10b6:303:88::10)
 by SA0PR12MB7075.namprd12.prod.outlook.com (2603:10b6:806:2d5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Wed, 23 Nov
 2022 15:27:25 +0000
Received: from CO1NAM11FT009.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:88:cafe::a4) by MW4PR04CA0245.outlook.office365.com
 (2603:10b6:303:88::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15 via Frontend
 Transport; Wed, 23 Nov 2022 15:27:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CO1NAM11FT009.mail.protection.outlook.com (10.13.175.61) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5857.18 via Frontend Transport; Wed, 23 Nov 2022 15:27:25 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Wed, 23 Nov
 2022 07:27:22 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Wed, 23 Nov 2022 07:27:21 -0800
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36 via Frontend
 Transport; Wed, 23 Nov 2022 07:27:21 -0800
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
Subject: Re: [PATCH 5.15 000/181] 5.15.80-rc1 review
In-Reply-To: <20221123084602.707860461@linuxfoundation.org>
References: <20221123084602.707860461@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <75291024-a9af-48a8-a45e-736e3f0a6660@drhqmail202.nvidia.com>
Date:   Wed, 23 Nov 2022 07:27:21 -0800
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT009:EE_|SA0PR12MB7075:EE_
X-MS-Office365-Filtering-Correlation-Id: b8f9b3af-9d1e-4d72-3560-08dacd673933
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: E5YclFeB7s5MnOSCG2oGMiR/5m3hoWtpUeHxIWdy4XzkCVQYj058R0Sx6DehQe7TWXxl49eVR0EoFtCwBnJo1iSmLNmstTwoAyUTGfvs8njQDHEK4OpCcCCjzV5Lqpm70HAcAxx8TK7j0HlMSKrY+3ZKMDd4mduOBGqWer90eWfap6gmMD1F2Irj5GR1e9s+YH3WR/urzpEtxFxXUInejhbZMzTcRmXOTVzWd0zXbvGOmX9g6t7g6pdQAKTaxUvmR9aSoEI8oG3IbqZFbFJi9mRd/q4LOnaw3/SoKRwMGnWQVdc5DIMmX8RkPV/oF3R2UZX9lVth5+qo6XuFhB6oJO8E/WsyaNXD0vhgeNXgOparFWcjbw1I4UZt3xfvY1of2RZ1doFDYSMb0/tiGf3vnPAgOYvkNatocsQVYTt1bfhAT9uEL+jLGqdo07Hsr//piGw2lgvZpw2uoiKZVcscaKu2zzdo5ANZjpvVz0bbAg523uSHudyfkv9SnK9EyYXT0faxAb/Ly/4klfDVSd9ZOtEWuhQM0HlIw/0A9l8rIUGIw7/qzy6gExQt2EVsvfXcdVHEreJL/xefC4HA9OUKqyZvD+MHs1kKs6PPX5v7/zBqTLOOvzPQVVw9QvTZ39GwVCiirTM/eB//5eDWkAAL4snCKP8UDO9baTFJAHr8ifuafEi9e+WGX3PkOBpBxSvBoWT/cplQ6Zvfge/GNxgr2QgFCz+ecYKzHGj7XHxjmIfTZfmPghI2A3+x4j9tXai8Rsumx2nh8fhtBIIkhGZf3HWgNBaSutEcHMLfxe2h4Js=
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(346002)(376002)(396003)(136003)(451199015)(40470700004)(36840700001)(46966006)(2906002)(336012)(47076005)(186003)(426003)(966005)(26005)(478600001)(36860700001)(7636003)(86362001)(40480700001)(356005)(40460700003)(82740400003)(31696002)(82310400005)(8936002)(7416002)(41300700001)(8676002)(31686004)(4326008)(70586007)(6916009)(54906003)(70206006)(316002)(5660300002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2022 15:27:25.0391
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b8f9b3af-9d1e-4d72-3560-08dacd673933
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT009.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7075
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Nov 2022 09:49:23 +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.80 release.
> There are 181 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 25 Nov 2022 08:45:20 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.80-rc1.gz
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

Linux version:	5.15.80-rc1-g1ac88d934860
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
