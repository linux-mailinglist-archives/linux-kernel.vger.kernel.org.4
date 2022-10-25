Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6546460CCF1
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 15:05:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230057AbiJYNF4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 09:05:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232208AbiJYNFV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 09:05:21 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2063.outbound.protection.outlook.com [40.107.93.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49776205C3;
        Tue, 25 Oct 2022 06:05:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O+OvG7jQKKCM8N5TPOMHj0NbxmjOtd8/4D0f2wTO7JuhotkiYbbjOGpv7VkCcyjkNTfl//sB97ACWJ+x0hXviIWsUkE02zEzre3FFXIuPCJ6LTNDu1yXk+k634G4h7t/R2P5wrCkgPbkxYbIG/KUhmvCLRsQXs0+sCZwW/0d4Cgox4FmZ29c73wLgBJV4K+PCKvxSmHDqXffgYhIUotJnC7rtpe3t7BNY5DMaPqjmsPTXj7+eduDKVDXvzC96a3SdlkTFoDXgZTsXVqMUstQhpsdJ+/R//HntQlfWA14rP/6JIP8d9Tea44CECXSwEOaaXsKoCY5nF3CmrroAOzhEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tuIbzp+Q5JodVv/Vwt6ufH5m0nPiflcua9Q92mqziUE=;
 b=SSaKetGgQtBBL25VKba3juI4Bi5UEldK6mcwnQscfYl5nbH6Wx8hdWOwvsOtbR585iaIhjxYGcset6EYOrV9uEzUgIMjhgPy9dQJyWhqCVFpTIFqwQnSwLqa9fLlxOvgH1g54HLJUJZgKhLuhXcliocSKVVKxkRt/vuPqTNc6jrPjjD3GCnC1QaQSglwWDusyQAji9yqq+qWnlnkEsSUN+kouvzyE5TPHZ36aUDkvXp7Op/GmMvmK3cBaAIJ94U3WL49exh3No61mq+KpDpug9nF/0NPnvM4qzJ4r0wEQLAS0OysFY2k12xoV/190XBhlm7jtp61RQdXmHU12OzbRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tuIbzp+Q5JodVv/Vwt6ufH5m0nPiflcua9Q92mqziUE=;
 b=jVHms+XeVP/q4j8nKPdOd8zzh+W1BGzQ/0YNGUGqTLAUHkWMivqIW41zbkwDAFuHtseFZYIzuyGb1RqKNfm8MgZ55DjEfQlMZwuZVsCvcBn7O6L7MkGaMu1CXY4cNR13EG/foKsuOEqE69bacJQ0yG6toiFHqav/zcSaXaIJYbY=
Received: from BN9PR03CA0668.namprd03.prod.outlook.com (2603:10b6:408:10e::13)
 by SN7PR12MB6670.namprd12.prod.outlook.com (2603:10b6:806:26e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.23; Tue, 25 Oct
 2022 13:05:00 +0000
Received: from BN8NAM11FT079.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10e:cafe::e8) by BN9PR03CA0668.outlook.office365.com
 (2603:10b6:408:10e::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.27 via Frontend
 Transport; Tue, 25 Oct 2022 13:05:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT079.mail.protection.outlook.com (10.13.177.61) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5746.16 via Frontend Transport; Tue, 25 Oct 2022 13:05:00 +0000
Received: from [10.254.241.52] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 25 Oct
 2022 08:04:55 -0500
Message-ID: <ecb13c89-58b2-545f-2ee0-3bbe1fd97dce@amd.com>
Date:   Tue, 25 Oct 2022 15:04:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v10 3/6] firmware: xilinx: Add ZynqMP firmware ioctl enums
 for RPU configuration.
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
 <20221011212501.2661003-4-tanmay.shah@amd.com>
From:   Michal Simek <michal.simek@amd.com>
In-Reply-To: <20221011212501.2661003-4-tanmay.shah@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT079:EE_|SN7PR12MB6670:EE_
X-MS-Office365-Filtering-Correlation-Id: 90b81e66-5277-432b-83a3-08dab6898614
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2RmkQT/lvL7Raj1GECbMXc1mpMM/o73/6aYABFkwa0+HFmCtakWgSlz4SHTyf7x3dvCho699oundDF7Wq+AzswjvREPB+o8BMvyuZk6Zs9T0JuKL7E6DzM8+xUb3NSUeqfgFRbonvz+yuI6Xam+PnTRl76fa8js5UKN2AfDqaBjGL4xW6suYgzS7O77OevTp7qjxp59PNdtdWa/dXa4hRJnj6TVIP30QsuGfbU08IixbZkKNAZ1sVfQ4/SV+xWcklcb8Afv7goozUEa2exPbVnm7zRIjHv2MspysrYOk8JJwwiOmGZpOyS7lWNMbDoVPsjzOVGZ3U3JvL3oE2Wjfq8tn83yj8xA98C42yq3tRFtNy+LqnI/SYm17vyWxKVNYTUJJN+SNx1c4kHQdCoEQHsx7hDhEH/s3G8h9KixmK8SgedsX4VAuvhV4g+f0NTi4+bRZQPKtrsF+poGkn70qmq6eBdaUeIyqUuKNtJ9TEfu4IaYOdzeZC7dX5jdTMNL3kDeLdBsb+Hw3CnePEPAbd7QKohPdkF3M1U7hJsxiKIMCoRlkgBOkpbCeOjwadCq2pOKOVomM28wZ4ngMfDqhykdKDoruw09oaaZas50nPjOFBq1FrDK+f6XpgIlLPKzUQUIt3vApjmfDzJCa2a/Rq3x+cUbEAd9eQ+gHpU0Sz0CuHvpEyCHUaFxzFwtJhjUmZU8ULShN6p29DCmeB0nBk9xpXUtGDdlmr7M9DROo+LTk6UezhWE1J/aWOuqNtZmuG4G5Hl1c5TG31kdDnPwEc+Fe+ivhrSKj7otXfMD9edNl7LskPAcpWM2tJz3rqA2uzpYqlxneanLXW+Cjbz1lGg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(136003)(39860400002)(396003)(451199015)(36840700001)(46966006)(40470700004)(31686004)(36756003)(82740400003)(36860700001)(40460700003)(44832011)(2906002)(31696002)(86362001)(16526019)(2616005)(356005)(426003)(81166007)(83380400001)(336012)(47076005)(70586007)(53546011)(26005)(16576012)(186003)(4326008)(8676002)(316002)(110136005)(5660300002)(54906003)(70206006)(41300700001)(8936002)(82310400005)(478600001)(40480700001)(36900700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2022 13:05:00.2143
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 90b81e66-5277-432b-83a3-08dab6898614
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT079.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6670
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
> Add ZynqMP firmware ioctl enums for RPU configuration and TCM Nodes for
> later use via request_node and release_node
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
>   include/linux/firmware/xlnx-zynqmp.h | 19 +++++++++++++++++++
>   1 file changed, 19 insertions(+)
> 
> diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
> index 9f50dacbf7d6..e00a25aa2c17 100644
> --- a/include/linux/firmware/xlnx-zynqmp.h
> +++ b/include/linux/firmware/xlnx-zynqmp.h
> @@ -135,6 +135,10 @@ enum pm_ret_status {
>   };
>   
>   enum pm_ioctl_id {
> +	IOCTL_GET_RPU_OPER_MODE = 0,
> +	IOCTL_SET_RPU_OPER_MODE = 1,
> +	IOCTL_RPU_BOOT_ADDR_CONFIG = 2,
> +	IOCTL_TCM_COMB_CONFIG = 3,
>   	IOCTL_SD_DLL_RESET = 6,
>   	IOCTL_SET_SD_TAPDELAY = 7,
>   	IOCTL_SET_PLL_FRAC_MODE = 8,
> @@ -172,6 +176,21 @@ enum pm_query_id {
>   	PM_QID_CLOCK_GET_MAX_DIVISOR = 13,
>   };
>   
> +enum rpu_oper_mode {
> +	PM_RPU_MODE_LOCKSTEP = 0,
> +	PM_RPU_MODE_SPLIT = 1,
> +};
> +
> +enum rpu_boot_mem {
> +	PM_RPU_BOOTMEM_LOVEC = 0,
> +	PM_RPU_BOOTMEM_HIVEC = 1,
> +};
> +
> +enum rpu_tcm_comb {
> +	PM_RPU_TCM_SPLIT = 0,
> +	PM_RPU_TCM_COMB = 1,
> +};
> +
>   enum zynqmp_pm_reset_action {
>   	PM_RESET_ACTION_RELEASE = 0,
>   	PM_RESET_ACTION_ASSERT = 1,

Acked-by: Michal Simek <michal.simek@amd.com>

M
