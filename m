Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7285968B7CE
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 09:57:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229945AbjBFI47 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 03:56:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjBFI4z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 03:56:55 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2052.outbound.protection.outlook.com [40.107.92.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 519FB12857;
        Mon,  6 Feb 2023 00:56:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QnpNvWcZUY9DIFaq8TJnHw/ahfZ3viUWXXWksNCMwYRoine85/02jxPPyLScqzcAEs81d7812NY7bXQVRyriz77Y8tJZggfyzz4hhemn7qrV8tDbg3Nswk/amRgOqfCg3yGg43TxF5oj1egCpvwM4grPozdq2gIMlFvLsx+33Bcht2wtCnk36t9JrxrYBMilNBDy8JoRI3E5puwH9OoR3HgTtOaztE6zwBQiCVgHFO/beycov/ClbR7R2UL17bdCpJ4VFjjfiqbXZi1FfBs+x66iCi+Hr1dPT/X2+hGC/n2E8HK/J9AOzkcxskBpjTNacmBkB4+krjv3AFIGQNVObA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EnyO9ZjGhTTa7VYqkJZIPvHzvE3jYcMgYvh5p+nZ8y8=;
 b=VnGtmRUksG+cV2eE0XHb8n8Wed0mcSKgaNeeUQZ4hFJdz2E+ljmv9egjKqxesfXn4O6hBXy1Gc2PCYctNX19oXHVNuXfwlvh0m+Bumt9clLfA7R1dj8xKxnnzm6Pyixqrat/FJQ7LoJ8CVLg8myHOSJwiguF59lGb+pKWQgHWGd7H3k6dhjJaYx9b6jpRaF1FrXUlMzSnMBLRwgkqOoJWfFLsd0hsEhf44MDpNtfZeo/BAMhh5GbO8Ogee8iZju5mX2e5JMqQAoi4xQYXbZNKqzS3BHz8f+D0Vvb/mUp3M/6VVPxe7EeE2YVM1lJojoSelWfGAYykAfdu+tfyAxHOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EnyO9ZjGhTTa7VYqkJZIPvHzvE3jYcMgYvh5p+nZ8y8=;
 b=Am7pmv4Uu6KUaBFSdCpIcF/+tY9img9Gdz2Muz2i43Sn4kVBedckFnM3tNJaUsajJP5Y+mjC3ZCedaRKP+V6aCAd4irc89WEQFshrDobqkelFWSALT7DFxmvPiT4gvCnwLNwqfad+mtW5h2tnlwcXNWXrKUPpUcEUSGXpZDr4nHWtBUmnOgS2M5ZlL1zD6Cb5jvey9fnHcR9PxcW+PXQgHkcGkK5I/ll5YQhbebr5JS/QXi56mh7e8V//MSUxcrhqk7UcmNr9RQWuuXt2WT7gf6INmXZM9oDpjRNdZuTwTKmbne1ouNE92yjrxVf1j0J+lXciZnoxvyvd9SmWJbj5g==
Received: from DM6PR07CA0045.namprd07.prod.outlook.com (2603:10b6:5:74::22) by
 SJ0PR12MB6830.namprd12.prod.outlook.com (2603:10b6:a03:47c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.34; Mon, 6 Feb
 2023 08:56:52 +0000
Received: from DM6NAM11FT049.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:74:cafe::f9) by DM6PR07CA0045.outlook.office365.com
 (2603:10b6:5:74::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.34 via Frontend
 Transport; Mon, 6 Feb 2023 08:56:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DM6NAM11FT049.mail.protection.outlook.com (10.13.172.188) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6064.34 via Frontend Transport; Mon, 6 Feb 2023 08:56:52 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Mon, 6 Feb 2023
 00:56:46 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Mon, 6 Feb 2023
 00:56:45 -0800
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36 via Frontend
 Transport; Mon, 6 Feb 2023 00:56:45 -0800
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
Subject: Re: [PATCH 5.10 0/9] 5.10.167-rc1 review
In-Reply-To: <20230203101006.422534094@linuxfoundation.org>
References: <20230203101006.422534094@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <95a66cb6-25ee-4931-8ce0-ff91b2832156@rnnvmail201.nvidia.com>
Date:   Mon, 6 Feb 2023 00:56:45 -0800
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT049:EE_|SJ0PR12MB6830:EE_
X-MS-Office365-Filtering-Correlation-Id: 3905f4a6-2a78-4bc9-bc76-08db0820170f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j2bHLm3h0r5g+beZ+Yi0B3OYDYGsLJjD1zTVx1A6uJygwCjHOQ/BIztK98nyYOiz4WQUXccRLi8rnsY8FxpXynAqXzMtp0NK1uMuF7f7Z9oAhjbgh7FXlXxfeu5gKa8argYeyBHvdVmwjJGZBhS8flCpEY3N0k8CtZNlLGt13UelA0kL0uJGPieR4BTPWk1s4kKR3ezKMnzigxzpSR5InRp4UiQ8i5PM3jawksm/4Hrmr0e0ojEYssYd75MhB2TuJK2AkftcbszR0/oPfNOHKT+hEc4P8dhtuEFHZ8Q7KW1Zbpvn3q5Csv4J8rmMUP44te/iFZh+6ySVSU+8gvou7SK59sftq2ZQ3ZYkx3Njoj9EwOO4WBEhpjTcEfd40sSqEDpvMPRQU6JSBJB0Na0AeZFavtKRA42j0MfgSpuuw1QOldcQiS+gIQRPjMEqUxWlVoCSAq6WbhbRjtNNxOztxsk5ow/zVHyUkNJCqc9Ttz6Cg7ctwoWQmfSgOtaqo9j17v/+atjjvZkorODvA6EAOGpIPh9mQK2D+97r+rHzkasKtvy6rYrhOL8tfGjVKIgugJn3bC6AZyPkP/89BxefGFOSqvz170wb1E3U9/uBJtZw/XTDj5wBIGSw1/y2VllDdKoB8fyyrrXNw8rGlHjykViLW4ytSi/GcIJ+sfkbTC8ou0Ph7S/zv/BJUA6B36DuXLu7XFVYmbMTO56uOCGPIleJ2YzPiE1SOlVkzkYtPEKKrjgtqFLpc4aTsMbIX6vDEZiGijpkx0TicbXqQLrDRUNa6b2DmIGoVT5SN2VUfYQ=
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(376002)(136003)(346002)(396003)(39860400002)(451199018)(46966006)(40470700004)(36840700001)(31696002)(36860700001)(86362001)(356005)(82740400003)(7636003)(316002)(4326008)(6916009)(41300700001)(8676002)(8936002)(7416002)(5660300002)(54906003)(70586007)(70206006)(82310400005)(40460700003)(40480700001)(47076005)(426003)(336012)(478600001)(966005)(186003)(26005)(2906002)(31686004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2023 08:56:52.0533
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3905f4a6-2a78-4bc9-bc76-08db0820170f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT049.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6830
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 03 Feb 2023 11:13:29 +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.167 release.
> There are 9 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 05 Feb 2023 10:09:58 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.167-rc1.gz
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

Linux version:	5.10.167-rc1-g34c96ff6b629
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
