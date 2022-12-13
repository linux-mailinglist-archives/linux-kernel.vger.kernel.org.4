Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA5F464BC8D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 19:59:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236662AbiLMS7l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 13:59:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236661AbiLMS7j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 13:59:39 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2078.outbound.protection.outlook.com [40.107.223.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11AF32253D;
        Tue, 13 Dec 2022 10:59:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NN8ZkSIgbsEr1Omc4zAemjooXLkNbW5auBXnaraDNuvcO6bou0utN2m1NVK+taMC3uXmov9aPLZRfWZyVkEgYlvN0AxGJfpD2+GzMfeynOZtRG0ume7D0C8p77F+1HwQY7yydT2WzQ1HYR7KPJjYvWZPmN9fw6mrhG4UcBc6HPPK/n3zexo7Yka4oKQPeNNYKsZ9DO/sj9JLbdwT9ABg2QwO+fC3M03Afk7WSWmYyLlJyiDD8geAc/VOtK4Qgfv3hV1y8Icu4toy1LHYLdfpdLM1AlBEa89uVjOwZiXB12htmN4R0ylmit+4EvPn+0Ghi3VelJsFBpvNes2dFo2JCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eT4k/fJXHKP00utfjq0fu2DtvAXk01lRSDLqR/P+a88=;
 b=kgET9xWxV5sG+KJBR14zZFDUSxFSczsX8SbMMyFHdr05D0M0Rq5i3akXLA8LdVAkXvcl3k1nVL9jiPYS58oY7d+po+MVo24bKLycvTh2NsnsB3uRLVYKe0f1X9EEo/eqUN/gTFE2108nk7O8L89O7S59v6WY0bWyEm1x0gcdzsJ3ZYz/sdQqjIo+riDPH9grG67we0dKWefIyGHbmcPN8l36loACvGkMfp3pSkJf2cLYwv7qC+qU6nvHvoOS1fJB9zJS/W6AgjkxMSxwFbyvgmNyTOBDmNZis+0QW1eBEIIiFusECAJ8Ald9oTXBy43RUYmk/WOydUJuClmIT2KBHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eT4k/fJXHKP00utfjq0fu2DtvAXk01lRSDLqR/P+a88=;
 b=ch3xGYRr9lM2It6k9cFuT3z4JSLHZC5RfVMO0yTQe9g1vRe5ju2plpGjUeLzKAEr+xxCdAEwWyYl1bDxBkSkBmE1GqZw6rJNGCslkMFwhUFY6MemNOat+3zuwdIs6cU1/e+6hjIoU2P+kvV7vZmKOw8w6ATxPKFA9nR4pnLf4bGSHEBfTOHx6cTuOsLotSp+FBlf/A2OAAW84ug8yq91X1AkpIqaahkAdu6pCc5cKMAqptMXFcA9hok1pen9g0412t9JKJNLfAuO6Y0TkzUVfqxz4RJnxn/wRSUNfXcOUjvfuJ4C7u4yj4farEyu9+PqfNp31nJLxtq1y2EfdAZXVA==
Received: from MW4PR04CA0249.namprd04.prod.outlook.com (2603:10b6:303:88::14)
 by BN9PR12MB5259.namprd12.prod.outlook.com (2603:10b6:408:100::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Tue, 13 Dec
 2022 18:59:36 +0000
Received: from CO1NAM11FT021.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:88:cafe::73) by MW4PR04CA0249.outlook.office365.com
 (2603:10b6:303:88::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19 via Frontend
 Transport; Tue, 13 Dec 2022 18:59:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1NAM11FT021.mail.protection.outlook.com (10.13.175.51) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5901.21 via Frontend Transport; Tue, 13 Dec 2022 18:59:36 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 13 Dec
 2022 10:59:19 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 13 Dec
 2022 10:59:19 -0800
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36 via Frontend
 Transport; Tue, 13 Dec 2022 10:59:18 -0800
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
Subject: Re: [PATCH 5.10 00/98] 5.10.159-rc2 review
In-Reply-To: <20221213150409.357752716@linuxfoundation.org>
References: <20221213150409.357752716@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <a7a56871-e36b-4e68-9173-b859dd1a663a@rnnvmail201.nvidia.com>
Date:   Tue, 13 Dec 2022 10:59:18 -0800
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT021:EE_|BN9PR12MB5259:EE_
X-MS-Office365-Filtering-Correlation-Id: e9c592dd-afbd-40cc-3570-08dadd3c2dc3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MzT576ZmFhKKlEMWRTxqB6d71pb7lNO0TyqZ2zxzCZJcZp1WiYVLmIKcSIQE0QE8cDDPwrehsjT2FB898I7KQjCMX2gQB3P1S3pSALj5LLGzzvRmFskok+aTfwXByOtOtTG/CWAC7hzbYXH0MlE1lFX2GgYzRp1jeSxeL+FItIIzgsw7ipjznBHfz1y+dFV4Fl/Uh0HgQMNl/DQlKEiupamqFX/s0Szap/0/psLoRVU80cb7vS7QGe7Fe0NWQN4dAusgVuYcuWWRWyI0AiqY3FoQfe0jl8FVg5FhdqgVBSYgihTzGVVBNKHkWL0geLFPO9z7JXptyjpRudWMfz3QfmZYz7Se2M9CQfygnEcBGnnJAxV0DoJK43LqNOxLHAb99XSx7xSALfjPpKVHR0Id4XCqirRjHhqmdbydBIPW9czu+LDcrqWPxNLDY4OM3Fst90B6RJDvSXTxDJFtsrp1Qp9tP5tO2Y8b2DcbJL9NZaXlLroeeilUzk8q69/4ihIIlhs4Gh8dMqtkR4B4IL8QFvcNVwgobK1cyLD81T6b/6JENsd2B8JyPO6b7MjWJ8mMuyCbQuca3nSdP3YOdSBRsB4zmn5hF49MN7CFyrKAYDumTVI9+YtTouhAb3UTDjCQOgd/lFt55H0A3x6zcVeCiCDDsXQiuuxy29vz+Cu9JPuACZAELHLmivyRDTrEoM9SQpeUIdy3dSFhTUc9nRv0Ywv5M3EN2Txms9kuFfslTYe8QRg0rdww3U5Wv3ILfndNPPFEuoE24uHchD2EXe20XpVYBszFpfBIwFVXp2G+M8Q=
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(39860400002)(396003)(136003)(451199015)(40470700004)(36840700001)(46966006)(186003)(82740400003)(478600001)(26005)(8936002)(7636003)(966005)(70586007)(70206006)(4326008)(356005)(40460700003)(47076005)(426003)(41300700001)(82310400005)(336012)(31696002)(5660300002)(31686004)(7416002)(86362001)(6916009)(54906003)(2906002)(36860700001)(40480700001)(8676002)(316002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2022 18:59:36.0328
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e9c592dd-afbd-40cc-3570-08dadd3c2dc3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT021.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5259
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Dec 2022 16:05:08 +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.159 release.
> There are 98 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 15 Dec 2022 15:03:44 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.159-rc2.gz
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

Linux version:	5.10.159-rc2-g2c8c8e98b2ec
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
