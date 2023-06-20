Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5EAE736924
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 12:23:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232217AbjFTKXZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 06:23:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232139AbjFTKWz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 06:22:55 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2068.outbound.protection.outlook.com [40.107.244.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3341C1735;
        Tue, 20 Jun 2023 03:22:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dXqhOUSdF6UwOi71wZHcyieedrpRvS1NYE5bWE+rgzLGK1zt+iyLNimpji1yN16mG9g8bPDLR03t671OwZlRkmElU2I+rcPQQQ/cMYHKjsJDD24x7SYqQJnD3Lq6EDeQv8Gwqdflc8m6cNVEK0MK21kjWrpNHX99WH9GPIF35HwJS9KtMfmg8QZ8xfC1rIsruNBAUFKsrvIkHubOEzBWKCfgV+ee6ewpuA12iI7DW4DAMDU8WkrNA7u1mjRByDuMj1VhIIbcstlIkNPzXcIcRk/TmROIbYdjSymCDnF2Ks4cMxt2cxqGv16TfCHfcNAJmUHMhaehP9egGWIQjGXpUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=19UziBH3KjWWS/Nwub85kgrDLE6oz5wKKrZcCDh5uWA=;
 b=A3sJlOJ+hOlGDkjJ2EaZZQsBWbbG1RxuxBLGq1SAaK1FlhT7qG3GuL4Q7foIk02EQ/unkBjNXSExOrrgNF18Yc2cOJjwGxz0igCSctlogfpR2M6BS/wh0sGSwcjds8bxp0lHdiFTc+yav9qLUP+ae97efo+/BEe0V0CHwjNV9ZrQnDx852zxFXODeIhyP/FOXwfy5j0sAzywo34PH2qZUnbZRub4e3+f1UBdlZ3bPfNEBNm/BnlAgQRv3drk3pjIhcVmREM2EsZ1Q8m9MdIMqQt3uAVRrJ1YJTEcoBJE7uQJWhjY+LzRR4j5RrU9DR39lNd8UvgioxJwnRFx0mnfyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=19UziBH3KjWWS/Nwub85kgrDLE6oz5wKKrZcCDh5uWA=;
 b=XYuPlLDUe5QaLfXynfesrsOGPIPO9Qx+qxSbok4zMIjgiyeri/91o/BKU2um1z6CR9e0qDLBL4Jo7/wscvDjJTpBIDYtrlEZjUTqTrmikUEHe1oPAVO5M+jC+R8kSCpV0Pvqo1tiGV+a7pr0d+on646RlZ9QWGC0PxR9VVwCxyJSgkeSTs9ry55MtjMK/i3F17ugJpC4yXzdtjs1Km2lDHyGl2h97zfr8TtFsXoEguUXMBFy779pJEun0OuP7NfyVQ1L1IoOIya63qjC3NS60+FNiCADXbRLAFe6USyAg0lRIRi4Tx8eWQe79zLzNnC7pLPn91jGnxCW6acXSpzASg==
Received: from PH7PR13CA0015.namprd13.prod.outlook.com (2603:10b6:510:174::21)
 by LV3PR12MB9258.namprd12.prod.outlook.com (2603:10b6:408:1bb::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37; Tue, 20 Jun
 2023 10:22:13 +0000
Received: from SA2PEPF000015C8.namprd03.prod.outlook.com
 (2603:10b6:510:174:cafe::ce) by PH7PR13CA0015.outlook.office365.com
 (2603:10b6:510:174::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.21 via Frontend
 Transport; Tue, 20 Jun 2023 10:22:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SA2PEPF000015C8.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6521.19 via Frontend Transport; Tue, 20 Jun 2023 10:22:13 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Tue, 20 Jun 2023
 03:22:02 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Tue, 20 Jun 2023 03:22:00 -0700
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Tue, 20 Jun 2023 03:22:00 -0700
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
Subject: Re: [PATCH 6.3 000/187] 6.3.9-rc1 review
In-Reply-To: <20230619102157.579823843@linuxfoundation.org>
References: <20230619102157.579823843@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <db728c91-d4b2-43fa-ae61-b3bd4eff9c83@drhqmail203.nvidia.com>
Date:   Tue, 20 Jun 2023 03:22:00 -0700
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C8:EE_|LV3PR12MB9258:EE_
X-MS-Office365-Filtering-Correlation-Id: 178e5f3a-c3a6-467a-bf5c-08db717836c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rPt3XLYh7jL+KVcntzyNQhphoXSCcUn15XZb77e1IsjS0FtTb3BvJWMYctx27paBxCzeBATb0PgC6CFZTGzU2ZF40FLO4hWu2Zx3jRY3d1E1/cLMtt9eX8oox+Kgpdl921Pm5vU+OQ3M7F4YgrKoEtc2VUUycMSmzh5aG5/oKWLZimyI/EpIsucOvLhicT3lAsqnMWnH1VfQCdvNGvye+2zR+T8Wio1jZ4OA+Drv9p9JwQAch96buCUdcUcDmml9N5as+mcEvexXV+je02J1JHv34R/gpc6kMmnB30u3E6hdJXhLre5a8W49rc8qyyvSOOKOINI9SXufB8mBar/aYOMSQ0JyhWV2V3Gy+FBBPqPOmJw2/b6QK6Bmazr3JI00cmkCPXwqrY1jSi3dB/GIZ7xn0iJEvNf60ZEWUocI8Zye3NHmJQ9E0gBfNgHyzWAzKi3+yh69ymezi06HNM6h9voiHJPVsp0GG4WD8wvha15DEYTrC8gM1ozFTGDXcdamVSd4AcBQBgg/xPn7maMLPJ+mh1gRgl+gLuRzyaf+/McGNjgxCVcxcxzbsaD74DR9qhxupd/3NnCNe58M2aPtiMSutP+v+SoxifsXSBpJ/kFexqQgMm8T/89BzOEdMAdmobdcGjWfiH9lOWLUzAPuvWPy6YPCgerkyxvUmtlRfqi7LVtBf/u3Z71HlJ9M+gIbdPd0mwdFgZhsDvbW5lkUsTb2o5ALpCzbelrS0abLYtWzCTkEEATSzQi0PDUDBwHcyTydLC+dsNX29GH9EbNuz952sGO+TFhGhXKloU77u2w=
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(39860400002)(346002)(396003)(451199021)(36840700001)(40470700004)(46966006)(5660300002)(31686004)(70586007)(4326008)(70206006)(6916009)(316002)(7416002)(2906002)(8676002)(8936002)(41300700001)(40460700003)(47076005)(54906003)(31696002)(86362001)(40480700001)(82310400005)(478600001)(26005)(186003)(36860700001)(966005)(356005)(7636003)(82740400003)(336012)(426003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2023 10:22:13.0528
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 178e5f3a-c3a6-467a-bf5c-08db717836c4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015C8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9258
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

On Mon, 19 Jun 2023 12:26:58 +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.3.9 release.
> There are 187 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 21 Jun 2023 10:21:12 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.3.9-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.3.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

All tests passing for Tegra ...

Test results for stable-v6.3:
    11 builds:	11 pass, 0 fail
    28 boots:	28 pass, 0 fail
    130 tests:	130 pass, 0 fail

Linux version:	6.3.9-rc1-gc4f2a2d855d4
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
