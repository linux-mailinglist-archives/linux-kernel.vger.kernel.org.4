Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC6BA60B32E
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 18:58:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232997AbiJXQ5t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 12:57:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236146AbiJXQzl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 12:55:41 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93F4A3FA2C;
        Mon, 24 Oct 2022 08:36:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wncv/52i5uwf6ZjHQw9RA1G8hCQgZIzZj9b0hclImJmz0EOw+gB2GadFRb/1TNB4UxLUQI8Mt6fbTc0SWEta0WpWgf4Zegg64B/rBh1u6K/6YUM2FTHM8URcUXd65vb8AFvo/Me35aAPpGGNp2kWF3FCucX/8jGdNkve1gaIsH466I20zFWKWAwHdFXpCMYW2Xxi08XUucLMqE5VW9KK8jycrUj4v/K4YlFS72cbailZtQrLdymqpwoj26FbF0r9jaiIhgL1j4UppNCJxxh8EaOtVm0e8BfIYJPFWCOOZp/x2oNkhj5Cw+nGToAc88kfZdApoRyrCFsq7sTY6Bxmpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ihmx/YPpcZwD7PuLvZCp9yIm+KGilDKfSzSjAIO6KBE=;
 b=VLT4jIyTHUjravSl7rclR9JeJXEitP2cz9Xu0n5FWhbnsH57Od9a1kdLpxf5V0hqhk9nSFKB8URsC0Oqo+gLY56tUwHWpBt4mYpgF6XjkcB3E33k04Q7a5KhipuUar3mzKzDqTc9nBvAzkb+rsxluhQrNKzj5kG2g55BxMBqMvB7J2RP1t18wDAnVF6p1LENptBTxD7xDJDHDvFHBxRWcyLuHjtVQKvqUu+9gml5TPj67DIZ5LFzcLI8tR4YTyzd6RjxueS7mmHYcmN5EcoWt1n4hpGFI8S9kCWrMduK5dArdp9+xfl2Ik/DmvITtm5AvwJ4/I70/STEe0vvMb5vDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ihmx/YPpcZwD7PuLvZCp9yIm+KGilDKfSzSjAIO6KBE=;
 b=Kz0xw7CWDROuEIY5j7I8LGi+bQKApLwkU1rCVr1K35pJEX8LZ8GQzvkIoMYHrC5j05QF35dSrWVHlDHFIlxFbiXbkPf+kT+b0aZ2cHnWEUZ0fliexYyi6vS3VJ9MDqmIbYDFR5XEsclh/lAE9ynaPymuIGVXHb9RZs7If1e+GAE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5874.namprd12.prod.outlook.com (2603:10b6:208:396::17)
 by CH3PR12MB7762.namprd12.prod.outlook.com (2603:10b6:610:151::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.34; Mon, 24 Oct
 2022 15:33:59 +0000
Received: from BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::9eca:d454:d407:7ba2]) by BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::9eca:d454:d407:7ba2%3]) with mapi id 15.20.5746.026; Mon, 24 Oct 2022
 15:33:59 +0000
Message-ID: <c4abb4f2-dfa7-e343-7567-8e7bf5f2223f@amd.com>
Date:   Mon, 24 Oct 2022 10:33:57 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v2 1/2] Documentation: Start translations to Spanish
Content-Language: en-US
To:     Jonathan Corbet <corbet@lwn.net>,
        Matthew Wilcox <willy@infradead.org>
Cc:     Akira Yokosawa <akiyks@gmail.com>, bilbao@vt.edu,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        miguel.ojeda.sandonis@gmail.com,
        Federico Vaga <federico.vaga@vaga.pv.it>,
        Alex Shi <alexs@kernel.org>, Yanteng Si <siyanteng@loongson.cn>
References: <20221014142454.871196-2-carlos.bilbao@amd.com>
 <48b4a5a1-2a52-4159-699b-9db73a012892@gmail.com>
 <Y01pkubcT7FOwCjL@casper.infradead.org>
 <8e2a1da1-2914-b223-85b0-a769339d9c39@gmail.com>
 <9e65ba16-68d3-8d11-c6ac-c35c29026688@amd.com>
 <Y1aovvn7dAyo1nuW@casper.infradead.org> <87a65lfdqb.fsf@meer.lwn.net>
 <875yg9fdbm.fsf@meer.lwn.net>
From:   Carlos Bilbao <carlos.bilbao@amd.com>
In-Reply-To: <875yg9fdbm.fsf@meer.lwn.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0448.namprd03.prod.outlook.com
 (2603:10b6:610:10e::11) To BL1PR12MB5874.namprd12.prod.outlook.com
 (2603:10b6:208:396::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5874:EE_|CH3PR12MB7762:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a78501c-b418-4050-1f81-08dab5d52bf2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xAAqUHkfeX+ajilB0alUHIb/gxkdEbMj6n7FWXcZc7YfEbA3olZ9pXrbozaAyY9iAg2mr5EBIUuxlprSTVnkY7iQsU6j8lSetMIbN+sQOUtyQFnZoHpEIHvu78Bit9vtuJdcnmR94P5/eTM3mnzfweRCL+ol1yjuXVcPD+FqVI1N+vSHY5Ildz+poGu2NH2S0sZkiNvNx3EhJTdb95Vv3CMXmrtMlomzRPrhwDZHF/ylgCzKa/NRg8zRUyoyuX7gWTWV2CbHaN5IXVUDBW1SzKTSRiVJKp2ywnPilEcS0E8y8lIHjyR4/mUQpebZ/JRHaK9oMX6f+xRT19ht5d1ueHcHPmMqcuFohO/2ou0Y7uRn6T6COyZwAjU+knxF+ZWJCXLLZuhbGxz32quJdxveeFq3j1emNKP/87K1YL7NId9CZ8SKMLy+3jpiHv1rVjERDt/TQETLA7/nMplDU1MBeHSvVXchnv7Jgdq+MQiTj/x4UeEGQdnC9J4OjCEv8kULWS0amZOljkcVA82wDsJN2kkIMR8viWtneV7S08Ser90XFPQcQ/ogmmAHDE1d0ZgxPkZpimmMOHsMC4LFfAQ9MgD95xem5URfvC3fck1PPUkzn39EDfDXyjQS+Yat4yqUIaqgQqqDU8WzFfeVDUSMYRDkoc7UdMegHR2s7HjPeVAuwMG4vBswCd0m+XJcJO7yS/2Y1USKG1XsKHzwFU62IgTrWrKe3Ql+6IjVhamQT4VP4LkF0KPtRYGKf2DDkp0YamWQVR0zoIK1cCmmve3BXH7u+fWCxp+1WgwEWbqOIop/+MfhSPfAiV5vpJ7RWjbPcnv+r7pr5ir+1So06M53Mg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5874.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(396003)(136003)(376002)(366004)(39860400002)(451199015)(31696002)(6512007)(26005)(316002)(86362001)(2616005)(66946007)(4326008)(8676002)(44832011)(53546011)(186003)(6506007)(66556008)(66476007)(6486002)(5660300002)(36756003)(38100700002)(31686004)(7416002)(41300700001)(110136005)(2906002)(54906003)(966005)(8936002)(478600001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZmFOUFVTZ2cxR25CNGpvNEhBdWI2dVBtRGswUFg3YVpVQ2FhNHVIYTZlTVhj?=
 =?utf-8?B?MUVtRmNXcmlMbm4ycU5UVXI3akpYVmZUQjZGcnZxdGF2dFR5TTlXOGlKQVZi?=
 =?utf-8?B?K1VqUzU5Z2VhWmhEdTQ0alpyRzdobDcwVEM2QjJQWGFWY1pqYXZCandxLzJR?=
 =?utf-8?B?YWRWMlU5UWl2ZDMrUkluS2pCWWlRckJxUVVwSFR5Y1R6cXhCUHV4QjJwMWlQ?=
 =?utf-8?B?NDlsem1kemEwY0pldjFkYTRETDRoZ3crQUNPODQvbUpIeXdDc3dOT3FOdVl5?=
 =?utf-8?B?eUV4Y3BPcHZzdGxJaG53NzJvV0hqS0pxYkJFZHpQZnRwUEJlL2JOZnRTR0J2?=
 =?utf-8?B?N1pSaWtDQi9vY1VvakZIQUNremVlTDVCK0dJVFd0Y1NXN1JJMFJYL2xHQ3Zq?=
 =?utf-8?B?eXRvVjdlcTdaa3RmOVF5eDFFOE9FMm1nVWQ0b1RJZE4zRW96aVp3WW5pM0Z1?=
 =?utf-8?B?eFFNZXh1YWRWVGtFSGx5ek5lUjY1Uy9LTlFyOFN5eXZvOEpjZUg5aXlFR3lr?=
 =?utf-8?B?dGx0T1gyU0VFTVNPU2dVU0RRZjJWN29YRHowWm9wdXBOcTRaUTVhUENPbDZU?=
 =?utf-8?B?M2N1Z0lPWjZ5QnpwM3VqUGlOWTNYbDJEd3lJa1cwV2p1OENvdWRuU1F3akZB?=
 =?utf-8?B?ZUFGQzFDa0pvUXJzMmI1dWFsU0FUQlU4WE9Ec2ZsemcvdkgxVXViSG1mZFVn?=
 =?utf-8?B?VnJaOTZvcTYrNWE5R2NhSEtYeWZkUWpvM1lMMlc4Q2dQY0xIMTVmM2p4eUpH?=
 =?utf-8?B?Wlk3cUdHTkFkamtUem9jUTZVYitSMU1RTnEyL0V2aDNhb0VHczRSaWZscFkw?=
 =?utf-8?B?bzljZkdoYkloc1ZxbDVjYjFCYXJjYUM0TW5RUmhrdjdmcDhQZ3JsRElabWEv?=
 =?utf-8?B?V1JkbmZqTlQ1UGdnbE9jV00wKzRoMkM5TTc0UVVFVFpGYUhMZXA0VHY3NFhL?=
 =?utf-8?B?L0huWnU4cFRsY2xmMjdZUU1wVmtEV016NXVkTjNBNEtUelRDTzkvTElEMFJa?=
 =?utf-8?B?c3lGUnJIRFZFQnFtd1lXS1BKVGdhY2lIc285MHUzanlLVlFlNzJpazAzeUhO?=
 =?utf-8?B?b1hHN1BSYXdFUVNUcVRhSXo5QjMwRGZoTDIvR0JLNTRjcEtuK0pneWtnY1c4?=
 =?utf-8?B?K3RxbXhPN3lKWTk4SmlOaHhQMjJjMnFmeEhxTDFJZmd4MkloZFZQRlJIVTND?=
 =?utf-8?B?bUdUN1ZkcEFHSHhWTU1GWFljRFVTU0tDVUkrODhhaUpiNTJ0T0E5dUxsbVMw?=
 =?utf-8?B?M0ZTYnlkZWtYVTdkN0haZVVLdUxhc2tnektzRVRUUEFyK2l4UVYvL2dHTXlT?=
 =?utf-8?B?YnZld0lBYlRaMk5PZTVjVUVxTTJaaUdTUUVLcXpTUHdtTWYxVVpCYlM3QUlZ?=
 =?utf-8?B?bnVpUTV4VUovOEZnR0h6TW9xS2F2anpWZlFhMy9UNmJpWWk3dFMvQnYzWTBq?=
 =?utf-8?B?UDVxSWxuaTRQOFNLeHVyWW1XdWgyejhobzU4K2ZxNFQ3RzlUUFd5RjJjMW5z?=
 =?utf-8?B?TEFmTFZQaTZ6dXRkS1Y0ZHlnTGFUVFBnWjVaTlEwcGg0Mk1vRTV3Yi9LTlNp?=
 =?utf-8?B?czFtUkNvMzBlSUZSdS93K2NrRUtSUkdFOGhwRzBrMVloT0ZMemdJWXIzd29k?=
 =?utf-8?B?UDJ5eEpMTGdzbnZEeEI1aFFnQk1uTjFaQ2paZSs0cUlHTVR0YkFTTlJMMUdy?=
 =?utf-8?B?ekJraDU1dzBNSDZ0TnVlYmFlNnozcFBKMjZoZWdhSU42VDBFUXB4ZHNJZGx1?=
 =?utf-8?B?YUlVajMwNTJ5MnJLOUI4Qk1ZVmlYb0kxOG54a09VdTliS0hUQ3I1Z2dFa2x0?=
 =?utf-8?B?TUd5M3NacG12U3ZTZ1h5YmN6NUcrdzVMaUs4U1BML1JDODNVdGZGd1R2WkdE?=
 =?utf-8?B?WjJhS2lQMFQ2ejFyWE1tUUNMVXN2NW04REFtaitETHFCdC93REJiYlEvSmNy?=
 =?utf-8?B?V0pac1hocGlrb1lWWVVRMmVFb0R3WG5YVzhFNllaY2xiaEZJc1VncjlBVlB4?=
 =?utf-8?B?aXkxS3lOMnIzVzR0ZDFCQmVZNnZ3VHVQMlRpb2JzQjZkbVQxTG8yd1lZeU4r?=
 =?utf-8?B?TzZqTmM1RzZMaUFlU1pyS0dQZWV6SlZHanVRUm9MSW5ad09wRUwrMDdWL1ll?=
 =?utf-8?Q?VarVDnGQrjAcAjNxphbUxztq7?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a78501c-b418-4050-1f81-08dab5d52bf2
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5874.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2022 15:33:59.7702
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dfb9Xt618o/wKTfawZhsNhL1ZPWa37zoqoKZ2VRhXJIgK0fgyY3VCkqdpI3+heF0bnHPT/41UynzNZCXyxvCAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7762
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/24/22 10:31, Jonathan Corbet wrote:
> Resending without the screwy address that my mailer decided to put in
> for Alex, sorry for the noise.
>
> Jonathan Corbet <corbet@lwn.net> writes:
>
>> [Adding some of the other folks interested in translations]
>>
>> Matthew Wilcox <willy@infradead.org> writes:
>>
>>> I think we're better off following BCP 47:
>>> https://www.rfc-editor.org/info/bcp47 rather than the libc locale format.
>>> That will imply renaming it_IT to simply "it", ja_JP to "ja" and
>>> ko_KR to "ko".  The two Chinese translations we have might be called
>>> "zh-Hant" and "zh-Hans", if the distinction is purely Traditional vs
>>> Simplified script.  If they really are region based, then they'd be
>>> zh-CN and zh-TW.
>>>
>>> I think you're right to conflate all dialects of Spanish together, just
>>> as we do all dialects of English.
>>>
>>> Jon, this feels like policy you should be setting.  Are you on board
>>> with this, or do you want to retain the mandatory geography tag that
>>> we've been using up to now?
>> I want to go hide somewhere :)
>>
>> I'd kind of prefer to avoid renaming the existing translations, as that
>> is sure to create a certain amount of short-term pain.  But I guess we
>> could do that if the benefit somehow seems worth it.
>>
>> Of course, if we're thrashing things, we could also just call them
>> "Italian" (or "Italiano"), "Chinese", and so on.  I don't *think*
>> there's a need for the names to be machine-readable.  We should stick
>> with ASCII for these names just to help those of us who can't type in
>> other scripts.
>>
>> If asked to set a policy today, my kneejerk reaction would be to leave
>> things as they are just to avoid a bunch of churn.  But I don't have a
>> strong opinion on how this naming should actually be done, as long as we
>> can pick something and be happy with it thereafter.  What do the
>> translation maintainers think?
>>
>> Thanks,
>>
>> jon

 From the perspective of the target audience (someone that wants to read
translated documentation) the name of the directories do not make any
difference; index.rst lists them in human readable format (e.g. "Traduzione
italiana").

It would make sense renaming if there was confusion among developers, but
there isn't.

For these reasons, and for the obvious inconvenience of renaming things back
and forth, I would say do not worry about it, Jon.

Thanks,
Carlos

