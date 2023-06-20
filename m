Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3425C736915
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 12:21:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbjFTKVz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 06:21:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231968AbjFTKVh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 06:21:37 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2042.outbound.protection.outlook.com [40.107.93.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC31FA2;
        Tue, 20 Jun 2023 03:21:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JWjeeGtoS0OhQGUQHYr2FTpsF6/VQ1S68pnQMPrmYJUTRwDyeOZHjZLg+yhjsjROCpgM5N5FdHSLMwJxypaoa0N+5r04+QPLA7R84JorKJkyg0OT9H/JHhn3ECXftoCEUN0X3rv8+yfsSdzHHnfLVsP0bNWJTwM7VEwk5sSwO2V4FpFtTETXfId97955ZGA5xn7V4npuf6zk9LfuEs7uWWAHcwP+DMIj5tQbVYb0INb+8PbutkiuT7JK9G+MLfLolhuDyCIxN64H6dq+ry+El1v6sgmX3YBI3UGRkspKV8AzkiWeToW44hLpu2q7Ql2mUc6ltJeKaGE2JzGcsqoSvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gFheGU8TPrKorkwPFRZjIZqdq40XaPuwc9EMcwUyIZ8=;
 b=NdCd7Tsc/TRoia9r7uEM+T5N8hEPNqfHia1HRFaNn8UHd39hOi4XCTgIu6qTL9+TClMBJi0SjQ0U3C7vsvMqnRgcCZ4Xu+HYnR370btqpNMIDdSyjUAMlXhaldh6oRDdt5KfcYHQpVdZSGwuyEJl+VmuI5f/0IeOX4SKLAqkLIzVAeqwYdeZ4LVe7Nzt7ZUv8xWkX9wI32x/wzYFTEOPCi/WmOV+pf1zCnrgmOfjkQqPO31Dg7ZUC13Ij+/R4Vis+m8VTRqsSv6gEvGqO2nggA3DcJfUWJCHWw/roPlpYWA0XkDBFdp8voMuXdmu5NYIPjS/q1IE3kXq31RD7WtrRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gFheGU8TPrKorkwPFRZjIZqdq40XaPuwc9EMcwUyIZ8=;
 b=dYAu+xplW54EuhIlE74uIsDzVk1Y7IrEihkUUAmYX+w9QSIUCmwvmv3hNISyILs9Kf6nnlkgGf7t57NGSfT+iYRf9QuD9bw3YaiIWXzFTss855IQJ81tWI7TwRb+cSP3RQsMWjEyt96P0uiYRCnp4CNi0rhkvmNc2Kpi3xLprHjUTAyUnXZM7Q+01hTID0V679Qbvy+fORN07DhxDz698gPow+kActJwCC8EybZiVcYYFARxBvwgI2M8Wu7F980Wg+Bj6GHJqOnUafOzWVM+5nJwl9M/z9ZYTn3pKQEL3Xpdzh1vDAxqBAdVgn4sFrbm7D7RzyhN8TZhBtC7lVZ6zA==
Received: from DM6PR07CA0073.namprd07.prod.outlook.com (2603:10b6:5:337::6) by
 CY8PR12MB8243.namprd12.prod.outlook.com (2603:10b6:930:78::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6500.37; Tue, 20 Jun 2023 10:21:34 +0000
Received: from SA2PEPF000015C9.namprd03.prod.outlook.com
 (2603:10b6:5:337:cafe::61) by DM6PR07CA0073.outlook.office365.com
 (2603:10b6:5:337::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.21 via Frontend
 Transport; Tue, 20 Jun 2023 10:21:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SA2PEPF000015C9.mail.protection.outlook.com (10.167.241.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6521.19 via Frontend Transport; Tue, 20 Jun 2023 10:21:33 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Tue, 20 Jun 2023
 03:21:18 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Tue, 20 Jun 2023 03:21:18 -0700
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Tue, 20 Jun 2023 03:21:18 -0700
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
Subject: Re: [PATCH 5.15 000/107] 5.15.118-rc1 review
In-Reply-To: <20230619102141.541044823@linuxfoundation.org>
References: <20230619102141.541044823@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <d9ef30bc-602c-4521-a92c-68bbcc5727f8@drhqmail203.nvidia.com>
Date:   Tue, 20 Jun 2023 03:21:18 -0700
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C9:EE_|CY8PR12MB8243:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c3922f2-7a04-4551-7922-08db71781f7a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wdfuLLsei/1CjRWlONtpiU+OzpbYs3aw1LAil1T2CdYDPQPICvqp7Aibspv8TKDw3UhmguK3bgyVpghuhqlb9O6QQ2dviyA2jwhCG379NlJCaldiDLM/WiR3tDYxuQmHTuLstIvDuvfPR48xMcPV+sK/9Ow2iYiuQwA3hWrGPr/HKk+yRhGGdPecIh8dLizTJdBspl8ffMTUMgMPKk6F1jZp3yfSrIZOLUwUIfwyxEECBTQ3vMCoJysPRSn5R6D80+VLeulAqe7aaDcSZsGH7QzXmongKRtT4kskVBT1VHd1Lw57KAdGswKJnzgPzaSt9lb8umijcnUPKbVlh4kv8/73A9UJYuYRdmaH3mRKy3nKwLuNhh1At2L7f5wGXRRTbHMtDCoSv4SK1XUPCVloykv8R1LNSCQoTNb+irHPiu+3XqZFn/w3TRbBu26dvvTMzqyR4wVLU19IfSR5ONGh3bjFscXvTw8wGs0+VNBMt/ifiONAwHyrs4jlDGNIv5j266o40C0UFmgLxfyK5hYnmjVI1dKuSrSsrXwwyKq0m6oHac/fNm76NcZjx4xOs11BtZvgRIxGmQYyYoC2+KMl8AtShGEBhBPVIyTEWotXft6Ty2Qa8JydmX5uSFZbq4Yy3bLVLNqPBdTvSxxvNYzIXgzwZlRGC2wW3Z0jF/gCG5X00F23DMSsECkzrsJt4cLLjFP2ZEnLEv8yzrJ2BPbFyy9cu382ePZ/JsEJIBzO7XRRahrF6L8dT+SqO7ePEta2pQQ8D7mfpTQJmmetyRYP96r/Egef5bcORHfVWNI18tI=
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(136003)(376002)(39860400002)(451199021)(46966006)(40470700004)(36840700001)(7416002)(4326008)(6916009)(70586007)(70206006)(41300700001)(316002)(54906003)(8936002)(8676002)(2906002)(5660300002)(31686004)(478600001)(966005)(40460700003)(356005)(36860700001)(40480700001)(7636003)(186003)(336012)(426003)(26005)(47076005)(82740400003)(86362001)(31696002)(82310400005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2023 10:21:33.9941
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c3922f2-7a04-4551-7922-08db71781f7a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015C9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8243
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

On Mon, 19 Jun 2023 12:29:44 +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.118 release.
> There are 107 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 21 Jun 2023 10:21:12 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.118-rc1.gz
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

Linux version:	5.15.118-rc1-g71c980089d73
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
