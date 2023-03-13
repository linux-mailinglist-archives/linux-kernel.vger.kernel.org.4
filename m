Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 971DF6B730C
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 10:46:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230089AbjCMJqC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 05:46:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbjCMJp7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 05:45:59 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2089.outbound.protection.outlook.com [40.107.92.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2DEC274AA;
        Mon, 13 Mar 2023 02:45:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xhy7/S3T6em46m77SpCDu2POWNwu+piLYbwEoCT1JXAbJok6oyVLBewGWPQpjMOTSpO9NKHYvYf99Po1qkA6em5Z0NuBiF51xXr7mQi0m+ziOKkJRsF4uDaV+YasXsD5xAdQYIm8szMaIyEZENt3YEyaZHpj7AhWP5JhgLUo8adO2/gMGOxzGxcljhm441uyDDV3q6yFIibdOeD8H24eqTK5zmwj9BNCmiDORctuQytPKVbxDtJPCApuRF5qkIPFFfrybw7Y1kwgkUDVSB0N71wXgPvbPCVfoW7ji6hhe8t7oXo4iJfrCVA/4t1UpSY1JZlErv0S60ATE5g7Nh8/GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3/bAkxfmL4RorA+Aq9hQL+TRaaE4z66sKX1SJ8nP2mM=;
 b=hu764KxZkxSZCEeD7zPSXMHJ0Q+bD5pE5JwDgK+UMoSeNtpL7FAjc5pjdyMAstSaTX7Mw95CQx4KoQ5BS7JLrxu/oJKZwum87WGDuzxZOUkAEAzYZaESUVPQnJt6mQoeT449dw6xZlpR3wUDPYuElXBheVaVtI18rtEs2JT8yldbjmcJOncKFR6k6tP8ejRWztLN7DteqV+WbEHyQmbbXw6A39SWRrATzlskEFlv8yn4NV90aYnfHDEF8t4EKLDzqqYG0AsNbx7t+ubrlIHRjZUWzfI14RnawisZ950IdTvUgNLZj2NLEAh9vXHfK/Y2Cmbv3qu34oNU+fSZR+/FyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3/bAkxfmL4RorA+Aq9hQL+TRaaE4z66sKX1SJ8nP2mM=;
 b=fDGfmtZpIhbKHI57VAxHp6GfD+/VP4lfthUJ+t6zgGFi26d2yT/Dz9ZOEVpkqaYf7ngwGDkzqqmFMi8G6g5vGIwgq0mOEPL7twcphxpTjFyI1PqKjb6UVtPg4fwrW2QJUjk7xv7DH43fAfxAN7E+ijvp45Y5WU9y4ee6jk4cDQMF6p0obnO2dDchYxwkYqns7LUw44+ykgmyNGnBOS9uc4GrLG9gUUqknvMdKpFhmAfItqAqeRLdWWkkSHiR8GXrWmpJWjOym0exRaepzJO4Kqjkj8c4hzn1nV6t4OB9diKhEwgGqSMon3AZ/bxfdPenfF6UGPH1R5XVhxhLXX+W0g==
Received: from BN9PR03CA0929.namprd03.prod.outlook.com (2603:10b6:408:107::34)
 by DM4PR12MB5914.namprd12.prod.outlook.com (2603:10b6:8:67::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.24; Mon, 13 Mar
 2023 09:45:39 +0000
Received: from BN8NAM11FT037.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:107:cafe::99) by BN9PR03CA0929.outlook.office365.com
 (2603:10b6:408:107::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.25 via Frontend
 Transport; Mon, 13 Mar 2023 09:45:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN8NAM11FT037.mail.protection.outlook.com (10.13.177.182) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.24 via Frontend Transport; Mon, 13 Mar 2023 09:45:38 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Mon, 13 Mar 2023
 02:45:24 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Mon, 13 Mar
 2023 02:45:24 -0700
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5 via Frontend
 Transport; Mon, 13 Mar 2023 02:45:24 -0700
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
Subject: Re: [PATCH 6.2 000/211] 6.2.4-rc1 review
In-Reply-To: <20230310133718.689332661@linuxfoundation.org>
References: <20230310133718.689332661@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <3bd56fce-d281-439d-a95b-439ff6afe918@rnnvmail204.nvidia.com>
Date:   Mon, 13 Mar 2023 02:45:24 -0700
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT037:EE_|DM4PR12MB5914:EE_
X-MS-Office365-Filtering-Correlation-Id: e3287312-325e-465b-1cbc-08db23a7b3d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: O2sBevakd1VnL3XD3rrRM/jX+q6MJw7XlTUaQTsHXI55hhOLyP/DTPCegJ5ijp2Bh2zqLik9mNTxY4my8YwRADtCxWoS5SVeyELvrSPuGxua2kW2zdtl0x5WhNp9XsQYY8z75WXjMF8Fldm2He3mtTsJGu4vqbjLG80/jxFFQFoWmDRNTHWjlL2NmVEsEGXpbEoaGc7wPeLXeEaY5suvL2BzJD67vMZpLvNWyMbYY21SDq5Vn/Ke9e/tmHkWWccaK7lN1loQyfgSDsfTu9Z4pOiSF+xAR5507H66JLMFnRVuKI1wgUr1WgfbcXOqGa3KR3zocKJQ9v4n6y4bLKDD/L2nL8WjLAyNmvzNCTWTIXK8LUDlLhHgFjWfcUBWjfmimkqZ/bq2xbgWXdy5LbNCLibWoKbl9e6SiKghrZrANvNBX82qnHBfrybZWblc2Wfxc06f1ijezFJVCWF6KfPI0y2NeDLG5ksixbymAto6IZrCONDIWdON6PwEcQ9AqgmcH3d6Tdqvcpp4DHLsVZ5WeoMXas5vTXp5oHnTFEBbQyyXMYQf2PKiUnePC9bcDA0tHsUqggCHHXjCchOwquP5HHI3C0g+bRtPyjPHAf2X7RIH7DjxIRX6DpFoJY/omk0dstZJ81MqA/7xTnhIZ3+eKiAQ6qDekVHQUx6i98vd/VygokuIls8b3/gM0frMckAWJuEoJ+uACjqfAagukWd2a/lJ3Mu6MwKcXLS/PGwN1C2Y0fPqPn0bZn+vXOZgKzv0ffIH1GX+DxxcBTGRvu4pL+L/+Tk/vw7BFoz/jTEWfkI=
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(396003)(39860400002)(376002)(136003)(346002)(451199018)(40470700004)(36840700001)(46966006)(31696002)(86362001)(82310400005)(356005)(36860700001)(82740400003)(7636003)(40480700001)(40460700003)(4326008)(70206006)(8676002)(70586007)(6916009)(8936002)(54906003)(478600001)(41300700001)(316002)(7416002)(5660300002)(2906002)(47076005)(426003)(336012)(966005)(186003)(26005)(31686004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2023 09:45:38.5043
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e3287312-325e-465b-1cbc-08db23a7b3d9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT037.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5914
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Mar 2023 14:36:20 +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.2.4 release.
> There are 211 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 12 Mar 2023 13:36:38 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.2.4-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.2.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

All tests passing for Tegra ...

Test results for stable-v6.2:
    11 builds:	11 pass, 0 fail
    28 boots:	28 pass, 0 fail
    130 tests:	130 pass, 0 fail

Linux version:	6.2.4-rc1-g54d58d14b95c
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
