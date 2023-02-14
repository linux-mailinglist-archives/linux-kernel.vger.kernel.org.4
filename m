Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87559696458
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 14:11:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231561AbjBNNLK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 08:11:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232698AbjBNNLB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 08:11:01 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2086.outbound.protection.outlook.com [40.107.94.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9FE1279B2;
        Tue, 14 Feb 2023 05:10:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VQts78sEXTOyt2MEu9GStvNbbRsUGNgGvaklfUG72OeJTRl+tavew3EQ6/QY0z73m0IxYAP2YyD6aE/yrfCZ6W8K10hbAC4fZfodOATQXxVvEItNqNYLGt5xMEY1M8fnbrl4aLOANo885jmxeoEUzppnvhQqW6Bf3DAdAFWXOScyEnh5m14S3GdzuGbNmWhdHxZy2vcZNHbO3XxpkzJYlR7WKXb/sAPu6lS4prTv0R8bgZIcdUnCfYyyNlVSzm9aCyQDJjcHvI6AbWlW3sIoxetLtoP1fdE1rd0sF7tCODdxKblSGLFp24+VlLoP9FaTPI5cuKMBbM8Nvaazgx6ckw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QiP+mFLbFCX3s3z2iTjNwf1tyjEU0Xf1A41FJDuj+Ts=;
 b=RA9vOFSePlVt//nrfp4uvlG84ZU2Uw8egmiOzFb9CLW0i6sAanBUSbNT7AdZ37naoyrMfDvm4XfBOecxg7QWa8v4laKrjQC4GESzPhWlkZ020OvxFEVd0lu9BdxCCbx16zflf/U7TII0GJyIHAGDOGgjIwfkhfPXFZ0bIAzqH3PdaUaap2GAB4MA0oJ5Wa24lydrmI1S7j/b/At1V2dN4qVujWvwTEwdqLd/NPFTA8SLxFSD7SCmf3wqIKzhcK8682JbbgqGyRshkZhLm41tOFq4/AzYRWsG8k3+5lKuXskWn1ldNi5+/21R/c9gzx771yDBMRhc7g4Fmq1KL3dJ7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QiP+mFLbFCX3s3z2iTjNwf1tyjEU0Xf1A41FJDuj+Ts=;
 b=NX2LQM76216CEL1NBqZU3/5V2Qz+nYeDYv68ZJcqyugUnZ+EUdMXE14RAjL3xRdnuzdJa0hOf8Jd+3RUp5L3TW+byPZ7oE11bKFQ9tlNZVBi+BWaMTKJiC4FutIMAO++A1Z4CEF7pJyQ/S6vj/bXPYUy/AsxRz8n8r9Etl/VRbkbCpo1yNxVupS904mYZLPvUrG4ruvhrClXQgkVDBF+Xc+G3nd+8LfM2PuWedngavEv/5WaKo884OzLM4YP0kr8hZws/oQNN8hb/PDW41Js5OkLj6lBzDGQ6HswbMVnR/LhqoXDOK/YYYo1KRSMr3oPS77jWx6oBfIeGMw/z6zcAA==
Received: from MW2PR16CA0055.namprd16.prod.outlook.com (2603:10b6:907:1::32)
 by DM4PR12MB7623.namprd12.prod.outlook.com (2603:10b6:8:108::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.19; Tue, 14 Feb
 2023 13:10:55 +0000
Received: from CO1NAM11FT069.eop-nam11.prod.protection.outlook.com
 (2603:10b6:907:1:cafe::85) by MW2PR16CA0055.outlook.office365.com
 (2603:10b6:907:1::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.26 via Frontend
 Transport; Tue, 14 Feb 2023 13:10:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1NAM11FT069.mail.protection.outlook.com (10.13.174.129) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6086.26 via Frontend Transport; Tue, 14 Feb 2023 13:10:55 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 14 Feb
 2023 05:10:43 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 14 Feb
 2023 05:10:42 -0800
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36 via Frontend
 Transport; Tue, 14 Feb 2023 05:10:42 -0800
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
Subject: Re: [PATCH 5.15 00/67] 5.15.94-rc1 review
In-Reply-To: <20230213144732.336342050@linuxfoundation.org>
References: <20230213144732.336342050@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <a01335e3-8e42-4b96-8e0d-dacf3a12be25@rnnvmail201.nvidia.com>
Date:   Tue, 14 Feb 2023 05:10:42 -0800
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT069:EE_|DM4PR12MB7623:EE_
X-MS-Office365-Filtering-Correlation-Id: c7eee1a6-b8d8-41d7-8db4-08db0e8ce7f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tIFUlHg/axbXEWQ6XKAiaERtv4HqSYk2vjmO4GUwP2MBSkbnJ1q/WdZ6K2zuHWNBtMflXlzlQqx+7tBklI+VOXv2fBBMVFOr9hQoC4XWi3FKHcVIBRlv1nB9uU0jQGvR6Vj/SdUTLAiEoze6Fn3C8InzJ+jiefq+DKXS8fpXkNkycokbndHioAYFfgZaXreVGjHbCNu/lyKWES2lint/uDLDChn4rrWG2xJ+uycUENgGy7dju/uKa4CO8zrFNaEm6eG9/YSyKEcNzSi+Vym86E92FsLYAqIByWs8iBwacDWTvMRIg3BdZzQW4wwI8WAL4w8+hwf6FF9Oks/Xx363OjdYENq+WwsSWmXc744IouZWz/TJ3ZVbTshid5omWwry9fRLJW5dPDFUtKYN8gMq8oLgzBLWNKeGdqIsefdaKsQmWDWYXgWLdNkp5EdZ6wxTXP8Le+GBSKKs5V9O3FPCsnq4UcHz1DsWeMuadIVBvfNjaaa5RCOcC+K6wC1Ga7ObOyZ6pfwVkIhr/0PbUZyCJZRnIwLl7cMp2Pmh8+GllkN231YAc5bDc17KXPht6CytDQBtPCbcObQvWofmcRqE+GEL2E5TLpFLgUJl7dGq4zW8e7c++UpVseCqf6oahlnjUtE0KRLJkWmYrrUTHMSHjNSJuIwg0qLvJyBuiGAj6pC6b/vZyEXhgTsITZtpayRYI3zTI5pXx0/q0i1h5DJ3KnxveqUZPw6H+ljKLdWEw/aMn7ooYpdLaa761BdDFe63
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(396003)(376002)(136003)(346002)(39860400002)(451199018)(36840700001)(46966006)(40470700004)(966005)(86362001)(478600001)(31686004)(70206006)(31696002)(82310400005)(336012)(26005)(186003)(4326008)(70586007)(6916009)(7416002)(47076005)(426003)(356005)(316002)(54906003)(2906002)(41300700001)(36860700001)(8676002)(5660300002)(82740400003)(7636003)(8936002)(40480700001)(40460700003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2023 13:10:55.1556
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c7eee1a6-b8d8-41d7-8db4-08db0e8ce7f6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT069.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7623
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Feb 2023 15:48:41 +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.94 release.
> There are 67 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 15 Feb 2023 14:46:51 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.94-rc1.gz
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

Linux version:	5.15.94-rc1-g2bf3e29e9db2
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
