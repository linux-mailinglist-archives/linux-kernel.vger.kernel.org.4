Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E9C974D901
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 16:26:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233233AbjGJO0P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 10:26:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233214AbjGJO0M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 10:26:12 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2070.outbound.protection.outlook.com [40.107.93.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A45790;
        Mon, 10 Jul 2023 07:26:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AJ2AcvU74v9C76l+sjOQtp4hYkrL2eLndhY6GKPWCF905bhh1Tr8e7eJWg0iIRzPKwsUBXw8+yO+3//Dd/nVj4F9QOB7bldmv2hZG7gzN+c8i4cDlISGDPu4vZMZ/bGmlyOOXw9B1u9r3RPqG8vbWfRf4QFd4F1TWlhLwxxl5qadjJOESQBF6XMJdVNyK55/wsEKkhDfm2/Xim9wSa7z5lCLeQkGdchGeH5eMO9dfA6yTdOZ0AwWTFdK8dJ2OzY1Mwvkz98dKABJl1dc98MY7qBNwsnAA0hkHCL+bzxG+wzmqbOxVkIrqo0LvfXmVc13EhCmqvNczA7ELDGaDtisIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=57YQiWDftmcpsAcARRLEvP97vLkYGlqC2puOAsoYGow=;
 b=dzMkyVyZK9iv+91zce0un3ort6Xal4Mwlym4p/JCso7oIx3N9tWmSwebFAuVVdb57P8+uOsgmaanlzfNTU3Hs8CVpgqwhERsENfcenZcU7P88dX6SdoFPd8R6OUNu2EYnmUA6OL3lpCqkCjSNPsRuQ6LQ9FkA+wF+yRGakbZq5zzUJdKMHk+4LLhUKVpEK7uGubxAx6X9o60SOvj6rTTVI9bWt9D+kom7bzDb/WLlHruTGxEQumHBAaoCNu6ChAPZ1x4GBZaLbnUkEw9pktM0gAzQmgS3dv22lxhxlKTwxuy1oe1NK0jaWgNGokHcYZ9ldoAvrWQOYo9Rdo1lMEqeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=57YQiWDftmcpsAcARRLEvP97vLkYGlqC2puOAsoYGow=;
 b=gPzKPgOKRSMM/KWMZGHB9GFenkgN/0oJrojwLf8s38J59vHKyM373f94knxrfmWDbMEjw0anBcCH2LSI1odMBXnDAnGd37XSXvGHCz4yhhczO971ovrdaGKRlHoZULMW6lBkEdZJ+Sij0tbUvobdYdKAHmmZc3VmljQXA1UJAVVRy9pPBqDKc89T9nHJY8yB0Qx0KZGHWnokE6Z3MdDI2JQaQnSNJvqU6590JHUFANxx3hpUHlRUg0NrlcN/W0mFazXbyZyKz8UV2MkG1h1yGnjfW3AzcuFtpPoglbVMHBYsN2wuPnYrIKLM1jGNYN/TcdgmoLo5V4/qbfT6VnP6PQ==
Received: from BYAPR04CA0026.namprd04.prod.outlook.com (2603:10b6:a03:40::39)
 by CH2PR12MB4182.namprd12.prod.outlook.com (2603:10b6:610:ae::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.31; Mon, 10 Jul
 2023 14:26:04 +0000
Received: from DM6NAM11FT038.eop-nam11.prod.protection.outlook.com
 (2603:10b6:a03:40:cafe::66) by BYAPR04CA0026.outlook.office365.com
 (2603:10b6:a03:40::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.31 via Frontend
 Transport; Mon, 10 Jul 2023 14:26:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DM6NAM11FT038.mail.protection.outlook.com (10.13.173.137) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6521.44 via Frontend Transport; Mon, 10 Jul 2023 14:26:03 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Mon, 10 Jul 2023
 07:25:43 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Mon, 10 Jul
 2023 07:25:42 -0700
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Mon, 10 Jul 2023 07:25:42 -0700
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
Subject: Re: [PATCH 6.1 00/13] 6.1.38-rc2 review
In-Reply-To: <20230704084611.071971014@linuxfoundation.org>
References: <20230704084611.071971014@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <70b425e7-4dd9-454b-b340-997b9861acde@rnnvmail205.nvidia.com>
Date:   Mon, 10 Jul 2023 07:25:42 -0700
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT038:EE_|CH2PR12MB4182:EE_
X-MS-Office365-Filtering-Correlation-Id: d3868c61-7e87-427d-89e2-08db81519766
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 920usSktOoGmln5sAH06Be00K65snSw/AKMpMBAd98UTW8MM9gnFAhLpZhd/VHZR/RdhCwHxgwRcID/U1e/q/DxFcPoQmUyUh6NyeRWEzbFqvZia5JYHrU/ggbEh051/injzHPuj+DYEY+PMioZlGOvzAPqsC6wEm3U3EXlrPvCAi8s4bQhfxcPNgla2SYEu3bnBhkndxfYpeM6sn1ObzEkfycPys6/Yzz42XD1gIIOPhNOqBAhKknHIL5IweQ8NWL6AymvHiz2v3REK/DFl05emTf7Vjp73xHB4bvr8tgGYgphuyqbBL+WmVkxyInEHvvtLCJVbl7K7o01IPTAlXlPxg4zV9Csb1O19qMaAv0oFuUOxhzaMC6hDFJnzeodU1SMHoQk8HP4lRb35DCtUaIJeMJs2zuRpl5HVl3hKRZuSL4VbdNYTPGUErCsAguaRxvy33TDCzLXTT0dS3tHlAStUYV88RXjPtDSNB0abTfmcL2ss0v6AFkGx3ZZ3MXdTCpleQ6az4SD1IhgQZhnnR69tr6UGoCya5rdxLkGZ3nLLjPgYvS4UrgO5h1ebOIiah7XR+k1lGE4Vnd2sC0ZAX2y9GpHzXp9kHHL6Rqc3H6DPuiO43g05K6GHcwGK6OmMGFn90pG0KTtLxPsLdPYbdKOZHP5HSowpVFXzk+2WIK9HQU4a144MTrL1Pnod0R719twoBSG6jZsYeO393bMY0B78aC09b/qMQn59+Wv/LyrjPcYHg0+opW0YEJhNyiZpsOgvYXT70B27Lw2cfhwEveEXaHyF7e4O5KfhHX9eAg4=
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(39860400002)(376002)(396003)(451199021)(36840700001)(40470700004)(46966006)(36860700001)(82310400005)(86362001)(31696002)(40480700001)(40460700003)(356005)(7636003)(82740400003)(478600001)(54906003)(966005)(8936002)(8676002)(5660300002)(7416002)(316002)(2906002)(6916009)(4326008)(70586007)(70206006)(31686004)(41300700001)(336012)(426003)(26005)(47076005)(186003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2023 14:26:03.3908
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d3868c61-7e87-427d-89e2-08db81519766
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT038.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4182
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 04 Jul 2023 09:48:32 +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.38 release.
> There are 13 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 06 Jul 2023 08:46:01 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.38-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

All tests passing for Tegra ...

Test results for stable-v6.1:
    7 builds:	7 pass, 0 fail
    22 boots:	22 pass, 0 fail
    104 tests:	104 pass, 0 fail

Linux version:	6.1.38-rc2-g185484ee4c4f
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra210-p2371-2180, tegra210-p3450-0000,
                tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
