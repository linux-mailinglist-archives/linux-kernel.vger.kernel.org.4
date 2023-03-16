Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E5776BCDC1
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 12:15:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230244AbjCPLPR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 07:15:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230242AbjCPLPP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 07:15:15 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2046.outbound.protection.outlook.com [40.107.6.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57186B8541;
        Thu, 16 Mar 2023 04:15:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KfVDLA2PT+J0b2dCPu04rLc+UFY+VRsbUfwbbdhoemy9+35ZpUem3bACIQYn6wtLQWxrZd35DSBubLKfCLer+BkbCpiVRM3ZTbZgqTKnKZ+rAoDCOJze/kL0KOKQc8iL2D7oZ0Zh3j1QCW+YlvKPlAprBNpcW1NWW6XRpVQeobMb6viZ89s1myUOPQX6McPoE4cVZZXOXTKzw50W8aChAbllQfAmy7u0/wnlQstrldo7q+kv0z8kE3PCUTpTiSXUiFQ/QABjnqb47neizL6yeqX8k7pW3u7zknzWOt/mW8qBij6uwb1L1tS5TNkHc26m1WWG0mGH6KHBi3u/9s0tzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gWQuCSOqv/yYN+qmb4yfaY/Qpev2g4VbIfywb8iehhI=;
 b=F7018GhLJvaUzidvMPj5oCU3HW9RJjqRSZSYO5O6dlp/Pi1Giwaiif8BKkwcDAFq/2ELPZ8wt8Xnz4ZkK41KuwgbdturVQRUlNolrAo3nqg9pRFgm9x1ougxpwUk8/nAPWKA15p2OxHyPS/leuQSedn4PUvT1e1sVwWkz5ufStbLWawMwGsx0DvSIEaOVXn4f13Ku0oTnao9oG7A9JVu9HWwSX+Tvh0OY2AYNjCqGdqF5ucaxkujjMePP9P80ibEBZYijhlx7Q8cLJAsvt6x3giZEzyjTTSQcYgLrQuCgW1NHfq+yyhlGvh4/LIFSLUCS9oR1VPkN1iqJPxPGldYtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gWQuCSOqv/yYN+qmb4yfaY/Qpev2g4VbIfywb8iehhI=;
 b=ra/mSCiPq8z7cbilAV7Ou1Oju4OR1WW9jq/vNy1vnE4MuS23aDtFireukDanC62irIsv1ol5O7peuW2wA5Iwg2xitn5xWKQx8rEYtbA/eX72JEBcOEyjvbnpKaivkQ6jnPB+iUvFPE68tyWBqgbvz3wM5NsWje9+K821rOloGt4t7iOqc/H99PxhiKT9jofw31GTRK368GW91i370ppJpell3xLk5BCTpF/696W+6h6EtwwEmJyHarYbsiuhu+/f1b7ZYCa8d6aF7G1IiBMgtQSu6KMTVYHMhL1ntsmEt4G/Vcjp2jN3ftPoyBMuv1tQpqWGvtpcMz8LR43kofL0Tg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VE1PR04MB6560.eurprd04.prod.outlook.com (2603:10a6:803:122::25)
 by DB9PR04MB9647.eurprd04.prod.outlook.com (2603:10a6:10:30b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.24; Thu, 16 Mar
 2023 11:15:10 +0000
Received: from VE1PR04MB6560.eurprd04.prod.outlook.com
 ([fe80::154e:166d:ec25:531b]) by VE1PR04MB6560.eurprd04.prod.outlook.com
 ([fe80::154e:166d:ec25:531b%5]) with mapi id 15.20.6178.026; Thu, 16 Mar 2023
 11:15:10 +0000
Message-ID: <68195c77-e645-ebd5-3067-489536e7ace9@suse.com>
Date:   Thu, 16 Mar 2023 12:15:08 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v3] acpi/processor: fix evaluating _PDC method when
 running as Xen dom0
Content-Language: en-US
To:     =?UTF-8?Q?Roger_Pau_Monn=c3=a9?= <roger.pau@citrix.com>
Cc:     xen-devel@lists.xenproject.org, josef@oderland.se,
        Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>,
        Alex Chiang <achiang@hp.com>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230316103236.37102-1-roger.pau@citrix.com>
 <ba2d10ed-a1c0-2f35-3ffc-13637c83ed93@suse.com>
 <ZBL2yosC4LWGdjsn@Air-de-Roger>
From:   Jan Beulich <jbeulich@suse.com>
In-Reply-To: <ZBL2yosC4LWGdjsn@Air-de-Roger>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0002.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1d::12) To VE1PR04MB6560.eurprd04.prod.outlook.com
 (2603:10a6:803:122::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR04MB6560:EE_|DB9PR04MB9647:EE_
X-MS-Office365-Filtering-Correlation-Id: 4219c0c8-6f23-4cac-9907-08db260fb4d7
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ULYjAXJSJ3WYqQc+xt5g4g3ndpI0gSsCHwA3ZRVLeY99ioKNSsuwqY3iQdbyyHpPN75f9XhEzjkwuLyZU2xRKh7C7XhLdcKuk8tyjB9baVgJ+yQPnTTWO6gICbzaIcSmmUYh1KI7w20kowf0wVCe+9XGmS+Fqr6WQKN9Q6ExGSmVolwKX3rU6lJ4RGeZYnfKmudREsIx+41PW77xzsVyxYL5DkkCj8iN6kDHDybYXDRbRGFIOlrKRgcz5Jg/WXWmbcafWDhz7geLcCCaD2zsuliw5YrcI7JrzvzmDd6E4ZYQb6jvrHoWyGkrRslAXof2/W1P1sKRV6niQ2fAiC4veB83faxCQlIuDHdjs0z7lGf8Df1c1nMJiTdtS+wbThaM8no3yZhrrBF1aTgAJUolKFq3MalmSau7xuDEz1MO+r7Qnm3fixm19aJ+jyH7EmySN6/aS0c7+2xYTtJQ6moxcKRZwfN0uivKnhXTWF9/8UB/WKcF4qdsvkFV8EsSuQuGZH6tAIRgaPimLpwcsl8drcJcYy5JtX+R9Fk4l67/FUebfUyFNIB76V2yPYc3fI07mAd4vJd7Eag3tADJ+njQz1UjFDjHpiuZ3+8EUIG6THKhvlCQMFlqFgKGxDBW+dIegCDKthRI/L6OjgGJf55btpMiluBvsTPS5VajFz8VwWjDbO2sRdd/ZHeXRbHtk7vewiOs8DwJvHd82zeAQCq+ya+o6mf2ZUEYRLdH20iCi2E=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6560.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(366004)(39860400002)(376002)(396003)(136003)(451199018)(5660300002)(7416002)(66946007)(36756003)(26005)(2616005)(6506007)(66476007)(478600001)(186003)(6486002)(6512007)(53546011)(8676002)(54906003)(6916009)(4326008)(31696002)(66556008)(86362001)(38100700002)(316002)(8936002)(2906002)(31686004)(41300700001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UjZla2cxTGR6Qzl3UGlzWUtCcjZ0R09uejliOVB6aUozQWdvU2pVcVZoMjJN?=
 =?utf-8?B?S2o2djVxZXJQQ0VHUzl5QTBIUzBDRU1ncmU3Ky9vdVFXNzlCY3kxa1lkZldw?=
 =?utf-8?B?SzgzMWlNRjkzR0ZISXdxVXBBcnF6cm8xbnRlcFJMVXU1bWIrY2prVHlqVVFk?=
 =?utf-8?B?YmdkTG5ONVBzeFE4ZThwR2k1NUtwT1VFU2Zxa3RpMEljNmJzQkNDSU51eVgy?=
 =?utf-8?B?Q0RQZkMwUUdDdmNnaTV4cmtFZmZJc1ViQ3R2MkpIY3ZJR2RFSHo2S0JTY1N0?=
 =?utf-8?B?eE12UDBsczdzN0FMWHlVSVV0K3ZrRDhoUER2bTUzMzRXR2Y5OEU2WlhaN1NP?=
 =?utf-8?B?K2ZMZVNKOUNmMmx0WkdoaElLMG1LUVM0dUY1R3U2d0RPb0JvY291R1pGTk1n?=
 =?utf-8?B?WnVIOWt1cXRUTmlxa3NuY1o2ZmY3eFhkRXY5TzNobnlidHd0ajV5UTlZcC91?=
 =?utf-8?B?WURJc3BWUnpjL1dtby9iM0pYdDRnMHBIeVl0RHFDRHlmdWcxc0oybjc5WDVP?=
 =?utf-8?B?YmUvdUZqcGNBN3grN2JONlpWZCt6aDVCYkpRRm9rWjV6MUUzUmRNM0M0NzAw?=
 =?utf-8?B?Qnh0ZjZRM3J2NlBGb3cxK2ExaldzbzVJRU4rWGdSOG45SzNvNGVYWG82UWZy?=
 =?utf-8?B?N3hmVkYyRzhVK2NTcFVPZjM4cEpLUWdzN0ZjTEJ0dkdiR08yS1AvNFlJYU14?=
 =?utf-8?B?R3g0SjJWRXM2UGhrYVZ6YXFJblZXYjVWaXdJdm5rMDZCckN4VG9JUUlpWS9i?=
 =?utf-8?B?cXhOeHpFcVVKWFVKMEVjOHM5QVI5NWdYbW1rd2d2ZUQzdkVsK1VnUytHK3Z4?=
 =?utf-8?B?VWpVeWJsNHUxSUpXV3JWcHFKMzBoOC9aTkE2UlhZUDZYekNpcmpoaEg3TGY2?=
 =?utf-8?B?bExsaE50aFlqMkpwcnI5czlHZVp5aTY3alR6a0ZCbHVKSzZTTzQvcnNzWXJS?=
 =?utf-8?B?elpjQ2FGZlBpRitENkI3VjN5S2lUNFZrUFVIRHJpVWl0UWNVTWpWVnN5eWtB?=
 =?utf-8?B?Y05GRUhDcCt5Nlo5aWdsUm5VTzAzSWdDOGdGakdVc1FTRmwrWG5tbEJ0Y2NW?=
 =?utf-8?B?TDZFNWIxWTRxNE4yR1MyMWpBQXhYNHgwbFdLSmJOZGpBdzJmdmlvbThSc2Ez?=
 =?utf-8?B?WEZocTRIZHl4Mkh4b3p0NVRKdCtnNWorbVYxb1pmK3NCdFZLSlRsV1J6K3di?=
 =?utf-8?B?RGJsYXJTVFErNktDR0xVdmtxQ2QrNFcwd1ZXTGdMT291S0dyeWNmNzNremRM?=
 =?utf-8?B?UzVrQ0NLRmJVOE9jMk5KYUhMV1FTaGkzS0NzTjJaNzBhNnRTVXUxcDArdFM1?=
 =?utf-8?B?ZXhLcWJWWU5LbFpvMWNDNTlnNVp3ckZzR2dyd2VuOGxMMHlJMm04N1VuRVow?=
 =?utf-8?B?UnYyd0Rra0JsV2JYaFhqVEZwSVBUYjB5QUVhUTYzNFlMTjV3NmZ1T3Z0clVG?=
 =?utf-8?B?Y0lHdW5Vd2oxQ1Zvd0ZLV1Vsa3FPNXo3TGNlQ2cxTFM3dDh5QnZhQjlSUHU3?=
 =?utf-8?B?NlJIVEVyS0xuMDNhcnBWSVEwcHZ4eEM0OFh4U2dEQ3RyN0NPMFJHZVljNGJm?=
 =?utf-8?B?ekF6Y1dFOGZFajRjMnVIbzl5c1gzK1R2SUdYWCttN2Q0am5WKzZMVFFVNmhX?=
 =?utf-8?B?Wnh5OU5TeDB2dngxa3ViK3dNZENkU1BvbVgvZ0JXMTl3V3lQbkEyNlo3Nitv?=
 =?utf-8?B?WXRwYlZwZWVXTmppeGVERTZoUnRPR1J3Z1lRMXNxbU5Ub1M0ek9jTWpWUkFW?=
 =?utf-8?B?NnVodzhqTmpxcUphb1hQaXJVMXdLY2srVmRKVFVZRTV4dXNXOTEvbUtyejB0?=
 =?utf-8?B?azlBdGhhVm1tbmRZdWcvcTVGSEMzWGNxbzJmSWJXVWVzeEI3QmxpclU0UG9P?=
 =?utf-8?B?SVlIQjVjQzN3K3dJeVZCT0J2ekFqZXRYaXdDaVNFa1JMV1d2VitTQXlpM2RO?=
 =?utf-8?B?SU9ySk8rTEE2aWpaN2hYcy81aC9pMHZVQlVxU0pQTkRiOTlMKzJubjdjNnZO?=
 =?utf-8?B?MGVSUkU5TU1Fc25Ea1FmcldIV3lKUWFaT0dPcVArZEZVYnBVeFdVam9GbHJq?=
 =?utf-8?B?ODN1TUl5S3JKYUk4T2phVnZQbCt5Y0t3blprQXhza1JpMk5sb1VEZUErZUp4?=
 =?utf-8?Q?oF6UPQTe7ucXA4eF0pKZBRVMl?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4219c0c8-6f23-4cac-9907-08db260fb4d7
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6560.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2023 11:15:10.4856
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r+82hhagk+ckD05WsA0dX+tOomGlLfHpWVbbe5L6zgZDD1fdsPJsTtxxa/TYkwsnxvopsvUyseMyZ//9adDuEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9647
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16.03.2023 12:00, Roger Pau Monné wrote:
> On Thu, Mar 16, 2023 at 11:45:47AM +0100, Jan Beulich wrote:
>> On 16.03.2023 11:32, Roger Pau Monne wrote:
>>> --- a/arch/x86/include/asm/xen/hypervisor.h
>>> +++ b/arch/x86/include/asm/xen/hypervisor.h
>>> @@ -63,4 +63,14 @@ void __init xen_pvh_init(struct boot_params *boot_params);
>>>  void __init mem_map_via_hcall(struct boot_params *boot_params_p);
>>>  #endif
>>>  
>>> +#ifdef CONFIG_XEN_DOM0
>>
>> Shouldn't you also check CONFIG_X86 here, seeing the condition for when
>> pcpu.c would be built?
> 
> It's in a x86 specific header, so that's enough I think? (note the
> path of the header)

Oh, of course I should have paid attention - I'm sorry. (Then again it's
not really logical to live in an arch-dependent header, as the same would
be needed elsewhere with ACPI.)

>> Additionally CONFIG_ACPI may want checking, which
>> - taken together - would amount to checking CONFIG_XEN_ACPI. (For which
>> in turn I find odd that it will also be engaged when !DOM0.)
> 
> Hm, is it worth making the acpi_id field in struct pcpu or helper
> conditional to CONFIG_ACPI? It's just data fetched from Xen so it
> doesn't depend on any of the ACPI functionality in Linux.
> 
> IMO I don't think it's worth the extra ifdefs.

I didn't mean to suggest #ifdef for the new struct field. But the helper
is of no use without ACPI.

Jan
