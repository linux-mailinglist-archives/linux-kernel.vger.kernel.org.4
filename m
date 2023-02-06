Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26D1568B7CD
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 09:57:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229967AbjBFI5C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 03:57:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbjBFI46 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 03:56:58 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2062e.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe5a::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CADD718162;
        Mon,  6 Feb 2023 00:56:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e90/3h6cipRNbSDuPB4fbG/RBGa0L5+mOL1Xec4pLIwU0p0lp4ME9FwAykGoX/fw7WOU3xgGB9DxXuC8spgEljiHRuw7DkK0V+SG1skYEWxfWRI56kylS6Go6Hhn92kMPhgBePVpy9JVtGCu1y6BGKnKH3dEhu1E2ozQjQqWjERVFGL8INRXokB8RSWS8XuNgrW7MHENxoIaff+XRJgD1h0Pbcdc4LszBmbbO+Z3hlyGYe5f5u6sTTaXsYoxvfMJsnJqrzpRCYzaSl2YbLF4R/SjwdonGPZIwL0+o8tkp5nbVOH9oVhk50XYc67oBYmC2kYUOQHmW7E5JHwp65j9Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UI8RY7WdWbfWLn7hRfC5jPqBCrqEAsKCY16p+7Aekps=;
 b=PWrODFpvkmFwxkAZnNuGbhtoKf9MdIgs4kxIpPlE1oPumejm+rbO2xURJjSbt93o/1p1vrKSs3/XhZE8cAmdqIEAKG/ZO1FIgBvAvNbN8+tDyhivnvNoP12vn8cdKPk/z0EhlEqRAo8EFoIJrDSo0zbm3RIouX2nS4nXNXPNCTrA7c0WGmYlUWbqID/qKZNJi8OK19eYPozuJjCXg5JnEakhCBlMnBdT1IpXekRCTrr7t9ArshOH2ZhpW/2uCUX9My8nWStuvmJmu1QGFMIHK+WVE/ibDNFwagHJmmagHS+en32EGonNtr5J1cIkDJSjL+kU7vi8+/bKe35h6FlsDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UI8RY7WdWbfWLn7hRfC5jPqBCrqEAsKCY16p+7Aekps=;
 b=tbfi1l7oJ8se2jjs7Ka8OnJegWslAlSQAKG0DUxH/2VNI1cxyOEYuWW/Y3c8+urkfGotnufkfHOFgBFnt2axEZ0e4v+NOwr6LEipUO8yskfYQ8eKPcqoNWk3mFu/wbmABqzMj2fykl34wITV2BmwIPgs45De5+OevXt13b58CBS+4Uu/A2lqMSwkCVonZpYOBXp6+j9A2APmD/lbZkSXNguHPShWsh3SFcd6wvqslgGm9kQLi0vRx/LBeKgfHxK60div0yDPlXGWCPWGVf/J6n8WIIdhIvu8+feNqYNGHFUUcRC4TmXtgGYRzRwTGXxalhliSQw+nC0VMdisgaZ44Q==
Received: from MW2PR2101CA0007.namprd21.prod.outlook.com (2603:10b6:302:1::20)
 by DM4PR12MB5087.namprd12.prod.outlook.com (2603:10b6:5:38a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.34; Mon, 6 Feb
 2023 08:56:55 +0000
Received: from CO1NAM11FT053.eop-nam11.prod.protection.outlook.com
 (2603:10b6:302:1:cafe::93) by MW2PR2101CA0007.outlook.office365.com
 (2603:10b6:302:1::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.7 via Frontend
 Transport; Mon, 6 Feb 2023 08:56:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CO1NAM11FT053.mail.protection.outlook.com (10.13.175.63) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6064.32 via Frontend Transport; Mon, 6 Feb 2023 08:56:54 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Mon, 6 Feb 2023
 00:56:51 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Mon, 6 Feb 2023 00:56:51 -0800
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36 via Frontend
 Transport; Mon, 6 Feb 2023 00:56:51 -0800
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
Subject: Re: [PATCH 4.19 00/79] 4.19.272-rc3 review
In-Reply-To: <20230204143559.734584366@linuxfoundation.org>
References: <20230204143559.734584366@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <c4d922e0-c108-4de6-9b13-ce2d97b807dc@drhqmail201.nvidia.com>
Date:   Mon, 6 Feb 2023 00:56:51 -0800
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT053:EE_|DM4PR12MB5087:EE_
X-MS-Office365-Filtering-Correlation-Id: 086c8912-17de-47b0-ebaa-08db082018c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hxAT+m3HPmbLGNLmY4dBEJNm/HJOGqkAATUStG00GjWq4fuQ5Fka0E62udoXHhCDnAfyqI031LC4VShSnH6EXNyb+bQQp3N9+6bHhiaykeW+je/YvORHm+rW6WOSiazI7iSB9DKTOW8LjtRXB7NULtYItdVzLn4oi2XCM+fhvpcv/s1kLhC3fXe+E5rnuUcXdP8CPk8i+oyJcI6US2h6bmGJejpEpj7BvSDE6TSLLHak44hr86rAsxYaeKMEii7wfLX7cu5y9mXa3dELA6oQ6g6wAbT4kHiYp0zg71uRWemt4CW8oawWIaMrfyBn7pegxS9AwCOLL1B+vSXmNFKJH5ap/CALz5OCWBibjr2X6W8mgIAY0p9co8Nj+tWdScqbJ9vHgQ71wmCpW1jzViS6x8oexXh47rZf3GK/FfXwIGIHISjIGcifz4XqA4Q8vh+PKNxfDsC9YfJh7nUgCjnMkOR+2NVemqDW2in0cR1CnWahIiLjK3rk/H7kP5qvUvvZLW5tf4fDVs8yXZICVUPrABMxUhN8UkX4a5+wpeAKI04N6eRfK78ym5W4V2EH1PY5utiTi+J7YmhwsvM7VzNscC7HLgj0vTz8/rkP7fAx929g5+iBTQTZzoaH3by3OyMZK72o2rquWuwjgSBQI5wg2fzbLX+xfUdTkiI9KWuYLVvlh2cIfc35lIyEeAWJO74ED1AtoHRLlpFCl0lP+xdIZklswd+T81TNxmnxlz58y/x35dC8fYRKLjTkhuWV6kZcbO5MeR9I93gGe3OzuiK7JlOY4cqxovW0JCGhxNHcfmQ=
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(136003)(346002)(376002)(396003)(39860400002)(451199018)(40470700004)(46966006)(36840700001)(82310400005)(40460700003)(6916009)(40480700001)(966005)(478600001)(8676002)(186003)(26005)(4326008)(70586007)(70206006)(316002)(54906003)(86362001)(82740400003)(31696002)(7636003)(356005)(47076005)(426003)(36860700001)(336012)(5660300002)(7416002)(41300700001)(8936002)(2906002)(31686004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2023 08:56:54.9875
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 086c8912-17de-47b0-ebaa-08db082018c5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT053.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5087
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 04 Feb 2023 15:42:31 +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.272 release.
> There are 79 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Mon, 06 Feb 2023 14:35:41 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.272-rc3.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.19.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

All tests passing for Tegra ...

Test results for stable-v4.19:
    10 builds:	10 pass, 0 fail
    22 boots:	22 pass, 0 fail
    40 tests:	40 pass, 0 fail

Linux version:	4.19.272-rc3-g84a0c172d04c
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra20-ventana,
                tegra210-p2371-2180, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
