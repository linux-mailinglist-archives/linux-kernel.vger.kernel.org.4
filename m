Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 934FC721D2D
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 06:41:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232813AbjFEEln (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 00:41:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232762AbjFEEli (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 00:41:38 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E16DCD;
        Sun,  4 Jun 2023 21:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685940097; x=1717476097;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Hrv0AfJHCYnsrjqpcldPJJnyCRPlsL+C6JumEcUlImY=;
  b=jM52gJS26+dEqol03GssbkVwFRpnKr7hUpgg/qABrx8NtSFxQG7ziTxy
   l3bYHSxoaEosZyDdeDTHHJ+WDko7gcGNnztSDGtILbEeHjWkh7P87sNqU
   k2rz5MMCwVqZaFYNmTaDQIxthp9PL/eAvns4+d7d4SZhbUBOzl0NMbCJI
   EXHqQoRpgd1Vu6rNO4hrMF6lQxyTbURZ99b5XF76UBUtT3PO3K//ASe6g
   +0W/4jaNySxrRtfPFy9QeGlVXacStP8qUMC+J0k+SV3O99Ly4AQFBD5Uj
   OnyYRM9gu49zrMQbq4ZfvUa665ULqIorgH0HWHGo8KsaPdK9ZuXO5rPFn
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10731"; a="384578248"
X-IronPort-AV: E=Sophos;i="6.00,217,1681196400"; 
   d="scan'208";a="384578248"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2023 21:41:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10731"; a="711665423"
X-IronPort-AV: E=Sophos;i="6.00,217,1681196400"; 
   d="scan'208";a="711665423"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga007.fm.intel.com with ESMTP; 04 Jun 2023 21:41:35 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Sun, 4 Jun 2023 21:41:35 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Sun, 4 Jun 2023 21:41:35 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Sun, 4 Jun 2023 21:41:35 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.175)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Sun, 4 Jun 2023 21:41:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hUB0H8ZDppVeYC5H0ZCfa1/McMY+ZgOBwfmdz75b9lDsqafZONH+BlXQIGwUVo+/iJG+F/MEiXpXIt853o9j1yufnk60DfBfMVEkgLdwOj8CDMRdqpGJiR+Wzp1JjCgocCW78+t/IvhWqGx2fsPxx+hXvBtg7ey1BCZwkq6ce4GCa6dYzyNQ18Z4VaG/LO5olw9u4DkHFZJJWvJCy7G6u5PauWXakfAEWw4PyApdChD/jeeHNUrQ5tTGizYr2q5MjfZ8g776q6yj7Y4ryYCBsJMjDGKOhvjwCMin4/Oju35vGISg6OS5rauX8Lmv0bGqbc2YSKEVwo9ULmp6z4qTjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gDzN/SWgmlMfmmatQ8XnhLkvFBihY3kE9RfOTLh2SdU=;
 b=C2J+WLyO/wywXHRo/5fIs9i+b81G0qPC44PM3LJ/Ni3BF0xMOEfUer/jWqBXXPdEZYyWuI6uLBScZdlkkGG8xnY+y8Ej0nQ00EL1+x37f2tAtb8PoqN7NN878f4ovbuubhQhdLk7UiXxa/pd7Zin0iRfJpuwXriIv3roSjIWdoDXh7oGsFuoJYXaFb87+qxRwSPuVf6QW8EtPGz24j/TzNyB0yKTTBpGjyw7/FYhXhSTUo2OcJoPodnv3+XDgdvUPS5F+L2SD18xztZr7xD5O9k2UD93lb+dFjHmpO4EvViG2tjOfTX2+ZomZdp71gCZBLIaOJtMFXn+JQv3ZNsiCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB4855.namprd11.prod.outlook.com (2603:10b6:510:41::12)
 by CY8PR11MB7731.namprd11.prod.outlook.com (2603:10b6:930:75::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Mon, 5 Jun
 2023 04:41:28 +0000
Received: from PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::a41b:1b6c:8306:7644]) by PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::a41b:1b6c:8306:7644%6]) with mapi id 15.20.6455.030; Mon, 5 Jun 2023
 04:41:27 +0000
Message-ID: <f1093780-cdda-35ec-3ef1-e5fab4139bef@intel.com>
Date:   Sun, 4 Jun 2023 21:41:25 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v8 10/12] crypto: x86/aesni - Use the proper data type in
 struct aesni_xts_ctx
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
References: <20230524165717.14062-1-chang.seok.bae@intel.com>
 <20230603152227.12335-1-chang.seok.bae@intel.com>
 <20230603152227.12335-11-chang.seok.bae@intel.com>
 <20230604153434.GA1212@quark.localdomain>
 <0925dd9e-3588-38da-8dfb-0ac2ff568655@intel.com>
 <20230605024623.GA4653@quark.localdomain>
Content-Language: en-US
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
In-Reply-To: <20230605024623.GA4653@quark.localdomain>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR17CA0027.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::40) To PH0PR11MB4855.namprd11.prod.outlook.com
 (2603:10b6:510:41::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB4855:EE_|CY8PR11MB7731:EE_
X-MS-Office365-Filtering-Correlation-Id: b7071bed-3015-48af-8b51-08db657f1fe3
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Lp5gunYTerocIdJTvTnjHIUEPsL6s0dpmCq11AG2HlQbqcjffncEVqf2lNiACDbuLJa3vEs+o2xGxc0/MY+nqbcR9IokQ3mQIpdZHqe5mhnqe0cN6YUqQMbKRXOR6waI7Io2yqGkWNjr7Mu7ef2K7ITaU8GzDbphKGznVVnZBL75YZBez9zvV9rVIOhGcGsdL1kGZ86bXLpY9Cd2DailrED/MOpMUQkCsq6KRhp4XE1xHw1W7kS2p+1WLM79f6tXl9J4otYYv1+dfZBo8q5pUwAz8VFghGkGrR4/ep17S4hxedERTDQsjzRqa9J4fyNrSM/cClIdbzm5fzEoVclxpRD0p4qsbTER54ezJn+/acmUSnPPCZAyQe6Fu8zwc9CWtJqkZLPUwT8r96gV2+rVHEZzkK9becXjBCzzZpscqTnU6wOvaUJWAE8I1vjkPuKkMGOU3rH1ifwJfNWR0altwFT76hMAdEcwvwmh2yo+vz8+SniEd24BUer+j29eAww5NL75CpB2n/I3/afN8A8Dt5lIAf3HIxus3uG2x0Wb+jXjDV5ld/atYos223w9N9+ezqV7yU1j2TjMmbQluWnIy/Q3khXts5lZsaDlh9rMWFPvaAZHTHQ3FasJ/biODDNsiZmoXUZ0ya3j/GQt8gKuJw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4855.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(346002)(136003)(376002)(396003)(39860400002)(451199021)(8936002)(8676002)(478600001)(54906003)(41300700001)(5660300002)(316002)(6486002)(26005)(7416002)(186003)(31686004)(4326008)(66556008)(66946007)(66476007)(6916009)(6512007)(53546011)(6506007)(2616005)(2906002)(4744005)(38100700002)(82960400001)(31696002)(86362001)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OXNwQmI2eHorVnM4NlhDenNkVExxYkVSK3ZMVEtXS0VFSS8wMEtyMk5ndDJO?=
 =?utf-8?B?UnJXaUdFSTBJL2greFFzdkwwV2ttWWh6QjNodHZvRk91UkRIZEVGbU9paXZO?=
 =?utf-8?B?VmJlYXlHemRaRUhWSXZBSGt0VlVOTmc3L1dqeGk5QTZRUS9hNE8zN0tDWXhT?=
 =?utf-8?B?eUNrSytDcDNGcWg4c3hneEtGa0pWUCtZZ2ZKV0FkMVZJU2NOajhzbXRBVnNW?=
 =?utf-8?B?dkpvRE8rUDNUYXhPYi8wZDNDa0lxR2YycWRjL3JZeW4vWkhlVFI1SFdXQ0pT?=
 =?utf-8?B?ZmVhOVVsUEpjZHlDdytGYlpUSEZtak9KcWtsSk5PamVjc0Z2a0UrdVpDRXJz?=
 =?utf-8?B?UDdlWUdkM090aE1LOGxnUnM4eWw1akFGOE1SRXkvM0ZxZ2N3S0FjSW5VaGFs?=
 =?utf-8?B?VlhzWUhka3oxL3FUOFdZK21USjlvVHA5L0twOTBLWW9BMlpBeXFIeUNiYzEy?=
 =?utf-8?B?UG9ra2NGa211UEU0azl3ZlQ4NUVqcklVVnV1YUE0QVFwVzZmYS91L1c1L1N2?=
 =?utf-8?B?Q0M0TWZ1U3piUEd0Z3lKelZsSWluYmpuQnVjVzJaSWp6cnZ1Q0plSG9kMTNi?=
 =?utf-8?B?YTAvZlBsOFZiZ1E0ZDBTZ1VrY1dFcFpINjVsRWcxRDR3RVFpcHoxdFZGTmk5?=
 =?utf-8?B?SXFNYjNLUkRzYlZuQVNnK3hnaWRCNWt3NkUzY3F4R1REMFNpWHJpNTJvWExF?=
 =?utf-8?B?RDVNYm5CbEwwbTRjSUtvWEtId2Fma2hjWnY5aXNvQVVnZ0RrZEFZd080U1Ez?=
 =?utf-8?B?dzFkaTRaTTNlQ1VTd2s3QUFVcmdtVlFIWStYNDhZMWVMRHFZdjV4SjJBc3pp?=
 =?utf-8?B?eFZQc1JtZnRvZjZKeitIelkwMjBvdUlKK05JTzBaRUhVQzNvN3YrRVV1c01w?=
 =?utf-8?B?ZW0vU1FJelBTbXgrZmM4RVQzRU9ucVQ0d1cxakhXRXVjakloRTRvakFnNVhM?=
 =?utf-8?B?SDY5MGVLaTRTQ3Q2cmVXanAxZ2hEcmYvL1dOV0paYXlIajJRM2VHbHBQdmhB?=
 =?utf-8?B?anpUR2hTMnNrKzdhdVRzRFhEaUFqZ1lGdjdaOUpLd2xobkJVNGhhalhTTGUz?=
 =?utf-8?B?UFJhdDNidWl4U0JjeUVGMm52Y2ZhOTlhZnU4VkVmOGtyTEora3A4R29HdHpw?=
 =?utf-8?B?NFBVWmxKandENGgvWlhBeHl6U0lKL2twZm9LekJXL3ZYOHdrblp1ZkFFMWRO?=
 =?utf-8?B?MjlpQjFOdURZZ0E1RWdlckI4bFc5aUQvbHdFWTZhbXVOQkdydFFQYmk4VUF3?=
 =?utf-8?B?dmNzdFUwaHJNWXlpVURmS3AvRDRYZGw0UEUvbXIvSm9waFRNK1VJUnZOaStB?=
 =?utf-8?B?djZFTitiMGRYbzRSeTdyaFVFbngzeWQ5dENWTStGTEltdzYwZ01jZklOTUM2?=
 =?utf-8?B?bDFlUTVERlpsVXpSVVNrYUZsWHJnOXg1dWlXWXZKa01EY2NPTjZrOTduTmR3?=
 =?utf-8?B?SlhyTzB0Z2k3alR4d0l3UFZsczU3YkNZT053Um0wSml2UXptd1ltMlY0TFVk?=
 =?utf-8?B?RmpjVDY4SHQvQWp2WGNsWlFtVC9GSC91NzNoUWFra20rYnJKSGhFRnlDeEpZ?=
 =?utf-8?B?cmlpanRuYW5Tc0hOZDdSSGcwMitMeTJuNzBzRTAzVFpVcitoNU9PbzZyTXdN?=
 =?utf-8?B?UlBEY1AwdWFTMDNxYmxmRHlQeHdhRTJjSngrK3RsS0pmSnlqaWRkYmxocHVr?=
 =?utf-8?B?MDdVai9SVm1Jb3ptdWYrMFBzZWo2ZXlIZEJhMTJ3dmgvQ3AzeCt5bEdHS1A0?=
 =?utf-8?B?cTFSSUxDeXBMMkovZzBENXdXUE5rLzQ2R2RPd1RIOTFFQlFUM0lhTEY1TEZ4?=
 =?utf-8?B?eGRTVGZoUmd2RWdma3BVZmtlTzhxMWNGS2phRk5QWnhvZXk2WnVITEJoT3VN?=
 =?utf-8?B?RnVOTGpLNllqK0d2ZG1JMjJ1U1hxQURaN0hVV0l5djA5bDZubWI4UXBuZmF2?=
 =?utf-8?B?U3VjSnB3eUwwSG5WZlJDbERwMFcrNDhaK0NTeTkxczAzU2IxMjRMYlJnbUFk?=
 =?utf-8?B?S2dIMXNhMHpEZk03ZGhmNWhLbW5uWENCVTZzSjNLVURUS21mdVpMN1NxVXhP?=
 =?utf-8?B?bjJLc25XTVhlSU5Bb2pybzdLRDdpd28wVVQ2bnpQdHlodTRMTjZJZW1hdm43?=
 =?utf-8?B?NDQyNVRrYkRNdjVOK0NqQ3NzU0RCK0RsQXNwL2VOeU4rVnBpUTM3WDNpQ1lX?=
 =?utf-8?B?MEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b7071bed-3015-48af-8b51-08db657f1fe3
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4855.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2023 04:41:27.7072
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VOwrTsNyYStPKItGk08MSpF5TMHgSGSbWn1cO7UEdPEGJXButayGnEslWuxJrAB1ZZhvnr+hoh7LS/1WCDomgzRxK+2n0VcEBMxIegqZyG8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7731
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/4/2023 7:46 PM, Eric Biggers wrote:
> 
> IMO the issue is that your patch makes the code (including the XTS code)
> inconsistent because it makes it use a mix of both approaches: it aligns each
> field individually, *and* it aligns the ctx up-front. 

But, the code did this already:

common_rfc4106_set_key()
-> aesni_rfc4106_gcm_ctx_get(aead) 	// align ->ctx
-> aes_set_key_common()
    -> aes_ctx()				// here, this aligns again

And generic_gcmaes_set_key() as well.

Hmm, maybe a separate patch can spell out this issue more clearly for 
the record, no?

Thanks,
Chang
