Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F0F96228EF
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 11:47:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229963AbiKIKr5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 05:47:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231298AbiKIKrd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 05:47:33 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2062b.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eaa::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43DAA264BC;
        Wed,  9 Nov 2022 02:47:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aSP5R4KMS+bcdA3/sSzZLwjaGI3jPb6aInHvmmfkS0xYuA6Pfhn3dSxz75azPjEuzHXQN5+gQjCL23x5qee9pATmLseHRjsOrQID2ILdnXTSPhS4KDflaLbhJbR8I1L7xI6YRej7gDyuaTuFzC6/PRlHp0ua7hK+4F5dKfKku/A7foIouDQpP7t7YGHBxb8ZAVpkte3l5p7cbrYrflByGww3OorlaR5jppYp8t48uIvlgw30w+hLrcuHbrLP/Ecjv4yn25GnuM4DEJrayBARJhEnDbdRpx+k9i87TV3EDB+OQE7YDPIng1k0aMCWT4t3H7boFW6KfZ7qlt2CVmkKNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ouYyXvyc1pFVO/VkiN7EqAsw5w4WzLsZ2I+fh2rTlW0=;
 b=FY19mdJfpkxDu3n0XlT6WRQswoV/tPWrMIz8QqIACRqseV/nfAerID+x+xbG1sf3Y4MdyrYUOYYyj+APAM6e2aAw1kNShC0kqBY+Qs92d2w8hvjvSpeDndQznB2gr4Wkzxy+fhk/JvJteQ8WVDj4qOmh/TAaeSbyjMPNfGhNs2STzrmaWGH0geTyyf3UoUxgWypKcc4fKg9qOL1rj81caMcKVPVoia8yR+jLP9aVasQF70cbRHPqQujLg0MvuwG/v/KbZyV/fBWNuBIq/KlC/le89cSIEysxwz0u+g/vDiVpnbwmwWvwdt7u/D9von5AbZpbwQSGweKbt1zGf21h7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ouYyXvyc1pFVO/VkiN7EqAsw5w4WzLsZ2I+fh2rTlW0=;
 b=nl3U6ozgGjNf9yPl7cLVwhhZspiiqG2u5NdQ95jVlLIwZ2AYk5DVjgMKlj/8rIA4BkS/eVEGWorDpwq7ScZ5QLD0TBXDRGYBjQUcFGrudhdNcmbNCJT3m0v1Vru8ttrtVuVMwZ9t70BP7MUdr1p4by3L/m6xYsHts7Kr201XwPy/gqYorZSPD1yKEe/ac3RMGtBdzTCDDLUL4Iltl9xE8TYq7+dMh3bMcvFBX9x2r+WMnye5P+yeVq181d9PzO3QT/gDvMahG8EtEOhgg0cqbWFGG0Z6OfbeqhKcCVS74F9cb4XRF1DeHLHuUGXBdl44r7EMCAOICUMcNOdJjDquZw==
Received: from MW4PR04CA0035.namprd04.prod.outlook.com (2603:10b6:303:6a::10)
 by DS7PR12MB5887.namprd12.prod.outlook.com (2603:10b6:8:7a::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5791.26; Wed, 9 Nov 2022 10:47:30 +0000
Received: from CO1NAM11FT081.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:6a:cafe::9) by MW4PR04CA0035.outlook.office365.com
 (2603:10b6:303:6a::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.27 via Frontend
 Transport; Wed, 9 Nov 2022 10:47:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CO1NAM11FT081.mail.protection.outlook.com (10.13.174.80) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5813.12 via Frontend Transport; Wed, 9 Nov 2022 10:47:29 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Wed, 9 Nov 2022
 02:47:27 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Wed, 9 Nov 2022 02:47:26 -0800
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36 via Frontend
 Transport; Wed, 9 Nov 2022 02:47:26 -0800
From:   Jon Hunter <jonathanh@nvidia.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <patches@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        <torvalds@linux-foundation.org>, <akpm@linux-foundation.org>,
        <linux@roeck-us.net>, <shuah@kernel.org>, <patches@kernelci.org>,
        <lkft-triage@lists.linaro.org>, <pavel@denx.de>,
        <jonathanh@nvidia.com>, <f.fainelli@gmail.com>,
        <sudipm.mukherjee@gmail.com>, <srw@sladewatkins.net>,
        <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH 4.9 00/30] 4.9.333-rc1 review
In-Reply-To: <20221108133326.715586431@linuxfoundation.org>
References: <20221108133326.715586431@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <192f40b2-5f58-4460-b385-89e9abf0c3f9@drhqmail202.nvidia.com>
Date:   Wed, 9 Nov 2022 02:47:26 -0800
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT081:EE_|DS7PR12MB5887:EE_
X-MS-Office365-Filtering-Correlation-Id: cc8fa67b-59b7-4939-8076-08dac23fccbf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: //eQYUMMiI3/aPYZ/8U3PdVAxNzBaRJUw5FDvMjLAY4NbZgx3B8u3z885QC9DauM/8oPn5fF1I4gtOuHD0OOFHV/2DXxfepV8iWkJWJ+tROhzKgApBK/UekBvQm3T3/akp9jZwOEk7lPdbwAFvliCH6pJRm7RU4NmXb+4KY9wWlIWo5Py6rOOlMk6pteFplCV6Svj0o3vMt1lr8KhljElZNQP6BPk4RQ+bkmYnLRVCjqnH8VHi30QkEs0VPRJUFxqwaMhVZoIPd7ywqb01DZfQHbv1qjkY1glMwAUvXzegIJGlkFtBqogic1yVrbpNSDG2IIg2Y0198Xwf3+C8l6Z2qJ+lvHQ2WQX/wYD1e8WaWh7owGLO0rB7oIVh3+k/LfDgArEC+MXoGUTf7PH3ff8ELu7bpI8Fc1j1Q1ipnlFscfepQa1efugL4SG0bS4GtpjPWBXd+3vFVDVLopxh4I7s2yOah6lYIbNF+7sl0jsqP/kFPsWZZSmUuKmA44R+a8EXqL/WPNFbftCXiaE5egbb6x3djLK0Z31pVkev1sRkrvAR4Mc0GQYNwQPkPpIV/GLDq23GV+CVHNJlpSqwLcD5QyJ+2UtWRJtJFA9Icp/mNLPivfLSluef4zOiJ+8xwZU4xqbwfHtzxoLSA4Ggk0JkBOaW3xQsn1OMqQJFk9Vnzk/V3yZ6j8zd9oPEnKKsdiHSNRws/0LxjC2kD/hODHMUTxI8BOQFT9fTz5RzA7CThM7Rti9WegueLEtKV/YgtI7lgnstO0ZJlqHvojgVuFS3L2gI1j+f/m+PeI8wsmjQoZthZuwb4M4njxu1/HdX1gSqqNdd4xsVZZbz3iRslf6x3de3aJTH01CyK0W4FN+SQ=
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(136003)(396003)(346002)(376002)(39860400002)(451199015)(46966006)(40470700004)(36840700001)(336012)(186003)(26005)(426003)(36860700001)(47076005)(2906002)(40460700003)(40480700001)(7416002)(82310400005)(478600001)(54906003)(41300700001)(5660300002)(316002)(4326008)(70586007)(966005)(8936002)(70206006)(8676002)(6916009)(82740400003)(356005)(86362001)(7636003)(31696002)(31686004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2022 10:47:29.9239
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cc8fa67b-59b7-4939-8076-08dac23fccbf
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT081.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5887
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 08 Nov 2022 14:38:48 +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.9.333 release.
> There are 30 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 10 Nov 2022 13:33:17 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.333-rc1.gz
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

Linux version:	4.9.333-rc1-g2f583ceb0e80
Boards tested:	tegra124-jetson-tk1, tegra20-ventana,
                tegra210-p2371-2180, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
