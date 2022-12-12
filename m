Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0152364A879
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 21:12:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233470AbiLLUM0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 15:12:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233459AbiLLUMD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 15:12:03 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2084.outbound.protection.outlook.com [40.107.94.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D491BC00;
        Mon, 12 Dec 2022 12:12:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RyhKama7FufTwangiBgjIT7sCugYpBFEyzHcD7sAVRczr5GnYzzgAfDIhddrpQpt0p6o86tolMlvS1W4c1RfDiw4elNk/mPa1zXBylcXETtJu+9axukRCZ61BirfBOPs34pGmbZX13WQOr7IxwEEZ2uAENP8VTJAPE7OMeTjOKb6tMauU+pmJ7ijLHzvJHMm335u0+xKl+7m7bBEIbc8lGc++paibz1fU9XWl8JatrzNBuQMJPlOkUwO3lwZdMNfe1gMXRTMyszJGia9n/YssADbgTU7jlG9z/t4SrldkTvx+98pKycSkJYS2qcBZCIiff9dnaogwO+onrUrnIsRzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CW7kIWLOJweV+hhl51YxBo2JlhaZuSnFtaUmACL/kLA=;
 b=A7ftirArrOz92n7kgU6l5lQlBbSd9alzxBhQdJKTwh1f4tXwNx37NB68LuRoix4M1RGdLCCKzj8RS8DvUkqm5O1KILW82md+tNUX8szTvR2r4f1zmEUiN3EjtLnmNRpoJ+PzFILjmcUa8rYUt7CUcm8+ZJfOZN6LHLy8wCyP8b4IuE+gqNfuO1rkzPD8hBkdd8/EXnAr97Cw31bL94FcLAw4ZdgItN6SnXVd3rIF6H/yn7mxWrwS7nKBIPwAhv+8Wn2o10+K1t7zBO6AgJbzLkIBc/fNFozsRM2aIMADM7Zvj3HOSmBLKaLi7QO/4p6CrXvbBQDF/8IUsQZziULQCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CW7kIWLOJweV+hhl51YxBo2JlhaZuSnFtaUmACL/kLA=;
 b=ayh55vMt9jHH1Vmsm8BYygFyNaoKOJ0TxJHwwsJHdfvGB/sQe53GaArsSShqkuDNqjLHRJnOvULGjEUOWvTChurciaVxeZP5/BMWD8S4FEw2T1YGYtrCILIsilFgqEHGo0QSj7lwXoSPW+aUSj4N/qCZhJszUIJHwM8jDeUqOS6ZVj9OKaRb49AApuHSdUtemnxOmkgRFPcK80T8YcLA9aebaa2HBI8wXMJpGkBUV1q4mFpal5qWKGIhTU6dmCEMnFc5Iz7ouUZEOJTu7QWtwag2PWT+FDgOSg2AnRc21pT6JaFy7yyNjq2cG5CwZwS8C0t3DX2jbGnYW+RWwEpQjA==
Received: from DM6PR10CA0014.namprd10.prod.outlook.com (2603:10b6:5:60::27) by
 DM4PR12MB5913.namprd12.prod.outlook.com (2603:10b6:8:66::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5880.19; Mon, 12 Dec 2022 20:12:01 +0000
Received: from DS1PEPF0000E649.namprd02.prod.outlook.com
 (2603:10b6:5:60:cafe::97) by DM6PR10CA0014.outlook.office365.com
 (2603:10b6:5:60::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19 via Frontend
 Transport; Mon, 12 Dec 2022 20:12:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DS1PEPF0000E649.mail.protection.outlook.com (10.167.18.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5924.8 via Frontend Transport; Mon, 12 Dec 2022 20:12:01 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Mon, 12 Dec
 2022 12:11:44 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Mon, 12 Dec 2022 12:11:44 -0800
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36 via Frontend
 Transport; Mon, 12 Dec 2022 12:11:44 -0800
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
Subject: Re: [PATCH 5.10 000/106] 5.10.159-rc1 review
In-Reply-To: <20221212130924.863767275@linuxfoundation.org>
References: <20221212130924.863767275@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <fdc7def4-3e34-4649-9b5b-5d049b36f31a@drhqmail201.nvidia.com>
Date:   Mon, 12 Dec 2022 12:11:44 -0800
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000E649:EE_|DM4PR12MB5913:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ebf6014-c5db-4c0f-9b95-08dadc7d2172
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rwkAA52H8FjPW6qbYFfgabi669tpdXzfpautQXB5XkiAlZXSvuVYCt9hX6ILjf8Ya81T57yKKbUz4qS0YAbeK81YQk3ONR78WYiclCd9dkKgv/D3Gb0sPUBAWJQLJYoDK0picaDloN2OrE5sNNUmCLeUejfpD6/T8c8BH0WG+N3Ae0aJbwHMYtkTgIXVTPavJyjEbFpUlbGc5yuYZautHz1nx17DhKgZH43dC/yXyLzkU+33+cSVHVz4a5SOj/JSafYLFWZgCJyE52O9KeQ8kJz4oc26MssVVhqIlmrsQQMRfqPLzPNiN9p+Etg+pR1R33T0d8lkBN34tgP6RRfbCsPfxsypogSn3CKkP5rRIyMW5T1OeodMZ4lSl7J8qFR5tXQQCWGwTGqL62isCGC9R3SJ+qfKqMQaX7a3KEShWPk4Lwi1QQWhfjFsKRDPts7Xvn3Eq9rrx3+pbK6oufgbiEOBJ7/9f/v2eFgMMeICjmVmjzv5PvkNY0j0Hv1iU338Pw/cAzxDkywMANNcRASOceOSdAZ40T0wUqsg/M0ySq/c+PDvBqpatqjYO2e5XMmlLVCKurLNgNh1JjAM7gDyLz//C0wIfWJp245xEqG8VDPiyrZBz7j5ZGm3QumrtMqqzxGryyvW7gnAKIQx5FlsWNVDxY2vvuZsjEzh48dT2TZEbrNU3dTMvpSZgeIhBpkA8hpEiau9agDZT+L/9qMtGN/29xhpLvK6lYE0yf4zHpfaKunz2Yc4fKgL9Ltn72TeFbvXC/WDrEEDJmrEH+nSGWQ/R7SmloTEyyDDI3IsWNU=
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(396003)(136003)(376002)(346002)(451199015)(46966006)(40470700004)(36840700001)(31696002)(2906002)(40460700003)(86362001)(336012)(54906003)(47076005)(426003)(6916009)(41300700001)(7636003)(478600001)(26005)(82310400005)(966005)(82740400003)(356005)(8676002)(7416002)(70206006)(70586007)(40480700001)(316002)(186003)(4326008)(36860700001)(5660300002)(8936002)(31686004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2022 20:12:01.4809
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ebf6014-c5db-4c0f-9b95-08dadc7d2172
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000E649.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5913
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Dec 2022 14:09:03 +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.159 release.
> There are 106 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 14 Dec 2022 13:08:57 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.159-rc1.gz
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

Linux version:	5.10.159-rc1-gd2432186ff47
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
