Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34D3E6E9352
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 13:48:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234252AbjDTLsM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 07:48:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjDTLsJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 07:48:09 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2134.outbound.protection.outlook.com [40.107.244.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A3EA1701
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 04:48:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QzTQFDdSMIYRX9/OEk/xuJKg/F0Fv452UkuDIQHPQgTpPG+a7vXA0qB9oZl8GRVynicGJadUZfWB9aJxVONDKqsPZE7zxcvE4Hkv3SeHtPcAGgeRp1ajdkHgD0PKUTAKq/F2SjeKmgBVuKpKw56qVthByujNqHAMzvoPtyxnOhyCV3q2zhP5NFjzC4DBzjj6WmMXDDB5GpaOloekM8quEydEyVU4WYiUHQyEjNqWbRsEXq4uuRjfPxF31tX1ocBIa18d+7bzQvFKmKlvYR1/LdHN5bQlO/Uux2kj7LHirVkkleg1HsvolCVBlIY1pghoLxISm9N2QOjT5hBVQNlebQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a91vEP44sIrBwsaXeoVRZc+68rtrp7L/yqZoI4VIFmE=;
 b=BTe6HxeR/p37GuU9FGrLxbWZ7MwfofMgbO6YMn8OkALCOYmFGBAV/YKDmQu9JYKAnyKUiZrz6GZ8uQ7ziwLcZM6CdkhD8QratUQ4g5z7fbBhBDc7AOP3T+BOG6XKBBC8ejHPvygswYrneIOSCclE1Fg3HRaWeMLoNtPX5NbSX5ZPS5C/FwCXPrfVQs/RILGC0SVzCEBwl5MQqPBkigJ8YPlTmmsyAS+QRP0ykrK3rJSCNeKs+uSQkI+/qazXFJdK1fUhcev+La6Xphi6uxJ8wegWkEOiRMx40TC1ZZzUMvYF1pjY1R9+x1fN2y4gpaV8nCbrDC/5grsexJ2wIuSP1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a91vEP44sIrBwsaXeoVRZc+68rtrp7L/yqZoI4VIFmE=;
 b=nbyfWQQa9e3P6yD31RMDeG3vbteJc+MTkV9PMeMftTnl7+00rOOexZvTlTLdh38Y2/h8BErvKUP8Xj6SGq7kzw9OeoFWPND6D7/cg8N7B8kg+Ns6dP7tQ2/WHSOfPNwuwr6V6OhJgQ+GijM/RXUwPmKYaKMtDchaeXI2GHcuh04=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from DM8PR01MB6824.prod.exchangelabs.com (2603:10b6:8:23::24) by
 BN7PR01MB3828.prod.exchangelabs.com (2603:10b6:406:84::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6340.11; Thu, 20 Apr 2023 11:48:02 +0000
Received: from DM8PR01MB6824.prod.exchangelabs.com
 ([fe80::5cf:2baf:f5ab:ac87]) by DM8PR01MB6824.prod.exchangelabs.com
 ([fe80::5cf:2baf:f5ab:ac87%5]) with mapi id 15.20.6319.022; Thu, 20 Apr 2023
 11:48:02 +0000
Message-ID: <84eb3363-2ef8-d3f1-4613-805959dbf334@os.amperecomputing.com>
Date:   Thu, 20 Apr 2023 17:17:54 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] perf cs-etm: Add support for coresight trace for any
 range of CPUs
Content-Language: en-US
To:     James Clark <james.clark@arm.com>
Cc:     mathieu.poirier@linaro.org, acme@kernel.org,
        darren@os.amperecomputing.com, scott@os.amperecomputing.com,
        scclevenger@os.amperecomputing.com, linux-kernel@vger.kernel.org,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        mike.leach@linaro.org, suzuki.poulose@arm.com
References: <20230419172101.78638-1-gankulkarni@os.amperecomputing.com>
 <d758c5e2-aa32-d829-35ee-a685bdb56f75@arm.com>
From:   Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>
In-Reply-To: <d758c5e2-aa32-d829-35ee-a685bdb56f75@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0312.namprd03.prod.outlook.com
 (2603:10b6:610:118::21) To DM8PR01MB6824.prod.exchangelabs.com
 (2603:10b6:8:23::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR01MB6824:EE_|BN7PR01MB3828:EE_
X-MS-Office365-Filtering-Correlation-Id: 34c727f4-652b-4357-acec-08db41951869
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6CkItOnayS1oyC+QQmRFvY6R4gdYL0VAeHG6bMLFdJ6McoQLA2AJHQ6yKF5DPL+09faA/I+N20qWBZ6UePw1hHTsbBSTgxYIpLlR1T7I/TPDUwdDgJ3FyGpS1ok/HZ4eJB+JiXikaTYAuz3nihLQ+AQyYE0m4BJqsOllKSAyLn3nE3iqTCsY0onfZ23GlywlZI5Mdjk5IGkEp7lZnYA55t/XyLf5Zo1daN2YoJ3YVEhK7eMqFgyTGcouUSbTx+ny2eLfRsfPuyLukfOJutv8ntWGCSD+3FN86OMhCXL9+NjcrURRwJUzidabktpl3gg5Jo5Fg6grke0g22aqzx+vAUt0BDQZ4RrAs/Sn/K+ZTyTnBZG6DzAR420QCB+hpbWUkANBjFsrjcLXJtiM59ZdAWq5WMenLk1Q9zGkkTlXfeNKjl0K0s+p1EFx6xlm4FQXEYuZsN33Bqw1CJhbd9733MLRpJDM6+RdVMI+lS9xaWWzagk0iQyuYb2KYhxK0resiRR9NVOC4TweItnVnhq+QnBvTBFllCDZnQIEUVn4Q4V2dmApTJ8lmlqsj5Z+KrRgDS/rWIzWm6qfN27taAIJBvWpfsTzBJFlwVRMANCe1QM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR01MB6824.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(346002)(136003)(39850400004)(376002)(451199021)(478600001)(83380400001)(2616005)(6506007)(186003)(53546011)(6512007)(26005)(86362001)(31696002)(38100700002)(6666004)(966005)(6486002)(316002)(8936002)(8676002)(41300700001)(4326008)(66556008)(66476007)(6916009)(66946007)(5660300002)(2906002)(31686004)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Qm9HYUNDQUlRTGl4QmFJTnVvOEhoVk1CRUtGckN1V2pXZG8wN2lEb2dVckx3?=
 =?utf-8?B?QmV3QTFLeXdjSWxNcXNPUU5WT01Nem1pYnpiMzN6TEJWc21zVkJOZUIxM3gw?=
 =?utf-8?B?NmpqVldYNGpHT091cGRaZUV1S3ZVZWlucGdaZll0VW14UkpBSlVSRzhjZ1BC?=
 =?utf-8?B?QXdtaUdGa0RBZUVjZ2RzeXJySzJvN2s1bTRlN2IxclVYMkt1UVBwZURqeXB5?=
 =?utf-8?B?Q0V5NGFXUVNaY0VxL0FRVHptSDNOb2Y0bzBJY1lhaE1HVEUyZ1RFSk1JK2Fw?=
 =?utf-8?B?Q1Boc3d4ZXNhTmx6ZVg0aHFjZXF1ZkJCWG5iK2FYZ3czOVdPMmh6cWl2UWtK?=
 =?utf-8?B?OCsxZmgyQUJUbVFCaHVpVVhaY1NVRkx3cmRIdTBHdzV6YzRySjR0RUs0Nmkv?=
 =?utf-8?B?ZDB0QlpkVTR6YnFIMGdkVWZLMWJIZHBneWxWRWROZEZjRzZZYmh3eGErdk54?=
 =?utf-8?B?cVpidHFtRmV6VVA3cVc0OFYxc3NRQnpFdzE0MVlHdVd4VDFFL1pFT2E1djA4?=
 =?utf-8?B?K2ljWUZueVdqWGptblJLV1ltOUtQcDJ5YUhhcTRQN2JZTzA3YlN2N2gvYWdM?=
 =?utf-8?B?YkZkemM2Mzh1aTFPYmRJc25Kb080V3BoT0tYR1lGQ0M5Q21tUU5oNE9DL0xE?=
 =?utf-8?B?UCt2ME9GWnpmT1hHSncxdFFKZmhvNzVHODBDbDYrN0VwTzY4bEdCRjVlSWVY?=
 =?utf-8?B?TDBGZ3VQYkgyRG5YdEFEN1JQclVmY1FpVDJZdE11TmUzVXEzSldkTU1IeUxp?=
 =?utf-8?B?cktWdHdQdnpuSFE4c3VFbVJKWmtqbDRHQUNaUGpOZStBSitCbk50ekVWTDJj?=
 =?utf-8?B?S09ubkkwem9zWEtIRUVlb2dRTFJ3enI3blpiWnhiTkdBa0pCSVdVS0NCUVVj?=
 =?utf-8?B?SWpFcHZUOUFqT01wL3JpSmFIWmRyY0FlL3VxRlE2cHVOT2NnYTRVeHo0b095?=
 =?utf-8?B?T2tmNjBYWmJDRlFydUpRWlNMcnEwZmZMSG5PY3orK1pnWTdXam5saDJiVmdo?=
 =?utf-8?B?dGFjcUpIYlk4WHF1RU9pU3d2UEZEcnZiUWJPODBRRGJwNnduMnRJYlhmVHZo?=
 =?utf-8?B?Q1RVQUNEejh4VGNNR3pwRG9sYWthdksxN1VIajZvY2Q2VTNsc3lEQVdpaS9Q?=
 =?utf-8?B?NUxKRjJOdWZhNXNNZCtrRWV5WlVaY2RzVk8vKzVWUU9vbHdaMnZnbmlIU3hH?=
 =?utf-8?B?bVl3QlFLOGFuZTZPK1k0S25sWktVVit5YS81cEpUR2NEbGc2ZGJZWWJBOE4z?=
 =?utf-8?B?N0Q3V0hDTm9lK1VCUWVaWEluR1paOVI1OEZTMUJRdEhGYjI2YWttOXZRVEJr?=
 =?utf-8?B?WStZWGF5YVp4WGl4emV2ZFV6YzFtY2p0UHAzdDBldGtrVUt2R3dVNjZYUkRn?=
 =?utf-8?B?c0l5UCtTekpnQ2ttZWs1U3ROanA2SlBZbVV5NTNCN3orc2NZQm1lTERQTWVk?=
 =?utf-8?B?R3kvMy8wTVJNVHQvN05IcGcrS0hGL25Id3hySllqMG5qYVlPYWU4UkpaTTYy?=
 =?utf-8?B?cVVRQXNqVUJhejlQVlkyWGg2cUZVMVdmMjF2YzVHbUxHcGR0M3dHL3I2REtv?=
 =?utf-8?B?NWUyRUNkOGJ5UWV5ZEU1cUgzVVJyc0hjWEFtRFZTSlRlR1lZVEU5allzODcr?=
 =?utf-8?B?YnhEMUtRUjZZQUp0aTlLajQ5UGVXTkZiMlQydEdtWTNxWUR2U2NrOGI4TDVv?=
 =?utf-8?B?dDkxY0t4Z0tHWWkrVmNlSG14VTBkZzhUOW9mZWg2Wk56SzBpaWkvZnA1eGU3?=
 =?utf-8?B?OFR5RFBhVVRHcmIvQ212RVRueTVmc2VCWldtaXMvaHh4MnVBTFVxUmY0Y2N6?=
 =?utf-8?B?OHlZd2lCdHJpVGRzclJ5UXVBYnNvdGwxUExPemMyODhCNXpTYVZPV3JqT3U4?=
 =?utf-8?B?dzFJejY3ajFIdWZmQVdsTExuZ2dqbGVIam1sSmFsbjhRSUw0dmFPUDJweW1v?=
 =?utf-8?B?dDhiQzJ1c0tibXZWcFkwb1RqZkw2bGx3TUlRRmdKU25teUJTSEdleFM2eGZu?=
 =?utf-8?B?QkJYQnlMR3haZHFTSyt5bGRocUdFTUlhZXU0Y2xuUVJ0RjlGNzlGTDV5SjdU?=
 =?utf-8?B?S20wSVlkUGJKUkwvRVkvdmY2U1d6OXp4MkdHK0ltZzBTUFFlcURnQUcySVhk?=
 =?utf-8?B?SEZkbXM5LzBSY05EVnRKVzdZNldHbE56YXVPWlY3OWc1TnplRE5qcnMvaHc5?=
 =?utf-8?Q?3KXNL11MH19FHPNjFpTHv5pPUHBzmEp2SfRziOh0nctf?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34c727f4-652b-4357-acec-08db41951869
X-MS-Exchange-CrossTenant-AuthSource: DM8PR01MB6824.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2023 11:48:02.0343
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UWCrZJzqXW3Qz3DJb9dulQnB6VVs5cYscceoKr8zmCGHN9KVSTejlqeUch3B7mfg+m7zdY+C8yShVmkdCFRHhLck+lsWHyUxxrRtoemfeK+5uwhjVw09k/I6JJXeXiR2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR01MB3828
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi James,

On 20-04-2023 03:13 pm, James Clark wrote:
> 
> 
> On 19/04/2023 18:21, Ganapatrao Kulkarni wrote:
>> The current implementation supports coresight trace for a range of
>> CPUs, if the first CPU is CPU0.
>>
>> Adding changes to enable coresight trace for any range of CPUs by
>> decoding the first CPU also from the header.
>> Later, first CPU id is used instead of CPU0 across the decoder functions.
>>
>> Signed-off-by: Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>
>> ---
>>   .../perf/util/cs-etm-decoder/cs-etm-decoder.c |  4 +-
>>   .../perf/util/cs-etm-decoder/cs-etm-decoder.h |  3 +-
>>   tools/perf/util/cs-etm.c                      | 62 ++++++++++++-------
>>   3 files changed, 42 insertions(+), 27 deletions(-)
>>
>> diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
>> index 82a27ab90c8b..41ab299b643b 100644
>> --- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
>> +++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
>> @@ -724,7 +724,7 @@ cs_etm_decoder__create_etm_decoder(struct cs_etm_decoder_params *d_params,
>>   }
>>   
>>   struct cs_etm_decoder *
>> -cs_etm_decoder__new(int decoders, struct cs_etm_decoder_params *d_params,
>> +cs_etm_decoder__new(int first_decoder, int decoders, struct cs_etm_decoder_params *d_params,
>>   		    struct cs_etm_trace_params t_params[])
>>   {
>>   	struct cs_etm_decoder *decoder;
>> @@ -769,7 +769,7 @@ cs_etm_decoder__new(int decoders, struct cs_etm_decoder_params *d_params,
>>   	/* init raw frame logging if required */
>>   	cs_etm_decoder__init_raw_frame_logging(d_params, decoder);
>>   
>> -	for (i = 0; i < decoders; i++) {
>> +	for (i = first_decoder; i < decoders; i++) {
>>   		ret = cs_etm_decoder__create_etm_decoder(d_params,
>>   							 &t_params[i],
>>   							 decoder);
>> diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
>> index 92a855fbe5b8..b06193fc75b4 100644
>> --- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
>> +++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
>> @@ -90,7 +90,8 @@ int cs_etm_decoder__process_data_block(struct cs_etm_decoder *decoder,
>>   				       size_t len, size_t *consumed);
>>   
>>   struct cs_etm_decoder *
>> -cs_etm_decoder__new(int num_cpu,
>> +cs_etm_decoder__new(int first_decoder,
>> +		    int decoders,
>>   		    struct cs_etm_decoder_params *d_params,
>>   		    struct cs_etm_trace_params t_params[]);
>>   
>> diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
>> index 94e2d02009eb..2619513ae088 100644
>> --- a/tools/perf/util/cs-etm.c
>> +++ b/tools/perf/util/cs-etm.c
>> @@ -55,6 +55,8 @@ struct cs_etm_auxtrace {
>>   	u8 has_virtual_ts; /* Virtual/Kernel timestamps in the trace. */
>>   
>>   	int num_cpu;
>> +	int first_cpu;
>> +	int last_cpu;
>>   	u64 latest_kernel_timestamp;
>>   	u32 auxtrace_type;
>>   	u64 branches_sample_type;
>> @@ -638,14 +640,13 @@ static void cs_etm__set_trace_param_ete(struct cs_etm_trace_params *t_params,
>>   }
>>   
>>   static int cs_etm__init_trace_params(struct cs_etm_trace_params *t_params,
>> -				     struct cs_etm_auxtrace *etm,
>> -				     int decoders)
>> +				     struct cs_etm_auxtrace *etm)
>>   {
>>   	int i;
>>   	u32 etmidr;
>>   	u64 architecture;
>>   
>> -	for (i = 0; i < decoders; i++) {
>> +	for (i = etm->first_cpu; i < etm->last_cpu; i++) {
>>   		architecture = etm->metadata[i][CS_ETM_MAGIC];
>>   
>>   		switch (architecture) {
>> @@ -817,7 +818,7 @@ static void cs_etm__free(struct perf_session *session)
>>   	/* Then the RB tree itself */
>>   	intlist__delete(traceid_list);
>>   
>> -	for (i = 0; i < aux->num_cpu; i++)
>> +	for (i = aux->first_cpu; i < aux->last_cpu; i++)
>>   		zfree(&aux->metadata[i]);
>>   
>>   	thread__zput(aux->unknown_thread);
>> @@ -921,7 +922,8 @@ static struct cs_etm_queue *cs_etm__alloc_queue(struct cs_etm_auxtrace *etm,
>>   	 * Each queue can only contain data from one CPU when unformatted, so only one decoder is
>>   	 * needed.
>>   	 */
>> -	int decoders = formatted ? etm->num_cpu : 1;
>> +	int first_decoder = formatted ? etm->first_cpu : 0;
>> +	int decoders = first_decoder + (formatted ? etm->num_cpu : 1);
>>   
>>   	etmq = zalloc(sizeof(*etmq));
>>   	if (!etmq)
>> @@ -937,7 +939,7 @@ static struct cs_etm_queue *cs_etm__alloc_queue(struct cs_etm_auxtrace *etm,
>>   	if (!t_params)
>>   		goto out_free;
>>   
>> -	if (cs_etm__init_trace_params(t_params, etm, decoders))
>> +	if (cs_etm__init_trace_params(t_params, etm))
>>   		goto out_free;
>>   
>>   	/* Set decoder parameters to decode trace packets */
>> @@ -947,8 +949,7 @@ static struct cs_etm_queue *cs_etm__alloc_queue(struct cs_etm_auxtrace *etm,
>>   					formatted))
>>   		goto out_free;
>>   
>> -	etmq->decoder = cs_etm_decoder__new(decoders, &d_params,
>> -					    t_params);
>> +	etmq->decoder = cs_etm_decoder__new(first_decoder, decoders, &d_params, t_params);
>>   
>>   	if (!etmq->decoder)
>>   		goto out_free;
>> @@ -2959,11 +2960,11 @@ static int cs_etm__queue_aux_records(struct perf_session *session)
>>    * Loop through the ETMs and complain if we find at least one where ts_source != 1 (virtual
>>    * timestamps).
>>    */
>> -static bool cs_etm__has_virtual_ts(u64 **metadata, int num_cpu)
>> +static bool cs_etm__has_virtual_ts(u64 **metadata, struct cs_etm_auxtrace *etm)
>>   {
>>   	int j;
>>   
>> -	for (j = 0; j < num_cpu; j++) {
>> +	for (j = etm->first_cpu; j < etm->last_cpu; j++) {
>>   		switch (metadata[j][CS_ETM_MAGIC]) {
>>   		case __perf_cs_etmv4_magic:
>>   			if (HAS_PARAM(j, ETMV4, TS_SOURCE) || metadata[j][CS_ETMV4_TS_SOURCE] != 1)
>> @@ -2982,13 +2983,14 @@ static bool cs_etm__has_virtual_ts(u64 **metadata, int num_cpu)
>>   }
>>   
>>   /* map trace ids to correct metadata block, from information in metadata */
>> -static int cs_etm__map_trace_ids_metadata(int num_cpu, u64 **metadata)
>> +static int cs_etm__map_trace_ids_metadata(struct cs_etm_auxtrace *etm)
>>   {
>>   	u64 cs_etm_magic;
>> +	u64 **metadata = etm->metadata;
>>   	u8 trace_chan_id;
>>   	int i, err;
>>   
>> -	for (i = 0; i < num_cpu; i++) {
>> +	for (i = etm->first_cpu; i < etm->last_cpu; i++) {
>>   		cs_etm_magic = metadata[i][CS_ETM_MAGIC];
>>   		switch (cs_etm_magic) {
>>   		case __perf_cs_etmv3_magic:
>> @@ -3015,12 +3017,13 @@ static int cs_etm__map_trace_ids_metadata(int num_cpu, u64 **metadata)
>>    * If we found AUX_HW_ID packets, then set any metadata marked as unused to the
>>    * unused value to reduce the number of unneeded decoders created.
>>    */
>> -static int cs_etm__clear_unused_trace_ids_metadata(int num_cpu, u64 **metadata)
>> +static int cs_etm__clear_unused_trace_ids_metadata(struct cs_etm_auxtrace *etm)
>>   {
>>   	u64 cs_etm_magic;
>> +	u64 **metadata = etm->metadata;
>>   	int i;
>>   
>> -	for (i = 0; i < num_cpu; i++) {
>> +	for (i = etm->first_cpu; i < etm->last_cpu; i++) {
>>   		cs_etm_magic = metadata[i][CS_ETM_MAGIC];
>>   		switch (cs_etm_magic) {
>>   		case __perf_cs_etmv3_magic:
>> @@ -3049,7 +3052,7 @@ int cs_etm__process_auxtrace_info_full(union perf_event *event,
>>   	int event_header_size = sizeof(struct perf_event_header);
>>   	int total_size = auxtrace_info->header.size;
>>   	int priv_size = 0;
>> -	int num_cpu;
>> +	int num_cpu, first_cpu = 0, last_cpu;
>>   	int err = 0;
>>   	int aux_hw_id_found;
>>   	int i, j;
>> @@ -3068,22 +3071,31 @@ int cs_etm__process_auxtrace_info_full(union perf_event *event,
>>   	/* First the global part */
>>   	ptr = (u64 *) auxtrace_info->priv;
>>   	num_cpu = ptr[CS_PMU_TYPE_CPUS] & 0xffffffff;
>> -	metadata = zalloc(sizeof(*metadata) * num_cpu);
>> +
>> +	/* Start parsing after the common part of the header */
>> +	i = CS_HEADER_VERSION_MAX;
>> +
>> +	/*Get CPU id of first event */
>> +	first_cpu = ptr[i + CS_ETM_CPU];
>> +	last_cpu = first_cpu + num_cpu;
>> +
>> +	if (first_cpu > cpu__max_cpu().cpu ||
>> +			last_cpu > cpu__max_cpu().cpu)
>> +		return -EINVAL;
>> +
>> +	metadata = zalloc(sizeof(*metadata) * last_cpu);
> 
> Hi Ganapatrao,
> 
> I think I see what the problem is, but I'm wondering if a better fix
> would be to further decouple the CPU ID from the index in the array.
> 
> With your change it's not clear what happens with sparse recordings, for
> example 'perf record -e cs_etm// -C 1,3,5'. And it seems like there is

This patch fixes for any range of CPUs.
Record with sparse list of CPUs will not work with current code still.

> some wastage in the zalloc here for example if only CPU 256 is traced
> then we'd still make 256 decoders but 255 of them would be unused?
> 
> I tried to test sparse recordings, but your change doesn't apply to the
> latest coresight/next branch. I did notice that 'perf report -D' doesn't
> work with them on coresight/next (it just quits), but I couldn't see if
> that's fixed with your change.

My patch is rebased on 6.3-RC7 codebase with Mike's 3 perf patches 
related to dynamic id [1] support(queued for 6.4).

"perf report -D" works for me.

[1] https://www.spinics.net/lists/linux-perf-users/msg27452.html

> 
> Would a better fix not be to keep the metadata loops from 0-N and
> instead save the CPU ID in cs_etm_decoder_params or the decoder. That
> way it would support both sparse and not starting from 0 cases? I think

Yep, I though this initially, it got complicated due to for more 
for-loops. I will try again and post V2.

> the code would be better if it's worded like "i < recorded_cpus" rather
> than "i < cpu" to make it clear that i isn't actually the CPU ID it's
> just an index.

Yes, makes sense to call it "recorded_cpus".

> 
> Also a new test for this scenario would probably be a good idea.
> 
> Thanks
> James
> 
Thanks,
Ganapat
