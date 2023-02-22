Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60CE169FD2B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 21:47:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232802AbjBVUrN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 15:47:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231268AbjBVUrL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 15:47:11 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2087.outbound.protection.outlook.com [40.107.93.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 233B23BDA9;
        Wed, 22 Feb 2023 12:47:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IQPh6js2yziJ0T2tW1wtbQP8hnAzIgbCNQgjVeHwFF0BCIMRkTNHOC/+WsZ+vrlKBoxbvnelLLQcQalmBXi7e6bSPTWfcTqQygZCQzjhSkiCxu4pA7ipPvwr/jlMaVcX3HiPKOtm4ZIMRYUrUGWAEwj5fdzTXSWjMVwh3KtkNVftL8wrbZV0jdUpuG8aWEu5Rp+PqmxXiHb18pg4TkORr6Q8S5EzmKOsc4k1HRyFj9jfRAdHZkPDhRQhPpb+xpDNQrOmmP2l3IhYxnpaiZWQmcOrA4WrE96gntEwFNx5JEuHIHdcVB6Thge0edEJqtinBS9QJTKseHfyfM8jXtIBpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8k6yGffUjEthslUBTFdb4AAwJZnMx5zybqKgOrqaYpI=;
 b=iNLXdWYfHOwkHDzCH7e2ATzImG5ym2p1lWZTM7mE+an/88RIY3nOsntIergICe4G2S1BPChs1Z4bgmCAohdE3FLugwQk/HjckSfYYjkr38GnmQKRJlk66eQGfh1BLQThwu7dm8fL+/lec9zlaWBSk9VGqd4NdschLMEpZRn1wJmqSiFOdQO5HmObCoEdkLEyosk+GeWtsu+M2nZdKF4GnSvEmg+c7/AE9jcREsR72SIKzP2mvGsL8gff7EX3m3fH5l+94pfVKjjgycPOxe0rucrqL7WhIbOYHeIKSkZ8XA+AOiFmZjaQjGjmckK1GBkqoiu1uiORuh3e/RcN7gYf4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8k6yGffUjEthslUBTFdb4AAwJZnMx5zybqKgOrqaYpI=;
 b=f0n2/TDhK4rj5VwXzCyB7rlbcqRfif4CyigW5mZUcB/vvhJGBoLmoJ5Mak8t81MwSD7cXeXJRYgYzJcViiviwYyLiCgiLsxIRUcCmfj8MMvhLnk0ni9+xjL07OwnkITHrjadT3LCV8qQKwV4ysxo745DvzDdroomn2q6+uwaCwM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB3688.namprd12.prod.outlook.com (2603:10b6:610:28::33)
 by IA0PR12MB8352.namprd12.prod.outlook.com (2603:10b6:208:3dd::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.19; Wed, 22 Feb
 2023 20:47:07 +0000
Received: from CH2PR12MB3688.namprd12.prod.outlook.com
 ([fe80::bc3c:ddda:b3b:9fcc]) by CH2PR12MB3688.namprd12.prod.outlook.com
 ([fe80::bc3c:ddda:b3b:9fcc%5]) with mapi id 15.20.6111.020; Wed, 22 Feb 2023
 20:47:07 +0000
Message-ID: <051c1902-2e76-9fa3-1b82-e55387f834dc@amd.com>
Date:   Wed, 22 Feb 2023 14:47:02 -0600
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:110.0)
 Gecko/20100101 Thunderbird/110.0
Subject: Re: [PATCH v3 2/3] drivers: remoteproc: xilinx: fix carveout names
Content-Language: en-US
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Tanmay Shah <tanmay.shah@amd.com>
Cc:     michal.simek@amd.com, andersson@kernel.org,
        jaswinder.singh@linaro.org, ben.levinsky@amd.com,
        shubhrajyoti.datta@amd.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-remoteproc@vger.kernel.org
References: <20230213211825.3507034-1-tanmay.shah@amd.com>
 <20230213211825.3507034-3-tanmay.shah@amd.com> <20230222184135.GB909075@p14s>
From:   Tanmay Shah <tanmays@amd.com>
In-Reply-To: <20230222184135.GB909075@p14s>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0070.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::15) To CH2PR12MB3688.namprd12.prod.outlook.com
 (2603:10b6:610:28::33)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3688:EE_|IA0PR12MB8352:EE_
X-MS-Office365-Filtering-Correlation-Id: 1348a67c-7d8d-42a9-6ceb-08db1515f610
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KJ1ks5JyxGEN8dksoUqqEGe/njuyAWhgUbzJSb2gh0LSzQ1ofVW2cGhNmArNA5f+oyndVoPY37ZtcGvqH2JKCr7hUWJYKeiM0TJoHazEPK+PmfcxjqbrCzTvMrJ/usUAbkMmsQqMdeK3Wd6MEgnySlVuT2wLSMg//Y6Q3HClFJxsoOw0LhZRAK5oUrm57dDnQj+TZwp2m9LL2fu+gOu6rymVaTz+AcaYDRph1Atw71K0cB1xrIoCk/DzfmHaF9CCaYKrlqo5qlaBicEX/x26T0pKQSsEQYwT+KbiBCFiYAk0ESceYd40De8SXkCX2nh2+vu31mrbupGlbH/8A2VD5UBwChbYnCx6Y/4uH6ewKvlS/67DFraY8xVd/WSIR6Eek96n7HrXFiq8x420uK4/w2c+tC2luJqupxnzDjKQypN71EUg79zYxgRV3R3jTnd5/XfAB+VfO2O1j0tJgJk1nfuHhiQGB7J6UYwM+7D9JaGemavUnCgjIwBrLaXo3SSTc8z0DccDcfk8apyfK1ttSHUirVv/7m57iSgerF6V7WO2o+3dyuusNr/oY+jw0bAvto5TeNafRVtjiDle2vXSg3OiPiSAHmS3oC684ipOF0QPhi5J9G/5fQTozNBQ1g49gMG7O4D6nznval57Nn3ho3aCTAJsnkWRRxZ3xQo6L8r1G6LbMM3qnYoSn57ZB5NngimrXPmwdNralCP7eIvKU9og2mt8ZSzK2rw5Jpp1fwA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3688.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(136003)(39860400002)(366004)(346002)(396003)(451199018)(31696002)(31686004)(38100700002)(83380400001)(2616005)(6636002)(316002)(8936002)(8676002)(4326008)(5660300002)(110136005)(66556008)(966005)(478600001)(36756003)(6486002)(41300700001)(66476007)(66946007)(2906002)(6512007)(53546011)(6666004)(6506007)(186003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MzlnSXZwbGdCVWM4ZmlLZUh4ekxoWjdpakVWNVRqbUVJZ2NzaVRXSEY4YnM4?=
 =?utf-8?B?c2c0MmYyZzRWczJWRjFpdnB2MVh3T3FocXp1VXIwTXJYT0NOcnBkYjlkaXZu?=
 =?utf-8?B?dHJMM296S3FlR052LzlPOWhueFFHUzJIdEY2bFhoMVpCeUFNc1JpeG5WSHh5?=
 =?utf-8?B?UGwzOC95MkNwd2luS0hHbTQyT0REa1lpTXhwZTZZNm4zRHBxMC9nKzF5NlhS?=
 =?utf-8?B?ajVXTXVaSUtuMWVGMmdlTjU1Ni95MCtERGI0c3FSeVlycXFlOENKRDZUaDRI?=
 =?utf-8?B?eTVqQXNmRm8rQ0xodlZtdENRaENvN0loVE0rSkl3RDExV2p4SHM4c09wTGxi?=
 =?utf-8?B?a2ErVXpzZldrcDI4dWhiaktzM0RvOWNlaFVPWk1HWDRBOVhhNXE4L1BDUHR1?=
 =?utf-8?B?WXNBanR2QlJrb1FGcTlHVGtBRHVSVkQ4aXRmRGlERjU1em14RHZIbzN3Uyta?=
 =?utf-8?B?OWJrc2dMVkNYNzNyRkpVdm1vYkpWUkJVRWIzeUZsaVphMklSRStMNDhsU3po?=
 =?utf-8?B?amlQekFIRnFqa0lmR3Z2NE9YTmZQS0hqeWt3bnhnTC9ZZ1V6K2tINWZhYmNs?=
 =?utf-8?B?aGZ6cXNRY1VmUkRDNE01eG1rRHZVWDhyaFZPZ2hNY0xJODNYM1kxdUw4a3Y5?=
 =?utf-8?B?d3RiZU5aVm5PSmNrMDVETzI2Nm1lZzVPN0xBMFBsSWdpTGlyMlVERHhnSXVG?=
 =?utf-8?B?eWhQU3UwaG1EWGtnZlFjYXhxV1NaYjNGY01GVEV2MGJDSUJTMVR6VVUyUW1z?=
 =?utf-8?B?WGQwQWVvcEFqeFVkeSt6NDlwK0FjYms5RkdtS016WmxQenF3TzVUQ2xPTExp?=
 =?utf-8?B?cFBIbW9uRUE5RmROay8vSG1UQk1Ya0xyYTRzZnp5bFVQQTF0dFp1Q3phMEhT?=
 =?utf-8?B?TjYrUlFwWVJ6ekpEd2RBYmNGcjJpQmx3eXVrcHpHR0tsM0ZqQWRJQmxuTE8r?=
 =?utf-8?B?UmdYUFNCQUx6bU1uT2RRNEFBVGtraW90WTFRcU1mTkVUWTBZN1BFa3hZamZQ?=
 =?utf-8?B?OHZoVjJFbHNBajR4SlVBcm5Fck15L1NtUyt2VHN5cmd3a0h1a2ZEUWhnQmNw?=
 =?utf-8?B?VmZPbW01NzRCSFc0YTZ1K28rZW4rYytsbVdoTld2YmNJVERGYUZyb1p2Z3Nt?=
 =?utf-8?B?b2FxRURiZWdCUVFTZC8rWERoSC95K0lZSVNkMldNS2JnZFozODVCNStIS2FH?=
 =?utf-8?B?TVI5R055N0wyYUlVeUVJL0hqekJ0SG90eWJFVGtobUdpRnNsZWNvY2NXSXNT?=
 =?utf-8?B?dVh6L2ZhUGduUUNVUGRGMVZzblFHa1ZtM3Jud2s2Q09LVWhKSXh2aXh4SGJO?=
 =?utf-8?B?ZGxGYktRRUtCd3dpVlZ1M0NXcHVna3hrbkE2cy9vaHRyMmZGNUxweE5oYWcr?=
 =?utf-8?B?RUE2WkIzMnFxLytPZzZxQVYreGd5dDY5ZTUwcTk2Q0Yyb3c3SVY5enMrdVdt?=
 =?utf-8?B?SS9mek9zQzFsZ2lZWmdWU0xQVlMxRitwVE5UeHNBREFxRzNtWDZpR2dDZzBT?=
 =?utf-8?B?ZlRCVFRxbzlVS3h0YjNFUVBaZkd6cEJmL0xNc0V6MzBFa3ZsQVY0N0ZCMVdH?=
 =?utf-8?B?cTZaOUxDUDlUVDRIbzhEZ2t5R0QyRzZrbjNCRm4xS3VPTTRXa0RpcUtxY1VY?=
 =?utf-8?B?Mm1DUzQycVdEMmxrWkZOVFIxcDAwaEx0bm1YeHB1UUFHMUpJeXVnY0RXZHps?=
 =?utf-8?B?aWx3Z2tycE12TnhWcHhmeWFxQVdlNDVTVXNJc0xDaGpycmFnb3pDdVhBWWo2?=
 =?utf-8?B?cVl0OUhTK1AvSEpncHhHZTRpUytUaHhTSHV2OW45Rm9YOG9XT0cxQU90ZDVw?=
 =?utf-8?B?em5TcHdIa3FXeWd4TXBmS2JnZUlDczkyL0o4MXp0aGR6NTVrMUpWR2o5THV4?=
 =?utf-8?B?bnJKZTM0aVdHVkJsRmJkc1BIK081cy9BRFIwbnZua1FacnRBZG44SmQ3dzBL?=
 =?utf-8?B?azV3R3BQQVMrWmxHTjBVenlack13aHNXWjNLVjhadDVwWFU4SXdTd0N5bUlM?=
 =?utf-8?B?ZGx2UG1MVXFNS1JTNHFhOWs4Vy8vL2thOGU0RmRJOUVIcE5QeXlrbTJvVnIv?=
 =?utf-8?B?M1BCRGNwdjNzZmVhdVptYlNPOW1ORzcweEdGVkNFaFR0L2hSZXdxY2FxUG5h?=
 =?utf-8?B?c3RiUWZ2bXhmNFJWSWpUSHZRTE1RQTJDVlVKaFJjc2ZXN0t5L3BzUnpzMGc3?=
 =?utf-8?Q?31MftzLMQHU2ONwRBKAOdn2dQ3b8mDpIpB0RSyHSojgT?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1348a67c-7d8d-42a9-6ceb-08db1515f610
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3688.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2023 20:47:07.3106
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FxaVc1DbQpI2fSEsaFx+uU1DlEJ46fFrfzoygIFAoQvce8QaliMgccof+iTyZ6aM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8352
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

Thanks for the reviews. I agree to all the comments and will address in 
the next revision accordingly.

Thanks,

Tanmay

On 2/22/23 10:41 AM, Mathieu Poirier wrote:
> On Mon, Feb 13, 2023 at 01:18:25PM -0800, Tanmay Shah wrote:
>> If the unit address is appended to node name of memory-region,
>> then adding rproc carveouts fails as node name and unit-address
>> both are passed as carveout name (i.e. vdev0vring0@xxxxxxxx). However,
>> only node name is expected by remoteproc framework. This patch moves
>> memory-region node parsing from driver probe to prepare and
>> only passes node-name and not unit-address
>>
>> Fixes: 6b291e8020a8 ("drivers: remoteproc: Add Xilinx r5 remoteproc driver")
>> Signed-off-by: Tanmay Shah <tanmay.shah@amd.com>
>> ---
>>
>> Changelog:
>>    - This is first version of this change, however posting as part of the series
>>      that has version v3. The v2 of the series could be found at following link.
>>
>> v2: https://lore.kernel.org/all/20230126213154.1707300-1-tanmay.shah@amd.com/
>>
>>   drivers/remoteproc/xlnx_r5_remoteproc.c | 87 ++++++-------------------
>>   1 file changed, 20 insertions(+), 67 deletions(-)
>>
>> diff --git a/drivers/remoteproc/xlnx_r5_remoteproc.c b/drivers/remoteproc/xlnx_r5_remoteproc.c
>> index 2db57d394155..81af2dea56c2 100644
>> --- a/drivers/remoteproc/xlnx_r5_remoteproc.c
>> +++ b/drivers/remoteproc/xlnx_r5_remoteproc.c
>> @@ -61,8 +61,6 @@ static const struct mem_bank_data zynqmp_tcm_banks[] = {
>>    * @np: device node of RPU instance
>>    * @tcm_bank_count: number TCM banks accessible to this RPU
>>    * @tcm_banks: array of each TCM bank data
>> - * @rmem_count: Number of reserved mem regions
>> - * @rmem: reserved memory region nodes from device tree
>>    * @rproc: rproc handle
>>    * @pm_domain_id: RPU CPU power domain id
>>    */
>> @@ -71,8 +69,6 @@ struct zynqmp_r5_core {
>>   	struct device_node *np;
>>   	int tcm_bank_count;
>>   	struct mem_bank_data **tcm_banks;
>> -	int rmem_count;
>> -	struct reserved_mem **rmem;
>>   	struct rproc *rproc;
>>   	u32 pm_domain_id;
>>   };
>> @@ -239,21 +235,31 @@ static int add_mem_regions_carveout(struct rproc *rproc)
>>   {
>>   	struct rproc_mem_entry *rproc_mem;
>>   	struct zynqmp_r5_core *r5_core;
>> +	struct device_node *rmem_np;
>>   	struct reserved_mem *rmem;
>>   	int i, num_mem_regions;
>>   
>>   	r5_core = (struct zynqmp_r5_core *)rproc->priv;
>> -	num_mem_regions = r5_core->rmem_count;
>> +
>> +	num_mem_regions = of_property_count_elems_of_size(r5_core->np, "memory-region",
>> +							  sizeof(phandle));
>>   
>>   	for (i = 0; i < num_mem_regions; i++) {
>> -		rmem = r5_core->rmem[i];
>>
> Extra line
>
> Everyone else in the remoteproc subsystem is using of_phandle_iterator_next(),
> please do the same.  It is easier to maintain and you don't have to call
> of_node_put() after each iteration.
>
>
>> -		if (!strncmp(rmem->name, "vdev0buffer", strlen("vdev0buffer"))) {
>> +		rmem_np = of_parse_phandle(r5_core->np, "memory-region", i);
>> +
>> +		rmem = of_reserved_mem_lookup(rmem_np);
>> +		if (!rmem) {
>> +			of_node_put(rmem_np);
>> +			return -EINVAL;
>> +		}
>> +
>> +		if (!strcmp(rmem_np->name, "vdev0buffer")) {
>>   			/* Init reserved memory for vdev buffer */
>>   			rproc_mem = rproc_of_resm_mem_entry_init(&rproc->dev, i,
>>   								 rmem->size,
>>   								 rmem->base,
>> -								 rmem->name);
>> +								 rmem_np->name);
>>   		} else {
>>   			/* Register associated reserved memory regions */
>>   			rproc_mem = rproc_mem_entry_init(&rproc->dev, NULL,
>> @@ -261,16 +267,20 @@ static int add_mem_regions_carveout(struct rproc *rproc)
>>   							 rmem->size, rmem->base,
>>   							 zynqmp_r5_mem_region_map,
>>   							 zynqmp_r5_mem_region_unmap,
>> -							 rmem->name);
>> +							 rmem_np->name);
>>   		}
>>   
>> -		if (!rproc_mem)
>> +		if (!rproc_mem) {
>> +			of_node_put(rmem_np);
> When moving to of_phandle_iterator_next(), of_node_put(it.node) has to be
> called on error conditions.  Other drivers don't do it, something I will fix in
> the next cycle.
>
>>   			return -ENOMEM;
>> +		}
>>   
>>   		rproc_add_carveout(rproc, rproc_mem);
>>   
>>   		dev_dbg(&rproc->dev, "reserved mem carveout %s addr=%llx, size=0x%llx",
>>   			rmem->name, rmem->base, rmem->size);
>> +
>> +		of_node_put(rmem_np);
>>   	}
>>   
>>   	return 0;
>> @@ -726,59 +736,6 @@ static int zynqmp_r5_get_tcm_node(struct zynqmp_r5_cluster *cluster)
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
>>   /*
>>    * zynqmp_r5_core_init()
>>    * Create and initialize zynqmp_r5_core type object
>> @@ -806,10 +763,6 @@ static int zynqmp_r5_core_init(struct zynqmp_r5_cluster *cluster,
>>   	for (i = 0; i < cluster->core_count; i++) {
>>   		r5_core = cluster->r5_cores[i];
>>   
>> -		ret = zynqmp_r5_get_mem_region_node(r5_core);
>> -		if (ret)
>> -			dev_warn(dev, "memory-region prop failed %d\n", ret);
>> -
>>   		/* Initialize r5 cores with power-domains parsed from dts */
>>   		ret = of_property_read_u32_index(r5_core->np, "power-domains",
>>   						 1, &r5_core->pm_domain_id);
>> -- 
>> 2.25.1
>>
