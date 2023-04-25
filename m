Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B20276EE097
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 12:45:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233915AbjDYKpi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 06:45:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233847AbjDYKpC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 06:45:02 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on20624.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e88::624])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15D68CC15;
        Tue, 25 Apr 2023 03:45:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OCAkIfJxanXdggrZlGtbaf+CP/dMuLBYZESEwijmYiIGVSpPmG5/Cu4Ky+kx/JgfJ0caMEQWDyi5HjjRV1BEoW9Fg1XNBA81zX1o70+b+ZZg5TxzwHUVsMjR+Vi1YQmjfANDo4gT+LlbktDWo1BewYPA65e/YdtlEIDiej7eBfgCCKiDsfnDhwBnyy3YhprYKp6fNnop56kXNNnuWGeeTJ6LkSENUxmUQ0In2Pcgk434Rsl+L3bAKZPnQjBGvZ8hATRiyoidx53XpiqBNbkzpjJZhXEJKKZrFDiVUS+a/J2/bDEBih8XeQdgF9M8iIEPcqA2AtdB9Fx9VUejzjlQ/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lnyXgWBvO1Q8xZ06UNAMJGbBP+hGtEpW7l8tft1rBJg=;
 b=LmMssMdJBL7rwjo8ntRVsVRdr1AXtJOFJ72FAUqoh9i130KJFwOTkQgCKb5XUDARnayIC7/mHy0WumWxJHSC5carW0Wnxw4mu+b+u8wgjsuml+4QqMxL7+7SlnBJ/d+up4B4TYnhfXIywp86mSNmI/wutOEPTgHO+XbJ2kfCfMgmBt6LE5kHfQG1V8Upj/AEOC8f5xeMxn5sz6KjgqCxWn7GwY084Y3AunFWDwWRHRd/mYT0yuMM3/u8nNbEECzsKmZzl09ru308CHYxGW+n0DD0oDFGBCRDTZkNcEGzfiNZscFft7q740MQkdLR6Lwn04kp1XbuhjG8AY6v9UfhQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lnyXgWBvO1Q8xZ06UNAMJGbBP+hGtEpW7l8tft1rBJg=;
 b=azpHrujKYRpx06mmFDQ3mhKRPMLgr1MhaKsHBGX9k3g9C86O1+95w9uXY6bTmJxfWaBAuL0NR4y69B4EMbZYZQcWTAXScdpKiDs9dpBzQEPzk9K+GLfAnyETFj7oGK3gfcjXszFbxu6LcLff8ClpWC08VaeVQtLEsn1RQN1f3kjMAHzBrrQx+HvtNtFpIAFK+mIj2G+9SYXxIZywiizXN3NtvdOT01lbF87TAZPsR3TECrfXLwQAxnGTPEsKJjgLa8qEuD1emVJ9D4nF8pvlIqZthJKIReSiOMHmGk5urObM8rMY69gPOEkN78qkU0+0XcjWs54wKnRprhubt6EJUw==
Received: from MW4PR04CA0305.namprd04.prod.outlook.com (2603:10b6:303:82::10)
 by DS0PR12MB7584.namprd12.prod.outlook.com (2603:10b6:8:13b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.33; Tue, 25 Apr
 2023 10:44:57 +0000
Received: from CO1PEPF00001A63.namprd05.prod.outlook.com
 (2603:10b6:303:82:cafe::f9) by MW4PR04CA0305.outlook.office365.com
 (2603:10b6:303:82::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.33 via Frontend
 Transport; Tue, 25 Apr 2023 10:44:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1PEPF00001A63.mail.protection.outlook.com (10.167.241.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6340.15 via Frontend Transport; Tue, 25 Apr 2023 10:44:57 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Tue, 25 Apr 2023
 03:44:43 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Tue, 25 Apr
 2023 03:44:43 -0700
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Tue, 25 Apr 2023 03:44:43 -0700
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
Subject: Re: [PATCH 5.4 00/39] 5.4.242-rc1 review
In-Reply-To: <20230424131123.040556994@linuxfoundation.org>
References: <20230424131123.040556994@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <43d15036-5282-461c-bbfc-1fd5dcb1d8ad@rnnvmail203.nvidia.com>
Date:   Tue, 25 Apr 2023 03:44:43 -0700
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00001A63:EE_|DS0PR12MB7584:EE_
X-MS-Office365-Filtering-Correlation-Id: 84a6ec47-3a9c-416c-4866-08db457a1cd7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RxqGuttH1HVgjABcTVuoWPoMVYkQGFch6qlaEUCU8zMphU4BSsgkWUq7a6FNZLiBnhGsSoSVuNDDAvkUd5rf59GskCyeYtPRul+oPw9nOnuH7ZVUIAjR0eShkytP4bpyDjmq7+YM4k2DxOc5q1o3LMrNdL0DNoC4/63wXkfM3g/nQciYdSV27lExKXozv/tuXGmsP8s51pk8x8x8ISWEfyL0MSh2dJPDBQctSQuL6ZzzH8nl3J8TAWJ4OD0gQi0fKZbAULt//HkRZM5aIzvQCIRl911phiVKiYEWjVAq1HGUZU7mPNsnnPCEX201W2/PxFSgKXX6Lfy4L+g8eRtscCYXoCgL8pr9JenIRpV7VrofA1JGZnGOcd5/ul7qprAh68TK+QICLfon4fUNBcD+OqVddyBZVJngaUv7lqRbfjjU5OgP1ugS8q8oZCm/4dtRARF1U7r03dnY33OhfwBiBDmpuKjWsyk7GEil5qQEdM7Dfw+WllSTrPjoQVLmaoQOn26F4lUW6tdncmaUf28FRS16oC3f/1jDqD7iONmBsfntBRqCW9gu5ZcKCypMHvco+ep4oNTVpb4TbacXRZgW/JZ+FPgwiytIYNQq5bPtBpLi6WutWNUnbEMmTdHQA9gMqXG685F7ipTnuKG8o+/0X2NNfk8pxj48KyelM+rbQlWiDpmQ9EOu9pv01qgY308cBOzO/lqth4QAEWUtDqC7ks2v+bpQ04Ff8L5NeJcZuhI4NmoAMrNcUAz5zHuBMiti
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(39860400002)(346002)(376002)(451199021)(40470700004)(36840700001)(46966006)(70206006)(70586007)(82740400003)(2906002)(36860700001)(40480700001)(26005)(82310400005)(316002)(4326008)(6916009)(7416002)(47076005)(7636003)(426003)(356005)(336012)(8676002)(41300700001)(5660300002)(8936002)(31686004)(54906003)(86362001)(40460700003)(478600001)(31696002)(186003)(966005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2023 10:44:57.3691
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 84a6ec47-3a9c-416c-4866-08db457a1cd7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00001A63.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7584
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Apr 2023 15:17:03 +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.242 release.
> There are 39 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 26 Apr 2023 13:11:11 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.242-rc1.gz
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

Linux version:	5.4.242-rc1-g00161130fc23
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra20-ventana,
                tegra210-p2371-2180, tegra210-p3450-0000,
                tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
