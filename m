Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2E0364592E
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 12:43:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229928AbiLGLnZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 06:43:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbiLGLnW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 06:43:22 -0500
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2042.outbound.protection.outlook.com [40.107.96.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 684AC25E90;
        Wed,  7 Dec 2022 03:43:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T8lXrDE2UPKbA/7rarrKXn1GsE0aXw0OnKKock7ex0Ku9Gsl5DUhTLKVRww+DS1DgtvWwH4O5PUCXkYQqD7eIQAjnaobEFZvGvtoO1XBwKodvxFJyjf6iZA3yA43eog4/lXFhI6avRO+5fyh7EHxR/qNawpi96X8cva+8mGerAEcKuNity2XGyocHItaQCR50DOtq9hMUdslx6MNCl/LvkrGyuWxPTfBQyxhzTIetjw/ufv6cE2/vjpz1zESMGcUrbNbIZhWBLUJRkG0BDxYPAkHTSL+UGXoBkQbSmzpaus11n2PqRgV0GMUtx4WFc4itaxb7tdjp41Lmsc3xnVHbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YFsenu3ZyjClgd7ekOezl1at3E+5AB24TCFiJ4Dk/rU=;
 b=i6j3e8S5895hIlykdHOBDEhBj7VHXAuSxaz6U0VYDULwxPVBUbQgooD6SjReU0f3SnBqLdCUPX8puWpUveKuWHi1U91AtJpogSM4eHoSjLZ/geduVJWWSttACqNzwpORAq1PPD78qMfsj96jE8+MMGmAwxJALsVmMYuupMkIFjSWWVNw2gYTxnZbUSlrn8bLvHQUgU8gKne9/nKmpqt2MAUClG2TihW/rcBmczHVpYeH3R3PJpXigOn5Zvt5wASQ+G/qeGes2vXknbNZKUCLLJ9JGWr7lh/VEzuSyyb+87Efx+xyQHXnJ/bhW/v73r3fKwYVlWfM6Mv/7UDlxnfkwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YFsenu3ZyjClgd7ekOezl1at3E+5AB24TCFiJ4Dk/rU=;
 b=jYb2r4gDDSB8C6rs5TkDM4j4BAqr9Q1GTlfxkm6StVJVt721wlhx9fH+PJ2wW67VxAmZ6URDnb5O4e627PETg3N8kCGqCxuEcGhkMylRrW4Jpav2ycbGWtKZxqzldfjV+5xu4u5S/7z/Ex5hYPvK5GYeFCWx08WQEG/UgNK/j53YvxBnhVZv6RKxlaXbL40bmtCVsUurSlbPd6zE8keWzGxhNV+TjVGuObXRBqyxntDPIILUVrWAa/EZzGM+gCSDfErfON5Mi4eTWx56hb60SiAcCbVcX8ztuV6IiWSrWPhganbz6Wbc6f7Qh1P683xYAO77QRxyHruU72ZoXkdK1w==
Received: from DM6PR02CA0103.namprd02.prod.outlook.com (2603:10b6:5:1f4::44)
 by SN7PR12MB7348.namprd12.prod.outlook.com (2603:10b6:806:29b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Wed, 7 Dec
 2022 11:43:19 +0000
Received: from DM6NAM11FT091.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1f4:cafe::65) by DM6PR02CA0103.outlook.office365.com
 (2603:10b6:5:1f4::44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14 via Frontend
 Transport; Wed, 7 Dec 2022 11:43:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DM6NAM11FT091.mail.protection.outlook.com (10.13.173.108) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5901.14 via Frontend Transport; Wed, 7 Dec 2022 11:43:19 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Wed, 7 Dec 2022
 03:43:06 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Wed, 7 Dec 2022
 03:43:06 -0800
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36 via Frontend
 Transport; Wed, 7 Dec 2022 03:43:06 -0800
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
Subject: Re: [PATCH 5.15 000/121] 5.15.82-rc3 review
In-Reply-To: <20221206163439.841627689@linuxfoundation.org>
References: <20221206163439.841627689@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <fc6a9e74-2cc8-4ade-a87e-11a4fceff2c2@rnnvmail204.nvidia.com>
Date:   Wed, 7 Dec 2022 03:43:06 -0800
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT091:EE_|SN7PR12MB7348:EE_
X-MS-Office365-Filtering-Correlation-Id: 57969840-7731-4379-7a5c-08dad8483cee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EBe7hOOkAXReRZpziyBRhijTsMH6hwR2uUVxapeowWbBCuDTH9OMdmkXQ4CCLdVpaTOkiMS44Et68X9Cy9MD37K9v6yNDQC2xTBtgm99qsN+sp1XHDNDm4oqpABS5oIhNIRxQY3I4fuPU+vCJFcL6XyWSdRtDEWygDEqTMUj59izz8VzET4hpivauJRHI2TdO5ELngUEOKU+IP6dXhj2e38bwnLkVB8jVLUR5BwULnlhPsR42HwX+asT01XjNsdvTizkZ/DyK6WnXzgwxaibHsVJ+TGsiHriuX8XYSGEcCJiEe4gOz+tOIR3j4xHxOM22qBxrcoDmZkEMLacWv4iIvRJPPzqVj8kt9zvJGOA5+j8jL49rITp7MjNDUNCBvIHSh5oY9U8C1M0WQuXmZVTYotWooCyMYuqLHXl5W8Hm4lxl2Ode7bSSmtwnR3+bYaWWqWw3RgO8vNER45K69p+8NSoZGEqe3CKe/5U7LOawQYFcjWq6xV/M3V3rOpfAtO5R10z5Ikik+goxXFoGo6vqm4IvrfFC/mCFelWNunsXHvnSpHzG56bilPlk5ftN5qddSvqUSI9+5gKSjza1qPE/MwE1vZ1nyagS24I5yXOvXK+6YqhXRn6CgPvc+Yi/pOc+zZ8XpQG3Htm1E5C0jeUXX6VIujHXqeE8DFdaiSqVxfbevwnG6lnJQEl9riGCj6URXNn/vIYZL/SqMxTdTSvfTxCAwFTJVhIGX/M5yFul+5dqUr9NmIyXk4418F5n7vKm06tQHPjtIDbTCGUWhb3oIE6w9u5+SzH0MgEetDBhJg=
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(346002)(39860400002)(396003)(136003)(376002)(451199015)(46966006)(40470700004)(36840700001)(8936002)(7416002)(2906002)(86362001)(31696002)(5660300002)(426003)(336012)(41300700001)(186003)(47076005)(316002)(6916009)(478600001)(54906003)(966005)(26005)(82740400003)(7636003)(356005)(40460700003)(4326008)(8676002)(70206006)(36860700001)(70586007)(31686004)(82310400005)(40480700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2022 11:43:19.6290
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 57969840-7731-4379-7a5c-08dad8483cee
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT091.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7348
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 06 Dec 2022 17:39:55 +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.82 release.
> There are 121 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 08 Dec 2022 16:34:23 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.82-rc3.gz
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

Linux version:	5.15.82-rc3-gc5f8d4a5d3c8
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
