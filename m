Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96475658A03
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 08:38:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232644AbiL2Hib (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 02:38:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229992AbiL2Hi2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 02:38:28 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2064.outbound.protection.outlook.com [40.107.244.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E484A458;
        Wed, 28 Dec 2022 23:38:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DdTR8rs16L1Qi4MjQg0oX2QfAJQPccQLoJSSL3tSNtr65Ha5b3K9niR90pOW6/7+Lj/+5SAZuO7Rv8KveedqURKRc1tUN5rB0uA2LahqGv2xV/zJsVhGTihXZDYvph/eumNQa2o7vx4hCYxwc8zCtkIQzEwzTffgkkrqnlFlyl0ILNGBjsmcDuafW8145WaM7vhHCOIMKDcnhZu7UWSBk/tb3lyXy+ys03VzQ17gp6jCKX6b27WokFPehm3gQ3NePjk0AIBsAj66NFDYR0ode+7/fJdxRHQZTAoOrsfPyHoT7GU/Dr+TIM1g+QFgNA7KRstBaJ9Zo0zlGuHJSc9XAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3p9Hq1RoVC2a5hDIsBEXSPNhMrXbFdLXuNu6lLt1Si4=;
 b=UtrK5spJXiGpL86HRoCcNjP2RaR+WqptPppcM3JHNr8NnaYGyWA5g1+31BM0KBvZoEMvuM5Wgj1DSckqE2yfdYKKsHDeVyrnOFPyOnaShKU1nDeR+9Sz0kUoLOTyN9nGsgG24yOeYY32MCOVKKXf4rukPj+p3U/yMD0wwn4/MvrxtWPRqvStbz0u2IdH/UvV56r7lRBRLdwleFzazTQ3jzguG/kXYk8TXGv0iEqRPiV8uy8UWnPT6+XPG6HdXwJEUFboJN4ncSMBmOiQ+y/H4/Eb7jiuLE74UuayD3Rmy6yEEZmABFIeQk6OoLuWJEgtTrnbIw2tteHAxshLwsLmvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3p9Hq1RoVC2a5hDIsBEXSPNhMrXbFdLXuNu6lLt1Si4=;
 b=lpma6MKyAI4Vm6Uuq33oddFhZSCHHmhupDnm/Zrp6S3uIgPADeZgbXmsuHK5Yf8cZJKiymDvbEtWucNJT3kuwBXEkDIui6HDbPpdBUKIGx+DAnChRtT/zpRJT2ygm/2c4Cx2QtopnPsPpXOkOpXWeuc1p/VGXDbxMXmfZjzZYS+qSyiNiVOK9hHSdsQn2JGkN8LIy7DUaQ86ks558c/sY4a9yh6Rbt/uw71Rcu7VKyF2uwpPnn2jDDbD+6T/8co+20vty650BkL52xYXHb9UIrC2yDIhXC6/N64LcETgs4dcfm/Wvse9DR/TJWVUGpbWz2CrxGpViUmsI6Zm8tA8kw==
Received: from BN7PR02CA0029.namprd02.prod.outlook.com (2603:10b6:408:20::42)
 by PH7PR12MB6787.namprd12.prod.outlook.com (2603:10b6:510:1ad::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.16; Thu, 29 Dec
 2022 07:38:24 +0000
Received: from BL02EPF00010206.namprd05.prod.outlook.com
 (2603:10b6:408:20:cafe::94) by BN7PR02CA0029.outlook.office365.com
 (2603:10b6:408:20::42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.17 via Frontend
 Transport; Thu, 29 Dec 2022 07:38:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BL02EPF00010206.mail.protection.outlook.com (10.167.241.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5944.8 via Frontend Transport; Thu, 29 Dec 2022 07:38:24 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Wed, 28 Dec
 2022 23:38:18 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Wed, 28 Dec 2022 23:38:17 -0800
Received: from orome.fritz.box (10.127.8.9) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36 via Frontend
 Transport; Wed, 28 Dec 2022 23:38:14 -0800
From:   Thierry Reding <treding@nvidia.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <patches@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        <torvalds@linux-foundation.org>, <akpm@linux-foundation.org>,
        <linux@roeck-us.net>, <shuah@kernel.org>, <patches@kernelci.org>,
        <lkft-triage@lists.linaro.org>, <pavel@denx.de>,
        <jonathanh@nvidia.com>, <f.fainelli@gmail.com>,
        <sudipm.mukherjee@gmail.com>, <srw@sladewatkins.net>,
        <rwarsow@gmx.de>, <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH 5.15 000/731] 5.15.86-rc1 review
In-Reply-To: <20221228144256.536395940@linuxfoundation.org>
References: <20221228144256.536395940@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Message-ID: <e68ec684-5cfc-4d8f-9b91-8eab2843bf01@drhqmail201.nvidia.com>
Date:   Wed, 28 Dec 2022 23:38:14 -0800
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00010206:EE_|PH7PR12MB6787:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c7c49fd-f98f-4fad-8f11-08dae96faadc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sYXYp8DjUYlQzxGapg5yFZh/LzfKgGVybe6lf33uQ3eSM1H47qvoKFFh6oV5V11TQAxzMxqWSjO5icr+Od8v5WdgOj58U3eG7Ag3gKBslsQbp34YY8blXQ6PX4LcjjzvI6aUNaXllW7l9TqNpxqa0mNhYK9Zae4O+uBZ3XkSkbyMVMqjaWvYP5T+HDw3rpBnT3/cga0PskqrBJhF3FXgnDBaCJ0fLcQdwaJjn0UVzACwjyAwbfHETtUqwPnnlS3U0i+c8TMFShqZ4Kq02cGYrdXT8J+4WA9ijrQKBJhAARK7vkaaxhN94iMUV+bUPrAKRW2i2RGMXy4m9O5OtOtbaa1AN4anqREKBEfdkv8uhniforR5lk4jNwtki3EOPQHY6oNZscmMFxkxQQ5Q3MyznAkE7ivD4z8wlTRErGqzOMeHRD6R7VFNJS2OolhfDMJUR/FuMfDEKrrolDxbxyh5hlcrpmh4Gqoq0PrlQ4Tjfv5WZyya9iu05Z60Zg/fRNoHVXSnTl2MakpHYV8xs5f/Q0ldTWYECe3s5y4Nh07fTzkWAJUk7KV1Qyeq+1aGA7hSFtezcQNkd75vklM+/2gcytjU5j4gItNL5cNL+F5HFyTqwcJ2onD0o0E8s3ezWiWQsdS/1mHRo/UjHTTl/fYnr5YgDzF1qRPgEvtdrHEtG37NZdHXQI6k7uzD/q17SMZJQQNuOhn78bH8SYDz4Ai7pK7xutOG+fcJ6wAm2yKSXSJmyGQ1jdi+B5Inw8BCkt+3N2vFzpy3cAXDOWaKF0FVj4PZzunyqD1y+VqBhczqKOk=
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(136003)(396003)(376002)(39860400002)(346002)(451199015)(36840700001)(40470700004)(46966006)(6916009)(54906003)(2906002)(31686004)(478600001)(40460700003)(86362001)(426003)(82740400003)(186003)(316002)(26005)(356005)(8676002)(8936002)(70586007)(36860700001)(41300700001)(40480700001)(336012)(966005)(82310400005)(4326008)(70206006)(47076005)(7416002)(5660300002)(7636003)(31696002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Dec 2022 07:38:24.1538
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c7c49fd-f98f-4fad-8f11-08dae96faadc
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00010206.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6787
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Dec 2022 15:31:47 +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.86 release.
> There are 731 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>=20
> Responses should be made by Fri, 30 Dec 2022 14:41:39 +0000.
> Anything received after that time might be too late.
>=20
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.86-r=
c1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git l=
inux-5.15.y
> and the diffstat can be found below.
>=20
> thanks,
>=20
> greg k-h

All tests passing for Tegra ...

Test results for stable-v5.15:
    11 builds:	11 pass, 0 fail
    28 boots:	28 pass, 0 fail
    114 tests:	114 pass, 0 fail

Linux version:	5.15.86-rc1-g9c8c39127c59
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Thierry Reding <treding@nvidia.com>

