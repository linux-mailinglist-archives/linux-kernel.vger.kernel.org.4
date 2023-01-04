Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC01765D62A
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 15:41:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239390AbjADOku (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 09:40:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239749AbjADOkM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 09:40:12 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2085.outbound.protection.outlook.com [40.107.244.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56FD138AF0;
        Wed,  4 Jan 2023 06:40:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JwEOaDomo7rcvGaaUcq0l+MgOte9AECRCIC5BSqjoO6avrtZOzMOhsIKTFITuWSWiauK2x+4ZhgGpvhHHwSBwKRonG0OhGyAYlNnIS78dsyipjqj6ZXFAh+1zbGo4ykf7e8feIgIBMgqijVNuh+xwfflCH0nKTk/xcyZqvnptgRA4rrxPmU98XpD14ovCiH90JYWdgZ+w46gkPfMtHbbKaFCtXSnAiKy4vVnE+m36vaZj2P5RAda3eZYGg4dwUDN8YqPJBvOeG9HmX1PphTA2dGbdcHOYj+jsZ0vpst5jTAwwDhTHLW5+N+LhDdIr1IlB3RCFYaQoVybUJPoCRoE5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=igUQ/9sslEx6KencUKIp8PftnOCq3VqEQ31w/lLjmL0=;
 b=Eealy4UpRpl4sIqXPvGwN3jLe//zbaw0uTSMBZLCz0VTUCdzXcBwqSox67Kez8eqtWQn26L+GsqeKg8/EgKIP8zsB437dHb3a29gKIh8w20ProdmF+Wb/X60c3qT1QRw6CxozU1yHOIZvEiRayetWrMWVnZrhACUnx2dCycEV1jHHWGOqft8hg/WY86N6FuH/Ge3kupPHMmrKr0ElLg5z1/FiuN9T76ihD63TCf5UGSKcoAf+cyOhUQU7fxU5w5u/+/fE+2a3FCOcWIzD+0RZMDd3KgdKaRKISDAGzrfkQXtSCy2rE3PgnH9bQd/sj8MQT6/EwkYpst3t5C+cSYESw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=igUQ/9sslEx6KencUKIp8PftnOCq3VqEQ31w/lLjmL0=;
 b=kNxUo48Ye7+/zryu1OiRtvcL5yDo9gre6UKmSq8lkwUeQ6K7SuWk3xPWw24lnsHF5en6bUSkniE/WwvREpv/sUOf2Qomuu1qQkenbJDtbclUrncJKTBWDHbhGfcDDLBE3xjwn9CAyN2dsOwqCxHJOH0h5fmAIhFg1WFiWhgxnxI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by MN0PR12MB6224.namprd12.prod.outlook.com (2603:10b6:208:3c0::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Wed, 4 Jan
 2023 14:40:08 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::8200:4042:8db4:63d7]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::8200:4042:8db4:63d7%3]) with mapi id 15.20.5944.019; Wed, 4 Jan 2023
 14:40:08 +0000
Message-ID: <260364a5-f467-f83b-b180-583576ce70ee@amd.com>
Date:   Wed, 4 Jan 2023 08:40:06 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [patch] crypto: ccp - Avoid page allocation failure warning for
 SEV_GET_ID2
Content-Language: en-US
To:     David Rientjes <rientjes@google.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Peter Gonda <pgonda@google.com>,
        Andy Nguyen <theflow@google.com>, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, John Allen <john.allen@amd.com>
References: <20221214202046.719598-1-pgonda@google.com>
 <Y5rxd6ZVBqFCBOUT@gondor.apana.org.au>
 <762d33dc-b5fd-d1ef-848c-7de3a6695557@google.com>
 <Y6wDJd3hfztLoCp1@gondor.apana.org.au>
 <826b3dda-5b48-2d42-96b8-c49ccebfdfed@google.com>
 <833b4dd0-7f85-b336-0786-965f3f573f74@google.com>
 <1000d0c8-bd8c-8958-d54f-7e1924fd433d@amd.com>
 <06de8454-2b29-f3b6-7cf2-c037c2735b6d@google.com>
From:   Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <06de8454-2b29-f3b6-7cf2-c037c2735b6d@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR16CA0005.namprd16.prod.outlook.com
 (2603:10b6:610:50::15) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5229:EE_|MN0PR12MB6224:EE_
X-MS-Office365-Filtering-Correlation-Id: 795f1b70-d7c7-4ad5-4d79-08daee6193b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /6tLWlr1bU400JfLQXZ/CFph/Zh24vXkYOzDzbSkHGMIdfQHM4lJzpEqELZyjU2Ee9ZrQGFVorDjuqn70gFvs5ybTPnw8bY8gJ3ZR0hU4ACzwZPdoZyidRIgcq2FwVTqF2wMXI5p9kzjP34sHM784UEBH1gHkhUAJAmNyM+iSrfK2nvxlcfh+ZY3czw++F0XGsh4TaEnCT87+UcS7ynB1wma0dSDJcurG9u8fUcCPiq5jIfql8uxZDsi1tCsPNQTlsrthFUrE2ZlRNGN5mU+Q90QAFvxosTvsY9qwA+0w9UkJb1egtLGvkRwYNqwWGmvy4Rw1ProZNTk4MAF0AI5egOaBI296trVF2CYz0gflIPyajkGT4uSFA2/UDIGYv16t12Dggto7bACiQzG2YArYBd60wzAQ4TEe9i1SNs64NnpnpoeXiNEUQV8VZT7IgmaMVW5IZPFddMxbhummmQusWY3SfcQ4c1xOrid/8ld5vLLoyKXMIke8aAov+KqfB1QitJ1+rpAb9qpMU38P6KvbfBWdqTefw0LsCTkA+o3uH9InMOa9rtjoHB5Pprrl8W6+2yB6DOPHUuSyYjaGTiyDymGob+Eyl54mufx6MIr1IXJMA8I5lHKwdxbyWZGuC2FWTRPoNQiud5eKKHfqjMIs/eP7YtuxbpuFKa5+k/RZNIlBtD65BHFksXrjq7JBa5Z8R1A9G2JNkT/j13GoLDQNURW9CxAXEYQsE/LKdY0Dkg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(39860400002)(346002)(136003)(396003)(376002)(451199015)(83380400001)(86362001)(31696002)(38100700002)(41300700001)(8936002)(2906002)(5660300002)(53546011)(6506007)(4326008)(316002)(186003)(6512007)(26005)(66476007)(478600001)(8676002)(2616005)(66556008)(54906003)(6916009)(6486002)(66946007)(31686004)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RXJFSWJONU9jYlkvdnVRTWYyUnZ2Vm0wYzZXL2lwRDFDbnVmQ0VNTlJ4bjI3?=
 =?utf-8?B?eHBnS0lqMnlDbFZiaWg4OUJ2ZDJLYUpMMEtFd0dRc3Q2MkZVMzFRSGJ4S2NY?=
 =?utf-8?B?bklNQ21MbzA0cHoyd0loVWZjRkdDcURHRHBzVytmbm1MSDhteW1JakNnTHZY?=
 =?utf-8?B?SytRU3FMR0h4ZHZzZEF5K0xWY0ZuemptSGFRend0ekV6VDRySEZkZDhEdVUv?=
 =?utf-8?B?SkQyeHRkREErNm1Rc0pMUUdPdW0rMDVmY1J4MEtObGd6V1BiaEMwdy9PV0FT?=
 =?utf-8?B?ZzdGUDUyTUNRZys0c2hVc1pnZXlTVkJBOWJyM1V3MFJ4UEVJa2ZKMDY1WTJh?=
 =?utf-8?B?SlpwQjJsUUtCSlJQVGpqRW9oUU5odEo3ZUdQcUZYQXgvRGdTdHJPdTJ3a2w3?=
 =?utf-8?B?OHBqOTV5U2xHZzJHM3RyS0QzMEs2OC9PeGRWYWc4ci9HZENCb2JJaCtGRkUr?=
 =?utf-8?B?Mjd1NEFJM3RnNUFEMWd2UE0yalIzMmRPZS85cnNLWDczYmlvSTZ0dDl0dzFO?=
 =?utf-8?B?TTNiS0VqTVFiWDhXWGd6Um5uTnQxNTEyTFVhL2JNQURJbEkwRUVlVEJJRUxM?=
 =?utf-8?B?TWQydm5Ba2k5a0VPOC9zUG1kZzdDd0VYTVdyRWtnYmJPRUR0WVNmN1R4WExE?=
 =?utf-8?B?QXdiSDdwWTY3djRTQzhjOXFHRXZzSlFLR1RDcU5JNlZxS0w3a3drbmVERU9N?=
 =?utf-8?B?T2F3MkJrcE9kekUrWkRqdmttZEoycFhBZ1pVb1ZOckNCOE42cHZFQmVDVHdK?=
 =?utf-8?B?N1JzUEFFZ3RqVTNIMEhmQW9wMDcySm9FTEV5elJ4WjZSTjFLTXNPdmp4QzY4?=
 =?utf-8?B?M0k1TTRaZk5FLzBBMUhDcmNBL2k2OElvd2YvaVJvWmxja0RNMER5aWFrUndD?=
 =?utf-8?B?RS8wbmQ5QmJXekF0UkZpNDFsOUdORjZ5eHRKZTFCUjZ1eFU4b0xKL3JOMnJn?=
 =?utf-8?B?ajAzM2VsbXhDM1JiODFBdERhRUQ3Q0g4U1RmT2NMbXQ4K0prTXBvMnM0YS9C?=
 =?utf-8?B?cTRMeTZqNWwyNlFhN3pJbnFrUTQzMUJsZ1dpaXZGUkxzM1ZQdjBGWXZwTXlO?=
 =?utf-8?B?MkdxVmQ4REJaNWlMNGliM2hNRUJxTmR6SWF3ZkdFMHI4dStNaFNYWloyRllw?=
 =?utf-8?B?Zm0yc2JrN0Y5VFRTNXd5YllMaHlJOTZ4ODNseGdQRGlQRy9ZVUxaZGVweVlt?=
 =?utf-8?B?NGZFUWJrbXIrYm9wWWpuZFM1d29QM1FPdDQ1ekgwbnlBNUZnbjhRRWdndWZp?=
 =?utf-8?B?MlJFd0IzU2h5cFRqUFhRY0tpRDVyY1hMZlhrNWhSWVVtZ0FqTXpWNUxxR3A1?=
 =?utf-8?B?bi95bzdOUjlvZ0hRaVdwdzRsbkVaUEREZlVWWEY1R3hJVGhTUTVNUzZJdEk1?=
 =?utf-8?B?MXhOY1pIbjRnc21rYzJGZjBQZjZlRTBHWnIwd0dwTW90dXFwWkh0QnpuSDZy?=
 =?utf-8?B?NnhEcXc1MU5TYW5maXdKV0FhcFZFaVZvR2kzRXNWSXhuZ2Y5NEQxQVRjQWdl?=
 =?utf-8?B?Y01BeTAyak5wekRkWTlGRVVWOXFrTmVHKzc3Vmk1WlNSOVNHcVU5L0U3dG0r?=
 =?utf-8?B?OXRVMEZua2pNaDdOMW5BM0N5MzN1NDJwMTZsSTNiRXYvTk9SYXlvTGxxNTl3?=
 =?utf-8?B?TWdzWW1ZdG5kR2FTRko0UGZDS2RyUG5WTm1FY3RwakV2UnRFeCt5Y1o4MWpl?=
 =?utf-8?B?U3NkeEJoa0pjdlVBajZRSHoyM2VZblJjdnVjQzJmcElqR2oycjFUY2MxM2RI?=
 =?utf-8?B?bzZqcFVBZVk5Tzhhd090QUR1RjlNV1IrUVk3NTVnbXQrNjFRQjQwYzNTTjRu?=
 =?utf-8?B?SWlYeExIbVBCaElIYjlNRVZRMXczYmx5VUlXd1JINFZET2lCNXhpNXp6ZXVB?=
 =?utf-8?B?ZHNWQXFRRThvK2M2TkJuU1BxZmNmekwvUUxJR3poU1RGQ2lZRU1nVXQrSkVJ?=
 =?utf-8?B?SWZJNTd3ZTU4cVZ1cUZxUzJlUjMrLzFTU21DZ09KQms2MkFuWkVHSWhwc29E?=
 =?utf-8?B?TDdNZUpPQWFZOE5NS3FoTUpSdnZhdjhMK2pKN0xPMjMwNmJTSzcrTDBSeHdZ?=
 =?utf-8?B?YU1rK2lQMkpLdndIckJ3SmpNT3NqTnNsbG9WUEdIb2lOdFFSUis3V3VLQ3pn?=
 =?utf-8?Q?S1oubed4oHQ9/feYggmgm/iNt?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 795f1b70-d7c7-4ad5-4d79-08daee6193b6
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2023 14:40:08.5032
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 56ybnUT/tkunGN8A7CQqiXhqnaDQiuR/RJn2IsrgMhWvxk7E4tm5GvyQ0nUz7cOf5FWAMnrJK53ZXeV9VqrP8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6224
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/3/23 17:18, David Rientjes wrote:
> On Tue, 3 Jan 2023, Tom Lendacky wrote:
> 
>> On 12/30/22 16:18, David Rientjes wrote:
>>> For SEV_GET_ID2, the user provided length does not have a specified
>>> limitation because the length of the ID may change in the future.  The
>>> kernel memory allocation, however, is implicitly limited to 4MB on x86 by
>>> the page allocator, otherwise the kzalloc() will fail.
>>>
>>> When this happens, it is best not to spam the kernel log with the warning.
>>> Simply fail the allocation and return ENOMEM to the user.
>>>
>>> Fixes: d6112ea0cb34 ("crypto: ccp - introduce SEV_GET_ID2 command")
>>> Reported-by: Andy Nguyen <theflow@google.com>
>>> Reported-by: Peter Gonda <pgonda@google.com>
>>> Suggested-by: Herbert Xu <herbert@gondor.apana.org.au>
>>> Signed-off-by: David Rientjes <rientjes@google.com>
>>> ---
>>>    drivers/crypto/ccp/sev-dev.c | 9 ++++++++-
>>>    1 file changed, 8 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/crypto/ccp/sev-dev.c b/drivers/crypto/ccp/sev-dev.c
>>> --- a/drivers/crypto/ccp/sev-dev.c
>>> +++ b/drivers/crypto/ccp/sev-dev.c
>>> @@ -881,7 +881,14 @@ static int sev_ioctl_do_get_id2(struct sev_issue_cmd
>>> *argp)
>>>    	input_address = (void __user *)input.address;
>>>      	if (input.address && input.length) {
>>> -		id_blob = kzalloc(input.length, GFP_KERNEL);
>>> +		/*
>>> +		 * The length of the ID shouldn't be assumed by software since
>>> +		 * it may change in the future.  The allocation size is
>>> limited
>>> +		 * to 1 << (PAGE_SHIFT + MAX_ORDER - 1) by the page allocator.
>>> +		 * If the allocation fails, simply return ENOMEM rather than
>>> +		 * warning in the kernel log.
>>> +		 */
>>> +		id_blob = kzalloc(input.length, GFP_KERNEL | __GFP_NOWARN);
>>
>> We could do this or we could have the driver invoke the API with a zero length
>> to get the minimum buffer size needed for the call. The driver could then
>> perform some validation checks comparing the supplied input.length to the
>> returned length. If the driver can proceed, then if input.length is exactly 2x
>> the minimum length, then kzalloc the 2 * minimum length, otherwise kzalloc the
>> minimum length. This is a bit more complicated, though, compared to this fix.
>>
> 
> Thanks Tom.  IIUC, this could be useful to identify situations where
> input.length != min_length and input.length != min_length*2 and, in those
> cases, return EINVAL?  Or are there situations where this is actually a
> valid input.length?
> 
> I was assuming that the user was always doing its own SEV_GET_ID2 first to
> determine the length and then use it for input.length, but perhaps that's
> not the case and they are passing a bogus value.

Except that if the user was always doing that, then we wouldn't be worried 
about this case then. But, I think my method is overkill and the simple 
approach of this patch is the way to go.

Thanks,
Tom

