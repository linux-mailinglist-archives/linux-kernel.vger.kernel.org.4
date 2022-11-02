Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D48C3616084
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 11:07:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229485AbiKBKHt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 06:07:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230290AbiKBKHZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 06:07:25 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2043.outbound.protection.outlook.com [40.107.93.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82A0824082;
        Wed,  2 Nov 2022 03:07:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H+CEs/67ynm78AHiRxWMwIchnZu5QVFf0iTcRCOCcfE5Xn0JLHk55o7iftqUmFVUaXiKWYdF9gx6G9Mz44BgkahV4AI0F0RZ1KUJ1qbNlT3nK+j8DOD5QztxeKHtxgdxW+G4l5JYHgPg3QdI7xCrAmHdBFaVrXlI1/A6tBD1ZbIts/vKqyGsGSTWBDQz6QCwwasqhdmOluuIpsb5OSZObp3tDrxuwR/iMjZAucN+s3++NVjNKZEmJmYkcLn7oVCz+lQIPedO0TnSS2Fs1wduXylfJoPF2XVGHCtXjVLY1pRSzO+CCKN3z4tJn0tTltFJ0UL7IIVWlGvovRMJH49+hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qEcKBAuGzxi7c0b9XC5Q9ULyaRhJxhTfuE5NUsxczrA=;
 b=HUOgI1ETXJg4HKszlyBk7iQALtuOufUHrXTxEKMD3oO+/hQ0pg7sZODprzb4+QrqSQc32rm0lsP3xs6SOdmVf1bDadavURr9gHhGQLN5GlCiQ4tumxH3suOCLzV7seyFYgPDpllePfQuZpfD5TaFqEua7QVUGjaW8wegEzm7tsRR+ZMjK9JrNaloY6u73X2WkfKuhBn45BfGTA8vhj/Sl/j9ncgTYHFMhd6Ht7wadpXAZ1RbnRO9HEW/rWurq2Asa2uWBRlmh9RfNXznjdJfIwvGeFkiDbFBTMFharZETwGL+rZZma3wj5wMFgM0WwlVG9LEuqGpOqqlEx0gZ3tZkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qEcKBAuGzxi7c0b9XC5Q9ULyaRhJxhTfuE5NUsxczrA=;
 b=MQ+05lne/nKb/7mNE5ix4xxeDlJww0mojk1PM1IJtWKDMqROMBbtOSN3m2ZKL/itLiSGMVBX5TXgjysCSKsC2TtWL9dEhj4H2W+LyM0AUxMHxb3Jbep1fiuK+LlhgH2vqV7MhaHh3gpWazxUTi2dnTJPcw4n7COXWpb+hMvPH9CHJQpKYfHQKpj2+mziODgz3womSKHwqC/59WHHBj4Lt0bw90EJac51De5hZwB00emWR4vGyZqPxzE/6seohnh6O8CnAcUJHnybdFIECurLmuQXGvxsnkAToavExkihL3MbYWIN6ZYdBqa7vbxdPaeiBRo0hevTGYBMTih2MzkU8A==
Received: from DM6PR11CA0052.namprd11.prod.outlook.com (2603:10b6:5:14c::29)
 by MN2PR12MB4501.namprd12.prod.outlook.com (2603:10b6:208:269::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.21; Wed, 2 Nov
 2022 10:07:22 +0000
Received: from DM6NAM11FT025.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:14c:cafe::5) by DM6PR11CA0052.outlook.office365.com
 (2603:10b6:5:14c::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.22 via Frontend
 Transport; Wed, 2 Nov 2022 10:07:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DM6NAM11FT025.mail.protection.outlook.com (10.13.172.197) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5791.20 via Frontend Transport; Wed, 2 Nov 2022 10:07:22 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Wed, 2 Nov 2022
 03:07:09 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Wed, 2 Nov 2022
 03:07:08 -0700
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29 via Frontend
 Transport; Wed, 2 Nov 2022 03:07:08 -0700
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
Subject: Re: [PATCH 5.15 000/132] 5.15.77-rc1 review
In-Reply-To: <20221102022059.593236470@linuxfoundation.org>
References: <20221102022059.593236470@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <53737f49-fd87-4301-b0f1-953a5b2bb871@rnnvmail205.nvidia.com>
Date:   Wed, 2 Nov 2022 03:07:08 -0700
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT025:EE_|MN2PR12MB4501:EE_
X-MS-Office365-Filtering-Correlation-Id: e90632ed-a290-4187-4a46-08dabcba08ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QNUwDJap7FNLS/v3QkOu9M0FsDSGuwsC+o606NyX3UXurmDqgYVc82yHOq36uVFfBfjUMpw1FWJVzcoaHJ7IE4SuLuDXsZ21UPLHL0Gz61zExICSAXZ9N79oDszJnTCQLBUEkxJ2bp/U3lNpKVDq8KOFwpUwJSFInPumZY6u8QGK2H+aXlCPtPYHbxfepKC+VFrxUytr2AvnXhp5j1HFYrKBbYSvrHE9YpDFQPg9t6ltPlW9WM8qOCn883MxSfvj8Dbf+A29uHQE/FKXYsAOreVTXavB8yj+E7mltSkHXgsVyfT9UWlxovkY8Vr5stdgpbnKgPCiHQQe6QmpxLhuLBWIEoQcrpV4WIYoZ3PG2rNPmI5Z4FkWbo/eQ2dUk6VK5c67C8Nj+GQGxaE6vfatO6WJ18P87DIxAP5P5fG0huBsICWNb0nyqBTX+gqfcsd9w8XvW3QreGA7Nu8WZ0y23x42YYd6EY7oi1ms9vDnVV5gLFASVqKThyry/gW2lslM07qkyR7wC98l6wXYUv9Rk9wyn0ZxUjWrVGC13N3TeZYa7Yf/tkqGNkBUZamdONswpZKKfaePGEIGYHszpiTcZAEmzgQiGeE7hNDgZUydbM1U9s/T6FM4G3q5Idvxv7u3awUZ/qOBnN5RrNl7Zd2GSEXR+YpoQMfyMlGQsAESFQR3KvUQu2U4Ez8pd+2e7QGFOK3lmG46+6CxQFEm3s/otUvwKbVFelbeQcmaYqDSnpqURpHBxA6RiL22aW495P+UVD/QsinvfZAbDh2D8iw//Gq1OOq02bUzw/qo/TSLwPEP/8gvaXagvLv9kKv2IU78RvVG7rRI9U+EClpcijy1A/0zMjt1o0e4k1hx9Gri8KE=
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(396003)(346002)(376002)(39860400002)(136003)(451199015)(36840700001)(46966006)(40470700004)(186003)(82740400003)(7636003)(356005)(31696002)(2906002)(336012)(8676002)(4326008)(70206006)(40460700003)(86362001)(316002)(40480700001)(6916009)(70586007)(7416002)(82310400005)(8936002)(41300700001)(26005)(54906003)(5660300002)(478600001)(31686004)(966005)(36860700001)(426003)(47076005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2022 10:07:22.4295
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e90632ed-a290-4187-4a46-08dabcba08ea
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT025.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4501
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 02 Nov 2022 03:31:46 +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.77 release.
> There are 132 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 04 Nov 2022 02:20:38 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.77-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

All tests passing for Tegra ...

Test results for stable-v5.15:
    11 builds:	11 pass, 0 fail
    28 boots:	28 pass, 0 fail
    114 tests:	114 pass, 0 fail

Linux version:	5.15.77-rc1-g55ed865a9c8f
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
