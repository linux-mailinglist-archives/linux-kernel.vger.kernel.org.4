Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47E0C63860D
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 10:25:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbiKYJZA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 04:25:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbiKYJY6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 04:24:58 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2077.outbound.protection.outlook.com [40.107.93.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A03BE275F7;
        Fri, 25 Nov 2022 01:24:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lzlRA/MXwTVOoeF9MWtdJovWW+C1bueRWS/TIR/D2NHZW+DdciNAwBB6pjQb+uoO05U7pq+g/WIJg3OKYq3gvrPvwvh7hUYR0d6X7m5n5Om0RqyGuFaCQs2TxRJdaNnnnWagk9LDeI4sfG97q72nGDgoZO3GnGebHkYWZ65P3IAeOKvn6qXM9JfXkkYyG800ZInBfd5wKavpbKVttU9nKY/JiUQhnFYP8MQ/MKvMRSw787YZe+PIw4G+p9g02mf6tLHaqaC80Bztr2PPmBR7VbslxOKV5aFMxZNjdTh3z29vE2vc8+ICdpMY2Mb7DfClhaAfhkoj/yBH0IFs6Ca3xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jj4NVYZwSw9NqFsGFP2qaH1sOQWciz6pFjl3agybzcE=;
 b=fXiEPNlnrVzsazUwVcPh9LgJzbp04gsszqhjBIwWusyRGRaM2z7clhhVnsFh6aZNK41atqGNn08a1hWfbXnXA3F0Ps4OH764euZ7AfCnTLL1S+Ziw9ZiHVqh0SGQrQFbxjhWxJo9EnAMjO9JqfelNiGpQGqR+U4HluNE375e4eta6ml5gUwkFjDOF8O08k59XxDzydhC7LSnkuykMJNs7etGEkrbke348fbtPDF6+xf1yH4GnzVR82i4v5UhsyBLV1TqtjQJ0lIOQL6PI2q5bvzRZtQkgG+YEWWjctOpIb5yVdNKSthBpYGyJkHzJL1+A47lbznh/ysWL3UGNRHfJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jj4NVYZwSw9NqFsGFP2qaH1sOQWciz6pFjl3agybzcE=;
 b=0K0u/gNvJiNE9GiID+V1LtWagBy0PsdRYr8z6CnzVPxMvrRZ4Lq4wHdWLOuR7+U672XmtylWUHrE6DM8S2zJbGupamHHATBoY5k6W5x+A0/vkng98UEsnFALp3x0xKfxJ5lcolCiBXqMQ9E8uGelQHL6KYKXyGdg9K1xXWL62Gg=
Received: from DS7PR05CA0027.namprd05.prod.outlook.com (2603:10b6:5:3b9::32)
 by IA0PR12MB7505.namprd12.prod.outlook.com (2603:10b6:208:443::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.11; Fri, 25 Nov
 2022 09:24:54 +0000
Received: from DM6NAM11FT086.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b9:cafe::ac) by DS7PR05CA0027.outlook.office365.com
 (2603:10b6:5:3b9::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.17 via Frontend
 Transport; Fri, 25 Nov 2022 09:24:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT086.mail.protection.outlook.com (10.13.173.75) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5834.8 via Frontend Transport; Fri, 25 Nov 2022 09:24:54 +0000
Received: from [10.254.241.50] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 25 Nov
 2022 03:24:27 -0600
Message-ID: <6ed85ced-1d85-5620-881e-943fa4bc71d9@amd.com>
Date:   Fri, 25 Nov 2022 10:24:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v11 4/6] firmware: xilinx: Add shutdown/wakeup APIs
Content-Language: en-US
To:     Tanmay Shah <tanmay.shah@amd.com>, <andersson@kernel.org>,
        <mathieu.poirier@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>
CC:     <bill.mills@linaro.org>, <linux-remoteproc@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Ben Levinsky <ben.levinsky@amd.com>
References: <20221114233940.2096237-1-tanmay.shah@amd.com>
 <20221114233940.2096237-5-tanmay.shah@amd.com>
From:   Michal Simek <michal.simek@amd.com>
In-Reply-To: <20221114233940.2096237-5-tanmay.shah@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT086:EE_|IA0PR12MB7505:EE_
X-MS-Office365-Filtering-Correlation-Id: b0adc978-6a31-4911-23d1-08dacec6e9a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ebgLXcnjyIvK2y9GUuVjLO2EZmg5bVl79iJCN+trvJEspJ5dwdarDZLAFE2B8pBFY1TANwUaT69FpGEk+70zTtrrxEt2YnfAWjROjoJ5VAOs/gW9mivPmegdvtoNSJ9aaC69b8zu5ObqUZ0I0pogwKRko4zCAIH3MmIfTK+nRDTJl2qQzGZ0m0gYjq7c0Iu6Z5wll2rvHAHu7avxTOKc2PV7usoaTrEAXQCuM+SlFjYv8gu6zQ11IWUYuFDmzWKMq5IZJCnxuX01Bbf4Xwquq4RqwzC3NJ/+OKjkWhQtXRqmLWMoDiHyvbVmS6HCJv+7QtooTS0L65oZ0bUZrVKRxs4wMDaGMHnIDiUb5HY+JENKQsaI2LMcevt953zB0A93JXccU0T9JP2R3RdhRqI6Sa34a1oh68mK2QQ442WPieByRnrKvEKHicPWwWjfqwnAHObsbJmQZF9LpvySXA5td1sMCoRCLhCcwXelyDu+r604yZ+1qoAFMrjPwG26nA1aM4ObG2SfEHNJ2BHx8sKVj9xSAKo0FlxxymYh7/f280KR2v4Ruij0DMANgdonQF7vSNHFv+7O+AxrzgXZXn9UZFJ5jSNH32V47SJlU0GZJUFDE3PNWtAa4YyRN5IDIpyyVvAB1xGx3mzF2gk9Prx1R5jpB19b4ceIYxpZnYmU1JS01DHSGbMa0SMWY/thk0I3u0tboYNk4f5VDQqMQP+9YsqNWPpwK6HXFIPCuQG/U+CvzrVpdL9dtnASB5EBm5X7WRUz5xZlWF1AUbu/+BOGFg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(136003)(396003)(346002)(376002)(39860400002)(451199015)(46966006)(40470700004)(36840700001)(336012)(44832011)(47076005)(83380400001)(36756003)(8676002)(5660300002)(316002)(54906003)(26005)(40460700003)(426003)(70206006)(4326008)(478600001)(2616005)(110136005)(16576012)(41300700001)(8936002)(16526019)(82310400005)(356005)(70586007)(81166007)(53546011)(186003)(36860700001)(82740400003)(2906002)(40480700001)(6666004)(31696002)(31686004)(86362001)(36900700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2022 09:24:54.4129
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b0adc978-6a31-4911-23d1-08dacec6e9a2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT086.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7505
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/15/22 00:39, Tanmay Shah wrote:
> From: Ben Levinsky <ben.levinsky@amd.com>
> 
> Add shutdown/wakeup a resource eemi operations to shutdown
> or bringup a resource.
> 
> Note alignment of args matches convention of other fn's in this file.
> The reason being that the long fn name results in aligned args that
> otherwise go over 80 chars so shift right to avoid this
> 
> Signed-off-by: Ben Levinsky <ben.levinsky@amd.com>
> Signed-off-by: Tanmay Shah <tanmay.shah@amd.com>
> ---
> 
> Changes in v11:
>    - Rebase on latest rproc-next branch and resolve merge conflicts
> 
> Changes in v10:
>    - None
> 
> Changes in v9:
>    - None
> 
> Changes in v8:
>    - None
> 
> Changes in v7:
>    - None
> 
> Changes in v6:
>    - None
> 
> Changes in v5:
>    - None
> 
> Changes in v4:
>    - None
> 
> Changes in v3:
>    - None
> 
>   drivers/firmware/xilinx/zynqmp.c     | 35 ++++++++++++++++++++++++++++
>   include/linux/firmware/xlnx-zynqmp.h | 23 ++++++++++++++++++
>   2 files changed, 58 insertions(+)
> 
> diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
> index ff5cabe70a2b..1865e43ed7e7 100644
> --- a/drivers/firmware/xilinx/zynqmp.c
> +++ b/drivers/firmware/xilinx/zynqmp.c
> @@ -1159,6 +1159,41 @@ int zynqmp_pm_release_node(const u32 node)
>   }
>   EXPORT_SYMBOL_GPL(zynqmp_pm_release_node);
>   
> +/**
> + * zynqmp_pm_force_pwrdwn - PM call to request for another PU or subsystem to
> + *             be powered down forcefully
> + * @node:  Node ID of the targeted PU or subsystem
> + * @ack:   Flag to specify whether acknowledge is requested
> + *
> + * Return: status, either success or error+reason
> + */
> +int zynqmp_pm_force_pwrdwn(const u32 node,
> +			   const enum zynqmp_pm_request_ack ack)
> +{
> +	return zynqmp_pm_invoke_fn(PM_FORCE_POWERDOWN, node, ack, 0, 0, NULL);
> +}
> +EXPORT_SYMBOL_GPL(zynqmp_pm_force_pwrdwn);
> +
> +/**
> + * zynqmp_pm_request_wake - PM call to wake up selected master or subsystem
> + * @node:  Node ID of the master or subsystem
> + * @set_addr:  Specifies whether the address argument is relevant
> + * @address:   Address from which to resume when woken up
> + * @ack:   Flag to specify whether acknowledge requested
> + *
> + * Return: status, either success or error+reason
> + */
> +int zynqmp_pm_request_wake(const u32 node,
> +			   const bool set_addr,
> +			   const u64 address,
> +			   const enum zynqmp_pm_request_ack ack)
> +{
> +	/* set_addr flag is encoded into 1st bit of address */
> +	return zynqmp_pm_invoke_fn(PM_REQUEST_WAKEUP, node, address | set_addr,
> +				   address >> 32, ack, NULL);
> +}
> +EXPORT_SYMBOL_GPL(zynqmp_pm_request_wake);
> +
>   /**
>    * zynqmp_pm_set_requirement() - PM call to set requirement for PM slaves
>    * @node:		Node ID of the slave
> diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
> index bdbf855b5eef..ad3f2bd0c470 100644
> --- a/include/linux/firmware/xlnx-zynqmp.h
> +++ b/include/linux/firmware/xlnx-zynqmp.h
> @@ -12,6 +12,7 @@
>   
>   #ifndef __FIRMWARE_ZYNQMP_H__
>   #define __FIRMWARE_ZYNQMP_H__
> +#include <linux/types.h>
>   
>   #include <linux/err.h>
>   
> @@ -87,6 +88,8 @@ enum pm_api_cb_id {
>   enum pm_api_id {
>   	PM_GET_API_VERSION = 1,
>   	PM_REGISTER_NOTIFIER = 5,
> +	PM_FORCE_POWERDOWN = 8,
> +	PM_REQUEST_WAKEUP = 10,
>   	PM_SYSTEM_SHUTDOWN = 12,
>   	PM_REQUEST_NODE = 13,
>   	PM_RELEASE_NODE = 14,
> @@ -521,6 +524,12 @@ int zynqmp_pm_is_function_supported(const u32 api_id, const u32 id);
>   int zynqmp_pm_set_feature_config(enum pm_feature_config_id id, u32 value);
>   int zynqmp_pm_get_feature_config(enum pm_feature_config_id id, u32 *payload);
>   int zynqmp_pm_register_sgi(u32 sgi_num, u32 reset);
> +int zynqmp_pm_force_pwrdwn(const u32 target,
> +			   const enum zynqmp_pm_request_ack ack);
> +int zynqmp_pm_request_wake(const u32 node,
> +			   const bool set_addr,
> +			   const u64 address,
> +			   const enum zynqmp_pm_request_ack ack);
>   int zynqmp_pm_set_sd_config(u32 node, enum pm_sd_config_type config, u32 value);
>   int zynqmp_pm_set_gem_config(u32 node, enum pm_gem_config_type config,
>   			     u32 value);
> @@ -795,6 +804,20 @@ static inline int zynqmp_pm_register_sgi(u32 sgi_num, u32 reset)
>   	return -ENODEV;
>   }
>   
> +static inline int zynqmp_pm_force_pwrdwn(const u32 target,
> +					 const enum zynqmp_pm_request_ack ack)
> +{
> +	return -ENODEV;
> +}
> +
> +static inline int zynqmp_pm_request_wake(const u32 node,
> +					 const bool set_addr,
> +					 const u64 address,
> +					 const enum zynqmp_pm_request_ack ack)
> +{
> +	return -ENODEV;
> +}
> +
>   static inline int zynqmp_pm_set_sd_config(u32 node,
>   					  enum pm_sd_config_type config,
>   					  u32 value)

Acked-by: Michal Simek <michal.simek@amd.com>

Thanks,
Michal
