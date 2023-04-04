Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8339E6D5CB6
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 12:10:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234380AbjDDKKz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 06:10:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234351AbjDDKKv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 06:10:51 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2065.outbound.protection.outlook.com [40.107.223.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DD5310C7;
        Tue,  4 Apr 2023 03:10:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AWfAk3s3gxNYjcHw8skYy4M+x1ay9E1cpGSw7s6lnV74/22P1XK1wGZ1q+DslJyJzdvCkk57j8qbmzh6zxjuLnq7Oc6lnWDaODFcbZTINUdm3lU4iz0JMctjVL+vFNFQOmf/pUoGDzpPuIWpzeGhpy2c0C7JT72xsLrzic7jr2nGMlE0r7QSA2Vh1arwa/gbcIscmseGhsFG6Hz/pAkq4gm/EXuOuQgdaUPZuTUumfy0hvl+HjVMo7qSzttbSiirssWHVpRGZxE5nn4vbPXQDUqMmKbW1wqx4tcEcWvRMbuoeSxwXDonagyGNawwv3U90svVjQQ3Td3brxnfO90+7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6VLKlnHuDUlQavj00Er5kvYpj+BDkGEUHBj2AgdmhiY=;
 b=McYl6tkCxJVIoCKB7MSD7c6yhGJKCSO/dHhmGbMD6ACjKr/Ne69YKF2gGLzKH08OeWpJ5cGuQFA2bIYmstwKNUCtm0kqczwLesevdEBeqjRtfnLFUTlRmCwc3rIY7nPaNQvdC0KE4+urSG7C38+YdWjZFW68l8uGikZ2Z4NzjiG80DvXZQFTB8hDNqPMnDXNImn6U3wq5Qb3/BpSYIgh9IcpOpKVSCoJYgXzQehAzBZxWL2OakUbH3HT9Fu6ykKlkrJonE1PQ0P7NQavPwR3NsrMGXQ55qIqZMi6bCda9qzdGZ+IjAwcQeT6CsX0lJDh4tpzLwipxeH1gjN5khTx7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6VLKlnHuDUlQavj00Er5kvYpj+BDkGEUHBj2AgdmhiY=;
 b=cgKiQwo0usC3bJf6bblPGT5/d4YThCVSFcFmHkpS5NtBR6+PrUhEnnGzKB8VzY0nHvZesBPg+vHx1O3/hPO2xoXpmguXIcFO4Q9pbDr4fFH4vuBdBiTsDXgEfABjp7VnYatUK5M8JmWBq/YHU0eT9EZNm2+JtZ5E00fxx+7D0TbPiYVerNSsKNJUrGjVuTRXPOoy5oLraa3NEBpckMvmDYB69r/ZBtYdGpBLJ0OACwWfIBsBIcbv/l6/tiRv1eafc6eEYduPQkm2O0ajJXSaFic0NNH8NksEIV2PORBG9TaMDe1GkQPMqAT8gdNL51PMUD/XK/my1P597Vl0TkkTVw==
Received: from CY5PR15CA0030.namprd15.prod.outlook.com (2603:10b6:930:14::28)
 by MW3PR12MB4460.namprd12.prod.outlook.com (2603:10b6:303:2f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.35; Tue, 4 Apr
 2023 10:10:48 +0000
Received: from CY4PEPF0000C97D.namprd02.prod.outlook.com
 (2603:10b6:930:14:cafe::51) by CY5PR15CA0030.outlook.office365.com
 (2603:10b6:930:14::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.22 via Frontend
 Transport; Tue, 4 Apr 2023 10:10:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CY4PEPF0000C97D.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.30 via Frontend Transport; Tue, 4 Apr 2023 10:10:48 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Tue, 4 Apr 2023
 03:10:37 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Tue, 4 Apr 2023 03:10:37 -0700
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Tue, 4 Apr 2023 03:10:37 -0700
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
Subject: Re: [PATCH 5.10 000/173] 5.10.177-rc1 review
In-Reply-To: <20230403140414.174516815@linuxfoundation.org>
References: <20230403140414.174516815@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <2ec1b951-8b21-4897-9724-9a82dd24a0c5@drhqmail201.nvidia.com>
Date:   Tue, 4 Apr 2023 03:10:37 -0700
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000C97D:EE_|MW3PR12MB4460:EE_
X-MS-Office365-Filtering-Correlation-Id: b71bcd16-5b1a-400d-d4dc-08db34f4dcdd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: arBV02q+RfSIln7pe5bGLAoGr0ZsDLNxFIGDfkEn5iT/39CY1ENJHANd6QvtUkkqFGBdPgGVLuXqwuwLbgKxWu5DWxE0GGyr8VwS52K6w0XTXaXhN+mvKv2m5YCo04m/u0z87OBwbhovj5ykCAiWyXbVLfl9p0iRNhnW6mbGkuD3pl112kr0YE6Ib90lTrXv18J6YnW0jVIu7rm8IAXqzjFHHNZuDy84t33JH7n7uPRDh2wBsHYSZZRqy+atp6/nbgzd3V3zKR10HzeYn3mVjlAC7OM5JGp373C40+u6ADVhFnifpWBuQEDdUoB34ihzynnvq8LYrV4b1g7Iex1WFCP0JSBk0bdefZO2BFpw0okP1cIziuF0UtdyOpheXtWSW4I4B2jZMstcyHUmO/1zSMrw5iIHvLVPewUrfS7VNEufhwPkJnfxWElP/gVGb3RoCDJTs3LvDMzFBJnAkVfZuRYTqpSYIriWAjq6B7KXiKm+IvQ4CU7/swf/sEn8hl4qpWZXMCYcQy3vU/2j8K/suPcQyv7hU8T4IC8M1ilGi0gHQDJZbBqm70DBzMk2eJjTXNm1IYExlkYITOdvixvN2Q23RWMo+ZMwwg6h5BMNb3PpWi9bTbQYiJnrwrOVsFQm069DPXOOX7MZp9q7+YTZzGN318gC4guTt/9ny+8Af9uwLvAPhlHzSXBVK4QqHGmBYduP1MBiR2Z5C4j7mTOnevWYgYor70FX0vcgZ7bN/1gynnkKHm+yEbQUWNo0Gw9+ZXjIUltdD2XfxvfrpkH3gitWhwqkcUVfrMPYYWDU4q8=
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(136003)(396003)(346002)(451199021)(40470700004)(46966006)(36840700001)(82740400003)(356005)(7636003)(36860700001)(40480700001)(31696002)(86362001)(40460700003)(82310400005)(2906002)(966005)(26005)(70206006)(70586007)(8676002)(4326008)(6916009)(41300700001)(54906003)(478600001)(7416002)(5660300002)(31686004)(8936002)(316002)(47076005)(186003)(426003)(336012);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2023 10:10:48.3997
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b71bcd16-5b1a-400d-d4dc-08db34f4dcdd
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000C97D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4460
X-Spam-Status: No, score=0.8 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 03 Apr 2023 16:06:55 +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.177 release.
> There are 173 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 05 Apr 2023 14:03:18 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.177-rc1.gz
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

Linux version:	5.10.177-rc1-g7d617ad89b61
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
