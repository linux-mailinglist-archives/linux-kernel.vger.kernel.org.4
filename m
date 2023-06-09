Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E972172A004
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 18:20:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232077AbjFIQUB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 12:20:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242227AbjFIQTy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 12:19:54 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2078.outbound.protection.outlook.com [40.107.244.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 267E03C1F;
        Fri,  9 Jun 2023 09:19:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YAilIk/LBATFQm1eCDkVvFBvlTmhzwKljJxYswUh0XociQmv/4tTqCfEGU1N7m7oV/NrxGQsElyei4ka4hvzW5mVi/A089/sG3d/8TYBGnLX66fLs3cvbFZR9MNqK87rTtCbfyk6WaN8YDfx2ob0g6VxDXBKBlSPgnNIWVVP+5W74RJuqt5xNZvmwXLvz27ImAIfT2+zpEan+asWYdgJMhCNq2ubHDzLvT3pdqjALFfe1yCL1DRlhHet+uEX6uB2EbRNtFb0IbqbNG1Dr9fin5Anyb63mtkTSzMIQmbuzTEBslZ1IUyjnZqghHGdVPkurr/TnbCakCSq1pczRNusAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vak9PgPQtIsa8k5RfsgPPWNsY1qsQkVvD9Nh8BOjdNs=;
 b=lEyhO8ZsNON4FbSdlfPI4AM/bBIYis0qQtY2ghKJQddIgKItl48319lu30fCdTpzEYOPGXlxMBYWE+kBIRnzinn8OohMlOzvSttmfOLY7VjOUp9C+6pMiza4EO+w2XRmPzR9SS6lg+FLN+i0oiYyEs++K/LZBpZkxefJgVgJ5sRrLGPJKgu8C0DOp0YUC7o7NeZ+a+s7HaPkXPcy35IxvLLPpJY2ZMFc/VBfKNagG9nrsoODbUi95DOIlBPXmiFi2ofhBGclglOMaroQyVEE4DcJx63zNGwNQhN4E1+hFy4gs+1Nnc7kgdLrTpufW/vGIQ/uWWTOaYjLM8n/MUyixw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vak9PgPQtIsa8k5RfsgPPWNsY1qsQkVvD9Nh8BOjdNs=;
 b=TTzvbnEVpp3LCJDlg/drLQ1ZFWW2uF7uxhi6iWTTzuEoGhITk+6EuBJtOH+QE+vVwqZYIMB859QplhstKHO0ui5n+3Rj20Mcvp8rMZz/23yxxHXCJPPLEkhK8dHM/EP6Psy/9S/FqMrC5CmPFZH2ZXuRsVW0pobtP8EdjRBVSKBhafOxmBSQVZmYNCI7y0tagy+Ct3yAQtZuKyiLbF9bwG4BQy6SWsLmPIxH2UbaWwYSZaQFhvKUTt80ng1Ssoozfwm9qfolXY39EUugH08fTulAI0CrsN3SGCSP3978j4po9UvhV0nPELcX3Ij1t6jB3So0XjUVzROrzJZvawXUfQ==
Received: from CY5PR17CA0038.namprd17.prod.outlook.com (2603:10b6:930:12::14)
 by CH3PR12MB9220.namprd12.prod.outlook.com (2603:10b6:610:198::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Fri, 9 Jun
 2023 16:19:09 +0000
Received: from CY4PEPF0000E9D5.namprd05.prod.outlook.com
 (2603:10b6:930:12:cafe::b0) by CY5PR17CA0038.outlook.office365.com
 (2603:10b6:930:12::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.26 via Frontend
 Transport; Fri, 9 Jun 2023 16:19:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000E9D5.mail.protection.outlook.com (10.167.241.76) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6477.13 via Frontend Transport; Fri, 9 Jun 2023 16:19:08 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Fri, 9 Jun 2023
 09:18:57 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Fri, 9 Jun 2023
 09:18:56 -0700
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Fri, 9 Jun 2023 09:18:56 -0700
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
Subject: Re: [PATCH 6.1 000/224] 6.1.33-rc2 review
In-Reply-To: <20230608175726.909746266@linuxfoundation.org>
References: <20230608175726.909746266@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <8c8b702e-d9c4-4ad7-a599-79cd5c63323e@rnnvmail204.nvidia.com>
Date:   Fri, 9 Jun 2023 09:18:56 -0700
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D5:EE_|CH3PR12MB9220:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f8cd791-4c28-4542-bedf-08db69054111
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R8WbBq7YT/m3KJ+yynaJQbGVPO+jlAYUftv3X6LLn5aMEBCFVRdnmaFE+ywl0GSRnxwf7K9rTzmfjoVRs4xfFMxmN9Kp5uz5lWziu71ScaBOMar+63Kf1FA6fpjuY1u9w0tec1oB4YxmAxhyCeeaKt3f4O7kvOiPklVmB+Qlh6smuwYJFn5hQ3Dc2rmT1OEUa3/lUF3QcfvgAS8Z251c1+op2U6Af026jCKUEQWh9eIycM00cY89YhAEfWbfrtIeTdBjBNpAHTZXucqoOeGbNQlaHuOb7u5xDSC3yNzhFA7PRO5oBduymg5aASYmoDSiMLvlrazfbm1+8xDbHzA4iHafJ3YvR2pE7DNroHTMKVwk+QKR4rVfPfuhZ9Z5jF/MH/qz43XXSZfNh8ApBmvafrVkX7Ov033MJu4BIiUb64m2xfDuQqiQR6ArW8l5n+d7eOxQnc/GZ6XzJB/JkUVuKG/MS4SFaca6NHPga1eC/xJ09x0vKjxIovpaIMfMrnMeqoQJYXPklZSaaE678o3coquiLKO28ReyityMv4dQYiCQbjmup/05WzraBjkU2cNoxstVVlSWw3E68qpNpYcBaneo+3YnL+6YNhdWA6JIIVNKiGJ9TJvp4sQWUPcKuUF3syT8sZ9CSCP1JwbHh5V4VW9JK1NN6blkiF39Mj6pnTuopKpB0o1hiEGVpev5t/anF4VePimt5Z6sY7vIcHwkR/DGpqHs3BSVm3WXI0+zWeir+bjN2xWvs11laFNVPZub53i5X6EMy/YfMDkdwVp7wTpve03334D7Ehj4D5NrUAk=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(136003)(346002)(396003)(451199021)(40470700004)(46966006)(36840700001)(47076005)(6916009)(7636003)(26005)(356005)(316002)(31686004)(40480700001)(4326008)(70206006)(70586007)(966005)(186003)(426003)(36860700001)(336012)(31696002)(82310400005)(478600001)(54906003)(2906002)(40460700003)(82740400003)(8936002)(86362001)(5660300002)(8676002)(41300700001)(7416002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2023 16:19:08.9398
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f8cd791-4c28-4542-bedf-08db69054111
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9220
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

On Thu, 08 Jun 2023 20:00:45 +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.33 release.
> There are 224 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 10 Jun 2023 17:56:43 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.33-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

All tests passing for Tegra ...

Test results for stable-v6.1:
    11 builds:	11 pass, 0 fail
    28 boots:	28 pass, 0 fail
    130 tests:	130 pass, 0 fail

Linux version:	6.1.33-rc2-g621717027bee
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
