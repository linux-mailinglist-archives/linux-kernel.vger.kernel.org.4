Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E37E6697AB
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 13:47:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241815AbjAMMqZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 07:46:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242080AbjAMMo1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 07:44:27 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on20606.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe59::606])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48D0E1AD9A;
        Fri, 13 Jan 2023 04:36:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VpfV9WoTL4jZ/6aGduq7eS7qA3tBDYNzr3rlcauNxVdrCTXAuWK4DHu68Nu3Z3L6HEkI3Zm3iCY1Oz99DAmowpwZN0ZCnkRQBE/BbGadjES60qDCzRnbZ73GKlXpeF12H1TiDLizLHCIvmgqKsW2S2WP/Tf4lysDOM4s0HaoAJyKN9eHCwPfo3s6EsPbu4raF6zO0kVaOH0nDxEnhLAVbVrEJfdQNRiGSQqe8zufEpI1ja9iUjnDQzVQiqjZyVaGrzWrJvSUT/yGJaZpgNmBqSTVFwaEF1p0IJal3aGU7WM+UNLtgj785LbvkVeAA4m5wMnMBKtc5B805Lt+VAdCbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7XcIP4uToEeFUPH7doJuVPrNpjN5WLvDBi6ZQFJcXZA=;
 b=dwPIgsi3qHy6TZbSzohJj0Mj0l9XS91ck1ATjVyOJmstLhGvs0Srkc3Vov6L59BhxJMrAPkYH+A+kqA3VZmA/OAWJjCrHl2Zx7J2r+6SVtMGxOE7a0pzyvAEJtk8q9wHcgM6p8rVVir7fOCnUUptrKqzYQA0Zln+yAfIxXSEBbx0T6bTB7LSgQ/Stk9lNlL/gg1iIv02If2t5x0gaImJd1SfVKUouBZIormQExqKos8Nr1GQ+fIvWyY75395gRJHiKXvpoC8eeWU6LfQl1oeB1O+LbX/tMENvOL75m8vmfMuk8kEc1k+yxPYoQyzwxuq1S2hG/zHa26K33TVwac0pA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7XcIP4uToEeFUPH7doJuVPrNpjN5WLvDBi6ZQFJcXZA=;
 b=YGI47duUX0FC8HmppkVqCD9vJV2+D4ZWKMNxXsvETh75zDqNgdR5+5u5emSXBkLIqjM508UImZakGV13S14OD1hm+guPUukQqgD26Z6ZNHQFeAdzDkx8uwiOOXTYSbRcJjkc4AkMFXjq36PUaSIntVO5L/n8h8kYuetCaDu0vb/vGJd440i9dsvYKJFvJOBwzFX7hpsRdQSFAgfcBqYTP7JCyf/ZRDsTsganwCrqg6qxobg4ueEUyXzkRhveZvqzuNYAv7Yxy7HjY/vrs299m57o8tq+6Xca+Gz0ehyYH5hzZzh2fZGVsDD6IAzdH2vWtIf5dl+ZkxMkbXl4xPG4Rg==
Received: from MW4PR04CA0217.namprd04.prod.outlook.com (2603:10b6:303:87::12)
 by IA0PR12MB7532.namprd12.prod.outlook.com (2603:10b6:208:43e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Fri, 13 Jan
 2023 12:35:36 +0000
Received: from CO1NAM11FT041.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:87:cafe::33) by MW4PR04CA0217.outlook.office365.com
 (2603:10b6:303:87::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.16 via Frontend
 Transport; Fri, 13 Jan 2023 12:35:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1NAM11FT041.mail.protection.outlook.com (10.13.174.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6002.13 via Frontend Transport; Fri, 13 Jan 2023 12:35:36 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Fri, 13 Jan
 2023 04:35:22 -0800
Received: from [10.41.21.79] (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Fri, 13 Jan
 2023 04:35:18 -0800
Message-ID: <5fe5cd77-c82c-23f5-800f-16a7beebf26a@nvidia.com>
Date:   Fri, 13 Jan 2023 18:05:15 +0530
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
 <62fc4a96-bab8-4d43-5278-3375e34431e7@gmail.com>
 <791f5e52-6035-2501-7bc2-2795e43ae1c1@gmail.com>
From:   Sumit Gupta <sumitg@nvidia.com>
In-Reply-To: <791f5e52-6035-2501-7bc2-2795e43ae1c1@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT041:EE_|IA0PR12MB7532:EE_
X-MS-Office365-Filtering-Correlation-Id: b3f7d983-9be5-490a-3cd4-08daf562abaa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: A1cgxvhT0X75Hi916TMTsnSNc4VZR0wzA4T6PT9LIJBxAitAj5znUuiJSe3k+gS6R6Jv2GejH/2X5BOBWnnywYHb3OUYCExjs5bpyEVrBlPo9yvaxzv6QGMLPcWBr6GyE8ACQN7pcHFatI007sr6C6Z4Tmj3BYAYRRXRL1046Bl1rRxoeVgIQ2HbKpw6OcNKs5galXLXitmrI8B3UlXg6XwjvxdeH1VIKbSGtbbHL8ytzwL3+u1gedkf0UVNV1ZZ27TZpuVjTz345U3LgHlJaXdXLhBxWPVCBd7DPR6WVFtOK9oiyGkppA5IK5mw3yZnesToASVvGjscflxZn7/Az9ZYkz6mLWX6I4aYjtxDDhzTusoSfOVuAeZs164Qyes8rxQlZpeaiNl5ZWT5czCV3Tsq3fAK7D7a84dkE04jJO918fL1hp1QoMFS83cGg/zgIoSB+bayprMqoJihj+letQ7OcYie5ZT7139xBtCuKTywzn6i0acllCs2i1AKh7tta8rVvQS6VEFB5nbR0xSTm8pxeVo+FfyAczIq8iBbiln8gP4iWcD1SwBVlgYZdcgS+jrMBDNI7XajHShFOWMCyyTZ2v6QKkehYFuFABoPflrhf4z+keo9xmUPFgx0R8zZ9q6mQC/Pm/n8WPeS9chSep9f0s2i4z78A+OIgZyjKQfO16RCvbQJyq6L4muks/i6BETNtCHwUdVO/Tf/36TQE4PkWIUUUDFzHEptbZKT4cu5gVSww9WJZnXkFbRmqQZ1
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(396003)(346002)(136003)(376002)(39860400002)(451199015)(46966006)(40470700004)(36840700001)(16576012)(36860700001)(82740400003)(107886003)(6666004)(31686004)(53546011)(921005)(7636003)(356005)(2906002)(5660300002)(478600001)(7416002)(2616005)(16526019)(86362001)(186003)(26005)(316002)(40480700001)(40460700003)(8936002)(36756003)(82310400005)(83380400001)(8676002)(31696002)(47076005)(426003)(41300700001)(110136005)(336012)(70586007)(70206006)(54906003)(4326008)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2023 12:35:36.0913
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b3f7d983-9be5-490a-3cd4-08daf562abaa
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT041.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7532
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,SPF_HELO_PASS,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 22/12/22 21:26, Dmitry Osipenko wrote:
> External email: Use caution opening links or attachments
> 
> 
> 21.12.2022 22:20, Dmitry Osipenko пишет:
>> 20.12.2022 19:02, Sumit Gupta пишет:
>>> +static int tegra_emc_icc_set_bw(struct icc_node *src, struct icc_node *dst)
>>> +{
>>> +    struct tegra186_emc *emc = to_tegra186_emc(dst->provider);
>>> +    struct tegra_mc *mc = dev_get_drvdata(emc->dev->parent);
>>> +    struct mrq_bwmgr_int_request bwmgr_req = { 0 };
>>> +    struct mrq_bwmgr_int_response bwmgr_resp = { 0 };
>>> +    struct tegra_icc_node *tnode = mc->curr_tnode;
>>> +    struct tegra_bpmp_message msg;
>>> +    int ret = 0;
>>> +
>>> +    /*
>>> +     * Same Src and Dst node will happen during boot from icc_node_add().
>>> +     * This can be used to pre-initialize and set bandwidth for all clients
>>> +     * before their drivers are loaded. We are skipping this case as for us,
>>> +     * the pre-initialization already happened in Bootloader(MB2) and BPMP-FW.
>>> +     */
>>> +    if (src->id == dst->id)
>>> +            return 0;
>>> +
>>> +    if (mc->curr_tnode->type == TEGRA_ICC_NISO)
>>
>> The mc->curr_tnode usage looks suspicious, why you can't use src node?
>>
> 
> This function sets memory BW for a memory client and not for EMC.
> Apparently, you should move the BW setting to tegra234_mc_icc_set() and
> then tegra_emc_icc_set_bw() will be a noop.
> 
Yes, will move this code to set_bw() in MC driver. The set_bw call in 
EMC will be a dummy function after change.
This change will also help to remove "struct tegra_icc_node 
*curr_tnode;" from "struct tegra_mc" which is used for passing data 
between MC and EMC drivers to transfer to BPMP.

static int tegra_emc_icc_set_bw(struct icc_node *src, struct icc_node *dst)
{
         return 0;
}
