Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E068652EAC
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 10:35:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234544AbiLUJfu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 04:35:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229713AbiLUJfp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 04:35:45 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D663219A;
        Wed, 21 Dec 2022 01:35:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dkB2xGaFy9rqAB7AjK9SG/r51h8LPeq5506+Pp0dN4VHALsIdC6DoHPo6AZinEFsF4PqoOYk8HcQUR0lJxAv4s3AohIz2wFJEP7feqXOjAeDeQ5giweAa0pCY9A9lPC9TfJvV1+8xjy3r89p3zhn/Jkc9qXqGZAU2T0+uMV+XxFytmwKj0Ksv6PItsFB1B5dNlajign5MSDUKeZ328PrrnPQYqf6YDy5WB466SYiJ/YzTCtMRRY4N7OhQvZukERCMW1Ebq0Imhm35Um1TitSIphwFfodMf4nZahOAjmMSqRXgkGQhboGOlGtBgvxZh50G8boz3hJKysJUu7f2iHWgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BrUV+K8oKFmJgap4qcL5Umt/DVScJKZJvyeJ90JQvKQ=;
 b=BI0rspFBRi937kJbSgo6VZCyM6dIwPB5bWSDUVgmVLosQCRrgsgrCo043Kwx6UNT+D8dPQlz4o3TFa/CK0EF2/SqWPGpcdfG/6C8WQmKGRCODsS1ISl41C7hBookwH4nPrDY1hMNfLMr6NTLcydH03mIrhx2sbOu4wEz/fQ0+TjB5z90VfG+9p4WGAMOSMwVvgZ7W5nmvPbDVxsOtO5WuA/tzdOqphTwe+LM6W6ds8rYAKf/O2TRLqPSyI48B+Ia2gjNavehavz6FHLOryGH/+rvClSbC3r3hrsLOwLDUKdJxI7RXOREFBPmBv4kSWnPHuezyGYnwcJUwIL7iZqN+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BrUV+K8oKFmJgap4qcL5Umt/DVScJKZJvyeJ90JQvKQ=;
 b=cAW3wmdpc292jOWzTyqQlZ+CyCjO5kR9suty0R6WOxxrd3x60OgufdMgBq2+nlB6OZLCGre1lFvlZmfg85spNb+AsUwUWiL1pdWhUtpjSLFEZ222DQeFAFpm3RxoS1ijnWDsrbLpbsTXCIGkRTiQ6dlzVTJKPZSgw2j5W8MG3sSSXTXgKipHeegg4dCohZzxMfAjrMBseL83PmrMOTKolJFr9TXEdLWCBvFbD6nygrMTs9q0pb5YH003HzO9IEQYQIGpZSVxsiFCSbJm/XSYYXa06qAuTTypprDLOHRMg4KrMcvmmj4Y/wE/Mbf+3AXEmMzdO5uq4oI03vLK6eWg8A==
Received: from BN1PR13CA0009.namprd13.prod.outlook.com (2603:10b6:408:e2::14)
 by PH7PR12MB6660.namprd12.prod.outlook.com (2603:10b6:510:212::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Wed, 21 Dec
 2022 09:35:42 +0000
Received: from BN8NAM11FT063.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e2:cafe::6a) by BN1PR13CA0009.outlook.office365.com
 (2603:10b6:408:e2::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.10 via Frontend
 Transport; Wed, 21 Dec 2022 09:35:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN8NAM11FT063.mail.protection.outlook.com (10.13.177.110) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5944.10 via Frontend Transport; Wed, 21 Dec 2022 09:35:41 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Wed, 21 Dec
 2022 01:35:28 -0800
Received: from [10.41.21.79] (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Wed, 21 Dec
 2022 01:35:25 -0800
Message-ID: <298fcaca-c708-5d68-95d6-51673f7a2174@nvidia.com>
Date:   Wed, 21 Dec 2022 15:05:22 +0530
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
References: <20221220160240.27494-1-sumitg@nvidia.com>
 <20221220160240.27494-2-sumitg@nvidia.com>
 <4d562b75-854d-1997-8969-e7ef222e4e37@gmail.com>
From:   Sumit Gupta <sumitg@nvidia.com>
In-Reply-To: <4d562b75-854d-1997-8969-e7ef222e4e37@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT063:EE_|PH7PR12MB6660:EE_
X-MS-Office365-Filtering-Correlation-Id: 3edb0040-35d7-4669-6130-08dae336ba3d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z1cyYzBxJJhd8Khvv/YJpBDztwOxZ7m3d48vTuGRk5n1mMhOz4OVoLM1qMRuZJQPLYOu+y8x9B9yGuPEpD6QO5twbPUS5QwiVhHYBGPuEqmv1WonjGsFZnOFCEMcEWHpV9YGY6HA8ubfpSepR0JaAniaIz5xrUJvfsVZcK8YWf0YtrGS1ogwHbZ7ObcSBtK7gg2gD9supJ+cJyENgeyRINkysmn4sCKRcaBQ+wnCVTa5s3cGhWt8Kf0XiLElxT0B33iHpLyLFK1Wgkd03M7og4nJs1CtLr/qwR1TQxXfsMKdpEtlXs8aosktLfOtVFmPz8wlHCcxukpHGAcn6eQHK3prIuECrSyksZz+VPCChT4393JmbNV2Bi1b6ISYQx1oTO1no67SlSJin3RNaJs6X4xpADM2dPkPhL+c7ZQZ7S5zH1BTcrKxHiS2scTK6/u4ExHmonGW7vZYpapvOf2Q78fuafW1REdDHS3D9Kon7WS2nRhiwoXt393ZmDuRe4o7n763tYbMt2v6h90X6Msyw0ggbp0rwSibN8GE/ORcm4HLi/eeBm6J6Ruri/MsAJ71T6zUznoRMhlqHmc7W7c6PduKhE6pVy9xu29oHAnv8j7Xfe3/lGmqXFI6T2FuJ0Fc5LR1YFACpbPTnzqVk58tL89mwIfVPyoFQ3iLcb2V6eeloGsEf+LG4bKokDgW4cCM6NKNk1fOp9ycHvoJd3TMXIL/9tUtI1ChMbFguLst6gmutVheuTDuXsL0ZYTikLci
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(396003)(39860400002)(346002)(451199015)(40470700004)(46966006)(36840700001)(2616005)(36860700001)(47076005)(82310400005)(336012)(86362001)(426003)(40480700001)(31696002)(8936002)(40460700003)(36756003)(921005)(356005)(7636003)(316002)(82740400003)(110136005)(5660300002)(2906002)(16576012)(70206006)(70586007)(7416002)(8676002)(31686004)(41300700001)(53546011)(6666004)(26005)(186003)(16526019)(478600001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Dec 2022 09:35:41.6639
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3edb0040-35d7-4669-6130-08dae336ba3d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT063.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6660
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 20/12/22 23:40, Dmitry Osipenko wrote:
> External email: Use caution opening links or attachments
> 
> 
> 20.12.2022 19:02, Sumit Gupta пишет:
>> +static int tegra_emc_icc_get_init_bw(struct icc_node *node, u32 *avg, u32 *peak)
>> +{
>> +     *avg = 0;
>> +     *peak = 0;
>> +
>> +     return 0;
>> +}
> 
> Looks wrong, you should add ICC support to all the drivers first and
> only then enable ICC. I think you added this init_bw() to work around
> the fact that ICC isn't supported by T234 drivers.

If get_bw hook is not added then max freq is set due to 'INT_MAX' below.

  void icc_node_add(struct icc_node *node, struct icc_provider *provider)
  {
    ....
    /* get the initial bandwidth values and sync them with hardware */
    if (provider->get_bw) {
  		provider->get_bw(node, &node->init_avg, &node->init_peak);
    } else {
  		node->init_avg = INT_MAX;
  		node->init_peak = INT_MAX;
  }

So, will have to add the empty functions at least.

  static int tegra_emc_icc_get_init_bw(struct icc_node *node, u32 *avg, 
u32 *peak)
  {
-       *avg = 0;
-       *peak = 0;
-
         return 0;
  }

Support to all the client drivers can't be added at once as there are 
many drivers all with different requirements and handling. This patch 
series is the beginning to add the basic interconnect support in new 
Tegra SoC's. Support for more clients will be added later one by one or 
in batch.
