Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5448C7159D1
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 11:19:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230244AbjE3JTy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 05:19:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229888AbjE3JTd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 05:19:33 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2071.outbound.protection.outlook.com [40.107.237.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEF93F7;
        Tue, 30 May 2023 02:19:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BCXzxrjLO4VUonfbzRFGB58AkcaKjDIUUgxbqrfbNzwwywsczXPqzWLcMTsG9kmWOSnaLvsxhjtqEmd7CFvNzrGAEo6+DwEfiT8ng7G7avKIrEzB1ZFb644ZZ24UstXvQhQVfmXnFKsF3pvQGnYypGew2HS0UZ1Bm5MFSsf4mDxQxYOkwKaHPdB5UNzmpAYG57dTN1PeB92uH5+Hmz6l1TauuvYM/myzXb7JbJnEXelcPc3rO7ZZp2fdAtJk4BCcMEdJEKlD6S1guymDwBdNFSSuCsQpNJ7EfcAAV0QNq7yOVd2xWJRHKYblDPtJrzqp75pK2CaUNYc7k18dYOsquQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O4ENl0wxTkh5tuqUM4S+n3H2o/FLWbk6kp5CpeMNFF0=;
 b=aTmQeleX6YdM8LlF4LOXbQdvUdv3hCYmY0NxNexlFzttLXVXQrl01XNOJwHti6Ybhsdb9N1yDsqlx30E9wdNcNzerjJrXfOxoMnM/8O/LRBQDW+JsTqI5+uVw/smU5IG30Rj3RXKnPj4fPKe21vk4XYmSN97omadik8fmNIKt0JHZQoi8MOFvtmaidXEcf/yFtQ+3x8Jzg0zl//829lyppwpR5SR5EkrwdhcbEbgrgdY6BiQw6+blfpXvR42iCjkbi2GyB58Scuq+yCy0fyzmuq4GNSOMgRw1TPiquNgCkei6AEQ/0okyfU8VoFaldq/6ugEHWS98h0YokfjK+L9dQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O4ENl0wxTkh5tuqUM4S+n3H2o/FLWbk6kp5CpeMNFF0=;
 b=qQTh98uh2OiAhz3qR70JQ2oX+zbUpKHfw7n2IQhdnhJUmEeVUGKbvEp6FIb17av5nfvA3RH66zXcN2QaYOV9DSKhB3lQpbV6IlJA2YuH7tbTCQHK5cFX0QVR8YPhmwRVepFwPE5H+a6RF7M/b3wr78U9G2HAJYDeJ+M0/lnnWTzzhmkyNPQXLt1Cr/HM4hNMrDdN2pHIgCKTB0RAYoPHeGFscnAnqiH0EkttfwxTbs4QUsSySDm2LdL7WlN9+3OqKKbswxaP2CwKJdf8dG997RmN1AHQudeGNIvVF0H0wwTzeGWDYqWj0fHi1bLEU93zI8lz928Z71+DHxHf07Yk3g==
Received: from DM6PR06CA0082.namprd06.prod.outlook.com (2603:10b6:5:336::15)
 by CH3PR12MB8548.namprd12.prod.outlook.com (2603:10b6:610:165::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Tue, 30 May
 2023 09:19:23 +0000
Received: from DM6NAM11FT081.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:336:cafe::1e) by DM6PR06CA0082.outlook.office365.com
 (2603:10b6:5:336::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23 via Frontend
 Transport; Tue, 30 May 2023 09:19:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DM6NAM11FT081.mail.protection.outlook.com (10.13.172.136) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.22 via Frontend Transport; Tue, 30 May 2023 09:19:23 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Tue, 30 May 2023
 02:19:06 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Tue, 30 May 2023 02:19:06 -0700
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Tue, 30 May 2023 02:19:06 -0700
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
Subject: Re: [PATCH 5.4 000/161] 5.4.244-rc1 review
In-Reply-To: <20230528190837.051205996@linuxfoundation.org>
References: <20230528190837.051205996@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <e546173f-6441-43cb-a3a1-2fcd088f0e71@drhqmail202.nvidia.com>
Date:   Tue, 30 May 2023 02:19:06 -0700
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT081:EE_|CH3PR12MB8548:EE_
X-MS-Office365-Filtering-Correlation-Id: 9de81ef0-7c2f-41f5-2ca6-08db60eef51b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QhGQEsJWSd352G76isbcQhx+I6hQSKfhVmGFvIfIxutq1PYXBLWVeozFMBJUGRpeM1p88iuATK1j5BvvHf9jU4cpeDCiL1Xms6h1HMH8LHe6bd3gZr16BziFTeWZpNWJqR3ZfrsLpLtza+O6xoO4J7OH6Qp/oUntlv/JeP2rJ7WSRiXyVLqL87rcnJXSI8UTIMcBCt+4j+xjyy8//aUY89iZy0WqWhojiBjWBFX+F24b0YRLJmJMyKfJh3UP+Q2Yups0v3ZwMEVh9P7/sN2Y00ZRmzcgw2DlEBz1oTc48n1l3YIZAvXPzxePHAxotMj7uq2de/Mn8JusVJWPQzOgcgUD9Yl7NuqkTLxDEjOBbceYLewHZhL0dwZtOZ2WvhIqJC7OxHC3i1AarZWz6s7Mqucy4K+a93vPLH72XNBZT8W24D0AZUd2x2j99LMGpqyk47WXOW0Z36+TDawlzuGmn0rpCKRMtVbzBg/saj+hzVzaXjCCGg+gi7sE/LlRb7fTPm+ZUieCTwlKN2icqpBy1wav/T7Aae9CXogR1ZETixBSuUv9hIj+ymK/dEk9agCTiD/Ui1eSpnPAUzMgjr89x6a5PMgVq1zNeiYXI6om391Yiu4HFiW4nNmhMXdh2h68ZAmTaboiAeCuxYZOIDc8Qa9uxpF0HLgCfityN74ayKesTxQECp0pNsz9CAS9roDSJyDYHeRtmBfRG+dJRcQoOgRZ3L4sR/p7sKcc/1EAvEUiRaVxWWHMPD1QwlfmRPUa1suoK6RrIqurEUR+CuhGzJQ1TehWwdem8awRl3JLaQ0=
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(376002)(346002)(136003)(451199021)(40470700004)(46966006)(36840700001)(478600001)(40460700003)(54906003)(8936002)(8676002)(7416002)(5660300002)(82310400005)(2906002)(31696002)(86362001)(4326008)(356005)(7636003)(6916009)(82740400003)(70206006)(70586007)(316002)(40480700001)(41300700001)(186003)(966005)(26005)(47076005)(36860700001)(426003)(336012)(31686004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2023 09:19:23.2489
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9de81ef0-7c2f-41f5-2ca6-08db60eef51b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT081.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8548
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

On Sun, 28 May 2023 20:08:44 +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.244 release.
> There are 161 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Tue, 30 May 2023 19:08:13 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.244-rc1.gz
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

Linux version:	5.4.244-rc1-g99ecfa2a4afc
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra20-ventana,
                tegra210-p2371-2180, tegra210-p3450-0000,
                tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
