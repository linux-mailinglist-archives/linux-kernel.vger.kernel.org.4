Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6D26722011
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 09:50:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230444AbjFEHuj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 03:50:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230030AbjFEHu3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 03:50:29 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2080.outbound.protection.outlook.com [40.107.244.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DCF9D3;
        Mon,  5 Jun 2023 00:50:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JpZF4x5P/y7bebFiByn9fAtsyJ+6MMna+whxNYrvSeOTHYnfNc9FIEczmtFg8qY8r2OiTXVHgaKl5fZV70/chZU00LUVKPNJa9kfhJv/ELkgf0TWA8RIrJso2Y/sQ3b5uL9h3Q+1TUPanv+9KVlK9B/JYd5ycTY9CnVIyiEkSqsdHx3RlbtoTamcTGJloc+CCgJirGqnvvQ0XV6QTQ+E16y4tfvdSmthVByjRIVNIrliEXqEA4UCFZ5iq1U3XzJL5lSvF9rlgClnt20W9xGDmRQzPqMN+snT8LsLp/XLlUYaJStZhjt39u3labXZBVJTdZn6Ha2lhcyMfvjkfaNmwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3KTeH/XWMLfQN05sh2JSyV5e7eCHK5ifmzHw5GzpnmE=;
 b=oL70Hb2hTAIBuV7an9euQyXxkBC2XH5d+ZnHpdsqSMNR5a5Mo8MP5oXvmtmUYXEpnJEpO9pjPyiQr0sXj4htDZIfRNj+fC5tpRqlHaCwZwRek82fNQYmcBJB6PKmHsQBRpeyQe61rJ73eeO+6oz2NShXB5cYb1bSON2HvGwUNOLfS3yDn0QGSaZReNdcG8a+zsy31FJqiNvuhXXGY/7I9DboCMt3FxqVM/hiRXY1JomWskTKgjX7SdRAGJpmlTGcmavqGcerxUmG+tLK+RixoVdpFYpy4jRwawIKp6JwZ543ZZF+I/OjKPTnS13dmhE/phujtYffzXLDLAilQqe2Uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3KTeH/XWMLfQN05sh2JSyV5e7eCHK5ifmzHw5GzpnmE=;
 b=nv4gFaXfnQX9FxLXUMBUBzBA7rBxrDGdtcOJhsjNP863AP/B6FqiYMH1g3JVjmusDiK3mHwzLi7K3BgVnx9VNEPlJK6PRnO91M1HHZPJ9BNM0yuRG1Lwe1rIYoZgCOCwjrKxkX7xTP1qpFDqp9W6+WsxgcsPjC+YmWbrMMI4qWzMTA77b8LSCY5dxApX6rEGdQk1TeIP4+2aarL92+4+T0Pcyir4tTziajHXCkef14z4cmRj1T6RW7qxfPOQuw/WaPI4qeV4l7urdMUkLmj5KpklFEZum87hnMdXcdHEmgDB6CXAKwXnHL+gyW7cImR5bh6dS9LGteQXMkZqUAcScw==
Received: from MW4PR03CA0051.namprd03.prod.outlook.com (2603:10b6:303:8e::26)
 by SJ2PR12MB8783.namprd12.prod.outlook.com (2603:10b6:a03:4d0::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.22; Mon, 5 Jun
 2023 07:50:25 +0000
Received: from CO1NAM11FT093.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8e:cafe::ce) by MW4PR03CA0051.outlook.office365.com
 (2603:10b6:303:8e::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33 via Frontend
 Transport; Mon, 5 Jun 2023 07:50:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1NAM11FT093.mail.protection.outlook.com (10.13.175.59) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.33 via Frontend Transport; Mon, 5 Jun 2023 07:50:24 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Mon, 5 Jun 2023
 00:50:10 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Mon, 5 Jun 2023
 00:50:10 -0700
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Mon, 5 Jun 2023 00:50:10 -0700
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
Subject: Re: [PATCH 5.15 00/35] 5.15.115-rc3 review
In-Reply-To: <20230603143543.855276091@linuxfoundation.org>
References: <20230603143543.855276091@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <99f2e59f-4101-4755-b6ec-bbebbb427752@rnnvmail205.nvidia.com>
Date:   Mon, 5 Jun 2023 00:50:10 -0700
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT093:EE_|SJ2PR12MB8783:EE_
X-MS-Office365-Filtering-Correlation-Id: 13c63995-f1c4-4c4b-66ed-08db659985b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NF8zE6QT2A0zBcONV5E/QRQGZrDChuTdyq35LY8ZsEowOOyE/5k0d6l5b12af3y4B3hrrKwM7Z2aWTm1nR+Duu/zZxnrBUNp3W9IcIR3W85+rQ8GhsrHyA2VTpkoYhtRwKP+3UlIPUyhdDSc6DyabQPzixpNSWPaSlkYgHHgbjVs3DIAZX6OkRmgi2iwverjHVEINY9k/1RkUbS5ePisxQIRU+zySaimOufk/0wvBRWWNZU878wCFZHH8sNxu07+xjWkgRhT0fCCZIGb92ciwE8eRvvpt2JYMqHw+3JqKeGUdyF7JoZCYSdkoe2huHaWkpWMsjcAzuldWUret02KiOrfVDzclPUmoBayISdNDyzKwNB7ahtTtmdFqnTpGpHxb1l/ZCAyJAdugvsKJSyjIO6l2h8bPEdQBU/mK2oUwzDxYYT3YmCO0Yc1UJqd6Dy/v7VJSR2+Bs+/MNxpb1FoashYw2Bqj3v1hM4FhMhJSMq4/Ym2Ld8lyuVfpLDcxmao+sTz4Zyz4WT3LENE3CF+bSs1MrRwX+bwXfv2A/0Inwk2h4rhO75H/lfEVhL2baA7fQ3WocJV3vlbd5AcyE2FceIop8XvRevZX7izLQFBB4fRiNscyUqpAvF9Su5Fz/7AcbQip2LfUKSmHQ/Od+KRYPlxIHnw6GtLKVvfGc1QWxfonKLx1kSoRdtz2aEiF2jqHGu0OeEssA5V//3zuS0ul/hkUZVZjkToK8tq6J11xl9aozd7L6N5xALbTMiQH73uPbUGUyrIv58PTak//mk8sKhHPJ5mmKbTteWwMv99/V8=
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(136003)(39860400002)(396003)(451199021)(40470700004)(36840700001)(46966006)(4326008)(6916009)(70586007)(70206006)(8676002)(31686004)(7416002)(41300700001)(316002)(5660300002)(54906003)(8936002)(2906002)(40460700003)(82310400005)(36860700001)(82740400003)(966005)(478600001)(356005)(26005)(40480700001)(426003)(186003)(7636003)(47076005)(336012)(86362001)(31696002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2023 07:50:24.8892
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 13c63995-f1c4-4c4b-66ed-08db659985b1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT093.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8783
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 03 Jun 2023 16:37:18 +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.115 release.
> There are 35 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Mon, 05 Jun 2023 14:35:25 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.115-rc3.gz
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

Linux version:	5.15.115-rc3-ge43ef124b08b
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
