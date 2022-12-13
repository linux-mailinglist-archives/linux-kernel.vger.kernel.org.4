Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAA9A64B05C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 08:23:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234655AbiLMHXm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 02:23:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233998AbiLMHXh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 02:23:37 -0500
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2051.outbound.protection.outlook.com [40.107.22.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BF44DB4
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 23:23:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=McrD9DuznWtHEF2mpqRtiLhSU7s7Dj9eTiu1zTzqJJ5Dafcdddh+RuMeQ3Wjhs9v9E7JnjwpWY8yu1JjlTOxYKzq/N6pfLoOhU5ZDvGNnSB1iEwVFBENdpx5hqjRgNEU/QR6HCqla/FOKpyJv8gDis8lJOJZdEsdfiYrU400om7iN5+QGX9nGB7SqKgSiybEHissQre2Vj/8WHXGL6WRxs78DiR03czozXlEuP6yCrmlYvigmWYjBriENTivVT0EXJf0g8ZMy3OQ/zm5F2LtF1bEkXq/TcXDf7pgqcAAXrWM3FASuLxF/dE/P3ddEReVCi+l15EdDDfPsqWWajrEzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z2CwDtY0amO889UVeAN/5ezcpX9vWKAy1hKH5LfCURQ=;
 b=jtUepVVC06GmnBo/lcUOxO+RRLJJZQYNo12UKwJ6d3qdC4h9xYrRViD3ASe0qrdiaUiEi9hSGUGKTiYzg00oTasjvMEd4XfS5s9zDzd87NpyJDC0i3VCWtfE9ECzLaFM8nIRl+vpRbaAHUBDcIPB0e0HzKA5nQssC8plRe3xze0UC8L7FeJiqLFpke5b9T/fJIyf+H0fyMZSYXkFLjmVLTkt4+UIaSVDoLeq4lCnHTdIg/foDiHgmNuSRJCcRz5hq3HwsP5ZV/pJTioJPpG5eTTaLqyrN7zYBsYmo8p+shtd0EXAPUreBGmUJdupGybZw07TkFH1AU44ltZ2o6w7Kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z2CwDtY0amO889UVeAN/5ezcpX9vWKAy1hKH5LfCURQ=;
 b=zQW1dpwdAcGBzoUP/AmgyRVDgqWeY6d6SxsfnJ7YlpEKkloc6i6mgJVRxFJdQyNUWEid4pwcXOnVMebG2BQHm/GtALRtV+6kmf6hmvKDJ1pEcjGpj6GZ95ism95HqfCqcBV8M9xXyQGKjnO9AmCX2cT0O8MS2CYud8HoCSh+bpQ0NLPgvXVqUo4t5ILR25RdlyFy25FwRsZ1l/UOXUVtE9Dz6R3KiKLhuPqHes06enR2GBpplP+li/weI/9uV8WPoen3KDFHIXnZFnEZRHZ1ciUbhPPlj37GU8d3hwckwnDai34S3pEPq3exDyHgoJbqKhkeLr3c9y6J29mLHgMvZQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VE1PR04MB6560.eurprd04.prod.outlook.com (2603:10a6:803:122::25)
 by PAXPR04MB8944.eurprd04.prod.outlook.com (2603:10a6:102:20f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.10; Tue, 13 Dec
 2022 07:23:31 +0000
Received: from VE1PR04MB6560.eurprd04.prod.outlook.com
 ([fe80::4da2:ea8b:e71e:b8d8]) by VE1PR04MB6560.eurprd04.prod.outlook.com
 ([fe80::4da2:ea8b:e71e:b8d8%4]) with mapi id 15.20.5880.019; Tue, 13 Dec 2022
 07:23:31 +0000
Message-ID: <60582b25-4fb9-a2c8-9db3-9b5593f039c1@suse.com>
Date:   Tue, 13 Dec 2022 08:23:29 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH linux-next v2] x86/xen/time: prefer tsc as clocksource
 when it is invariant
Content-Language: en-US
To:     Krister Johansen <kjlx@templeofstupid.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, xen-devel@lists.xenproject.org,
        linux-kernel@vger.kernel.org,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Anthony Liguori <aliguori@amazon.com>,
        David Reaver <me@davidreaver.com>,
        Brendan Gregg <brendan@intel.com>,
        Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>
References: <20221208163650.GA3225@templeofstupid.com>
 <1e6c1b08-d573-fba9-61fd-d40a74427d46@oracle.com>
 <20221212155730.GA1973@templeofstupid.com>
 <20221212160524.GB1973@templeofstupid.com>
 <1eb6048b-bf23-78a0-9c3c-54bbd12c3864@suse.com>
 <20221212220519.GA1935@templeofstupid.com>
From:   Jan Beulich <jbeulich@suse.com>
In-Reply-To: <20221212220519.GA1935@templeofstupid.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0020.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1c::21) To VE1PR04MB6560.eurprd04.prod.outlook.com
 (2603:10a6:803:122::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR04MB6560:EE_|PAXPR04MB8944:EE_
X-MS-Office365-Filtering-Correlation-Id: 7aad693a-c009-45b5-4faa-08dadcdaefe5
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OG+pOAjuN9r+s18O8Zu5nPys2ph1lY0QEqi7S3FrO8JtSPi5Svf8OfMuPQCqc1FHFAhYWgI9LxWZ80+ZMTABz0yybgcFFK14Zs3WVTPziN41PihcO0O0Nh0bySiQtB9YW66sDSI+jITvuTtc87cTGguE7Duu0RCTOcSoCLqaUadMawCgFtDKqUNmmf+gUIYZKUjhQvCV3B0vg0SMBFPSwOkCYUMUGcUy5HSiSYahEq2dNiTffMi61W8S81WSVN0ANCkLRgakEhlK2ev8/lwkHoABAORsB46um8TXVSlIAb5agpkXjsSm7l/ugwK40MRNOY8AptAdReBbRyUmYZgXMjc3IbQJU46Gg1EdpYIBecXpoFJfANxyr4Zkci7D2eAzW6sl1ekbJ1xoav74aXrW8igiy2qG3lLZLE2SZvYIczr0ayIYf0zERDO0WeHMBd/1XI5RqQDmgEvRM/8kZzeQjILboek8o01efAM5Qi1vLz+55A3jRXeuh9nCIGOVsPZMPdsPVEhB7jeZb+3FZQ6fOojXy2nmR53FKfdLvwMSKOJjZVFqZcN2EivJ5FfKLpu9QgVcwAzfwUyS3/eq/jDzqRnbi0Jyq5n92aW7qFCqm6Bek9UTECYfKhzZ3HZTodT69MKUqcKtgJscM1nCh0wwykuNmux6jmYF7ZfubvaT1hRky3W6fvWEv/edKJeV43bAlvB0ADZOCKqb205T8Ko22OCVA50sYPNzvc32hRB/+uM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6560.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(396003)(376002)(39860400002)(346002)(366004)(451199015)(36756003)(31696002)(86362001)(26005)(316002)(54906003)(6916009)(478600001)(2616005)(6486002)(8676002)(66946007)(66476007)(2906002)(7416002)(5660300002)(4326008)(41300700001)(66556008)(83380400001)(8936002)(38100700002)(6512007)(53546011)(6506007)(186003)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SWZTc1lEbXREeXlhV01vQVRHdCtDQjFQdTF4TDFmT0ZoYWZWOVN2R0xEQjFY?=
 =?utf-8?B?M21jT3ZZMVlNaCtHa1NSbUhBbGNsUWsrL1FHZGZ2clVNODV2OU01THc4N3hs?=
 =?utf-8?B?WnE4WWRnRTlOK2E3d1BUNmtnSW1PTVBGb1RTWnR5Y1VSUzlFUmNrbFJ2TER0?=
 =?utf-8?B?QVVoTCtlUzBaYlhOaWVvdFFMZ0FnQUdNZnpnVWpnVEJYdnJvOEpScy9udGdQ?=
 =?utf-8?B?ZElRak5xRWNVOWZZZ3Aydmdqd2VNMGpjMGthVEZaRzRaYXRxbTkvQ2VEREJ5?=
 =?utf-8?B?NVd3bjFDWC9qVG04T0VTNmV5d1c2bmxnUmo1dVUzYnA1YkhiaFRKd3cwVVor?=
 =?utf-8?B?anUrQXBVUk8rK01Md0xsVjZzeG5Cb3lFQXhVZXREY0FwY0xNd3UrZGtwbW5z?=
 =?utf-8?B?MFo4WVFJOHlBbVdLd1J3dGI2VlR2SWk1QW5jOHlWMzhBTEFvS0ZDYytUV1lZ?=
 =?utf-8?B?WEQ0UUJWeDIrekVMYjlnTWtnRVhMdVAxM1NSaEZEMUp3ZlNZMGhTU3d2RnVH?=
 =?utf-8?B?Zzh1RkozQmlhTmF2NmpxMEZKVFNiTXZubiszamhOV3lGMVlTVzdjNUtTZkxC?=
 =?utf-8?B?elZDRmgyQlFFSnRhTFVydGZ0QlUrUmdTTkFCZVNGT0QwdUhubmpUYmVKRUJh?=
 =?utf-8?B?eWlabW93eit1M2M4NVZBdGRGMkV5NDFxNzdvSm5VclBiS3R1Sm9rT055ZmVt?=
 =?utf-8?B?S2tWV0EyajRSVVFiYmN4eWNnZlk3VGplYzZzRnl0ZXNwUlNNejZLRXBCbDQy?=
 =?utf-8?B?T2VmbXBVWGRCaEpwSFUvcVFxK3lxNEpzTnU1NlNrWmx2a3dtTFN0VGVkMi9n?=
 =?utf-8?B?ckhONWFsUzBrTHI4QjhnNjVXU1lzeGRXRGgzTWJXUG5DdWkrS3BWL3hOMXY2?=
 =?utf-8?B?dklMYjJRT05scGExNktnRGxVcjkrNE1zT3NmUTd1UksxNlI3M2VRY2cwMGRr?=
 =?utf-8?B?V3htbGV2V1J3Vml6dDJaS2NvSHc0Yk1ra1RPTHRvcDNFS1psTGtlb0tYdi9C?=
 =?utf-8?B?ZEYxTllERkQySzUrUkt5aEV1V1lPYW5EM3JES3FNWlZjRGVlL2kzblJWTnB1?=
 =?utf-8?B?TmEybVZDSWNORisrWW5aVXc3S1h6RWpCeHNxNllkcnRTWTRwUDlWNGViN3R6?=
 =?utf-8?B?Y2FTc0lrcmNxRGFXM0pRNk56UzdRdHIvdHJEY1o4emZBUXcraXdMNUVBVnpl?=
 =?utf-8?B?NnVPZjQzTDJNaGE4TDg0Z1BQTDRlK1UzL3hLZkhxSld6T09JVHBPU0RmRE95?=
 =?utf-8?B?RUR3SkQ0MkpQa2x0UE5oR1BiM1JCb1FtTUtVbWwzOHFTVU5LaEtDZHR3MmN0?=
 =?utf-8?B?bUlEWEo2WHNlKzQyZHNmSzNBSEZTK2lmb0dYdlg3WmtITU1GS2tKYUhMT2hF?=
 =?utf-8?B?RnNRcFBtdlVEMzR5TGFGOHRQOVpBZnlzVGN6UllzVXBtWWxDblc0L2xmbWNj?=
 =?utf-8?B?bDRYcTZveXhCbW5UZ2NvMk04cjZwcjJnd1l4VldOMzZIZXNRenIzTU1EODBx?=
 =?utf-8?B?QkIvS1lqZTM0T1VPZDNtNExOeS9hdS8zb3pkQ3o2MlhFV3VJelFYczFrT3Q5?=
 =?utf-8?B?RzllZzJiaGJhSGlqOVVNMytYTHFFS092V0c2bUdYWFdxYXd2RXNVZHBLWnFX?=
 =?utf-8?B?amJreDc3Vk9uMVAvbXJKdGhSTmhaRmsybWxzMVBDNHlqMjg5S2JuSDRtQzNm?=
 =?utf-8?B?c1RVczhha3dBTGVHaWxTWDM0bUZGR0J4QUhlbnJPTXJpVDVJSjFHcWZibm8v?=
 =?utf-8?B?T0tOZFFtK2JBaWYzcmlLL1RlTi8xZllGc3V1N1Nud05SNVpkeDNUMWx6TXV6?=
 =?utf-8?B?OFRpZVN0QU1xQkZKSi93L3hnS3RybUxBUFFscENGdGxIbkV0RWNHWUhsdTkw?=
 =?utf-8?B?YmxIdWF0VDJQSzIxSERrZzdOYXZvUmdZcXBaN2lrbFphY0U3Mmg5YnA1bE5t?=
 =?utf-8?B?OGJZbVpqUWtDbngrUGhLQ0o4TWdFOVg5MVY5QVlwZUdqcGpqYllYejVQQWJm?=
 =?utf-8?B?a1cxRzI2SGRpeEVEdFRGdkU3Njc3Zk9XRzRjN2ZZdys3T2RtSlQyaFhJcUNF?=
 =?utf-8?B?YW1MMHV5NnljRmF5c2w3M2QrWGZNM3VMcllsdWh5VFlHOEZVNlNEZ3ljeTMz?=
 =?utf-8?Q?lHmrrPYY0grcsBVnJXGc5tWwk?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7aad693a-c009-45b5-4faa-08dadcdaefe5
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6560.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2022 07:23:31.3047
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d7lfGjAoXqfCpbLGUEfqXvOry6DCsvKv2o4N2EsnJrR8ncrLUwAj6ZX2z5lFPKGVJUv7KLWZB/1YP2oYeHMk4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8944
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12.12.2022 23:05, Krister Johansen wrote:
> On Mon, Dec 12, 2022 at 05:46:29PM +0100, Jan Beulich wrote:
>> On 12.12.2022 17:05, Krister Johansen wrote:
>>> Both the Intel SDM[4] and the Xen tsc documentation explain that marking
>>> a tsc as invariant means that it should be considered stable by the OS
>>> and is elibile to be used as a wall clock source.  The Xen documentation
>>> further clarifies that this is only reliable on HVM and PVH because PV
>>> cannot intercept a cpuid instruction.
>>
>> Without meaning to express a view on the argumentation as a whole, this
>> PV aspect is suspicious. Unless you open-code a use of the CPUID insn
>> in the kernel, all uses of CPUID are going to be processed by Xen by
>> virtue of the respective pvops hook. Documentation says what it says
>> for environments where this might not be the case.
> 
> Thanks, appreciate the clarification here. Just restating this for my
> own understanding: your advice would be to drop this check below?

No, I'm unconvinced of if/where this transformation is really appropriate.
My comment was merely to indicate that the justification for ...

>>> +	if (!(xen_hvm_domain() || xen_pvh_domain()))
>>> +		return 0;

... this isn't really correct.

> And then update the commit message to dispense with the distinction
> between HVM, PV, and PVH?
> 
>>> +	cpuid(xen_cpuid_base() + 3, &eax, &ebx, &ecx, &edx);
>>
>> Xen leaf 3 has sub-leaves, so I think you need to set ecx to zero before
>> this call.
> 
> The cpuid() inline in arch/x86/include/asm/processor.h assigns zero to
> ecx prior to calling __cpuid.  In arch/x86/boot/cpuflags.c the macros
> are a little different, but it looks like there too, the macro passes 0
> as an input argument to cpuid_count which ends up being %ecx.  Happy to
> fix this up if I'm looking at the wrong cpuid functions, though.

Oh, I didn't expect cpuid() to be more than a trivial wrapper around the
the pvops hook, and I merely looked at native_cpuid() and xen_cpuid().
I'm sorry for the noise then. Yet still, with there being sub-leaves, I'd
recommend switching to cpuid_count() just for clarity.

Jan
