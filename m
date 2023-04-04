Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF8A36D5CBA
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 12:11:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234408AbjDDKLI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 06:11:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234385AbjDDKLB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 06:11:01 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2087.outbound.protection.outlook.com [40.107.244.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C30B43581;
        Tue,  4 Apr 2023 03:10:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oOsMS2X2eaFPi6mD3RIWOCjpzpLH3QEd7gu0oV5J9rRmqReUgtYC2xmvT/BWUOjt+pdVcyecPkbD1AR3i+IRTEb2oOdkGi1Ir8xpAybmiYQokbUyQjmaOxXqdg/DcEg21uYPRMoFBT577G63dX7ae7t6nREOwam1Hg2Y7zcTBDoWYVhG8Xfih25TWVRjCwbzVOwrH0iu9YSdvjsAV4o4AFNnXttg4RJWJ+5bo8PU79WPMvF5ZUfr9AmgZgDoJ0dnQevzPPrU2io+iLH+1qC1SC38M6ZJ08hMqhx3dfTGtYTtzUBPFnXkZJ5SfB9T3P4TjcFDRXXOf76n7GL8QOoi+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Iq8D/ae+Egex0XJ/INZQlig/gHvrH9Ys3QZP3DcutSs=;
 b=Oi/VJ1pEEM0f5UEjqbRz0dDdZ9BPJB8tdbtKeGLt8SIzMueJFKUgOw2uu3qk6SJolYiAZ+p3H5dwxU6dQHXYBfU6V6zEOZGYaGtREn4/YK2vrPgxTQ9o0A/f7PwsszysmJomxn+4ogOD/34iyxRitM5LBM2ebaTIu5mSac8/SgFv+qixdl/kAVs03J6W7PmMS3xwclGztSCJCPDIxrRux5ObY8SVyGULbMqlIxo3dHrr+g2W9WjS86D/p4VMBc57nk7TAnwfgpVAp2KyTZA//IGQy4joUZJKllwZaR5eaCuVenk0EIhpMBjf6F/y0Pk2VkMa8nbhzagvwEziiwAIRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Iq8D/ae+Egex0XJ/INZQlig/gHvrH9Ys3QZP3DcutSs=;
 b=LRS8mlezvjkxgq29cdhu+AVhWKfHbliDse16IvbHicMmukObHqSu9y5our51UldwnsKCpLItqEh/oeneySTHfR8gHbvKy1/a+p1sPitSQTk0qAWzg3tu+5E0naZ2cDyPvQBx7K1+dWOgnn5l6rHFkodfYoU7gim6WkzZXX66/eI0TjXp93I1GrcG1bkM9ain7eUKQ+mdN1dzFGhO8roXDB0mTAuyaKrhktewxpkdSXOBcIy8eI7VKQpq3OHflr0NlYwlq/wqt0uCUrb0PTvsEcZ9WDDLaXKeZFhkyjfquCNZptwlvNXhAO03FVmeCM5z1cdTBQRAyX4ybreHAr4gUA==
Received: from MW4PR04CA0236.namprd04.prod.outlook.com (2603:10b6:303:87::31)
 by IA1PR12MB6650.namprd12.prod.outlook.com (2603:10b6:208:3a1::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.34; Tue, 4 Apr
 2023 10:10:54 +0000
Received: from CO1NAM11FT009.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:87:cafe::74) by MW4PR04CA0236.outlook.office365.com
 (2603:10b6:303:87::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.35 via Frontend
 Transport; Tue, 4 Apr 2023 10:10:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1NAM11FT009.mail.protection.outlook.com (10.13.175.61) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6277.26 via Frontend Transport; Tue, 4 Apr 2023 10:10:53 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Tue, 4 Apr 2023
 03:10:39 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Tue, 4 Apr 2023
 03:10:39 -0700
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Tue, 4 Apr 2023 03:10:39 -0700
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
Subject: Re: [PATCH 5.4 000/104] 5.4.240-rc1 review
In-Reply-To: <20230403140403.549815164@linuxfoundation.org>
References: <20230403140403.549815164@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <7591fa7c-4385-424f-b57b-c859d6f25236@rnnvmail205.nvidia.com>
Date:   Tue, 4 Apr 2023 03:10:39 -0700
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT009:EE_|IA1PR12MB6650:EE_
X-MS-Office365-Filtering-Correlation-Id: e255b5bd-7d9f-41d9-710e-08db34f4e022
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hfQ+b8KIu0n0aa7qYjQSC3hKn7LNf3zKoKETuhG2A+aKxmkLjIdxj0TOO6dlZKfTg4vE5bEtpzl6qa1tZD6W6BxxtF8kL4DAgD1+3Rh5Fc0VsuwnPEqUbu+Cu0tMjiJVIdSY0sr8iPkmtvQvHADhWx4BzIaky8RzOpGTAdp2/l6dD6nGwB1qPiZ+CeFKpoUIwMQJO8ZCGoXZFlDxaDjPMWh+JExttvJ2i2futdIQ2LLXGZ4l39V0qhcAuAgb1FoMIJsLqKdzc5ugaC545t45OajbHwPsCMdd+M2p93x1Q23fu05Rk41fEXTZQPdafd5ltaXYzagIjdh3iF1U81wFJtdcGd+L9+CiKderdKeQJOzsBYJLKrprFdtNKciyt2c2Th5CMv0O/Y3wBJRCcvO7m3D+pUNTc7HBPLv9vJguMl32Zvv3yVEKTkUZIb282nutl+ZTQc/7UTFSWmZ+qotWE8IEtaLie9ZSMYEMSksc8+J2nPV+91Xej4czfR5xuOi8ZpZqixfADdHylF7fVUlJ53COaTZm9tbnTFA+z4d8dlY7ZvrmIzM6uqeg8zALnbPccREhtpOQ99bnAABWjOT7LNf03LNEpDGmCz+WRmWFDQvWcbeF7sPh5BcuxHUyWBfvXAkekl4fPNMCn3kHSEwqWE3DBQjfn4sKOfWW/1+XlHkSCIa8P2OCzKlXz6cCfHoxgr12KEm7odXn6548SuNs5oXAfI5/kr1dysUBNQunKQjEVcQplSucoMF6fsZQ+5Tjm+x7pK4rk3rs8lwKOWomTnpnfG8ZvQeoxz3TUWUo4Dc=
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(136003)(396003)(346002)(451199021)(46966006)(40470700004)(36840700001)(26005)(40460700003)(31696002)(86362001)(478600001)(36860700001)(40480700001)(82310400005)(186003)(966005)(8676002)(70586007)(70206006)(2906002)(426003)(7636003)(356005)(336012)(6916009)(47076005)(7416002)(5660300002)(31686004)(82740400003)(4326008)(8936002)(316002)(54906003)(41300700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2023 10:10:53.8512
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e255b5bd-7d9f-41d9-710e-08db34f4e022
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT009.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6650
X-Spam-Status: No, score=0.8 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 03 Apr 2023 16:07:52 +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.240 release.
> There are 104 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 05 Apr 2023 14:03:18 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.240-rc1.gz
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

Linux version:	5.4.240-rc1-g73330daa3393
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra20-ventana,
                tegra210-p2371-2180, tegra210-p3450-0000,
                tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
