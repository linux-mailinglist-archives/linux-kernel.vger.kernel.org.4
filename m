Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BF63691024
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 19:14:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229735AbjBISOW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 13:14:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbjBISOU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 13:14:20 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2081.outbound.protection.outlook.com [40.107.237.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2DC1A5D4
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 10:14:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BXx42lmy9p7aiEKcNFy2R/zrBkdzXOAVrCbM5YE2mv9kiqHOyaj8cdPOy4E9ELZbMfc7fjfrsziZ+++uVHeDop01+hluMy1+S9uGdztAH6cot86mYfqfHKCx5fJmQS1lEz8lxtNkHh2l0VB5+3RNPWhdOqWWIGYYgZyDN7Jgu60KAX9hn5NywEgWdYlpaLpCeCwtzLrFM4xttK8B+LxPwXpBbyx5V++D3z61TaTM8kiWk7cygFs5mMCpjXj18y+5+ElmmgW0nruRzsliPylbTX8cTyzKwQdcFG2yX+fN5s3/fGdDONf2ScMzrio2CBYJVNxrRLUsKjKyUbJur0GRAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JZQiNs+419Pph2N9ksyrW0Em++OmnJyNkqilRas++54=;
 b=YsXNZ3JkGnK1rgEB9Be/kd8af/umI+6/Ny/A91ioWbdaHxikHsNMMRK3B7FVSK19nYi0RJTMmm0I7rM2KQM90cd9FJ1GRHPmnTrFCgKjGdZ7tnOoP9RkH+EJAjkSHe5Y90PuubuTSrtAThH2GkPPXLb1ykE1ZH/tDTUTRB7qlYpdefGzEV4Bn3pJSbTLcQVpcowWVsujQRyTz8W+vArxclg9TkHGDRM3uHYXS3b7CtovOM1GPobvFZxd01CY/7tmHXotfZ5B3+7jiIgNTF1cPbQFAtQySX+ufB1alWWr/K4ALGDy35VrDDnkdXMYAytzK9cUm2uDn2RaZc3n7GMKjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JZQiNs+419Pph2N9ksyrW0Em++OmnJyNkqilRas++54=;
 b=eZAnv+LYGUwfoycAp2rErBDcsMUDkkazLJYKDfMhxIxpyStCpPXjy97TAZ+xC+FCNoY6bXfrVTacsL9tCHgA11LpPnlsFb6R3lLf/XLWAga+PDt1fxJ6pT+BZI1Fhlu2ImdIX38eGWfWwFIbZBu3bIlv98NjDA5pzIxXKDXSOg0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5874.namprd12.prod.outlook.com (2603:10b6:208:396::17)
 by DM4PR12MB6400.namprd12.prod.outlook.com (2603:10b6:8:b9::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6064.34; Thu, 9 Feb 2023 18:14:15 +0000
Received: from BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::f29:b74e:c400:b24]) by BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::f29:b74e:c400:b24%6]) with mapi id 15.20.6086.017; Thu, 9 Feb 2023
 18:14:15 +0000
Message-ID: <e309f543-5307-65a9-e5c9-c2a82a17eb89@amd.com>
Date:   Thu, 9 Feb 2023 12:14:12 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] uml: vector: fix definitios of VECTOR_WRITE and
 VECTOR_HEADERS
Content-Language: en-US
To:     Anton Ivanov <anton.ivanov@cambridgegreys.com>, richard@nod.at,
        johannes@sipsolutions.net
Cc:     linux-um@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230209161916.3729757-1-carlos.bilbao@amd.com>
 <874b2d0c-3500-5c1e-07cd-74f9e91d92d6@cambridgegreys.com>
From:   Carlos Bilbao <carlos.bilbao@amd.com>
In-Reply-To: <874b2d0c-3500-5c1e-07cd-74f9e91d92d6@cambridgegreys.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR03CA0068.namprd03.prod.outlook.com
 (2603:10b6:610:cc::13) To BL1PR12MB5874.namprd12.prod.outlook.com
 (2603:10b6:208:396::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5874:EE_|DM4PR12MB6400:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c80126b-d255-4775-08e5-08db0ac97392
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tYOqqbRMJkY7S5DYoQ7jCcLeHwTqmjM6yiZJG3B2TVKDAyLdr0tTgyo78q1bW4mwkhJpy7Tw3N6Ww/fKn2wHANQTk+lh2OhyK0QtSxg7X9+cDn/aN2WiEsufSsXxk43XZf9/PonilXYUXRwXKPnbxrIRKYoTqjnWLNCI65nMRL+R9ZxSWIdlhNh5g0c41q/i+qDAG/N34/BTAokjACvMehTfy2QhUeLFFL5sIKYNkGx8XZlO/m6yFcab1n0vgrOil17W4DXgbGbYlfsG8YrzdmmG2OZ1VsPnQo3NBM6ZfYLF+c6j96NwgwhI4seeg/TK9LBHYWbVoA5HI0H9W37D5JgqpJ5sXphyBEWrYrRjsHlnzj5oWZ9mFtRyjf580B3eyJj3lHJr+GG/FqEZHFNls0s5C8+Ai1tkwH947AbUxcIGfjNblvsDRV6fMYEnebFz9TUphOyjQ+zOq1J39myCz1WIfbuS1VISSNr5MM+TEMjCalwFmYMlgyx4jAYcLbf1lAgpEE3ubaRwffZ84aVWYOqwvoo0cBa+z9A61F8zfupCg7PJQLibQOdDZqNesY7QuXKMtYFiLc1zfe85VsMYknG0+BfSffRuBAGbPI4f9Om3PHe4V92gWd/mc5fQg1P1zWcN7tDzMWHZOJIL0LwsgGqVy6ViIAwOyflLJxiDps7RHXP1xHjViHOqikFKeNcGLyDHqG/I+2tNk+GDD5GnN+vxGrgCJky8tIbDNOu1K6U=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5874.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(376002)(396003)(346002)(366004)(39860400002)(451199018)(44832011)(4326008)(38100700002)(478600001)(186003)(6486002)(6512007)(2616005)(26005)(6506007)(53546011)(6666004)(31696002)(41300700001)(66946007)(5660300002)(8936002)(316002)(8676002)(36756003)(66476007)(86362001)(66556008)(83380400001)(2906002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cE1ZN3FUbHM2QXJhdERXenNEbExLcnhWMC9jYXdLdWZRdG5VNHZ4NDkzMGw1?=
 =?utf-8?B?Y1l4dmoxcWthaERQblRZNnNaZThiOU1jV3BIUWsyU0tGdzJVRUV0WGUreU0w?=
 =?utf-8?B?OTgrQXVNejN0bGFZTER2VDJNNkRJSi9EZ2wzRjd5eUlGNkxPY3E1VVpYVTBk?=
 =?utf-8?B?WTdMbEZMN1NCUHJrM3NaQktoeTNFOVpYSlpHMjYvRG5FU0V2NXVvS3ZuWTFN?=
 =?utf-8?B?WVNhRVpnYVJjNExuMTM3SDhRbVdqaHM5U0dLTnBJNUZybER6djYvTjJYWURo?=
 =?utf-8?B?c0hpb1VGN3ZRbTd4TlFVSDcxQTE3aXdNVUh0MDFPRlBGVU1hUWNJSmdGTkdM?=
 =?utf-8?B?ZGtSTGRxUmZsdkN0aUJKajR1cm9KVE0xdkZYa1lnajd5Q1hqVjdKMFdvdU1j?=
 =?utf-8?B?R2hiTDAzbGZDaTBxRXBPRXFNVmtrQTIzUVAyYURWSEVra1JlTTNGeG9BL3lt?=
 =?utf-8?B?b0hMREhIYXhDek5JRmtLdk41eTllN3loN0xldmlxUis4S2ZTbTFBWkF5Q1Fp?=
 =?utf-8?B?UjJnSTZxaENtSGpLSEhUYzJCY3l2L3daM2hyc3l6YlN4YitMUU9PaERhL2tp?=
 =?utf-8?B?QUhYVWtRM3pWbW5UNmMvLzdkdC9jTE9wa3EvV2FWdjIxVmV0Q3Fzd1RFNzFw?=
 =?utf-8?B?VVBWUG5Ic2xkc0JES2F0ZUxnUzd6bGFGaHNRUFV5SHRRWmpHb3BWQkVESW9s?=
 =?utf-8?B?Uko5TUNQaVh4ekZrbGpvNVN0Q1F2Q3pFZ0x2SVFaWVZHODcwNkh5OFBOMnRB?=
 =?utf-8?B?M0NkanlRZ3ZjY001ZDZrWTAxLzRWRDR6VDZscngxU0dJNkhyRkE5Q0J2MXFm?=
 =?utf-8?B?RFRYRDlLaDdGNHpLa0FVZU9Yb3BEWnlpQzh1SzZJdUtCQWtjbVNLRUI4NDJU?=
 =?utf-8?B?Z2NNVW80L2dXcjlwZExCUWhpNitYSCs1bzVseTBSNmtGNXNpaitLbG00K1Br?=
 =?utf-8?B?UWxzdFFMdms0eFNnc0dSU1hVdVVaM3hqd0dwckpqb3dJYy90SGZZck1NK01W?=
 =?utf-8?B?RlVxNjBxQzdzd2FYaHZycTZMSnduZDZnRU5kaENNb0dESHZ4cXF6d2lVQWxV?=
 =?utf-8?B?UzRNaU94MFZRd3VRVnR6UkpBVTdoZUxxbzJOc1ZZZE0yTnVtd1ZMcERNQktM?=
 =?utf-8?B?dDhJYmt2TW5Rc1QrUFBiVmVyc3gza25LWGo1bWM5NGs2aGM3S3JLaXY5dTBT?=
 =?utf-8?B?Yi9GU2FabnZBZHlGc1VMV2J4cUtUSElqRDBKNnlSY2ZyeTdqbUVPcWcyeDlB?=
 =?utf-8?B?T1lUOHpLUDgra3FNZVBvQ3RGQitXeVZ1eHpXeDhEN0owNjdFbjM4RTlNUk9D?=
 =?utf-8?B?MVFXMmpvakZUc2NpOFQ3SzZtL0hDWmcya2ZmZE1sRk5RVnVERlZ5SytpS29p?=
 =?utf-8?B?bzFjRGx2dnBTRTZad1ZPRVFQRWlyMnM1OURzZ20wL1hqUEZhQTdReGhLZGVa?=
 =?utf-8?B?YXlJM1pwUytZUlNuWjMwZW9VNEU3WXN4VDBNNXovRGVzOHRFMitoeVVhZ0gr?=
 =?utf-8?B?Q0dOVjVEWHlQN0Ric3hSTHFaMGkra0RmU3Q3MDNOejl6V29Pb3VXdGhTQzN1?=
 =?utf-8?B?YnVYR2NRdnU0YVhjdFpVMFduMVNHK0xwMGZ6QXNaRUs3UlhnSVlsQVFESGtw?=
 =?utf-8?B?Mk5WbnlwKzlqQWZ0b0hxUnE1aC82Yk1id2w4d0lhM3M4d1JYSDBLaFJ3cUdQ?=
 =?utf-8?B?RlQ2RHgrTHpnS25nWjV5YnZnMlhCeXlHNmZZNkdET01aMHJaMFEwQnpJSG42?=
 =?utf-8?B?ZERsVytuNUZiazhaSEdTVXVEY1NvNHIyT1g3VnI2SU1iTURFTWtkQkNONVNx?=
 =?utf-8?B?NllodU9HZzJaR2h4T096WkxrVDloQU9HYXZac0dCZDNIcERXTnlJMDcxY0JW?=
 =?utf-8?B?U3JOaWQvNGNwbTA1L1ZYdlorWXdkRE42R3Fpdk5rK1NTYnEydlMwdXZEMUdP?=
 =?utf-8?B?clB3ckJ4SFV2U2NaemdqcllDNDNXRFZqd2ZmV1owOHlUeVNrQTgzek1HczVh?=
 =?utf-8?B?ZlBPVFFkUVZMQi9HaXhrYkNtMWFicEp5eTFFbHB6ZjF3bzJWSGM4UEJ2bnFM?=
 =?utf-8?B?M0J4SjJkbkw4ZWNLVldkQ0RSc3Y3Y3pzQUo5SjhzMzU4ZGc5Q0hKaWR6TTVU?=
 =?utf-8?Q?jkcqOPFaMcvEjPd4UAWu5Or5r?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c80126b-d255-4775-08e5-08db0ac97392
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5874.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2023 18:14:14.8430
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DtGdjTJcK0PIlrXY9PHo06Ug3ROpYFjSkRJmmsgoiW14GwFVfc3JfWUpzbZlhGkiktp9GeDe8oEytMg+T19nsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6400
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/9/23 11:33, Anton Ivanov wrote:

> On 09/02/2023 16:19, Carlos Bilbao wrote:
>> Fix definitions of VECTOR_WRITE and VECTOR_HEADERS with proper bitwise
>> operand for bit shift.
>>
>> Signed-off-by: Carlos Bilbao <carlos.bilbao@amd.com>
>> ---
>>   arch/um/drivers/vector_user.h | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/um/drivers/vector_user.h 
>> b/arch/um/drivers/vector_user.h
>> index 3a73d17a0161..f7d3956f5c15 100644
>> --- a/arch/um/drivers/vector_user.h
>> +++ b/arch/um/drivers/vector_user.h
>> @@ -68,8 +68,8 @@ struct vector_fds {
>>   };
>>     #define VECTOR_READ    1
>> -#define VECTOR_WRITE    (1 < 1)
>> -#define VECTOR_HEADERS    (1 < 2)
>> +#define VECTOR_WRITE    (1 << 1)
>> +#define VECTOR_HEADERS    (1 << 2)
>>     extern struct arglist *uml_parse_vector_ifspec(char *arg);
>
> These are no longer used. They were used in some very early versions 
> of the code.
>
> They should just be removed instead of redefined correctly.
>
Ack, sending patch your way.

Thanks,

Carlos

