Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5902D6BDAA0
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 22:11:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229948AbjCPVLZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 17:11:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjCPVLX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 17:11:23 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1F4619C5B;
        Thu, 16 Mar 2023 14:11:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YBrLCZE7ivm5+NZZnr7T2/EjnYOQtoW1kcXaTIgXsrz4sB/12IGC5fdKqw2wA694qmSVFHkT7qyiaC9i7rWkditgjD5hHeBcvPSv5L1huerKklUipj1agzANh8ZUZpx/bS0kiaLI7Y8knGKK3QDLtJjBQ4VHBlSGRslqCTz+O54mj3lAPR9UDNp2eFcPXlNFgzBzlw34RggffP1GtQJIJBMM0qjvNhNEfFyaQ/Qecv6nFg3KlQBSpPnDUZrVB1hOygMEjImrZmT4bbZOLwj6YpBnUMF9JdEj7iIpmsXlWzuyDMc8GtDh0bnuqy61V4RhofSRStURQVa4atFN6ipOKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oNr+UdpiheZwKszhKoc5Z/GUBaD7XVLkVpZJBHscPps=;
 b=dOeljnVgls/AyPcVxZEab+2CMhchSw4Kw1vGN4XR5YbcPynOGbddfQ3uiZGKqXC7kChlbTu1WtxesXIqfdH76tV5UNoYYXYxp4bTZyGpj0aDflaa9ol01YEFtuUbQCANQ6614LahODiQulaYFzGKo5JIMSzLabHkYcqU0B2Cq5T1OP9l3lO7auqLY6HQg3gjI2EvWxUuoR9lDJ8pAvYoR6B/8V8UGEMdh2P+2hNgCqUMiUthYOokmRhWQqnFj3nnzuiCPmk1KVgdXCUvBFK/A5yT6ymtYlEY6fbKGYzX4HunMl0VIWcK9xtMqFt+1eBnE6w4T88B17ljfEGZqfrjgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oNr+UdpiheZwKszhKoc5Z/GUBaD7XVLkVpZJBHscPps=;
 b=oC0WovGOBWY+gQIHQDBQsvPFhfD/0YSg0oSXPcTJicU+zuKdI8/Ia7cs2PYIoKWEtAHooGhOGFrrJ9gleLn4s37X9t8FAGbBySKtYuPsfutGAp2a0mdEqJo3fgFnkLCDrlpWxiOESM0T20YIIdvSc5N9mic8sPBo8Q+//HXpu8g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by DM4PR12MB5745.namprd12.prod.outlook.com (2603:10b6:8:5c::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.26; Thu, 16 Mar 2023 21:11:17 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::3490:de56:de08:46f6]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::3490:de56:de08:46f6%9]) with mapi id 15.20.6178.029; Thu, 16 Mar 2023
 21:11:17 +0000
Message-ID: <c07dfb04-4502-47d8-ad89-9f9c7898f246@amd.com>
Date:   Thu, 16 Mar 2023 16:11:09 -0500
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
From:   "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <4af7feb7-7663-7bab-33a4-7ffce092f55d@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BLAPR03CA0128.namprd03.prod.outlook.com
 (2603:10b6:208:32e::13) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|DM4PR12MB5745:EE_
X-MS-Office365-Filtering-Correlation-Id: 725c72ec-89ba-48eb-f5b8-08db2662fb1a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JbFq/QfW41n6sTFgZWi8pyz+wgl3F65ooueASNkW3iKCKkjQrYSBebHzlHrkDpTHPXCkwWPeFjChBuNqwmkMPqgsmEqzHKd0bALLiLuesLZdteHHH+yXW2W11Ma35Usk9CBhJ7IDKXxuDKtYRnlwJ4ZMYFUiBJyo/8JZ0u+qZpNX+4Kyvjb5VKfSconB2nI0+3GZdU+G607zXvdCvQBMkLCKlSz38YRmR4113lC2FI6Vk557xRTIf5YiJ1OKKGFUUjJUtBfVnzseLZagCMRItWAobADqOVJzkaSPwXesUmbHQ5bigUrTbM7XDpyF2bvuGEcTLa4wEj8VpuLd2cE6CJKrZrb1XyW0t7XAaQd/Ky0eOPQhjV9edGorA6DlRUSqp2qDphgLFRIYt2ek8FNup9aaPIqWOdvejxHs+yqMp5XEWR6J7nNTt9Ov6Uuod7VfkVvDBOY8IUQpGx+h5/QASqCzPl5Ng2e4Nrgh8jukL2ikubb10+TYdfLhHOS63kE8uT9+GbCS/UP9AyABVH34tArQwKwoE78JzQaUJW9HQbPUyDHdu5v+s5dQCjGpmENIkUirFotmNue0nZ8R1RXnne2Igb4dQByKqtfk/Ut/vwl8UT1/5T48KkVhSrd/WYvrQxBea49ZsNNXx9aD28FeTPaoK7JErEgZvq8X2Cz7L1kKZ9ojpDHX0ZV4jChaPG1fMwJc6mRLg3SPOO8jDo4HpZPUsQuOcp5vu4ULFWW//bE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(346002)(136003)(39860400002)(396003)(376002)(451199018)(36756003)(316002)(6506007)(41300700001)(83380400001)(6512007)(86362001)(8936002)(53546011)(6486002)(26005)(7416002)(5660300002)(2616005)(7406005)(3450700001)(478600001)(31696002)(66476007)(4326008)(66946007)(8676002)(38100700002)(2906002)(6666004)(186003)(66556008)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SmRhSEkzb1prS3dwcUVrOEtNb3h0ZUVidnVDcjdUYzBiOW9kNHlQK21CMi9i?=
 =?utf-8?B?a0tONFNndEhmVW1pVUtibGhIeFhaUmJJOU9aUUd1TnZRQ0ZJb1VCai9DbEUv?=
 =?utf-8?B?azBtMDZMOERPSDFnbThxQ2N5TmNzNUhXbkFXWjA0R0liZmVuMlRvUjhkczhT?=
 =?utf-8?B?RVplQjhmSXhRMnJIU0VMT1ZUcHVzdkQxRXpaMkNhVEVxV3lXYU11M0I5TVE3?=
 =?utf-8?B?MDdRSDBUekdNVDF2QXFPNGMxN2FOenhCNnJvVW5HZDlMbmpjREYxT3lLQU5z?=
 =?utf-8?B?M2NHbFN3QXB3ZjRpZFc3TXIxdGpFWUlhK284VFRDczR1M2pETUtrZUFycmFB?=
 =?utf-8?B?MDlCVytCMWRsTHVIaG4xVVdObE1nazNCbXdOV2g4aUZaRldIdmdHU2ppQ3BL?=
 =?utf-8?B?TUhYSytXcFJCc0g3LzEyaWNZN1BjbCs5UCtzRXJTNW83OHpTUWhqcms3U0pq?=
 =?utf-8?B?aGM1V3BucjlsaEFIbkdwaVYxUnMwOU9lcnFPblJjZmpyUnN2Lyt3UUY2T0ZN?=
 =?utf-8?B?U0FPSTdCalVvdFdrSWIzekgyUVFGYUxOVmUxY1FieGZlUFlTM1NkbVF3aEZG?=
 =?utf-8?B?Z3AwR3hYbUdWR0tFYnpIUWhrM1NmelBnem5OUG9XbjNrS3FQdmEya1BtUG5U?=
 =?utf-8?B?ZjZxWXVOeDloK1FkYkNjc1R1b0lqa3g2c3phWkFOa0FCbWRVdFVkK2NmdWll?=
 =?utf-8?B?THdBZEpFSWVhUXVBTmdReFN5cXA3N2FQa1dIYWdCMFdLMnhIakZSUmFXQUds?=
 =?utf-8?B?WVl3d2MwU0JxRUVEVHBKVi9lSlN2QzVMdDg2Ni8xc21IbFNJL2hGajhkcHRp?=
 =?utf-8?B?eUJXRG9RTWRlNWtEUFZVODNZbVdEVnJEUzZuSi80aWIyVEZzMjloalpFM1RS?=
 =?utf-8?B?TnpFRXpXRkdaalhmRUpUc0pFc2plTGlHWU5iamVSdVJpQmR1b2ZDTzM3VnBV?=
 =?utf-8?B?RThReWNzTUgzNEliWC96K3VrQUlmRzV1YkYvT0RyR3pzZ2xLcndpTmdRODk1?=
 =?utf-8?B?RkdESEFPdVVPVzE3bDVWeVlseVp6SEhBZW9KdFIrSDhQYmhHSi83Sjl5dG1k?=
 =?utf-8?B?VnFaM1JoMHArbkhyV0ZZa1ZGYUF4bGlrc3p2QmFFbGRLK2NIYmd5ZzZwVnln?=
 =?utf-8?B?QVhpME9jUmREZGM4MFdJRzIvNFBBOVVKSUJZMzh0SkVsczZERE1obHZ0S0xJ?=
 =?utf-8?B?aXRySDBVRy9rdXJaekM0OTd3cEpRK21RKy9VU0pINGtKbmtiT2dSTjVrTG4z?=
 =?utf-8?B?N2U0em5Rd1VHVnRDc3J1OG5Zc3hPT2tsMThrdWl3eHRKQTByMnphNUFzU1pY?=
 =?utf-8?B?UDJ1VEdVQUZINWJpWXlVbEZ1d1FXV0RkNUl0ZlJkV1NuOCtyWUpvR1p5dEs1?=
 =?utf-8?B?UXU3RmlsaDJ1emZFZnJOS1k5VTU4N2VoQjJrdm94UzM1cFQxbW01d0RtNXV3?=
 =?utf-8?B?VHRWZUoyZE9XMmpkaGNrcGVwMmgvV0tYcHdzMlJWQnFuN0ZQYjgwaXFwV013?=
 =?utf-8?B?L2w4dzhLek0xSkJoUE9hUlozc3VxWG56bjkvempQaVIvMTdZTFpNeGllbU1U?=
 =?utf-8?B?SVNGWFphOWxtZTJ1S205YitCQkltUW1LaC84cjhpdk14QmVtdzFxV2liTmd3?=
 =?utf-8?B?RE1IbElmZEgxeVFPcm81cXZHUWI5cmlmdllyUWYyZlVFazBIZlc2QWh1cmkv?=
 =?utf-8?B?dzJqNnhBcmt3T2RibDNFZ3hzaGJSQjEvL0YxRTNiak1IUEExRjZDRThWTndv?=
 =?utf-8?B?RmZoN1l3SzIwVERqVkM4NlZySksvZFJwczkxOHFGRzYwSDRQN2tta2VvZFdN?=
 =?utf-8?B?ZzltM0lPeE1PSk5WM01Zc0U2WW55ZFphc04xUVNGcS85UHp2MXI1dldyb3FJ?=
 =?utf-8?B?OWg1WUV6Uk1POFNtZHVJT0Q2WWFKb3IxZEh2dTArbHVGUitKLzFLN043TVJN?=
 =?utf-8?B?K2o1MHFqMk92ZnFkNXZxMVZ0RUVDWFNLV1dwZkdPN1pSTVRoYVJUT2dtY0RJ?=
 =?utf-8?B?Q3BvWXREWHhIL0F5bTRlQ2R0cEd3ZGlFTkMrNmhoUXFKVzd4ZEg4RUNnaSs2?=
 =?utf-8?B?ZEgrMkpyL1BLenBPTmVHZXRRdUlYZW5nTnZnWXhDWjVna3B5WGVEc3dnbkg0?=
 =?utf-8?Q?4JDeUi12KAUSg51hS+MaUUwOV?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 725c72ec-89ba-48eb-f5b8-08db2662fb1a
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2023 21:11:16.7367
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SCPu/XYLsFrz2lWcebyKW7y/aA0VE5Lx6vYAl+K3kkFXIkZOEu5ZBz7Mi1F/yGd3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5745
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Reinette,

On 3/16/23 15:41, Reinette Chatre wrote:
> Hi Babu,
> 
> On 3/16/2023 1:31 PM, Moger, Babu wrote:
>> On 3/15/23 13:33, Reinette Chatre wrote:
>>> On 3/2/2023 12:24 PM, Babu Moger wrote:
>>>> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>>>> index 15ea5b550fe9..3c86506e54c1 100644
>>>> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>>>> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>>>> @@ -3163,7 +3163,7 @@ static int mkdir_rdt_prepare(struct kernfs_node *parent_kn,
>>>>  {
>>>>  	struct rdtgroup *prdtgrp, *rdtgrp;
>>>>  	struct kernfs_node *kn;
>>>> -	uint files = 0;
>>>> +	uint fflags = 0;
>>>
>>> Hoe does changing the variable name from "files" to "fflags" simplify
>>> the code?
>>
>> I should have said readability of the code. Its actually fflags we are
>> passing to rdtgroup_add_files. While changing flags below, I changed the
>> variable name to fflags.
> 
> You are correct in that it is the actual fflags parameter but what it
> reflects is which files will be created. I do not find that using "files"
> makes the code unreadable. 

Everything helps. I changed it because I was already changing few things
in this function. That is not the only change in this function. Here is
the main change in this function.

-	files = RFTYPE_BASE | BIT(RF_CTRLSHIFT + rtype);
-	ret = rdtgroup_add_files(kn, files);
+	if (rtype == RDTCTRL_GROUP)
+		fflags = RFTYPE_BASE | RFTYPE_CTRL;
+	else
+		fflags = RFTYPE_BASE | RFTYPE_MON;
+
+	ret = rdtgroup_add_files(kn, fflags);

In my opinion this is more clearer. Also I can delete some of these
un-necessary definitions below.

 #define RFTYPE_INFO			BIT(0)
 #define RFTYPE_BASE			BIT(1)
-#define RF_CTRLSHIFT			4
-#define RF_MONSHIFT			5
-#define RF_TOPSHIFT			6
-#define RFTYPE_CTRL			BIT(RF_CTRLSHIFT)
-#define RFTYPE_MON			BIT(RF_MONSHIFT)
-#define RFTYPE_TOP			BIT(RF_TOPSHIFT)
+#define RFTYPE_CTRL			BIT(4)
+#define RFTYPE_MON			BIT(5)
+#define RFTYPE_TOP			BIT(6)

Thanks
Babu
