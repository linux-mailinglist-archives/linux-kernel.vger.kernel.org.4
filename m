Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B82A56D5CBE
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 12:12:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233904AbjDDKMJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 06:12:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234081AbjDDKMF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 06:12:05 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2063.outbound.protection.outlook.com [40.107.93.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B8FD2D42;
        Tue,  4 Apr 2023 03:11:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yp3+7poM9u+nTdBYhIWUu/mU4UdkVr1elvoN+hK0ZabjuCpblxGFue679Ao3e3ztYA7hjCoR3IOrbacLqde8Y1Vn3rGDOUkW7RsQFN6o5SdQY+P1udGlx6QjuFWZ5zo8ysAjqf5kFn3H9i4yEqpU01Gka73+83TPeXhhsEhlUl2wRuPQ48YXyawWD8CairZruhyuSKmBbLRNhqG+pOyTJ1hfhKGrMWjZ9bYwb8wBlvxwyf2CYr/Rx1QqKxE6cHEcE7u8igaX6XR7ipCBGFnE+sK+mpfHqAVr6Z85+VNITdQZrETF6OcRAFU1vvSgx8XKjC0WVMcaAv67ER+qxlaDUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kt3PY0ud7Ku92JLK+3YPx0QObceEiWNazVg6asdO2lc=;
 b=jC+TCWZp0RHcwujv5KfEbRwM4Ca+WcSTVJGk7KqyDR9byU+nlop0eUqU92yR3RDsogszGI0zmr/oyIqdVyN2U94K3lMa3G5/Jmww5xP0jTP6nmly40PS5t/8Bd6dzAQDAQHjuCQMO+i6KTxNCNQdDm2LCS6/stw/A4Eq3PP4aXykiiotTaTad5u/PWyhF9UskVkCj0uicn2nEKRVo77AiLHtGhilViUvrE1pYzwHclxs2GZI7VuQkqCDhAi54RXwUWYgsVJlvVj0c743b+XIZI8WwmEItSr4y4r54dTDf8bPbYnTu+OO9zoMTf9Rgk491TOtBAPNaABkTXAe/fONjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kt3PY0ud7Ku92JLK+3YPx0QObceEiWNazVg6asdO2lc=;
 b=naEfC8w2EczF3JTNO34UmrLtEIwnvXUceHxHD/i2Y8FGhNf3TzhtTH6o0UtVKCTFxM4WwEF4dUhdwlQf4DCCpT9lAJtUQ+1FmYstmqAN7f1QxFqPlK9LoIDrmM3ksrY13YZ6a0Lkb8VcGssLefA6+OvVaQU9HPCvKwYnKn/NEmXyNe2pQOHRi8ft5170J93W6uXD5Wk4WZpY41u7Dk/avs7mKg3VvldwsyOWipA+tMpnRIGR3sB7tLE1prkQsYgYFwOHk58IxgNBcd1+iaQdF44S1F54Wyp9/hJ2fg4z6CZlZGA/DBs0m7g5uAhR5GnXwRteBH7z4yXi5wWl5dTRcw==
Received: from CY5PR15CA0009.namprd15.prod.outlook.com (2603:10b6:930:14::22)
 by MW4PR12MB5668.namprd12.prod.outlook.com (2603:10b6:303:16b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.33; Tue, 4 Apr
 2023 10:11:35 +0000
Received: from CY4PEPF0000C97D.namprd02.prod.outlook.com
 (2603:10b6:930:14:cafe::ae) by CY5PR15CA0009.outlook.office365.com
 (2603:10b6:930:14::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.22 via Frontend
 Transport; Tue, 4 Apr 2023 10:11:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CY4PEPF0000C97D.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.30 via Frontend Transport; Tue, 4 Apr 2023 10:11:35 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Tue, 4 Apr 2023
 03:11:23 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Tue, 4 Apr 2023 03:11:22 -0700
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Tue, 4 Apr 2023 03:11:22 -0700
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
Subject: Re: [PATCH 5.15 00/99] 5.15.106-rc1 review
In-Reply-To: <20230403140356.079638751@linuxfoundation.org>
References: <20230403140356.079638751@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <050ba0a8-d36f-4927-a09c-896bcc2ebdb1@drhqmail203.nvidia.com>
Date:   Tue, 4 Apr 2023 03:11:22 -0700
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000C97D:EE_|MW4PR12MB5668:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e60cb76-7486-4d3a-5124-08db34f4f8af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rmWa2qMHczvY7Tf8jvJpOR8vmrKxY9Vwswrwy1xKg2Y2Viql2BTHLMjcIDVk3dSjVygAbW0OolJOHdSGSO0DmAAyKajUvwlKPp2IHWQQp8OSuDqBc6u7O7A6qjGQUf9bBdTdZialmeCnqlHtDG9hF6epT4qDAcCF/Oeei1FWxXfjHdc72X80M6/0UpARv/fOoQg9I5UXswJRxJOVXcpbHgXGm/eUynyfSmOSLgOOA2MKrPB2FcoKqaou7ISbtrDmdEnDGlYJLZhSQkcv2tAtIeZDYOZcJmHaAfIUF+wt2lvaIdenD2l624JbVzpLTZuUMnXwnRxdor7hCGoAl4LxKidxDGWMxNPWgJWO+KnsA36QFHX8IwUig++L21p067sOwipCUJqiwUu8eJjbi/Ui22d4+uBgfirhMONpLp1/pEhw/IwrMB0v8WikbX56BfHRs8BKKcrty1Jw0XqrLYeaT0fIm1vkRW9kKwbZFrZASmRVOILyCOsGQSYbjgmNyIPYPnZL0xl26DGXl8MAUTIbBN0ll5Tkzb+uYMOye9DU3n896Hy6CZYlpL124ULd8BCSVfde5mzyyhzChjE+VQyMBNvmfexDvqY1x4rXyxsQ26azlblqBvBwvtGZpXfP1Qbv+jfk/IpHnJvcCoGVGp+3gY4JRJFdh3uoynsuT+a+Th9cbkQFY/ZXXcmj77K5Spt97h48cqBAfAFu/AVH8DyIPjLX/oJb1fXsf0czSgXnCv8FKic/86TremvYuBGwcQiZw7C1RnOHHPV+v/6hXSSYzaqU6Zde6aqoz+CSlkXzT08=
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(376002)(396003)(346002)(451199021)(46966006)(40470700004)(36840700001)(40480700001)(41300700001)(6916009)(36860700001)(40460700003)(478600001)(70586007)(70206006)(8676002)(316002)(356005)(54906003)(7416002)(5660300002)(4326008)(82740400003)(7636003)(426003)(336012)(186003)(47076005)(26005)(966005)(31696002)(86362001)(82310400005)(2906002)(8936002)(31686004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2023 10:11:35.0867
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e60cb76-7486-4d3a-5124-08db34f4f8af
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000C97D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5668
X-Spam-Status: No, score=0.8 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 03 Apr 2023 16:08:23 +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.106 release.
> There are 99 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 05 Apr 2023 14:03:18 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.106-rc1.gz
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

Linux version:	5.15.106-rc1-gaacd62149991
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
