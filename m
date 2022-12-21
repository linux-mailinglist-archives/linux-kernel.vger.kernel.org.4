Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC4F4652DAB
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 09:08:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232174AbiLUIIB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 03:08:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiLUIH6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 03:07:58 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2086.outbound.protection.outlook.com [40.107.92.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8676762D7;
        Wed, 21 Dec 2022 00:07:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gkvOzeladNeKy/cphaQsJawuoT5cUzwBNH647+BeKWtc9SjVrP8QwGF9ggl//cpRXGpxyxiTJLOBC0WD6l87WaIVJxkqHWlSm1fXoeSGH5De8OfR4o2P7iH2Jglfipzc3QzMHcmE8e+jgnkkI/YBMyLtp7s26UzFdPMfJ57KPEl2ultpQors2r10FTWRB792d0yBW4zel82xvO7X7LU9h++vwOHBvCp8i3kkkLLwcBW8bL1daN+ZWAymdJHURkVubRACq+/o+cR1+MAPw65Ea871hSWwNJf22p/YkFpxiIzhQ9ONy+wO+yG9QhuMllafrNzu0LHwulPrtb5ZnbEv4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Y0G9aGfkA2G3WUWPEBach9FPH8lApJjLefcTSAsvPM=;
 b=n1wD02zWu2TRRk74wfiOyKmbO+EI9SDD1movytXAScrf+0awPVu2CLzcXThdwwCxSUExTeaWrk5/bG/WLB9Jj2fglgpfYjXar8Iwa9GHfrtDS28PiSuLt5UUC73Rjkeqb539tiawyfuxT4ea54/uAJc/7R+jxXkABy83i5vil/3l6jhxwNeDrBXErC7D3irtZuPKxSSDQ8amDM0n889z1aQ5lVG7WOO3uv+UEakLFYonfdP9nBKEGBd64syrUDAol5Pmj/kcGUeq+A3FNkLoXkbsPJUVKUATBFxhuMF0w5VL7mn7UH2NKpORNQ5+e/Sdagj7eOr4QNFbJLHH1zZPDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Y0G9aGfkA2G3WUWPEBach9FPH8lApJjLefcTSAsvPM=;
 b=Sy/7CYB1Z5b/LdjjtiGqoHnm4yeLFnIlxz3qiinXKGIlHNFBtlOBGk2CD6GsaxJLuL1aFbhs/oe7CgkBJ6tUkkqF3SrXjNB4h/77FXkF8vH0xder/p06JoJV+6vNVZZsELCy9+2+ECTmCr7nHR0HEuECxGYBB8D581W3HLvOJaN0PwgNhULkuLQFz10OVXfbvMX1vECcbmD5c9FNO7BDcobAHLl+KZRMyGKKd+c19vDT01YZ893NoMgqRI2brEbT3Dcvu5p9oQYQFsHYOCAVRGW6/MOY8FLGBuzYOtuMTJvAEIvXQS6Bfa2owpeW2dfKj5lV8zTSo2c4DGk/S9hn7A==
Received: from BN9PR03CA0784.namprd03.prod.outlook.com (2603:10b6:408:13f::9)
 by PH7PR12MB6396.namprd12.prod.outlook.com (2603:10b6:510:1fc::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Wed, 21 Dec
 2022 08:07:54 +0000
Received: from BL02EPF0000C405.namprd05.prod.outlook.com
 (2603:10b6:408:13f:cafe::9a) by BN9PR03CA0784.outlook.office365.com
 (2603:10b6:408:13f::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.21 via Frontend
 Transport; Wed, 21 Dec 2022 08:07:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF0000C405.mail.protection.outlook.com (10.167.241.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5944.8 via Frontend Transport; Wed, 21 Dec 2022 08:07:54 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Wed, 21 Dec
 2022 00:07:45 -0800
Received: from [10.41.21.79] (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Wed, 21 Dec
 2022 00:07:39 -0800
Message-ID: <bc6a5d48-7864-0075-4db4-b7251d31ee4f@nvidia.com>
Date:   Wed, 21 Dec 2022 13:37:36 +0530
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
 <0fe5ac44-9467-1dbb-3a69-5ab5839d251e@gmail.com>
From:   Sumit Gupta <sumitg@nvidia.com>
In-Reply-To: <0fe5ac44-9467-1dbb-3a69-5ab5839d251e@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0000C405:EE_|PH7PR12MB6396:EE_
X-MS-Office365-Filtering-Correlation-Id: 102b7fe7-2e36-4eb2-7a75-08dae32a76ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qjtmGtK49b3o0TMhHRo+E56k09sR5mpq3bljjP4Oe0W3tBlNPv1arqpNC0h6YAsYM8P/Mj9GOO2q/B/RweTohfWXabzbDLi7LeKY7GJa+q/H06lCU+nRAR67Ffh+LKjD3Dapi89nDBC8zjzMThbeaJlX7h4b4jlWsNneHbJ8alTGSQ50XF90f3hW3mIk7gocokISuhmKvQSxbhUFW0mvFcq+GYed2l2J0WXUb0Zg49Hd2Gw7Ld0fvGgfdAX29h+RxnlkNtY3Y3MzTOdBfK1TXOIJfQl5sw2MYodRccrdYvbjSyO0jHfMFnOCp/LCA4DyUHVEz9cd2mfLBiJpF5PDV9YIkvmZlQbYYH2VUZZABqsmHe7LUx+gmK7V63wnkJdTi87OX0Y4e5qzl/dOixAQyXp9JRHfCB/8Qa9DqJxhxL8plZgGfIjIvU4oUk+QqhWSveM3rx25Nl5KmcRNBnW0V3DI/dXEbPZiCUpNuWcOzT8n+eJ7XbHG3nAziuz+QFfqvm9cNeSd44M7Zh6Hr7fjIqe69a1hSNJXbH4VZPItO1wUPG0/0Ua0iUpor43aR63sDAaa6cBFur1mxGsHF+AH+J36KtaRi614sMsCYBY0ySNw/iM10BNZKgeHYPR2x61nFL3oXfN4K+lwTO/cc3TOhcaQpJGAlnANqfKCPtROCuqrEgoTusRX/O0XTDmUU4iojpgyXwyYNdbTBznJvLQfk0IoHlRxpjYpbztKCRYzEtZqGi9J2678hPSZMpmqed5r
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(396003)(136003)(39860400002)(451199015)(40470700004)(36840700001)(46966006)(426003)(6666004)(8936002)(107886003)(47076005)(31686004)(40480700001)(4744005)(5660300002)(186003)(41300700001)(16526019)(26005)(336012)(2906002)(70206006)(16576012)(40460700003)(36860700001)(478600001)(82740400003)(316002)(54906003)(53546011)(7416002)(31696002)(86362001)(921005)(36756003)(82310400005)(356005)(2616005)(4326008)(70586007)(7636003)(110136005)(8676002)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Dec 2022 08:07:54.5690
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 102b7fe7-2e36-4eb2-7a75-08dae32a76ce
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0000C405.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6396
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 21/12/22 06:25, Dmitry Osipenko wrote:
> External email: Use caution opening links or attachments
> 
> 
> 20.12.2022 19:02, Sumit Gupta пишет:
>> +static int tegra234_mc_icc_set(struct icc_node *src, struct icc_node *dst)
>> +{
>> +     struct tegra_mc *mc = icc_provider_to_tegra_mc(dst->provider);
>> +     struct tegra_icc_node *tnode = src->data;
>> +
>> +     /*
>> +      * Same Src and Dst node will happen during boot from icc_node_add().
>> +      * This can be used to pre-initialize and set bandwidth for all clients
>> +      * before their drivers are loaded. We are skipping this case as for us,
>> +      * the pre-initialization already happened in Bootloader(MB2) and BPMP-FW.
>> +      */
>> +     if (src->id == dst->id)
>> +             return 0;
>> +
>> +     if (tnode->node)
>> +             mc->curr_tnode = tnode;
>> +     else
>> +             pr_err("%s, tegra_icc_node is null\n", __func__);
> 
> The tnode->node can't be NULL.

Ok, will remove the check.
