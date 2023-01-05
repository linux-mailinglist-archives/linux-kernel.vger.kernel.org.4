Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A24365E5C9
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 08:02:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230495AbjAEHCo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 02:02:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230131AbjAEHCj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 02:02:39 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2050.outbound.protection.outlook.com [40.107.243.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44AB55F50;
        Wed,  4 Jan 2023 23:02:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y/V0JzWhS1E4JenRHSGhzqNxdpjj/DzSQNNEEBuKul9JjJQim9Y45pQxO2+K7zUBpcddoFIkjHp1IfTyijQtckFfZ1VyLpikz3BwxJ/8YnPeffFYhgRrMEhvYKDqIO9OvZngr22BabI7y3Howcr6RiyGhZhcf3OrOd3p/gxQj+ncyewtnp+WwLBqb/S27Nhfw39E2JCqM+MMzLKC7SimAcKPKfNesW6pfU0zqQdZ/e+VZqNc3XoUF1IptJ0Ix7onWZYqd0CGkY5cyVbwQvra0D8jXvnxrCbOmIhBtmb+UvQk6FuV4ssrSSYEsvPD5VBzLM0d6jsaZzs2sC+MwbAqcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6fAjF7B0LhH1AS492GQv0nieT5ZGsMfXNHNtyl92uBc=;
 b=cO0IIVEJqehpKyFDFZPy5y3YTnGkEGaRpgwofHGdKAtYpY7qhe6cxJz7OLUC/xysDWEQMUblRWvZuEHDYjdWoJh00WIA59eY749/JlH1f+VTseSHUuVTw8SpVIqHKLDBieJIN3jLdM+iz2PgredaQR2S94r9mNPu/ld08u80HBoM8Hl6ts722Nhs16I4khgLtvkDmJsOkJazETj0UiSu6Ni4LbIZP6UqPwC/jEyBV1MXWsOuY+SwN+FtO8n8TLlSoxJMYIq6i6gvDZ498IjVKt75ALWNiDAx6V/4ihqGLNkn8Wlt4/hH5fUl7qfcbwJ6fGoGH/xYuia1J4/hxlo7vA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6fAjF7B0LhH1AS492GQv0nieT5ZGsMfXNHNtyl92uBc=;
 b=FLr9W+hux8PgVutZTbmob5ckQt5o5o4oOqGnnx1OS4jwoMNtm9vPy+zL7gKLDCu0AGe7WZHrKSHNN/RxqrNT926R+gCHu/4/GLxv5goQA0wPu4RX5DPazP3hGFbEi2vqmKAbF2JSQNlSPEdRweE/+y3rmKad9gbRAFPWCGnc1jumTXy85ATW5760vij0BB9LG6AnNUG/1NGhFfAuWImpwgZ4923LGste7zqmsIAeFOQC1475V3xWYnsuPchTVwEJByPR308mIaYzoFGLQF47eW+NHEWHC0U+Lt05cbN7nBxrajVuUFLl70FgDO28h/RmW4XNVdRSbScfSa+5sQfGag==
Received: from DM6PR02CA0088.namprd02.prod.outlook.com (2603:10b6:5:1f4::29)
 by SJ1PR12MB6050.namprd12.prod.outlook.com (2603:10b6:a03:48b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Thu, 5 Jan
 2023 07:02:37 +0000
Received: from DM6NAM11FT082.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1f4:cafe::3) by DM6PR02CA0088.outlook.office365.com
 (2603:10b6:5:1f4::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.14 via Frontend
 Transport; Thu, 5 Jan 2023 07:02:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DM6NAM11FT082.mail.protection.outlook.com (10.13.173.107) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5966.17 via Frontend Transport; Thu, 5 Jan 2023 07:02:36 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Wed, 4 Jan 2023
 23:02:21 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Wed, 4 Jan 2023 23:02:20 -0800
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36 via Frontend
 Transport; Wed, 4 Jan 2023 23:02:20 -0800
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
Subject: Re: [PATCH 6.1 000/207] 6.1.4-rc1 review
In-Reply-To: <20230104160511.905925875@linuxfoundation.org>
References: <20230104160511.905925875@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <3be14d40-83f5-4c7a-908f-9be2e534ce12@drhqmail203.nvidia.com>
Date:   Wed, 4 Jan 2023 23:02:20 -0800
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT082:EE_|SJ1PR12MB6050:EE_
X-MS-Office365-Filtering-Correlation-Id: a79614d4-86f6-4704-a3c3-08daeeead3a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WrLzWRJoxWTr8hrKkMDRDduLemBbBx69Gs+MGU2lifTJeW63qoR5L3biKWdPjrnWjcfl4ltJfOjuh4clloo6Kt5C7zZho3nrvNWZY/ffAYcWFQsQZ2n97cNgTBbf3Do8otCTxd9Di4fQn1elc4g+aOvpL8YHEnN+TSeHxAuGbczu+JAUzXJRN02s5I6+VIBRKW5CxKQVSplnqQLoO8vd5Wx72t/3bFi7slyiKrUlw1JAdiV5SgzB3Orry7gy1Bs82biSWodMkljVft/F00Wtfib0Gsa01f13eIYNMkxY5pE1QEXywQ992y/1+2H2oB3S2rKc0R2t53RwJqH1em7fjR77rD9EJJRpdPKn8H10G7G7YOIoozlLpHX6IEJkj0kTWJ+tV6OgJ08L3bvpSuuptFr3fLOs2QxV8W87cE8L73GKETGXBYvspD0pISjOSZLwEAnBe3EKQnvYJNAffwWNTQCbalOD6MYmzHgeDgUtkPacBCY+3hc4y8Y8AmUjX+DWTCETpIR4lrYtzJYp93CA/9sxe/7cDt8NGiujBdR9zEHJBK8R+bpEKtg2648R5QL/wYUBVO/Zv/olPisMqZh7HYR+SLGmKbMRSogWqt1kbMiKJ+yxmbbWDrvS4qOd8bsQxsneOV3bnQ0hjMLwFyj+XrgRxa641BKwJBGzBhDEw2XLmww8AGI2q71IL2yujjo4xrizKdlRqTfXqWRhS+uxTavYUn8jKgI/Ic5UBmipKZ6n8pVFvM+RM0Gn8luRR8rHG2x/PBJZJqq9JA+U56KkFgkqmBcDHag9KX5OfJ76tyY=
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(396003)(136003)(376002)(346002)(451199015)(36840700001)(46966006)(40470700004)(8936002)(316002)(41300700001)(5660300002)(4326008)(8676002)(70586007)(7416002)(70206006)(54906003)(31686004)(6916009)(2906002)(966005)(478600001)(86362001)(47076005)(426003)(40480700001)(31696002)(336012)(186003)(7636003)(26005)(36860700001)(356005)(82740400003)(40460700003)(82310400005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2023 07:02:36.5193
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a79614d4-86f6-4704-a3c3-08daeeead3a2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT082.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6050
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 04 Jan 2023 17:04:18 +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.4 release.
> There are 207 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 06 Jan 2023 16:04:29 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.4-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

All tests passing for Tegra ...

Test results for stable-v6.1:
    11 builds:	11 pass, 0 fail
    28 boots:	28 pass, 0 fail
    130 tests:	130 pass, 0 fail

Linux version:	6.1.4-rc1-ga31425cbf493
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
