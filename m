Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A24EF6630C3
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 20:50:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237228AbjAITu2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 14:50:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237836AbjAITt3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 14:49:29 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2083.outbound.protection.outlook.com [40.107.94.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5560665B2;
        Mon,  9 Jan 2023 11:49:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KKSmJ5iLQpQ1nO7byDqDaIlCI54t6ff/YDtQuD3Avuu6+5AsHRMJtX9sH7P1fuQV7l0TEiVr9Gzw5tUlSNc76/pQvcVMt0XDFlr8vukmksFunnPyLskUrWhHVKDTXVNiFmNw6gKDzx1ZJx4IekejcCs1zr+qQO34zUZ3eDQW0zD3pGiIbEnaWFPQcO8NDym/eyS/+Plm8k+Fl+lcknziMopWbflXd49stspEkrTorbVBZJTKD5wxjsttjEeuAInkQSGBISb1B+vS69qnHD30wtQUZyv2HyJazhjOW+0tK+hqwl6aLKxNbXTi/S7Zx6k8QFCAZ5yjMPOd9Iha1iGJnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+13QUbZRk+0KrFZ0VZC3VsffakQ+hYa/4CuXh8csSws=;
 b=SSmVrQDBXVOHBa/4tJA4hv2dYs3lPU6dvbuw+sYxx5yftCdY8aCme1mozw+3HqpTUPhdaS2GWl3tsnm8DsZWx6MUs4rY6amMOCmIO/yC2pcjLHGJ9aT/IXH1AfueHpCsOq3E0rePpNpH6fAOVd4Uywixy/ZlIGFR0G/fQD6ffs/kX6GIvNKnDlB/uczAKrWaxB74cz16kJm8Y4JvTtkJGAvSKfkTPIMM/sj0VfQ4WPRsInfTRSk3iT2sjvUB1Mk/O2QklDlPkRkTUlEnwfxjQq2kRGzy6IOvJrUkL6anuK3aYTgolfzHpwAoMJnHRlBu3Y/WETMFlllIGkcIPu1FEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+13QUbZRk+0KrFZ0VZC3VsffakQ+hYa/4CuXh8csSws=;
 b=NvwggIgDg09SWNNp3fs56PdCWAf9v+44NZ9G/GENeBq4mw29F2TieRoPxQ9ytODMb6Wcf5wbt/mZA86k7SYz03NmSmg2Iz/+KYfzKQs8JSErH05PfO0ofM/iEll1VX5ov5P7ftv6EA9h3UbotrZzEjbsLGITLHFg6Nt+lbg4pPU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by DM4PR12MB6542.namprd12.prod.outlook.com (2603:10b6:8:89::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5986.18; Mon, 9 Jan 2023 19:49:16 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::790c:da77:2d05:6098]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::790c:da77:2d05:6098%7]) with mapi id 15.20.5986.018; Mon, 9 Jan 2023
 19:49:15 +0000
Message-ID: <5afd0a7c-3fbe-dfea-f1b4-2fc35fbb4f13@amd.com>
Date:   Mon, 9 Jan 2023 13:49:09 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v11 04/13] x86/cpufeatures: Add Bandwidth Monitoring Event
 Configuration feature flag
To:     Borislav Petkov <bp@alien8.de>
Cc:     corbet@lwn.net, reinette.chatre@intel.com, tglx@linutronix.de,
        mingo@redhat.com, fenghua.yu@intel.com,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        paulmck@kernel.org, akpm@linux-foundation.org,
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
References: <20230109164405.569714-1-babu.moger@amd.com>
 <20230109164405.569714-5-babu.moger@amd.com> <Y7xjxUj+KnOEJssZ@zn.tnic>
Content-Language: en-US
From:   "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <Y7xjxUj+KnOEJssZ@zn.tnic>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL0PR1501CA0016.namprd15.prod.outlook.com
 (2603:10b6:207:17::29) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|DM4PR12MB6542:EE_
X-MS-Office365-Filtering-Correlation-Id: 78d1117f-3751-4392-a56c-08daf27a96bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wok3xWV3AGwb0dpNskWfziLuIytrHKkv0m4Bc51b5BPDhIu3wIFu0NZDLhyQtFnE4BHNcgufCxvrvSLUS/IH5MyyJgJ0BVfOaLHZnFdhL4L9lJjEMqBbnKf31CA9ONpO394b9XD3D/reG9+KrGMcqRQFs/vmj9SD/cx2vbYcbPG84eZi7aRRiemI5tPgZPAyRNVmjPQIoxFyLzmCswKpbS2DnOuWFnJs8OAE/nwsQ+1OM0Z/dxsktQq5B9UZwE7RmKYtoQdUToOy3RtOAjHKq3SsDb+p3KlDLcsZ68iaeHcKQUnKHS5kQyCi15Rsvq+5sT6v9IHTjBXLujoID5acqiiXt1wBB0OwhHDIGXx/E04KXmw60OUZyDIyc0yVME/H4MfB8aVDkkZiIQfcEdUHp+D//zRc4OG+9bbpJV03qpDTHl6HnR3WLCJIvZ5KwWlsSI8a5EfuJDkoANVFJJrBfJNPd+Ex504pICKBudWmprPYkesRklrVyjOkvjSMHEzxMvytW+1Z0es4eAYH3g2GpRMXIXqEiy2UQjc0XyaVASMvOWQF7wCeDJx2e7j59RLVj4wXjvDbH7kIPzmi63Cqs0saQ8ROHS3NHNQbbJDg/MLHYXk9TO5KY4mlv1XmgdNJLkdgvS5NJAiHsWikUsuOr/KrLLT/LYChyalEH00iTVWeQu3Uyzne3Ug6j+zM2KQnfYSLpzYj/2pa12Oh3cmo6IG8PwghbQtUKSRPS5L59qg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(136003)(396003)(39860400002)(366004)(451199015)(41300700001)(2616005)(316002)(6916009)(36756003)(66476007)(8676002)(4326008)(66556008)(66946007)(86362001)(31696002)(8936002)(38100700002)(5660300002)(7406005)(7416002)(2906002)(6506007)(3450700001)(53546011)(31686004)(6486002)(26005)(478600001)(6666004)(6512007)(186003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K2JvY0R0QUlpekhZV3liQ3NIM3dVVDkxQkh5WUxLUlhmc1BsSjMyUDJUTkJs?=
 =?utf-8?B?YlliWlpGMEVPVW9OUThNMTJRNkUwamd6YXkyYStLK2V5MVV4a21rdjBCOE9j?=
 =?utf-8?B?VjdLeDBhTTVVU1Q0SVpUNlVUaE5YTlhlV0xYNFlXN2pZd3dITFl5SkNOQy8z?=
 =?utf-8?B?SFBDMWdXMk9lTjlYTzZZSHJZQ0xlVFdIbjRxOG1tdngzTmVMK0JwWHpwcndC?=
 =?utf-8?B?UVEzRXl2RXlHc3VvY1lvamV1RlZWN0N5ZDJqN2QwZUpMSjNPQVBwQ1NqOUpG?=
 =?utf-8?B?bE14aVBzU1EzTmw4T1RQSGw3WDhBdFY1RDdVRDE0cGgvQW1xQzFHV0MyVHVv?=
 =?utf-8?B?VHhtbi8vWkRlRHltaEhzaldnZjBJVTk2NWtxL1pzQjVoUnNyd1RsZzlSQmgx?=
 =?utf-8?B?ZkErUkZmZWZZNEU0YnpRa2poTk5JejVUandFbTE4emtzaHpkcUpMMVUzRDNx?=
 =?utf-8?B?T1BHcXg3bHUwS3dRcnFUVExFbGJwRnlId0xNQnZ1WWV6KzdwMVNPSmJqTDhW?=
 =?utf-8?B?MEdrT0Yrd2xSRGNQOHhlZkRXZWp3b3R5Q1hmNzBsUmU0WXk4ZEZ1eC9wN2lO?=
 =?utf-8?B?L0dmNHNJeThXZGw2Zzljbk8xc0lsNE52TldjWncrWC9sditmSG00N3MzOEts?=
 =?utf-8?B?SzZDMW8xZjdiTDluQ0RqQnY2SXhGWGR2RXpYZTlNZTlLeHBJU0RrNjNZakl1?=
 =?utf-8?B?dmNuMm1wRlBiNXIzTzVLekZoc1RvWnhvY2wvY3ZuSE9vSVJVYWUwVWo2K0FC?=
 =?utf-8?B?UTFtUGhncDFrT1UrdEk4OGovdEVHYWkxOHJRRXJNbFF2UVF0VStuS2F2Rjkv?=
 =?utf-8?B?MlU4UEUvemFSTzdhR3B0UGtNSnFmaFZIdEQ2a285bnltMVBJdEZ2MHdOeEZr?=
 =?utf-8?B?RzdZNUs3aU1CU0R3eEZ4YWJEWVB5ejVubGowZHZwTG5iRXdsRmV3TlhqN2Vh?=
 =?utf-8?B?MWdwZ3JNcjNxcC9rMld2bkxQdUVRTURNNFpxWHZZUWJnT3g1Q1c5elJPKzJT?=
 =?utf-8?B?eDhOeG9FKzkzTGVxV1NYWEZMbmM4Wjk0WkdUd3ArQTVCek90Z3dKbzBKbm1z?=
 =?utf-8?B?VWlvWnhmeXZRV2RoN2g1QWF1NjZkUGUzM21idmo2NSsxQmx0QWlKeFczM1ZH?=
 =?utf-8?B?TXBJSDJZWVdnbHJBQjFIalhydFJYOEpRdFB2VHFQNlQ2M2M4a2xqVHlaSkpD?=
 =?utf-8?B?VHBFTy9iMGM2VmwxVDFXWEtER1hYU2IxWkh5ZFU1K0JpcHJSWFNDNjFSc1Bz?=
 =?utf-8?B?TmRSU0s2R2s5eXRxN3ZwL2hqTm1vNjRmMXg2TkhDS21rc0lwTE9VeGtqWFZK?=
 =?utf-8?B?dTlrU29qVlE2RGZDMnNsV2pBZlRhZWFURkFLaWRyL3pNZUV6WXNVNDFxano4?=
 =?utf-8?B?ZWluNnFrd1pzNXdWR25GdDB5eVdCS0doR3NSeWFBdmxyTUxYL09OZ1lJS3Nu?=
 =?utf-8?B?aW42THJQbG9JdmVwTXh2ZWI2YWdLWkUvUGJxUWgwLzBxdmk0N3VtRGpZaGRE?=
 =?utf-8?B?UGI1eklGemNJN2lLdGUvMjJuMXIwVnNwYzViNWVjdSszb3k0MnFMWHN0L0dE?=
 =?utf-8?B?eXR6Sk0wUnZvSFFoT0ZkU1hReGdaQ21SMDdQdllPc211THpRdGViVEtMY2Zi?=
 =?utf-8?B?M21PbWwrcDNJUVNuWGJuTWtFK2NpZVB4SWMrTTY1WTBvQXM1ZnNwYUd1WHZn?=
 =?utf-8?B?UnVWaEFPaVVjMTdsODVESm5ZSDcyUFdrUmsvNUNGUDEwOC9NVTJMaXJWUXZG?=
 =?utf-8?B?NisyV1Q4NWwxMVRkR3ZKd0RiSkpDbTRpL09UU0ZOS2hVY3gyWTVraWNoZWtt?=
 =?utf-8?B?MHR4NnBTVlNocjFPV0EwZUVXb20yUDg3KzhUMVV6ak5oTy9Hcjd6Ris1ZXRJ?=
 =?utf-8?B?aFhwWmFYZEl4ZGtJK3VEcnN1dlRPTWNlM29SVGNzSW9ZdzRHMEZUbmh2NEJT?=
 =?utf-8?B?ak1YY2NraDFOdFJmSXR1RFZvZ3BYNEY0cS9pZitSNVZtRUpRM3NyckMrblpa?=
 =?utf-8?B?dDExeldERXpiVEFKcUhFVWRIaVIyY1FlSHJ1SjhrNzdwd21iQWZ2V3NZNkpY?=
 =?utf-8?B?V3lna0hvT3JWVFpxbm1ZY2E5TG9JNFQ3OFovcjF3elV3Wlk2ZHRveForRU43?=
 =?utf-8?Q?Tbjc=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78d1117f-3751-4392-a56c-08daf27a96bd
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2023 19:49:15.7476
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FoMOyfzvzHRbGEu9LZtI6ILiO1WbiT/vMzg2rGo7Q+mKrqxbN23XnM9kfTHjnqgf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6542
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris,

On 1/9/23 12:58, Borislav Petkov wrote:
> On Mon, Jan 09, 2023 at 10:43:56AM -0600, Babu Moger wrote:
>> diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
>> index 00045123f418..db5287c06b65 100644
>> --- a/arch/x86/include/asm/cpufeatures.h
>> +++ b/arch/x86/include/asm/cpufeatures.h
>> @@ -308,6 +308,7 @@
>>  #define X86_FEATURE_CALL_DEPTH		(11*32+19) /* "" Call depth tracking for RSB stuffing */
>>  #define X86_FEATURE_MSR_TSX_CTRL	(11*32+20) /* "" MSR IA32_TSX_CTRL (Intel) implemented */
>>  #define X86_FEATURE_SMBA		(11*32+21) /* Slow Memory Bandwidth Allocation */
>> +#define X86_FEATURE_BMEC		(11*32+22) /* Bandwidth Monitoring Event Configuration */
> If those flags are meant only for internal kernel code use - it looks like it -
> and userspace doesn't care, pls put "" in front of both in the comment like the
> others above them do.

All the QoS(or RDT) features are visible so far. If we make them visible,
users can easily figure out if this specific feature is supported or not.

There is some benefit if we make it visible. What do you think?

Thanks

Babu

