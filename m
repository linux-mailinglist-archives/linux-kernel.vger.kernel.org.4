Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BB677061DA
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 09:55:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230262AbjEQHzw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 03:55:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230306AbjEQHz3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 03:55:29 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2060.outbound.protection.outlook.com [40.107.223.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 727D51701;
        Wed, 17 May 2023 00:55:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=krbHxr482M/MIc7XQTdcXbB8CCPqWal346flJQgWCbk3xMlO/d3NDnk+ZfU9NXEE4QnRDEiGaDLO1ph1cHP1QcBy7HhX+f4qx89sQocY3Juyux+CRKyjM5G93HFWG15JRZCkfw42h7H5EJxewOnaYmUUaqt1RRkRzB68u+IJ3foLBW7fwyJUYfkNE79VEONIQEzcHFv1oLhOpbGQGATqrwHlWNUsym04ymkTIRX5c6vS2LNDZzVv6BD2txfMS07x3oyPUGoe5IRCw4L9udf1hCMxfk5Tbj4pGlWS3ynY3TlzF2Um48uSiniJEnelIdQFzk1TsoJbY1BuGPmO4GrvYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hvns2H5iIHknQ5tzo4koj6f5jOesEjO0XK2Ndi36mVQ=;
 b=k4chrB/mjl3aelXQuIbvYriz+UdGVPdP0Ttb7U0XsSj6ggqcZFvq9CGQoRZwqvVLQ7NIhMbAhebvDMrPYhaY8EYHQtiyN/Vc2YjMO0/GsrtHr5qiTfypnuyKZRDsDssD+yfTFkYPTQ3AFS8m9ZAVp9uo1rAB5iPMai6w0TYqd3dcQ8xXxrNB1NFEpFtksKc+uet5mDnEcu4Cys4VITEn+vyEcGvH53eSEQpDwJAcz7FJMJCBsQzl+wBcyBrIfMbn0ns7XX6umYx1eqysEn3yh5IP04I/0xEfnNv3aGQ1WLgfzG1WBZNFBAMJLAvVCp9WclJ+3PrA+Y7tZ+NLbydOcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hvns2H5iIHknQ5tzo4koj6f5jOesEjO0XK2Ndi36mVQ=;
 b=uZavqqA6hDwxAi5cG4/OXuAwyIrtfC0zciKU2/aQAojSmmH/p7rPBjV/sRoE0koA/u5WC34rmqYVcU0dmRJc2ZYx9/clXPFRRYgagVA9MC6RWyiwWBw+QRFH4PwST53Zi0BCNrghueOUC5ucUpuHdA9NaxT2V7oWTJhO99aj2qoiLILFUsTPy0sVgGSQX3FR7pS0+wFD/jHF6fEYT3l88YumEpGkHvWQSMLEwO5Sw5XO6pfQbK4LBq6J+nYG/0ShMlXeDyXRL7A2iTOviXtKEULoNv8Uc78ypzcyG4JPuNJFh/oVoPINFFvCSluMBc1El3P6sevucM6MLY2pqWdmFg==
Received: from MW3PR06CA0023.namprd06.prod.outlook.com (2603:10b6:303:2a::28)
 by BL1PR12MB5924.namprd12.prod.outlook.com (2603:10b6:208:39b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33; Wed, 17 May
 2023 07:55:26 +0000
Received: from CO1NAM11FT082.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:2a:cafe::c1) by MW3PR06CA0023.outlook.office365.com
 (2603:10b6:303:2a::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.34 via Frontend
 Transport; Wed, 17 May 2023 07:55:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1NAM11FT082.mail.protection.outlook.com (10.13.175.224) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6411.16 via Frontend Transport; Wed, 17 May 2023 07:55:25 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 17 May 2023
 00:55:10 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Wed, 17 May
 2023 00:55:10 -0700
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Wed, 17 May 2023 00:55:09 -0700
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
Subject: Re: [PATCH 5.4 000/282] 5.4.243-rc1 review
In-Reply-To: <20230515161722.146344674@linuxfoundation.org>
References: <20230515161722.146344674@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <6f184af8-b9c4-4f41-8c1c-ea2429a71b0e@rnnvmail202.nvidia.com>
Date:   Wed, 17 May 2023 00:55:09 -0700
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT082:EE_|BL1PR12MB5924:EE_
X-MS-Office365-Filtering-Correlation-Id: a93dae3d-ec29-4f5e-0aae-08db56ac133e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MgM/CvwWXC6kgGbBoejWl+umJfa2GxUELhLAb1rhqiuBN2yHK8PALzbStn9agooQrmrb2hqUaOP1XW6eriHK8+Ox1u5KKcde5APhFqhLiaRVrMe2ZXx9tBEYb1sVI1cWiMS39We32yZptkMfNJTLo6LM4YSfL+xznmCS6rJsciDJ9JXvun4CrcIGgsntRINu8F42gwKP6Rfrsvu8zPzbsB9lG581LQ4jLvDYJlc39f4z4GEVGcViNV4W5WLcfiNarOb2bQ19rDQIKYJqZiKT5Gql1r/WzBtR9Q9QgNbiA3oIXxHlOvl0NKV3tj9399WTNqH5eS/L4UhPMZFRzCnugaONWm5jUWy4NH8WN5RwlsGd3YJJDSgvZ35oPB+YmUybMFHhgiN/ewFoMVmVvZJvvcGNUUt6Vto4w1haT5MmdkguS8w8SRoJJYo+3wHpQIqcn0OEcXjLveV1ixnLyuTC4YP7BNqaTScjc0/z2cRV3uN8el+oum9B6s2NT4vAzm6p1Yqa2k70KaL01yDluaFeDNGd9zcMgNSRw8uh+nZJtxq/mxY8y3y2IuUNUJaV7EynmY7yurwmrzSoaPyEyGs83CE04b7JI6w52vWskhdnOUxIT3W23kftghNGYIhuHcKGME4u8hfKHO9pfYRaN8DF0kFxdBRILUWOgs5bLOh4QUYIbSI4fYRr23PhinyZ0Sq4JQ8WgyF2OmvNvsXkNbSbJRELfcRuYJstwiK/IhatUuDk0NOUK3+I7Za8yrsvXHWr
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(346002)(39860400002)(136003)(451199021)(46966006)(40470700004)(36840700001)(36860700001)(82740400003)(336012)(54906003)(86362001)(426003)(47076005)(478600001)(31696002)(356005)(7636003)(31686004)(966005)(186003)(40460700003)(26005)(40480700001)(6916009)(70586007)(70206006)(4326008)(5660300002)(82310400005)(316002)(2906002)(7416002)(41300700001)(8936002)(8676002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2023 07:55:25.9316
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a93dae3d-ec29-4f5e-0aae-08db56ac133e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT082.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5924
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

On Mon, 15 May 2023 18:26:18 +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.243 release.
> There are 282 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 17 May 2023 16:16:37 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.243-rc1.gz
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

Linux version:	5.4.243-rc1-gb6ac0ac1f533
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra20-ventana,
                tegra210-p2371-2180, tegra210-p3450-0000,
                tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
