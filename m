Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29E307061DD
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 09:56:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230452AbjEQH4I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 03:56:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230349AbjEQHzg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 03:55:36 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2052.outbound.protection.outlook.com [40.107.93.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEDEA3C3F;
        Wed, 17 May 2023 00:55:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AH8pKTSmFvFQ1AeHdCjOnCMQ/t3zjh9h2Q9qG/gmqwdRMMr1AcDDBgBCy57EW48qBmdT0pzrddlyAfZPJVjMFUluzwrpLx89DGkIeEFRRGNB3s2O0JcKgn9xwelvrA/3f3irgrvuNMMLVA6664YguEtz5ZH82U+hniHhZAWdl4GNXlpTtk8wgLD8ZPLNyPDghHhZb3FhFfuv2hGhHBIDuroNjJoGMvW+cyfYJinrKFQUVqwIiPxE4yZmNxYMvFZqBvJBV9P+WEm525AzXsJiQzLo8ZyLZ9SiYGHmccs3DTYMjmAxO9gp6V933xIf6yLsp+wdt+pLX3X+ZwDkbKoIKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YRLKmNjLv0hvZz9k1e6N3x6ilN3POo9OyO4ET/JgRlc=;
 b=fK+udnQQsCAaHV+X38cJddMDrPyNmW4Nn9ESOLKrXjnfTYp2iPpsJtmQZpWpJGDV1dw18+vvOQsrnt+uCWLKdTpRGYBhf79R3pY+PWu9FbH3ugZf7IHl/y4H7UldWq2nyV8Z4NJ5RE7z6kQ5oE9LLWHrVuh88zZeIk7fbbedvcJDSMh74Ci8hke8loz9zDpqNfvNO/tQwP62ja/M3Vu4oKfdAM8TLCmOMGkQHFadz2wZNUWiBaQXLICPV0z64rGS2ZcSjgffq2XNkD7KyxgOz3LRyb99vU8JlvjocQ11R8sVrC6n1r3PNmgYyznyYJ+M7cCDE267ZmUBfVKKZHhOVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YRLKmNjLv0hvZz9k1e6N3x6ilN3POo9OyO4ET/JgRlc=;
 b=ZhYNWk1WBQ6MGRVw+aDopvOtW1PNTMeaY9WF9lFOBrTARWTJwrzCLS9TrdQ7X5owFShnl6Saot0aD/nS9ntWf5LMP8BwktUjt/PDpNqL1dHzd6EI3NssZ9ZHgeiFxL37pXXmi2bEz6tHdheWVgBVHQadNpffHYNgE4ZBjR3r30B+JScC5XNrWuLf+CRRnXXah9BHqjxyHzRSdEGl3eROKqmWVo6fCcus6H3l6945vxHR4UQY6I7IkvH5Y+9nKYi91v+i9AgPt2gQdLq7P/H5J7l4zvzqzO/vjjL/GTcNqE4LRaxtWfyy2vfqKlqFJWB/RodJ9jjappzxfLJrbQifXQ==
Received: from MW4PR04CA0307.namprd04.prod.outlook.com (2603:10b6:303:82::12)
 by DS0PR12MB6392.namprd12.prod.outlook.com (2603:10b6:8:cc::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.17; Wed, 17 May
 2023 07:55:31 +0000
Received: from CO1NAM11FT077.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:82:cafe::95) by MW4PR04CA0307.outlook.office365.com
 (2603:10b6:303:82::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.33 via Frontend
 Transport; Wed, 17 May 2023 07:55:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1NAM11FT077.mail.protection.outlook.com (10.13.175.55) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6411.15 via Frontend Transport; Wed, 17 May 2023 07:55:31 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 17 May 2023
 00:55:15 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Wed, 17 May
 2023 00:55:15 -0700
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Wed, 17 May 2023 00:55:14 -0700
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
Subject: Re: [PATCH 5.15 000/134] 5.15.112-rc1 review
In-Reply-To: <20230515161702.887638251@linuxfoundation.org>
References: <20230515161702.887638251@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <ea2443e2-964e-4b74-9a29-4745c240fe8a@rnnvmail204.nvidia.com>
Date:   Wed, 17 May 2023 00:55:14 -0700
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT077:EE_|DS0PR12MB6392:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c0d92b7-edb8-48ab-86fe-08db56ac1693
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nbY6qDcMFcr7TXroPJxNPn0dvb504AZzpsHZ46e/FKrA3oPfOZfXNolJwzIPxxQveafv0SG9SQoBiMf3AkfJ01SYHXTrMzzBCvP2+HaIna1ZBG16p7NLi+xKj58YDurpC5SxlcGcNCr1X1Ql/6MTSDq/DBedsvXuiZ17FQWZ0sGqubXXjo0ieoIU6cF6uVmxFEe4NuUARK/toAXYT83jyMSFxJvPsUpdPdLvyskSmaZJhhge40vXlZ6jRNdt2fy+pHXjRo1mukqpumpChrUyVdKVf1GYCnFcbUju4U2EoJFtnTGRdL7sopOnHsSI1N45VlFbiXkhzJn9TAWvkeGK+2zFB65F9Eqb5xQA8OLwobf04EXrWradrgI6vYfuUgULDrckfJ37r9qBzOQeiOZHTexnAYhgWhxwROFndnkn22h5CsOGoCnrSa6978P0VdzZ/JuSw/hXmbb8lGbnoQp9TQhN+gcOaQkj/oMMdWJgFICKO9Z46/PwIQNFRjQAhUH65XyWI81kqXcYtiteW+utECYOyAhqTxv6wy+r4nrHd36wAQBuuGnt2+/f7nDGeZBOjAqd1GO26QQO+vmPmqq9nCWsHgFTFFPBxqJixtAUp7tAtn40+1bBSZu3WdN1wSQuW1Kb+LyzbMoIdJm7U++Ox7KGvaUWE56T/nsitJGK5IFBODjaKxgvLDC9kLD7S8l4z++CuOXgMDXbqi4XY6Jxeq+GyR8wV87xGl6+VPqp1WniNC+Q2IsWEixJao1lgz2VfgMgGQJEW0ta34YpEtLdj1vUvgN5c4jvKk+nfDHWfTw=
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(376002)(39860400002)(346002)(451199021)(40470700004)(46966006)(36840700001)(36860700001)(47076005)(426003)(336012)(966005)(478600001)(54906003)(26005)(186003)(2906002)(8936002)(8676002)(7416002)(5660300002)(40460700003)(41300700001)(7636003)(356005)(82740400003)(6916009)(4326008)(70206006)(70586007)(40480700001)(82310400005)(316002)(86362001)(31696002)(31686004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2023 07:55:31.4625
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c0d92b7-edb8-48ab-86fe-08db56ac1693
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT077.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6392
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

On Mon, 15 May 2023 18:27:57 +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.112 release.
> There are 134 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 17 May 2023 16:16:37 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.112-rc1.gz
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

Linux version:	5.15.112-rc1-g070cc2c270b1
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
