Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5CBA6D5CBF
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 12:12:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234328AbjDDKMK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 06:12:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233732AbjDDKMF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 06:12:05 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2049.outbound.protection.outlook.com [40.107.92.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38B4E2735;
        Tue,  4 Apr 2023 03:11:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lUxz2XWYofUpXzS02g7r/4upgDHwT5N6ZfKcDBFdkna6IgqYrTzHZgrLCsuKGyfA/DhJx3YxM85zJa0SxgADAI7ADsWj7O4sZ+hhQ0mWmDUd+wqtDUuoC9ZM0/mmI/r11qH9eXRNhlYRKdpH1oVTS3fdD9IELRxmfITuHU0WtDwloXLmlJKGkbvwrxmYZ8cPOscMuqNQRH4kLp7L3mST0kBlxxMH+bpTtbIg8LJcLTAF3bB60mZLmG/ZU6DR4N2jDZlllizmMOJ0clS4Fd2tPC4QwxRZcSBa9J9Leo0L+r9brT5dN5/D4H98cU6vYEq8SytvUSBpVHQpZE6PsB0ndw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WlGVa0lA6Tt6r4WaLe8aaV8zAQO54x/S6XQxRD7ZF7U=;
 b=LP/ul3pnMkJKV0ZQuIBY3Qc+Jfa5P4UmiojJ48GPIDo1CFATCBv/NnFhSzwL6uTDbFzCBteynST86u90DcDp96mlitvyiHgYjVjhUX1ebGHxup05QWP+J2ddwi8gFuzoP6aYX4vjEw9UFXh2kFnc7GX+rF9nVijJJxnrBg7oe+aoGvt6YVY701qoLvHZTAnfLvRp/2U8X53fW3YG0Fn3RbYT0KI2YnFfqDsgWRxokCIo5+BfySIyDistfMlc8nriAqxI9JY4Pa5j2nUDf6T3hvQBKwFs0XNjEGJs8cm4srIWcjaHVPrHWgZu0A9a3cVhdAEeq+s5GlASKAtNcoPDkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WlGVa0lA6Tt6r4WaLe8aaV8zAQO54x/S6XQxRD7ZF7U=;
 b=Zn1TCZTcViQimR9rd95FlZL3fHjIm+1+OQIiNIwwSLXXksulX1eDpOFd5/xR92Mgu8gQYGAl4DsqstZivQfJyXnBcmTKpKWm7xh69cSeeREB3us/QQg5EqU8On2kJPe54YbFoIp1/H2pSMmDj2CiLe9Hg9msh4zpNI1ILFI7vEvNJ4E/I+KXkhfPMKMXamRAgc0rNVHJlAzauYuvq8GwC+poRxlcK6w8mOGxnfc/cN4gA3ca63ccvZcYb+8/nn7S2qEc8G+oC/rlUg7CeFBk25ZvyQ8Ej6gW8/VPtPf1AjMwB2FMZ6jzdsT6xQWN16O75eDklDmmek8zfL9qfX3w1Q==
Received: from DM6PR06CA0062.namprd06.prod.outlook.com (2603:10b6:5:54::39) by
 CH2PR12MB4905.namprd12.prod.outlook.com (2603:10b6:610:64::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6254.33; Tue, 4 Apr 2023 10:11:35 +0000
Received: from DM6NAM11FT057.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:54:cafe::e3) by DM6PR06CA0062.outlook.office365.com
 (2603:10b6:5:54::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.20 via Frontend
 Transport; Tue, 4 Apr 2023 10:11:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DM6NAM11FT057.mail.protection.outlook.com (10.13.172.252) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6277.28 via Frontend Transport; Tue, 4 Apr 2023 10:11:34 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Tue, 4 Apr 2023
 03:11:24 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Tue, 4 Apr 2023 03:11:23 -0700
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Tue, 4 Apr 2023 03:11:23 -0700
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
Subject: Re: [PATCH 4.14 00/66] 4.14.312-rc1 review
In-Reply-To: <20230403140351.636471867@linuxfoundation.org>
References: <20230403140351.636471867@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <a5075360-4ad8-467c-a61b-ffa180109443@drhqmail203.nvidia.com>
Date:   Tue, 4 Apr 2023 03:11:23 -0700
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT057:EE_|CH2PR12MB4905:EE_
X-MS-Office365-Filtering-Correlation-Id: c2bcc754-4104-41ed-4d44-08db34f4f896
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: q63bpcGnDdX5jGhNW5qZTgUpAm02PX+fMQN3GWJGb5oqEuOTHIOAxIO5EnIEXEfUUHWPr2zPKsvSAlGFYcxmzbHgSpROgHfJ87v/UHF8amneoQbbMrDPBsH9zy56DR4LKJ3Jw6AsPAaW1+jutyJ1+YACeP5bgvxP3okM+w6ilfBtbdMsp7xbqgyHHTQq3GdioLvXKqI1JpWv38LDMesYpHd5JsZOjj81Ykr8KkFXurxmpkTgT4vToakDcclTtKP4uSLkr8wwfpcywUdVmgDWUeg15HZlgYYzyfYrOMPFBGLAOTGRsxpSo2thJfkW62ue/PZ5WU/zdup0MZL3tATtY0iy0eWViqIOsQk1h0X7VKtaqF2KyA/apYP0mv3+gOmJgKScpEccob3fCt3c1dXoq6zvVm/tY5BRMLW0cxPe7vCNOvtkMDXbrwdrWYglBT/gJ2z4LzzlLMcZGkdCvvliTT33ZcCDzUWE7lahMiqRJWmhRg4FX/oU0qCyXbK98O1vko27gnQ9sTwMyF6wlHNs5txKmVDstJqCsEhB0hVDi8ug9nfcdHAXtKcRvAQCE1Z7/y+pVUNF7JQWFdz587vNVktL96W389Smd8NuZa+ivpx2aZGhigtkZTaEioACnjOZYeqWY9RWft2t2L3kzb4IOEr+UZKPrqOrxNpta3z9FQDLrzz6o1d4pqcaWJWFNszz+2ylKE3tPLIpjchSZLhL7HNzkf5OctZ+6hkWSIe0WrkzmWnz9rQkNxDcEEq52FENRzzH8L4qjBciJhEARoJF+CPpFwbHH4AN8cXhbdl386w=
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(39860400002)(396003)(376002)(451199021)(36840700001)(46966006)(40470700004)(40480700001)(40460700003)(54906003)(36860700001)(4326008)(70206006)(70586007)(478600001)(6916009)(8676002)(8936002)(316002)(356005)(5660300002)(7416002)(41300700001)(7636003)(82740400003)(426003)(186003)(47076005)(336012)(966005)(26005)(31696002)(86362001)(82310400005)(2906002)(31686004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2023 10:11:34.8915
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c2bcc754-4104-41ed-4d44-08db34f4f896
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT057.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4905
X-Spam-Status: No, score=0.8 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 03 Apr 2023 16:08:08 +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.312 release.
> There are 66 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 05 Apr 2023 14:03:18 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.312-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.14.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

All tests passing for Tegra ...

Test results for stable-v4.14:
    8 builds:	8 pass, 0 fail
    16 boots:	16 pass, 0 fail
    32 tests:	32 pass, 0 fail

Linux version:	4.14.312-rc1-gf4c3927dd933
Boards tested:	tegra124-jetson-tk1, tegra20-ventana,
                tegra210-p2371-2180, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
