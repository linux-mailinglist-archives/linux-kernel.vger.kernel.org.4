Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D1D163861A
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 10:26:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229871AbiKYJZ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 04:25:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229869AbiKYJZt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 04:25:49 -0500
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2046.outbound.protection.outlook.com [40.107.96.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F3C631F82;
        Fri, 25 Nov 2022 01:25:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fwoNcf5vXxdmkjJ4mDMeL/N98ONHoWsb4Dh5pwfBWXfP70sHcRsWbHeBYhbjT/7Ks9JWCcqyI1Q1B/19me+0Oggh6zS+nzHEo59gK+UTdIRBuebAPZVEmNxJQpFnayKdv0wABGBwZ31RQFNAScoRouw44KHJZkheI4AX8JYJ5BYvidknrwYmX+xQF5vWJ10viGqSmHNka+VN3ms2kR3tpqqRG9Dxu2IBBYDYlFXXhMKAt0h9OEanc61N/XzFsDNIg519bz6ZRuUQcfDtWhGzc0i0OXxrd81msnUQsmBZ8CaDZzmsBtgKVykLe4rbDeIcWHU2QPOvpqS+rAsiK9ZilQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ptKLpD/UD56c+zH9PQ/UGytaJcgaunA9AY4taxrDKdc=;
 b=VLcvBeleLajkYD53JtzOf1hi2KO4ZGetmNXJBu5Zwly/4ZCTSF+pt6+nuc+cuXiKHqGnjiCH2uKqsSjrC/DL6/ZMHNQ8RNDByXWuxSP6SXKA8FLMWauPqZ/5K+JpsiR9kCB0y4XNVtlqy5o7Ungs56269yXDa6lC6mxK8cnD7hlkDf/uT1RJB9Ifs88k50jd4hVHJLQyB1xXjZvIcBsngCzaTdsj5/XiAhqjp+7ELL9VyvswAlBOEn3eHVHNBujwD5aIh+RC2iGDo1HTu5RUxW5g4AQpSJ+MSFNWUDOmib69uTPpIYNUmeVy956GQDY682xtAopLQtz/p02IXLmdbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ptKLpD/UD56c+zH9PQ/UGytaJcgaunA9AY4taxrDKdc=;
 b=TFHLKIfdfcsSjywGtlv+mFTNFA9Z1bSMq4P/5OMydUuXzwLgG6xgeZ1hsh+da7wcS2XKy+OUZHwUEFdZwMD7lNbjC+6g2rQDuo63WPfWijkt+D7QopJfZjf9yTTCyDd5ZHQLF9C8MEmeIfztV3aIIpJRxHi4G1vOiMalm/71YbM=
Received: from DM6PR02CA0067.namprd02.prod.outlook.com (2603:10b6:5:177::44)
 by BY5PR12MB4856.namprd12.prod.outlook.com (2603:10b6:a03:1d5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.20; Fri, 25 Nov
 2022 09:25:43 +0000
Received: from DM6NAM11FT023.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:177:cafe::5f) by DM6PR02CA0067.outlook.office365.com
 (2603:10b6:5:177::44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.20 via Frontend
 Transport; Fri, 25 Nov 2022 09:25:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT023.mail.protection.outlook.com (10.13.173.96) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5857.20 via Frontend Transport; Fri, 25 Nov 2022 09:25:43 +0000
Received: from [10.254.241.50] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 25 Nov
 2022 03:25:35 -0600
Message-ID: <add472c4-a555-e8a8-94f4-bcf707f32af1@amd.com>
Date:   Fri, 25 Nov 2022 10:25:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v11 5/6] firmware: xilinx: Add RPU configuration APIs
Content-Language: en-US
To:     Tanmay Shah <tanmay.shah@amd.com>, <andersson@kernel.org>,
        <mathieu.poirier@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>
CC:     <bill.mills@linaro.org>, <linux-remoteproc@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Ben Levinsky <ben.levinsky@amd.com>
References: <20221114233940.2096237-1-tanmay.shah@amd.com>
 <20221114233940.2096237-6-tanmay.shah@amd.com>
From:   Michal Simek <michal.simek@amd.com>
In-Reply-To: <20221114233940.2096237-6-tanmay.shah@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT023:EE_|BY5PR12MB4856:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b851400-1017-4b01-43e8-08dacec706d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2/s9sbICfS0BsToy01+yCzRk149W3Uvr3VDimLYC9XF/gfeQcevwtkvIyQ/hFQgpv1bHkjzffkGGL8OPBZS17PveVdULg+0mta48+D9vn2qDUef9hY/DoSKOZcUBSlQuagXqt4a8uxx6is5H/NzaV5KzpTry4aKsLwCYIUlR42yU8YU6eBh6YfgtMj2G6CBspS5u9L3cYHgFHeKrzLIFm60dwDO4NN6LTPepKixPaYMbVFmwMXGWPCT4/7sd4T0VdJq4FCXJ/qR2QegyaHRdaYjeQqOWFRsIGURZQ6vbZosyWYBZM6bYLzk7D9T+r7DSCUIda45GgZCnN/J3mL3UlEzhOoB1AbKVAM+p8PBdPhZZC3k9V5Lg8oQ2BxN+IkIqspRSmClTUeNknQdFOD4+WcZjr8txqtpz9xehScOx1iu7Ssq17vRXXR2Svk+t2/brqRGGbq5987nZh4vJbtb2YbxBDbp7/OrW1vHll9lHyOqaBbSnVmybFMlyLXOJRoxB8ppRaOP9KUeNFK7bdlgygZlZ29zVvsvwTdCkRBYcM8h/KiOTiUvRDQO4W6S00AkLvhLvZGGnk8P/vD9AsAmzdafmRtbSMFye3Vg5qNbmPL8XehANSs24MZ58fbXBycF56/QDYjaWA7v9x3yQqpEcajo2beiDgmMpUkSBDVubMD6YS3DbVzIW9KYZB5Ptkp/6XerrcHtoOaxTL9RWTfRIM5L1X83Cb0AQA7IJ/lRmBNeu+DSeqav+fmxKtqOxsNIKEAy8cf0oZhGwaa+LRcIALw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(136003)(346002)(396003)(376002)(451199015)(40470700004)(36840700001)(46966006)(8936002)(2616005)(26005)(44832011)(5660300002)(356005)(16526019)(186003)(336012)(426003)(47076005)(36756003)(81166007)(40480700001)(31696002)(86362001)(110136005)(16576012)(54906003)(316002)(82310400005)(6666004)(41300700001)(53546011)(40460700003)(8676002)(4326008)(70586007)(70206006)(478600001)(31686004)(36860700001)(83380400001)(2906002)(82740400003)(43740500002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2022 09:25:43.2910
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b851400-1017-4b01-43e8-08dacec706d0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT023.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4856
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
> This patch adds APIs to access to configure RPU and its
> processor-specific memory.
> 
> That is query the run-time mode of RPU as either split or lockstep as well
> as API to set this mode. In addition add APIs to access configuration of
> the RPUs' tightly coupled memory (TCM).
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
>    - Add missing function argument documentation
> 
>   drivers/firmware/xilinx/zynqmp.c     | 62 ++++++++++++++++++++++++++++
>   include/linux/firmware/xlnx-zynqmp.h | 18 ++++++++
>   2 files changed, 80 insertions(+)
> 
> diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
> index 1865e43ed7e7..e4981e7f3500 100644
> --- a/drivers/firmware/xilinx/zynqmp.c
> +++ b/drivers/firmware/xilinx/zynqmp.c
> @@ -1159,6 +1159,68 @@ int zynqmp_pm_release_node(const u32 node)
>   }
>   EXPORT_SYMBOL_GPL(zynqmp_pm_release_node);
>   
> +/**
> + * zynqmp_pm_get_rpu_mode() - Get RPU mode
> + * @node_id:	Node ID of the device
> + * @rpu_mode:	return by reference value
> + *		either split or lockstep
> + *
> + * Return:	return 0 on success or error+reason.
> + *		if success, then  rpu_mode will be set
> + *		to current rpu mode.
> + */
> +int zynqmp_pm_get_rpu_mode(u32 node_id, enum rpu_oper_mode *rpu_mode)
> +{
> +	u32 ret_payload[PAYLOAD_ARG_CNT];
> +	int ret;
> +
> +	ret = zynqmp_pm_invoke_fn(PM_IOCTL, node_id,
> +				  IOCTL_GET_RPU_OPER_MODE, 0, 0, ret_payload);
> +
> +	/* only set rpu_mode if no error */
> +	if (ret == XST_PM_SUCCESS)
> +		*rpu_mode = ret_payload[0];
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(zynqmp_pm_get_rpu_mode);
> +
> +/**
> + * zynqmp_pm_set_rpu_mode() - Set RPU mode
> + * @node_id:	Node ID of the device
> + * @rpu_mode:	Argument 1 to requested IOCTL call. either split or lockstep
> + *
> + *		This function is used to set RPU mode to split or
> + *		lockstep
> + *
> + * Return:	Returns status, either success or error+reason
> + */
> +int zynqmp_pm_set_rpu_mode(u32 node_id, enum rpu_oper_mode rpu_mode)
> +{
> +	return zynqmp_pm_invoke_fn(PM_IOCTL, node_id,
> +				   IOCTL_SET_RPU_OPER_MODE, (u32)rpu_mode,
> +				   0, NULL);
> +}
> +EXPORT_SYMBOL_GPL(zynqmp_pm_set_rpu_mode);
> +
> +/**
> + * zynqmp_pm_set_tcm_config - configure TCM
> + * @node_id:	Firmware specific TCM subsystem ID
> + * @tcm_mode:	Argument 1 to requested IOCTL call
> + *              either PM_RPU_TCM_COMB or PM_RPU_TCM_SPLIT
> + *
> + * This function is used to set RPU mode to split or combined
> + *
> + * Return: status: 0 for success, else failure
> + */
> +int zynqmp_pm_set_tcm_config(u32 node_id, enum rpu_tcm_comb tcm_mode)
> +{
> +	return zynqmp_pm_invoke_fn(PM_IOCTL, node_id,
> +				   IOCTL_TCM_COMB_CONFIG, (u32)tcm_mode, 0,
> +				   NULL);
> +}
> +EXPORT_SYMBOL_GPL(zynqmp_pm_set_tcm_config);
> +
>   /**
>    * zynqmp_pm_force_pwrdwn - PM call to request for another PU or subsystem to
>    *             be powered down forcefully
> diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
> index ad3f2bd0c470..cf92e739fa3b 100644
> --- a/include/linux/firmware/xlnx-zynqmp.h
> +++ b/include/linux/firmware/xlnx-zynqmp.h
> @@ -530,6 +530,9 @@ int zynqmp_pm_request_wake(const u32 node,
>   			   const bool set_addr,
>   			   const u64 address,
>   			   const enum zynqmp_pm_request_ack ack);
> +int zynqmp_pm_get_rpu_mode(u32 node_id, enum rpu_oper_mode *rpu_mode);
> +int zynqmp_pm_set_rpu_mode(u32 node_id, u32 arg1);
> +int zynqmp_pm_set_tcm_config(u32 node_id, u32 arg1);
>   int zynqmp_pm_set_sd_config(u32 node, enum pm_sd_config_type config, u32 value);
>   int zynqmp_pm_set_gem_config(u32 node, enum pm_gem_config_type config,
>   			     u32 value);
> @@ -818,6 +821,21 @@ static inline int zynqmp_pm_request_wake(const u32 node,
>   	return -ENODEV;
>   }
>   
> +static inline int zynqmp_pm_get_rpu_mode(u32 node_id, enum rpu_oper_mode *rpu_mode)
> +{
> +	return -ENODEV;
> +}
> +
> +static inline int zynqmp_pm_set_rpu_mode(u32 node_id, u32 arg1)
> +{
> +	return -ENODEV;
> +}
> +
> +static inline int zynqmp_pm_set_tcm_config(u32 node_id, u32 arg1)
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
