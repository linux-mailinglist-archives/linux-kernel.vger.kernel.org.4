Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C69F57159C3
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 11:19:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230101AbjE3JTQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 05:19:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbjE3JTN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 05:19:13 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2075.outbound.protection.outlook.com [40.107.223.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 820B3CD;
        Tue, 30 May 2023 02:19:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SBPYv6JrJCHaEPF4ldc+PfRU5ZwWU2b3BSPO8hoeLo6Ja0WDLYTbxp3+4VhneNMtpbco2N3OIx9G+YwI1QAMkMSct5AyGwZu7Zx3PuIHtMJdg3lHgy6lUI/I09m1UxujS6eicKVBlTinZDvtAbYpCorpF7VdfvXiaN28A+Vfx1HY+X9zcqzF1wbHjHu1nBbzjesoSETVCbhgPHZMrZxRnEmxV+IC73Wk6SPWoAZfo7C1D4tR1xuxMD72xtvBp+4bBKZcqwzXik8WrPx/xu4P74B1YDo+KysJL998VmNbQ2i5Uj98+v8MZ95s9Gu0jSc0Y0ulAQgGZx3iqHB3uO2Esw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5TfB1mr+hcHRbII/R6ohRpdB1a9hrLkhlJdLyw2NztQ=;
 b=HX41uXi6x/3b995MeezbO61NlJ5Hi3jjg+KlJD+sEVQSz5TBVDcwcC76rtn3OKdKhnM5Y/AajRSAfjvAEYa+klOq258cIYLuCz/l0TLrpRSwYKWMvU4wQhkOCMEyJ1yFA28kiBgAmO4aoKU5IN0TOEmEG01A9Fs4EwcmKpvODlEXYwZB0XM5Q7AnDmTDdUQu0nfbfIqQ7yby3mmPSMV2OBPWgvEBWXSJenROhbPM25wwLx4eX7STgCm8pcGyrrfGdlz5HiExsIS4Cgw8HVARGE7GXDgy9kdMPlwvRnxHFlct5ktv+qGyV0fxGiMj9m0neZeIDv78diuPHzTAadwHSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5TfB1mr+hcHRbII/R6ohRpdB1a9hrLkhlJdLyw2NztQ=;
 b=sU2ya5bjjt7rLuO7KWrc1IZE3zBWsK94EG++PYfgZVriT6kz0A+wj9IfZg7e0bnNppHbW2xp7277Z1/ko8uhnbMMgXC6qkrF4REVa2/HLkbn3foPxRCTFGmEUBTWKJONALUABOn27LSanT0ncS1yrgjxKIKAEngNRl6KVh9TCWa0sYfT7y0VhImN+VpWumEN5FimlpRnMYnvtKr0XfjSFuZYuma72mWdzXPP1tGObrR6hIbJ4e75o1gylHAtjnR+ETK7mHGDgksPuoVl+x9scuj1Ghaw7Emq5+GghH5nIaJC7WYbVsFu/GYEySi2CA7YpPIiE4HAljWfThXIwIe9vA==
Received: from DM6PR03CA0023.namprd03.prod.outlook.com (2603:10b6:5:40::36) by
 DS7PR12MB6213.namprd12.prod.outlook.com (2603:10b6:8:97::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6433.23; Tue, 30 May 2023 09:19:09 +0000
Received: from DM6NAM11FT077.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:40:cafe::4) by DM6PR03CA0023.outlook.office365.com
 (2603:10b6:5:40::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23 via Frontend
 Transport; Tue, 30 May 2023 09:19:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DM6NAM11FT077.mail.protection.outlook.com (10.13.173.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.22 via Frontend Transport; Tue, 30 May 2023 09:19:09 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Tue, 30 May 2023
 02:19:01 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Tue, 30 May
 2023 02:19:01 -0700
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Tue, 30 May 2023 02:19:00 -0700
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
Subject: Re: [PATCH 5.10 000/211] 5.10.181-rc1 review
In-Reply-To: <20230528190843.514829708@linuxfoundation.org>
References: <20230528190843.514829708@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <259bba74-af96-4614-b2e8-98a1dae2953f@rnnvmail201.nvidia.com>
Date:   Tue, 30 May 2023 02:19:00 -0700
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT077:EE_|DS7PR12MB6213:EE_
X-MS-Office365-Filtering-Correlation-Id: 25ee1212-5583-4637-dc7a-08db60eeeca2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hBJAxrW8blvuQT3Zau64pdvPGC+eR43npOrOdYa8j7dIrts4o1LaV+LclBZLJ8VisWAzChHur06ntNV+uVkQBKtK9fyt2JGtRmOG1mzO2LZeWJo88ae8d5pgjMXGuvIWTtmWVYvMPPTFoEWIySMlJJHuY8gVccORafynCi+Fb3xlGmQuStYo/yJzHwZWIsTpfSdURb7159ffiFf/oXd6LpdKYDcVLQXYFrS+vmQY1q5x15pemGcZZGUaoY+meuUKnsJkAzL9rpgfDYVxMn+6jGRQyzwEZ87G9sB2D72HHt0mj/aW52PpLdGLSC4Kf8sXYw+d3VsLzhNIDB62WeIfPo6U8KDNZiH/aI1V2lkMeVuCmbvDWxMViWsxukev909+4wx1CTaPSshdH1LiVHzgoqO/ki1YRDhwVHjgc9oK6GRmocE1ZWpmMTLZ2xZBCL6Hp9yNxriEREZE+CaUfs3fpiU8aDL+jCVh9U0rlDXgYeapoerKKBvMsEryd0OKrAlUNwBm5Or8vYMz8heVqf0x/q6Nvs/pleYkX7DAbZjKkEoQAKoeFBiM8ljAXTSoh7mqkb+U38R3xIr/N6kO1gqR7drkQCTgfK9gRkIQh/J/MCEUtakhuX8fd0PSVQPUo3ydeEKy3DZ9UbjZQxgCiltXjKBpp9XFrYQoDR/SPX/rZtrDRoZ2KrM8SDs+4OP0vCzO4hlt06hPSJtmNLGGM2ToomDvw2neyuy5baHrD1VEEut1ufJlQI0LCpUnU7wv5Xeuh0EfEaSZUXAKy5sCr8pd3Ybo2t3eEB9jJgHm+WVtmhE=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(396003)(39860400002)(376002)(451199021)(36840700001)(46966006)(40470700004)(478600001)(40460700003)(54906003)(8676002)(8936002)(82310400005)(7416002)(5660300002)(31696002)(2906002)(86362001)(356005)(6916009)(70206006)(7636003)(70586007)(4326008)(82740400003)(316002)(40480700001)(41300700001)(26005)(966005)(36860700001)(31686004)(336012)(426003)(47076005)(186003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2023 09:19:09.0230
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 25ee1212-5583-4637-dc7a-08db60eeeca2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT077.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6213
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 28 May 2023 20:08:41 +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.181 release.
> There are 211 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Tue, 30 May 2023 19:08:13 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.181-rc1.gz
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

Linux version:	5.10.181-rc1-g80ae453d08c1
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
