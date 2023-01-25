Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 110A967AFB7
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 11:31:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235278AbjAYKbd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 05:31:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235352AbjAYKbb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 05:31:31 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2078.outbound.protection.outlook.com [40.107.243.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 590154C32;
        Wed, 25 Jan 2023 02:31:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ItwL4gulOi/KmKUOQyUXV7zO0JuUvVdg/oKymDy/bMpV+Wxp4S9sYhNZymFa31ClnrOfSA//bGK90D7EgyRuHLAayHwLAplbljHqywcTtHqMnNp1byhPKW3PuwNFhpOuucOwrJ1WHEWjjFvvCdmq+1VgwaPzsaKhjMVDOY/BVNeWsdrDOf7kNrx6lTC+p3vi41EiyNS7z503WPsTznrkq/IJJoA7nd4J53AbYh1gyGQs6XWvOxVHuGoqIHZUUN07ziunLF7pXJ6HHacVVlpBJxOSsQSFfosTyCsgt0Oj/Q3PS0BL4sz8XdvCAn+fji8RXkFv5C6fuZfAYndabEvRrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BdI8UneWLMempZWNnB9keGVdncmnWpX84j353pzcUqw=;
 b=RTq5FwnZpny0S6w55O2GkOATecQ28fmphwaM+xgtdD0WYK6k2MeNpAtV70SMwoutD5y/AF2JV0DhyyRSvh1fBxDFGCx6a4xRrC0bSFvBcFvBQGksWOwuaWKwMMXy45eOa4ev+noowcsu/RGs5RWLmLIUrISCdwsHT3u+FOaCOrWdpX9L3x7LGVtB8FNMt0rUwAvGDsgGGYe31bibwSKQLANpRHskZ+K7Z6gUMGQcQPBRGUqmcbq0kaBPmtlBpetLsW7aqWTe4cNLPeuYZkVucMR7RoroLxp1DjnYrLPkiQMRCF3R6YyVp5QzTMCLwn+hq2SQcqCUX/A04qTPUZ0t3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BdI8UneWLMempZWNnB9keGVdncmnWpX84j353pzcUqw=;
 b=N2Xe5Fd3eley1tuRvxbTPbH1wCFLrRhHDTuXinLq8xqB2wCJbZH90hGO70kUFUijxNFEHVKgW2bJuKmvczqKomHdcIcVTLxciqRmBctVBpRCu+VK784ypRC14m0QYFS1GDnA7OA4cjGqbkRbwa4ponDJktcntHAzK9wWglsuK+kj0crdNfzcMVx9LwutDPbQkrpXnTpvqog0GKqT4mqF9tAdhB+6XypssG2oDtgoA1ULbjKM4lm/OlxMxvsyXASCB7fARr6HlIKoZ5tPlCyvkuZtMgE0H/L+gQozWA1G8cNRxmbs9jg4RVnUm52dfDbeTZUsjbadJWcn8GSPIOn1aQ==
Received: from DM6PR14CA0065.namprd14.prod.outlook.com (2603:10b6:5:18f::42)
 by SN7PR12MB8602.namprd12.prod.outlook.com (2603:10b6:806:26d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33; Wed, 25 Jan
 2023 10:31:28 +0000
Received: from DM6NAM11FT039.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:18f:cafe::89) by DM6PR14CA0065.outlook.office365.com
 (2603:10b6:5:18f::42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33 via Frontend
 Transport; Wed, 25 Jan 2023 10:31:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DM6NAM11FT039.mail.protection.outlook.com (10.13.172.83) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6023.16 via Frontend Transport; Wed, 25 Jan 2023 10:31:28 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Wed, 25 Jan
 2023 02:31:20 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Wed, 25 Jan
 2023 02:31:20 -0800
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36 via Frontend
 Transport; Wed, 25 Jan 2023 02:31:19 -0800
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
Subject: Re: [PATCH 5.4 00/51] 5.4.230-rc2 review
In-Reply-To: <20230123094907.292995722@linuxfoundation.org>
References: <20230123094907.292995722@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <a0f60afd-fd4a-4dcb-ad1b-9976c756a302@rnnvmail203.nvidia.com>
Date:   Wed, 25 Jan 2023 02:31:19 -0800
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT039:EE_|SN7PR12MB8602:EE_
X-MS-Office365-Filtering-Correlation-Id: b5732dae-0cb1-401f-cd56-08dafebf5166
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CB3onB0JcE7FaWE2rQ2cDahjfOpMHGe3rKs2RlgMzOJuAWFmIibwZmUzboN0GVLrZlKemSOGA4eWa+jie+OEeputGD2a3G2aVWpE4RlOmoTpFM6TxYRd5FpZUHvFTtfpRsn6psqXGukYYVRu391lY9C4fMn6/6KjL3TfNMUFLNxNrQ1BLRqkEu0zCOPulw5Sm+GMDKf67fw6uqyvqu5VQvo2Xwrtsb+DrQzyZPyCPlQPu8+QTfGRgUe4XeCkNjKfPIlwTncUwUcE2ED7A473gV7oJu5gkxstf3OmKHRAhATJZjwVg2E0gedEBmNHY3tURpgp0rlYrUlvhOX6VPeMecd8wbFjeU4/5/y6jBG0XIn4LqkyXi0vnCgwP2o2roL058YFlFfFq/OzZsIqdzvORA+NSjSuzWef0iW5XrtH2aMXotvwiDJWFnl5G+jsD94SqlgE3ZC4JumR9ZKQu+xJKYzJsLIeaxq9JxewoVM3/7vuUWYpX+W8Y2FGV98RYaF6hxGMo+MjNh3XA0XUoo76uh+Gn5dq/fHNq4Qo3Wyx128DlW/2xndxeM4FKNPNpEJBDedRyN/m9DCU8/JL1QpMR2UJDdqdpW/sFpkDd9KymZbXe4sx2MzMWmhp2D7MKn2WCcGQ2l+FL5zqee7vhGKbEvb2Q2j508gGyuFM2nyMzAR5lp02drr7Nv9abxISxHISGJpgeAX/yszr7YW/2Q/P6i+ws1GCRddHMQNsNHmQ3Emve3yU0vIiNRsrZBVDAnZv8x5Fc2+yW/o4aRbdleLF/JjLdnf1gjHujMR+wAg4dGQ=
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(376002)(39860400002)(136003)(346002)(396003)(451199018)(40470700004)(46966006)(36840700001)(36860700001)(426003)(336012)(54906003)(47076005)(6916009)(478600001)(8676002)(186003)(31686004)(31696002)(70206006)(70586007)(966005)(356005)(2906002)(86362001)(82740400003)(7416002)(41300700001)(7636003)(26005)(5660300002)(316002)(40480700001)(40460700003)(4326008)(82310400005)(8936002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2023 10:31:28.2684
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b5732dae-0cb1-401f-cd56-08dafebf5166
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT039.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8602
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Jan 2023 10:52:43 +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.230 release.
> There are 51 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 25 Jan 2023 09:48:53 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.230-rc2.gz
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

Linux version:	5.4.230-rc2-gc4ab8d7671d5
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra20-ventana,
                tegra210-p2371-2180, tegra210-p3450-0000,
                tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
