Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D63827061D7
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 09:55:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230385AbjEQHzl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 03:55:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230290AbjEQHz2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 03:55:28 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2068.outbound.protection.outlook.com [40.107.94.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96FEA10E6;
        Wed, 17 May 2023 00:55:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iWH0Lq8y86ktK4HWk7kcZl8aBX7oZXaGwu9+Y87aUiPA7DYSa9YSqX3k8WxRRD+ZcntCIwirLhxiHFChjkJEWk8PzxQBZlYAG9E2Wx59S3tsBd2H5n8npihHLzDkX+SmYAc3Jr738+x+4xpu0wttMQ1YFQzCzVCm+n0Ru7lfKpFRkdptoqfJPrFetueiTqJzH79TQZ4YTPa3ZipjO61/QNR0jRQW7QsivuQ1tRSwaJf2QTjWpvzd40Y+6kpH6jthuOJBr9ZvmOD3e8BS5uEf5mnKa/gJBXvNCcN5/XHLvmE9CVVU15z72ARUKI+n2KWTKjboKP40ibx9eNzRZMVGCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q1fHwATEEvAuM55Yqgtjbhpo0Cli5MHTIgv8zZ8/Uio=;
 b=HahppKBqdPv+o5MZ9mZLFEbLtchQcItXiTR8U+xGvvZNHGhNnyGC6sNAlsJSsgZzCFvJULPHQ+Shm/DvZXOMF+3TI54gOsv2wrnlZJ+OZ9sMe/YhYQA67rpSiNPA3dc6pgFx2qbKlr5q0xFKPbYxXMu083gPo5SOh23uXQaZgIY4jb33qum9jfN9+sw1Zx3c6iil60YVseRX8jb61vZ5TzNkNuTNttS4E0/I1og90zSYgLNj6I9zdz5oM/IIJ75YN9zjihyBop+FG0Uu64dIGCosDRQ7rEPa5F2GldGcyjRq52GsPuux0MD9wLhcpGyy7AZG1nBcbVGo+RZivUomow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q1fHwATEEvAuM55Yqgtjbhpo0Cli5MHTIgv8zZ8/Uio=;
 b=GtBjpzvjTKS80VCiCmYSW/Y3/Usl/1+rmtrA0TB4TVLoVbgE8apEws15ZlZNegnksTftIItz75MAQFc23H6M70VTp6xK8oRJXv6J/G5hUMkC1TBso74odP5BbRqeDRGP7ywvfAfI+IZxhf4M9PG+BZYL9Zg01ok+UXwztdwJBGxK9L6LJXmnj+Z8/lf58DCILg29J8HtDrpo943mm654NOCzy3f8HAsf6kFhBjkYqMI5p6ezXytKdh8cKyPUHbF/FE+1q5SRiHMSXh7Vvl1hm0oI42rWFmF05hV0TQMWcWK2onbdSOH+92aIEJO9dI/gG//lohRF+Z2aDn63IGJiIg==
Received: from MW2PR2101CA0024.namprd21.prod.outlook.com (2603:10b6:302:1::37)
 by SJ0PR12MB6687.namprd12.prod.outlook.com (2603:10b6:a03:47a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Wed, 17 May
 2023 07:55:23 +0000
Received: from CO1NAM11FT036.eop-nam11.prod.protection.outlook.com
 (2603:10b6:302:1:cafe::c5) by MW2PR2101CA0024.outlook.office365.com
 (2603:10b6:302:1::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.4 via Frontend
 Transport; Wed, 17 May 2023 07:55:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1NAM11FT036.mail.protection.outlook.com (10.13.174.124) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6411.17 via Frontend Transport; Wed, 17 May 2023 07:55:23 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 17 May 2023
 00:55:09 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Wed, 17 May
 2023 00:55:08 -0700
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Wed, 17 May 2023 00:55:08 -0700
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
Subject: Re: [PATCH 4.19 000/191] 4.19.283-rc1 review
In-Reply-To: <20230515161707.203549282@linuxfoundation.org>
References: <20230515161707.203549282@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <018cbe37-a7d8-4510-91d7-c66f2eb852dd@rnnvmail201.nvidia.com>
Date:   Wed, 17 May 2023 00:55:08 -0700
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT036:EE_|SJ0PR12MB6687:EE_
X-MS-Office365-Filtering-Correlation-Id: bb93bb6f-da38-4399-a35d-08db56ac11c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: m+q/aBZLpA3e08iHcAlxJZGlPHcicy/ozWMQHZB22xNwachSwfaK2OprOCRNbjW0BDYFeu+NCe1Gl4cULVAUXBvwyD8rZRBI3Sdk/oYWDyZQZeNhraaenkClflMWZh8yu7+lYXCyHyA8fgTSFcn6fdMaDqemPVtbG1Yco+qrvCsnTh5WWk0cZKeICcR91Oj1BfZ6B14dgQiqfJk2olAYyndzGKNka0jjfMicqJgufjh57RbSqJ9gt37y06Lf72ogCqzH5u8DCP+lsaPJV9tBeFqBbcvneRBNb+FEvuuMN0uYxOZu7pyGbUXjxXKN5+hMlXj/r/trGDqU/WV5hqC3WqnzKdjNpaGCFFdP7d1e72sIhGCXbIHxlNlLmDMVxxwHlqyueuVwGEFi2KO+oD8PwHl98aKGCtvkGJzBNMgJcFUnh2VIU6RBXZNcGLqAJXO39rL/YmVru4Ph8RJ6Q61p5HWIYRRQct03AZLvZ8q4ltqCU4yOpJ7PfITZG6wts7xDqLsnd2Kt5JJMuXG26AF3g4wl+nDl2RR9ZWpB/jCd/xDyswVbJbv2vapAcZiTppZU/fSYz6hQyZn595RYwxMx1G8D3zgHyqU5qjK5PdvxDXjQZMVGAIv6bR9cXQpE9U70Rh5NLiqnw+8PpVMolEnyDZKF1WI92w77Kske5UlHJPStR1xSfe8eA3LdYbnCZJhwcMS1XsfmTL3FeW9eGKm62f0CTfjOs5QHCbFLv2AQ4hFt0VZCbkU2gd6WxrdxxDud4HrLXLsYNA7DtkesM1vjhjA4hJMroriXlOEAmIhvGps=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(396003)(376002)(346002)(451199021)(40470700004)(36840700001)(46966006)(70206006)(54906003)(4326008)(6916009)(478600001)(70586007)(966005)(7416002)(8676002)(316002)(8936002)(40480700001)(41300700001)(31696002)(2906002)(5660300002)(26005)(82740400003)(7636003)(356005)(82310400005)(86362001)(336012)(426003)(40460700003)(186003)(36860700001)(47076005)(31686004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2023 07:55:23.4426
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bb93bb6f-da38-4399-a35d-08db56ac11c4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT036.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6687
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

On Mon, 15 May 2023 18:23:57 +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.283 release.
> There are 191 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 17 May 2023 16:16:37 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.283-rc1.gz
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

Linux version:	4.19.283-rc1-g373cdd8d6123
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra20-ventana,
                tegra210-p2371-2180, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
