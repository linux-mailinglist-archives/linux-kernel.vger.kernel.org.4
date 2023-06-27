Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 054E573F820
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 11:05:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231339AbjF0JEv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 05:04:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229982AbjF0JEp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 05:04:45 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2043.outbound.protection.outlook.com [40.107.212.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B33710C9;
        Tue, 27 Jun 2023 02:04:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vogx0Nw4TgVXRS/hDzzqyacGZHIDxRN7ZB4c8chim+EyztrekLNs3ow4b0zfvY4w7hKt5nuGeuXyD6fk/393f9MtDa6XO8y0huR4dYnuf0/YJF9fO5iYjL179urq1NjJ8u3fy+zhoahwzQJmrYkoPB9sNKlfpYl8VQ2ehk2NEk8IOeJ9t5mXZlfmVHECJtKSKNv/YxWaRT38R6oSmG7/e3xNlMkLB29uhEHwYiGaTMNHD72TO5U25Gmr/ya8jbV+zJd3WQlDKy3+kcUYkVIOIfObDPkxU49iPXtEpHGUpftTY/f+1nCjio8oIZ4B36nUxiJBbchvVC+CFHc+Uo+Kkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XzB8O6sNEgXfAXOnyc8QlBHiSSuVfip2SHJBYbM+AOQ=;
 b=NMX3vguD9/Aq7JeSi2Ap+8yMXq930U82mOGT4JQwjT1t6pVERwyUatMLSY94GWP8bpujjIQzmH47WpTPvVVcY7oaZRsd860LhRtlFfhrdXJbajKWLJLsvFz5rmdR3vvZjo05AM6f2rSty9wqvhUd8+6j3mMpzcbJNXE+vABwXTkedxbne2c+52bJHqotxfg520DJAoX3+segwnOC9dBF+ouIVOCitTX6GnQmnAFlq9IiHRR2rbQgGZaJiLvBS19if6Ws6sArfHa8VFsYfUk+Nf1yOqrZlyZtWH/7bell9VmeWDIT6ACiVxmaNNY+9KFe+DL4mrU3Vm5ywff/RUw6uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XzB8O6sNEgXfAXOnyc8QlBHiSSuVfip2SHJBYbM+AOQ=;
 b=J5rwfvM0jEUDsXCmk7dKFbsHKLN+JJGv8ofwqzGMTY8iNPtfdFM5sMQY5Szkcal7oT68Fw/qCIZ44+9G53EOyA4fMGhHXreYGf1xjbAKca5qZ48YzB0cc1ykoTOrZmOikIi4UiXUhQJAyck0uXZ8T1ci2q9f1LWk6XXdVrZ0QGL2qHQ6FtLjkvnCyYFgWVdvHdFCrRdhICQQgAmIR6PtG79Nti9eSv1o+FPuUFlDqLngBgksxFTS+D7TeFqJv0x2Nc3WGCrPzF5omdNqJiPAr75nMZmiXHjj/mgiGfQcVlwz7r+3upPlqVG6CeOYmDFsW9iOKuR6QVZpr3s4b0H1nA==
Received: from MW4PR04CA0172.namprd04.prod.outlook.com (2603:10b6:303:85::27)
 by DS0PR12MB8815.namprd12.prod.outlook.com (2603:10b6:8:14f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Tue, 27 Jun
 2023 09:04:42 +0000
Received: from CO1NAM11FT066.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:85:cafe::e1) by MW4PR04CA0172.outlook.office365.com
 (2603:10b6:303:85::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.34 via Frontend
 Transport; Tue, 27 Jun 2023 09:04:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CO1NAM11FT066.mail.protection.outlook.com (10.13.175.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6500.47 via Frontend Transport; Tue, 27 Jun 2023 09:04:41 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Tue, 27 Jun 2023
 02:04:30 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Tue, 27 Jun 2023 02:04:30 -0700
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Tue, 27 Jun 2023 02:04:30 -0700
From:   Jon Hunter <jonathanh@nvidia.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <patches@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        <torvalds@linux-foundation.org>, <akpm@linux-foundation.org>,
        <linux@roeck-us.net>, <shuah@kernel.org>, <patches@kernelci.org>,
        <lkft-triage@lists.linaro.org>, <pavel@denx.de>,
        <jonathanh@nvidia.com>, <f.fainelli@gmail.com>,
        <sudipm.mukherjee@gmail.com>, <srw@sladewatkins.net>,
        <rwarsow@gmx.de>, <conor@kernel.org>,
        <linux-tegra@vger.kernel.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH 5.10 00/81] 5.10.186-rc1 review
In-Reply-To: <20230626180744.453069285@linuxfoundation.org>
References: <20230626180744.453069285@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <1faf3944-6b79-4b20-9642-f777b1e4e207@drhqmail202.nvidia.com>
Date:   Tue, 27 Jun 2023 02:04:30 -0700
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT066:EE_|DS0PR12MB8815:EE_
X-MS-Office365-Filtering-Correlation-Id: 868b9c6b-2976-420d-ab91-08db76ed8b3f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lFKQuDHOvPFF0EAwxJDC0P+r+JCxcxgVN0ak1QcUEUlVpV938ha1BWyQewL3liYau9pIfypZ8e1CCr34OiU6AbfcLVJfWZ+O4uZFE+W320i9CdnnDLg3b3/4Z6Ca4yAt+LdWnh9xjb/YcLTAPl/s/+3Mp3ZVu1oZH/w0cPeAbhu/SwW4eCZnNHSFoqsAq1Mp4/9Bky1rfXWKIhRonq3q2XQXwzPkD5D0Ej+RaoRdkOHq4a9+3KA7fvCzNu3i3NIwTEAXLKvIw+P9EwIRNAtIvbiS47aY3ixbMgdPzP1cPVXLc3xTT/4nYNsEglkvEfsFZRQpyJWYa49Bc7n0LU5fKJJm2x+5/2e6Hf9/2KSXNDEB6fQ74P4T/ij3p/g2QUmra8qqWszr7Y5007vVUog3jHuL+dedg1OeP/7L0zvYo+ATVkYP0w9fQLU4BcEoEzer/7oQwOeqiJGcIvKQwCW8UC0jBuCgz/g3xTS5CByQgZoY5T/UmqdCOvhBOFTKkmAoQelJldRakPWyWcQS1hypoSHJw89tzVj/9KH2U1HARrtQDPM1AOoQsHvw7cl04+2HK5EOzBrXMN/R8RupVAR4t1HOHiwIiiei0S11bfnoldiIXwoOAgw3Y+DdPxqTmcPj81qjORHxmHlTC+MFjLf6JN58YJrMup5w43TUvv1ZwusjBQj47juVopqTih0llTPCU3ZM9vazjyFYDA0ww4ZxOFeUdp3gkbwxjpdwLmBdY0a8SgH34SmpjlGkhma/5XFQFO240BZAp57TkqWDdCjtH/iTJO4Hf7pxM/7ZSwX/SXs=
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(136003)(39860400002)(376002)(451199021)(40470700004)(36840700001)(46966006)(36860700001)(82310400005)(47076005)(966005)(54906003)(336012)(426003)(26005)(2906002)(478600001)(186003)(5660300002)(356005)(40460700003)(70206006)(7416002)(4326008)(70586007)(316002)(82740400003)(31696002)(7636003)(40480700001)(41300700001)(8936002)(8676002)(86362001)(6916009)(31686004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2023 09:04:41.7652
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 868b9c6b-2976-420d-ab91-08db76ed8b3f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT066.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8815
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

On Mon, 26 Jun 2023 20:11:42 +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.186 release.
> There are 81 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 28 Jun 2023 18:07:23 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.186-rc1.gz
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

Linux version:	5.10.186-rc1-gf7aacfe10a25
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
