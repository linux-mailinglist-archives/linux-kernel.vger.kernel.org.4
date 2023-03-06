Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A55BA6ACE0B
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 20:28:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbjCFT2t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 14:28:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbjCFT2q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 14:28:46 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2048.outbound.protection.outlook.com [40.107.244.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEC76DE;
        Mon,  6 Mar 2023 11:28:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f1VlOv5IGXdxJZLfYcmPG/ZewS6qP8L7MEm3ELRmYGCuKxby1gYjFf4u/g8t82la9gXQl6aRtg5JAhjlvnMDoG82TznsnAXBh3ItuEt7CUXNKrEkJLTaRsGjvogKRp+nrPPq+B8HbHI8L72qmTK8g03twXYeGcOfjGh/6YjlrpccHSTBJZ8qr+uEnsInXyaxAKp4TgaQATNQBqlYyKLL5f+iwvH05tdb/v5yVG1dT8kzfEck+Bhn/T7fXEl5PcPHmFj6gtsmYEpzVppff2lkMVDEXXYi5qA84JBZyGMa3e1rAxAsc7mlLjL7HUn1/Diam6e/TcFEFaNrO2amll55yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eLTQjpcInUfjQtAk997dvDS58SXdAsdEarvSAcw8XRE=;
 b=BJjuCDRTcWdATq0sEDDkzstIcJvzqa3Sv1zB+S1HdhJA2BMwEEw3jj/FlH887OjuY2/CbQTnBHlweCrLAi931xn4ecibAMn1yVDyVT9tgJG1S0bJEuedpaR2SrFo4iYEm3cZht+dC+M82rYkcI8IsfD56PkRlH7Ap3StQzjOE2iBgHdX18bRXZAdRI0ud01suyVk9VcNPwuHPZvEQCSjVNEABa9yZcfXsGXwIqIicsi2sOLRrUVCx85tviq+mkxzyTqLSeNMhRIXqmvbzboxHZg7Q8owogj4SbIqGFNsOwdjlP60Tpk74YaYUSu1El9X1Uj3V+3bkhY9vcG0/SfDgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linaro.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eLTQjpcInUfjQtAk997dvDS58SXdAsdEarvSAcw8XRE=;
 b=sZct3P4gQebt8WQf9d2RJqoYB5ARId22B8WxVqYRpS/ibFSfxXV249xOnw7YXJdswkKWBXDOMoV+wKZQCJljUfMa3RJIsG96eK7PCAJa3IqLW3qJkztMm9ElUil+uc0SZb+IoTVWkK0cNtoj6m0M7NVoCW2syCCNW9kEYZG2h7NVRNgKmePe4yAdyjEyAyIjEqomkTwwgCt8gfXXjv3suapU7BGXcmI0aVMfHnmtzXGNPhnZSEqBZXuIBK8pHfcHBic6mYq+5pCtvyvU2SBCOtRTx0Vt8Fre9yo4xsl8mRyFoUSOJ11Sfq9q/n3WHl2212gI26aNSwML8AG69V9sTw==
Received: from BN9PR03CA0308.namprd03.prod.outlook.com (2603:10b6:408:112::13)
 by DM6PR12MB4513.namprd12.prod.outlook.com (2603:10b6:5:2ad::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.28; Mon, 6 Mar
 2023 19:28:42 +0000
Received: from BN8NAM11FT022.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:112:cafe::df) by BN9PR03CA0308.outlook.office365.com
 (2603:10b6:408:112::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.28 via Frontend
 Transport; Mon, 6 Mar 2023 19:28:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN8NAM11FT022.mail.protection.outlook.com (10.13.176.112) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6156.19 via Frontend Transport; Mon, 6 Mar 2023 19:28:41 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Mon, 6 Mar 2023
 11:28:26 -0800
Received: from [10.41.21.79] (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Mon, 6 Mar 2023
 11:28:21 -0800
Message-ID: <841dd7b5-98b2-e1a5-2387-a48d7abf4f38@nvidia.com>
Date:   Tue, 7 Mar 2023 00:58:19 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [Patch v1 01/10] memory: tegra: add interconnect support for DRAM
 scaling in Tegra234
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <treding@nvidia.com>, <dmitry.osipenko@collabora.com>,
        <viresh.kumar@linaro.org>, <rafael@kernel.org>,
        <jonathanh@nvidia.com>, <robh+dt@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>
CC:     <sanjayc@nvidia.com>, <ksitaraman@nvidia.com>, <ishah@nvidia.com>,
        <bbasu@nvidia.com>, Sumit Gupta <sumitg@nvidia.com>
References: <20221220160240.27494-1-sumitg@nvidia.com>
 <20221220160240.27494-2-sumitg@nvidia.com>
 <b4777025-0220-b1e4-f6f3-00d75ec8f0be@linaro.org>
From:   Sumit Gupta <sumitg@nvidia.com>
In-Reply-To: <b4777025-0220-b1e4-f6f3-00d75ec8f0be@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT022:EE_|DM6PR12MB4513:EE_
X-MS-Office365-Filtering-Correlation-Id: faf5ffa6-fff2-4530-dacd-08db1e78fe7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JrDUCTXBgdx9cNy3VoPBa5uX/q8E3CT5CPjfdWnQJraDV2O2Lg8tOjdcuuh7Ddpr2MFIzXeD5LuO81FiHQYldzxyMBV+EQ0TLUOx1pjFdlm+leCZL4GtquuncFe8/mV6KIpqMPz58XWEDdLYYJrmURFjk0S5pA3qyYW1fBftoNdcCGOpgjZOvNSrdHhhnKo6XRQQ5NrrBsLMhHZmqSS4ii0BYE0ULL7wgrBWyaj7Mt4VzpxhsPO3oMv0IxSsS561Z+ugm8JGXi8lsl9DjWjTBv0EQ9e3s7l7X1DRhiHWIFRMSh3VwhmsmG1Px/yAtkmWuo11dDCXugCDJloxzTJWneQIBIaz16QKvZvzz6ovPQSKbSUd9Arm0ZYy+oziWiIlqcHFH4qIUo1ygZ/Zqd5k8konGdhz5TeYlM9+CoQAm7V22kcoCCIk6AAE8QWg86cGLpP+oU4SWAPGp+pLAoqYh6ynPWdMPDi5C5Uc5Ib4vN4uY0Wc0Nzgn+ItcAmu1t+g0IpTCuSj59aDWj756x8VgHKpXbhi2iSNhdbH0F+Bp0olmrHUVXgSZvEG50OJyjhTdw4raSJbLpIih+nNwsFi4xWKBH8qV7MbkUYbq4m+4dRl7BlVLpVeo0CHsakUV3/9hzRNbwUwsEbAqDjI85tDfbptQFv8OE9P4cNvJu3mSd84j9nt7GNQbNcV/yfCp+zyE32c3Si9V3r8AfOLrgPoq5U/rSx+hOH1J5FoRKXEB1HN6QdTDbmCs+RqUSLkU1ih
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(346002)(376002)(39860400002)(396003)(136003)(451199018)(36840700001)(40470700004)(46966006)(110136005)(54906003)(36756003)(316002)(16576012)(83380400001)(40480700001)(82310400005)(86362001)(31696002)(336012)(31686004)(16526019)(40460700003)(186003)(2906002)(82740400003)(5660300002)(4326008)(70206006)(70586007)(8936002)(36860700001)(41300700001)(8676002)(53546011)(478600001)(47076005)(26005)(107886003)(2616005)(426003)(356005)(921005)(7636003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2023 19:28:41.5464
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: faf5ffa6-fff2-4530-dacd-08db1e78fe7b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT022.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4513
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 22/12/22 17:02, Krzysztof Kozlowski wrote:
> External email: Use caution opening links or attachments
> 
> 
> On 20/12/2022 17:02, Sumit Gupta wrote:
>> Adding Interconnect framework support to dynamically set the DRAM
>> bandwidth from different clients. Both the MC and EMC drivers are
>> added as ICC providers. The path for any request will be:
>>   MC-Client[1-n] -> MC -> EMC -> EMEM/DRAM
>>
>> MC clients will request for bandwidth to the MC driver which will
>> pass the tegra icc node having current request info to the EMC driver.
>> The EMC driver will send the BPMP Client ID, Client type and bandwidth
>> request info to the BPMP-FW where the final DRAM freq for achieving the
>> requested bandwidth is set based on the passed parameters.
>>
>> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
>> ---
>>   drivers/memory/tegra/mc.c           |  18 ++-
>>   drivers/memory/tegra/tegra186-emc.c | 166 ++++++++++++++++++++++++++++
>>   drivers/memory/tegra/tegra234.c     | 101 ++++++++++++++++-
>>   include/soc/tegra/mc.h              |   7 ++
>>   include/soc/tegra/tegra-icc.h       |  72 ++++++++++++
>>   5 files changed, 362 insertions(+), 2 deletions(-)
>>   create mode 100644 include/soc/tegra/tegra-icc.h
>>
>> diff --git a/drivers/memory/tegra/mc.c b/drivers/memory/tegra/mc.c
>> index 592907546ee6..ff887fb03bce 100644
>> --- a/drivers/memory/tegra/mc.c
>> +++ b/drivers/memory/tegra/mc.c
>> @@ -17,6 +17,7 @@
>>   #include <linux/sort.h>
>>
>>   #include <soc/tegra/fuse.h>
>> +#include <soc/tegra/tegra-icc.h>
>>
>>   #include "mc.h"
>>
>> @@ -779,6 +780,7 @@ const char *const tegra_mc_error_names[8] = {
>>    */
>>   static int tegra_mc_interconnect_setup(struct tegra_mc *mc)
>>   {
>> +     struct tegra_icc_node *tnode;
>>        struct icc_node *node;
>>        unsigned int i;
>>        int err;
>> @@ -792,7 +794,11 @@ static int tegra_mc_interconnect_setup(struct tegra_mc *mc)
>>        mc->provider.data = &mc->provider;
>>        mc->provider.set = mc->soc->icc_ops->set;
>>        mc->provider.aggregate = mc->soc->icc_ops->aggregate;
>> -     mc->provider.xlate_extended = mc->soc->icc_ops->xlate_extended;
>> +     mc->provider.get_bw = mc->soc->icc_ops->get_bw;
>> +     if (mc->soc->icc_ops->xlate)
>> +             mc->provider.xlate = mc->soc->icc_ops->xlate;
>> +     if (mc->soc->icc_ops->xlate_extended)
>> +             mc->provider.xlate_extended = mc->soc->icc_ops->xlate_extended;
>>
>>        err = icc_provider_add(&mc->provider);
>>        if (err)
>> @@ -814,6 +820,10 @@ static int tegra_mc_interconnect_setup(struct tegra_mc *mc)
>>                goto remove_nodes;
>>
>>        for (i = 0; i < mc->soc->num_clients; i++) {
>> +             tnode = kzalloc(sizeof(*tnode), GFP_KERNEL);
>> +             if (!tnode)
>> +                     return -ENOMEM;
>> +
>>                /* create MC client node */
>>                node = icc_node_create(mc->soc->clients[i].id);
>>                if (IS_ERR(node)) {
>> @@ -828,6 +838,12 @@ static int tegra_mc_interconnect_setup(struct tegra_mc *mc)
>>                err = icc_link_create(node, TEGRA_ICC_MC);
>>                if (err)
>>                        goto remove_nodes;
>> +
>> +             node->data = tnode;
> 
> Where is it freed?
> 
> 
> (...)
> 
Have removed 'struct tegra_icc_node' in v2. Instead 'node->data'
now points to the entry of MC client in the static table 
'tegra234_mc_clients' as below. So, the old alloc of 'struct 
tegra_icc_node' is not required now.

  + node->data = (char *)&(mc->soc->clients[i]);

>>
>>   struct tegra_mc_ops {
>> @@ -238,6 +243,8 @@ struct tegra_mc {
>>        struct {
>>                struct dentry *root;
>>        } debugfs;
>> +
>> +     struct tegra_icc_node *curr_tnode;
>>   };
>>
>>   int tegra_mc_write_emem_configuration(struct tegra_mc *mc, unsigned long rate);
>> diff --git a/include/soc/tegra/tegra-icc.h b/include/soc/tegra/tegra-icc.h
>> new file mode 100644
>> index 000000000000..3855d8571281
>> --- /dev/null
>> +++ b/include/soc/tegra/tegra-icc.h
> 
> Why not in linux?
> 
Moved the file to 'include/linux/tegra-icc.h' in v2.

>> @@ -0,0 +1,72 @@
>> +/* SPDX-License-Identifier: GPL-2.0-only */
>> +/*
>> + * Copyright (C) 2022-2023 NVIDIA CORPORATION.  All rights reserved.
>> + */
>> +
>> +#ifndef MEMORY_TEGRA_ICC_H
> 
> This does not match the path/name.
> 
Have changed path name to below in v2.

   +#ifndef LINUX_TEGRA_ICC_H
   +#define LINUX_TEGRA_ICC_H

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
>> +
>> +struct tegra_icc_node {
>> +     struct icc_node *node;
>> +     struct tegra_mc *mc;
>> +     u32 bpmp_id;
>> +     u32 type;
>> +};
>> +
>> +/* ICC ID's for MC client's used in BPMP */
>> +#define TEGRA_ICC_BPMP_DEBUG         1
>> +#define TEGRA_ICC_BPMP_CPU_CLUSTER0  2
>> +#define TEGRA_ICC_BPMP_CPU_CLUSTER1  3
>> +#define TEGRA_ICC_BPMP_CPU_CLUSTER2  4
>> +#define TEGRA_ICC_BPMP_GPU           5
>> +#define TEGRA_ICC_BPMP_CACTMON               6
>> +#define TEGRA_ICC_BPMP_DISPLAY               7
>> +#define TEGRA_ICC_BPMP_VI            8
>> +#define TEGRA_ICC_BPMP_EQOS          9
>> +#define TEGRA_ICC_BPMP_PCIE_0                10
>> +#define TEGRA_ICC_BPMP_PCIE_1                11
>> +#define TEGRA_ICC_BPMP_PCIE_2                12
>> +#define TEGRA_ICC_BPMP_PCIE_3                13
>> +#define TEGRA_ICC_BPMP_PCIE_4                14
>> +#define TEGRA_ICC_BPMP_PCIE_5                15
>> +#define TEGRA_ICC_BPMP_PCIE_6                16
>> +#define TEGRA_ICC_BPMP_PCIE_7                17
>> +#define TEGRA_ICC_BPMP_PCIE_8                18
>> +#define TEGRA_ICC_BPMP_PCIE_9                19
>> +#define TEGRA_ICC_BPMP_PCIE_10               20
>> +#define TEGRA_ICC_BPMP_DLA_0         21
>> +#define TEGRA_ICC_BPMP_DLA_1         22
>> +#define TEGRA_ICC_BPMP_SDMMC_1               23
>> +#define TEGRA_ICC_BPMP_SDMMC_2               24
>> +#define TEGRA_ICC_BPMP_SDMMC_3               25
>> +#define TEGRA_ICC_BPMP_SDMMC_4               26
>> +#define TEGRA_ICC_BPMP_NVDEC         27
>> +#define TEGRA_ICC_BPMP_NVENC         28
>> +#define TEGRA_ICC_BPMP_NVJPG_0               29
>> +#define TEGRA_ICC_BPMP_NVJPG_1               30
>> +#define TEGRA_ICC_BPMP_OFAA          31
>> +#define TEGRA_ICC_BPMP_XUSB_HOST     32
>> +#define TEGRA_ICC_BPMP_XUSB_DEV              33
>> +#define TEGRA_ICC_BPMP_TSEC          34
>> +#define TEGRA_ICC_BPMP_VIC           35
>> +#define TEGRA_ICC_BPMP_APE           36
>> +#define TEGRA_ICC_BPMP_APEDMA                37
>> +#define TEGRA_ICC_BPMP_SE            38
>> +#define TEGRA_ICC_BPMP_ISP           39
>> +#define TEGRA_ICC_BPMP_HDA           40
>> +#define TEGRA_ICC_BPMP_VIFAL         41
>> +#define TEGRA_ICC_BPMP_VI2FAL                42
>> +#define TEGRA_ICC_BPMP_VI2           43
>> +#define TEGRA_ICC_BPMP_RCE           44
>> +#define TEGRA_ICC_BPMP_PVA           45
>> +
>> +#endif /* MEMORY_TEGRA_ICC_H */
> 
> Best regards,
> Krzysztof
> 
