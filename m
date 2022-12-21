Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE363652DA7
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 09:05:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234488AbiLUIFw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 03:05:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234489AbiLUIF3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 03:05:29 -0500
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2063.outbound.protection.outlook.com [40.107.102.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4F0021836;
        Wed, 21 Dec 2022 00:05:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AnNWme4vygpN8FBGf8qaW9d7varyV8B10UPk4S70VqEe3PMfsxZg8ZYmT6RcwngoxEA+bneYneJWmA/eGh42VFEZ6Q++6oTNnJqoHMvuqUVvEVVg+hVwiP6gbsC1Z4lXvkug3xkavCXElkyRkC7IVZ5In3i9Y0D2P69nBa7qrrQSp9MPQYWs4ufEnfYqiwBptDCySy55k1ggEVc7l134pOaKJY6LIgaOKvlb+pQvUPLCW9FMqCPWe8O05meSugxHwM/yxrTgCvnl04BocWQobPzTnuZB6kvSIYd+VpWL6DZVP3fACnAhMFuY7h6fX0lx32AwtaDylxcQyjA/3CkCXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EA8NSo2KG8/DMuQ/BlQUGUKYx/IOXINOZIB/pDpYlhw=;
 b=AB5GU9CCZG7mCPiBbkzRXKzcooYCL3IwziyEw1Gxihlux0IHC0t2etwpT0IjQXRgoxxji12p5D4PsqDrb/jYoN6miIX/ETAQifyHWaxt+GhcqgSn/BfiZaGw1qSW5yeXy8cm5ANDlRv4471Gm7m1DonpycaKhe/6Vec3kEPjXCSblN68l8XULRZT52rc6TCZTwlpsNCVn8RNreOuDjEbWiaiJL6K2VfCjxH+sdjwEXAFHNld+hy5oGQFT7+FJ387lO5HwkvBQRhxqHKZPaOUgRyI61rGKWCdPoDDSouq2nZ7q6jVwa6MajF+Msxh/XTnOR9npascOSwgnpNJzQU1uQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EA8NSo2KG8/DMuQ/BlQUGUKYx/IOXINOZIB/pDpYlhw=;
 b=n9j2UCyCpdjlo+W+xKhbLe/ekpqp7qb9Vyd/i7jBzgBOgwPGtwyROhvtfW4BeYQeOineIW1VEjvq/HqPUBkV97jnO7nh3IjRvPSh/s3Sgq82sIESaCWLOwfnYG/Ubsyx9tGHwhwiTl+3E3kkHkqeH7UagR7KkqZjrqo5eFEPBYSTCXRKROngyUz+uF9vTuenz2L7mT2uFAwV7YNjbFMJj043fnRDSJLt1hEmPGAqsmz/xTSxBTyrAbf7v4f23Gbn9+B7ToPysZPgTucQAq+xphNe5VU/fPEFUq397tXuVg0Ynt11J8mxaq72u5AxxyNe2mGUIaJdOCHEUgnKhdxvJQ==
Received: from BN9P223CA0025.NAMP223.PROD.OUTLOOK.COM (2603:10b6:408:10b::30)
 by PH7PR12MB7913.namprd12.prod.outlook.com (2603:10b6:510:27b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Wed, 21 Dec
 2022 08:05:24 +0000
Received: from BL02EPF0000C408.namprd05.prod.outlook.com
 (2603:10b6:408:10b:cafe::96) by BN9P223CA0025.outlook.office365.com
 (2603:10b6:408:10b::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.21 via Frontend
 Transport; Wed, 21 Dec 2022 08:05:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF0000C408.mail.protection.outlook.com (10.167.241.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5944.8 via Frontend Transport; Wed, 21 Dec 2022 08:05:23 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Wed, 21 Dec
 2022 00:05:10 -0800
Received: from [10.41.21.79] (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Wed, 21 Dec
 2022 00:05:06 -0800
Message-ID: <221c1bab-8f4d-9dbb-bb12-4f7ab5dc5d90@nvidia.com>
Date:   Wed, 21 Dec 2022 13:35:03 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [Patch v1 01/10] memory: tegra: add interconnect support for DRAM
 scaling in Tegra234
Content-Language: en-US
To:     Dmitry Osipenko <digetx@gmail.com>, <treding@nvidia.com>,
        <krzysztof.kozlowski@linaro.org>, <dmitry.osipenko@collabora.com>,
        <viresh.kumar@linaro.org>, <rafael@kernel.org>,
        <jonathanh@nvidia.com>, <robh+dt@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Sumit Gupta <sumitg@nvidia.com>
CC:     <sanjayc@nvidia.com>, <ksitaraman@nvidia.com>, <ishah@nvidia.com>,
        <bbasu@nvidia.com>
References: <20221220160240.27494-1-sumitg@nvidia.com>
 <20221220160240.27494-2-sumitg@nvidia.com>
 <f4e05666-d094-18cf-2641-ebf92da85dc8@gmail.com>
From:   Sumit Gupta <sumitg@nvidia.com>
In-Reply-To: <f4e05666-d094-18cf-2641-ebf92da85dc8@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0000C408:EE_|PH7PR12MB7913:EE_
X-MS-Office365-Filtering-Correlation-Id: 88d3522c-46a6-40b7-f558-08dae32a1cf6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4qiaSbzo1LrEVm6T8KVQQ3V2mFdl+omfW0O3U1q3MPrqi/etVPXVbOPEdqdJJpBJ4iCfvp9ZJ8m/zOnUyetLASFrCpwYRuTDlE8+sA/a6/L1lXhKCvKzcKWL+AfHd22UWpm5q3Xt0AwbMCkTljQfEnYS3LMiOQ8mlc9WdfPT/46PkxUGvQREPbPA1qyD690DLVAnFCZlb//zv9v6xFsGEQl4yJuIGwbTyyutSWDZ7FVe43itUCDVwbYoafJGURmX0iwbC3u0L+YazFUV0sB6Puhrm0jdMk0yluJa3cDculY/a6isNOCsrVSxZ77SmoixUY6006gGtqJWnf7zIlIXPs73k6cFX1AiA9ttnq4B2oXwSQuEJ6zktPYcggmXNLUnRZ1vnKvF5Miz/B+mcPrkIr77UsbgCMGuMGYNFr0sgkFk/n2DQMohVDzjKyoXRj1NJgREB5ynK6kOMS7/+gPPEUsorpEjfqVBW1vHbyX/uRfmcgpWH9ZLruOKg5ZENZiS4ulY9GoRXs5f/EZzK91+xQH0BzLhpWlHFmStWdRa7F7ZAVaFL+c8rkdLleeF8fiGD8LA2e00cIo/Nal3nnu5CLoKf0/QOFC6WIIAMMl77XTWFTJlkgDjaUa1ZZXG7WW8KJ/4FMxaR/HPGoJgoxRGOnrQWNeW1++wSf6/Yj0gjjZg5DsuhsG8i8kiP8ABjEd9+QhGmBGX3q2vhIJ7l9PLev8B9a5lukydhYOHqJ7sHX7A3HaXXpZMmCca3aa+NdtE
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(39860400002)(396003)(346002)(451199015)(46966006)(40470700004)(36840700001)(82740400003)(82310400005)(53546011)(186003)(26005)(336012)(426003)(16526019)(47076005)(478600001)(36860700001)(6666004)(36756003)(107886003)(40460700003)(31686004)(2616005)(41300700001)(316002)(40480700001)(110136005)(16576012)(2906002)(8936002)(70206006)(4326008)(356005)(5660300002)(54906003)(921005)(86362001)(31696002)(8676002)(70586007)(7636003)(7416002)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Dec 2022 08:05:23.8237
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 88d3522c-46a6-40b7-f558-08dae32a1cf6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0000C408.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7913
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 20/12/22 23:37, Dmitry Osipenko wrote:
> External email: Use caution opening links or attachments
> 
> 
> 20.12.2022 19:02, Sumit Gupta пишет:
>> +#ifndef MEMORY_TEGRA_ICC_H
>> +#define MEMORY_TEGRA_ICC_H
>> +
>> +enum tegra_icc_client_type {
>> +     TEGRA_ICC_NONE,
>> +     TEGRA_ICC_NISO,
>> +     TEGRA_ICC_ISO_DISPLAY,
>> +     TEGRA_ICC_ISO_VI,
>> +     TEGRA_ICC_ISO_AUDIO,
>> +     TEGRA_ICC_ISO_VIFAL,
>> +};
> 
> You using only TEGRA_ICC_NISO and !TEGRA_ICC_NISO in the code.
> 
> include/soc/tegra/mc.h defines TAG_DEFAULT/ISO, please drop all these
> duplicated and unused "types" unless there is a good reason to keep them
> 

These type are used while defining clients in "tegra234_mc_clients[]" 
and its passed to BPMP-FW which has handling for each client type.

  kernel$ grep -B2 ".type = TEGRA_ICC_ISO" drivers/memory/tegra/tegra234.c
      .name = "hdar",
      .bpmp_id = TEGRA_ICC_BPMP_HDA,
      .type = TEGRA_ICC_ISO_AUDIO,
  --
      .name = "hdaw",
      .bpmp_id = TEGRA_ICC_BPMP_HDA,
      .type = TEGRA_ICC_ISO_AUDIO,
  --
      .name = "vi2w",
      .bpmp_id = TEGRA_ICC_BPMP_VI2,
      .type = TEGRA_ICC_ISO_VI,
  --
      .name = "vi2falr",
      .bpmp_id = TEGRA_ICC_BPMP_VI2FAL,
      .type = TEGRA_ICC_ISO_VIFAL,
  --
      .name = "vi2falw",
      .bpmp_id = TEGRA_ICC_BPMP_VI2FAL,
      .type = TEGRA_ICC_ISO_VIFAL,
  --
      .name = "aper",
      .bpmp_id = TEGRA_ICC_BPMP_APE,
      .type = TEGRA_ICC_ISO_AUDIO,
  --
      .name = "apew",
      .bpmp_id = TEGRA_ICC_BPMP_APE,
      .type = TEGRA_ICC_ISO_AUDIO,
  --
      .name = "nvdisplayr",
      .bpmp_id = TEGRA_ICC_BPMP_DISPLAY,
      .type = TEGRA_ICC_ISO_DISPLAY,
  --
      .name = "nvdisplayr1",
      .bpmp_id = TEGRA_ICC_BPMP_DISPLAY,
      .type = TEGRA_ICC_ISO_DISPLAY,
  --
      .name = "apedmar",
      .bpmp_id = TEGRA_ICC_BPMP_APEDMA,
      .type = TEGRA_ICC_ISO_AUDIO,
  --
      .name = "apedmaw",
      .bpmp_id = TEGRA_ICC_BPMP_APEDMA,
      .type = TEGRA_ICC_ISO_AUDIO,


