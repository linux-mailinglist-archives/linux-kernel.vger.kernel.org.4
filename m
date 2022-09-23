Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D22695E74E9
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 09:34:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230504AbiIWHel (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 03:34:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229928AbiIWHei (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 03:34:38 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60119.outbound.protection.outlook.com [40.107.6.119])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0C462A247;
        Fri, 23 Sep 2022 00:34:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dAHuuhZgSs1oRlHwhqbcqPH8N3aBWsAsziyjdl7Mzlncy/xwv2XtDwnY+eA3fnh5ehbIIBdT+IfBHvdqj0qqGx7VgiuBNeUUMZzCVWMahxsdWXUGF5OM1rJZSEPBmgSawhFc96rwAb/92oXGMgJZIHD4ciz4jlofR34JMseAD0Z1hJnbBzdkEhAuOAMa8yM34bDmQS2ezDVR08g1AVU2w2R4qQ2+ExyX6cJhBhfAErEulV9/ewOXS3TjJg3LmfqUsu5L4NP2sSiliw9JjjTlG60zAQAwE7Lz7/Ffls4UsvHYjX94AKBnu6408D/OtOqjGx8o84fzz/3jZyhBaqXPkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fjOYn/4k09qNOyxi88hh7BxnKaKDN3zBNvOmPFWhqjo=;
 b=gXZ9WlF8F4rR6diMs2t0KomNmOJyZP4ZjC4uCCZGv8nhnRxv7mB3vEtTNk82pfKJx3cI1tmzMdxX5Y7DigHj43HaQJt4YgYPyDdX4WoCYnwIr3lepZvkThSsWoHUyG+x4OgRB/m/3J+R9G9vX1EMEOj4en4WWgvcwr4X7eqgVco4nO/ZtAIi2lECAI+gZ9rHIYeQb+DYyl27FjGb3t/JUzlbQOHnFI4H2Gb7ip5TfQU0pM7FAlL5I/om5gQZfF/gy3HMqjK/U2tuhEKx2uZcN8ax/LjLmoZc8JsQkDwXTobwGo9bACrEr+qiG/ebMFfckm0ncFtTp9OCKSFpOdvkVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fjOYn/4k09qNOyxi88hh7BxnKaKDN3zBNvOmPFWhqjo=;
 b=Y2pDOSHKlJIC5k+qk/8fQc7UEIJay/t+ixY0BMxNyUfjxok8caMSznWqL3iMtk1ElRXG2JBxtOb0sm5Rw6b+4zbmwfDtMYWxYRzg1lZP31NACvNj9IkOEwWs3q/97QWKN4McURWhYfy4ew0SRXu3O1XwG/SCnSn+WL4OIIhEtP7EnZKXouuWmen/G11iQdUl0/xtXEVOGjpiWOVHWfCdnhwIqDfJ1uX+AOhn07Ob9pS+j4vsV9YBfqpvLw4OcEnj8rO7k9IeUF2yDxyBRTFM3P74P52lbjOhdFiK0X1CcfC2i3VWAXzoicqVYBTsNwwaqccgOiCAA0ZzJjl53d7CWg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VE1PR08MB4765.eurprd08.prod.outlook.com (2603:10a6:802:a5::16)
 by GV1PR08MB7803.eurprd08.prod.outlook.com (2603:10a6:150:5a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.18; Fri, 23 Sep
 2022 07:34:31 +0000
Received: from VE1PR08MB4765.eurprd08.prod.outlook.com
 ([fe80::2846:1df0:88bb:451f]) by VE1PR08MB4765.eurprd08.prod.outlook.com
 ([fe80::2846:1df0:88bb:451f%3]) with mapi id 15.20.5654.020; Fri, 23 Sep 2022
 07:34:31 +0000
Message-ID: <30063d97-69f0-bea2-9d59-108140995bfc@virtuozzo.com>
Date:   Fri, 23 Sep 2022 10:34:28 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.2.2
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
From:   Alexander Atanasov <alexander.atanasov@virtuozzo.com>
In-Reply-To: <Yyr1xONdw8dBgsKr@hyeyoo>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR07CA0252.eurprd07.prod.outlook.com
 (2603:10a6:803:b4::19) To VE1PR08MB4765.eurprd08.prod.outlook.com
 (2603:10a6:802:a5::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR08MB4765:EE_|GV1PR08MB7803:EE_
X-MS-Office365-Filtering-Correlation-Id: 50ff07b1-44c9-47fc-f308-08da9d360d91
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JNvGQJMuVjIG/upM65hO3w4nndy792ZEgOtR8G4px2w4nxFejLebAiC5drDo8yioqqjg7j4PaJfybOxrizqV6iAp9/eD32/4Qui49t3Z0jcxAD5Q39NCGoD1mlzBP82NKPdcm3H0owvv+oDQMmDS+43g4Ierga2xn/m0h3MViIwirmXaRu6rGU31egpDd5vYpe7SY4YEEzl5E+BPm3TUpcxlmm0RBbqhNIBGn1GzixnIj7Y8SXQky7aiUA02tnDjga9WjC8g9vPHRmhVnwprqozCqw+Y5D1csOd8DVJ7zTfmFp/JvFxFwnUqvnfL4bx2uXRcvY1VrQqO2FUkmQZlTuvq2GGfOIRoAK+dTMg8YsiaMYKGDO4mfL+P2YvI6Oy3Aoxx3nozOtkLeAn0T9DK+mp01rjCv3goj0r6TIuBLYPN2LvT424kEwMnmFwHZy2jOYWsWO8uBIaQAA7OW4H1VTLQ5QIPHEQjQM/Aqzv/u7pLhEEYJ9hKe9dY7rKjsUQLPuT8J2oVu5AH9d7ox2uVgokKSGTyFQQZyMzjwOv8bhuFUtsV8lvgImCewJJlw2K7/fO9hLnw1fFAwlC9JU8QCksJ4A7WlV3h4TlTCUdKh9Qr/D53Orux3w18Li0wSGrPKwH4Ag5GevqcdZpmMw9WROZKKeE5ArqhtccxxvfYEUlrWzqpoxvbEMZRJIdAEGl7LTIM03d7RAGohqQywcTsg+3DeR6l4cYHj+FGxilXVTwi+yGlLYGOVOASd3RWWgo2Sb2HOcn569cR+/qQci6wXGyu86a6RK3tPbXAJlGiFBJyasUWkBlAEcu5UitmMEXW
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4765.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(39850400004)(136003)(346002)(366004)(376002)(451199015)(478600001)(54906003)(6916009)(316002)(66476007)(8676002)(66556008)(31686004)(6486002)(4326008)(66946007)(38350700002)(6666004)(41300700001)(5660300002)(53546011)(6506007)(52116002)(6512007)(44832011)(26005)(186003)(36756003)(2906002)(2616005)(8936002)(86362001)(31696002)(7416002)(83380400001)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TGxES0g3dURVNzZPK05OUWxhdkUvc04wTHdpTkRycmNHT1lYeHFsd08rdlgx?=
 =?utf-8?B?WlB0Mkk1OVFTQStOT2x3U0ZGek85cWdBRGN2eHJDUFlBS0x3ZTgxSDZzdVA0?=
 =?utf-8?B?UGw0WGErMjcyaTRqUWRKRSsyMHBVT3pTZ2JVSzg2TVFmWkwrOXZBQm9UWWpK?=
 =?utf-8?B?aEYyb0pWbVBobXBzQi9ONmtDR2NlQXAvRVAwYnpWbVlRTVFFcGZxbE9lT0w2?=
 =?utf-8?B?SDkyUm1ZemVKaVFyQlN2Vk1EY3BzOHYyR3M1aklqSHNDUkR4RHlQT3VkU3NN?=
 =?utf-8?B?TEhzdDYxZGZtdkVzbHQwUmxvNFhOelBtQUt6dm9JdEx3R3RqSXZ0UkhGTitl?=
 =?utf-8?B?SUhFMmZpbFo5Z1ZPQTFlUWxsQUt4NnpnNnFYdjdMY0E5YktIV1Bxc3BxQkpn?=
 =?utf-8?B?QVVyODl3YnlYMHhEZG1SMHRGM2lJRFRkbHpHRDZzZ0lLdXNqV3ZGM1YvQzRs?=
 =?utf-8?B?S1k1Zlc1TFZ0RmlHQXNjdWtXRUwyZkRPOGZvUkdSQjlHTnlqazNaVlVSSnE4?=
 =?utf-8?B?cXNTd3c2eW1sbkVvQjZJVjl6ZVdWQVlqMEJIUkVWL2Y4YUtSUVJQM2MxTHF6?=
 =?utf-8?B?NmI5QU5iREU5Rk1NMzBrdGZ0UGtKdzZybUFoSTFjTkJ1QmtjYTZxOHFiRkN6?=
 =?utf-8?B?ZVo4dytDTGF5Rm9qVjI5NzBuNTdHQnlQZ0pqUG9wM0JoTklLTzc3S1NjajJ0?=
 =?utf-8?B?cmZSRWN4K0xtNFVNUnZ2c21kc0hCL0pOV2o0SzBCMXZFNEhOZkp3S2hxRFZx?=
 =?utf-8?B?Y0piS3VLa3JPQlRNVitmTkE2R1dkcjNkcTljWFN1SzZEblJaUFo3N1dhV093?=
 =?utf-8?B?ZHZFL0hkQVdXTVkxY1JZOGdPbGVFVXNGbjlIbVlzTEZQdE0vZThLaWVOaDU0?=
 =?utf-8?B?RFhDNHhrNDgrWEQ2SHpJQVpkWlNHT01lUCttRG16ZHB5MFhCeGg5T21qRXl6?=
 =?utf-8?B?ajhZb2lMVGM5Y002Lzc5TWZPUmcxZVE0OHhHbzM0SUZNREVJczRGMktObEJx?=
 =?utf-8?B?TWJFNVpuNlhlbWxKNWt4bDNURU1MNFRJQWJIRVhoWUxSUGVOY0pyLzJyZzd4?=
 =?utf-8?B?dFFQU1dXdHUrcUlmWGpZL3NOd1JIOUZ3QVBPWWNGMmRpSG0zS1ZSMVk1TW1u?=
 =?utf-8?B?OG92cVJINEk0aHhPcTdrOGNNTW50MVBDck9nNThxQWNSL0M0Q1FLTVl2akV0?=
 =?utf-8?B?bzJRTXBMUzNlUTFsSHQxa2FJTHNwVXVJRnM5LzVjNGFvVG1sU2Z3eVpFdVJU?=
 =?utf-8?B?RWVGakdMTVNibGlHN08rQWlHbWw3VEhPUDliWDJmNlVzT2xJSnl3RGd3SEgz?=
 =?utf-8?B?TzJ3NkFmTlhSNzJvdVVyRW1hb013Ni9McWFpTno4UXJtaWJBblVtZnRxL1hX?=
 =?utf-8?B?bmRIbG1IU01FQk0rcSs2TzhIbXlGeVFncnRZLzhZS1BGMnEycW02bWczb0pR?=
 =?utf-8?B?Nk1JVTFaOW9CUnVTMXVCQ2QrMDR3NE9ZZ3dqQVZqVVFBYTcvUTFGMC9tS2U5?=
 =?utf-8?B?QkJydkRZeEkvbUxuUklHVytkSUZiSXo4SnIxMEVkVEI5Q1ZaYzJLb0RzOFNZ?=
 =?utf-8?B?QjFwTVBoNHNLc21yU1g1MHBRcmtrdGs3ZjdJRDNNM3Q0aGRIR0hwNytWd29q?=
 =?utf-8?B?UkozNkY3UTRLMENWZlJwdEk4UzFDYUdKMjhUYWl5MVBob2duaUdTSDdYNDlN?=
 =?utf-8?B?SGtrbjV0RHlWTXdQS0J0c1UyamdnMWtaV3VZME56RkpzbU5uRkZ0ZFVmZHcv?=
 =?utf-8?B?NTR5U3dGUWtySjVZVzI0aGlTSUs4OTQrN1dVa3BYWURxSmxIZmxSM3BYVisr?=
 =?utf-8?B?R2kyYmE1djRiVUNIR2dseTBPaGd6Y0NsSXRRVW01Sk9VS21pVHcwYmRkeE5M?=
 =?utf-8?B?QWo4SGdZK0s5SUx0N21ndmtIcmlQSkI3TVZVem9ZQmdrc2tERzRVZGlTSnJw?=
 =?utf-8?B?QmhsaXgvSTNGejFUcGFqYlY3UDVEdzg0UHNUNXFXUy9NY2MraDF5cXRSUGpJ?=
 =?utf-8?B?OWV2S0wzdUVvRGhKWER2TVkyTURGY1UwTzE1aW9pZFZpazA1MEdjTkJyeGNN?=
 =?utf-8?B?K3Y5UWNvTGk4SkZVRW5WTWxPS2wxREJIQnRZR0gzUEFUamtXc0ZsV3lMWjgr?=
 =?utf-8?B?SXhpYTRxSkVvSWY2cE1qMnlUb3ZDS1lndmxoU3lZSEgrOWZBbjVMNlNVS2Ft?=
 =?utf-8?B?UlE9PQ==?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50ff07b1-44c9-47fc-f308-08da9d360d91
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4765.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2022 07:34:30.9841
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q09N7xg7jKPnKr+SUdHmor3JCvEg1obW04n+BOMsy22/8Ge+c/oOwZ6zjvxocalz1eikbTws5oTpuje3ow6rAjanpMeoH7kC58fPY2aToh5yACVQMbZC/g5eVgJTauDO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB7803
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On 21.09.22 14:30, Hyeonggon Yoo wrote:
> On Tue, Sep 20, 2022 at 03:11:11PM +0300, Alexander Atanasov wrote:
>> In (060807f841ac mm, slub: make remaining slub_debug related attributes
>> read-only) failslab was made read-only.
>> I think it became a collateral victim to the two other options for which
>> the reasons are perfectly valid.
>> Here is why:
>>   - sanity_checks and trace are slab internal debug options,
>>     failslab is used for fault injection.
>>   - for fault injections, which by presumption are random, it
>>     does not matter if it is not set atomically. And you need to
>>     set atleast one more option to trigger fault injection.
>>   - in a testing scenario you may need to change it at runtime
>>     example: module loading - you test all allocations limited
>>     by the space option. Then you move to test only your module's
>>     own slabs.
>>   - when set by command line flags it effectively disables all
>>     cache merges.
> 
> Maybe we can make failslab= boot parameter to consider cache filtering?
> 
> With that, just pass something like this:
> 	failslab=X,X,X,X,cache_filter slub_debug=A,<cache-name>> 

> Users should pass slub_debug=A,<cache-name> anyway to prevent cache merging.
It will be good to have this in case you want to test cache that is used 
early. But why push something to command line option only when it can be 
changed at runtime?

-- 
Regards,
Alexander Atanasov

