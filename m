Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A0995BE1B7
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 11:17:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230184AbiITJRf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 05:17:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229962AbiITJRa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 05:17:30 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2136.outbound.protection.outlook.com [40.107.20.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15E6F2BF;
        Tue, 20 Sep 2022 02:17:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D5WorHQxFtgqpDABrDf/xvb4VG/OCsZwtQSnBzA8BWY1UviBVz2b12kCtChlg3Sq3/NGfyWIxEtay3k1dqzlHlCNcW58epQY8EedpD2MF9i4r6ZcToQUSpryPJ3TBeo+93qwstUuw4zNVDeRw2TCSAR3NoZZkscCmGItzGI8C5/PJiYYXb9f15SrPWh8Tca8RwYq0Le9CVA6kCj9LdswkOr23oyGlyQ+3fmh5UzEzSs18aiJamv8gDcfe3n+dFJ+F9qbd4Sw3JvovJx6qPvkcFTN8p+GzCIVoVsjuSd+pdqjRS4QDQ3Z5EmobWGrl1xap76PxuAJWvoiHVxh254tBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/p3teV7KgnFJdkiPa6CjOgiZI9m/YJEuccoL7s+T0bM=;
 b=UhtDsGgSradifsiZZCtb8yEPr4vutuqujSBrk55lZ0h1kbwJZNUhCKRI6St8mlVQQdm6UC6l1b+ugiDhI31GxHFhL5yocW+YQmRjKcb0xRrnkgnO5R6BlYQnow3Zm/CK1jnm+XHiHhgr2GtLg0wHPzpik1AVE+gdPxrJ5cn2CrUfpR20WYoreMiSXnNQKOdu9B270lBRQocy540Fy29BRo15k5l8gm62+bL6KXsfaWAUQK4Ban3N6mKDijbvHtQ85yyKy0dRuLDtIlxgn9dBTE2z35LrTs8RjICdiq+ZwvpEfSlTTLohLk3xrgqftas0S12PMIuBgQqoq3fH72X6dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/p3teV7KgnFJdkiPa6CjOgiZI9m/YJEuccoL7s+T0bM=;
 b=s5KLgPzgush0v+unrKLwryMZAIebJkkfWGn9c6p6x+znc/w1/rn0igse1A3tDd7P9YcJDBeCgsTPH5quxWC4GFlufEfDKYi/UUKg+4fpVeAnB9n/ngufX5zX3qD1EsAOS2JlS9EVp1tg9Op6ZcYrOzEViyiah7A7JaN3tTte0fibeYXYQl31dRiEX/WKDwJIV3VkFpkN6l0yxsc97ILqZrUxSjQxaJ8SVkAuvtJK9KL4HUwcqUJPcxkxlwwqOIy/l7k7/Ob2DNxu0AoEGNRKRxFHSy/gyyWoDXse87AcrYRMUuIGvemLtAmlKdo0odxJ8xSOYC2WypTW5cnLQa2fGQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VE1PR08MB4765.eurprd08.prod.outlook.com (2603:10a6:802:a5::16)
 by AS8PR08MB6550.eurprd08.prod.outlook.com (2603:10a6:20b:31b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.21; Tue, 20 Sep
 2022 09:17:25 +0000
Received: from VE1PR08MB4765.eurprd08.prod.outlook.com
 ([fe80::2846:1df0:88bb:451f]) by VE1PR08MB4765.eurprd08.prod.outlook.com
 ([fe80::2846:1df0:88bb:451f%3]) with mapi id 15.20.5632.021; Tue, 20 Sep 2022
 09:17:25 +0000
Message-ID: <6f5a8f71-3d82-97bf-90e1-0f33546bb59b@virtuozzo.com>
Date:   Tue, 20 Sep 2022 12:17:23 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.2.2
Subject: Re: [PATCH] mm: Make failslab writable again
To:     Vlastimil Babka <vbabka@suse.cz>, Jonathan Corbet <corbet@lwn.net>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc:     kernel@openvz.org, Kees Cook <keescook@chromium.org>,
        Roman Gushchin <guro@fb.com>, Jann Horn <jannh@google.com>,
        Vijayanand Jitta <vjitta@codeaurora.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
References: <20220920082033.1727374-1-alexander.atanasov@virtuozzo.com>
 <21646f5c-39ee-a51c-f30c-272de85ee350@suse.cz>
From:   Alexander Atanasov <alexander.atanasov@virtuozzo.com>
In-Reply-To: <21646f5c-39ee-a51c-f30c-272de85ee350@suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR07CA0210.eurprd07.prod.outlook.com
 (2603:10a6:802:3f::34) To VE1PR08MB4765.eurprd08.prod.outlook.com
 (2603:10a6:802:a5::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR08MB4765:EE_|AS8PR08MB6550:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c739355-27d4-4125-f1b0-08da9ae8eea7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0w35UatpmrbBWY+2BYweRXV6rpGuevYZ8Wp748W2bIr3FTPtcMC67L5j2fLQsUnhhqP0MsxITJqbhe7oheItN7EGlH2+67AwA4eBChGXlBv6Zf8Ax9OS32ITM04UHkBxw7mImJ9pfBJsYyhfwjK0zxFbv9zM/3X8ZhkMoLC0IQ83JdlWWVkskc6/kui2YiWSd2ZGd/otYUywt9Il6AnkSp9jB2k+qW7JBWFRnNQ63Xtqrk2sdfR9JAW946mU2dtz5TjjNOK0BB6RQh1ZvvP/7hXhoD/ot9bpLjPkXHpE2VPIjud3dBvrhbJ3bSyF09RQi9S/3uRbYsyTFifflcU2JKLuWHHcxAwKO+PbuosZKmb1gE9hVCXVCwxWUnlZ/9SI9VdSoy5kQufg5Y2JO+EFS/H0df1iFffRFyN6yDafLPqfmbTc5TSs3aQv0Mfg+bIejamwX7rhgAlC8+1F+LiYcTtJlW7ZcPKLI5u9SwoMT/bKpt8uVAgBfAAp6KYyDQ8rOke9HEVABbKOW2EUPc86Uuu3Mj/7RmolEpr9MhqsmMuRkLjmfXOAfRhZ+pM69J1qtSWmaH7Cu4LPiM5aPlRvCR6Y7VojTIAnctPNmGFiw6l/4DvhGXbGg5vx5rry8s09iIm/I45MMUybHkACZG8CmBD1Sx47ulLXlSjLQZbOxSXJWv5d97RZJRoV3fehYJaVC/SrjIjaa2bVEljmom8yTgyNZM/q4uI8IfIBLAdWceqq8BoRwJ1B9qUq998gV43jnQOS9+AQefY2V99cpt8B5o7J//m3QpKeO9tBmuJElGxffdDlncjb39E3jfx5ZR9qAGAa5NPMIFr9MMSPVRHy+A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4765.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(376002)(39850400004)(396003)(366004)(451199015)(44832011)(7416002)(41300700001)(8936002)(110136005)(54906003)(66556008)(2616005)(8676002)(66476007)(2906002)(36756003)(38350700002)(83380400001)(66946007)(38100700002)(4326008)(31686004)(6506007)(53546011)(52116002)(316002)(6486002)(26005)(5660300002)(31696002)(478600001)(186003)(6512007)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VmZ2UFNOckViSEVxUHdaK05yZXNkNXZqMjhteFk1b2htQ1dlOUJmbjh4WDly?=
 =?utf-8?B?WEFScFA0S0Y0MkE1YXdpLzJGeTdmcng5eDBCWGRXNEdBUGZDMWh0NFRNMWtr?=
 =?utf-8?B?b2ZUN0hjQlp0N2pPL2cxMERkRnVjUzcrVmdjbXVjZVc4NVEzYno5RStjNUZW?=
 =?utf-8?B?bkM2TnZrdElrWmQ2RHlxUW0zUGFKYmZwaHRFckV5NEVVbG11bEo5NGovSDVr?=
 =?utf-8?B?R0dRRjZJbENpbE1PV1dFRG95b1hHQUpvbzdrY0JrdHBUcFlkUEhZS2JJaVFy?=
 =?utf-8?B?c2U3TVZQSVd1SnV5QldNcy9uZ3VYbFNNUUxGQjJyYWhxMDB4NGVsa2JxOUFI?=
 =?utf-8?B?Uk41UGVuTHNXUmcxdzcwZ1hYUFo0SGwwTGNUR0ZrTHhCV3psNWwvUXpuYzVE?=
 =?utf-8?B?a3M3TWp1eEI0dERUQ2JudStqUm9NWDdhWVEvVnB2WEhHRFpNOCt6b2o1YUV0?=
 =?utf-8?B?MThUbVU0dlUwRWd0eUlXS2dZUFlSZThyWGgyYWpCanpjMy9aajlsQ2NnQ1dW?=
 =?utf-8?B?d1YzMmJzTGpXK0ZXRW1Ea0l6cG5zV0FaZE5IUUd2Zk9qM3dkTmdaeWpLMVpI?=
 =?utf-8?B?ZWlya2xJeE4wTUZPZlRRV1hBd0xnWHQyUGxlK0EwQUtkczh1RXVvWFgvbGtB?=
 =?utf-8?B?aU80dHRZYTY0WVVpTENCNFJhUklVNkN3MnNyV20vUENVdWtWMktvVEgwWGFV?=
 =?utf-8?B?b1JhRm11RVNYS0VVWHRtbnlISnVveEZRejJSOWFjZVloOXZLMzdlSWdzZHlC?=
 =?utf-8?B?RmhQSnF3eDJTdjNLRVpDS2ZqdTdrVkUzWFhNNHNvVnpUNEJKVGY0TFlEQUpW?=
 =?utf-8?B?UjNCcGZYWC96eVlIdTJBVFFnSDFHd1FFKzVSTUQxU3IrVi9pSldEZ2toZE95?=
 =?utf-8?B?Q083RmdwNXp1aS9FMjc3bGtPbGFab3RYajFNUldDanhYOFAxQmlScUVXanlo?=
 =?utf-8?B?cHBVTmVtMEhub21DOVRaZ21ON0ZGSWJYUVFxNXVIR0FSbzlmenQ0S3cwQnUv?=
 =?utf-8?B?eDFkZmJWOGJ5bzlHdTRQYmd1WGd5S3hXcWJvd0hhN1ZXODBKNmZ5cm9FcnBG?=
 =?utf-8?B?T1hlV1ErUlN4V3VmK25LL2NVY3hxNlFIaUVMM2IwYVNUd3VSZENBb1JjVHpD?=
 =?utf-8?B?OE9JenNYYyttKzVReHJOalFWejA5aFUvYWtCMi92T1B0TnVRbE41SXZwMldL?=
 =?utf-8?B?ZzRSOEJ3bTAxblpsN0RvV00xcFpxcFpNRTA1VmF0T254eXpDemtDaHJ3SWtZ?=
 =?utf-8?B?UGJYa0d4dXdpQzB6bDVDdmN5WWx0VUN0ZHpjbCtTb2UyWDlhM1VGYVliN285?=
 =?utf-8?B?NDVOSnEwRHNYUmhNRnpPU3NCYndnT0Q5V2gwVE5sMDZkZUMzZEJvc2tnNmE1?=
 =?utf-8?B?eGhoWEJoRGgybUUvaHJrTmpjbTBERVhRSVQ4cXhvdEQyTFJyUXF2dGpOeHVy?=
 =?utf-8?B?eWpneHdrZE11SXUwK1phMzFrNHBrYW9ReW1ORldjbEZoSWdpRCtUQzR4aktt?=
 =?utf-8?B?dmpCTE52cklITXdpTzV3YUh5bytka0ltUE92SUR0eFZ0cVhCRHBJb3U1bkZK?=
 =?utf-8?B?UW5BOStUQVEzTWNwNnM3RDV3N2R1MTU1ajBOMDNpcDdjR2h5by9aTFB6OGVP?=
 =?utf-8?B?ci92MjJhQTJsNTlrZEcySWNuTFl5Qm9mZnNnUER1dENINWZGSTNkUWxXU3pK?=
 =?utf-8?B?RmNqcCt0T2ZVWDN5c1BkODlNU1ZGYktTY0YxVnd5ekFoTG5NVWNkRE5RSG5o?=
 =?utf-8?B?UStxb3Z6NHpiWWFBdE5tVzZ6bzJSR0E5Q05VM0Q3aWg1MkVrM1dpemMybndV?=
 =?utf-8?B?VHp3STIxQnA0cDFCdHRPem5NK0RRTjBhcHYwaXlpYlU0aWkwTTFiL0xJQ0wz?=
 =?utf-8?B?TGdUamp3UklheDRtL3A3dVNzTTJGNmNUbzk1L3NnM0tZL3lmVEVHVGQ5OEM0?=
 =?utf-8?B?U2xjVWJpN2x3OUpOaURodGNIN284eG9NQVJ2MjZJQUNpZUQ0QTlnbWZteVpa?=
 =?utf-8?B?K0NTRUYwOFJiRi9ta0ZIK2poTGtjT285WXMxRmhiTzBHUzkreDZwMG8vUURj?=
 =?utf-8?B?Y2UxUzhRcGpSUlZWbnJDcEVOaEVoT3lWSWhnWTF6UXpsTG1VUWdmMHhseldj?=
 =?utf-8?B?alhrVWU5YVJiQWE1L0JhNVBQMzFPWWJhY2M5SmtWMG04L1VqSmVoc3c0R3Ur?=
 =?utf-8?B?TkE9PQ==?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c739355-27d4-4125-f1b0-08da9ae8eea7
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4765.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2022 09:17:25.4826
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 123N7OllmqtbEK5YsgPKUGF/F6YfpaCLqZ+4aLnhtejOmfEZJvv5c2F1FAoMRTv1WnJFWzdcVZ8tHXwr3bmgA724mKnMmlZf3/YpArH9IcbZ4H5GydDpr5eakkRVFh57
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB6550
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On 20.09.22 11:42, Vlastimil Babka wrote:
> On 9/20/22 10:20, Alexander Atanasov wrote:
>> In (060807f841ac mm, slub: make remaining slub_debug related attributes
>> read-only failslab) it was made RO.
> 
> "read-only) failslab was made RO" ?

Yep.

>> I think it became a collateral victim to the other two options
>> (sanity_checks and trace) for which the reasons are perfectly valid.
> 
> The commit also mentioned that modifying the flags is not protected in any
> way, see below.

Yes, indeed.

>> +static ssize_t failslab_store(struct kmem_cache *s, const char *buf,
>> +				size_t length)
>> +{
>> +	if (s->refcount > 1)
>> +		return -EINVAL;
>> +
>> +	s->flags &= ~SLAB_FAILSLAB;
>> +	if (buf[0] == '1')
>> +		s->flags |= SLAB_FAILSLAB;
> 
> Could we at least use a temporary variable to set up the final value and
> then do a WRITE_ONCE() to s->flags, so the compiler is not allowed to do
> some funky stuff? Assuming this is really the only place where we modify
> s->flags during runtime, so we can't miss other updates due to RMW.

Since it is set or clear - instead of temporary variable and potentially 
two writes and RMW issues i would suggest this:
+	if (buf[0] == '1')
+		s->flags |= SLAB_FAILSLAB;
+       else
+		s->flags &= ~SLAB_FAILSLAB;

If at some point more places need to modify the flags at runtime they 
can switch to atomic bit ops.

-- 
Regards,
Alexander Atanasov

