Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28AE1688638
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 19:17:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232039AbjBBSRj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 13:17:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232056AbjBBSRh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 13:17:37 -0500
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2066.outbound.protection.outlook.com [40.107.95.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF47D6F709;
        Thu,  2 Feb 2023 10:17:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ARos6LjFDD/X7f7sXrqnR4N3xb+g9bE56wqSJ91aN0qMPOdQeo9CZoM5hybVtcAQlA7XcjSROAZt4diyAsiV9iAzLoMKFnEd67b06vVue4k1gwoMquTvmGpze98Mxv2Y5WmuBxthCFwXszdiWx37Mf/jsmKrjKPNxxFGj7d7HEEM3Aw23kNjh0aXKakoWJsnZIMTLTyTe9EuOOg7rDM6Ir+Bz2FcHBk8I2f/rPYcpvxUDAWbjnaelRivkn6ur26hCWLAbRniBmGSDN5uAA2MaxkLUC8VP7t+/UlAcwUVfTXBlyMOpu7ririsqQxExSxl/MCH+paxAwrnFcWgfL6b1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xzc3sMYXNqSI7if69sAvd0BXK8uRE/LQa4enoWLu/ck=;
 b=OsYeOCE/ZCC74eKYAh1jvb48bfCw/p2HKjDZb20xcT20ZfWXaASgNSR8yLCZ2Ni26O7xWKiNeHr1AbHZYA1k0B0xiIilwP9Y74G9+eCKFizd6J74kphnkkimQRRM7kGJRQzi/9+vsxqBJMbtooFReNy8s6CluNyPpeNuAd0WiNp7E+4qWTD31g3Ahfn4HASKJJv4mgIOKuqmXWXld0EeJ4/Z4OMEraO/3XGMRXhVJGY4ztXKSlQiXSUt/jBXGej7cYD0BhPKdRIYJRtoaDzO1VqKGWXnKwWo5Bi89RR5yA9hZRewXpoOdC23PEIShgrnwvjbkADaK41TAyVRCz9hbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xzc3sMYXNqSI7if69sAvd0BXK8uRE/LQa4enoWLu/ck=;
 b=w+onFW26VkwcswkBABr2uAeV4Fi6h22IpFXfTIyV8hkTMVDpJAoL/kA4jGCCYngo6JpGPr1gl4R9ty5HhMJ5F3YA10Q7ezLD/4W3uqFCzso4exIHDcsoaexByc7HSQZt7mS1VzdH3WNp/LFp+nVxguN1A1LT4cigZCzIESqrobc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BY5PR12MB3683.namprd12.prod.outlook.com (2603:10b6:a03:1a5::16)
 by CY5PR12MB6648.namprd12.prod.outlook.com (2603:10b6:930:42::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.27; Thu, 2 Feb
 2023 18:17:31 +0000
Received: from BY5PR12MB3683.namprd12.prod.outlook.com
 ([fe80::3ddf:d47:b37a:5a7a]) by BY5PR12MB3683.namprd12.prod.outlook.com
 ([fe80::3ddf:d47:b37a:5a7a%7]) with mapi id 15.20.6064.027; Thu, 2 Feb 2023
 18:17:31 +0000
Message-ID: <7cdfb802-ad57-d3ac-c632-88077f2c605f@amd.com>
Date:   Thu, 2 Feb 2023 10:17:28 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:109.0)
 Gecko/20100101 Thunderbird/109.0
Subject: Re: [PATCH v2] remoteproc: xilinx: add mailbox channels for rpmsg
Content-Language: en-US
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        "Shah, Tanmay" <tanmay.shah@amd.com>
Cc:     "andersson@kernel.org" <andersson@kernel.org>,
        "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20230126213154.1707300-1-tanmay.shah@amd.com>
 <20230131225957.GA217823@p14s>
From:   Tanmay Shah <tanmays@amd.com>
In-Reply-To: <20230131225957.GA217823@p14s>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0107.namprd03.prod.outlook.com
 (2603:10b6:a03:333::22) To BY5PR12MB3683.namprd12.prod.outlook.com
 (2603:10b6:a03:1a5::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB3683:EE_|CY5PR12MB6648:EE_
X-MS-Office365-Filtering-Correlation-Id: 25676bff-42c9-4258-7778-08db0549bf9a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sSzJa0txCzVcU4PIvijHEwlCBVaxGDZapZF167r9S0nRRQinaIu9a0OErn/ZeGtCbutLjW/cjK2FjrkI8ByhachROnAf/HopOpRUnliKlKYb0iD1GwP8cFmls5hhcO5TLOS42PxkCI8KTRLuCXx+ry99QhEcr6JwljahjjpgJRyF3uSZ5NjvQGGe4h4ASefqXEPpvPdfubmHZ5TcAfwwm4oLzjEvX/Iy6Yya+j9DXnrmH3NpIr3a21sg6u03RR3l/520WUdNxZqPga+S43kM1c+RSuLDfvalF4/f96ZtCpm/aTTz2cAXnTXt/COMjXAe0vXBoze3B8XMl29errfzZpCb2H6VNQkdsbJMWmJEzeIeG5zpzxTHuPBq6SBS4YwE5zB847GdLri6IsM1oNap4D5NBJaQgtuth7IwijyuBj7sIMD/P2wQ+0z38HF9xsFHkv5YD3bB4QbrHPeTu6IM6sZpNg/eVtIiaWvUtjB8wbFXK5Xs0MwiPtt/bU9nbPvtU99HE3UaVYdkkF8zbU0/AmbkxVUZHVT2JJxO68JDFHZKHpKX8MJwrgNZSI1VV81CYimqc3K+zszUDU46cwTGbz2jGlWRIK0qV2XbpkZGHeAsMV9LFQxY619+nP0wHVg7Yk8W5LsFjBFjOldzQrNMbzj7ju5x3zkCO1V/D02ZxM3Qq91dvV+lAN2Eaz4JGuiiu1cMeFK77nLk14AMJybDKeg9xtJXzHOBjat1QvcSdLVWAPqNsepEWEk2ZFcCJgjo
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB3683.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(136003)(346002)(376002)(366004)(396003)(451199018)(6666004)(6636002)(54906003)(2616005)(83380400001)(66476007)(31696002)(66556008)(36756003)(4326008)(41300700001)(30864003)(5660300002)(53546011)(6506007)(316002)(8676002)(66946007)(8936002)(31686004)(186003)(6512007)(38100700002)(15650500001)(478600001)(6486002)(110136005)(2906002)(17423001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dzJMSWU0SThjLzBMWW4yenNHK200SWJWcUdJcSthMmdNVUF1c1duVUtOYVpE?=
 =?utf-8?B?K25XQ3F3dE54K2xlczRUNFM4YlpmakVwN25yQ09KL3VvK1FLemw4MEQwM1JG?=
 =?utf-8?B?RmpDMjhQeHV1cjJ3RkluN1IzT0lUREo5YVpXY2lOcUM4QUxVM21DK3BrVmJH?=
 =?utf-8?B?eS9GWjE2RTg3OXFMNkRtWElWUjJPdVpWQ01CWWpDUmJ6aThMQlNrVE9jZFpJ?=
 =?utf-8?B?dFFybWNrbjhtM0kwdFpySzBvelRxZk82TzUwOHh0cmtMVFJ6eUZlVWI5TXVL?=
 =?utf-8?B?OFBxcUR5M2pMWHdqRW5JclV3bGdRZHRsUkNZOTRacGtMR2F4WkI3bTZBNnpO?=
 =?utf-8?B?NHpQZWx5R25pVmtneHFLUmlUVmdnK1JiWFhpaSt0dFBub3lKb2ZnSDM4VHVq?=
 =?utf-8?B?blhRZVU2UjJiTWNEbTVVcTNzWjVJTFh4OUhFUmxLSHgxd1BhcmE1WkxleUhv?=
 =?utf-8?B?R3Mwb1dqNTg4a1kwMFRTRVIwOGU3M1NLZUpmeVRaRUFYLzVJUmRDL004c0sy?=
 =?utf-8?B?U0J1QkdBY2IvU2N1R3A4YWpHWmQvZm9USUd4dWt6VWVhTnJvMC9xbll6V01v?=
 =?utf-8?B?WjFlcUt1aFg2UzhqWDNxbjhYKzNFZ29mV2VBYVZkbUR4YUI2L2I3NkNhQjVG?=
 =?utf-8?B?ellwdE0wcGxhdHdSeU9rSmxjU3ZoRjlMUkdlYlpDNjZVdWtmWXdxSlhTcFBk?=
 =?utf-8?B?KzU2VFR2aWRvVWpVQVloTFc4VlZuT3YzdWgybS9XUVdScnllNkxvVzRnUzJC?=
 =?utf-8?B?SlNUZkFueEhwRnBJdFVUd2k4RXlYazd2blNZY2k0S1RBbW1maU4xQmZiQXcr?=
 =?utf-8?B?U1pOVkJTNEtYOW9OMU5seGVOQUdzN2J6bGpVY2s4YXczQ29KWmc0aEo3NlVH?=
 =?utf-8?B?enBybHpnYTZMYUZEYWpmM21CbHdNcXJyalQ1VEthS2R0NmlVK1FiTUR4cU84?=
 =?utf-8?B?S0pjLytVazVZblF1eENQaGZlaUtSYXlWNmdpaDhFUExneFlnRFBKdDBmZmpY?=
 =?utf-8?B?eXNpeHZURFBVMG4zcnVlN3V5N05lYWduN3F5bWc1UndReTJoZjlsQ0V6K2x3?=
 =?utf-8?B?RmlNbGNyUmNIaXYyRkRWNFJqY1AxMnQwdnY0aDBhMUhyakZpMG1BMnFldFlh?=
 =?utf-8?B?Mko0TDlOTHBtdGlpUHlLM1dxWTM4cXR5NnlnZzJWZkNGOVlkZ3UzbHA0eDVr?=
 =?utf-8?B?M1pyUWtEK25SNHdMeHdJa2I1ajJzN3p2bTFQeEUwWTNGSzR3K3dGekE4MHpx?=
 =?utf-8?B?R0E0b242N3Y4Z01KUW1CcjA1TmVtc21oZ2s4QTBlMTQxdUlPMDl4dkdEVWJz?=
 =?utf-8?B?VVV6MCtEZzR1RFZGbmhhNWlhT3lZdlZPTTI4VDVQV2E2SkFjamJvaHREL1pL?=
 =?utf-8?B?cnNmaGlNb3RrVU9QK0hXN3dOMEdZbkJLbk9WcUlCM2dQaGliWEdYeVZtTkxk?=
 =?utf-8?B?bTBOa0wyVlk2U0YrUnFvS05SYVB0aG85N1NQcUo3ZU1Oem9Ob1pyMkhqVUpH?=
 =?utf-8?B?bnBzRHVpU2pHcVdvMUNjK05zQWNaRU5QVC9NbUpnQzltQ3B3Qm5OOGppSEcv?=
 =?utf-8?B?V2xqSzBqWVpiLy9mVkYzU3V3MGhWd29yTXpnMVR2cXg1QVFvT1dXdzVMM1JV?=
 =?utf-8?B?bTZWcU9XTGRaOVRHcXBIMTFSNVNlWDhGQ1RVeHZNaDQ3RHJpeXc3clZlcnhG?=
 =?utf-8?B?V1QxdDNSYmV4SDJVVC8wVUpNMm04QTFaM2NYWDA5eGF4dGx3cUZudlVrZk5z?=
 =?utf-8?B?b1hvQkRqT2dKVFZNUWl5UjR2a0NVYmJFY3RJS0p1Tk9kZEw5NGVQaU1vbGxq?=
 =?utf-8?B?USt1T2VxOE43L0svYlQzZzVWazVrT3Jtc3VNd0NRd0dVT2thdzBvVlZiZXBC?=
 =?utf-8?B?MWxiSjN0VHJSb0VOdTBoM0FTemZOd05qUDJwbnNyWXUzYUZ0N3g5ZmtDdVls?=
 =?utf-8?B?TkJDcGIrVW1uaGhFZmZoT1d4YUlXR09Eb1BoUVJpNDk5Q3JxK0E1cUFBMmNK?=
 =?utf-8?B?SzVJK0RoZEFpbXpBdUx3ang2d3kxSzJMd3FKZzZ1VU9sT2JCZnZkdXB3WlZa?=
 =?utf-8?B?cEZzUmJkbndYaWg3MWdhc2F5dnA5ZGhEUEs5TE5aemV6UkdFUXFQVUoxNWp2?=
 =?utf-8?B?c0VNRjF2ZGJzMExDWWR0Y3JKNFppOHV5Q2UyMEFabGF6eS93TVZGWjBDdHU0?=
 =?utf-8?Q?YE/4BdbRRtf1W++GFqpjBjDLP4eUhh4zNFv8cy2BM12q?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25676bff-42c9-4258-7778-08db0549bf9a
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3683.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2023 18:17:30.9786
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6r3xmA66ap4nDwDOCJG+2Mwc49NeEcXuY1kpgurxQ/7LjkIDSYn9lgBwOU7mPvrX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6648
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mathieu,

Thanks for reviews.

Please find my comments below.

On 1/31/23 2:59 PM, Mathieu Poirier wrote:
> Good afternoon,
>
> On Thu, Jan 26, 2023 at 01:31:54PM -0800, Tanmay Shah wrote:
>> This patch makes each r5 core mailbox client and uses
>> tx and rx channels to send and receive data to/from
>> remote processor respectively. This is needed for rpmsg
>> communication to remote processor.
>>
>> Signed-off-by: Tanmay Shah <tanmay.shah@amd.com>
>> ---
>>
>> Changes in v2:
>>    - fix vrings carveout names as expeceted by remoteproc framework
>>
> This should be in a patch on its own along with a "Fixes" tag.

Ack.

Next time I will send series of two patches.

First patch to fix vrings name with fixes tag and second patch to add 
mailbox support.


>
>>   drivers/remoteproc/xlnx_r5_remoteproc.c | 352 ++++++++++++++++++++----
>>   1 file changed, 292 insertions(+), 60 deletions(-)
>>
>> diff --git a/drivers/remoteproc/xlnx_r5_remoteproc.c b/drivers/remoteproc/xlnx_r5_remoteproc.c
>> index 2db57d394155..45ce7f2089bf 100644
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
> The documentation for struct zynqmp_ipi_message clearly states that @data is
> fixed to 12 bytes, whereas here is it set to 32 bytes.  Wrong documentation or
> bug?

As per hardware reference manual, each message buffer is 32-bytes. There 
should be bug in IPI driver documentation.

I will test this before sending new patch. If 32-bytes are supported, 
then I will send patch to fix IPI driver with fixes tag as well.


>> +/* RX mailbox client buffer max length */
>> +#define MBOX_CLIENT_BUF_MAX	(IPI_BUF_LEN_MAX + \
>> +				 sizeof(struct zynqmp_ipi_message))
>>   /*
>>    * settings for RPU cluster mode which
>>    * reflects possible values of xlnx,cluster-mode dt-property
>> @@ -65,6 +72,12 @@ static const struct mem_bank_data zynqmp_tcm_banks[] = {
>>    * @rmem: reserved memory region nodes from device tree
>>    * @rproc: rproc handle
>>    * @pm_domain_id: RPU CPU power domain id
>> + * @rx_mc_buf: to copy data from mailbox rx channel
>> + * @tx_mc_buf: to copy data to mailbox tx channel
>> + * @mbox_work: schedule work after receiving data from mailbox
>> + * @mbox_cl: mailbox client
>> + * @tx_chan: mailbox tx channel
>> + * @rx_chan: mailbox rx channel
>>    */
>>   struct zynqmp_r5_core {
>>   	struct device *dev;
>> @@ -75,6 +88,14 @@ struct zynqmp_r5_core {
>>   	struct reserved_mem **rmem;
>>   	struct rproc *rproc;
>>   	u32 pm_domain_id;
>> +
>> +	/* mailbox related data structures */
>> +	unsigned char rx_mc_buf[MBOX_CLIENT_BUF_MAX];
>> +	unsigned char tx_mc_buf[MBOX_CLIENT_BUF_MAX];
>> +	struct work_struct mbox_work;
>> +	struct mbox_client mbox_cl;
>> +	struct mbox_chan *tx_chan;
>> +	struct mbox_chan *rx_chan;
>>   };
>>   
>>   /**
>> @@ -92,6 +113,181 @@ struct zynqmp_r5_cluster {
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
>> +	struct zynqmp_r5_core *r5_core;
>> +	struct rproc *rproc;
>> +
>> +	r5_core = container_of(work, struct zynqmp_r5_core, mbox_work);
>> +	rproc = r5_core->rproc;
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
>> +	struct zynqmp_r5_core *r5_core;
>> +	size_t len;
>> +
>> +	r5_core = container_of(cl, struct zynqmp_r5_core, mbox_cl);
>> +
>> +	/* copy data from ipi buffer to r5_core */
>> +	ipi_msg = (struct zynqmp_ipi_message *)msg;
>> +	buf_msg = (struct zynqmp_ipi_message *)r5_core->rx_mc_buf;
>> +	len = ipi_msg->len;
>> +	if (len > IPI_BUF_LEN_MAX) {
>> +		dev_warn(r5_core->dev, "msg size exceeded than %d\n",
>> +			 IPI_BUF_LEN_MAX);
>> +		len = IPI_BUF_LEN_MAX;
>> +	}
>> +	buf_msg->len = len;
>> +	memcpy(buf_msg->data, ipi_msg->data, len);
>> +
>> +	/* received and processed interrupt ack */
>> +	if (mbox_send_message(r5_core->rx_chan, NULL) < 0)
>> +		dev_err(r5_core->dev, "ack failed to mbox rx_chan\n");
>> +
>> +	schedule_work(&r5_core->mbox_work);
>> +}
>> +
>> +/**
>> + * zynqmp_r5_setup_mbox() - Setup mailboxes related properties
>> + *			    this is used for each individual R5 core
>> + *
>> + * @r5_core: pointer to the ZynqMP r5 core data
>> + *
>> + * Function to setup mailboxes related properties
>> + *
>> + */
>> +static void zynqmp_r5_setup_mbox(struct zynqmp_r5_core *r5_core)
>> +{
>> +	struct zynqmp_r5_cluster *cluster;
>> +	struct mbox_client *mbox_cl;
>> +
>> +	cluster = dev_get_drvdata(r5_core->dev->parent);
>> +
>> +	/**
> Extra '*', please remove.

ACK.


>
>> +	 * ToDo: Use only one IPI channel for APU to communicate with both RPUs
>> +	 * in split mode. As of now, two IPI channels are expeceted for APU
>> +	 * to communicate with RPU. for example, APU(IPI0)<-> RPU0(IPI1) and
>> +	 * APU(IPI7)<->RPU1(IPI2). However, this is not the optimized use
>> +	 * of the hardware. As per hardware reference manual, each IPI channel
>> +	 * can receive interrupt from another IPI channel. So APU must be able
>> +	 * to communicate with both RPUs simultaneously using same IPI channel.
>> +	 * For example, this is valid case: APU(IPI0)<->RPU0(IPI1) and
>> +	 * APU(IPI0)<->RPU1(IPI2). However, with current available examples
>> +	 * and RPU firmware, this configuration in device-tree is causing system-crash.
>> +	 * And so, using extra IPI channel is required in device-tree. In split
>> +	 * mode explicitly inform user about this limitation and requirement.
>> +	 */
>> +	if (cluster->mode == SPLIT_MODE)
>> +		dev_warn(r5_core->dev, "split mode: APU should use two IPI channels\n");
> This comment doesn't do anything useful, please remove.


ACK.


>
>> +
>> +	mbox_cl = &r5_core->mbox_cl;
>> +	mbox_cl->rx_callback = zynqmp_r5_mb_rx_cb;
>> +	mbox_cl->tx_block = false;
>> +	mbox_cl->knows_txdone = false;
>> +	mbox_cl->tx_done = NULL;
>> +	mbox_cl->dev = r5_core->dev;
>> +
>> +	/* Request TX and RX channels */
>> +	r5_core->tx_chan = mbox_request_channel_byname(mbox_cl, "tx");
>> +	if (IS_ERR(r5_core->tx_chan)) {
>> +		r5_core->tx_chan = NULL;
>> +		return;
>> +	}
>> +
>> +	r5_core->rx_chan = mbox_request_channel_byname(mbox_cl, "rx");
>> +	if (IS_ERR(r5_core->rx_chan)) {
>> +		mbox_free_channel(r5_core->tx_chan);
>> +		r5_core->rx_chan = NULL;
>> +		r5_core->tx_chan = NULL;
>> +		return;
>> +	}
>> +
>> +	INIT_WORK(&r5_core->mbox_work, handle_event_notified);
>> +}
>> +
>> +static void zynqmp_r5_free_mbox(struct zynqmp_r5_core *r5_core)
>> +{
>> +	if (r5_core->tx_chan) {
>> +		mbox_free_channel(r5_core->tx_chan);
>> +		r5_core->tx_chan = NULL;
>> +	}
>> +
>> +	if (r5_core->rx_chan) {
>> +		mbox_free_channel(r5_core->rx_chan);
>> +		r5_core->rx_chan = NULL;
>> +	}
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
>> +	int ret;
>> +
>> +	/* don't handle kick if mbox setup failed for this core */
>> +	if (!r5_core->tx_chan && !r5_core->rx_chan)
>> +		return;
>> +
>> +	mb_msg = (struct zynqmp_ipi_message *)r5_core->tx_mc_buf;
>> +	memcpy(mb_msg->data, &vqid, sizeof(vqid));
>> +	mb_msg->len = sizeof(vqid);
>> +	ret = mbox_send_message(r5_core->tx_chan, mb_msg);
>> +	if (ret < 0)
>> +		dev_warn(dev, "failed to send message\n");
>> +}
>> +
>>   /*
>>    * zynqmp_r5_set_mode()
>>    *
>> @@ -227,6 +423,63 @@ static int zynqmp_r5_mem_region_unmap(struct rproc *rproc,
>>   	return 0;
>>   }
>>   
>> +/**
>> + * zynqmp_r5_get_mem_region_node()
>> + * parse memory-region property and get reserved mem regions
>> + *
>> + * @r5_core: pointer to zynqmp_r5_core type object
>> + *
>> + * Return: 0 for success and error code for failure.
>> + */
>> +static int zynqmp_r5_get_mem_region_node(struct zynqmp_r5_core *r5_core)
>> +{
>> +	struct device_node *np, *rmem_np;
>> +	struct reserved_mem **rmem;
>> +	int res_mem_count, i;
>> +	struct device *dev;
>> +
>> +	dev = r5_core->dev;
>> +	np = r5_core->np;
>> +
>> +	res_mem_count = of_property_count_elems_of_size(np, "memory-region",
>> +							sizeof(phandle));
>> +
>> +	if (res_mem_count <= 0) {
>> +		dev_warn(dev, "failed to get memory-region property %d\n",
>> +			 res_mem_count);
>> +		return 0;
>> +	}
>> +
>> +	if (!r5_core->tx_chan && !r5_core->rx_chan)
>> +		res_mem_count = 1;
> Hackish, please remove.  There should not be a need to mix mailbox information
> with memory regions.

ACK.


>
>> +
>> +	rmem = devm_kcalloc(dev, res_mem_count,
>> +			    sizeof(struct reserved_mem *), GFP_KERNEL);
>> +	if (!rmem)
>> +		return -ENOMEM;
>> +
>> +	for (i = 0; i < res_mem_count; i++) {
>> +		rmem_np = of_parse_phandle(np, "memory-region", i);
>> +		if (!rmem_np)
>> +			goto release_rmem;
>> +
>> +		rmem[i] = of_reserved_mem_lookup(rmem_np);
>> +		if (!rmem[i]) {
>> +			of_node_put(rmem_np);
>> +			goto release_rmem;
>> +		}
>> +
>> +		of_node_put(rmem_np);
>> +	}
>> +
>> +	r5_core->rmem_count = res_mem_count;
>> +	r5_core->rmem = rmem;
>> +	return 0;
>> +
>> +release_rmem:
>> +	return -EINVAL;
>> +}
>> +
>>   /*
>>    * add_mem_regions_carveout()
>>    * @rproc: single R5 core's corresponding rproc instance
>> @@ -241,6 +494,7 @@ static int add_mem_regions_carveout(struct rproc *rproc)
>>   	struct zynqmp_r5_core *r5_core;
>>   	struct reserved_mem *rmem;
>>   	int i, num_mem_regions;
>> +	const char *name;
>>   
>>   	r5_core = (struct zynqmp_r5_core *)rproc->priv;
>>   	num_mem_regions = r5_core->rmem_count;
>> @@ -253,15 +507,33 @@ static int add_mem_regions_carveout(struct rproc *rproc)
>>   			rproc_mem = rproc_of_resm_mem_entry_init(&rproc->dev, i,
>>   								 rmem->size,
>>   								 rmem->base,
>> -								 rmem->name);
>> +								 "vdev0buffer");
> This looks very hackish.
>
>>   		} else {
>> +			/*
>> +			 * As per bindings 3rd entry in memory-region property
>> +			 * must contain vring0 and 4th entry must contain vring1
>> +			 * memory-regions. For remoteproc framework it is
>> +			 * required to have fixed names for these carveouts i.e.
>> +			 * in the form of "vdev%dvring%d" where first %d is ID
>> +			 * of vdev and second %d is ID of vring. Assign fix names
>> +			 * instead of node names, as node names may contain
>> +			 * @unit-address as well i.e. vdev0vring0@xxxxxxxx which
>> +			 * won't work.
>> +			 */
>> +			if (!strncmp(rmem->name, "vdev0vring0", strlen("vdev0vring0")))
>> +				name = "vdev0vring0";
>> +			else if (!strncmp(rmem->name, "vdev0vring1", strlen("vdev0vring1")))
>> +				name = "vdev0vring1";
>> +			else
>> +				name = rmem->name;
>> +
> So does this.  It would be much better to get the right rmem->name before
> getting to this function, something that should be done in
> zynqmp_r5_get_mem_region_node().  Look at stm32_rproc_prepare() for an example
> on how to get the right name reserve memory entries.
>
> I am also reasonning this problem has become obvious now that mailboxes are
> working.  That said I also think it should have been caught when the patchset
> adding support for r5f was worked on.

Yes correct. Actually I had tested with only one core at a time.

During testing my device-tree had only node name and not node address 
(i.e. @xxxxxx)

So, I couldn't catch the issue. Also, mailbox wasn't supported so I 
couldn't put vrings to use at

that time. I started facing the issue when both cores were up 
simultaneously and I couldn't put

duplicate node names and I started adding vrings node addresses.

I will see how to parse node-name only from format "node-name@unit-address".

That should resolve all above hacks.

Thanks,

Tanmay


>>   			/* Register associated reserved memory regions */
>>   			rproc_mem = rproc_mem_entry_init(&rproc->dev, NULL,
>>   							 (dma_addr_t)rmem->base,
>>   							 rmem->size, rmem->base,
>>   							 zynqmp_r5_mem_region_map,
>>   							 zynqmp_r5_mem_region_unmap,
>> -							 rmem->name);
>> +							 name);
>>   		}
>>   
>>   		if (!rproc_mem)
>> @@ -572,6 +844,20 @@ static int zynqmp_r5_rproc_prepare(struct rproc *rproc)
>>   		return ret;
>>   	}
>>   
>> +	/*
>> +	 * If mailbox nodes are disabled using "status" property then setting up
>> +	 * mailbox channels will be failed and in that case, we don't need vrings
>> +	 * and vdevbuffer for this core. So, setup mailbox before parsing
>> +	 * memory-region property. If "tx" and "rx" mailboxes are not setup, then
>> +	 * only parse and add first memory-region carveout. As per bindings, it
>> +	 * must be firmware load region
>> +	 */
>> +	zynqmp_r5_setup_mbox(rproc->priv);
>> +
> Setting up mailboxes should return an error code when not successful.


In case of failure that function is printing relative error messages. 
However, If mailbox nodes

are disabled in device-tree with status property, then it is expected 
that mailbox setup will fail. However,

that should not stop remoteproc LCM functionality as user still should 
be able to start/stop/loadfw functionality.

So, I did not see need to return error code.

I will add return error code, however that won't stop rest of the driver 
functionality. I can just print some warning

message based on error code.


>   Moreover,
> why do mailboxes have to be initialised at prepare() time and not once in the
> probe() function?

ACK.

This part I will take care. I will let you know if I face any problems 
while moving this to probe otherwise I am okay.


>
>> +	ret = zynqmp_r5_get_mem_region_node(rproc->priv);
>> +	if (ret)
>> +		dev_warn(&rproc->dev, "memory-region prop failed %d\n", ret);
>> +
>>   	ret = add_mem_regions_carveout(rproc);
>>   	if (ret) {
>>   		dev_err(&rproc->dev, "failed to get reserve mem regions %d\n", ret);
>> @@ -597,6 +883,8 @@ static int zynqmp_r5_rproc_unprepare(struct rproc *rproc)
>>   
>>   	r5_core = (struct zynqmp_r5_core *)rproc->priv;
>>   
>> +	zynqmp_r5_free_mbox(r5_core);
>> +
>>   	for (i = 0; i < r5_core->tcm_bank_count; i++) {
>>   		pm_domain_id = r5_core->tcm_banks[i]->pm_domain_id;
>>   		if (zynqmp_pm_release_node(pm_domain_id))
>> @@ -617,6 +905,7 @@ static const struct rproc_ops zynqmp_r5_rproc_ops = {
>>   	.find_loaded_rsc_table = rproc_elf_find_loaded_rsc_table,
>>   	.sanity_check	= rproc_elf_sanity_check,
>>   	.get_boot_addr	= rproc_elf_get_boot_addr,
>> +	.kick		= zynqmp_r5_rproc_kick,
> A kick() function should added only when mailboxes are present rather than
> invariably as it is now.


May be I am missing something but, I believe this is const variable and 
I may not be able to modify it once initialized.

Is it ok to remove const? then I can take care of adding kick based on 
mbox is available or not.


>
>>   };
>>   
>>   /**
>> @@ -726,59 +1015,6 @@ static int zynqmp_r5_get_tcm_node(struct zynqmp_r5_cluster *cluster)
>>   	return 0;
>>   }
>>   
>> -/**
>> - * zynqmp_r5_get_mem_region_node()
>> - * parse memory-region property and get reserved mem regions
>> - *
>> - * @r5_core: pointer to zynqmp_r5_core type object
>> - *
>> - * Return: 0 for success and error code for failure.
>> - */
>> -static int zynqmp_r5_get_mem_region_node(struct zynqmp_r5_core *r5_core)
>> -{
>> -	struct device_node *np, *rmem_np;
>> -	struct reserved_mem **rmem;
>> -	int res_mem_count, i;
>> -	struct device *dev;
>> -
>> -	dev = r5_core->dev;
>> -	np = r5_core->np;
>> -
>> -	res_mem_count = of_property_count_elems_of_size(np, "memory-region",
>> -							sizeof(phandle));
>> -	if (res_mem_count <= 0) {
>> -		dev_warn(dev, "failed to get memory-region property %d\n",
>> -			 res_mem_count);
>> -		return 0;
>> -	}
>> -
>> -	rmem = devm_kcalloc(dev, res_mem_count,
>> -			    sizeof(struct reserved_mem *), GFP_KERNEL);
>> -	if (!rmem)
>> -		return -ENOMEM;
>> -
>> -	for (i = 0; i < res_mem_count; i++) {
>> -		rmem_np = of_parse_phandle(np, "memory-region", i);
>> -		if (!rmem_np)
>> -			goto release_rmem;
>> -
>> -		rmem[i] = of_reserved_mem_lookup(rmem_np);
>> -		if (!rmem[i]) {
>> -			of_node_put(rmem_np);
>> -			goto release_rmem;
>> -		}
>> -
>> -		of_node_put(rmem_np);
>> -	}
>> -
>> -	r5_core->rmem_count = res_mem_count;
>> -	r5_core->rmem = rmem;
>> -	return 0;
>> -
>> -release_rmem:
>> -	return -EINVAL;
>> -}
>> -
> Why was this moved instead of simply adding a forward declaration at the top of
> the file?


ACK. That's good idea. Thanks!


>
>>   /*
>>    * zynqmp_r5_core_init()
>>    * Create and initialize zynqmp_r5_core type object
>> @@ -806,10 +1042,6 @@ static int zynqmp_r5_core_init(struct zynqmp_r5_cluster *cluster,
>>   	for (i = 0; i < cluster->core_count; i++) {
>>   		r5_core = cluster->r5_cores[i];
>>   
>> -		ret = zynqmp_r5_get_mem_region_node(r5_core);
>> -		if (ret)
>> -			dev_warn(dev, "memory-region prop failed %d\n", ret);
>> -
> Why doing this since this driver doesn't support attach()/detach() operations
> yet?


I see, so we should always fail if memory-region property isn't defined?

Actually it is also possible to load and boot firmware completely out of 
TCM.

Since the driver has TCM addresses, we don't really need memory-region 
property at all in

that case. So by not failing when memory-region is not defined, we are 
giving chance to

load and boot firmware from TCM. I can add this in comment.

Thanks,

Tanmay


> Thanks,
> Mathieu
>
>>   		/* Initialize r5 cores with power-domains parsed from dts */
>>   		ret = of_property_read_u32_index(r5_core->np, "power-domains",
>>   						 1, &r5_core->pm_domain_id);
>>
>> base-commit: 10de8156ed71d3dbd7e9099aa76e67ea2c37d4ff
>> -- 
>> 2.25.1
>>
