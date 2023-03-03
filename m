Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A1326A9BD7
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 17:37:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230495AbjCCQhC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 11:37:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230039AbjCCQg7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 11:36:59 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2074.outbound.protection.outlook.com [40.107.237.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CA2526854;
        Fri,  3 Mar 2023 08:36:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZEMwBsoQgqzkPrlszTQUsIEWbv2/elYL6rKdqt4Vwt5TVGVh/rfr3k0XCYsciPTOMh/CIJl1NrD4puB9Uv2Rdk+zX8nsUkkGnnD9TakfRw9WbrGl7OKUAYmv0Q/5HJ0RKvs5f7DaN5NaMwQnXOyMZadJ2FCE7sAXj5jmODL06apig6W1LA8bw/ap7kX5oBz8OF27e27U5pPtdn12OAjOdetKt/eqn4C7lgJBFFE7NnB6pIfmfk4Q83M0x9PLvv57o10uEgAIPeo3TjRkf1Vd+ASU0BlnGKPb0vounNE0zvLIEozluBtqA/MywKZZjlQlT2bLZOgezN1g/fLPDeJFXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2wqdzZIounRROVID/WmviB+caSjYoUqsGCkJMIrag7I=;
 b=gtpc3Rgi4Im7SOvoooQhkDleViQkHt5Lg0b3sbfbEYTOZrAo2gf9rBE4SjuEGEGYQKkwYP/FHJANBUgaWNknNbfjP0EUPrrWw9AMPFHBbuKJOTXgZXP/z/cTkXi0anXeH5Gen8X9nrGOMeGmnMOY6zbtR3oQDXHxC1QmoGYOvbia/A5R3yf9N/SMvgJ3L5IB42nc97q6NihfwtR5SRur32jT0x/MM0uTKV9Slnlst+lxTgDMcil8IOqEUKIB5GEdrRAnhybl3DtmHNSrUSBF9RYbprykhlQMElSy7y+kys6U/eu1b1MJXZAQX24zA46z3gwumue9ThX07WRWmX9RnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2wqdzZIounRROVID/WmviB+caSjYoUqsGCkJMIrag7I=;
 b=b4jHz4kwJ02jp++hCmC0uMmAS/TdodjNKpS+nmifXQPuVlMrabBZzhPpKnJQgtQVFkCb701JbWpfIV1RxaSuzjsdmKqMcJTj1JktO/d1vwi+YbRXaVebbBe+s3ffW2PG/kILSdkpOhZKuqmGrhX6mBtpCH2ohrCpbQE0fV6tu4I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BY5PR12MB3683.namprd12.prod.outlook.com (2603:10b6:a03:1a5::16)
 by MN2PR12MB4535.namprd12.prod.outlook.com (2603:10b6:208:267::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.19; Fri, 3 Mar
 2023 16:36:52 +0000
Received: from BY5PR12MB3683.namprd12.prod.outlook.com
 ([fe80::d214:f856:e057:f856]) by BY5PR12MB3683.namprd12.prod.outlook.com
 ([fe80::d214:f856:e057:f856%2]) with mapi id 15.20.6156.022; Fri, 3 Mar 2023
 16:36:51 +0000
Message-ID: <26869dab-ce4a-ac45-bd94-0d3545a2bc18@amd.com>
Date:   Fri, 3 Mar 2023 10:36:47 -0600
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:110.0)
 Gecko/20100101 Thunderbird/110.0
Subject: Re: [PATCH v4 5/5] remoteproc: xilinx: add mailbox channels for rpmsg
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     michal.simek@amd.com, andersson@kernel.org,
        jaswinder.singh@linaro.org, ben.levinsky@amd.com,
        shubhrajyoti.datta@amd.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-remoteproc@vger.kernel.org
References: <20230228210216.447373-1-tanmay.shah@amd.com>
 <20230228210216.447373-6-tanmay.shah@amd.com> <20230302231052.GB1401708@p14s>
Content-Language: en-US
From:   Tanmay Shah <tanmay.shah@amd.com>
In-Reply-To: <20230302231052.GB1401708@p14s>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR05CA0002.namprd05.prod.outlook.com
 (2603:10b6:a03:254::7) To BY5PR12MB3683.namprd12.prod.outlook.com
 (2603:10b6:a03:1a5::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB3683:EE_|MN2PR12MB4535:EE_
X-MS-Office365-Filtering-Correlation-Id: 45abe988-7828-4f55-bf4e-08db1c057dd3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xuo/Yfo2uJQsGndAC7ZqByN9eU77lO7pTNx1fm+X6Blk0wZmkCnrUUWxuEivCqvQZHmx+RlcKL6lTl9osa29siVWwdPD9UrRrUpK9OG1oxG/3Fy1oRhXTjwMkMMoct9vkWlchTvlb2U5lTCyMj6RAULD3svyBhbL0/f/pvnE9zyjEfm0oU2CdDor4yk8S5D5h/IqVUR0La8j2leHtUSRV/Qi9q2adqI8R/baFvUl0mtMNmWmGRfIp3SKsYYnBLlJjJVezwC68ZBiAGX9jSOE0iFRRkd/Rf+EaioJNsK8rOckzZbqAIT11+wED+Q2oqzYfqflBlWaH/wE/DvDiySqFhH/p6WQPIA9ZfJGfmL2D9FxSACcXavLjSQ/DM3daSIZS+oWo5rbEBGjI/Qi+uynomiawc86+LlXkMoNwhluBP25689FpiibXwmch6POYRwfiitAgKDmgaEknxxBWKvqTgBhGECy/EJ9OE6PxsbhpL90OxN7OQF8wysgB+vViewsvwG2ykust9CMw8WpXbtOew2DHKvHqF3GYd+XiCYLuuS/JU/p6zGe9qebnmxNYd0woC9I1TILX47Mz+3lSIhSt51bNKD87LNxebkreH7WBpEiaDOmPHC52/m58WKhwF6n4rZAOhtLHSOmKIkn8taachEAzZdR+PD6SWBCvQNrwdkCX0k692Ut6VYl0RyMDk8ezB2RM4CU7W8Q9VMyIz0tIiY1W6F8bJbYp3raefxXCavryNPft7RxnpLtfkjR4r8q
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB3683.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(396003)(39860400002)(136003)(346002)(366004)(451199018)(86362001)(31696002)(36756003)(26005)(6512007)(6916009)(4326008)(6506007)(53546011)(41300700001)(5660300002)(2616005)(186003)(8936002)(8676002)(316002)(478600001)(66476007)(6666004)(66556008)(6486002)(966005)(66946007)(38100700002)(30864003)(83380400001)(44832011)(15650500001)(2906002)(31686004)(17423001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dUJucUhNaGJ2MG84MlpRUVZyRDRKWHF2cFl4eUZRN2V5cXBqcm55N0k5Qllo?=
 =?utf-8?B?TVlETElLWnAvaTVXS2xJYUVlaEpCTVpyZWIwaStSWHFscVNMR2FFRytWeFha?=
 =?utf-8?B?Z09HL1RpSjhTclhzeXJHRCtyV1prdG5CRXFxLzNkbnNYc3JKTHBsUFNCSjJl?=
 =?utf-8?B?N0NhTktnNjAwMTJlQ3lFYlRmSmExUitPaWI2Yk16Yk5ZUzI1ejRuNVJ6YVhk?=
 =?utf-8?B?dGFjaDExT3hOOG81ZENENWpZcXdPUWxwbFNUR3hSYkVydDhQcm5lTjN6S1F4?=
 =?utf-8?B?WnRSeVBFTW1EY3RYbVBGT0xyL0FHY09HeDlLNHhmMFA1ME8zUFIvaGVsUm9S?=
 =?utf-8?B?WEdpRWhDSkg5NDJha0FHWlA2djdEc095QWZrRE1jcU1DTFMvRmF6VTlwYUZu?=
 =?utf-8?B?RzZaQXZqeGpXbE1naXRKeUI1NTd6NmVRclVtWWEyYndTVUVxY1VtK2NEWnYy?=
 =?utf-8?B?L2tDK09hSEVtZEtOZUZGU0ZmWXNJbnJ6U01JVzE1eEMva2VWK2pBSHhybWUx?=
 =?utf-8?B?UW93TTNwNTVlOXB5V1huMGRvYm44eXNkZ3dWOHlhRHVWdkI2enZrbkIrTkpo?=
 =?utf-8?B?MTFHNFpqRVluNUdvL1hnMXR0b29ybCtpb2ZGL3JaTHBqNk5lZFhvWDRLemlF?=
 =?utf-8?B?dHlwWGRJOHFteGYvM1kzODJ0UmZJdldBSUE3bzJ5ZTVhZU8wV0IrNTYvb2pp?=
 =?utf-8?B?VEZYd1RWMDE2SVNGaXVXTmxHQlZyM2t2SXhNZDFqc3Q5MlhyOUdqWHloMTJy?=
 =?utf-8?B?ZVp5NU05akVhWEhYTzdJYTBURkNqQ2tsRyt2blpRbFVJOHIzWlFuczBqSFhT?=
 =?utf-8?B?amJBNExmdUhRWjdzNkREYmFyY3VNaEMxNEpOWlpRQ212USt5N3dOaUViY1V5?=
 =?utf-8?B?WmZ6YzlJWS9UdUZ3bDByd3BtRDJabG5hRCtTaGtBdDYxTFFWUkx4NExNTjlH?=
 =?utf-8?B?MjBlbWJNQjJOWDBwSDVCM2grdXNRR09BaUNwazVCTW9CSXYwYWZBWUY2Sk1z?=
 =?utf-8?B?bitwM25nZmMxcXFPUGlHaWdDcUN5OU84eHBSMTN5UWk1cVpIbFRSRDc4TzhC?=
 =?utf-8?B?ejQwOGNMYVo2cE1xSlc4R0l1QmFqVjVTNnRvZk8zMkl3RVZJS3Jna2VkWG5N?=
 =?utf-8?B?OUdOb0Zha2ZQWHdqbG1tMlBvZmRuLzNWOHJZdXMvc1E5c0ZQdWZQUTRKWlZr?=
 =?utf-8?B?YUw2NGF6djhtaGlIbHVDelhjZGV6enVpenpEY0hUc2FFSG54NHVGM1FIWldP?=
 =?utf-8?B?a1g1cjM3T04wRXF1dVI2a2h5RENpMWZ2OFBOZDVjOGl2NG5iaTVRVkhLQzFO?=
 =?utf-8?B?c0Mwc3V2RndjbXk5cFhtY3N1bHRHMldIWXh1bVMyRG5qYU14Zm5iTjRpeVlO?=
 =?utf-8?B?SjFqdG81NldjODRjem5aMEpmblpQRHVDL3NXazhUN2srbk9XNUlpVkZIbkFW?=
 =?utf-8?B?bXA0OWM2d2tOaXdjaEVpaXBMMmsremI5c2NYczFpS0lSRHowcWpqenFvd2Ry?=
 =?utf-8?B?T215Ym90Y2sxdDZ1T01pd2NldVBNc2ZEZFRtbktvUDFvTmtqL3JNR01pN0U3?=
 =?utf-8?B?ZWJKaFVwUGVnUGdrT0Rld3lFWmFqbFI4NThRZ1pBV2NHNnFCL1Uza1Q2NjhV?=
 =?utf-8?B?bHBDVXAxNnJ6RmI0c05GYzY4UkdsWGYrN3U4NWx4WHR1UzVTUGFsRUV1YTZp?=
 =?utf-8?B?VSszOE8wUG5MUVBaK1p6NmNhbGY2VkhucHBteHFHU0FpT09TVllHMXk3a3Uy?=
 =?utf-8?B?dkFZQS9JbkVzUms5aGpZbzIrYWppQW41U3lDcEJPTEwraFlIWDBzekRoc0ZY?=
 =?utf-8?B?WHFxY0RVZ29KQmphSWlPRmFrVk9uL2VDRXlCQk8vMXRUNHR6NWMwSW15SFh0?=
 =?utf-8?B?czRrY09OWU1nNUF5RWptN3Fmc1dtTkpoZDRDSkozMXNPcCtVUDc4WCtMQmVX?=
 =?utf-8?B?MkVPUWY4YjNFUFJERFA2eUlFVzZFUVN2NlVDWnU3YVliYnFEcTFIUDkrMVZn?=
 =?utf-8?B?K3ovdlpiRUNscHgwSVoyQnBtMkxKZ2s0Vm8raEJuZE1jK2dZRXBqdFlPd1dh?=
 =?utf-8?B?cFdDWkNwdGJYeVFUZUVzSDhmWSs3S0ZtT25uZlZJaHdZa2Z5SDhVSy9sOEdi?=
 =?utf-8?Q?WTIXuFMjl7Q6cPEfD80p5xRHK?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45abe988-7828-4f55-bf4e-08db1c057dd3
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3683.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2023 16:36:51.7000
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /L79ZHXSU7uW38ekL2JSpDvbSnRu2FGkOGsjvUx/8cpl+8dH8V7BG3bFNUfwPBAr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4535
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/2/23 5:10 PM, Mathieu Poirier wrote:
> Hi,
>
> On Tue, Feb 28, 2023 at 01:02:16PM -0800, Tanmay Shah wrote:
>> This patch makes each r5 core mailbox client and uses
>> tx and rx channels to send and receive data to/from
>> remote processor respectively. This is needed for rpmsg
>> communication to remote processor.
>>
>> Signed-off-by: Tanmay Shah <tanmay.shah@amd.com>
>> ---
>>
>> Changes in v4:
>>    - move zynqmp_r5_setup_mbox from zynqmp_r5_add_rproc_core to
>>      zynqmp_r5_cluster_init
>>
>> Changes in v3:
>>    - fix multi-line comment format
>>    - do not mixup mailbox information with memory-regions
>>    - fix redundant dev_warn for split mode
>>    - setting up mailboxes should return an error code
>>    - redesign driver to move mailbox setup during driver probe
>>    - add .kick function only if mailbox setup is success
>>
>> v2: https://lore.kernel.org/all/20230126213154.1707300-1-tanmay.shah@amd.com/
>>
>>   drivers/remoteproc/xlnx_r5_remoteproc.c | 227 +++++++++++++++++++++++-
>>   1 file changed, 225 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/remoteproc/xlnx_r5_remoteproc.c b/drivers/remoteproc/xlnx_r5_remoteproc.c
>> index 5dd007622603..78c1638ccef0 100644
>> --- a/drivers/remoteproc/xlnx_r5_remoteproc.c
>> +++ b/drivers/remoteproc/xlnx_r5_remoteproc.c
>> @@ -8,16 +8,23 @@
>>   #include <linux/dma-mapping.h>
>>   #include <linux/firmware/xlnx-zynqmp.h>
>>   #include <linux/kernel.h>
>> +#include <linux/mailbox_client.h>
>> +#include <linux/mailbox/zynqmp-ipi-message.h>
>>   #include <linux/module.h>
>>   #include <linux/of_address.h>
>>   #include <linux/of_platform.h>
>>   #include <linux/of_reserved_mem.h>
>>   #include <linux/platform_device.h>
>>   #include <linux/remoteproc.h>
>> -#include <linux/slab.h>
>>   
>>   #include "remoteproc_internal.h"
>>   
>> +/* IPI buffer MAX length */
>> +#define IPI_BUF_LEN_MAX	32U
>> +
>> +/* RX mailbox client buffer max length */
>> +#define MBOX_CLIENT_BUF_MAX	(IPI_BUF_LEN_MAX + \
>> +				 sizeof(struct zynqmp_ipi_message))
>>   /*
>>    * settings for RPU cluster mode which
>>    * reflects possible values of xlnx,cluster-mode dt-property
>> @@ -43,6 +50,27 @@ struct mem_bank_data {
>>   	char *bank_name;
>>   };
>>   
>> +/**
>> + * struct mbox_info
>> + *
>> + * @rx_mc_buf: to copy data from mailbox rx channel
>> + * @tx_mc_buf: to copy data to mailbox tx channel
>> + * @r5_core: this mailbox's corresponding r5_core pointer
>> + * @mbox_work: schedule work after receiving data from mailbox
>> + * @mbox_cl: mailbox client
>> + * @tx_chan: mailbox tx channel
>> + * @rx_chan: mailbox rx channel
>> + */
>> +struct mbox_info {
>> +	unsigned char rx_mc_buf[MBOX_CLIENT_BUF_MAX];
>> +	unsigned char tx_mc_buf[MBOX_CLIENT_BUF_MAX];
>> +	struct zynqmp_r5_core *r5_core;
>> +	struct work_struct mbox_work;
>> +	struct mbox_client mbox_cl;
>> +	struct mbox_chan *tx_chan;
>> +	struct mbox_chan *rx_chan;
>> +};
>> +
>>   /*
>>    * Hardcoded TCM bank values. This will be removed once TCM bindings are
>>    * accepted for system-dt specifications and upstreamed in linux kernel
>> @@ -63,6 +91,7 @@ static const struct mem_bank_data zynqmp_tcm_banks[] = {
>>    * @tcm_banks: array of each TCM bank data
>>    * @rproc: rproc handle
>>    * @pm_domain_id: RPU CPU power domain id
>> + * @ipi: pointer to mailbox information
>>    */
>>   struct zynqmp_r5_core {
>>   	struct device *dev;
>> @@ -71,6 +100,7 @@ struct zynqmp_r5_core {
>>   	struct mem_bank_data **tcm_banks;
>>   	struct rproc *rproc;
>>   	u32 pm_domain_id;
>> +	struct mbox_info *ipi;
>>   };
>>   
>>   /**
>> @@ -88,6 +118,178 @@ struct zynqmp_r5_cluster {
>>   	struct zynqmp_r5_core **r5_cores;
>>   };
>>   
>> +/**
>> + * event_notified_idr_cb() - callback for vq_interrupt per notifyid
>> + * @id: rproc->notify id
>> + * @ptr: pointer to idr private data
>> + * @data: data passed to idr_for_each callback
>> + *
>> + * Pass notification to remoteproc virtio
>> + *
>> + * Return: 0. having return is to satisfy the idr_for_each() function
>> + *          pointer input argument requirement.
>> + **/
>> +static int event_notified_idr_cb(int id, void *ptr, void *data)
>> +{
>> +	struct rproc *rproc = data;
>> +
>> +	if (rproc_vq_interrupt(rproc, id) == IRQ_NONE)
>> +		dev_dbg(&rproc->dev, "data not found for vqid=%d\n", id);
>> +
>> +	return 0;
>> +}
>> +
>> +/**
>> + * handle_event_notified() - remoteproc notification work function
>> + * @work: pointer to the work structure
>> + *
>> + * It checks each registered remoteproc notify IDs.
>> + */
>> +static void handle_event_notified(struct work_struct *work)
>> +{
>> +	struct mbox_info *ipi;
>> +	struct rproc *rproc;
>> +
>> +	ipi = container_of(work, struct mbox_info, mbox_work);
>> +	rproc = ipi->r5_core->rproc;
>> +
>> +	/*
>> +	 * We only use IPI for interrupt. The RPU firmware side may or may
>> +	 * not write the notifyid when it trigger IPI.
>> +	 * And thus, we scan through all the registered notifyids and
>> +	 * find which one is valid to get the message.
>> +	 * Even if message from firmware is NULL, we attempt to get vqid
>> +	 */
>> +	idr_for_each(&rproc->notifyids, event_notified_idr_cb, rproc);
>> +}
>> +
>> +/**
>> + * zynqmp_r5_mb_rx_cb() - receive channel mailbox callback
>> + * @cl: mailbox client
>> + * @msg: message pointer
>> + *
>> + * Receive data from ipi buffer, ack interrupt and then
>> + * it will schedule the R5 notification work.
>> + */
>> +static void zynqmp_r5_mb_rx_cb(struct mbox_client *cl, void *msg)
>> +{
>> +	struct zynqmp_ipi_message *ipi_msg, *buf_msg;
>> +	struct mbox_info *ipi;
>> +	size_t len;
>> +
>> +	ipi = container_of(cl, struct mbox_info, mbox_cl);
>> +
>> +	/* copy data from ipi buffer to r5_core */
>> +	ipi_msg = (struct zynqmp_ipi_message *)msg;
>> +	buf_msg = (struct zynqmp_ipi_message *)ipi->rx_mc_buf;
>> +	len = ipi_msg->len;
>> +	if (len > IPI_BUF_LEN_MAX) {
>> +		dev_warn(cl->dev, "msg size exceeded than %d\n",
>> +			 IPI_BUF_LEN_MAX);
>> +		len = IPI_BUF_LEN_MAX;
>> +	}
>> +	buf_msg->len = len;
>> +	memcpy(buf_msg->data, ipi_msg->data, len);
>> +
>> +	/* received and processed interrupt ack */
>> +	if (mbox_send_message(ipi->rx_chan, NULL) < 0)
>> +		dev_err(cl->dev, "ack failed to mbox rx_chan\n");
>> +
>> +	schedule_work(&ipi->mbox_work);
>> +}
>> +
>> +/**
>> + * zynqmp_r5_setup_mbox() - Setup mailboxes related properties
>> + *			    this is used for each individual R5 core
>> + *
>> + * @cdev: child node device
>> + *
>> + * Function to setup mailboxes related properties
>> + * return : NULL if failed else pointer to mbox_info
>> + */
>> +static struct mbox_info *zynqmp_r5_setup_mbox(struct device *cdev)
>> +{
>> +	struct mbox_client *mbox_cl;
>> +	struct mbox_info *ipi;
>> +
>> +	ipi = kzalloc(sizeof(*ipi), GFP_KERNEL);
>> +	if (!ipi)
>> +		return NULL;
>> +
>> +	mbox_cl = &ipi->mbox_cl;
>> +	mbox_cl->rx_callback = zynqmp_r5_mb_rx_cb;
>> +	mbox_cl->tx_block = false;
>> +	mbox_cl->knows_txdone = false;
>> +	mbox_cl->tx_done = NULL;
>> +	mbox_cl->dev = cdev;
>> +
>> +	/* Request TX and RX channels */
>> +	ipi->tx_chan = mbox_request_channel_byname(mbox_cl, "tx");
>> +	if (IS_ERR(ipi->tx_chan)) {
>> +		ipi->tx_chan = NULL;
>> +		kfree(ipi);
>> +		dev_warn(cdev, "mbox tx channel request failed\n");
>> +		return NULL;
>> +	}
>> +
>> +	ipi->rx_chan = mbox_request_channel_byname(mbox_cl, "rx");
>> +	if (IS_ERR(ipi->rx_chan)) {
>> +		mbox_free_channel(ipi->tx_chan);
>> +		ipi->rx_chan = NULL;
>> +		ipi->tx_chan = NULL;
>> +		kfree(ipi);
>> +		dev_warn(cdev, "mbox rx channel request failed\n");
>> +		return NULL;
>> +	}
>> +
>> +	INIT_WORK(&ipi->mbox_work, handle_event_notified);
>> +
>> +	return ipi;
>> +}
>> +
>> +static void zynqmp_r5_free_mbox(struct mbox_info *ipi)
>> +{
>> +	if (!ipi)
>> +		return;
>> +
>> +	if (ipi->tx_chan) {
>> +		mbox_free_channel(ipi->tx_chan);
>> +		ipi->tx_chan = NULL;
>> +	}
>> +
>> +	if (ipi->rx_chan) {
>> +		mbox_free_channel(ipi->rx_chan);
>> +		ipi->rx_chan = NULL;
>> +	}
>> +
>> +	kfree(ipi);
>> +}
>> +
>> +/*
>> + * zynqmp_r5_core_kick() - kick a firmware if mbox is provided
>> + * @rproc: r5 core's corresponding rproc structure
>> + * @vqid: virtqueue ID
>> + */
>> +static void zynqmp_r5_rproc_kick(struct rproc *rproc, int vqid)
>> +{
>> +	struct zynqmp_r5_core *r5_core = rproc->priv;
>> +	struct device *dev = r5_core->dev;
>> +	struct zynqmp_ipi_message *mb_msg;
>> +	struct mbox_info *ipi;
>> +	int ret;
>> +
>> +	ipi = r5_core->ipi;
>> +	if (!ipi)
>> +		return;
>> +
>> +	mb_msg = (struct zynqmp_ipi_message *)ipi->tx_mc_buf;
>> +	memcpy(mb_msg->data, &vqid, sizeof(vqid));
>> +	mb_msg->len = sizeof(vqid);
>> +	ret = mbox_send_message(ipi->tx_chan, mb_msg);
>> +	if (ret < 0)
>> +		dev_warn(dev, "failed to send message\n");
>> +}
>> +
>>   /*
>>    * zynqmp_r5_set_mode()
>>    *
>> @@ -614,7 +816,7 @@ static int zynqmp_r5_rproc_unprepare(struct rproc *rproc)
>>   	return 0;
>>   }
>>   
>> -static const struct rproc_ops zynqmp_r5_rproc_ops = {
>> +static struct rproc_ops zynqmp_r5_rproc_ops = {
>>   	.prepare	= zynqmp_r5_rproc_prepare,
>>   	.unprepare	= zynqmp_r5_rproc_unprepare,
>>   	.start		= zynqmp_r5_rproc_start,
>> @@ -673,6 +875,7 @@ static struct zynqmp_r5_core *zynqmp_r5_add_rproc_core(struct device *cdev)
>>   	}
>>   
>>   	r5_core->rproc = r5_rproc;
>> +
> Spurious change.

Ack will remove it.


>>   	return r5_core;
>>   
>>   free_rproc:
>> @@ -799,6 +1002,7 @@ static int zynqmp_r5_cluster_init(struct zynqmp_r5_cluster *cluster)
>>   	struct device_node *child;
>>   	enum rpu_tcm_comb tcm_mode;
>>   	int core_count, ret, i;
>> +	struct mbox_info *ipi;
>>   
>>   	ret = of_property_read_u32(dev_node, "xlnx,cluster-mode", &cluster_mode);
>>   
>> @@ -869,6 +1073,18 @@ static int zynqmp_r5_cluster_init(struct zynqmp_r5_cluster *cluster)
>>   
>>   		child_devs[i] = &child_pdev->dev;
>>   
>> +		/*
>> +		 * If mailbox nodes are disabled using "status" property then
>> +		 * setting up mailbox channels will be failed. In that case we
>> +		 * don't really need kick() operation. Include .kick() only if
>> +		 * mbox channels are acquired successfully.
>> +		 */
>> +		ipi = zynqmp_r5_setup_mbox(&child_pdev->dev);
>> +		if (ipi)
>> +			zynqmp_r5_rproc_ops.kick = zynqmp_r5_rproc_kick;
>> +		else
>> +			zynqmp_r5_rproc_ops.kick = NULL;
>> +
> Based on the way this patchset has turned out, I don't think it is required to
> do this anymore.  After all, .kick() won't be called if the mailboxes aren't
> initialized.
>
> Please move the call to zynqmp_r5_setup_mbox() just below in the next hunk.


I don't understand this.

So, we are still registering kick call back even if mailboxes aren't setup ?

I am okay with that, I will check flow once more.


>
> Thanks,
> Mathieu
>
>>   		/* create and add remoteproc instance of type struct rproc */
>>   		r5_cores[i] = zynqmp_r5_add_rproc_core(&child_pdev->dev);
>>   		if (IS_ERR(r5_cores[i])) {
>> @@ -878,6 +1094,11 @@ static int zynqmp_r5_cluster_init(struct zynqmp_r5_cluster *cluster)
>>   			goto release_r5_cores;
>>   		}
>>   
>> +		if (ipi) {
>> +			r5_cores[i]->ipi = ipi;
>> +			ipi->r5_core = r5_cores[i];
>> +		}
>> +
>>   		/*
>>   		 * If two child nodes are available in dts in lockstep mode,
>>   		 * then ignore second child node.
>> @@ -915,6 +1136,7 @@ static int zynqmp_r5_cluster_init(struct zynqmp_r5_cluster *cluster)
>>   	while (i >= 0) {
>>   		put_device(child_devs[i]);
>>   		if (r5_cores[i]) {
>> +			zynqmp_r5_free_mbox(r5_cores[i]->ipi);
>>   			of_reserved_mem_device_release(r5_cores[i]->dev);
>>   			rproc_del(r5_cores[i]->rproc);
>>   			rproc_free(r5_cores[i]->rproc);
>> @@ -939,6 +1161,7 @@ static void zynqmp_r5_cluster_exit(void *data)
>>   
>>   	for (i = 0; i < cluster->core_count; i++) {
>>   		r5_core = cluster->r5_cores[i];
>> +		zynqmp_r5_free_mbox(r5_core->ipi);
>>   		of_reserved_mem_device_release(r5_core->dev);
>>   		put_device(r5_core->dev);
>>   		rproc_del(r5_core->rproc);
>> -- 
>> 2.25.1
>>
