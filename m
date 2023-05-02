Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2DB26F4829
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 18:18:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233877AbjEBQS1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 12:18:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233864AbjEBQSX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 12:18:23 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2062.outbound.protection.outlook.com [40.107.93.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FAD81733;
        Tue,  2 May 2023 09:18:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JSvO27nozj7I5cI+BjVsJn+PSOruDjiDNZpoTqShHqrxRH4yFROmQ61APA6o56u8EowIVqgDfhIDDBRR1WDY89aoAtWyyoIFUlRPBEjbfZtBvP3MPBmh61zFB4smjET0mJqn8dVjQ0YOF7WbwVhs1IHf73WuSsRGq5XKjAHuzBq8oSYGvSNoxR92aPu5uCGV86wGOcZnBXPhHyQI4u1akFAYPvw7Bbrl50ZtlqP1cpU12b+c/Rbl28vrJRJlYoYMtxdyIkyEnFpZeca7RKEqo9SRcx2viWpEOY36oRVXpNBSv/Pq3uUZj/69+vY1zkTINCMmXxvMFljR66T4VT0qpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8XcDLB+WEfsyEDKnBoYqwHrnUy7VhzMc8aTIR92ccKc=;
 b=Uc6Z0ns9UX5ocknFzm1BHbdqpJZ2baaGNNjMg7meFYCr1OTyR6bfLTtQOzMB5RuUaqATjhu2OgKi0qBrmpuuseVNLxvjT5nuZN5/L0VfUrzT1L8Nk9Q/sxgH0gS5Oc0hHApXTR5hV3uu/a2C4x1WuS1TYomM56S1pN3mlVforIulpk0VLTj0DTURFaYtVgyg2zQgcOXVdC3Y2n4c/Zrdi/dyO53iQ5CJgiywN7AMxK/9xAnKuj051lhfdgvkVkZNJdIbSxzK5QAaWczGx+50bX/ZmJ7JI9seQZ+QZBmux/7kDwothKYE4c0drDCK6LB1IHvzBxLk4kXC/U6lreVAOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8XcDLB+WEfsyEDKnBoYqwHrnUy7VhzMc8aTIR92ccKc=;
 b=eS/ZH7aVQlXN8LWQRL4kIUPn5BO6i+Pd8ManOnArtGh/cS0rvSNrVLbiKVUS/B/mcIbr7+50jtr0dQYjz93E6ikKk/7jy3sDU4s35aEuq0twt+iN9DZkxlTOINcaSFFy+0vP9wwx6dr8NHp+cPajlnLIwYtM9nOeAGPzFQZUiQk5b8YObVQz/zrS18Sr12RKuSLRjJNFGCFmA9ugNYuFEn69qVOzuQVFRw3vInmflO4WR1CvFVD7RUoo4m5pqaUjKlbul1Iu3UR8dAZp/EYD/D32rMNmdH7EXJqE6EeWikTxpSvLkcZnu18YB5W52WaSgLFjNUlG0R4x7LzY7WBWbg==
Received: from BN8PR04CA0042.namprd04.prod.outlook.com (2603:10b6:408:d4::16)
 by PH8PR12MB7134.namprd12.prod.outlook.com (2603:10b6:510:22d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.30; Tue, 2 May
 2023 16:18:19 +0000
Received: from BN8NAM11FT063.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:d4:cafe::56) by BN8PR04CA0042.outlook.office365.com
 (2603:10b6:408:d4::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.31 via Frontend
 Transport; Tue, 2 May 2023 16:18:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN8NAM11FT063.mail.protection.outlook.com (10.13.177.110) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6363.21 via Frontend Transport; Tue, 2 May 2023 16:18:19 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Tue, 2 May 2023
 09:18:09 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Tue, 2 May 2023
 09:18:09 -0700
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Tue, 2 May 2023 09:18:08 -0700
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
Subject: Re: [PATCH 6.2 00/15] 6.2.14-rc1 review
In-Reply-To: <20230428112040.137898986@linuxfoundation.org>
References: <20230428112040.137898986@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <8bf50ae0-b17f-4c80-854b-94d08bc3bf0d@rnnvmail205.nvidia.com>
Date:   Tue, 2 May 2023 09:18:08 -0700
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT063:EE_|PH8PR12MB7134:EE_
X-MS-Office365-Filtering-Correlation-Id: f0df6097-7522-49b3-1305-08db4b28d7b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D7eGOtJAl61oMPu50DCeDEAMzf4uoMIeKw+UrPwj/SwQdZAnRp9+Zr74mYvDi8oj5Z6z47RGvWwltTcpDPv5f0xZV2vycB9L1UIRVUvqJxUa/Q584RqSBH1gc40r57BokGV/DqjzvJxCRaJy9a+z2V4LiQqLQ2oUStiRqpkIC1CKptToLttH8fRZfVr6MmUBaOd6RGD4j4ipwXzVbiSFZMQgAfLX2iFyB1XcWX/ax+73aYXNufytpn5pgRhzHcjO7xFGPnJsLGpox+pHTxpjxztZRSq7RAF1R5OXiL/1DlMrj+LsTDYsPn16EIpXnXOx68CUIpa/kJRlUcLPrDWfCUqGPuGxnAX17MlBnU2Gv7OwFmDHisHpsKlAoREqudv8XRG8l8w7C/V25Wn+mqaXApqiBQn6uZwpv/iSy0AaQT6u9GDSiZRoJykLB4dya6Iep7u3OrlFt3M9w7KEKYQbmr6XvfPdTmhor2981uBzYZ+HEwjZWi9Yz1NyATAQeJhC/NAIQsP2BRmkYp1iSNCAazvop9809BPUvikwUPOFKq/RhD7Q1swtOopCQg7MgtG71HZfmny7ifVFZxWLJ/1dL5evV6AVTHEKwj0hGAhlfHdOFjfXrip24IHl5mW3i3bHhpgeY84fhZh0WmR7TEc6MyU6SuITw1rVPJJtsmDIL70pyhg6J3/nhJaGVm/JURlCF8ZnyyfD+7sdN+Lwv95V85J+fT00EdZkcWPbfkGhchPvuTwK10iE8YXxF2vIWlDG
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(396003)(376002)(39860400002)(451199021)(40470700004)(36840700001)(46966006)(478600001)(31686004)(36860700001)(7416002)(5660300002)(2906002)(40460700003)(8936002)(8676002)(316002)(70206006)(86362001)(40480700001)(31696002)(70586007)(4326008)(82310400005)(6916009)(7636003)(966005)(356005)(41300700001)(82740400003)(426003)(336012)(47076005)(54906003)(186003)(26005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2023 16:18:19.0966
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f0df6097-7522-49b3-1305-08db4b28d7b8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT063.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7134
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Apr 2023 13:27:44 +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.2.14 release.
> There are 15 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 30 Apr 2023 11:20:30 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.2.14-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.2.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

All tests passing for Tegra ...

Test results for stable-v6.2:
    11 builds:	11 pass, 0 fail
    28 boots:	28 pass, 0 fail
    130 tests:	130 pass, 0 fail

Linux version:	6.2.14-rc1-ga451b003c306
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
