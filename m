Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F068616082
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 11:07:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229992AbiKBKHo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 06:07:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230265AbiKBKHW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 06:07:22 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2085.outbound.protection.outlook.com [40.107.93.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92E1C23EB4;
        Wed,  2 Nov 2022 03:07:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eYgWAnGx1EkMvINxo+KedobuHzDSNaSQTxSut+wnYOo6hCoSe8ouYi6KrIAOthaP2rz/43Jn7rkFIgobkeBn5kfQvVhRPG4We6N7QhW8crmjyw49e9tRtAj5eX0XVjGatu4i4tVbFtfthGINyf596cmJfWICGZ5pxl3O2VzOfwTWjCuRgZXer+yZNnQeH5Lw+F18Xk0qIRZdQBJVB5bNdyD8S8/8zIba1FtuitCY+vnxwanFBa+HWgwKu+waa+xr0zCqPKTPLA8i3g66eo+Wnl0UpFGtVyDhmJX3YRmP5EhP0rJmpRA+ErJT04zB+Rd49zsdOIEQgnKkjfGndOHAJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MUPAl5Zix7oHtUGAMN6qayVD5kt8XgrUTJB/qERvbJQ=;
 b=F4q70WA6UYS+Lsx1mb2Aa9IQ3cLXynNRUEKN/yqV/rb606EzIwcNAcUM4LOSR+VqvklCWK2VmPrh5tkuWSqjj8NMKzMlMQUJmwkcNBtKl9K5Bas7ujWkVuNkAqlN1qrqitZoJXSW8xFXMLFcyzw+BiyC2mnl5iM0XJqHw+pgYzvE9MQEImWc7K+li5OlRNcmLXrREGngT7eVqezBIs/2RfzIqWE8bBeJWuM+9fzNLuLHupEG6UW6EtkK8LZLs0+wrkE+FTXwL/4jbsqNA0cAM6mA9vMCfR46Ut5yFwiiYhErvUgQjGs/IiqvAAqEQwq+o4l1Z7mjtejO4q/IRlKz0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MUPAl5Zix7oHtUGAMN6qayVD5kt8XgrUTJB/qERvbJQ=;
 b=cpiO8ZR5jtDlc2K13KP7NNk+Z4g+ltIC7x9FMBneyjn+1XTe3GsuheDNu88idzJ2/RLC2usuu6arcJ5ELZRP4NZ449C9txmCMp9DHbZjQdYn+6ar3CDkExGdqL47QW1IAMHiJn/6CkS44jFeiiXeVsdKsqBrSAT/yYnIHFn+xXkzumX4q/Fqp2Gd3jPF9X5iSn2QTExn6RD1v7xL6Ewh5AWp7TIRS35TsDsw4u07tIHosRFedoisuszWpNKIEjKn0hDOaByerqbjeBaMytLCRrA+ENR15ziJfIJFoljL8I2RuVzA/iuFeBIIYGSwxAMDYGigskXxR5kB0YMkwcWDrA==
Received: from BN9PR03CA0777.namprd03.prod.outlook.com (2603:10b6:408:13a::32)
 by LV2PR12MB6014.namprd12.prod.outlook.com (2603:10b6:408:170::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.21; Wed, 2 Nov
 2022 10:07:16 +0000
Received: from BN8NAM11FT075.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13a:cafe::9c) by BN9PR03CA0777.outlook.office365.com
 (2603:10b6:408:13a::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.21 via Frontend
 Transport; Wed, 2 Nov 2022 10:07:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN8NAM11FT075.mail.protection.outlook.com (10.13.176.208) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5791.20 via Frontend Transport; Wed, 2 Nov 2022 10:07:15 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Wed, 2 Nov 2022
 03:07:05 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Wed, 2 Nov 2022 03:07:05 -0700
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29 via Frontend
 Transport; Wed, 2 Nov 2022 03:07:05 -0700
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
Subject: Re: [PATCH 5.4 00/64] 5.4.223-rc1 review
In-Reply-To: <20221102022051.821538553@linuxfoundation.org>
References: <20221102022051.821538553@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <ee498ee3-2c4e-469b-8cdf-a8f3c2fcfd7d@drhqmail203.nvidia.com>
Date:   Wed, 2 Nov 2022 03:07:05 -0700
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT075:EE_|LV2PR12MB6014:EE_
X-MS-Office365-Filtering-Correlation-Id: c8aacc82-8fff-4722-758f-08dabcba04f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: k9t9P5SfC46ycNtDhUbI6+/fQ2p5o6d/DvYcXRuVEuMjdwWunRcLATxVhZ3vAyGNMp1UaI9StIcUH91ynjqscfermo8wxFIaDlEcuTnArSqSb9GMD/n5TgW+/1ssxweCLfxhun31U+3M+yT0yl45sFuXzQfeW9gHbJkUAbLOipeITP6Ow4x02CbrZX4Zx3YlbCm34wHX0skvDQRIkxYG4pzV1ccdrCKXhOOhUsFAkG8IKjK/lh+igVSeECvRm5sfVagwl+Bsn2Ju2Npxq4oU2jCkLhokvYkc1QeMB4E7kwH3MyudqLtZZ/BMN9llTo+AO56SP2IUT7hmolRAzsLo0xXfubjTj/1hfwv8DO7hCkN05d0usd4EpL6eD0fi+7BKpoUMb+PidlvZGTTvTDhSbpkyxmckwjl9bXLXG3VfZNd4elfy1+l2E2Sip8sEocTCcdhKjr7g5M11fYoxpxsKkvXEGQN3lSGKx8WaRm3aZe4fAQ4t+2lItnnahGLEgkYJRaTFOBbCcgYv5DpAwpbpEv0SNn+zjGulESQbq1lXHDMOQZ8lSdxrp+FrlgiBgeI96sk3wkxTvbPkN2jWq4oPvxyh2y5uzJWXd/SUErvvyJm5CUBBkbwxIsGA76+gMvLlhqRJvRt4Qkxi2ZqDDC3FrKGcf/l7a/FC4JZ2zvEmkVmWbG+IRzfTLZ/ZtsEXghBJydgZY6wvBHmDsGCkrfM5M9+kKrvcsj+QOmmv8UbYex0tE8AEvJDNIjSGQXd0Rc7FNEyrtkphpxxAl0PT+CWogcW15bW8D+yLF2drPgsdZPN2UOayBlPJuuBt3KdbGjVlXTKC0HVAntFRXstNGcNWJSWdKYo67JoWEHNeN7km3UQ=
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(346002)(396003)(376002)(136003)(451199015)(46966006)(36840700001)(40470700004)(47076005)(426003)(7636003)(186003)(31696002)(86362001)(36860700001)(356005)(7416002)(2906002)(5660300002)(8676002)(70206006)(8936002)(82310400005)(4326008)(40460700003)(54906003)(70586007)(82740400003)(26005)(336012)(6916009)(316002)(478600001)(966005)(41300700001)(40480700001)(31686004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2022 10:07:15.7711
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c8aacc82-8fff-4722-758f-08dabcba04f9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT075.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB6014
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 02 Nov 2022 03:33:26 +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.223 release.
> There are 64 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 04 Nov 2022 02:20:38 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.223-rc1.gz
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

Linux version:	5.4.223-rc1-g01e7d36eb536
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra20-ventana,
                tegra210-p2371-2180, tegra210-p3450-0000,
                tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
