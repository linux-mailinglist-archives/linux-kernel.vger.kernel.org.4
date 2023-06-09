Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05C33729FF2
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 18:18:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241993AbjFIQSO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 12:18:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242099AbjFIQSJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 12:18:09 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2073.outbound.protection.outlook.com [40.107.92.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F90F35A7;
        Fri,  9 Jun 2023 09:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ca9iqwK2cW7sS8axN8XhbZR0zI5PVa1cSZpuzhX7Dl4=;
 b=U+0Pmblelvt78+DZiAD+XrmMM9vG46qglvaEomfYLd9mIjG6tJ0KZLqPx4qs+a7SW0oS83p01GhvXwHEcy+FZiYPXcIXGUyzSyLaJrv0B5wHxU5K6GnxWaKc+SPa8pFTFgc/sqfHNXr3nze8WGJCgvw3YfHVrGWP4oBS9QTtCsDaLuth5rX79OA+YJewbjLSKGKN6IlAIQMTLUgxaRJCXxnSgPVffqRknaB1Cbbz07jB6hH0M7nTR8E3d+XGemVFh9SsW0BDONahZcdCAMzPRtkOwuLYETOHWtG7yam1MWssPf7DwefUCzUo1UuFeZqJlXf2feSksY+/QqmruO7GLg==
Received: from SN7PR18CA0025.namprd18.prod.outlook.com (2603:10b6:806:f3::29)
 by CH0PR12MB5026.namprd12.prod.outlook.com (2603:10b6:610:e1::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Fri, 9 Jun
 2023 16:18:06 +0000
Received: from SN1PEPF00026367.namprd02.prod.outlook.com
 (2603:10b6:806:f3:cafe::23) by SN7PR18CA0025.outlook.office365.com
 (2603:10b6:806:f3::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.29 via Frontend
 Transport; Fri, 9 Jun 2023 16:18:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF00026367.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6477.24 via Frontend Transport; Fri, 9 Jun 2023 16:18:05 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Fri, 9 Jun 2023
 09:17:50 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Fri, 9 Jun 2023
 09:17:50 -0700
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Fri, 9 Jun 2023 09:17:50 -0700
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
Subject: Re: [PATCH 5.10 000/120] 5.10.183-rc1 review
In-Reply-To: <20230607200900.915613242@linuxfoundation.org>
References: <20230607200900.915613242@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <332ce2c6-2c28-45bb-b5a1-d06103861d48@rnnvmail204.nvidia.com>
Date:   Fri, 9 Jun 2023 09:17:50 -0700
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00026367:EE_|CH0PR12MB5026:EE_
X-MS-Office365-Filtering-Correlation-Id: b80eeea0-6a04-4b4a-493c-08db69051b8d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BtKCGVEmHNomhshdK/rk0rSZDOc/rWbjR8sHhKMdeWOOu63BFAwtPfLKNzv+/2alxOmTyyOrXFjC0j4nzPk00D/G0ScNROeBiUwi4YyncU3jF1fMfamuCl03kpxEO/GB+5ECuZ812bbf67dgPsHk7xjL+uohoHkOp2za8uXnSq8iqNXEdRvQLIYRbvIYidhneuZ/gl5X3aVyrkR4N0K6QWh6yBxunvL0vPmyXXZxOErK9uN3fUTCAjCg8ebqS9PFo8eMsiu5WKVcJbN3FNZEVWieytnYCMND9Z1jIU6E7ujoDpg9zTmd6aTp1XTobY34ZQJxBvE/wAX2ZwS+khiTdHHlY40bpSjbwAuHltM9zRBpPwtN+ya5DpcYvzNxL/Z9Wmk//sVHrl6gWObz2TnDk8e1PV3YXjqPKIEBWOHt01OyncoB+LCUMQI0f6FOwzSwXs+qZ+q+MYa01mmlkn2OrEZ9QWMI0FPoHc/S2Kk3H3NRi5qrP+Z/HZQAdZlJ0cg0ZnuVJKf/hk4WM3krz9edGNvv7yy9qoB25c4SuHjTMuF+L7kiUCrWKW34Q/H6WVrEPD0EvVoCQR+vxCgZBFITYwx+oCp+61aZYVT4bLn1VLHsU/ktuHS6CTXxGhSltTSjqMT0mO18rzC7QVwY9gUamIiAdbrAbqJ9BWv1VOzv28Q7moH5zVeDeDJ89g3Iluc8bI0425Sq3PLInv4Muce01PCB4ZkwoY136x+I4KsthATCWGj92/dZcgJ37/Y7rRUcAKebajAMBIXXzGeqF7UjxdG+dCXaStJ6uTyn/wvK9Y8=
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(396003)(39860400002)(376002)(451199021)(36840700001)(46966006)(40470700004)(70586007)(70206006)(356005)(2906002)(426003)(41300700001)(7636003)(316002)(31696002)(5660300002)(47076005)(86362001)(7416002)(336012)(36860700001)(8676002)(40480700001)(82310400005)(8936002)(966005)(6916009)(4326008)(40460700003)(26005)(478600001)(31686004)(82740400003)(186003)(54906003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2023 16:18:05.9648
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b80eeea0-6a04-4b4a-493c-08db69051b8d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00026367.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5026
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

On Wed, 07 Jun 2023 22:15:16 +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.183 release.
> There are 120 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 09 Jun 2023 20:07:31 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.183-rc1.gz
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

Linux version:	5.10.183-rc1-gea69b726b972
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
