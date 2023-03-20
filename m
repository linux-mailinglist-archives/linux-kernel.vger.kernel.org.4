Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B08076C1385
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 14:35:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231435AbjCTNfq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 09:35:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231294AbjCTNfg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 09:35:36 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2042.outbound.protection.outlook.com [40.107.96.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C597CDBF7;
        Mon, 20 Mar 2023 06:35:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YAvmF9aE+NW0lG8+9XjGhrefE8QIapTd4uVxLAsiDAEqiLAwWmVaTuLdDUumX8hva/1dI4dWHcm3TYGqud9A5AQ7bTbym+Z58zecPDkdNEIgdfKJ9LMzqPoSXYt/tK/UTP7hFVDbpXqIWp2FweC10bGi/U8P86t4mZTDnhmYHyFEC+JBVebRjpUgDY/mmbBJhT00qOI3bfFvjU1SJmKiXVuN+DV04TpfoX+tcd+CsdDjsqEs7JodInblQfDvgeXf8+Jbw++Th+AARfuBacFJEHXDx3415vWFkJzyfmF+jRHvleVo5SMcU7NM0o7XkotvhaWHthHYVLj6Bf0VBGTHhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=quAGlK8+7DIxmEgTjOrLNnWCd+0fUZ+hOSh2Bu6RSpM=;
 b=gWzCeDvB8zzzKPXcD5ztUPXPgD0NqjPaoESm9gL3ORVK0sCW6dRlTzQvWRRU7tqCCF/sukoH+r5kxbl3OXlysaNsRI8NTE4dYUCARlAos60nnA0uFLlW/mIfyMpXhsnpF+Zzz95n6s/7Xa5hOt4DlmnnCF7hWd6OFUdrW64jYSnrXfVZr3VYFs3Sv6dMeks1+Q/qpPmp/Co2bb6vvEaFmIVzFbEEJg1obkbwqs9hk6zMlTRQipfDX7l89aLG16AyJoTxHb4GQd96mlclnxFZOwZrOJv64A+fDOd4G2d26eiZOLMpF2y3e+/rWmSt3FVoGx0YmQuSa1WE7Oq/5JJpiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=quAGlK8+7DIxmEgTjOrLNnWCd+0fUZ+hOSh2Bu6RSpM=;
 b=jET7dve9B5+xLLrdYaXRBUPMuLMbamIIc1i9Nk5Ty2JcYyL4yqf2GltlrOXeNB8zkTWufjxkllEsN/lXQkYwo8XNxEJmuBPLu9F8zc2cjB0R4Ff8f4ChYZxe7sHDIi3+0VW7BLhipPjpw3lJS8k276sthLnyIjPdjf497UFmruU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by SA0PR12MB4509.namprd12.prod.outlook.com (2603:10b6:806:9e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Mon, 20 Mar
 2023 13:35:25 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::3490:de56:de08:46f6]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::3490:de56:de08:46f6%8]) with mapi id 15.20.6178.037; Mon, 20 Mar 2023
 13:35:21 +0000
Message-ID: <eea8a9e5-abaf-ad13-5b9f-4d997ccd2aca@amd.com>
Date:   Mon, 20 Mar 2023 08:35:19 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v3 2/7] x86/resctrl: Remove few unnecessary rftype flags
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
        bagasdotme@gmail.com, eranian@google.com,
        christophe.leroy@csgroup.eu, jarkko@kernel.org,
        adrian.hunter@intel.com, quic_jiles@quicinc.com,
        peternewman@google.com
References: <167778850105.1053859.14596357862185564029.stgit@bmoger-ubuntu>
 <167778867236.1053859.12920879751317268318.stgit@bmoger-ubuntu>
 <1a45fc82-9339-d086-2e70-27fd91906b8a@intel.com>
 <edcb0810-df39-669b-ebf2-5988a71525e9@amd.com>
 <4af7feb7-7663-7bab-33a4-7ffce092f55d@intel.com>
 <c07dfb04-4502-47d8-ad89-9f9c7898f246@amd.com>
 <b2587ef0-38da-6714-f26c-5b8a16fba340@intel.com>
From:   "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <b2587ef0-38da-6714-f26c-5b8a16fba340@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1P221CA0023.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:2c5::10) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|SA0PR12MB4509:EE_
X-MS-Office365-Filtering-Correlation-Id: b894d861-41ee-4401-63ae-08db2947f38a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u6/b2a2LzQkfP/eg+RyU+4wXPEcobMv5BdxljiLAe0mCbA4g3hxrGIOfLB+QqU7mE/lJf6FvQd/zpijiLbo2+eAVttYpb0/H/GAuHd6JrQJtveLhSVtoUPgun3AdsFcEsyAjF7Y5MEtxxZfjfP/zoRhOpXQJvPfDqOveizpTKG76zlf9+oK74LABsqFRE3db8XiQif7vzq0EpQXrgBStt5a7oykSXNxDbP60jjfdYad6xb0fwJZ8quj3BWqljtqXKzOoo044wsi4id3qVQRRAXEK5QmIuM6rv7fmt22bJu5x91KpLFf+WCvNqzZA02prTPcRY++7SBru/lok/NBvnHTf19/RwgfxGd46mpVJtbbRXVV5ZP0u9yHECCdSG1Zj5VEMYJzrfLXfWuFnoHyvnETBzRnkAWInQ1X3zxLnDNtupYJKd8piHu9iRvgdZ4JXdCIGr5/9AFKFMl66YRrNtptxC1zCrcys3vM1GmfMwGTr1Tmg+eeBxlu9QuMxR2L8i5XWhNcA4REAtygRpfV72n+gayDxXbXUB+Qd4URmCBan9YQ7HeicgEEmqI7HgLSs99wl9K6nTOrfR7dQYSHE0ZF2cxkPUDWcEE/Pissegw+gDRT/6aVwk/MDdtV+vip8n9LuGwVQuGIqwbwpIlI+lduzoyXm2F8P5V5Vim6hqRbPkaV8u863Ii8MtnlR0VaFty77Rt6pLurPwJQIi2F3qNrZh8PHbFcUQiVcoqQ5RmN4D192xy7q52a9CQ6jUqfsCmtIXbfkpwAuDXJwmvYr4YbeYbmO4muF52DmDJlloUI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(39860400002)(346002)(396003)(366004)(376002)(451199018)(186003)(478600001)(8676002)(26005)(6486002)(6506007)(6512007)(53546011)(31686004)(2616005)(316002)(66556008)(66476007)(66946007)(4326008)(7406005)(8936002)(7416002)(41300700001)(5660300002)(38100700002)(3450700001)(2906002)(31696002)(86362001)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ay82TDc5MENHU1ZveGZISkZoR09IMStEQXpLOHRmckpxbjc0YWk1eDM0ZmtQ?=
 =?utf-8?B?ZW5tOVhkRzdQc0ovS002TTJ3VFA0TU5RcmIwdFZkNGFWSXNjR3JtaWpMNkVW?=
 =?utf-8?B?TFVjTzQvWUtMdnkyZndSUDFpa2xYRWh2VFc4Z2RkL0dQcXJ5bVp5Q0FxSE5l?=
 =?utf-8?B?YjR2ZCtlYkhab2Z6b2RRNGNyLzZyR2JteFpMZ0tEaHFEblNQYllLNlJjeGJt?=
 =?utf-8?B?RzlKVGpvTTNpZ1FXaDlQVHd6RXFtbEZFQ2JSZGkvamtBL3Vtb05HUVQyWlAw?=
 =?utf-8?B?ZndoRnVzd3JlNXhqY0dlVk9qRHV3c2ZZaGFSZG9OT1IvZWVaWUxpS3pSUmwv?=
 =?utf-8?B?a3hEYlpITFRzdFRxNkE4Vzc2NFZOd1BhNmdhamw1bVpWOWNyQmpFcW00Q0dq?=
 =?utf-8?B?MW9SMUdNbkNRMHdyRnRUL2o0K2svLzhzUm9adXpQNGY5cXZSaFNsMzd4U3pS?=
 =?utf-8?B?dWlYWXY0bG9ma09IaFdZZXpiaFRJZDB5K0NCOEtqQ3dRS3JONTEyNVJRMTE2?=
 =?utf-8?B?ajdKUkVDajBYbFhBQW1Eam0va3YzTnhlRlVISEFDeGZaQmo1Q20xM1hXaHda?=
 =?utf-8?B?ODM5eGVySkRtTmhPR3BBSnVxK1U0WTB6ajV3TjJjbVZzdzVWU0xIMnFXMlBl?=
 =?utf-8?B?NVVqR3dETWRpcHFPWGwySTd3MzhiNitsZDYvZGExTWVoZXlyeGxSMUxDeURh?=
 =?utf-8?B?WkNvUGlPWHU1b2NUcUpHcTdOWlg0SWhmOTZBNmxaL1F3VXJvMU91QmU2L2lx?=
 =?utf-8?B?UFVrb2lFVFYrcDVWcHlUeWxhRzF1elhHVC8xOWVkQ1pzU0N2azlJZE5mZkh6?=
 =?utf-8?B?dkNvb1ZJTTJzY1o0TTZrTWhXa0JPblhyMzR6aVgzYzQ0VlRQYnB0clN6U0dC?=
 =?utf-8?B?a3FQam9tQ1FST1BYN2lHNG1FbGJJcEJzSnZYV0tTUTMzM2tPeUpVZVhxMjlW?=
 =?utf-8?B?OCtVT0t0VSt5T3J3bHd0M1dmNXlBOVZqSEw2eGhQNm5XTmY2ZElGekt5SG9Q?=
 =?utf-8?B?cHI4TXl6aXFpWFpXUExMRWVlYVJmdEJrWmRvTWNBS0dQVThxTWhpOTQ3WmtT?=
 =?utf-8?B?REROK3VRckgycG44aGtjbzF2MllCYmdvNTlOSzF4UVBOWkhmWGVmU1BzNFQ2?=
 =?utf-8?B?UEVneGJkK2M1MllmSllrQTFNM2swWDFTSC9ic0JYWnNPbVRZSUVaVE5yNGV6?=
 =?utf-8?B?dGMxeUFZNjlYR0xiaGJsVzlpUE5MSC9oSXRTd0hXVEE0VVcrbGtmK2JGUU9I?=
 =?utf-8?B?dG80bWtySHdzUHkzQVZKbFZnUFB0Z0h6NjRydVZseHRyUkphd3B4alJvbGJ5?=
 =?utf-8?B?TFZwdElkWXJMckdua1lGVlNTQlcvQjZxc2VKWmFyQnBsb3VpcVk2dW9IRWZz?=
 =?utf-8?B?SkVLclpxUTJ4cWpMbWQ3Z0d2NHdObEVVem1EVDBpZDJNVHJYUUlSd0cwS2gv?=
 =?utf-8?B?eGhtUEE5UmRrbS9zVXRzM3dXVnVZenNFSWtoelFqMTh1QmdJVVhwOFpEZy8z?=
 =?utf-8?B?azNucHQ0SlBlcHZtUnFkVnZyMTd2cDl2TG1kSVJDVzBkRFFSUE1uOXZGMERx?=
 =?utf-8?B?SGpSN0NqSW1TU04zQ1Uwcko2L2Y4SEM2TDlmTjhJWFZuRnJBOEtlV0REcXo3?=
 =?utf-8?B?d2w5S0l1d21HVWlrZ3V1blJqMnpROGN6Z2RuOVh5RXNYOHAvbTFzc3FLVXoz?=
 =?utf-8?B?Q2tDTkVTeFpROU1tMDAwV01iSEkyUmJTNURobW1HZFZTTzVGZy9OdTJPQjN1?=
 =?utf-8?B?Qm1DaTRSS29VbCsrL1JZNVJyTWpQbWxtTTBIUHZXdlU0NnVibGl5TTUvTTJD?=
 =?utf-8?B?SktRc3FrVy96WFUyYkZqaUtwOWJ3ditxRVN0ak9MNFZGK0xOKzhibVNwdU9s?=
 =?utf-8?B?Q01rbnJja0ZSbDU2WlhDWEtHdVh0d1VDUDhoQ1Z0cDRWVFRPOGRsQXpHL3R2?=
 =?utf-8?B?VDA1UDJqV0ZpUUZCcWh2NUtzZm42Z2Eya05XeEdHNW5wOS8rN3RNaEpmQ05t?=
 =?utf-8?B?MkZaWkNMSU9tUnkvbDhGY0ZaRWNhdWliL0x2RVZCczhWalBQRGlnMG5kRXhq?=
 =?utf-8?B?S3ZiZFY5dGgrbmh5NEFtdVIwcVlVTVF5TC9HODJ1MFY0eEhOMG5VYnUrK2pC?=
 =?utf-8?Q?VR376fQjXVSv9dM97OdQ+rrNu?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b894d861-41ee-4401-63ae-08db2947f38a
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2023 13:35:21.1062
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PN/CEL6ljkXiWWmLoJ2gbYeD8SzhZgTQM+Te4QRCn6qOgS2XM4QUbp4EAhQhXqu0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4509
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/16/23 16:17, Reinette Chatre wrote:
> Hi Babu,
> 
> On 3/16/2023 2:11 PM, Moger, Babu wrote:
>> Hi Reinette,
>>
>> On 3/16/23 15:41, Reinette Chatre wrote:
>>> Hi Babu,
>>>
>>> On 3/16/2023 1:31 PM, Moger, Babu wrote:
>>>> On 3/15/23 13:33, Reinette Chatre wrote:
>>>>> On 3/2/2023 12:24 PM, Babu Moger wrote:
>>>>>> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>>>>>> index 15ea5b550fe9..3c86506e54c1 100644
>>>>>> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>>>>>> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>>>>>> @@ -3163,7 +3163,7 @@ static int mkdir_rdt_prepare(struct kernfs_node *parent_kn,
>>>>>>  {
>>>>>>  	struct rdtgroup *prdtgrp, *rdtgrp;
>>>>>>  	struct kernfs_node *kn;
>>>>>> -	uint files = 0;
>>>>>> +	uint fflags = 0;
>>>>>
>>>>> Hoe does changing the variable name from "files" to "fflags" simplify
>>>>> the code?
>>>>
>>>> I should have said readability of the code. Its actually fflags we are
>>>> passing to rdtgroup_add_files. While changing flags below, I changed the
>>>> variable name to fflags.
>>>
>>> You are correct in that it is the actual fflags parameter but what it
>>> reflects is which files will be created. I do not find that using "files"
>>> makes the code unreadable. 
>>
>> Everything helps. I changed it because I was already changing few things
>> in this function. That is not the only change in this function. Here is
>> the main change in this function.
> 
> I did read the patch Babu. I trimmed my response to focus on what
> I was responding to. Our opinions differ on readability of the current
> variable name. This patch can focus on just removing the unnecessary rftype
> flags.

Ok. Fine with me.
-- 
Thanks
Babu Moger
