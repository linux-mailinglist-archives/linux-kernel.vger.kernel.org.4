Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B23F067AFB8
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 11:31:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235604AbjAYKbg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 05:31:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232306AbjAYKbb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 05:31:31 -0500
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2065.outbound.protection.outlook.com [40.107.95.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15AB1A241;
        Wed, 25 Jan 2023 02:31:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ImAs6JhcIDG+v7CFxMTQEGQR5vqUwx+y2CeQz7DS8u+blmNR8Aa/X/JH41+eQJ504reXLeZX7QjKATfXoKpqUlXA2Rv1aKLb+473iSAgrJsHOkxMtopJ+P4WZfd4wLu0N8x3sNHVZ2Am9DF6FLqyyr9/Ft3gS7NgvHiesbk3leDOOSTW/qFNUudg4YarPS9YXeJlwxZ77wdYGIFZE+73rYYfls5PRLwry+Ud4YXEgo7UdBsridLp/GtdxAcy+rj9uibaljRgHtdEJ1xad9+6sV79fa6TQNVKdCc8MuSqy5dUBIs/+iqmbWRdf9gjIZBErJeW7YnhmETDjBHashQ9wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xnLTUp2wJNq/pE56fnTIq4pYuSusD4oDCvJ/u0vqmvc=;
 b=jkn/vX6ZoCGDtcKoe7UgR5uhlxqKU3ECYXfoGJDIn6PKZ6GcrLMTuZ4qbuYeFtIvAQI4/b/lS4u/qI1C9hLhBFdvCg8j9nC7vpaWsQxyxf92JVY0BKkhiVUeukrjIrjcSgsblEoI8/b1IrDkbogIOvShmTu79yijRhrsLN0WoUV1xHmrDXqkpDlgz8lItoL9/7d7EGcVXbsiVvVhwLpFPxWIK9FgussSWL4Iizvfxj+UshXXuPUiwOSsHzm4kktU9cs1rMQyQsKarHop05+vG4KjqbyWKGi3I+1BYEHIMVlE5KWgP9g+rbeDOcPse02dtUHKt2X5cc2YFkbKSfZyZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xnLTUp2wJNq/pE56fnTIq4pYuSusD4oDCvJ/u0vqmvc=;
 b=i5Pe6I1Zgyrh+ks5Xc6oYXtKaD0OKXQFUQrO6ua4ssjeSqnIY9X4UL+qPpRSsYgVB/q/TpcEwIYv6DPUmAUhedUwHAlmoOmR8inIwfGEsAXmtKaOHe/YX1WLumRFqHxZnmof4Rah6qurflO6ysqZbincD0EUS+U+sXhVjw3GULvMDNw+irTUPmPkb0QoXf6vcS5I3LA+LXZ4OiQt4bJ2JtJT/yx4s7rWe/5z/fAxEFXSKiSg8+YP0Eg5BAPdFJ5rlFOr2oWmdxBFbuUMZv1fzDgCFolmZhtiNMECPk3FC4W8ZSHKavH5U+quOxG9XK4pkd2vyqIkzis3guvZtnqeww==
Received: from MW4PR04CA0161.namprd04.prod.outlook.com (2603:10b6:303:85::16)
 by SN7PR12MB7451.namprd12.prod.outlook.com (2603:10b6:806:29b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33; Wed, 25 Jan
 2023 10:31:29 +0000
Received: from CO1NAM11FT106.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:85:cafe::af) by MW4PR04CA0161.outlook.office365.com
 (2603:10b6:303:85::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.20 via Frontend
 Transport; Wed, 25 Jan 2023 10:31:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CO1NAM11FT106.mail.protection.outlook.com (10.13.175.44) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6023.16 via Frontend Transport; Wed, 25 Jan 2023 10:31:29 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Wed, 25 Jan
 2023 02:31:21 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Wed, 25 Jan 2023 02:31:21 -0800
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36 via Frontend
 Transport; Wed, 25 Jan 2023 02:31:21 -0800
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
Subject: Re: [PATCH 5.10 00/98] 5.10.165-rc2 review
In-Reply-To: <20230123094914.748265495@linuxfoundation.org>
References: <20230123094914.748265495@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <f9a53d44-775a-404e-bc3f-84be95dcd80a@drhqmail203.nvidia.com>
Date:   Wed, 25 Jan 2023 02:31:21 -0800
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT106:EE_|SN7PR12MB7451:EE_
X-MS-Office365-Filtering-Correlation-Id: d67514d8-f0e7-4fde-5556-08dafebf51f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W1+YE4SwClIihpgRL/fYAdDkf4puHSY7FJ7Lvk+9/3nEGejOUibbiobGNq2lzhcCcRMi9xOJVa4esF0JnOlOA9rrE2hvS44pYxq3Z4TjdkR2PWimOLlY01jybIfvCNitzsP/Psmaamas0PydX0f6s8/+Ck4EaOHsY6cJDB+qlDLn3f2uLKu0mPCbDv2wrXRdPVQ5uYiZ7hFbX3q98wyTh1MYYuYxwMVprV0ak3pZQSrMZZUJA2v2ciR5rYWgDudpdkcHLH9dxDyIMsfEPcs/F/HL+E2WJxc/CwWBVRH2xllucbh+giXbicrTNV4+2amBcnThKT9/4mEBcEannBulCZ62SxZ8V7PGA6LfWNcWP4uepU5pzvCyLKFjOVKPTdpYyOQMLKsVRECa4nJaJg9Tn3UrGbhRXLvwbN6bGRTP1u60/CIxc2EgXoFhBIMDVSdGvboC/unIkNyds1oI/foHnoFMTrLvdB/vVZaUH2ws3rCTORmVDm6/O+j6kEUaRuVBGnCalteEXbUE055aLJZQ3QKAMTuCrikdqQvgHj4HtiuuAqKaN0upFFDcMpYH/bIYjp22nzitNXQYOydF7rs7eKKM8Fg1pWlOPs+yXGjerhJntQntu5eT8nSbOgKQ+OFVEsHZWGPuNGAACmwiJGJ0iFLT7tIJBEf+ARGfVrypyh7odIpKLJL2eNM1RmbAe5OfmViOc6fl8pcJb4MQ6+8OCkmpLxSTDLsmDacqwBxoMZjc7t0+BUrUeiAFeRmiHqAp6ZmWHpMMZmTGDKXZmPA/+jcQr+4Qdf7h+uy/Pg8W6qY=
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(346002)(39860400002)(376002)(136003)(396003)(451199018)(36840700001)(46966006)(40470700004)(186003)(54906003)(70586007)(966005)(8676002)(26005)(31686004)(31696002)(36860700001)(40480700001)(7636003)(356005)(5660300002)(2906002)(316002)(336012)(86362001)(82310400005)(40460700003)(478600001)(82740400003)(41300700001)(7416002)(6916009)(70206006)(426003)(47076005)(8936002)(4326008);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2023 10:31:29.2650
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d67514d8-f0e7-4fde-5556-08dafebf51f5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT106.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7451
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Jan 2023 10:52:37 +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.165 release.
> There are 98 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 25 Jan 2023 09:48:53 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.165-rc2.gz
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

Linux version:	5.10.165-rc2-g9096aabfe9e0
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
