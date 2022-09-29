Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFC5E5EEE3F
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 09:02:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235107AbiI2HCL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 03:02:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235028AbiI2HBa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 03:01:30 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2087.outbound.protection.outlook.com [40.107.220.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49A49EB121
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 00:01:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kmEDoJKC6i2xwXUNqKJoZU/ErQOXXOv9YOfS9uAdmQi/ZyXiI8NdyDq5OiLSNtQ4XvcYGlOSFuzl0RTeJyGcRB+wi8/5mryA+y5LlNvb9VfrcLN2kVV85m7nJ7hmBzvf5qhEmzBVMvi92ltgOuqMvk1m2FoSfw/poEG9MsmDqjuD9WGqCWfoOsHet9XWxkVaru98ez2Pn/xWXThHzOhr23XJzdrOU9Pa5qa7bl4Z3v7KqeSZCVT5L1M/0QwTNa2OxXddxW2QzpWPHHMrhbvKkdH6NNg/t0rq27EMsoxN0cpCvZt2uDD5ebebiMudeBpJEsY6s++9/HyC+zO+cFYpvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hz3CmQjV6sYMeaY68Qc2MRAsw1h40uv6I14WEqts7yU=;
 b=hx2qOM1N4j0tpCZsIJvy1QjWti2bRqqkpR6fvKm6ZIXaKRokLG2qR+j6PuRic/7u8OfSEwvKdW7OlrohHN/WO7+49qwOCKyfCpHE42b5nuDwf7dvgSsIZjs1jufeuBrrB1qy5EDPJA7xrto1fypM4Ddl2icagG0X3dorL1KAo679LQ1vCk8s/RNNemKTo4If9MUPqHPTLe6uZGb/R5jXA0zfMZ32lvX54zJxykwE5P3j5dWB5tHS5gd784PvBsvLR1z1X1oRoJZjVnI+fPoI1P26775a1F/EOfJS0SZnpZ+yQgnArQ6oCKWl0yDLIsEPsMc0uXm2pKoQF7JVLGWfAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hz3CmQjV6sYMeaY68Qc2MRAsw1h40uv6I14WEqts7yU=;
 b=Jp9RdgSFK7TPWtM18ee8BcP4EeXdZUKa0hkdskNMBcAidYSnY+iIviop8AgX16p0/3aVicgdI8owgl9IsABra9UGjd18k2NVUuIusnDBxPT04syBd4n1vSqXVeotk8cG+GrNEqrGaGguHILPii1D1xdC1f8KzewN+hcmscUCQB0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5712.namprd12.prod.outlook.com (2603:10b6:510:1e3::13)
 by CH0PR12MB5234.namprd12.prod.outlook.com (2603:10b6:610:d1::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.20; Thu, 29 Sep
 2022 07:01:26 +0000
Received: from PH7PR12MB5712.namprd12.prod.outlook.com
 ([fe80::aff2:40f5:fbfb:5f37]) by PH7PR12MB5712.namprd12.prod.outlook.com
 ([fe80::aff2:40f5:fbfb:5f37%5]) with mapi id 15.20.5654.014; Thu, 29 Sep 2022
 07:01:26 +0000
Message-ID: <9c40ef91-b7fc-5ee6-2ab5-446a10f8c00a@amd.com>
Date:   Thu, 29 Sep 2022 12:31:13 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH 2/2] perf/x86/amd/lbr: adjust LBR regardless of filtering
Content-Language: en-US
To:     Stephane Eranian <eranian@google.com>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        ananth.narayan@amd.com, ravi.bangoria@amd.com
References: <20220928184043.408364-1-eranian@google.com>
 <20220928184043.408364-3-eranian@google.com>
From:   Sandipan Das <sandipan.das@amd.com>
In-Reply-To: <20220928184043.408364-3-eranian@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0152.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:26::7) To PH7PR12MB5712.namprd12.prod.outlook.com
 (2603:10b6:510:1e3::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5712:EE_|CH0PR12MB5234:EE_
X-MS-Office365-Filtering-Correlation-Id: acfd934c-22f6-4d3b-5849-08daa1e86d1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hikpT9aOI4VuvbQsBEln5l15l3fakDcXijnEsY9Ckak2bRKHTHSs1ZD4e65Teo6cpcxQtmyGjfbmXjMk1JooudumOBFjGrsh1HfTLSbsYjy3Bdcg9tYHHxMGUSRwYkzCzDE4ORsMyqCuxAJYBY4CZpBd9y6IeZQY+tnK6CUcGmK5HlhAhyrWQpvYSbrRPu7x2PylPXrWw34ajtRBzylWY41vxwSd3g3duzGBqw5WT1OKBDNybv+/WgaYGydlbAvUtlfBqgiYPhgCDUZGjQ+8KB1VKHvFnzFsZxTrKPMNNwIroq+H/mhdmPe6aHvVNuObO/Q0Q94gJ+9idBt8ul4Q8gzGRhW6UlHG0XIwfue2MutUoTI7APfXt6c+OK48hrCpj6Iey8GgOlQQYqDV2hYN15N+fZch91XneUe6qq/sBM9R2OQgNzA6MWIW+nedcrk/PHywLNG44ZM/66WFa4jzfld9TtuUewg225bCcz1+WzZXO9oxDxBC34e7nTjs4EIkWcrKGK+ktbC4X9RHGObMWcD37rGxazEK2aYp1xQ0l5M4B6js/S1I32WlFqsUYmsCPKvi9az1NThit9LJw0YiViV51vblXWf3vIDaTMaA+fGWedoJTCOdJGHlN/DU9/pF2XV/TQdfINZKNaLvPxoKnO/bo9EtvT6g7b6kD5IHbQdSLjfuhc+oOGCe92R3FTviHtiPUx4YXDXblVoz5b8dQiuWJz5+KXqlQCSIwTQcOQSVONhKwgCclSqAipX32xpjqijzDdaCcle4Ra3co/2nOvjQaU6aGodrhRZUmwX5gV0SaXwZ2nNngXEM7iNHqtLw+yei6sqcfqvRJxnonE/kDQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5712.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(39860400002)(346002)(376002)(396003)(136003)(451199015)(31686004)(44832011)(36756003)(5660300002)(8676002)(6506007)(6666004)(41300700001)(4326008)(26005)(86362001)(31696002)(38100700002)(83380400001)(2616005)(2906002)(186003)(6486002)(6916009)(478600001)(66556008)(6512007)(8936002)(66476007)(53546011)(316002)(66946007)(26953001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RUU3RGl4VVRZNXZqZmJjUW5nUVJoNnRaUUp2TUxvWG5MTkVFV0FCUlcvNk8y?=
 =?utf-8?B?Rk9jSnBoWGZrOU1CeHlLSlVWUU82UkQ1c203YUEvRS8zYVBPTWpZM1pjOXhB?=
 =?utf-8?B?YU52bHBnNFM5Qy96c2JnMy9HNzNFWkdhZ252VHd1cDg2cDhUTXVSM2dLTzR0?=
 =?utf-8?B?OGowZ1hBRHNwU3BWekVOYmI4b081bWptMUZWRlc0V3pDOEtCTWgrci9vNXc1?=
 =?utf-8?B?Q1g1WTBIUGJGVXpzcGVCaEVpdEVPbExycXhENFB3QXNGOWd6WUlkVGNVRjNu?=
 =?utf-8?B?RTlaMmgzOTN2bTNPb0hCV2xGOWNTSlFkR0JnL3c1MVhyV2I3cGgxSjRNK1VY?=
 =?utf-8?B?aWZzaC9Xd3JmN2dFa2c2eHNSMWk2c3B5Uzl4eEwxcTRoSUNRMmx5MzVYWHFq?=
 =?utf-8?B?SjREUmx5TXBRbFpkY2dZQkc3cVNqT0RUbU5NZFRvbHN0ZGQ4djNoSnFpQTJ6?=
 =?utf-8?B?WjVyV1FKVjZFT0kzQ0t2WFB5NjJMVjhrZHZHTlVJdEQrV3MyU2pzME8rMSth?=
 =?utf-8?B?M2dYTHYwMjdYL2pWZTZyVW1yNWt5TXVjczY5OW11RThYSExEMDRXZlZpZlM0?=
 =?utf-8?B?ejdKcXNscUN1d2MxTis5UTFRc1NpOTJqZGo1ZHdPejcyMytURDd1ZzBCKzVr?=
 =?utf-8?B?TUEzbWJNQVd2OWpDRUhiMThXNU5EWlM5NFVuTDBzcXNYQ0hoUzdYelZZV0J1?=
 =?utf-8?B?UUI5VmpPQmx0K3ZrbkZkSm5vb3plSXE1U1BCWE5VUVdBSmpPYTJmcW5abXo3?=
 =?utf-8?B?T0RwdmNWSFJINVlrZjZZeFF1cTNXVTBIcVQ1azFPRDNQK2hmenNFUGxzUUpq?=
 =?utf-8?B?eHRQMklwQ3N2MU5QNG80cGFuNHo3a0tpRStiOXpsbEtoTk40aSs1YUNrRDNQ?=
 =?utf-8?B?eGZrWGI5eUJmMUJQeGxlVVoySEc3WDk3NENIY3RKVnRoQVl2UmU5N3NtYVlB?=
 =?utf-8?B?TFN0cXBmNUpkclRIV01aRHdFRWlTVkJvNW5NRUpubTJTWlFUaUE1dmdjR0cv?=
 =?utf-8?B?ejZqeC8xaEgvZWhqMjh2TzhUR2Y2M2k5WE1wUDRYL2hseDRiQXVaeEErdmZH?=
 =?utf-8?B?dXhpSXhIRlhCNmJPcmRSVHpYRUVKdHJvUFBMY3h6WllUbTE3S1VockNOZXpa?=
 =?utf-8?B?OTNoVjBtM0JQSGtvK2VZcVBON3c5aW01WDZuc2M1WXdyanc2OS9MemNlU0tj?=
 =?utf-8?B?aGJDdGd2d2xxK0NJSW52TVpsSFpRUzlaUlRmbFVjOXN5bUUwa0FTVnMwcHVX?=
 =?utf-8?B?VWMrdzd3YWp3Zi9paDFCNHd1NmpiMjdQbmhNRjY4aHVsQ0lNUk1QNXVzTTdP?=
 =?utf-8?B?dnNBYWhXV2ZKc3FzMFJjSkxZSnVZSXZmK0RONVAvbHJCcC9ua0dmOFNUaDZm?=
 =?utf-8?B?Z3FOODI5bzlVNEtNMXlnelZ3aVBHTWp1WEVaVXlBVFJiYmRkVXlZb052dEVP?=
 =?utf-8?B?Z0dUNW1Pc3o2VWw3WFlCRlVIekhSVjB6N082OXZkUEZENkxEQmE4YmV5UkVp?=
 =?utf-8?B?M2hyZ08wdTg1ampCSFVUWFFLYytVeUVpaGRSMEtob2ZFNHhpU3ZQSy9YUE9N?=
 =?utf-8?B?N0lUYlNkcFRGbTIyN3RBcXFONGovaTJSSlVKNTBhOXU0S1FYWG5QajZJT2h5?=
 =?utf-8?B?cm5EUUZLUkRVMGhDS05tZE9BRHN3VDExbXlRck14ZDIxRDF4UzRwaVRjWnYw?=
 =?utf-8?B?RFJlWGdYaHBuTWRsNFE5c3JVUnQ5UGVLMnZSTFU5SWdJL2NVbkF2YVJscUJh?=
 =?utf-8?B?aGQ2SmxaYXlKS3AwWEQ1YUZIekFxVmNHNjBPYW5yME1zQ3VUNDVDamtXNXMy?=
 =?utf-8?B?NEJwNXVESXN1VEJXODliZTNnK2FDWC9BeWZWaTlRSUlrcUtaeGdKQXc5RkJn?=
 =?utf-8?B?dXZybVhYUU9ZTWNpcEJlWGg3TG1kUXlnNzhIL3BSWDY3WEl3WTF6cEZqQ2Fo?=
 =?utf-8?B?ajdVMmd3SXlFV1Q1MWkzV2ZUbkgwbVVrM0tkNkVScWIrRStHNUttMzR1aThu?=
 =?utf-8?B?anlrV3JIcHJpU01wbnJhcVhTMVpyaDFZejJTai9Ia1podm9oOEloNW9GYzIw?=
 =?utf-8?B?NUlrNW9JbkQ2VDNpbmhNSGRVOFh2Y0QySVJSL29ONmFxaWYyNDZFODgrQTRE?=
 =?utf-8?Q?Uf2wWxB+bsi7P1HkbpoFgNF/P?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: acfd934c-22f6-4d3b-5849-08daa1e86d1f
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5712.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2022 07:01:26.4726
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: amO7mza57uHFIp309HVyLjSiqABojLt562eHPg+inexsiW+a2XoopwM49xbEH+Bupy06dhPHeIOGknDKoXGGoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5234
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/29/2022 12:10 AM, Stephane Eranian wrote:
> In case of fused compare and taken branch instructions, the AMD LBR points to
> the compare instruction instead of the branch. Users of LBR usually expects
> the from address to point to a branch instruction. The kernel has code to
> adjust the from address via get_branch_type_fused(). However this correction
> is only applied when a branch filter is applied. That means that if no
> filter is present, the quality of the data is lower.
> 
> Fix the problem by applying the adjustment regardless of the filter setting,
> bringing the AMD LBR to the same level as other LBR implementations.
> 
> Signed-off-by: Stephane Eranian <eranian@google.com>
> ---
>  arch/x86/events/amd/lbr.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/events/amd/lbr.c b/arch/x86/events/amd/lbr.c
> index 2e1c1573efe7..38a75216c12c 100644
> --- a/arch/x86/events/amd/lbr.c
> +++ b/arch/x86/events/amd/lbr.c
> @@ -99,12 +99,13 @@ static void amd_pmu_lbr_filter(void)
>  	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
>  	int br_sel = cpuc->br_sel, offset, type, i, j;
>  	bool compress = false;
> +	bool fused_only = false;
>  	u64 from, to;
>  
>  	/* If sampling all branches, there is nothing to filter */
>  	if (((br_sel & X86_BR_ALL) == X86_BR_ALL) &&
>  	    ((br_sel & X86_BR_TYPE_SAVE) != X86_BR_TYPE_SAVE))
> -		return;
> +		fused_only = true;
>  
>  	for (i = 0; i < cpuc->lbr_stack.nr; i++) {
>  		from = cpuc->lbr_entries[i].from;
> @@ -116,8 +117,11 @@ static void amd_pmu_lbr_filter(void)
>  		 * fusion where it points to an instruction preceding the
>  		 * actual branch
>  		 */
> -		if (offset)
> +		if (offset) {
>  			cpuc->lbr_entries[i].from += offset;
> +			if (fused_only)
> +				continue;
> +		}
>  
>  		/* If type does not correspond, then discard */
>  		if (type == X86_BR_NONE || (br_sel & type) != type) {

Reviewed-by: Sandipan Das <sandipan.das@amd.com>

