Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25E0C60CCF7
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 15:06:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231484AbiJYNGc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 09:06:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232747AbiJYNF6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 09:05:58 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2077.outbound.protection.outlook.com [40.107.220.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 286E8183AC;
        Tue, 25 Oct 2022 06:05:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W15xHwSJ3zjx62VwCdvrBfHp64H4MJi242V1kfvRfKsVi2L2gDKYs59Ya/ClscXS99qIKoFWLqSsSS3j6/Cb9Gy8PB5sQ924tuqQW+N8b3bdOEy5XCH9YvOAwbegHv2B+JiE3LSiO72vWvOrTT0tjfnMzLDHvTIOvWpvpvbWDymEwKfVj6VPgZfnBdaJD/EzGDafumc6BZpRXV9obnsyqCosapKajfB5mYxrImHBX5nIcPIWxoqQqd4sGA6GeCq0QohtMkA4GmdGGAd21fACG14712y1l1M6EPsFM9+xfWHbKRZcztImHwFmq2N3KzTpO7umpokCPjloPnzvUkVtrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gGdStu+y36WfiCa4dIF+Ub41DLAec67SIG1ZQm78Tgs=;
 b=SU6gDf4+rasRSTqSeczrY6/SlMeSyMPZdIlOqZm6jzZ+iMIoPlNQSHPFkcAJsBtrLbjSxMENCoRAjzsyoSQOVBA1NlzEi5pAGLFfX62+oPCe5hUnYsp0OMCCoJ60CG8Qd6kz2k07ovIbK3HlX74p+S+OboYlLqeyyLgW9Dfe72BH+mQozge1BKLFvYFRmeF0kZ59djewuO3MM0wIPMuzNWhrSO/prdlW6BaflQmWGwYgMaNQXQeWetrvnH1WLwuN7GjweRLCZHiu+YiP1Lwdamh4QBWgOsnMo9KwGDLMqX2n0Th+oBPIa3JpfQxje7GSGmYhbh+MdprXCa6aDDKH7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gGdStu+y36WfiCa4dIF+Ub41DLAec67SIG1ZQm78Tgs=;
 b=cntmKzCB17J8cVdVMOLb1/2+jwm0Rg3vvv52c8PCQVhUtMaXIcKSSsNn6t540IoNTLwwgBaodLo9RNfj7TDkfRcYIljIl1MYjMJ9B4BN/7hYsMvPOI2JXMVj43jzCaoudGt1Jo+iiQAqVqolGTgZiBmNBULfeKQzsnJQBROMA4s=
Received: from BN9PR03CA0676.namprd03.prod.outlook.com (2603:10b6:408:10e::21)
 by SJ1PR12MB6027.namprd12.prod.outlook.com (2603:10b6:a03:48a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.29; Tue, 25 Oct
 2022 13:05:39 +0000
Received: from BN8NAM11FT099.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10e:cafe::10) by BN9PR03CA0676.outlook.office365.com
 (2603:10b6:408:10e::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.27 via Frontend
 Transport; Tue, 25 Oct 2022 13:05:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT099.mail.protection.outlook.com (10.13.177.197) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5746.16 via Frontend Transport; Tue, 25 Oct 2022 13:05:38 +0000
Received: from [10.254.241.52] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 25 Oct
 2022 08:05:35 -0500
Message-ID: <f7b2ca47-5879-1023-4d98-cae9ba109ee2@amd.com>
Date:   Tue, 25 Oct 2022 15:05:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v10 4/6] firmware: xilinx: Add shutdown/wakeup APIs
Content-Language: en-US
To:     Tanmay Shah <tanmay.shah@amd.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     <linux-remoteproc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        "Ben Levinsky" <ben.levinsky@amd.com>
References: <20221011212501.2661003-1-tanmay.shah@amd.com>
 <20221011212501.2661003-5-tanmay.shah@amd.com>
From:   Michal Simek <michal.simek@amd.com>
In-Reply-To: <20221011212501.2661003-5-tanmay.shah@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT099:EE_|SJ1PR12MB6027:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f79624c-92a8-4919-d567-08dab6899d1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: smuyEWe+KykTZKvZ6v7KiX4mRWWnG8cTAWxLnQ6kdmm8QRf2HWYSqPizrdi03AYwnDGHK/yTOonAcuBO47werKuL/RRfPJFX/HtaBTk+nuPkRJiKTkzn/7EGO4XD+XF4yAc5UD+q2n6yK5CHOfSbNmikUMYxP7hRfwcERl/EEOBIr1uKIyDhZa6N5m2PGeIUbD98P1StQG7oVJgPKWawwkpWFenHmqpcQrygYsHrzWaqoiHqTcmd2f1f7pNaULz8TESyZxHj9TXsBfz51EhQjz2JFtrrB9tY/cYYebIojebfpKlqQH8KRMgQIhb/WKTpkPf9kLe/dP5lLLOx4vHZKOU9CoO9EOF1gKm68iQx13HNYjD+mqMrd1HMGP83PfRA41Sjkjc1a9RvX4IsEt9uJhU3rf2B2TEtrrToVU8pfLWd01T0KaCWk3HGkVUcHtlCAux2bvDK3rlGtXl8H2Rn9oF7/xU63sbY3LQxelHCsPlB794ptupDKsXY6j5o7wEnE7tvr3fvPx1PEo9SjEDlOM6f0hO8BWMmBFYfT3MqXZD4+Cxp5xLCE1s8LKnwzsEBUQZTnDuz91s53SzvelRPD9Jffe7zxpmjWSFLff4kJKahSSApl3GGi2qy7QPvCrSa01XgFr87i+NpX7yZYLK0tF07Eb83pj3WU0at7HLRPguu6G4B/21aNAUVYymhZhdWOv4KX4cLG0IxN+cGIHzlE4hRPOcUHpbw0bzYuQKmwM4NyQsEGJVxLTMwPf4vJ3jSfMxU418CrnLZvgQkk9XRWTW3+LDxoTP8oUmBtQWtplKknlZvfTgyUZHMxPaP3QEckTQ1hO0HeaoYyg9dlzx9eQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(346002)(39860400002)(396003)(136003)(376002)(451199015)(46966006)(36840700001)(40470700004)(31696002)(86362001)(36756003)(31686004)(82740400003)(81166007)(2906002)(356005)(41300700001)(426003)(54906003)(8936002)(40480700001)(44832011)(2616005)(5660300002)(16526019)(53546011)(83380400001)(26005)(36860700001)(336012)(478600001)(16576012)(186003)(8676002)(82310400005)(70586007)(110136005)(47076005)(40460700003)(70206006)(4326008)(316002)(43740500002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2022 13:05:38.8761
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f79624c-92a8-4919-d567-08dab6899d1f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT099.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6027
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/11/22 23:24, Tanmay Shah wrote:
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
> index d1f652802181..edb13167170f 100644
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
> index e00a25aa2c17..d52f8413b892 100644
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
> @@ -494,6 +497,12 @@ int zynqmp_pm_is_function_supported(const u32 api_id, const u32 id);
>   int zynqmp_pm_set_feature_config(enum pm_feature_config_id id, u32 value);
>   int zynqmp_pm_get_feature_config(enum pm_feature_config_id id, u32 *payload);
>   int zynqmp_pm_register_sgi(u32 sgi_num, u32 reset);
> +int zynqmp_pm_force_pwrdwn(const u32 target,
> +			   const enum zynqmp_pm_request_ack ack);
> +int zynqmp_pm_request_wake(const u32 node,
> +			   const bool set_addr,
> +			   const u64 address,
> +			   const enum zynqmp_pm_request_ack ack);
>   #else
>   static inline int zynqmp_pm_get_api_version(u32 *version)
>   {
> @@ -764,6 +773,20 @@ static inline int zynqmp_pm_register_sgi(u32 sgi_num, u32 reset)
>   {
>   	return -ENODEV;
>   }
> +
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
>   #endif
>   
>   #endif /* __FIRMWARE_ZYNQMP_H__ */


Acked-by: Michal Simek <michal.simek@amd.com>

M
