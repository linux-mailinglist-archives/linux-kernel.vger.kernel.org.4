Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BCE06D5CB5
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 12:10:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234373AbjDDKKw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 06:10:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234287AbjDDKKu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 06:10:50 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on20606.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eaa::606])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EE2CE79;
        Tue,  4 Apr 2023 03:10:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UQj9cJieFpDPvcL1HqWD5AQ2VMrDi68Q5pIbNXg7lYI5xp9mdkx8Rrq+FUYAwgCqq0yhxnGX/lOEsIfe1AQokdh6cpEIFIblqDD3bV6eqFmr1CSLikzl+QR8RPc7KXGKQASKxaiyvDF8e3+fVEW4wZlt2X+UIgAL8tAe81rWZzNfPhZlfr7elqoLxPf/5hc0SsUEBOnqcfSgru60HfVYQIaAEBnOZbBUFbiDe7mSXMcs19FQ31IqgoCcMql6rvpa3HVg6sGG9vtKij59Chnt2XroDAQJCUIp/CNM+A/GL29fTmvv7bdmzs2DQsDdF8G/ibNO0e4T22Ek5BIc2tXrHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c4/4uyTTIhHHn+Q+mLotoWyhc6rMYut6AZzhqzuQ0TE=;
 b=dfZY71Gw7cgbDrn7/OER43WtOvyszGsNG3LpgaaZg7Vz1RoyII8csBlgfTiL37A/nt1/AB0WLTwpKAI4T+5uCeT7qWHHnVFcBP6Ua+7lh4MJuoYeOTonGddPtECSietIcYg+IYT0MYD9OUbg4aRbHXZFJtQmH3O0SKQueGje/v6fI7/B7ylkOB6ItTcPW3HgT21W951kprN+lho5Sx9atdRJi/WC7VJCgAq+TfwWZh5jDqwmaxq6faXbUDdRpjGhbbG3Vrr/emPZxuPRsICYOqLstmUcc9R5JsiN9nmkphWdgFiVtlWEppTzAlJoXfAdi/6fQso5HhVmlTE/FPCNfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c4/4uyTTIhHHn+Q+mLotoWyhc6rMYut6AZzhqzuQ0TE=;
 b=cO2yfWPwxZ4S3jTazhwOoSSnV+sYEHEknHhuyOPt6RddGFIz/qDn0gUtnoXhvMhVTpiiccjg1h5oDnyYrDSXrLbq8l19dlRnq42pvtjjyawY7ciNfXDvVY8mGNwjI2Ym38TwGhmtXn3MfcGC7CfhMmP8tvsrT8/Mu0wbP1B0EpwKnni1mgARbusJPciuehzxu5ABxg/SAqdS0vtQ+qDCJ32KUjG0IWIdZNoXT2yRyua9AwDgVZu6S3L9WRcRoHrBB820BJL2Ow4iPytYnewEQXhRr36FK0wiG047/t03eFLRQVdfYNWKhsSQ2amd485S0sSwy+x0Z7JiKLXdqBSAXw==
Received: from DM6PR12CA0035.namprd12.prod.outlook.com (2603:10b6:5:1c0::48)
 by BY5PR12MB4920.namprd12.prod.outlook.com (2603:10b6:a03:1d3::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.28; Tue, 4 Apr
 2023 10:10:45 +0000
Received: from DM6NAM11FT088.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1c0:cafe::73) by DM6PR12CA0035.outlook.office365.com
 (2603:10b6:5:1c0::48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.22 via Frontend
 Transport; Tue, 4 Apr 2023 10:10:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DM6NAM11FT088.mail.protection.outlook.com (10.13.172.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6277.28 via Frontend Transport; Tue, 4 Apr 2023 10:10:45 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Tue, 4 Apr 2023
 03:10:38 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Tue, 4 Apr 2023 03:10:38 -0700
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Tue, 4 Apr 2023 03:10:38 -0700
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
Subject: Re: [PATCH 4.19 00/84] 4.19.280-rc1 review
In-Reply-To: <20230403140353.406927418@linuxfoundation.org>
References: <20230403140353.406927418@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <7f4f1e9a-ab93-4c01-8ce3-7e4f19397aac@drhqmail201.nvidia.com>
Date:   Tue, 4 Apr 2023 03:10:38 -0700
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT088:EE_|BY5PR12MB4920:EE_
X-MS-Office365-Filtering-Correlation-Id: 8584a20a-906c-412d-99b8-08db34f4db05
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3D3dwApu3MPobY+FUU1smOvwqMRy/WsYKA3UwitunZKNCtns3Avc1nEt3U98epPg4P3ifWYXCqUZyrALj4/kYGz7adh19Eax7H7+1IA9FZmd4jtlJgz7QKBVDUH2rngluKd3nberEI1x3SpX3WJlIHXwdMtOU2KNey1nC9hcOOVQOkVfANcmWAfeC9OJgwj+u8lvwMJUrsTc1+an8JD3WtDnUB1Fqe76GD3TImbhilC3otr69axQiqy4NqhLjD3J+rMYaaGI6edn1P5krKDSYwzfuwnHyhAm38NIV2rFDR2/OmvKEtphTbusFJe7ND8+eXq4I0W9DvKaxQwW47SCXcfPIUGaOGmzn3itejNOZDG/elh48BuGVtfUzPWMeBOHCDM/7b2zV2eR6g/ODpI/W3k3GJkFuAaKzeUnKOMBHqtIjEUzYcdoFlGVbIdR0eq7xcs3ku5KV5CnTmgYdOwicwSOG8uAh+eHQmgoOzCHwaYbAeESKDMBwyi8g4+Ml6wGYCuFWwg4h2x6AzD2jtb5bVJ2rlWzE0FtN4oBZO2hVimjsyFM99cxZ/C3gcRA09xOy7K3iIHd6Mor1XvH2Ko28i4nnkooFLG57wKAk6APPvWAH/K6RTOBkH6QuEg7886i+5ti8VXQe0oMlun46vm2WHy1UzveYXhpuoEfLFY1Q3zdmxw8+Mpob67YiAqzZHHVFbMUbRDWNZQ3uIa/vvZzapGv+qCt6oDtzlYSDlFCBxWVF8nHUkl8+BpIQqEBC9ijQCZOnbDRNrRKljAhs+BHo1L8FQyN8EtYbwHGAfB07RY=
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(39860400002)(346002)(376002)(451199021)(46966006)(36840700001)(40470700004)(40480700001)(40460700003)(6916009)(356005)(70586007)(478600001)(36860700001)(70206006)(5660300002)(54906003)(7636003)(316002)(8936002)(4326008)(82740400003)(8676002)(7416002)(41300700001)(186003)(336012)(47076005)(426003)(966005)(26005)(86362001)(31696002)(2906002)(82310400005)(31686004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2023 10:10:45.2892
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8584a20a-906c-412d-99b8-08db34f4db05
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT088.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4920
X-Spam-Status: No, score=0.8 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,SPF_HELO_PASS,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 03 Apr 2023 16:08:01 +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.280 release.
> There are 84 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 05 Apr 2023 14:03:18 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.280-rc1.gz
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

Linux version:	4.19.280-rc1-ge4a87ad39c98
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra20-ventana,
                tegra210-p2371-2180, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
