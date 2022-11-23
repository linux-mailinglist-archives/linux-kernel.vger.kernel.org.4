Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACE17636369
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 16:25:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237270AbiKWPZd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 10:25:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236642AbiKWPZ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 10:25:28 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2066.outbound.protection.outlook.com [40.107.220.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7644656A;
        Wed, 23 Nov 2022 07:25:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h1MTzawKQ2aU/66vi4LShWLRyqlbGlaOXwN8AuPSbIYQyzmt7mMIZhRWQF3EP/t8UBIP5tBFexs2p6vnI+le2004YsSGvsF05UoghnWi3TAMTHU0uLw+eO0REXMonjOsF98mnAJ1a/TMrpwC7oTJUF3R6m5oIjkDfUWZsWnngHIIz6jSxdSpgxjuvYhE2hb90A+GCnJ4PO3ot8EXaWaDfp5OztI1ekWAWkkn//AIDIe3MiNatgjo/Lf0xTpoz0cM34gbA+vMMhuy3LzDTUZR+x7zeypWK9io+XNHNtujx6FY9MpN79FdsabaS5JB6Q3e2QQ5l1GuSdyRoDwS9z4GHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8kTz3UuxbLTXCbVk91JbXoYFGITc23xecx2ViHTeYoU=;
 b=KzLzpVdx4oDiObahEEZWTG/AQdwAb02wAaxMoAxm47zDruuj7YGUOVxTtsjaE49SAySGQYQ329Hv5EhngEaXLaqA/0fQDIY+5EJGC4Y3ssfshnVsIQWWZn7n4h42yEwGCUdfOh28OX0BMhQkjR6B4CjgsMZQyS2/Y5nCMAUDbGEHeAEZ9Wbg4W6/3EtJYe1kqAuX5qJW/F+Ht+ZL8yum13q7lLB8Uf+uYNMVhIUIlPtpuck6qetfV1DgA4IkkzyOlIu0hxU1x9Egtzk3rCtiEYMN+aZsPfLmkmEVEz/Ue+kIWL2wI4Ap8Twi4HLC8jTKbqVnS6TfyeDXFXIvG/jKMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8kTz3UuxbLTXCbVk91JbXoYFGITc23xecx2ViHTeYoU=;
 b=O1tRTDUzK8ZIg0lVzpwhR+3QtRkLNf3eLqnB04o7IQdjvDgVNI6nXKLi11StA1XyBd0l9MP7qQwjX8CcOzKjXMFxfxLcV+q9K3Bsv/hiGCQaoXwQ7akJqUjWrGWuqMY/xnemqWfuI47WMD+Qaw1A/vXvRXTaJeHYeelh/t/ARaOWaiu5RhHVabryxjxSxPY+ehyh+SGEf0yLNZ9Qc5zgXPTjt/ubtIeQ26D4co4m4Tph8Ise+KjZfAcxv1DzgACWPylucj1/Shrns/kZ3gi5tgZhZT87DKBRPRGJCSyqThcpld4Ws+9iJwzlzMJYo4gS45sXEK71kz/2BB7SKYp4/Q==
Received: from BN0PR04CA0049.namprd04.prod.outlook.com (2603:10b6:408:e8::24)
 by PH7PR12MB5757.namprd12.prod.outlook.com (2603:10b6:510:1d0::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Wed, 23 Nov
 2022 15:25:26 +0000
Received: from BN8NAM11FT080.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e8:cafe::34) by BN0PR04CA0049.outlook.office365.com
 (2603:10b6:408:e8::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.18 via Frontend
 Transport; Wed, 23 Nov 2022 15:25:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN8NAM11FT080.mail.protection.outlook.com (10.13.176.82) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5834.8 via Frontend Transport; Wed, 23 Nov 2022 15:25:25 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Wed, 23 Nov
 2022 07:25:13 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Wed, 23 Nov
 2022 07:25:12 -0800
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36 via Frontend
 Transport; Wed, 23 Nov 2022 07:25:12 -0800
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
Subject: Re: [PATCH 4.9 00/76] 4.9.334-rc1 review
In-Reply-To: <20221123084546.742331901@linuxfoundation.org>
References: <20221123084546.742331901@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <4b79edd5-bb70-4a7a-a905-501fe7299778@rnnvmail204.nvidia.com>
Date:   Wed, 23 Nov 2022 07:25:12 -0800
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT080:EE_|PH7PR12MB5757:EE_
X-MS-Office365-Filtering-Correlation-Id: 38fc7f0a-bdfa-4c01-d079-08dacd66f1da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kr9zpW2v5RJXkzRX0Yssa2FqUVqImGMgU+wKuYmyXt0mFZUoypAMCMWsBwXau96Qn36rsGEAqngnMJLnHt2L8cUTGQKx8lXFMSuXA32CZLpPMGBpxl4hmdz/mWjviRIE5UBz3cjwHtvRfmddUKkPhK4Xeho86QNryCfcG1cLOyyQ3Q4emPQgcGJ5J8+PPFz/gyHrWFylCiIRzk1NQhZzsCv3ZRl52rD6YB6Uvfbi2h5A+S1rT5Iy1aV9zl9gcLx1OfvbZpOXhTkbsP6irpl6M9YrTag8O7GwKwQ9rc2gcebYYGOkY0JxQPafRiqLrWlYtg1L8Cc0N7Jc+tTxHSQT39Bqi2+VMcycA8yX9YNdlALxj9BKRWmTVjB/MYS/ut0ZhrOs4Rp0WwUhcnRI4xAla2wQC0wfqUuSGqwgFe6UfoQjNY2lQq3WvaFue5ZfFPicSwjEvvQqvNMQVQzrrHR6WsrSgJATCX/KAJYF1xkUzYBBb6G4/vfTuXoMZRPRFBmUQQD1FugJplPe7ENjR+sVUr6FNrDC+jjXS2SfF679OOdmO9amNA9E0nZky/Lcu5MvGbPEet5bKJCNcJfzcoMOa9wmO43bqVHWs47RIm6h4oAGrCZoOUj4ssI+6uXf/YwPsLkW+KX4876PmWHeuqCRhX298ldQYmFVRGZHm4j8qd3d7Jy/ApF85FUuKumVmqk/iYiW4pPEPxj8lYQ544eqFSAbZCQL26AryoeVf4LLUlNKpuW6uvJJZ1TBNQjyZGE3uwC/gJNx5LRueAj1tkQ2gy+qkPjZ87fhaS3g10dl1sc=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(136003)(396003)(39860400002)(451199015)(46966006)(36840700001)(40470700004)(31686004)(7416002)(86362001)(31696002)(82740400003)(4326008)(356005)(2906002)(36860700001)(316002)(966005)(8936002)(70206006)(6916009)(426003)(336012)(47076005)(478600001)(186003)(8676002)(7636003)(40480700001)(40460700003)(82310400005)(5660300002)(70586007)(54906003)(26005)(41300700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2022 15:25:25.2166
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 38fc7f0a-bdfa-4c01-d079-08dacd66f1da
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT080.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5757
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Nov 2022 09:49:59 +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.9.334 release.
> There are 76 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 25 Nov 2022 08:45:20 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.334-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.9.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

All tests passing for Tegra ...

Test results for stable-v4.9:
    8 builds:	8 pass, 0 fail
    16 boots:	16 pass, 0 fail
    32 tests:	32 pass, 0 fail

Linux version:	4.9.334-rc1-g48639dd0eacc
Boards tested:	tegra124-jetson-tk1, tegra20-ventana,
                tegra210-p2371-2180, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
