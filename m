Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF3CA6FC807
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 15:36:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235552AbjEINgj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 09:36:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235550AbjEINgd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 09:36:33 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2085.outbound.protection.outlook.com [40.107.223.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECE3D422F;
        Tue,  9 May 2023 06:36:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hqf6bv4cFPKdOcGIdX8ZWUl7Lm77mH1UYiRWPh/TLKvXOsBAzuXZvvM/zWOJS+xKBJrazAGJZFXOY60WvRgqHVfnS6E86TaQrJFEqNnhqYh3MEK+FL9ovYDvnbpIG6TbSTVIkqEQwPg1CZY50LY4tq3woU43YZMAZPkrNEtMIIz5L5IT2s+ejp7eFZexq+yhyEq/0XoCn70nJbT+iYP2K0yucelke4wd8rG0hs9TFZRV4jjclRY7vBk8FTuLiRoqxBpeDzGzUWqyrY0vWzsnCFjgRG4olB0L8tQZI4VGdkeKoE5dip7Cy6dPZsbih6V/xGNDUz4Dq2iECpi7fUAeKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FG08F2lkcC8zZ3uMcTZY61JIcuOx5gxk8ydU4n9r9D4=;
 b=mmeL1h8ENTNMy4ZwMCznjl+Hr9avBlXDgL69Jz/X3yKEBceqG+J15vXdgIjswnMi+gRhOdyYry2exAy+Y9DjIutJhGVV0/E8X+BbWvFGhvXG1GJ4vEXO4XSVgoZukLxt7DLFdfhrUp8Brci5K9gTaAUxuBWBwuESfwtRXl10rkReBoCcrQokOskgOvIn0wyUt4CyD9zR3KXGVUASMzz6A7Gz8F108/iBUKUz4eFTKPpxBEhQ3vAYDuPCvi2M9Tc4InhXFMYh2Oyx6dvXgzUYtLx+olxax7fziTmqnqPpdmJpNo0iwK9JXze6DjF6LyZd6VKi+qsCmUs295WyFQHF/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FG08F2lkcC8zZ3uMcTZY61JIcuOx5gxk8ydU4n9r9D4=;
 b=R1iuphL8bPxKGY0NjpiA1kDxsExp5MDBXkPxbXLLH8gVPZTpBkE6U81FZfPY6hVrlFV5eN9wKz1j/yfcrzqfXnIOasW299vNZAS4fIZF6jhyLBVjiTybayLdsyuVlzvUMUyYraaC+UHV8ZFMpru8Tv0qHy02Jxz7ZYW64Ss9azkmcM59CsbSHLdHDRKI56qmJasUQxq1FoKAYNtTIXOJLwyECvlijvSbwKcZsk5OF7PybGP4KHMxhYhJ3Ke6oZczYNoGCbaxppSw52duUw5ewaGFEXOpPQY9DolldHrWETMPRMlkKzzeD56bBcFXyTU2ppz6+B1Rt7MM7uTiTbmFVw==
Received: from SJ2PR07CA0014.namprd07.prod.outlook.com (2603:10b6:a03:505::7)
 by MN0PR12MB6053.namprd12.prod.outlook.com (2603:10b6:208:3cf::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32; Tue, 9 May
 2023 13:36:20 +0000
Received: from DM6NAM11FT004.eop-nam11.prod.protection.outlook.com
 (2603:10b6:a03:505:cafe::99) by SJ2PR07CA0014.outlook.office365.com
 (2603:10b6:a03:505::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.34 via Frontend
 Transport; Tue, 9 May 2023 13:36:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 DM6NAM11FT004.mail.protection.outlook.com (10.13.172.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6363.33 via Frontend Transport; Tue, 9 May 2023 13:36:19 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Tue, 9 May 2023
 06:36:08 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Tue, 9 May 2023 06:36:08 -0700
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Tue, 9 May 2023 06:36:08 -0700
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
Subject: Re: [PATCH 6.3 000/694] 6.3.2-rc2 review
In-Reply-To: <20230509030705.399628514@linuxfoundation.org>
References: <20230509030705.399628514@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <30c9cf10-2f20-4537-9bb6-b54dd3603832@drhqmail203.nvidia.com>
Date:   Tue, 9 May 2023 06:36:08 -0700
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT004:EE_|MN0PR12MB6053:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d10fc4e-3dc6-4120-416d-08db50925f23
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Vca4KA5XJQTWcuTzcFixhsoN9n2nv/6QT6m5TsxQu03N2cV1oTq2LZWCSDpWf5UxfEYqFdcSMI4FnbfaMVZt+urP4aFbrEd3FHZjY8FbO/+mDe0d6qrCwUB5+cQ/0dWnsYuQ9wcwhUYPF5m7Cl8OdrkuVs3VO20iXtCkTI3JdI88LM2TB8CbEE9SaoUTWUrAPWth5RJBycnrho+Sd2OW2yzM2Q75maghljMt9pYXtvYHmtL65iePmxJMGkrmvxa1COhCDwYTTdMvGsc7yWMPf1t9bjSWd6rsMVIbvBF7T7dta//MzlO6MAievfLk+jURwLbTVfnp+N0asHFY+PoP9gdlweYHEFItNtPmW4MHUF0K/gvsX9bXEgjsN2QZHpBeXG5p5bQ1MxOYaAUIwbJMcawpR1BcNy+jV+70/qCIAT+LzBhPfHOIYb+K+xsJFAUc+9Mb0rQRRDgTLAmY5iCvRweKWngudZaTf1wP93Ga00nhaIVsa2rhoEUKwVmXYO3tGoSUpwV9RL+PdzRL7yKzLxH0my4pmtw71n2teCunm2IogqFUVAiqYogVKKqRWZRv6kY9/fD4fuqc6U01NyorGnYyxYUpktBIu/HFuIAs56ihwYCWBHjs29I83FMgThVGF9yzyKhbSKQTK5SAf9ldQlK639bGlUcHKzUcWpmWM8cPDOLngYAYPVQDBqgs10W1+lOtmikzWc6v2z2s5C7/4JuVdcqfwzbNGHQ72NI7Z7H6Xzl4e3lifeZIlj3PAz6r
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(39860400002)(376002)(136003)(451199021)(46966006)(40470700004)(36840700001)(47076005)(36860700001)(426003)(336012)(31686004)(40460700003)(40480700001)(26005)(86362001)(70586007)(70206006)(316002)(82740400003)(6916009)(2906002)(4326008)(31696002)(7416002)(356005)(41300700001)(7636003)(82310400005)(186003)(478600001)(8676002)(5660300002)(966005)(8936002)(54906003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2023 13:36:19.3244
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d10fc4e-3dc6-4120-416d-08db50925f23
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT004.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6053
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

On Tue, 09 May 2023 05:26:44 +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.3.2 release.
> There are 694 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 11 May 2023 03:05:05 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.3.2-rc2.gz
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

Linux version:	6.3.2-rc2-gf1bb4e945e52
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
