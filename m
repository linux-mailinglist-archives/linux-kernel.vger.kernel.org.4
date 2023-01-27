Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C632867EFF6
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 21:51:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230237AbjA0Uvm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 15:51:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229991AbjA0Uvj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 15:51:39 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2045.outbound.protection.outlook.com [40.107.244.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 739FE1E2A2
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 12:51:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WxRRTZB45rcZnpZaseyl8hSG5tz3uUDgWoUeVz79aE05SUk/a18w+KUdnEkVtoHTjCK/g/BwHXH/XYYQNShQgYeDJKpzPOa2TaZNaGkLgWXuqZh083dORKNbeEwFpty7R/YzVwBZZB1apRCbBP6ex5cPlBzyTHh3OGILIzJG/Q4kfSbGzFHxlYfouiyqHT1j2TPLcL2J4g3rqWBkrH8SBV9GUd/h2y7JmpZ4d48X5eqTG7jd9IpPFY8yvlOUHKSSBfusgOi+O+HACIvVI3F/wDU8sp+GYjoeKDupOcYyHhecQ5am1pLGQfDBV0ttIEwtIpG4C+np7W4LtCaMHHFklg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/g08Ka1T8trooExdDvFLyyYRF2uLo8e+Dwp4t/0l3HE=;
 b=e/JyKlVuxNrO0KMNw2g81tH5hus+sXaiPpq3c0erwnD+UknC0GMj2ylRDB8vDm16SI6No4fZ2e848s0xgyOhOydHqra0FsG4Qd7SMeMjBTHBkEQGy37naZL1VGWi+seLwMqOp+ahozo9mvMzh6m1m3/FC0b4BBrYq6AIiwIjQJhQkw1SWI/ScAPTp/vys1pONaJTbkDwGmoKlb3lhcH9LJ29h2p6C7x/v5NzNL8Olx7M6deFJRmzfMhIBOL/AWGoE8Igv6YvutbJ4sBILtw2twBeIK3zODykoJUssF6AhPxEuFDTB7P58C1BJNhxcDZQiqFejYkRb5xg7FYyeeqwsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/g08Ka1T8trooExdDvFLyyYRF2uLo8e+Dwp4t/0l3HE=;
 b=toCkGo2vdadpBm0iQFaaRAKhg42sbOtOhW4w0q8hAB+1o2b6w1z3mQF4zQMDrzbiIqCXtIffAj+XO53qrIoAiE30No0wlVF9NL3zVkmsKfI3C8y3JLpv/cOqCbzHIHPTljjqqbAWow6tkhQONKBF2ibuulrNFLEf7CoXj3SBIYk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5874.namprd12.prod.outlook.com (2603:10b6:208:396::17)
 by SJ1PR12MB6337.namprd12.prod.outlook.com (2603:10b6:a03:456::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.23; Fri, 27 Jan
 2023 20:51:36 +0000
Received: from BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::f29:b74e:c400:b24]) by BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::f29:b74e:c400:b24%6]) with mapi id 15.20.6043.022; Fri, 27 Jan 2023
 20:51:35 +0000
Message-ID: <3850d949-3ae2-e446-de1e-24cf3ba4417d@amd.com>
Date:   Fri, 27 Jan 2023 14:51:31 -0600
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: Linux guest kernel threat model for Confidential Computing
To:     "Reshetova, Elena" <elena.reshetova@intel.com>,
        "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Shishkin, Alexander" <alexander.shishkin@intel.com>,
        "Shutemov, Kirill" <kirill.shutemov@intel.com>,
        "Kuppuswamy, Sathyanarayanan" <sathyanarayanan.kuppuswamy@intel.com>,
        "Kleen, Andi" <andi.kleen@intel.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "Wunner, Lukas" <lukas.wunner@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Jason Wang <jasowang@redhat.com>,
        "Poimboe, Josh" <jpoimboe@redhat.com>,
        "aarcange@redhat.com" <aarcange@redhat.com>,
        Cfir Cohen <cfir@google.com>, Marc Orr <marcorr@google.com>,
        "jbachmann@google.com" <jbachmann@google.com>,
        "pgonda@google.com" <pgonda@google.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        James Morris <jmorris@namei.org>,
        Michael Kelley <mikelley@microsoft.com>,
        "Lange, Jon" <jlange@microsoft.com>,
        "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>
References: <DM8PR11MB57505481B2FE79C3D56C9201E7CE9@DM8PR11MB5750.namprd11.prod.outlook.com>
 <Y9EkCvAfNXnJ+ATo@kroah.com>
 <DM8PR11MB5750FA4849C3224F597C101AE7CE9@DM8PR11MB5750.namprd11.prod.outlook.com>
 <20230126105618-mutt-send-email-mst@kernel.org>
 <DM8PR11MB5750678B5F639F6C2848FC3CE7CC9@DM8PR11MB5750.namprd11.prod.outlook.com>
 <20230127044508-mutt-send-email-mst@kernel.org>
 <DM8PR11MB57501BD39CC1E88206E6CD5FE7CC9@DM8PR11MB5750.namprd11.prod.outlook.com>
Content-Language: en-US
From:   Carlos Bilbao <carlos.bilbao@amd.com>
In-Reply-To: <DM8PR11MB57501BD39CC1E88206E6CD5FE7CC9@DM8PR11MB5750.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA9PR13CA0086.namprd13.prod.outlook.com
 (2603:10b6:806:23::31) To BL1PR12MB5874.namprd12.prod.outlook.com
 (2603:10b6:208:396::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5874:EE_|SJ1PR12MB6337:EE_
X-MS-Office365-Filtering-Correlation-Id: f835749d-2c9e-47d6-ad96-08db00a846d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K0YVaq+xgsMs39AwxKbxYmLZH9x/tZUMliJCOdYg3Kikc5ExmQpoi6b8uXXr1a0Xq0ti6XAbeSjpWruwsi2GQ1WtNtRcxPFICGbnKJE7Dsr3dDKpO788k5VNA3nGULQ55PNWz5xrFRlvp9g0hsgjgcip8iPbEzgqgZ61vbDCBwoeO3xaZS/HS+y6SSnCt5lQ256pxW+FcIm0GQ7HfCr7O4ZnfexJA5NxVr1D5rZYguCEG0DJ8TrtaWMuZOVxQpNmREDUHQOwcCFAgQWk0dlwc4bWy/wp3yGbx17H8o0qU4tjsKAV8uXlYsvpzTuWKC7fyQLV5r/9ywQtGXkbzdFgE3sYjXeTmqBVt3hxCdYN19pE6cMQjMXwlGEuRvxYQ4kDsFxol5ZsNvhFC6zL1em3zmBaq5VR55aDMfPbthQnKzxRIwhX50kum5plQ7EadWi4vcyUG/YmiMb+g1VDWz+JGBMjlwMeNLnGi2BfwtpNyW6SzADr1wtiSn6rscS8XpJjgklpidLcrhETq55DVBwX9JteqNNOh544ky1v9sG2OQgqV6/j4qaMS82kNusUBUKaXM622UaaaTb8nXzUt+KiyMz3vrSnXZVJ0rUk2vnocqsJCqIO0TRefLt4OpK3/gAQGCKtNre5FO+gzMkM4UxpaPZMEbdrPK4DvYTEFUvpI7mw3Zd9NgUxkrmQaatYUvOkesXd7ba0g5cR8kUj0fS/QZhhFTpAIndsOZzm+T4MQDU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5874.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(396003)(366004)(39860400002)(136003)(346002)(34036004)(451199018)(53546011)(44832011)(7416002)(38100700002)(2906002)(6506007)(186003)(5660300002)(8936002)(6512007)(31686004)(110136005)(54906003)(6666004)(41320700001)(36756003)(41300700001)(2616005)(66946007)(4326008)(66556008)(66476007)(83380400001)(8676002)(86362001)(316002)(31696002)(6486002)(508600001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dFZqSjlYcUkzZDdSTHVxTmx4T1oxQXZpcjU3RmdoQU5qZmw1OUVMVDY0R1l3?=
 =?utf-8?B?SjVzQXduRCtKYWhOU0FQeXRENVNOV0JwUVUwOGVDeG91eHlHSWluYVdCekRN?=
 =?utf-8?B?STV2MUFrWi9LNVc3UmsyeGJYRTY1bkdRN1lYR0sxaU5jSDBFV1FHM0gxUDk0?=
 =?utf-8?B?K29WcVU5UTNVNW5GUzFvbk5udmwrVFpHcmg3NUZta1hZSVIrLzVkTUtHMHQ4?=
 =?utf-8?B?Q0c4d3J3UVNaMWI1SFFGZHZBT1VUczlqUDVvR1dGZllPelRLNWxHM1dYMDZE?=
 =?utf-8?B?VWNCRkMwVVpxYkdYTk5NNjZUeDZUQTNBNEFyQ1FRWnpIQVMxbWExS0h6dGta?=
 =?utf-8?B?Z2tFd21EYlZrdy9HOUZmcmEyeEpZVVpFM0lGLy84WVJBTHFuSzAvL3JSc2RY?=
 =?utf-8?B?dVJRbzVMVG1EYjNLMnFhbElSWFFhcGRpNnplK3FiUjEwdUxtSTdNb0tBOU8z?=
 =?utf-8?B?R3pQYmtCK21mdDRYa1hydVJtTXlFQldUSGVtRkNUVWppM0ptajhMZEttSDNa?=
 =?utf-8?B?WUlnVHc2VkQyZUdlRE1wSTFjdnBuZFVjOVg1Z1lQMWV0ancrUnNQQ3BMT3pD?=
 =?utf-8?B?VlA5QURUT3RBQ1phdDVwdlh0UXN6ZUEwclJoM3lkMkp1MzhMNEFWN3BRd1Q3?=
 =?utf-8?B?S2xSZ1IxTHg4a2syeDN5RHBLNlNuNkdqMjFkVTVLeVdkbXdsTkFkclIzNFJq?=
 =?utf-8?B?VkhrMFJXb1JHb3dMNFcrWERWb05uNG9VazYyNWFuWnlHQVcvOXpFTzZabm1n?=
 =?utf-8?B?T1o3L3BYTmhvMVdic2h2MTRQVTdLT3NXWjFmdmIxd21STXBiK3loT1NjaTNV?=
 =?utf-8?B?SmU2VUZBb20yeHpGZUMvSTFuMHlqWHZGN3Q0SXE3d0hBTUkzRU5TMG84VFlI?=
 =?utf-8?B?alc3SGxkMmhaRkJsODFUUytpTUNzdEc0TkRlMm9wMzR1RnQrWE9GZnZLSTZu?=
 =?utf-8?B?cURrQkFPeVlKY1R0aXduRU5sWm9aRkh1WCswRWlldU1Dc2EyUWtWVEluQjZa?=
 =?utf-8?B?ZXlIejNLNzFFN3JPM3p2Q201S2RwUGcxWTBSQ0V1WGU3S1FtZVJMc1lFdEcx?=
 =?utf-8?B?STdOYUpQdUlpdCs2aEZLM2Y3dGR1MUVqY2gycTQ1QnNYSFBXRzVFQUZYR3lG?=
 =?utf-8?B?K3VCSjA2a2p3Q0VCd0Q1eUVaRW9HSTFyblBRQU9ENGlqTWxlZFFzakI2eEI0?=
 =?utf-8?B?bkZxLzNveUgyRjhzTFVBNEpacmtQTFlyOGVOYk9Wb3RqSDNETEpaSzczTnFp?=
 =?utf-8?B?SlA2c0NwM0luRVdCZWw0eXBzM0k3VXQ0b0p5dFhFTXVGQUtIVUZONGFXa1d1?=
 =?utf-8?B?RjIrYUJYcGo2ZFRoSHlEdHZWTmlQS1NZQjV5eTFEQ1NKNzQxQiszaHQzVXNy?=
 =?utf-8?B?c0Q1QzFlLzlCU0FsN045Z2NoQUp5RjA4dlhaLzg3b3Jvc0tFTUxZQmFvL3ZR?=
 =?utf-8?B?K2Z0WkFkbklCaFBtOWlDYURTLzF0Y0R5YS9BRm0zaVJLY2FBMkFBRUlQNEhl?=
 =?utf-8?B?RU0yaG5iTVViRi92MFlDRmN3NmxIbno1SjNoRWJJYWQ0V0wwZ2JIa1dMZFNY?=
 =?utf-8?B?RzBTbE01MGhVeW85Um1ZdlFzaEFGaFVDMGpyakRGYWhSUUlYMmlRYzJMbyt1?=
 =?utf-8?B?MmtJaVFDMDVPRmxzNUZySGZMUlNoNTdQb3JyU2ViQXJEWmtud1NnS0NhNUIv?=
 =?utf-8?B?dWdqR1lSZXZpZTgyNE9NUTd3Y2JySWlVQ2xrYXFRU3kxSmY3ODJhcmp3aWU4?=
 =?utf-8?B?WVVnR2hJaGFjbjBLZGVZd0lIQXd4N2VZYnRvUHBrMUIrdnhYanZSVnQwTWRY?=
 =?utf-8?B?THVRWGF0M3MwUjZIb0krbDF6U2JaWVZzRGZhS3NBb1VydTNUQVRFNFBBU2xr?=
 =?utf-8?B?OW80dlEzVXo2c3ZIaTdEWU1DT3lUbC9Ma2laZkxiM3hxdjhGaUtRYjBheVRX?=
 =?utf-8?B?Qmp3ZHhJSUcvWkx4T2hNc3BnOG1XRVY1aEQ4cTJWVUlvL0F4S1cwNk14cXp6?=
 =?utf-8?B?VmFvS1JXOXAwVDU3WHBDeE0vdGNOTTFmTEZ6VHRURUtQQ00vanRtQkU1WTEr?=
 =?utf-8?B?YkJEczNGQjNMK3VCTEVRR0pFKzJDYmRLNE1NMk5zOGVSRExOeXNITFdKUENF?=
 =?utf-8?B?b2xYUkpRK3RZbm5rdVBIT1RTOE1LNDhBNkZhTFEvWWJVTzg4VnZVNVpIYzJQ?=
 =?utf-8?Q?IWx9ll/1dyOpZFWFvsYpyxAnrb7F9xhGrzio3XzygbTe?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f835749d-2c9e-47d6-ad96-08db00a846d3
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5874.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2023 20:51:34.8964
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Apr+w8m8joBfFjm0m9rX41OOTsb8MRr2GQRbBrN5EtO/tiRRDBJYtfM5GQClIcifbTGtOzJkUY979cza8uZr2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6337
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/27/23 6:25 AM, Reshetova, Elena wrote:
> 
>> On Fri, Jan 27, 2023 at 08:52:22AM +0000, Reshetova, Elena wrote:
>>>> On Wed, Jan 25, 2023 at 03:29:07PM +0000, Reshetova, Elena wrote:
>>>>> And this is a very special aspect of 'hardening' since it is about hardening a
>>>> kernel
>>>>> under different threat model/assumptions.
>>>>
>>>> I am not sure it's that special in that hardening IMHO is not a specific
>>>> threat model or a set of assumptions. IIUC it's just something that
>>>> helps reduce severity of vulnerabilities.  Similarly, one can use the CC
>>>> hardware in a variety of ways I guess. And one way is just that -
>>>> hardening linux such that ability to corrupt guest memory does not
>>>> automatically escalate into guest code execution.
>>>
>>> I am not sure if I fully follow you on this. I do agree that it is in principle
>>> the same 'hardening' that we have been doing in Linux for decades just
>>> applied to a new attack surface, host <-> guest, vs userspace <->kernel.
>>
>> Sorry about being unclear this is not the type of hardening I meant
>> really.  The "hardening" you meant is preventing kernel vulnerabilities,
>> right? This is what we've been doing for decades.
>> But I meant slightly newer things like e.g. KASLR or indeed ASLR generally -
>> we are trying to reduce a chance a vulnerability causes random
>> code execution as opposed to a DOS. To think in these terms you do not
>> need to think about attack surfaces - in the system including
>> a hypervisor, guest supervisor and guest userspace hiding
>> one component from others is helpful even if they share
>> a privelege level.
> 
> Do you mean that the fact that CoCo guest has memory encrypted
> can help even in non-CoCo scenarios? I am sorry, I still seem not to be able
> to grasp your idea fully. When the privilege level is shared, there is no
> incentive to perform privilege escalation attacks across components,
> so why hide them from each other? Data protection? But I don’t think you
> are talking about this? I do agree that KASLR is stronger when you remove
> the possibility to read the memory (make sure kernel code is execute only)
> you are trying to attack, but again not sure if you mean this. 
> 
>>
>>
>>
>>> Interfaces have changed, but the types of vulnerabilities, etc are the same.
>>> The attacker model is somewhat different because we have
>>> different expectations on what host/hypervisor should be able to do
>>> to the guest (following business reasons and use-cases), versus what we
>>> expect normal userspace being able to "do" towards kernel. The host and
>>> hypervisor still has a lot of control over the guest (ability to start/stop it,
>>> manage its resources, etc). But the reasons behind this doesn’t come
>>> from the fact that security CoCo HW not being able to support this stricter
>>> security model (it cannot now indeed, but this is a design decision), but
>>> from the fact that it is important for Cloud service providers to retain that
>>> level of control over their infrastructure.
>>
>> Surely they need ability to control resource usage, not ability to execute DOS
>> attacks. Current hardware just does not have ability to allow the former
>> without the later.
> 
> I don’t see why it cannot be added to HW if requirement comes. However, I think 
> in cloud provider world being able to control resources equals to being able
> to deny these resources when required, so being able to denial of service its clients
> is kind of build-in expectation that everyone just agrees on.  
> 

Just a thought, but I wouldn't discard availability guarantees like that
at some point. As a client I would certainly like it, and if it's good
for business...

>>
>>>>
>>>> If you put it this way, you get to participate in a well understood
>>>> problem space instead of constantly saying "yes but CC is special".  And
>>>> further, you will now talk about features as opposed to fixing bugs.
>>>> Which will stop annoying people who currently seem annoyed by the
>>>> implication that their code is buggy simply because it does not cache in
>>>> memory all data read from hardware. Finally, you then don't really need
>>>> to explain why e.g. DoS is not a problem but info leak is a problem - when
>>>> for many users it's actually the reverse - the reason is not that it's
>>>> not part of a threat model - which then makes you work hard to define
>>>> the threat model - but simply that CC hardware does not support this
>>>> kind of hardening.
>>>
>>> But this won't be correct statement, because it is not limitation of HW, but the
>>> threat and business model that Confidential Computing exists in. I am not
>>> aware of a single cloud provider who would be willing to use the HW that
>>> takes the full control of their infrastructure and running confidential guests,
>>> leaving them with no mechanisms to control the load balancing, enforce
>>> resource usage, etc. So, given that nobody needs/willing to use such HW,
>>> such HW simply doesn’t exist.
>>>
>>> So, I would still say that the model we operate in CoCo usecases is somewhat
>>> special, but I do agree that given that we list a couple of these special
>> assumptions
>>> (over which ones we have no control or ability to influence, none of us are
>> business
>>> people), then the rest becomes just careful enumeration of attack surface
>> interfaces
>>> and break up of potential mitigations.
>>>
>>> Best Regards,
>>> Elena.
>>>
>>
>> I'd say each business has a slightly different business model, no?
>> Finding common ground is what helps us share code ...
> 
> Fully agree, and a good discussion with everyone willing to listen and cooperate
> can go a long way into defining the best implementation. 
> 
> Best Regards,
> Elena. 

Thanks for sharing the threat model with the list!

Carlos
