Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E65C67505B
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 10:12:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229915AbjATJMp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 04:12:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229916AbjATJMk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 04:12:40 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2066.outbound.protection.outlook.com [40.107.93.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 168908B74A;
        Fri, 20 Jan 2023 01:12:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BCnUCME5vz/mbfuMY2K+MQKyvnL4y4BksEHEbUh3RRH3w5KZoiLM5S3cEeluDn7EADNFIgRuFeNHkc5UI/800SjkNwbZevWTdRzh9jAzi63Qy/mKA8XnwTCzeNAf1mIT15rfzsP0ZhSZsLBDX6C/Q6X0bNRHbiGks+1DUEqcqxiIslDx7Y1D1VgS3YbyVNF1Ff1yObFkg5HNGWKpBH/7175SUEI7rK7Fk29afPOW9h5dspEG2t63Rz5/Aw6skRP8S1jxOFnANyXMMx/xAYEaLQhGwt6iILkKFpHBgbvQES9x4HJbtOi1pUJ9QAGk9W2ozomdOwOTPN/z2MejoTotkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mu7lZm7CnNy3kKofxFBbo+EBEyQklGwaZSKSLV+qnRc=;
 b=XkuoIKfR1nUMya0ed1MkGtnXrFpLLM2A/xVPR1drvXg7G9UmF6cepoLeEPr5MQ4d/08DRgZr0UQCg0WYbHXU67li3ybnwoOQOpW37F3XBYwa6JG88MXux8wP/KBhvw+t3+5JzDPU6GfrTpDwl4eip7QucDDWkRye2qaS03VcwTMjEvZoAerKlY002KlTyfRV2xT+38tHqaK5cCqpoi3+wFcg9BY7CkYuuZFbgkgbGuu6y07R8ypEvFZ8p3Y+Xzyhm44T7yjbzOYHXVfn6UnGSGwodNCXIumHcFrE1DVL37TpF5WNAd6n5qGofDXolQyLlKGSWv6/qSqn+4EROezhmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mu7lZm7CnNy3kKofxFBbo+EBEyQklGwaZSKSLV+qnRc=;
 b=VtKE3Jp2M4PdjZdp0YErYdn1XAIaEDZ7q7EbARXr0orcmK86JsEv8PwjhBbBn++CQvJpNc/Mqojn39U5NynqSzBFyxb3mstWGUL4Sq1eYsXmTAkkdE730BfHjrKGE6jOfy4MUNXmZ2WD2FbslSmedw2m5ulwUSzy7ulQtH7vpIo=
Received: from DS7PR03CA0100.namprd03.prod.outlook.com (2603:10b6:5:3b7::15)
 by PH0PR12MB5678.namprd12.prod.outlook.com (2603:10b6:510:14e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.27; Fri, 20 Jan
 2023 09:11:16 +0000
Received: from DS1PEPF0000B075.namprd05.prod.outlook.com
 (2603:10b6:5:3b7:cafe::f3) by DS7PR03CA0100.outlook.office365.com
 (2603:10b6:5:3b7::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.27 via Frontend
 Transport; Fri, 20 Jan 2023 09:11:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0000B075.mail.protection.outlook.com (10.167.17.6) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6002.11 via Frontend Transport; Fri, 20 Jan 2023 09:11:15 +0000
Received: from [10.254.241.50] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 20 Jan
 2023 03:11:09 -0600
Message-ID: <ed2d1554-b560-ae0c-4883-5366f412184b@amd.com>
Date:   Fri, 20 Jan 2023 10:11:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v1 1/1] iio: adc: xilinx-ams: Convert to use
 fwnode_device_is_compatible()
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        <linux-iio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michal Simek <michal.simek@xilinx.com>
References: <20230119174749.76769-1-andriy.shevchenko@linux.intel.com>
From:   Michal Simek <michal.simek@amd.com>
In-Reply-To: <20230119174749.76769-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000B075:EE_|PH0PR12MB5678:EE_
X-MS-Office365-Filtering-Correlation-Id: 81db7d46-9262-4b99-ea3b-08dafac648be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UAbt9CmVvFIr+SI2GmVjnLR6nFEwsD9dMmS2//8KdQ2hc+buVYMq8+Py4/6Z3y4A8isg+TNQX7UTxk8FA6Z2rBj/woxOU+K4ap3THqgt1L0sm3HDppNwScRjStqtyNnm1a3i1iPCSC9vPYwtA8k9zviOV7uoZV3WyG2/hIXTYQOP+qUJh5ePpTmLI2+kbQ2HSdfbp6UOWhjN6C4R0SXPGgXKPYKJ/u868cv+umrSNzxeADOUDgw6ru8YOTmSPsU7ml3F1OUc1Iuc8TfElgyYVO/kBweBPnjmbpgDNt3dAORcdoNawYYhlI9aWdTNNEVx4hKn78fbE6oMI5DB37AUBzCWO91lbKx88X6jV1icrA8QE7SeBzZKzcJWnD/HbgK63ozkSjZ8VLY3MaWxmOYo3PxroiedwbRafFzLhGQ6MxQiMWAi9EExB55DBUp6HIrBObstUsM2Njvvb8Up0TZPNEWQOAyE500eHvPa3cdtP7NSxn2lB8sgpzGhMyz4/YKDGTb0/14tzgrUsjxza4xK/kWP7Uryht+K1j9knv+a+/kIIeX0ZxyLfG1UGfW5C3p5wWS9+SftdCie+mMMQDniiC4ONjU2Yt290rzHUWIRohgRl09nSolDGDekcBoXRC+3SH8TPBw15yTwYnGR8TtSpTUEyvHxu8ycb9H06eTltZCSMYWEyesoD6leM/JMCYp+uEBMEaBBiNs6YBqnGBu7Yugjp4ib/OuLij0eoZZLpWndSdRt2eXrA8PhmCsV+MjFxR7wgBkEMBXcAMczFtYxUXWgWhtgJQhags/4bv1C2q0=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(346002)(396003)(39860400002)(451199015)(46966006)(40470700004)(36840700001)(5660300002)(44832011)(8936002)(31686004)(4326008)(82310400005)(8676002)(70586007)(70206006)(31696002)(6666004)(53546011)(16526019)(2906002)(26005)(110136005)(186003)(54906003)(36756003)(478600001)(316002)(16576012)(2616005)(83380400001)(41300700001)(356005)(82740400003)(40480700001)(36860700001)(81166007)(40460700003)(86362001)(336012)(47076005)(426003)(2101003)(36900700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2023 09:11:15.6023
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 81db7d46-9262-4b99-ea3b-08dafac648be
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000B075.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5678
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/19/23 18:47, Andy Shevchenko wrote:
> 
> Replace open coded fwnode_device_is_compatible() in the driver.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>   drivers/iio/adc/xilinx-ams.c | 9 +++------
>   1 file changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iio/adc/xilinx-ams.c b/drivers/iio/adc/xilinx-ams.c
> index a507d2e17079..34cf336b3490 100644
> --- a/drivers/iio/adc/xilinx-ams.c
> +++ b/drivers/iio/adc/xilinx-ams.c
> @@ -1220,8 +1220,7 @@ static int ams_init_module(struct iio_dev *indio_dev,
>          int num_channels = 0;
>          int ret;
> 
> -       if (fwnode_property_match_string(fwnode, "compatible",
> -                                        "xlnx,zynqmp-ams-ps") == 0) {
> +       if (fwnode_device_is_compatible(fwnode, "xlnx,zynqmp-ams-ps")) {
>                  ams->ps_base = fwnode_iomap(fwnode, 0);
>                  if (!ams->ps_base)
>                          return -ENXIO;
> @@ -1232,8 +1231,7 @@ static int ams_init_module(struct iio_dev *indio_dev,
>                  /* add PS channels to iio device channels */
>                  memcpy(channels, ams_ps_channels, sizeof(ams_ps_channels));
>                  num_channels = ARRAY_SIZE(ams_ps_channels);
> -       } else if (fwnode_property_match_string(fwnode, "compatible",
> -                                               "xlnx,zynqmp-ams-pl") == 0) {
> +       } else if (fwnode_device_is_compatible(fwnode, "xlnx,zynqmp-ams-pl")) {
>                  ams->pl_base = fwnode_iomap(fwnode, 0);
>                  if (!ams->pl_base)
>                          return -ENXIO;
> @@ -1247,8 +1245,7 @@ static int ams_init_module(struct iio_dev *indio_dev,
>                  num_channels += AMS_PL_MAX_FIXED_CHANNEL;
>                  num_channels = ams_get_ext_chan(fwnode, channels,
>                                                  num_channels);
> -       } else if (fwnode_property_match_string(fwnode, "compatible",
> -                                               "xlnx,zynqmp-ams") == 0) {
> +       } else if (fwnode_device_is_compatible(fwnode, "xlnx,zynqmp-ams")) {
>                  /* add AMS channels to iio device channels */
>                  memcpy(channels, ams_ctrl_channels, sizeof(ams_ctrl_channels));
>                  num_channels += ARRAY_SIZE(ams_ctrl_channels);
> --
> 2.39.0
> 

Reviewed-by: Michal Simek <michal.simek@amd.com>

Thanks,
Michal
