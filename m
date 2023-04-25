Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D79136EE08A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 12:44:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233800AbjDYKox (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 06:44:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233238AbjDYKou (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 06:44:50 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12hn2238.outbound.protection.outlook.com [52.100.165.238])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 147541990;
        Tue, 25 Apr 2023 03:44:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dxYnkbxmeDxi98NKCw1AHWaPei+LrfxEjbZrau01jhnkIOsV8umURMXidKdQ8oz3NMcMtq50q/AlkWtUNOj09Gdl+mz13orRh97erOi4FqWbMjffRpxj41XdsQOjyqT3hJ5OBb/u+lRlGiUF/rMoomoxQsKgbMwRTTUply0wKomxBeax6Gwefw0QF5Ui+NkL0B2x8ZzcdImheghFSrUM3h5OJ82+WQCUqZ6oqpbi1RN9d+mT+a/v5E4bGLyVMXEsTMFr3EbbNO8bEICgklu86nFEIrwN8TfyOzzlV0DvO5Hkyi1vPE01buVSC+HkeOVdaZOrOQ+Ncji+UKuJSxHXNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sK9uLP8ckhzc792dqtA+mPjS5SeJfJiQgGVGBj9WFm0=;
 b=etHliXIzwwlp3yXQ7i8wRY1+PRKuQHp32l0MFQKnUijq0gA4d8HkxkqbxH8FzvMZi9gYX3vomGGXMqsiLbGtZX6bFKe/RJXuazS8ZjrxkK54qigAj5isD2by+e1oy+69v4QkEFBG3ksM3yhkRErcIVHKfp2omB3t/5j3AyPBVchRD32dvaFmDwU9asotdyt9cMGhEq1WPLL1fpJ/PY+OsQdfLSXLllC9LcLmrxSWOFl+SaXRTzOn42Nu3yb+ma2boreeebax3vrvMVBEXpcm6mjCdFQcqNRq7LF4PasB3sF6XE40XGVlgjh9PjL3/jkOzvjwm4fHoWdtA8zupKeRwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sK9uLP8ckhzc792dqtA+mPjS5SeJfJiQgGVGBj9WFm0=;
 b=gGWOjhnC5aj3zXMJljGWbQYEYFu82B7cbgC5gTNQtzG6Jos0ZZpF6TnIxwlWb7q01kEyMIzcfiB/EIEEHA7EDNIWYEQ+i5MxoSLBFanXAyKIdF9jSPYHb+BfE/ar2Rwt/0YsUVyeFwEfbM/qA3K/Rx10or+DXoNP8QtDItPSVdJwt8l4MHpltCJzNc3mLbxi3A4TRQjdXI5a0fYFohu3Lbjt1tPdZsnKsJkBqZQO5NC+2+wfSvWZcEtcd3cuRdXBB3fKj7IQHCpi/ZLx6DYp01du1v1bfdHhY8cYxycxu7lfy/OxI5bQJmRn84a5ESkz0qn4/dt4/O+jHSX9r7AhYQ==
Received: from BN9PR03CA0304.namprd03.prod.outlook.com (2603:10b6:408:112::9)
 by BY5PR12MB4033.namprd12.prod.outlook.com (2603:10b6:a03:213::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.33; Tue, 25 Apr
 2023 10:44:46 +0000
Received: from BN8NAM11FT003.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:112:cafe::39) by BN9PR03CA0304.outlook.office365.com
 (2603:10b6:408:112::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.34 via Frontend
 Transport; Tue, 25 Apr 2023 10:44:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BN8NAM11FT003.mail.protection.outlook.com (10.13.177.90) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6340.20 via Frontend Transport; Tue, 25 Apr 2023 10:44:46 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Tue, 25 Apr 2023
 03:44:37 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Tue, 25 Apr 2023 03:44:37 -0700
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Tue, 25 Apr 2023 03:44:37 -0700
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
Subject: Re: [PATCH 4.14 00/28] 4.14.314-rc1 review
In-Reply-To: <20230424131121.331252806@linuxfoundation.org>
References: <20230424131121.331252806@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <b6bf74db-076a-49fe-a869-3a21007bffdc@drhqmail202.nvidia.com>
Date:   Tue, 25 Apr 2023 03:44:37 -0700
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT003:EE_|BY5PR12MB4033:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d969adf-7119-43d8-b5a5-08db457a162e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VN2XTLetlIXeWC6Ovp6KbOL8NvoazeeS5xgcEYhSAZYkXRWRK85nOUAnYICWOuviV9dxvpABnkR9Cw1CICbIOuWTPc6hyMI1upROouVe0X8wBL3C/7FiBOZi0tRs+UTLaCkHSh4lXqw8l6kQbFshC/lmeVZvIWxYJRA0qC1TYx+SYaEuwrCavxadzU3rZqmDQPtZPWmi4QMKPfXz7kwrs3IdbwMPP0LCw4N1uSSh8o0GttGK51KPH9YSWq0yPeBWllIai+KPJGFobQL/aVLDqHxTj/DvrAOZNlNyE1XsQLURvW35eDL0JQGh1i+/b6IglfCVK92NQdqcGawXVdIf9tfkPiVcPLqtQmasCoNwvwxIRLoBUGqWflFNX6nodxTKA+3ioVdinulQgI3d/4mdmn8nYKCGWtaTXKQ6S8BltMqOruohuaTkqTYi93+8k1rUuy5lBup74i/JZjmy3BGvMjL24kec98ULQChSAUQ7XwTfKUBRCfpZvXijszdp/2L/1aX58C5SaWWoSnUK7cSI55hXpTpBBOgL6xxewpb50X1FANZJSkGyec2Wp4f0nuWeAdUdbm0hTt9qO5Gpa8OYFTfFfLpqYaWKu2TKvLHl5u2NoOjcyobUuayV+fIotPwDUvvnKW++myG58SWupSfSIj3lU1FQfV5N/Eqy0+wkiqaD1fS10dBZcZ+KYXNeWRIpoa4CynyxW9uhHoou12LVdPU19UvvLTDd/1tp523+pHWru2UDIRQolgBvi8ayfw0tv831+sQ/oX8eZtwljiy40Rx9N9uJHYVn/ZsxUgSACpGGjhbaXtwGlPknM9Uiaf79
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(39860400002)(346002)(376002)(451199021)(5400799015)(40470700004)(36840700001)(46966006)(70206006)(70586007)(82740400003)(2906002)(36860700001)(40480700001)(26005)(82310400005)(316002)(4326008)(6916009)(7416002)(47076005)(7636003)(426003)(356005)(336012)(8676002)(41300700001)(5660300002)(8936002)(31686004)(54906003)(86362001)(40460700003)(478600001)(31696002)(186003)(34020700004)(966005)(12100799030);DIR:OUT;SFP:1501;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2023 10:44:46.1668
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d969adf-7119-43d8-b5a5-08db457a162e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT003.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4033
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Apr 2023 15:18:21 +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.314 release.
> There are 28 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 26 Apr 2023 13:11:11 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.314-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.14.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

All tests passing for Tegra ...

Test results for stable-v4.14:
    8 builds:	8 pass, 0 fail
    16 boots:	16 pass, 0 fail
    32 tests:	32 pass, 0 fail

Linux version:	4.14.314-rc1-g05f80276ba11
Boards tested:	tegra124-jetson-tk1, tegra20-ventana,
                tegra210-p2371-2180, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
