Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74F5A716F0E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 22:50:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229596AbjE3UuJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 16:50:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230194AbjE3UuG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 16:50:06 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0F63EC;
        Tue, 30 May 2023 13:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685479805; x=1717015805;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=xcyvYJUjpmINCo/sug0Y6oFgqoSyrKMcssFOt7KJJo4=;
  b=EsSIytyvgX0qJI5Xc7dId/G58o8DjzMsRSIHbRL3Pd/nBuo5sKrcYGXD
   L9RW5oQWqWNJCHA9eUXejF11P4XgmBLzyrmbt9CyfuDU/NIuPtqjrlAp2
   ecZ6o6qRsiI2MVuiptapoJnJG5DYZlbzjTi4/KVrc+7x2gc4T+PYeyLg3
   JmFH1k+SHouwWo7F8NbukBZK6I1Jb/7mmFIhoMZR8VcGgABMJOj0Famca
   XN75m+e/WCksy2jaTgp7lkj/CWt+eACTHfJ5lfC1lOeC4g3lJde+nw+dg
   PLbZogH5gN9w0nWH76yQY3V24cVZghqPFVBLfifCImtm6lpNviAzyz0BX
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10726"; a="353886394"
X-IronPort-AV: E=Sophos;i="6.00,205,1681196400"; 
   d="scan'208";a="353886394"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2023 13:50:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10726"; a="796420262"
X-IronPort-AV: E=Sophos;i="6.00,205,1681196400"; 
   d="scan'208";a="796420262"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by FMSMGA003.fm.intel.com with ESMTP; 30 May 2023 13:50:03 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 30 May 2023 13:50:02 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 30 May 2023 13:50:02 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Tue, 30 May 2023 13:50:02 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.106)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Tue, 30 May 2023 13:50:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MhdpHW74VhUkJjUythCheMNc2KeHwNJeYtaZuublXWsQGQAHH6cCkeKT//MvUz01NtCwd8i5wyKxA70QmjUo8/vltRKYxgzpOcXnTZdNwi74rbr8caT9mOqfym33ZwXJTWbmoIkRcC+9MDSBBHF7zw7IdvvaTtElAtIAol1YWWfmZuxNSd6r7s6II1iDZWVXYs+5XJU7PobYG8t5/gg+C2+/OgNmUh8T1kdgV6iX1FG00TlyLN29wLqekpqN7TAabw3DZPSXwbxnadOX3vN0CRkeLur5c4BIIT4yDPmXw/ITCw5xkHukKUQpFrZC4Wqhyug3HY9EC0mWXP+uFx7qAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bKhcfyQpXf4A6yXXJIy71ko9URRJM9soMSQgQqgMiwE=;
 b=evuI6HhbKw3wdovW7dW1H6JSJRnjLBIz4P6JktYZvOv5KK6XTURY9Z7fxOU2ZHbZz+ig0gQWJldxAp7gFk76QFIFhbRKqGFsXAQ66CzqO0NZAoi0JqV10qeF4T2f8G0/JUdYN09q7ihRKvtFej0V1YfsTb+eVjL6p8Gih1/Z1RXttR9ET7VzbnB0mPow1iLlMRQnOdAI0bKuSV0iZ24Fxc3numGVoLuDut5XrvdMZUShG9ut8nnShXF+sDdTdcsLrBxM8Qgn7MaSQrcByDb8NY7NPzqE/qDWPRdQjpQebP6/ys3vJ4K+GSOdccnfk4WSPZFN6vbDvxnRnsJ0sbKYfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB4855.namprd11.prod.outlook.com (2603:10b6:510:41::12)
 by PH0PR11MB7168.namprd11.prod.outlook.com (2603:10b6:510:1e9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Tue, 30 May
 2023 20:49:59 +0000
Received: from PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::bad1:92a2:fa0a:1850]) by PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::bad1:92a2:fa0a:1850%7]) with mapi id 15.20.6433.022; Tue, 30 May 2023
 20:49:59 +0000
Message-ID: <7a45b479-4732-21d8-8fff-64142f86cab0@intel.com>
Date:   Tue, 30 May 2023 13:49:56 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v7 12/12] crypto: x86/aes-kl - Implement the AES-XTS
 algorithm
Content-Language: en-US
To:     Eric Biggers <ebiggers@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
        <dm-devel@redhat.com>, <elliott@hpe.com>, <gmazyland@gmail.com>,
        <luto@kernel.org>, <dave.hansen@linux.intel.com>,
        <tglx@linutronix.de>, <bp@alien8.de>, <mingo@kernel.org>,
        <x86@kernel.org>, <herbert@gondor.apana.org.au>, <ardb@kernel.org>,
        <dan.j.williams@intel.com>, <bernie.keany@intel.com>,
        <charishma1.gairuboyina@intel.com>,
        <lalithambika.krishnakumar@intel.com>, <nhuck@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>
References: <20230410225936.8940-1-chang.seok.bae@intel.com>
 <20230524165717.14062-1-chang.seok.bae@intel.com>
 <20230524165717.14062-13-chang.seok.bae@intel.com>
 <20230526072301.GC875@sol.localdomain>
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
In-Reply-To: <20230526072301.GC875@sol.localdomain>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR07CA0074.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::15) To PH0PR11MB4855.namprd11.prod.outlook.com
 (2603:10b6:510:41::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB4855:EE_|PH0PR11MB7168:EE_
X-MS-Office365-Filtering-Correlation-Id: e87eb511-c255-4d96-169b-08db614f6eab
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YZmAjQW7ayQ+GoceZdU5CcKiK7ge0GXvHilQ/G3HqGMSphe3qNqer00kdAS1xbVKe886c/C4qc23phJiaOOuD5fBv7KF2B/FXltH16eRtTpqcr5s8MGWwzxLZTETtnLFakPqatzkEitzfbcsBRkZTAiCByUQ11H7SNBSTeyagoazaxxQOtBQF3sh40OGdiYrlWXpctCT6nj4U61ItlZv5dOgWZ7jAgnStv6U1H0iU7eXBeJsQFgNIZkqRXk7HV4iyH+NAuK6fa3GBfBuh4DNkdWm1fFLh/qyXZSnb3k0E6u+bH1Xbw1DGnQFVNCMmitEzJbLekpLGvRiDn4BBo6pn42FdtDjUj5lH7azpSJcTos8m8CP55/nP+sIBW1fNwtLqF2ooZUR4KdTLCVNqxU5TCXfG3NDHWhrNKuLM+62lfdyLnU1/rNT1GhFQAyBury6kseAXdFxi3Pqs8I7pSTZPFAW0J1NIiD99ZEWWPlpXSxzegyqjPsWb6EtM6+1kTc2TPz6A0bo/Kxtd10ZUZOhw+KAn7CW64hyMitelA0gpN88AAY+VBmnr6vl36vEoFB7Zm7x50B/Gjikx6lD3YXzY5VprdjY4qPf5XpHaCSOX9LaciQNlEFpHoL3jwiek48c0DzQBD9Jn2O2p6+lOf/Zew==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4855.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(346002)(396003)(366004)(376002)(136003)(451199021)(6486002)(41300700001)(86362001)(6916009)(6666004)(316002)(4326008)(31696002)(966005)(66556008)(66476007)(66946007)(36756003)(2906002)(186003)(2616005)(6512007)(5660300002)(82960400001)(54906003)(8936002)(83380400001)(6506007)(8676002)(53546011)(31686004)(7416002)(26005)(478600001)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NVozek51bFpJUkpGb2R1cnJqQlgyQUloN1JMUjBKUVBNQ29pZ1NOQ28xeG5s?=
 =?utf-8?B?dWllTFo5Q3JNanByelpuMGdIdUdyd3BOa3orKzUwb0VvRW9vTUUyajhQVkNl?=
 =?utf-8?B?Qjc1ekZSbno2L3NlU2FEeng4cWZsMkdzb0I1dDNCMy9iclJGOVlseTh5VE1Z?=
 =?utf-8?B?TU8yOFoxbnZpNkhPTnBCNU01U0Y3Ui9hNGtxZks5TTZNdHpxNzFSN1BMWmti?=
 =?utf-8?B?cXlnL3BEK3ovYUJFUGdDNnZ1d3B3SGNualNoVXpqdlBPWGw1TUNZUXZpenl3?=
 =?utf-8?B?WGhxSFFBeVN3SUppSVlSRXQwaW9UUFQ1ZlZPOThZTVZKV1VvY0hvaXd6QXRn?=
 =?utf-8?B?enU4Mk81Vi9QQzNSandpM1NXaE1rOHlkQStiVmFqTWFWWXBuYVM2dXVtK1Jl?=
 =?utf-8?B?QkR0TVpPNFk3aXlTQjQ1SGRlVGN6ZlloTllvUlZVem80K1hoY3Q4UWJaYzZE?=
 =?utf-8?B?eUcyelAydUM2RDI0SEJwcmdUUVZidURBV1VJR3EzYXhDSHYxay9WZ0RXeUtH?=
 =?utf-8?B?OXRSTllkUVFRV2t3WWt3NVoxZDdDYlF3c2hJMHYrOTBsVXVNZFZQQXorRVh5?=
 =?utf-8?B?L1R2NFpTTUErNW9rZjFRaFRWcE53aGJ3dU5pUlFWelpYMXZrMCtwcEFrMlFs?=
 =?utf-8?B?RTU5L0UwWVVPWi9hNXQzNWptbWF0UlFkUERBNUhyVkJKYWJ1K05qeVY0VFdp?=
 =?utf-8?B?c1RRd1dCNWk3RVFCemg1endLbCtHQncwVzArV2laWlArOVJsVXN3QXJCUmhE?=
 =?utf-8?B?RThKWkJBMVkwS0ZOcXlDbDY1Sno2ZG8wVlBCR2xlRUxTRGtoUlA5SkVrcksv?=
 =?utf-8?B?K3FZeE81SnRRTkp4WW45K0FBbXRHMFRVUFA5dENlZUcwMm80V3M1YTdybDJD?=
 =?utf-8?B?ZVA1dm5vL0plQThvUnhabTdFL0I1ZGdlQVh3WHdtaVV1K2lIY3dEK0RCanBy?=
 =?utf-8?B?TXpZckZaUVZUL1p3amt6NjhhbFpXR0lwZnRmVUkwakZ6MjB3SERjVEpRMGhG?=
 =?utf-8?B?cnpJZ2txcUNSa2dCajlOcjFaSnFUTytXMnYxUDVUWVpBcnRNQytlT3RWVDE3?=
 =?utf-8?B?S1JmMlJnRmRWVXpSazNCeTFZU1dxbHNxdkdqTEdINjlMZTUrSDZJYUkvZ0cy?=
 =?utf-8?B?Nm5IWnFrOEg4OURPczRBQTdpd3JzTkN1WitSSEJkYWtzZG55M1Bza20zTDFE?=
 =?utf-8?B?TTN2dDY3YzYxQU9oRXhjM0x0MElSVW4vazVGREhoNXBYakRLU2tFTFZtOFV6?=
 =?utf-8?B?emhQMmlEdlplaG5VR1hNZFNCdXREV2tMb0RHY3RQbXJia0UxeTdCZHIzTFRv?=
 =?utf-8?B?cWd6SDVpTUdPZ3Vod2d1Z3ZmejM4MGc2TUp0cFNvV3ZMb3FiaDByeElJYjMy?=
 =?utf-8?B?Mm4yVTFja1VWODBkdm9UUHR1S1VLZG80cXI1akN4eS9FSEt0RU5ob2ptYWhG?=
 =?utf-8?B?eUtvOGlERDV5NU9GSElzM2dTdjJZMmkxUFZHeDcxdHNPSGdKVGI1UzJUYnJU?=
 =?utf-8?B?UzFTSDVCMGJqNFkyaHVkSTdmckNheEtoSGx2N051R2duanNIU1gzZExGY1JH?=
 =?utf-8?B?WnBhblQrcE5HWWZPV2g4VnY4SVFHTnAzRkVybldoZlBoVTFtR0g2elBmWno3?=
 =?utf-8?B?azdQbnVOQnJYdnYxMmI4Y214TWQrSFRxWUJOSU1wVU10VFhHbVBZbGFIYnd4?=
 =?utf-8?B?eG9sWWlQYTVyckVpSGg5WXBSb1ltWTFBN3J0SUZBbkY5ZVBxU0RGRi9jMVpv?=
 =?utf-8?B?bjd5czJ1Q2dCZDVDWnNCRlNGdm5MaU9RektZdFZacmFvWnRaSkRzVjR1dTRm?=
 =?utf-8?B?R3h2alFlNnIvT2YvWjhLNWczUnVtb25EQWhRRWpFelhtbVFYeEJrT1hMaGtZ?=
 =?utf-8?B?SGRmNGI4blNQRGV1S25RQ2REZllFVHFkRksyRFk1dENNVE1WWWNHZ1JpbmNF?=
 =?utf-8?B?cUE0dmtSQlQrcnZJeGIvSkp0a3NQRkJaYjM3ZlZtb0ZvT1NEa1hvcjEvU29R?=
 =?utf-8?B?S2hOUTYyL3c4OEpzVVpOR0JZZThINGRnd0xaV2VHekFJc2dyRnVaNFV0ampi?=
 =?utf-8?B?TkR1RHJmcmd0NXdhcWgvMXg4WHZvdmcvcWN2UlprRUYxeGh1a0xjQnNLVEFj?=
 =?utf-8?B?THBhWG9hNlIyeFRwS05NbEMxT01rUnBBZHBjQm9UcEx1Sk9GV3JVWFpvMHlZ?=
 =?utf-8?B?RVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e87eb511-c255-4d96-169b-08db614f6eab
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4855.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2023 20:49:59.2894
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hb79g3OYYAkwD8qTsgSfOwMXTK7R2pgwN8GgcZT0AIExFH5RA+A41q5O7Ho6vpYAnnjSsmokze7m5HG5Jb1nYhSCIielTpOTpiPu8rD1SkQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7168
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/26/2023 12:23 AM, Eric Biggers wrote:
> On Wed, May 24, 2023 at 09:57:17AM -0700, Chang S. Bae wrote:
>> == API Limitation ==
>>
>> The setkey() function transforms an AES key into a handle. But, an
>> extended key is a usual outcome of setkey() in other AES cipher
>> implementations. For this reason, a setkey() failure does not fall
>> back to the other. So, expose AES-KL methods via synchronous
>> interfaces only.
> 
> I don't understand what this paragraph is trying to say.

This text comes with this particular comment as I look back:

 > This basically implies that we cannot expose the cipher interface at
 > all, and so AES-KL can only be used by callers that use the
 > asynchronous interface, which rules out 802.11, s/w kTLS, macsec and
 > kerberos.

https://lore.kernel.org/lkml/CAMj1kXGa4f21eH0mdxd1pQsZMUjUr1Btq+Dgw-gC=O-yYft7xw@mail.gmail.com/

Then, I realize that at that moment the dm-crypt use model was not 
clearly out yet.

This seems to be carried over the versions. But, now, it has XTS only. 
Then, this becomes less relevant which makes confusion I guess.

I think this can go away as claiming the usage clearly now.

> 
>> +/*
>> + * The below wrappers for the encryption/decryption functions
>> + * incorporate the feature availability check:
>> + *
>> + * In the rare event of hardware failure, the wrapping key can be lost
>> + * after wake-up from a deep sleep state. Then, this check helps to
>> + * avoid any subsequent misuse with populating a proper error code.
>> + */
>> +
>> +static inline int aeskl_enc(const void *ctx, u8 *out, const u8 *in)
>> +{
>> +	if (!valid_keylocker())
>> +		return -ENODEV;
>> +
>> +	return __aeskl_enc(ctx, out, in);
>> +}
> 
> Is it not sufficient for the valid_keylocker() check to occur at the top level
> (in xts_encrypt() and xts_decrypt()), which would seem to be a better place to
> do it?  Is this because valid_keylocker() needs to be checked in every
> kernel_fpu_begin() section separately, to avoid a race condition?  If that's
> indeed the reason, can you explain that in the comment?

Maybe something like this:

/*
  * In the event of hardware failure, the wrapping key can be lost
  * from a sleep state. Then, the feature is not usable anymore. This
  * feature state can be found via valid_keylocker().
  *
  * Such disabling could be anywhere preemptible, outside
  * kernel_fpu_begin()/end(). So, to avoid the race condition, check
  * the feature availability on every use in the below wrappers.
  */

> 
>> +static inline int xts_keylen(struct skcipher_request *req, u32 *keylen)
>> +{
>> +	struct aes_xts_ctx *ctx = aes_xts_ctx(crypto_skcipher_reqtfm(req));
>> +
>> +	if (ctx->crypt_ctx.key_length != ctx->tweak_ctx.key_length)
>> +		return -EINVAL;
>> +
>> +	*keylen = ctx->crypt_ctx.key_length;
>> +	return 0;
>> +}
> 
> This is odd.  Why would the key lengths be different here?

I thought it was logical to do such sanity check. But, in practice, they 
are the same.

Looks like this entire crypto code is treated as performance-critical or so.

> 
>> +	err = simd_register_skciphers_compat(aeskl_skciphers, ARRAY_SIZE(aeskl_skciphers),
>> +					     aeskl_simd_skciphers);
>> +	if (err)
>> +		return err;
>> +
>> +	return 0;
> 
> This can be simplified to:
> 
> 	return simd_register_skciphers_compat(aeskl_skciphers,
> 					      ARRAY_SIZE(aeskl_skciphers),
> 					      aeskl_simd_skciphers);

Oh, obviously!

Thanks,
Chang

