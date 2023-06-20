Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FE3D736912
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 12:21:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232004AbjFTKVo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 06:21:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231918AbjFTKVd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 06:21:33 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2085.outbound.protection.outlook.com [40.107.101.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2981EDB;
        Tue, 20 Jun 2023 03:21:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mqk2/wlVeO/yQxHj7xLz18Pi2C6lkBScoB75zkjKeDYAaH+LZxxHHCEiBX5L/W5pCJUixz74P+9DqMWEqG/AVkNPzqDE3IKGb8oBnE8f8Mq3BL09drLy2gMzmM1lvB0dVhuZnStZOeEflb9g3wkVCJviyyX92yTWdakdrcKNLpRXT2+22dxw1oakh1k1v2VOGdT0dAxtziYKfSFzGbjiDVuKZfSm3OkJfHrANBbC9ySjtDM30p3w90i0CcK3mn6b3BTtMk2PUhq2qpJ4N4vfUzf3uQ11V55ju/+NA3J+kO5bjvUB+1R6N33OtuHzxfdrrv/LGFJ3lKqEIAhUKupSxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CiwXklQ2pwQ6PuZaUq1ILpXqpohyR9aFG0GPbAWaVAw=;
 b=Isfr0bWYOD4mjx39n5jIiCeJ+CMOV8N8JccoAXpPaShxCnR/yIIuvzQsZ2a+TzC+rNSwJ/1WDTL4NF59TV6iFIZLHk1/YWUGohUD0wjgUoitTwLLEvupbFVa5BU4os6NNYz6f5b/d1C72JC8L5mVc/+s62fMd/FN/VClUCQF4rvBsO7MkzaIX2MIc3KCCD8ziUKtcwZlsIr26E6N4qiSC326cEfftjXwVrpxIGN+cfQ4m7vHl9Pn0MqbE8RcdQItKjC7yIZaRzPkEJ5nEZdI3IELSwrfX10yHWER6fSVpYlTNID1FSrFrUVjM77bGy7jPGhOeCbo9fkhSGbATvOxGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CiwXklQ2pwQ6PuZaUq1ILpXqpohyR9aFG0GPbAWaVAw=;
 b=dP7/Q4BksRT/tKmRHhRUQnBSVdKIAhoqpUFAhNf6xUNcFOlutMPf/zq+Kq/LPGlMY+d/UWq0sp/Hwnux1HXCbtKIN2r9Xp5zpBk+Y/punEcRpbanc82xzJUgsVavUl87e8CXVz+ZtHyPefmghDI1eeVCN17959bvKDlh2EVcmXFnGcQPGWo4287bjFRtFT3v+N97jpgNhkFWWM/8StPlyXb5qbQjDt4QEVMnhTMmgb3UBbMXlD+aMcvlMwqenRP1CeKLKriaJMh8Cs8gA3svsV+dSikSSNlbRJK1cg/sJJnFaicos+YnSaZagbEiMkpv3zsw2gGyZDMCQ7nnw+vfww==
Received: from DM6PR07CA0079.namprd07.prod.outlook.com (2603:10b6:5:337::12)
 by DS7PR12MB8252.namprd12.prod.outlook.com (2603:10b6:8:ee::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6500.37; Tue, 20 Jun 2023 10:21:29 +0000
Received: from SA2PEPF000015C9.namprd03.prod.outlook.com
 (2603:10b6:5:337:cafe::c0) by DM6PR07CA0079.outlook.office365.com
 (2603:10b6:5:337::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.21 via Frontend
 Transport; Tue, 20 Jun 2023 10:21:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SA2PEPF000015C9.mail.protection.outlook.com (10.167.241.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6521.19 via Frontend Transport; Tue, 20 Jun 2023 10:21:29 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Tue, 20 Jun 2023
 03:21:16 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Tue, 20 Jun 2023 03:21:15 -0700
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Tue, 20 Jun 2023 03:21:15 -0700
From:   Jon Hunter <jonathanh@nvidia.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <patches@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        <torvalds@linux-foundation.org>, <akpm@linux-foundation.org>,
        <linux@roeck-us.net>, <shuah@kernel.org>, <patches@kernelci.org>,
        <lkft-triage@lists.linaro.org>, <pavel@denx.de>,
        <jonathanh@nvidia.com>, <f.fainelli@gmail.com>,
        <sudipm.mukherjee@gmail.com>, <srw@sladewatkins.net>,
        <rwarsow@gmx.de>, <linux-tegra@vger.kernel.org>,
        <stable@vger.kernel.org>
Subject: Re: [PATCH 4.19 00/49] 4.19.287-rc1 review
In-Reply-To: <20230619102129.856988902@linuxfoundation.org>
References: <20230619102129.856988902@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <c5138c0b-98eb-4f6d-8e7c-bbfacf0868d7@drhqmail201.nvidia.com>
Date:   Tue, 20 Jun 2023 03:21:15 -0700
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C9:EE_|DS7PR12MB8252:EE_
X-MS-Office365-Filtering-Correlation-Id: 46fe7eef-5648-4af1-223b-08db71781cda
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8S/MTll8GoJayrZJXdZFgCvspn55tPKNwSetHF/cnVuJvffRAmIgdw9Q27UjPvY9jW0BvnNItN0bDl3ofm29kQcdxfy7uap0KgZWHeoVjcpBmaPJqL210sUpDm53I4vYJGlIO1xd92F5bFtaRSVMXqc1HabDTlhn3woQ63S8eji+sfTBtioSWbGaJDCcwUZNDY0pb8Rua4308aaESet3X8iUDFntj7PDwwL5JKWa7C40GayxIrY6m+GHQEr986jPG3JCop8zrMqE8At4d/sIya0JI77SJRUP3bgO/+wB2jaiZ1WgiwQjEdRn9R9Mqok9Mxu26/xsPP8ao2aiT+bHvyIC6WWsfwAjBLHQrQLvVSlIpDgX+ue2gkJKPmK4lmmZrI+8KyQocdPgUmEndy15q4BptqaO2aM4+2IZ2XidKg4m4OWqsekT6YMmp/TPVsBbBX3aTJ0LIvC5BFDit9WRSxINeHxbtsrR3F4aea9I9K+NZvPHjyxi1xZQEGyauda3jLUa+3yQN036q+ncvUnhtP/Wu5x5fIEKTOp72toR2rSa+jZZlFWi9ep4pUe4W1O/fzobMgKYUa71+/5nEXVqv1RfKMnrkA6CW40UJMVGbgyPG3ePbNlN17D3p5IIQrWmnePuUDyEyBUeELr74pS209nFbFlM8LpGT2EaagVRNt1gn4wLDmsci/rKkFUPvqjfrIpJ6Dvr9sb0EsI0WNiDWLBCTLZrzjEyQgfD2lmEmxpuJCUaKULx4XeMXdbDIsdWyDdAWKknXuQ3+rWUA2tbeFO3K4s4aq6ebXpozPdinFY=
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(376002)(39860400002)(136003)(451199021)(36840700001)(40470700004)(46966006)(7416002)(356005)(336012)(426003)(86362001)(31696002)(2906002)(47076005)(7636003)(36860700001)(31686004)(5660300002)(82740400003)(4326008)(40460700003)(54906003)(82310400005)(70586007)(186003)(70206006)(8676002)(8936002)(966005)(478600001)(41300700001)(6916009)(40480700001)(26005)(316002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2023 10:21:29.5879
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 46fe7eef-5648-4af1-223b-08db71781cda
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015C9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8252
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Jun 2023 12:29:38 +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.287 release.
> There are 49 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 21 Jun 2023 10:21:12 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.287-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.19.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

All tests passing for Tegra ...

Test results for stable-v4.19:
    10 builds:	10 pass, 0 fail
    22 boots:	22 pass, 0 fail
    40 tests:	40 pass, 0 fail

Linux version:	4.19.287-rc1-g3e62ea320ab2
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra20-ventana,
                tegra210-p2371-2180, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
