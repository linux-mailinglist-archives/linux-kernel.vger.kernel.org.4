Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 042375B5CBD
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 16:54:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229592AbiILOyk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 10:54:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230205AbiILOyd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 10:54:33 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2064.outbound.protection.outlook.com [40.107.244.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD3D8CED;
        Mon, 12 Sep 2022 07:54:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hFCkH7D6PnSJ7A0e/QU47md8B8tylR32StK9zTh0buPB0ao9H97mKVuWa2n+Z5kIVduL+GGQUKaP/nynLSVvzVYX3DXobY4u0PZoPKSxWN37CMV80sP51leRjOZQzzz9x8l0d1Nu10GtLdIj/Kc+qPD6KqWgrkll2tVyI808SLW/0wYUwIHcoq+5s+ZSz/rzH7JZ4UNH3TTcH2Su3f6Kx53mirHAZVN5o2PLp98YvWK+jvvxJHlIi5srO3Gv28IfPEB0HBE7kK+5jogR9RaD08zR02j7CV/VG8zRMt/mBlI7G9gZUasITvTTVvJRxIO7Mo2GUQHj9Nse9d3eFqr32g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cywUy7lxJ+kLPWfT3OqjaLt+/UBQgxbr2eLbfxeawX8=;
 b=buK4m+s11cSQssGhCe2RVI6zlzBhFqSTwDZGt9VQrniAzxwLqKwNrKbh2Bt1ffy2KtcmwdYKi3opYp5rQyaeHRXCWqPw0rP0JjTAd+pxV7s+fLeUfOIqgRu334c2m+iH/VVodOWBWAgyhMZwfX4bI0Y2kO0LQhfgHwn97JGqdCOgT+ZKy7nCDEbsCFZqMcSFpF6f9B16KWkpWTDADJ8PJcGzuVQ9OsVuKNcZbk4N3G1FDKbnuBGM+/ojELjEg3ZbVq7Y8jQ6KtHe48yK+YFcLsQ3hZXxqmJQDhmA0SDshSCQ4vAy0LgXNS42s+kv4fZEfPclH7OmY5SazqoEGR+WBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cywUy7lxJ+kLPWfT3OqjaLt+/UBQgxbr2eLbfxeawX8=;
 b=lsYrfPkdOrp+dLq7g3ArA6Zpzevjby64SY++NmKs/ER2wo5434o1TzeyMQqgd7E3aryqCEiqvGzYjuoqxYpT3TgXvzFIjm0qIeyurNpSbUmJPAOIa6MERYNK2KnyppFVwgr3E1RlYapCPKh9HHQI/pE8bQ17zBKY5ECP262EEtc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by PH0PR12MB5435.namprd12.prod.outlook.com (2603:10b6:510:ed::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.12; Mon, 12 Sep
 2022 14:54:27 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::4120:60cf:46a8:7109]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::4120:60cf:46a8:7109%7]) with mapi id 15.20.5612.022; Mon, 12 Sep 2022
 14:54:27 +0000
Message-ID: <b3b25255-c5de-f358-33df-1dc53939a5c7@amd.com>
Date:   Mon, 12 Sep 2022 09:54:23 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v4 01/13] x86/resctrl: Fix min_cbm_bits for AMD
Content-Language: en-US
To:     James Morse <james.morse@arm.com>, corbet@lwn.net,
        reinette.chatre@intel.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de
Cc:     fenghua.yu@intel.com, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, paulmck@kernel.org, akpm@linux-foundation.org,
        quic_neeraju@quicinc.com, rdunlap@infradead.org,
        damien.lemoal@opensource.wdc.com, songmuchun@bytedance.com,
        peterz@infradead.org, jpoimboe@kernel.org, pbonzini@redhat.com,
        chang.seok.bae@intel.com, pawan.kumar.gupta@linux.intel.com,
        jmattson@google.com, daniel.sneddon@linux.intel.com,
        sandipan.das@amd.com, tony.luck@intel.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        bagasdotme@gmail.com, eranian@google.com
References: <166257348081.1043018.11227924488792315932.stgit@bmoger-ubuntu>
 <166257359679.1043018.9253512972611409799.stgit@bmoger-ubuntu>
 <a60be378-dce6-08fb-02b8-1efc660ee3cb@arm.com>
From:   "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <a60be378-dce6-08fb-02b8-1efc660ee3cb@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0362.namprd03.prod.outlook.com
 (2603:10b6:610:119::9) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|PH0PR12MB5435:EE_
X-MS-Office365-Filtering-Correlation-Id: dcde4ade-cde2-4b8d-b952-08da94ceb0b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WUS/gTQFaiOGtPsHltyhoS592H8A5iLh/ITYeP/ypmyRWXpRqM45Qw51edFJ/kGENzCl9yoCYgHqwjUhyUvTnyKu2vwoydLwj4CGdlSCcCGorKyXyPFzWLHC/6Gx16Y+d6RaaVKXITemkm3snass6FUHZfPQ88Dv3rITLoPk4OyZ9jiJY96QnDcTD+TYFXL/iQ+bg/qYmjaOWuHvvL20TY6V3GBQW4CkkJW680mPRkzDH9E/gJLqdLx+Xillqd44L2ySaCl5cDtfo8BUnTdWnDKxljlst6s+fps7Shu49/Cn9ArEI6IMdK92OI4+n5f2Me8LcU5X4OiVojNHMkXa3pxbwh+3fvfDaoA/roP7UZR662x6FVrYsuvihHGJYwZpH3UpAOHtitSDVPHjf7fOGRBpI0NJJE2Tyjtr/5fewwvtaADcggTD5F6j9f3vM6j+lWHYWKgj6t4ZL5KqXqVSyt+U1DdlEj5gZX3xFFKxKCfbWp5QPZcQ7j3iwHSm8uU/p3/g9y4WIaRLXPDH2DxuEgeYfJXqG25/jRBSLfS1DNGlfsBBSrydzwCYV3f0Hxstc6FmpndopJhgBd2ZtrtPjpgofTxFvA/AD0FKsupAWXXCox6Iu9XG30yfV5hVaPRpzOonuAN7WUc+PD+rIdKrhV3+oB4Z0YI4wcMdCNm7sMQRIxVdQXShtXTjNca1eFcGqKPlzBmirgAoAC3DjzVOXFy2LWinBxYBVOLqZ05kZ0GQCFBaGdj2ozu76EanTfsqVzta2/gpQO2jYrolBjfe60d3+BqbICXK2mdUxD2smsHUaRbz+aXibXel3ixW972EB9iuKUIACUwr5yR62rihuQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(396003)(39860400002)(376002)(136003)(366004)(8936002)(3450700001)(2906002)(31686004)(2616005)(186003)(83380400001)(7416002)(4326008)(66476007)(8676002)(66946007)(66556008)(38100700002)(36756003)(5660300002)(316002)(45080400002)(41300700001)(966005)(478600001)(6486002)(6512007)(53546011)(86362001)(31696002)(6666004)(26005)(6506007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WllvOEpjV21TZnA0dEZEZWQyR09EeXFNd1RDQURGL1dRU3gyem1td3o5eVND?=
 =?utf-8?B?RmxWZis1aENTQldOazlNYXlRZ0wzdjlXMWxWQWk5a0NtRWRScE1hYy9uZTIz?=
 =?utf-8?B?SVQ1MHErcGdIcTlFZWZvaGJ2RXQxSDZOTzA4N05ETlE0dGJqdWxES3AvZjVH?=
 =?utf-8?B?Uy9pSkFWeFFOcFo3NkM1WEdUSC9Bcnp5M0dXdTFBbUh4WDlNRDFiMlM1U2pm?=
 =?utf-8?B?S2sxZ1MwcGNMKzh0T1RFR2tSRm90eXNjWVJic2RYQ1Z2dldVWk1BWnFqSmZx?=
 =?utf-8?B?c3h2OVdrZ3Eyd25VNnBoUmNBZjI3OVRaZ283d0RmVC8wY0paaE91WHhhc0ht?=
 =?utf-8?B?VHJmQmtHNXdaUEVYWmsya2FGTldoK2pJbFhvbDVwdjFmbi9kQWFrRU1PUXdM?=
 =?utf-8?B?cFdMTEhQeVVBUEU0L3MzN2dqdit1K3RYUU5GUXFCY3QvR3Z6QWlic3p5OHlp?=
 =?utf-8?B?M2dQTk1yeEdXb0pNY0lIM1B1TUlOa0daeGRVVitWUnMzaU52clpOL1NzK0I5?=
 =?utf-8?B?NUxzRzM2MVFsaXBwUUZ0RWhPdzByWTBUbTBUbXl0eUlUQ1FCT0VGNlNNS213?=
 =?utf-8?B?Qk5INFMzUTI2a0diTFp4a0srUGpSZmdvR0lIV0RpVzM4YzJGTFJvVDV6YUZG?=
 =?utf-8?B?V1pTK2FVMmpxLzFlWnZPaWZwbEFvOUo5Y3YyZXh2Y1VmSEgvRFVoMWhQK0FV?=
 =?utf-8?B?UXE5czNmenB3QWtlQ3hqa1ZqbFl6V2EwSDJ2RVQyeUZnWG53bHpqSDBFUzRT?=
 =?utf-8?B?WHMzTlhlRzhieEdvekZDaFN0MzRYMnh3OFhOUjFUanRjSDR1M0dpTWxLOVFQ?=
 =?utf-8?B?WG1Na2NPY0FIR2NVS3FUeTNNNXZUQStaN1VreGJRMDM2MkpKd2R2NlNrQjNk?=
 =?utf-8?B?ZzRIcWkwRUd0VnJYNVZZV0kvYlpPYVZKVmUySk5ReTVBd3ZheGlkcEtGY2VX?=
 =?utf-8?B?VWJzeUxRbEJJeXBGUGtxSi9xb2o0dmkyQWVuV21BMkR2ejdIcmJoUFRLVHpD?=
 =?utf-8?B?VGVsSDNWMDdRSU4rR1ZsOVBkSm9KYThTR3B1alpQUDBESXllZDZxb0RYdndS?=
 =?utf-8?B?VDJPNUNaS2d2Sko0a2hRYm1aQzE3cHNiWnoxK1M1RmlKdDJxeWQvY0FhSkh1?=
 =?utf-8?B?dXpIRThkTTJGcjBZaXVUa2VGWUJacENsblhYZVV5K1ZvbTdJamloTW1odkI1?=
 =?utf-8?B?QWwvUGI1cEZMd0lIQ0QySnFhcDFYcFhsZnlnVGx5U0I2S21zeVdGa3k2NE1Z?=
 =?utf-8?B?cDg0cTVqTDJiTlQ3TXREdU1TczMxNzZrUFNuaTNpT0JYOTBvZHR5eFJxOEoy?=
 =?utf-8?B?M1ZpUi9URHJTOVhVSjlzN0NlV2QyYURnbXVIZm9NYWY2RkJPQ2UyL0Vmam9F?=
 =?utf-8?B?NFVZSm9BbU93ZWVweEMvcjcrcUkzS2ttQnY1ZXJSYktZWXdqc0RIUTF6UHBR?=
 =?utf-8?B?dnUvZEM4SytIeTZtQ2lXZUNBUG9pN2FXRk53U0ptR1JrbTdmZG5VbkhoUlJI?=
 =?utf-8?B?c0hJODQ4eWZpbk5xSUg2VGJIUTRGeWFiditnN2VwRkZsR3pIK0JFMUxQNjJM?=
 =?utf-8?B?d0dZSUlpUzIzVFZUQ0dkTnNvYms4cEJxdzNsTDV3TGhnTU9WV3BUQklyaUJv?=
 =?utf-8?B?eWVpUFpINFQrSnZCTnZFMHFyRDRmSEl5a1VCekZTWEd2TEk2eWVrWmNCNDNR?=
 =?utf-8?B?S0NlTHFmbXRrczVZNGV5MGxiUzRvRHQ4VlRUVWg2SEIvWWpmSzRLZ2dYSUNH?=
 =?utf-8?B?RWYyQTFRQVFENUhTQ0hFKy95eVdBNWhmdUVkbmVETzdzUnRCOHVnR1RPVjRK?=
 =?utf-8?B?WmN5Z1VzZGtOTldVVTcxM3IzV2xFMjYwWmtKMXQyWkhMUmZOcGttUTkvTzdW?=
 =?utf-8?B?VUtzNlh3MEtZSjVPcms1TDFYS09JeUt1M0FrNlpLWXFnd0g2UmFuQTZpMkwy?=
 =?utf-8?B?bFRwZ1VSb1c1bU1qeFl2RlFSSE44amNYNGROWVROR3c4NGJGZEd0Mk9qNHA3?=
 =?utf-8?B?RTVkS1lUU1hEYm03bjRWemF2VWg5T0REdmk4ZFB1ZWY1UTJyNkt0K0xMTnJS?=
 =?utf-8?B?ZHU1ejhGaFNydGZ1djQ1RmVaOFRSVGtUUTJaTkdSOU43cUZudjMxdFZXWkxS?=
 =?utf-8?Q?Pc8A=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dcde4ade-cde2-4b8d-b952-08da94ceb0b3
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2022 14:54:27.7119
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: av+MDNvbuTtHnlPfzP2udRT1vzmU22ln5JZXNrJkBVILRilRaKZypUEJlo+RbtIM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5435
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On 9/9/22 12:00, James Morse wrote:
> Hi Babu,
>
> On 07/09/2022 18:59, Babu Moger wrote:
>> AMD systems support zero CBM (capacity bit mask) for L3 allocation.
>> That is reflected in rdt_init_res_defs_amd() by:
>>
>> 	r->cache.arch_has_empty_bitmaps = true;
>>
>> However given the unified code in cbm_validate(), checking for:
>> 	val == 0 && !arch_has_empty_bitmaps
>>
>> is not enough because of another check in cbm_validate():
>>
>> 	if ((zero_bit - first_bit) < r->cache.min_cbm_bits)
> Right, the Intel version had this, but the AMD didn't. I evidently only thought about this
> the !arch_has_empty_bitmaps way round! Sorry about that.

>
>
>> The default value of r->cache.min_cbm_bits = 1.
>>
>> Leading to:
>>
>> 	$ cd /sys/fs/resctrl
>> 	$ mkdir foo
>> 	$ cd foo
>> 	$ echo L3:0=0 > schemata
>>           -bash: echo: write error: Invalid argument
>> 	$ cat /sys/fs/resctrl/info/last_cmd_status
>> 	  Need at least 1 bits in the mask
>>
>> Fix the issue by initializing the min_cbm_bits to 0 for AMD. Also,
>> remove the default setting of min_cbm_bits and initialize it separately.
>>
>> After the fix
>> 	$ cd /sys/fs/resctrl
>> 	$ mkdir foo
>> 	$ cd foo
>> 	$ echo L3:0=0 > schemata
>> 	$ cat /sys/fs/resctrl/info/last_cmd_status
>> 	  ok
>>
>> Link: https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.kernel.org%2Flkml%2F20220517001234.3137157-1-eranian%40google.com%2F&amp;data=05%7C01%7Cbabu.moger%40amd.com%7Cc5b955e9726344c550f008da9284dedd%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637983396695085653%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=wIVM5%2BrCwfWDpIrLkDtycgoCd4PWMC3D8y%2FAjshIW%2FQ%3D&amp;reserved=0
>> Fixes: 316e7f901f5a ("x86/resctrl: Add struct rdt_cache::arch_has_{sparse, empty}_bitmaps")
>> Signed-off-by: Stephane Eranian <eranian@google.com>
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
> Er, who is the author if this patch? If you are reposting Stephane's patch then there
> needs to be a 'From: ' at the top of the email so that git preserves the ownership. You

I can add Stephane's name in "From" if it is right thing to do. But this
patch was modified from the original version Stephane posted.

https://lore.kernel.org/lkml/20220517001234.3137157-1-eranian@google.com/


> may need some incantation of "git commit --amend --author=" to fix this in your tree.
>
> As its a fix, have you posted this separately? Mixing fixes and new-code makes it hard for
> the maintainer to spot what needs to be taken for the next -rc.

ok. I can send this separate in next version.


>
>
>> diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
>> index bb1c3f5f60c8..a5c51a14fbce 100644
>> --- a/arch/x86/kernel/cpu/resctrl/core.c
>> +++ b/arch/x86/kernel/cpu/resctrl/core.c
>> @@ -66,9 +66,6 @@ struct rdt_hw_resource rdt_resources_all[] = {
>>  			.rid			= RDT_RESOURCE_L3,
>>  			.name			= "L3",
>>  			.cache_level		= 3,
>> -			.cache = {
>> -				.min_cbm_bits	= 1,
>> -			},
>>  			.domains		= domain_init(RDT_RESOURCE_L3),
>>  			.parse_ctrlval		= parse_cbm,
>>  			.format_str		= "%d=%0*x",
>> @@ -83,9 +80,6 @@ struct rdt_hw_resource rdt_resources_all[] = {
>>  			.rid			= RDT_RESOURCE_L2,
>>  			.name			= "L2",
>>  			.cache_level		= 2,
>> -			.cache = {
>> -				.min_cbm_bits	= 1,
>> -			},
>>  			.domains		= domain_init(RDT_RESOURCE_L2),
>>  			.parse_ctrlval		= parse_cbm,
>>  			.format_str		= "%d=%0*x",
>> @@ -877,6 +871,7 @@ static __init void rdt_init_res_defs_intel(void)
>>  			r->cache.arch_has_sparse_bitmaps = false;
>>  			r->cache.arch_has_empty_bitmaps = false;
>>  			r->cache.arch_has_per_cpu_cfg = false;
>> +			r->cache.min_cbm_bits = 1;
>>  		} else if (r->rid == RDT_RESOURCE_MBA) {
>>  			hw_res->msr_base = MSR_IA32_MBA_THRTL_BASE;
>>  			hw_res->msr_update = mba_wrmsr_intel;
>> @@ -897,6 +892,7 @@ static __init void rdt_init_res_defs_amd(void)
>>  			r->cache.arch_has_sparse_bitmaps = true;
>>  			r->cache.arch_has_empty_bitmaps = true;
>>  			r->cache.arch_has_per_cpu_cfg = true;
>> +			r->cache.min_cbm_bits = 0;
>>  		} else if (r->rid == RDT_RESOURCE_MBA) {
>>  			hw_res->msr_base = MSR_IA32_MBA_BW_BASE;
>>  			hw_res->msr_update = mba_wrmsr_amd;
>>
>>
>
> Reviewed-by: James Morse <james.morse@arm.com>


Thank You.

Babu

