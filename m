Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A8B65EBBD3
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 09:44:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229659AbiI0Hoj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 03:44:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230494AbiI0Hoa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 03:44:30 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80105.outbound.protection.outlook.com [40.107.8.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DCFA9DFB6;
        Tue, 27 Sep 2022 00:44:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=COt8PV7ILJaqDFx7S9l65QkTMSMS981LRopOomjDwMM+QHYEeevTSIuwPaO/Yoy/88z/ldmvZKp9aRyC0SNiLKHVnyEVH4G6P2x/3weQnuzFgOnpInq9nmSYi9B8glVSGm2JmEQ03R5DQmu90mNIFHxmgbdkte4QwxI/cDuCwUiNqUmzSv7acMTWtVtSoQsq3EMA1oO2sZH8sO+TN7cpJRev2KKP7aRD0rVPxrWR6dkPdxI1Ob4ON+H8uNA6twoimc+q0hkKhUUVDK5sSbhc0oF6/6qP9Rsg1hBNsfAaVbkwbZ6ZrZQ6XF33rJNWdI6bQKfi22B/J7F905UOx0Nv6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d/VW6mp4FHenPnSnA7N3xNXVleHRz2QoO+waueC8Q/o=;
 b=LiWHgj57F+BLTgOP1Y7ZSlrLILlWurm22+z9HvOpAwDzdBXlpclwgj0pYVzEYzz5gSh/sP47chIKy1RGmMBTNIz9yFf27o2+1Kc9u7+JAVcYVw/vyJAMuVqWC0YqlqN/dfTrQeaJJLqApYsWHttCaIfb2OlXl+HMH/ADovOGS17dsgKWCVm28C8nQLQPugGzTLNTsqDRmJ7yJ00cpSVmg00Jny0avuaTha5pVr+ghKCanGTeuJjH8dgPCvgj/3oa56OBprQceQauzYHSfDoLLDQlpTXFcNRbLllvLwNVsGj5q72owArECForgLyNIzGbgEHRZseqoTN3WbjEhfPN7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d/VW6mp4FHenPnSnA7N3xNXVleHRz2QoO+waueC8Q/o=;
 b=ZhrhLLDePfRneO6/9SPAz1ME+DZbVmnhjaXlFfFR6bAUezVzaiSCtO4jizV/hk5cfxrbCFegIzMtaulA4syd3hCXDn+iCZVbh6f5Bg9WnH3fs+gBHm2PXe41Hk9WsyNlfKbQDPnt/fK0aMBC0dINjDZB5Jn4iGTlezpPBdqvRZMR84eDedn5PDndYKI4S6D2LNtLbjfgFwpCreKA45gJR7jYckN2zuo8bhTCgfOBcocSdbPqG6SJQ4DNjXEybqjvmv+rKGJ2Yzt5g95PTXam2IzOl2tK18QwnJFatagB+1vKXuPVUbIbYVtGKuRnH1EgUJnhatvGoNtHhK4WfnmMYA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VE1PR08MB4765.eurprd08.prod.outlook.com (2603:10a6:802:a5::16)
 by AM9PR08MB6259.eurprd08.prod.outlook.com (2603:10a6:20b:2d8::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.26; Tue, 27 Sep
 2022 07:44:24 +0000
Received: from VE1PR08MB4765.eurprd08.prod.outlook.com
 ([fe80::2846:1df0:88bb:451f]) by VE1PR08MB4765.eurprd08.prod.outlook.com
 ([fe80::2846:1df0:88bb:451f%3]) with mapi id 15.20.5654.026; Tue, 27 Sep 2022
 07:44:24 +0000
Message-ID: <7640a2d9-a32d-2fd7-8f64-586edb9b781e@virtuozzo.com>
Date:   Tue, 27 Sep 2022 10:44:20 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.3.0
Subject: Re: [PATCH v2] mm: Make failslab writable again
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc:     Jonathan Corbet <corbet@lwn.net>, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>, kernel@openvz.org,
        Kees Cook <keescook@chromium.org>,
        Roman Gushchin <guro@fb.com>, Jann Horn <jannh@google.com>,
        Vijayanand Jitta <vjitta@codeaurora.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
References: <20220920121111.1792905-1-alexander.atanasov@virtuozzo.com>
 <Yyr1xONdw8dBgsKr@hyeyoo>
 <30063d97-69f0-bea2-9d59-108140995bfc@virtuozzo.com>
 <YzJIsFZQoCEYntvR@hyeyoo>
From:   Alexander Atanasov <alexander.atanasov@virtuozzo.com>
In-Reply-To: <YzJIsFZQoCEYntvR@hyeyoo>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR08CA0272.eurprd08.prod.outlook.com
 (2603:10a6:803:dc::45) To VE1PR08MB4765.eurprd08.prod.outlook.com
 (2603:10a6:802:a5::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR08MB4765:EE_|AM9PR08MB6259:EE_
X-MS-Office365-Filtering-Correlation-Id: 734f5144-f419-46fb-2f74-08daa05c1906
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JBqr4raNrr7sWaWwPrnuXyak2ZqcTZYRd1DQjxfE1gA8JIMAG25+ZU9aqhbzUjZ2ecyQg+5wx8qnviyj6Y5H3BWJ52+g8vAUBI3SkR+pdi+ueSJvgo29MiL30lmD1KhxVifAr20aoXRJBAwW5SAeXMbepp3GEj0V0NBE70TboWsMaFX3hsPWSc5ITSCAQCb5fMjSVgVx7BBiiNTnWyM3UIrQNLCRQDgsIfSKpFThncosII5HmYVVxD51nReT2ID+jQ+ystVPYhwIjxi8G2MYg57x0j28mSwo+JIJGrfnvJgZYKXd/t4yrXqDBIo1XV4C6zSNN0Bg86nTOyqHd+R5XqJzkC4Y6hhLxFXGSw7N9mggT+t48iW9/sR7WxpCND44sl/7D6Aeh2placJTROFiPN6kMdqQbeJgkYe8Lll64Cbyjk4baCpy+xOvCaRdZH5nYK62nQMFDby628yYs/exbOf1cN8keAQ5I50NuKztgZonjqbV0FZ8I66jVH7UBJFk3ypmadKht87HS9meG698oJITHnVRfPL1L4LcmYKo+YTaAo8kaRG+uKrQQmwhVMer0L1GVIpxhyOwMiVPrFzfnITmjirlQVID+XdUdSP31IYdRnXwOnDWcPwZ3+4CNpA963P4pW4mhT9095j9/qosT5jH/NT1dGAj9h+pf3c57uPWOt0PGP5DfmDif9Oip/CTwYY9F6TsXs/uJJ9km7VQGH9bgStb/4ngiIp6L1R2xsibWUQ8TqHFPRHVPnyXjtL2cYKQLbEna1PlXAgNKukrGA9BRSjxN6LttzyEJD4b/wuoIXh0u9gSRc78DgCa1Quv
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4765.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(136003)(346002)(366004)(376002)(39850400004)(451199015)(38350700002)(31696002)(38100700002)(86362001)(36756003)(31686004)(5660300002)(7416002)(186003)(6666004)(2906002)(44832011)(2616005)(478600001)(6506007)(53546011)(52116002)(6486002)(26005)(41300700001)(6512007)(83380400001)(54906003)(4326008)(6916009)(8676002)(316002)(66476007)(66946007)(8936002)(66556008)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QlZ5R2RGcWp5Z2xkWUxyR3NPT1A2bG1aSlY0SUlNc1JqUGxXNWR4U25nL2pX?=
 =?utf-8?B?RHMrS0dyQzV1a3E5TmhjU0Fod2x2M1BMSmtCU3ZvOGVkV2lLK1ZyNmFUWG90?=
 =?utf-8?B?OXpjNmRVcmJTV0hyUTk0M0dqZFBzRzVmUnhqN3Nuc1ErbHVDdlB6QWFNY2FF?=
 =?utf-8?B?OTdyc1doN0N2SE94K1dLNTJNSE9MMkxheG40Tjh1RW4rQnhndHBDRkg4THJL?=
 =?utf-8?B?dllwNkthUmRQTzkxbUZjc1FvZ3p3clpURGRhcHRpTVEvUUZKSGRFM21Xc2tC?=
 =?utf-8?B?N2JqRVQrOGlvSENWS0lsbGx2aWZqNnNDbVlRb3BMaS91ajB6N2RNelY2S0hn?=
 =?utf-8?B?VUtwSGRHZzB4QzZibldraWRJVWdjSHJWQ1k1T3E5US9LaCtpQm93NW1ZREN1?=
 =?utf-8?B?MmtGbmJhRFNiTnhBTDM1bnFWTlJ4TG1WSU1BR2dEU2VtRE93V1ZQZUo5Vlh1?=
 =?utf-8?B?V0hvMGlQZUFUK0dUVUUzcWdQZkdmbHB6RUg3YzUvRzVjeTBMOE15SUs4cVBh?=
 =?utf-8?B?d3JvL0d5ZWc2MVVGK016TkZyb3FCcXk3MEJ2TWl3YWkyV3AweFFSRU4zV1Rw?=
 =?utf-8?B?RHA2ODF6bkkxOXZZTjFEdDhoSGd6VkVqRlBGTk9sbGJNaTFWeEcycmZkQlYx?=
 =?utf-8?B?cmJJR2lhRFQ1ZlhOZ2FyRWM0NjZzYXBJb2pBK0M1RXQ1ZmJvNHViWkNzckd4?=
 =?utf-8?B?TWN4OHpqaFJpQm02S05Oc0RidCsxUWdkSCtBWi9tUWh6TXhyQWprTUNTelE2?=
 =?utf-8?B?N2hFM0ZPNmcxS2tVR1lBM2Z3N3d6QzdHeHJ6U21GVmh4SlZBdEhoVkY5OTM0?=
 =?utf-8?B?QWRKaDUxUzMyN05EdXZlV3Nsb2UrWVdhd2h5TW8xS00rSVVMc2l4eDFtNzRI?=
 =?utf-8?B?VWZnUXY1a2NOTWxRSll6N0dwWTlwUVZKelNqM0ZoTWtXYk50ZDJ5SGg1TXdi?=
 =?utf-8?B?OWZkbVozMjM0L1BPRFdwK1Jpejk0VTJHSnpsd2l3dG5jcW5NWDNaRERQZWNQ?=
 =?utf-8?B?WmN2SmZSM01jSkNtWFEveXBabVplVUVUMXBPV1Z6SjdvY1lmQlQwcGh3N2I1?=
 =?utf-8?B?U0U4c3IvdGxPSGtjaC9Fc29GSzF4bU92OG1vWVBUZGVRM2YxeDJsTFRBdEs3?=
 =?utf-8?B?TW1BbGxqLy9vVmN1YVNqcno3cGlHKzM0emVOclV3QzBGZ21VYUtEdzRsTjVR?=
 =?utf-8?B?eitHamlnS2RueXNFQnZmenZ5dExvWmlEb0hsY214d2hHeVlOTGVRa0J3VDVh?=
 =?utf-8?B?aFAzdFczcktpKzl2WWM5akNqdzRHZXZFZmJka0FuOG9aVGdoL0NlZVlmWFhW?=
 =?utf-8?B?Ny9Nc0k2RTA3QkV2SlBpQ2tSclZ1a21FSTA4UVFqemZTZFRQQ0pleHl4U0ky?=
 =?utf-8?B?SXVJTkk0dDhjN1REeWtsZXFtSUZOcC8yRTVnN1E5N2lCdGdjK3RzQVVWcnU0?=
 =?utf-8?B?SU1vNkhjMTRUZzlGaWN2NkQ1U3FwZ1pacFE2aUQrTm8rNmlRT3ViSll0QUFT?=
 =?utf-8?B?Yzk2SlovZUZMMHJJdEJ4SHhPODBYZ0dmTXNrMkt2d2k1dkZOYjN0VXUwK1U4?=
 =?utf-8?B?bFdLRFRHTExSTEIwTHlvcWFHQ3VpU3BPK1JXdVJFV3RDc0lua2pUQ1RwSGdJ?=
 =?utf-8?B?VjliN3BFWjZQcGk5U09BUHpWWjF3U1lBbXR0WWJvaXp6bXBpTVY1UVRPSmdz?=
 =?utf-8?B?dHZkM0hTdnZqM1hYUlF1RkJTN2NCalc1dnhoYzV3UlRmY3lybkpFWk1EUTFM?=
 =?utf-8?B?Z3Q4VkFEb3ZVWGVhRWdWQ2hMbm9XbFAzV01jbG8xME1aOThXNVVYaFE5MXJS?=
 =?utf-8?B?dEdnM2wvM2RIVkNpN0c2VUI4YVlzVStQOXhsSFREQU02aGlRbjBhcW13UlR6?=
 =?utf-8?B?aWpvK0FsK2JWVEM1TGE2aHFWMTZTb1NJMDVhUGVPbDZRcDZSVXcycFRNbFZt?=
 =?utf-8?B?TXM4ZWlLZUFxUDB4QWYxdzBhdDcyYXNsRStHUUtJRzlTSVFMSE9EQyt5TlNr?=
 =?utf-8?B?Y1lqcXJOSEZCSk14VEhHa3JQNmNaTVFmUm5CWjZBSGpkSUpUNmk1TS93NmlC?=
 =?utf-8?B?ZW9XcE1BUVFlVCtlNnpvdjNXUjJSMEN0MmpjVnphazFoL3ZzZVljOWZWSGpC?=
 =?utf-8?B?UitsekM2SEhnOTFBVXJqNnRhVksveWYwd3VQUFlPcDEySVFNS0xoblVtZGJw?=
 =?utf-8?B?OHc9PQ==?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 734f5144-f419-46fb-2f74-08daa05c1906
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4765.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2022 07:44:24.5023
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uPS1Rdhyjw62iuMs7PDnEVyqb30nn6YC+VsDTmJ/0QMHJbUFjQRGwvbKhWqT6+3+f+9v6bH/Z6cFa/rm6m1K6ssFagkCKyABQiSziMivko+FIjx/v2rSLB7+9kL5TJMO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR08MB6259
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On 27.09.22 3:49, Hyeonggon Yoo wrote:
> On Fri, Sep 23, 2022 at 10:34:28AM +0300, Alexander Atanasov wrote:
>> Hello,
>>
>> On 21.09.22 14:30, Hyeonggon Yoo wrote:
>>> On Tue, Sep 20, 2022 at 03:11:11PM +0300, Alexander Atanasov wrote:
>>>> In (060807f841ac mm, slub: make remaining slub_debug related attributes
>>>> read-only) failslab was made read-only.
>>>> I think it became a collateral victim to the two other options for which
>>>> the reasons are perfectly valid.
>>>> Here is why:
>>>>    - sanity_checks and trace are slab internal debug options,
>>>>      failslab is used for fault injection.
>>>>    - for fault injections, which by presumption are random, it
>>>>      does not matter if it is not set atomically. And you need to
>>>>      set atleast one more option to trigger fault injection.
>>>>    - in a testing scenario you may need to change it at runtime
>>>>      example: module loading - you test all allocations limited
>>>>      by the space option. Then you move to test only your module's
>>>>      own slabs.
>>>>    - when set by command line flags it effectively disables all
>>>>      cache merges.
>>>
>>> Maybe we can make failslab= boot parameter to consider cache filtering?
>>>
>>> With that, just pass something like this:
>>> 	failslab=X,X,X,X,cache_filter slub_debug=A,<cache-name>>
>>
>>> Users should pass slub_debug=A,<cache-name> anyway to prevent cache merging.
>>
>> It will be good to have this in case you want to test cache that is used
>> early. But why push something to command line option only when it can be
>> changed at runtime?
> 
> Hmm okay. I'm not against changing it writable. (it looks okay to me.)

Okay. Good to know that.

> Just wanted to understand your use case!
> Can you please elaborate why booting with slub_debug=A,<your cache name>
> and enabling cache_filter after boot does not work?

I didn't say it does not work - it does work but requires reboot. You 
may want to test variations of caches for example. Cache A, Cache B ... 
C and so on one by one. Reboots might be fast these days with VMs but 
you may not be able to test everything in a VM. And ... reboots used to 
be the signature move of one Other OS.

> Or is it trying to changnig these steps,
> 
> FROM
> 	1. booting with slub_debug=A,<cache name>
> 	2. write to cache_filter to enable cache filtering
> 	3. setup probability, interval, times, size
> 
> TO
> 
> 	1. write to failslab attribute of <cache name> (may fail it has alias)
> 	2. write to cache_filter to enable cache filtering
> 	3. setup probability, interval, times, size
> ?
> 
> as you may know, SLAB_FAILSLAB does nothing whens
> cache_filter is disabled, and you should pass slub_debug=A,<cache name> anyway

Okay , i think there awaits another problem:
bool __should_failslab(struct kmem_cache *s, gfp_t gfpflags)
{
...

         if (failslab.cache_filter && !(s->flags & SLAB_FAILSLAB))
                 return false;
...
	return should_fail(&failslab.attr, s->object_size);
}

So if you do not have cache_filter set ... you go to should_fail for all 
slabs.
I've been hit by that and spend a lot of time trying to understand why i 
got crashes at random places. And the reason was that i read an old 
documentation that said cache_filter is writable and i blindly wrote 1 
to it. If the intent is to only work with cache filter set - then i will 
update the patch to do so. This is the only place where SLAB_FAILSLAB is 
explicitly tested, other places check it as part of SLAB_NEVER_MERGE.

But even for all caches it is kind of possible to test with size(space) 
which is in turn useful because you need to figure out how you handle 
failures from external caches - external to your code under test and you 
don't want to keep track for all of them (same goes for too much options 
in command line).


> to prevent doing cache merging with <cache name>.

Or you can pass SLAB_FAILSLAB from your module when creating the cache 
to prevent merge when under test.


-- 
Regards,
Alexander Atanasov

