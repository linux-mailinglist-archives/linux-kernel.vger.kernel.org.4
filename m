Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D89326696FE
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 13:29:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240830AbjAMM32 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 07:29:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241497AbjAMM2k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 07:28:40 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on20622.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eab::622])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EC466CFF8;
        Fri, 13 Jan 2023 04:26:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d6UWTnMLhj0/EZRFFkjO4GNG3KZrXI1yxBfAvMsTMg5+LWgLsSfXTlKNkugGSzg/ZD67boeZRmZ+hPgQzA3+Fmy9ZKzyc6p7NGivpzNL4RlHhMNqF+WxSX9aR1UToZUvtso4y06EMQ4kwpn8w/00ftfLAAvqy3rl9kKsc2Tb4ALOnhAcj5ICr4bcejueqozniWVXyFFxtogBY+3Jxo7mpup6lK2rGTNSDhTJH1xF3IgPLBCxPuwhfYGXzudWxSofLMLB8Dc5++OIULRbDFwt/65UN/7VNSPaLqmHwO8UJ9NiLYI0MtxiHe5FuVyxNOHThxR5iZIhNhyaONUaojY30w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lu4CEIWktROaZIQN16YYuxvX8E49dULfYy+ILk9hrsM=;
 b=JUPnj8ibdHXidhWdcWptsoFqUb6Iio5OqKZlAScePrQGu3dDzSQaYOl/IGyY5jWJsOz6su9YTBnMli1U7zjZ3YrqjDPGMukXn8LAd4UKMd22ip53cr9tF3tfDtfYLmuHdyIE+8nJfDawZEMdWiHvNo1qOd6NzNbYT5AGwElf4EnYlDPd3t3PyLj4jIhnDa94Q9L1WXgjZzduCssRg1Fz0OOb0+PnTCPeZDXnDdH/RFdYw9p6adAN9ZDNNM5qhgDt6P5PaoU9iq3YZSs2lUGkSHFp3RseMcfl37j/3EeMnno3R9GQDls+hhSp9VW1CKH2w2cskYHq1B5SjTF/ueFSAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lu4CEIWktROaZIQN16YYuxvX8E49dULfYy+ILk9hrsM=;
 b=KRjd88K2sPjSgtkdvkXdahqseoTA3zSf1ioELcIJOQeOUvcRJ3iB+2hQ7f3oA2a2bqajwmrmImKpJSnTqR/XbfuafefJEJaH5V4QaGycYS+hm+fB5LiQAIjV/MrYc7SQxk6KYgNmX6z1uWW/CBZGsTO+DaZaha+8LjHiNiNu+j1X3bPdkHgZxg++V0ZefDT1RlfWd+95rUNlY1mt5UODoo+v8xhZgN/GzEgKJPWkb2ns9rJNf8lQLWgJ3AZyxCovXKzEhMbELZGoLH4YeQgVHA31okDtUnWvaE+1ImqfQosvh8mBB2tLFbXWZPSdIZy4O4sHJD7QDE4v5VPMwg6gXA==
Received: from DM6PR08CA0043.namprd08.prod.outlook.com (2603:10b6:5:1e0::17)
 by IA1PR12MB7614.namprd12.prod.outlook.com (2603:10b6:208:429::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.13; Fri, 13 Jan
 2023 12:26:04 +0000
Received: from DM6NAM11FT101.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1e0:cafe::b0) by DM6PR08CA0043.outlook.office365.com
 (2603:10b6:5:1e0::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.14 via Frontend
 Transport; Fri, 13 Jan 2023 12:26:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DM6NAM11FT101.mail.protection.outlook.com (10.13.172.208) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6002.13 via Frontend Transport; Fri, 13 Jan 2023 12:26:03 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Fri, 13 Jan
 2023 04:25:51 -0800
Received: from [10.41.21.79] (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Fri, 13 Jan
 2023 04:25:47 -0800
Message-ID: <0b2712ff-d4d3-3a7a-aebf-6b56774fc0fc@nvidia.com>
Date:   Fri, 13 Jan 2023 17:55:44 +0530
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
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>
CC:     <sanjayc@nvidia.com>, <ksitaraman@nvidia.com>, <ishah@nvidia.com>,
        <bbasu@nvidia.com>, Sumit Gupta <sumitg@nvidia.com>
References: <20221220160240.27494-1-sumitg@nvidia.com>
 <20221220160240.27494-2-sumitg@nvidia.com>
 <8641fad2-7170-4c0c-fbd6-6e2e784b3106@gmail.com>
From:   Sumit Gupta <sumitg@nvidia.com>
In-Reply-To: <8641fad2-7170-4c0c-fbd6-6e2e784b3106@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT101:EE_|IA1PR12MB7614:EE_
X-MS-Office365-Filtering-Correlation-Id: 34bb9ab6-4188-4429-a08d-08daf56156a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cy7nKjFb261cxS6ZVJNSRMUUaQsR6KZv20f67ineAyNO3X+9avbNZmsVzQLBiqu7FFnqYNmBBynR5C9Nc3IISOXIg391dfDe7dztWh3dw9dtqudrrYGwsLrMLVTzRcVXGYb7QfgvdyFUndgOy+hgKws0A2CmOcHT7ZhLWiIVztgvYxPneaQj3oOowx8FcnWNYD/xDbXm+MU6GywzwjL75kExfrrH2nH06udoUdqLOaGFrYmqTnF7GQ0xKJJLWDaG+t82XVGLKpth2733a1dtQ9c1haA8atX04E2vwKzoETaZoUDNa1H9YXbTOGaf9GvQEaPf7UoLfPV09VQt038mk8cvt5vRxOB/rRX+QPSvLd0dKGs9lufmkl1N4EuoVTmv9YBJ1Jf8vC8N7VPpNTUGAossX6s/NYdWKmXKJgUzFuZWFb+J/hEVl6SIBP/exXVjrIz1e9VkXb6KbdTP2Mrxega3DtDc/w9pULHy7oM71HytUn5dXZT5Pb8gA7hlN3Rty1aGyprVbBj+le0wmrxVjFGbc0cKet6CRKd0EgmdzkspDuSu03tPFfApNfLbSgex4cAcqviB/ZXO7Ufel33iXPjJx3QhX2dmlompgm7Q6fiLkqWhqr2I8KWeALAfQkTBEWQpAUhEqWoliVI3ntX47m8yxZ3akU8LckpjC7UR7zyDMaQbgj27E0rwftpdoSbDVug/Vqv7lfCjFzcdV2BXa0RMuDdC2u9iSIm1555iowmT7IsaxeshUTtpR3T1vvex
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(396003)(376002)(136003)(346002)(39860400002)(451199015)(46966006)(40470700004)(36840700001)(8936002)(5660300002)(7416002)(83380400001)(86362001)(41300700001)(426003)(47076005)(7636003)(82740400003)(82310400005)(921005)(36756003)(40460700003)(356005)(2906002)(40480700001)(31696002)(36860700001)(31686004)(478600001)(26005)(186003)(16526019)(8676002)(336012)(4326008)(70206006)(16576012)(53546011)(316002)(110136005)(54906003)(107886003)(6666004)(2616005)(70586007)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2023 12:26:03.8784
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 34bb9ab6-4188-4429-a08d-08daf56156a0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT101.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7614
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,SPF_HELO_PASS,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 21/12/22 22:24, Dmitry Osipenko wrote:
> External email: Use caution opening links or attachments
> 
> 
> 20.12.2022 19:02, Sumit Gupta пишет:
>>   static int tegra186_emc_probe(struct platform_device *pdev)
>>   {
>>        struct mrq_emc_dvfs_latency_response response;
>>        struct tegra_bpmp_message msg;
>>        struct tegra186_emc *emc;
>> +     struct tegra_mc *mc;
>>        unsigned int i;
>>        int err;
>>
>> @@ -158,6 +307,9 @@ static int tegra186_emc_probe(struct platform_device *pdev)
>>        if (!emc)
>>                return -ENOMEM;
>>
>> +     platform_set_drvdata(pdev, emc);
>> +     emc->dev = &pdev->dev;
>> +
>>        emc->bpmp = tegra_bpmp_get(&pdev->dev);
>>        if (IS_ERR(emc->bpmp))
>>                return dev_err_probe(&pdev->dev, PTR_ERR(emc->bpmp), "failed to get BPMP\n");
>> @@ -236,6 +388,19 @@ static int tegra186_emc_probe(struct platform_device *pdev)
>>        debugfs_create_file("max_rate", S_IRUGO | S_IWUSR, emc->debugfs.root,
>>                            emc, &tegra186_emc_debug_max_rate_fops);
>>
>> +     mc = dev_get_drvdata(emc->dev->parent);
>> +     if (mc && mc->soc->icc_ops) {
>> +             if (tegra_bpmp_mrq_is_supported(emc->bpmp, MRQ_BWMGR_INT)) {
>> +                     err = tegra_emc_interconnect_init(emc);
>> +                     if (!err)
>> +                             return err;
>> +                     dev_err(&pdev->dev, "tegra_emc_interconnect_init failed:%d\n", err);
>> +                     goto put_bpmp;
>> +             } else {
>> +                     dev_info(&pdev->dev, "MRQ_BWMGR_INT not present\n");
>> +             }
> 
> If there is no MRQ_BWMGR_INT, then device drivers using ICC won't probe.
> This is either a error condition, or ICC should inited and then ICC
> changes should be skipped.
> 

If the MRQ_BW_MGR is not supported by a BPMP-FW binary, then the MC & 
EMC drivers will still probe successfully and scaling will be disabled.
