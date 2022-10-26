Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27CDD60E8AB
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 21:10:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234860AbiJZTKM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 15:10:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235075AbiJZTJW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 15:09:22 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2048.outbound.protection.outlook.com [40.107.102.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A3A52B609;
        Wed, 26 Oct 2022 12:07:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=It46jjlQOsPDFiVOvU6e9Ch3Ld7XkBPnrwvpTl354/C2eQZop+kUt5nX92F5YwBOFpnaS32btoDA6Ht5tJz0GexWg/g8lt/1nR/901SYkGhhG1GzKkuZxORxr/0zin+iS0WSjJYdGQiwM1cJdnuGTw+2vbEBo+QChuX2o7OZJ2/KZgFxfrcVTZhjAmdegOfPdwn3YIO3UE+NiEVOoLS3dR87RsXgOcJmJf32folHuO610EKCv8Pbavd4Hb1PdS1lknvssO3K8uva3ECAXAHeW8yQNB0nRAOeB4rDzamoFnKjRJHAjrtG11dtJXQ9rN926+WIwFnFM8G++nx/P9xH8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SU8OOrqmVfFVG5LTa4ogeuMTt4MvQEm7tT15i6Csttw=;
 b=cNzd+Itp5W4AqBh/qBa35hDilMouLQinNO9QX0CjkYgNlM7/7j5GTfYM6W1B1Y7+D7zq0oEgsu30X46Ai0KQjzVP2wn1THyqw/QycU3x+F33FiRZATrmPYGhgVlEsnEC949n129FEtKPIs6rwF2WIdBUeXUefhCwjYOtP0AUH5NkRQmkxiBKolppI2hG2+sc1cylLilzpABcPIPxUrFpzx/AfuZzLTj7Qzni1R3gXgGJZjqkwpnA7NPTsXjMQv+Qrw9f4e+NJoOplXsJrCzXkzpvEWEQZg1Ui/snvjJam3kBdbs7U3Gj0wmSq+9Mwy4yPnJcF0AhRkEXe93ExWTt/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SU8OOrqmVfFVG5LTa4ogeuMTt4MvQEm7tT15i6Csttw=;
 b=YYrMMVR0zmH9WRYiGoq+AOerRbLf9lXqidPWTo9CpGmipELxbQbXCWXfY8ZTXqcxFxUxhIZQyCSEbIvgZckyd3z+MMl6oV2ipRl/JtbLptAbrhQqaBDBW75Mp1lF03qlHt2J/WzFqx0zDZ1D7+o/nxMJdX1yXFSh5njQJsXr+4w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by SJ0PR12MB5501.namprd12.prod.outlook.com (2603:10b6:a03:304::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.23; Wed, 26 Oct
 2022 19:07:48 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::2d5:77ac:6d39:e57b]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::2d5:77ac:6d39:e57b%9]) with mapi id 15.20.5746.028; Wed, 26 Oct 2022
 19:07:48 +0000
Message-ID: <ef734fc1-8a51-4c60-f73f-2d71fcc54b30@amd.com>
Date:   Wed, 26 Oct 2022 14:07:43 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v7 05/12] x86/resctrl: Detect and configure Slow Memory
 Bandwidth allocation
Content-Language: en-US
To:     Reinette Chatre <reinette.chatre@intel.com>, corbet@lwn.net,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de
Cc:     fenghua.yu@intel.com, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, paulmck@kernel.org, akpm@linux-foundation.org,
        quic_neeraju@quicinc.com, rdunlap@infradead.org,
        damien.lemoal@opensource.wdc.com, songmuchun@bytedance.com,
        peterz@infradead.org, jpoimboe@kernel.org, pbonzini@redhat.com,
        chang.seok.bae@intel.com, pawan.kumar.gupta@linux.intel.com,
        jmattson@google.com, daniel.sneddon@linux.intel.com,
        sandipan.das@amd.com, tony.luck@intel.com, james.morse@arm.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        bagasdotme@gmail.com, eranian@google.com
References: <166604543832.5345.9696970469830919982.stgit@bmoger-ubuntu>
 <166604559954.5345.14619487558472213422.stgit@bmoger-ubuntu>
 <c999a7f8-b083-72a6-ff07-201369339c92@intel.com>
From:   "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <c999a7f8-b083-72a6-ff07-201369339c92@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0P221CA0033.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:610:11d::16) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|SJ0PR12MB5501:EE_
X-MS-Office365-Filtering-Correlation-Id: e8ea276a-e6a2-4ad4-4ff0-08dab7855f4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4195SmXLZWf1hNn9g/vgi5WH3m68luSi0unPhNsl7aZohzeaitTjcSz62a5E1ouqA7TvgHUIyB4+Bdvn5f7AAeRk1d5FuXh1Jnu5fS7vHzI5lk2AuTeVkoMag9M+f1RG0ODSTz/8kqtiojp2N09JMejfYAQskdS+iT3DP3GTEoPn7ynBKIbZEvZ5W5mobiTWzUBRdYed97YehshIyDDXuh+vU4ziFUXEHqEstgCnbGvON7gZdNbfQdsfvkBVGMPR14gKlKB2Y4hQcRrsQB+MQxaowCnDPSGhqUED4Mvok5iR8SIxCZdGMtw2crJhEMird2RxZUmI7xda5bsEhvQ+9+aftf5TwG31ybovvXHyeF6Dy2I5bNHUEPx2dvkvi6teNW3oeHFfqNu4lx5lfRu2mTbNrM74aS91DuMXMspyoBQ7QeGrYB5ZHucVPfnFMfzcoEZmD27mW9KqF6qkC5BkoMZDFHJTA95aZO5q0Yyx84P/s0wQc2UoQxOdsUI10Z8YNfEiZA5eRDRyjP+civLhQ0B+2oxF5qxJQ06qAtKZo3zTkVGJrYIshw90V+AuTVlC9QbFWbR/vP0Q9SKhYn6IqmWYGI+puktv9gwlHvHK8i+qoPHy2OThR0h9fQGaf4hAsV84vq6yMxGaeXdaQSNn1V6w1rtsQqphmr7rdcMOfhOauM1tP4KEAC0/Ro3Dm6Cr/yhqr6mWuNqKH70dORZdLd5FPXE8B4iGLVyAzOsvse8DrHLffxHTfkqm2qnGjBJ7cg4eA6ZCAew32w4FXTrCv17tk0DIjgVsu37S81AhDMA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(366004)(346002)(39860400002)(396003)(451199015)(36756003)(26005)(31686004)(8676002)(86362001)(31696002)(3450700001)(186003)(2616005)(2906002)(5660300002)(83380400001)(38100700002)(53546011)(6666004)(6506007)(6512007)(4326008)(6486002)(66556008)(66476007)(316002)(66946007)(8936002)(41300700001)(478600001)(7416002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dHF4ckszb0x5azVhNS93YWFVTjY5SSt1cEZaWFcxQWJlT3JJZklHNkNja3NK?=
 =?utf-8?B?QWdvTXprZXZXek4zUmxTUjVxTGxkWHRaVVozUk01VzEzc3Vrd09IQ1RqTXRs?=
 =?utf-8?B?NnZWdFVuVHlycGZPa29IYlBLeVBCZWNSdkFMZE5hZEtiQ1NBUWZQRnNKMDJV?=
 =?utf-8?B?VTU4dGNCR2hGaWYrWUFWNHdOMjZrcWFLYUNsWVBMS1VJb1RWcCs4RDVxUjRP?=
 =?utf-8?B?c0hrWmU3dmwwWENoZG1EMC9DRHdmczVPWlRMNUNiRkJuWXFOS3hWb1lFVFUw?=
 =?utf-8?B?ZzVCWFRXV2NPczBJL3I4blpjUXdTSEJXWUdpTjgya1REWGpQSkZUZDZnbGRv?=
 =?utf-8?B?dzZEcGxkd2Z6WXBkYUVvQ3FYekFlRStsZEhHcnlFNlNEd3FLK2YyTDkxSTFT?=
 =?utf-8?B?UDkvMWIvTE1JVXcyVlRDNEkxeFRVRDN4Y2dOYWxSVTlPb1hEY3RHazQydVRI?=
 =?utf-8?B?Q1J4YWw5WW55eGlQNUlXYUQ3TVRSSlFvWDZ0UWJNNlFpMTFPdUlLM1gxOTN1?=
 =?utf-8?B?VHMzd0tZMStKakZOajNGblJ1RVVkMGRwQUQ0VTFIMGVwQ0M5Q2dCNVpjbzJF?=
 =?utf-8?B?ZzRMYm8rNjZJR3JQZlluOUxwR0M5WlR1Z0tSdHlpTkl4V1JoOGpQUUsvb0dG?=
 =?utf-8?B?aVBSeUZ1Snc1M3FaRFltcTBhM1VTcWdNT3kzZlY5Tnp0V2MxakExSm0zTnI1?=
 =?utf-8?B?SGFJNkhFbytpRkY3aVkzZytQMkZhMWt3a1YyVys4N3FnZXd5QlVrNS91SENT?=
 =?utf-8?B?RWc3Smk3eXJ1WFlYdW13SElXU1gvUS9QWUFOQXAxS2w0OTVNTlkvWGNVL1dS?=
 =?utf-8?B?UGRTM25HY2txQ0I0NVV1TnZRY0FSUitlL2h1QlJJWmtLeDdwNDlWYTN4OE9D?=
 =?utf-8?B?aGp2LzlUSVJVRnY5aUQ3ZG1CcGtYempldyszNkNhYnVVdHE5UU81RXlVMERT?=
 =?utf-8?B?c1NYZjdrTXBBb2wvQjZtb2lQTThZeDQxcGNsaFRGeXl2ZVM4UVp2WFlNUWg0?=
 =?utf-8?B?WjNrdWhOT1kwUDdoZkd6MHNVamhaNTMyUStmUjg1ODdzYmxDWVk5dHJnQncy?=
 =?utf-8?B?Y2l1VHJ2ODdLTTZmYm9HSFpoMFp4MU9WUUcrZHJkR2w2WnVCUnZxNFFhVUV5?=
 =?utf-8?B?YUhnQXNIcVBWNGJCVDlyWFlmT2JsYnIvSEJvVjRSUmtWOTRhK1llNUY2dzFq?=
 =?utf-8?B?eXl4NmtNdjM1WUhlZHVYaEgzYWhJVFRhajFIZ1E2UTk4RWpsYWdqREd6SFBH?=
 =?utf-8?B?a0xXbDZiQW02anNJYlZWODlESGdqUUR6ajFWRWZhYTRzLzgzMElqZlVnRlJC?=
 =?utf-8?B?d0JLYU1VUzdCc3ZLZHJLWlZ0alV2MXBkQUZSYmxFY0Q5bFQwWkNwUEtHUWRs?=
 =?utf-8?B?eW92R245YmYwdzFsN0tSSXR5Rzg1VUd6ZzBHZ2RlYjB1NnIyM3FnQUVyazJv?=
 =?utf-8?B?YTloMTV6b0RUK1hlbFVnNHNneElPQ1JoYjVleXdzY05LcEpzSTF5Q0duV20y?=
 =?utf-8?B?OVFhSnNLNjkxOU1BY1VldTQvcVA4V1cyeHRzbUE2SFJhcmZ6L05WampPMzds?=
 =?utf-8?B?Uk9VeUVlaHBqamljOVNhanJkd3crU0lkbk5yNUtUK2tjcmloQklqNVR4VTAz?=
 =?utf-8?B?ZTJRalFoUlRpL0dHWllmRFRLNktONHBNbExlTFMrZXZLdmhYcWVKS3VPTGxC?=
 =?utf-8?B?YXpER2lxWXdmYzlZb08yWUc3MEM1OTNzR2tob3R3SjQ5Y05VWW90REtQT0w5?=
 =?utf-8?B?MENZVjV2Z0MyR1pMZmxYcC81QmlHOU5YZDBFU3hVemsrbjAwN1J5TmMyQjNt?=
 =?utf-8?B?cmJ1U3BlUEx3SU94cCtlWmFRblF1M2t5ZHU2NTdKUHpUK3R2TjBYNVFrL015?=
 =?utf-8?B?RnBrcmxaQ2Z0bzJ2WDA1bmJWWUpsQzN6RCtYTHZlNjE2Um5ENGd3K0sxK051?=
 =?utf-8?B?QUJOd1JhZUpadVVhcjRScVYyekIrelFDUHBKSHdHb3A0dGQzOTlwRkhSV1lR?=
 =?utf-8?B?Y2JYSmovUnhuTWlFRlNzdUZ5dFczaHB2V1NOa0hBNWxweWZUUGUzTlVNSzNM?=
 =?utf-8?B?YzRadzFBRU9KdE5xMU5KLzRMZ2tISnA0OFYzT2pCMi9yREhtOTd1ZVhGbFIv?=
 =?utf-8?Q?QNjAP6n9exGS4Zgp0uZR7WvAv?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8ea276a-e6a2-4ad4-4ff0-08dab7855f4e
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2022 19:07:48.5721
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5xU18vLoy+++GUh7pcA44uhuj+i7gNYPSXsJGXjqHKSToFH9N8mYoblx0d3WFm4J
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5501
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Reinette,

On 10/25/22 18:43, Reinette Chatre wrote:
> Hi Babu,
>
> Nitpick in Subject ... "allocation" -> "Allocation"?
Sure.
>
> On 10/17/2022 3:26 PM, Babu Moger wrote:
>
> ...
>
>> @@ -2845,7 +2846,8 @@ static int rdtgroup_init_alloc(struct rdtgroup *rdtgrp)
>>  
>>  	list_for_each_entry(s, &resctrl_schema_all, list) {
>>  		r = s->res;
>> -		if (r->rid == RDT_RESOURCE_MBA) {
>> +		if (r->rid == RDT_RESOURCE_MBA ||
>> +		    r->rid == RDT_RESOURCE_SMBA) {
>>  			rdtgroup_init_mba(r, rdtgrp->closid);
>>  			if (is_mba_sc(r))
>>  				continue;
> The above hunk and the ones that follow are unexpected.

I am thinking the above check is required, It is updating the
staged_config with default values. Right now, the default value for SMBA
is same as MBA default value. So, I used this code to initialize.

Did I miss something?

>
> Note that the software controller, when resctrl is mounted with "mba_MBps", is 
> only supported by RDT_RESOURCE_MBA. At this time this really is hard coded all
> over the place, for example:
>
> static int set_mba_sc(bool mba_sc)
> {
> 	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_MBA].r_resctrl;
> 	...
>
> }
>
> Since SMBA hardcodes "delay_linear = false" I do not expect it to support the software
> controller ... but these hunks appear to treat SMBA as though it does. It is the "MBA software
> controller", not "SMBA software controller". Why does it check above if the MBA software
> controller is enabled on SMBA?

There is no plan to support SMBA software controller. Yes, I think below
checks are not required.


> 			
>
>> @@ -3287,7 +3289,8 @@ void resctrl_offline_domain(struct rdt_resource *r, struct rdt_domain *d)
>>  {
>>  	lockdep_assert_held(&rdtgroup_mutex);
>>  
>> -	if (supports_mba_mbps() && r->rid == RDT_RESOURCE_MBA)
>> +	if (supports_mba_mbps() &&
>> +	    (r->rid == RDT_RESOURCE_MBA || r->rid == RDT_RESOURCE_SMBA))
>>  		mba_sc_domain_destroy(r, d);
This check is not required.
>>  
>>  	if (!r->mon_capable)
>> @@ -3354,8 +3357,9 @@ int resctrl_online_domain(struct rdt_resource *r, struct rdt_domain *d)
>>  
>>  	lockdep_assert_held(&rdtgroup_mutex);
>>  
>> -	if (supports_mba_mbps() && r->rid == RDT_RESOURCE_MBA)
>> -		/* RDT_RESOURCE_MBA is never mon_capable */
>> +	if (supports_mba_mbps() &&
>> +	    (r->rid == RDT_RESOURCE_MBA || r->rid == RDT_RESOURCE_MBA))
>> +		/* RDT_RESOURCE_MBA (or SMBA) is never mon_capable */
> What does this change do? Did you mean to add a r->rid == RDT_RESOURCE_SMBA check?

Good catch. I meant  r->rid == RDT_RESOURCE_SMBA.

But this check is not required at all.

>
>>  		return mba_sc_domain_allocate(r, d);
>>  
>>  	if (!r->mon_capable)
>>
>>
> Why are the MBA software controller resources allocated/destroyed for a SMBA resource? If
> you want to support the software controller for SMBA then there are a lot of other changes

No..There is no plan to support software controller for SMBA.

Thanks

Babu


