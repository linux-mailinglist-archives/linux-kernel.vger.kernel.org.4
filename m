Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC98E68B7D7
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 09:58:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbjBFI6B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 03:58:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbjBFI57 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 03:57:59 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2087.outbound.protection.outlook.com [40.107.223.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DD381B542;
        Mon,  6 Feb 2023 00:57:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XoWWSMq+B/4CD06t3s6msQI/ybimEFaRz/BsU7CTsJOdB+GtXGYmWMmPVAA6FQZsI5QNehu0Sc0/xoQHaEGI6VVS3/vS/tcwxjLohLvQbtYsFnxqXfbQ/G86WIrx97vYWoTe36WF61YeL3N/8bd4ee0auvzIBNQHFaO+1PTDmNqVnejP/At/4yq1MbVCNvMkt9xSbfRo2YO/JpFDUwrkZ7yyPup96COzgIux9tWtmrTp120wfZr656wKdqSdvNRQQXSj9DpzyGXZullK5GRAEI8u+4CzbF6Xg2WY7PonS/HTk1heYdprX/A7B7XDlolBcd25Hjm1/YgDxPfSqUMncA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=btco5ITo0qXBEDM5xMpEQ7/ge/ZzgJQ806WPcUTJcow=;
 b=D/550WmpghjzdF5jCc1c1LPifJMEB0Lxs9Sr/QG1OHWhY7T2E/j9Ok4yGvM5TopqcEXYavOfZIB/Jtj1+/ffd6EmPB0GBinFmaMNAP/Iio7eSwgc84fZVe0izOUydF8BxtsWZL4kb/TScHzcilQ8jWMdhr3pnJVnPAtok+43yEUHSoP9Dv0bHP/cZ5HKkNTRElT2RC1k9VkrDHXLBCPh5+dhb0EkpvL4Z8farq++aZCOoZ8XlTU1sK8GGMw35XzpF3HSybZQqeNSsYyM9Pk9bz25fEW7Rdc09bCySIEHAwky/x3iKf4wDT3jO29//V3XBYl/OdW4N8DEib+VGznltA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=btco5ITo0qXBEDM5xMpEQ7/ge/ZzgJQ806WPcUTJcow=;
 b=GZBV16aphctM6vmGid00xkQcN9qL/2dQ8UXEA3iZHrXwDHtvJ5V0X7zwcvRTV1Mw5vgWUrSpVUghGnkMjq6FXHG72yKHF4+8EAtEitz5M1UUnTmMFQaMeYtJPpzA6/cx7cYqtTJSPq0E57g8khsHzEwj33yhwlmIt1V8eye3naSPjdIiGIIBmO7xjVE0650an9zH0RnNdZinjcqYnluEW8g+FV6pY3vhVKYBFFDpUMn1QyiBZL2SlwcwComgLpTruzIVq5su8YWhciQBqlT/3Ey0noSbE7oDnzKZfvar3+on/7XLnbWgq9HaLC1Au5JSJQbvVtmSQT9qpTdVrfWvFQ==
Received: from DM6PR11CA0067.namprd11.prod.outlook.com (2603:10b6:5:14c::44)
 by BL3PR12MB6522.namprd12.prod.outlook.com (2603:10b6:208:3be::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.32; Mon, 6 Feb
 2023 08:57:24 +0000
Received: from DM6NAM11FT079.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:14c:cafe::b2) by DM6PR11CA0067.outlook.office365.com
 (2603:10b6:5:14c::44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.32 via Frontend
 Transport; Mon, 6 Feb 2023 08:57:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DM6NAM11FT079.mail.protection.outlook.com (10.13.173.4) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6064.34 via Frontend Transport; Mon, 6 Feb 2023 08:57:24 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Mon, 6 Feb 2023
 00:57:17 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Mon, 6 Feb 2023
 00:57:17 -0800
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36 via Frontend
 Transport; Mon, 6 Feb 2023 00:57:16 -0800
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
Subject: Re: [PATCH 6.1 00/28] 6.1.10-rc1 review
In-Reply-To: <20230203101009.946745030@linuxfoundation.org>
References: <20230203101009.946745030@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <f112bcaa-db55-488b-a413-fa11a822ecf8@rnnvmail201.nvidia.com>
Date:   Mon, 6 Feb 2023 00:57:16 -0800
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT079:EE_|BL3PR12MB6522:EE_
X-MS-Office365-Filtering-Correlation-Id: 19fc256e-cc68-425b-1935-08db08202a3e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ruvO9HHNhCIHxb52t/BnirbN8et4TFyU8pCXQVB4MP1jmLubZ3+ClTLgWUAUDKIsVJNrKcHCLNwNl0NUFGjxLoRkp3EXWdcz+G84QGHm8OfpK46lzNx/wh1Hv+8WNGHg9+PXHlF9hCUbk7vsHqDjdJrpjM7KB5QT17qJElN6a+qT3alIuWukUqyCNOfCd6atXgEJST/9OKdBFcBaKDMJahKa8vTn5gxlQyC2++Jbgu5lkVKUIXa06icszNFxSEV6Vx3Fs87xJP/G5Ectqj8lBvWFEoK+kub0RLLk4/9Ilqp6KaZwkX+x+ab0P6AUES/6sRSAeTWhIvHp6CGkop8p1pxk1SQPa6k/WG7zj8KBdlDTbDPLbqVrDuGxDaEscRH22Hx0O+oL+Rm4MzoF4r5vAsw6S7aVsJpEoreKN4EE+ypSrOATGzvsIZmqGR4yzcFYc23pQhGNwc/3BCLntryMovtooSHmjiYyiFQkVHtC8b9qr4ke/+2KGdN/KH3IrKVrJhE35mb1PYRjecUSWcB8y7hCxpQK8BykB+rftkL5YYDpPPjDv5oitFg6KFr1nJN5qFDcDSMGhXw6GYynTKQBhlMEvUtBCTyKMhyvA7XhCHc8nAbwoSk6L9/cU7sIWHNbQcpY1tDDTOoRS/ExSC0MIYDIqEAKoNnGaARPchmR4TvWdIFBKhSnZMeW9c5RojIeODib7kllEonsAsuyWOePbTlwVTWYP2EzkqDXWd7NPxNFhivfUpeqdY1SnkOkeqf7Z7R2RkiS2YjHQX8bQn6Kxqn7GVoDLsfiom2mXY8xvFk=
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(376002)(136003)(346002)(396003)(451199018)(46966006)(36840700001)(40470700004)(336012)(36860700001)(31686004)(82740400003)(82310400005)(7636003)(54906003)(7416002)(5660300002)(316002)(86362001)(426003)(47076005)(31696002)(40480700001)(356005)(40460700003)(478600001)(186003)(26005)(2906002)(966005)(4326008)(6916009)(70586007)(41300700001)(70206006)(8676002)(8936002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2023 08:57:24.2183
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 19fc256e-cc68-425b-1935-08db08202a3e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT079.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6522
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 03 Feb 2023 11:12:48 +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.10 release.
> There are 28 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 05 Feb 2023 10:09:58 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.10-rc1.gz
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

Linux version:	6.1.10-rc1-gd3d679472f3c
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
