Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8AE860CCFB
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 15:07:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231249AbiJYNHA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 09:07:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232749AbiJYNGb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 09:06:31 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2081.outbound.protection.outlook.com [40.107.94.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3DD05FEA;
        Tue, 25 Oct 2022 06:06:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g/AH34G2iqw0w9vODejG5crij3+SEXqFxpRMnR/j9J2MapvmqO8K1aJfFnQvkRiHCUkUV41InVVVYaZ5aqx5nnVNYbIs5rrTZaiGJvhLao1k/FM5Grkn+2e4shgJKkgo+TWCwduC+xIWAJmpaDIyApgv5Q5XMU0zDVgUf3fnM54nhZ080u5nVhUPPKQIRKgvYW5vUPbztZFEFnE+phGi+MhInabP4IB7M46moxB6/2ier1IwHvwjyxtVmy+2CAT6MjDX2UjTwap26orApNL9+ejyI7o/F7Ih/5XgLXYqBD6W2FNOMaQkBmTmhVszUrGqhuF14W/FAdkxqMiCpAcxcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jNbwIxNZBjvht3rwEQEUe+MsnVRL3Y75Mm4mCkT1HxA=;
 b=EaqVG+DS9MzuWgNoZeli0ddENP2/Qx31TcfpFsxGTYzJLYg6yURxNVWNqTUWYJPiMVnF2EdKQo5S9n/5at0G8Kt6WMqgDKOnxYgIEXqAcZ1JiSFC5x9TsoDg/BMESWfnbjBs/dx12RFS7rxAptx1WMJMBhpOx2Usx5Yo/HmPCrymRbK5g00yoyrjzOWHLrwVNwPQStCWcb2UUte70XZ6yXssGEz7NsNW6gqLtRB/hi9RmngDTZEPx0+tvAumkcnBatwx/TjwAnawKDihJZatNhnG0limQMsPDsguSbV2Okm4D7o7nX7jDVQayrwhN6+lsSeI3LI6BkyHJJUPKIgpEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jNbwIxNZBjvht3rwEQEUe+MsnVRL3Y75Mm4mCkT1HxA=;
 b=sfBECLwENAXGFhNKVS4R10zvNIF+lmoDtcheeFiolkVyPp09aJoDYPRXqf1lX7i0sJADe2+Vq6R9PO79Tq6cxg59Gn0csOu7+T1CQSppg5XZH/k1dD9NDfX8lh/dq6PbSVDHeCZWC23gxRIfa0BQdThl8rSlqQ//21pyONf50yQ=
Received: from BN0PR04CA0096.namprd04.prod.outlook.com (2603:10b6:408:ec::11)
 by CH0PR12MB5332.namprd12.prod.outlook.com (2603:10b6:610:d7::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.33; Tue, 25 Oct
 2022 13:06:04 +0000
Received: from BN8NAM11FT093.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ec:cafe::7d) by BN0PR04CA0096.outlook.office365.com
 (2603:10b6:408:ec::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.27 via Frontend
 Transport; Tue, 25 Oct 2022 13:06:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT093.mail.protection.outlook.com (10.13.177.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5746.16 via Frontend Transport; Tue, 25 Oct 2022 13:06:04 +0000
Received: from [10.254.241.52] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 25 Oct
 2022 08:05:59 -0500
Message-ID: <61eeb4fb-b746-7b51-df7c-ddd9c709e200@amd.com>
Date:   Tue, 25 Oct 2022 15:05:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v10 5/6] firmware: xilinx: Add RPU configuration APIs
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
 <20221011212501.2661003-6-tanmay.shah@amd.com>
From:   Michal Simek <michal.simek@amd.com>
In-Reply-To: <20221011212501.2661003-6-tanmay.shah@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT093:EE_|CH0PR12MB5332:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f066a10-62bf-4d3b-4e96-08dab689ac6d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 01gAtTko3XL2jMR1uuScZ7C0a/WoRvNOaGS4ex7YBbZFyl0tBDLhJzAAKk11zj1h/zeq5q1A1QODjaUFW2z+AjuOA4XKgQBWvJK3yogayTWSZ7i4fSbYxkftTBR84U9gg0G5z7VN37vwXPVQ8KFebA2Pkv/870uWl/qM5kHBtdtuiPrsy0Cz0w3LyIZUYnQcaNM99uVbcZwQkxdPzxqcjFesEi30th6YGcXa9F6IijeSeaibnnxJgsz4748G3e51RCqu1hTbR8tnxDFu4s9o7hW2w7HUv2ViWuNMzTdAYrO/m1Fc6DC2J3iFRNMkIvCGF39jSYMPB/PDmRvEW39EUzylMehRHv5XGLIoQEoLk5sx/0M7WVYJ1zQQ+XFXIPle8lj4w2ysr3Mrcch82TIuAnuCKpV72hV83HLxpKsrdp5Z01iDTOl7e/OmZeNuHzpaVVnEZfyZYTevLWGiE1bnwS4FIeR+cP4oWS9OX0bX6N+/fXPWtSL+cDXRxehJe1HkEWUValax6e922jPFYCDprNzf9593RtXIQNFxtsxOmhGyeN8RBpHfGbZr33a/yjIvRUVPLQuXw0CJomBfIOnNv7XudxJcDAegbhzU+JKBVrr7NE6QAOkUTIRBnEUAKisLAgutiyzbSO+XDB7ouE4aGorQ44pi7IVl6N+K2xeNT94jcLTx753Kkw93heNzf8a5un3zPSx/UaRV6brYdA0Sn3/z5OLKC2KFYWysZvJIyyl8un2NRQU1+/vnVWJ0Y330SCZzMLnUiF6YGTcIYMF08RPaIdTNCHy/eeXeCx3iy+0207lp0fwFQoDuRjXbHwmsRxZLplYfok6PvXlbURXjaw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(396003)(39860400002)(376002)(136003)(346002)(451199015)(36840700001)(46966006)(40470700004)(40460700003)(186003)(336012)(47076005)(53546011)(426003)(44832011)(36860700001)(2906002)(83380400001)(26005)(5660300002)(16526019)(40480700001)(2616005)(110136005)(70206006)(16576012)(478600001)(8676002)(82310400005)(70586007)(4326008)(41300700001)(8936002)(316002)(54906003)(31686004)(81166007)(31696002)(36756003)(86362001)(356005)(82740400003)(43740500002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2022 13:06:04.5497
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f066a10-62bf-4d3b-4e96-08dab689ac6d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT093.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5332
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/11/22 23:25, Tanmay Shah wrote:
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
> index edb13167170f..eba359e66414 100644
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
> index d52f8413b892..83c69c968e32 100644
> --- a/include/linux/firmware/xlnx-zynqmp.h
> +++ b/include/linux/firmware/xlnx-zynqmp.h
> @@ -503,6 +503,9 @@ int zynqmp_pm_request_wake(const u32 node,
>   			   const bool set_addr,
>   			   const u64 address,
>   			   const enum zynqmp_pm_request_ack ack);
> +int zynqmp_pm_get_rpu_mode(u32 node_id, enum rpu_oper_mode *rpu_mode);
> +int zynqmp_pm_set_rpu_mode(u32 node_id, u32 arg1);
> +int zynqmp_pm_set_tcm_config(u32 node_id, u32 arg1);
>   #else
>   static inline int zynqmp_pm_get_api_version(u32 *version)
>   {
> @@ -787,6 +790,21 @@ static inline int zynqmp_pm_request_wake(const u32 node,
>   {
>   	return -ENODEV;
>   }
> +
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
>   #endif
>   
>   #endif /* __FIRMWARE_ZYNQMP_H__ */


Acked-by: Michal Simek <michal.simek@amd.com>

M
