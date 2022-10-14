Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 544905FEEB0
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 15:33:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229595AbiJNNdO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 09:33:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbiJNNdL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 09:33:11 -0400
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2097.outbound.protection.outlook.com [40.107.249.97])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 499B91CCCD6
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 06:33:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J+bPI1eJZ+QL/Xm+K6PQLlipWk72PxF9IFstk5379r/SNc9FEqfNOXanLyYOKOaYN/G7n/NENKO0iuz4WwU7iL7hUjXF9CmnUZ44HJ1TBKZ/Y/WuotuaoTlW4ZW1qXiUFVW5Iwg2EuE3jHjj438kfinx4wmwEylgW5Rk5oukAHqaofyB4XnOr7wNsFrdQaeTU7vsOXp+pnOyONNrY9L33EENLF+nhiOoEIkm36m8Y1mjOpxkDTalBYoTOMzr3LZpQkf78veuhCBrNuxGM+4GDLDKlx1gSOfhzgRPg660HpmtAn/7qtGNOcV8ImNX5yAHq/FxGPV7Ci99Q+Ruyd/nNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BHYgyoBKJZsw1XJxME5OSnKp63bXzBi0zpLSny3OdI8=;
 b=RHa0ahv2NYL7JhDp39I+NUwG49/zYYxmx2J1B8W2B4bSUbP5OLZr+Tgsp0sWbr4/zsuvZKPLmxcLELhWeTyKzSxjPljYdGXBc4Q7QJcle/bqiWL1T7kSbbYNUgGX5E37jUMN9qoT5Slv39JuBz9VRHG5LdC+h7CCN+JuAmoOQwkRrqY0lmVT6r9f01C0IYUs1VrAmtAe2qISpddyIu5G0Ogc99ssljH0mTJqz3LM6rJoQGnhNaW0nHNUhYQibwgnpE7+n239lXgJ74VS7umH4TrvgNQWuc0/sMpmqw5PNJROZciCzwL6EldPPNKrdpjmmZkDBcEu0b1M5+0Ulw1tAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BHYgyoBKJZsw1XJxME5OSnKp63bXzBi0zpLSny3OdI8=;
 b=FnVT8Q4xAGxLLJcqR7mGNC5GYhgEer/E2zQvovq4OXRHvNcb2TvZfxaKtYQpUS5QSdWb75hgo73+v/fFaQN2tJroAEmlaK2p1VwXB9/7p9VCTk1dBJN+wcdL3ZyGDLMaj0KQs0txCtjOunHtwfieXnYMhc6HJewWrpS45S2Ja9Swi2C0CIYvB/2xpmqWJkLCDk7q/AYkIpv7GAgBmV1vgVchwHT3QrGkv4n9jFhC3PLrpEKa9SeEPOb6mpQfn8+8f0xYA6HcL7JpGennZ3gWA6mF4Do99wYikZggd30bxuQQNIsCa3EWcok+m/7GKKHFwXtB6N2s6XQ5x1kWF+NJsA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VE1PR08MB4765.eurprd08.prod.outlook.com (2603:10a6:802:a5::16)
 by DB9PR08MB6540.eurprd08.prod.outlook.com (2603:10a6:10:260::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.29; Fri, 14 Oct
 2022 13:33:07 +0000
Received: from VE1PR08MB4765.eurprd08.prod.outlook.com
 ([fe80::6809:fef7:a205:b08a]) by VE1PR08MB4765.eurprd08.prod.outlook.com
 ([fe80::6809:fef7:a205:b08a%7]) with mapi id 15.20.5723.026; Fri, 14 Oct 2022
 13:33:07 +0000
Message-ID: <5b1e0a13-8018-630d-d512-c3033db2f2e3@virtuozzo.com>
Date:   Fri, 14 Oct 2022 16:33:06 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.3.2
Subject: Re: RFC [PATCH v4 2/7] Enable balloon drivers to report inflated
 memory
To:     David Hildenbrand <david@redhat.com>,
        Nadav Amit <nadav.amit@gmail.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>, kernel@openvz.org,
        Linux Virtualization <virtualization@lists.linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>
References: <20221005090158.2801592-1-alexander.atanasov@virtuozzo.com>
 <20221005090158.2801592-3-alexander.atanasov@virtuozzo.com>
 <88EDC41D-408F-4ADF-A933-0A6F36E5F262@gmail.com>
 <a8ce5c48-3efc-5ea3-6f5c-53b9e33f65c7@virtuozzo.com>
 <42C75E59-696B-41D5-BD77-68EFF0B075C6@gmail.com>
 <d55338c4-d15f-14ec-c057-806a5d5aa618@virtuozzo.com>
 <71E14334-CA3B-45FB-A854-7A8D6649C798@gmail.com>
 <b7dd38ba-9ff9-6b4c-2460-d4b1ee3bb3f0@virtuozzo.com>
 <1118F098-972A-4F58-8EE1-270A06E4F9D1@gmail.com>
 <7ba328e5-3bc8-cb22-f00c-eddb8aea9a06@virtuozzo.com>
 <063efd58-8373-90ea-7c5e-9d0e9161d2ba@redhat.com>
 <04e5a2e4-052d-0f80-d642-4e104307f38b@virtuozzo.com>
 <72e535ce-80eb-a02f-970c-6a9c80da0a24@redhat.com>
From:   Alexander Atanasov <alexander.atanasov@virtuozzo.com>
In-Reply-To: <72e535ce-80eb-a02f-970c-6a9c80da0a24@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR07CA0205.eurprd07.prod.outlook.com
 (2603:10a6:802:3f::29) To VE1PR08MB4765.eurprd08.prod.outlook.com
 (2603:10a6:802:a5::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR08MB4765:EE_|DB9PR08MB6540:EE_
X-MS-Office365-Filtering-Correlation-Id: f6f9543a-d3e6-4510-b839-08daade8a144
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 540OxPJpE1IQEy3zlL31tJpTMVorlfNGjcQqpeco3NE8DRAWfOYIatpVWfmzva+luP5b+azSFQ8gn9aoRwflIxXc2+33jX+kpVFEteTvmCPxjjnzC8PH2A1dkBgvSnwHPJZLlkNDkUzDZWuC4wNhewJ5hXMeG2H9EUOQRSATvTpSlZkA6fTJo1oqtsl+kdoLD53EnvBOtMZLad8YKEEDf7kEZP2wNeNhHJVJ0bzIXKMU+PXFc+BUBi2gf8QLjV/5wpzAV3jur0nzv31UnqkVjQJ59NT7uScjsSt+73ADp2e4iNzAaVxcrA0ENzqNP1BvZBxaXbJsyM3WjlAPHsCdBAHWwJ9/n6G070xRxT95ypleifX9Ny3YlPy99PhUgQKYVKVWYramai27/RWV18di3UO80g4tGXoQBJh71+TKua4lhNa73k7hGCZ3wR/gdzm8PxL762cGiy6Rx0CdmCxDEm+mxuaxHPVJqcnEgs2j8oQevU9YhkXDMyDzeyv/aaEJmDD+0ee9xokGmokfkbzzGS98v7TTpaw7U6i40jhmk6lBllTbutKingHDUwKnCWX3fpDst3fP2a+MuhCFqOa+e5vRhRubMEdqTcEqi9ef7ensMiqbIUz+vypUvSTgIfkjXjEEtpGdO4N1VvLQSbJLZ6BbmsTDCIJpC+I3S7WsKDtO6mkrByfRcxB3x6hsO5+uhBrojYtpkoYnLj9gazvbO2vaYdatD3zr1o+wCvNWwJ+HV20SL+zmSDn5+J9U9eQCRaNINJxPMQNoQmR7rVTns5AF6y4xaVNdl1lwSD2kdnc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4765.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(396003)(136003)(346002)(376002)(39850400004)(451199015)(6512007)(26005)(41300700001)(53546011)(8936002)(36756003)(5660300002)(6506007)(4326008)(66556008)(66946007)(8676002)(66476007)(38100700002)(83380400001)(31696002)(86362001)(186003)(44832011)(2906002)(2616005)(478600001)(6486002)(31686004)(54906003)(316002)(110136005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dDdUUTAwZWxhMDh0NllsaG42SmhhVis1VzlhekZTcU9CK0tiMDdxR1dTdUpP?=
 =?utf-8?B?N3ZIWk00MVZZZ3NUdlFkcUlpMVQ2V0Z4NUlWWHFac0ROTlVFOHhKNlAyUWFV?=
 =?utf-8?B?UmtDMWFpTHhZaFc0K3RpNlE2dlNjVGtEaTJVOXZMd1p3Z3RIL2QrajdCSW5M?=
 =?utf-8?B?Vk5lbnFIYVcyd3BIN2xFMlUrT0QxNUU5elNqRkZRSGZrV0pnS2o3WlhLR0Vj?=
 =?utf-8?B?ZmVCb2ZIVm5hOWdSSE1YUjAvMmJBTjJ6UDBySnRFRlZVNFoxMThXWmVTYWM4?=
 =?utf-8?B?YTBYa3VDOFQ0eWNOTlFOUi9TNGt6WGxKY3JQK01KWjFYbk1XMjVyVVNJYklC?=
 =?utf-8?B?eHhEeVhTVUQ4anlpVDBGR2pwTE1CSEZFNUpPdktMNlBpMUorbXNSaWdaYjA2?=
 =?utf-8?B?MWlwWmZFWG9kclhBbll2NStXNjdpNUxsZnc3NUZVVTlMUFVaUUcrN0gvQkJw?=
 =?utf-8?B?MXAvWC8rYmJkWk1NUmN0ZUN3bDJ2MDZzblp4OTNvbVhtSUFXV242WndWOU96?=
 =?utf-8?B?dk5rRTBIK1VMVXowQnhYRUFnVTR3eTRTb2hRRWR4SDlMS093cHRnNlB5aldl?=
 =?utf-8?B?VmR0UnNMNUoxb3NBeHZudUp2Ym5xRDlMeFlTb0dFN1JRbTZEVkFBeDNWSUsr?=
 =?utf-8?B?MFRObDgzSnRlK1djL3psRGRWVVYrNWpsdXpkYVpmaTkvM2hPM2Z4bUJZVW5m?=
 =?utf-8?B?Q3c4YnllS3o4U3E5QURIN05FaE5XeE43Y2lIK3VIclRjeDhyTjlHTkZIOElF?=
 =?utf-8?B?aGkxTXJPbnVNYUp0U2ZLN3h3aHREdjNNcllvREZrSDFEWndPUWNoRkdNc3hV?=
 =?utf-8?B?aTBIaXRwNkIxOXFYQ0dLMkpnS2NTOUNtWUN6TVFBMVBuQmJtdXZhMk5FWEZI?=
 =?utf-8?B?Q25OZ1dpWG5SQWl4VXpxQXd4Uy85NnFtaEZrdGFOTzhBRlYrUGNwWVZDakVl?=
 =?utf-8?B?b0RlVjljUXFDUnJtaE5GTi82NE9MWWVnOHNLdFpRTVFFejVaSWloTGU2bjlv?=
 =?utf-8?B?LzRSL0NKdDdIMWNjWTY0L2UxOEZlYzh6Vkl2ZGhHcGhKOVVGZll1Zk93eDlP?=
 =?utf-8?B?dTQ5TzNiOFVzUXBvRko4S3JWbEpZTnBwRVUvKzBnTjFhREJyYk5aMFhVbVJD?=
 =?utf-8?B?T0g5V0pOeHhHdmFsZFdBQnMxaTNhVnhZSzBXeUF3OFJ5ZEdxa1d4RzdzWVpu?=
 =?utf-8?B?dTByVWI2TDlpV1l0Sm1UTXNTMXdTYlBFbjA4b29ZUzNXMlZwWkRlcVVDUHNJ?=
 =?utf-8?B?RTNsb1FTN1A5bmwvdTdXcElYNnd6UEkydzFtYUp5blZWSW4rUXpxcTFadXEy?=
 =?utf-8?B?cEwxTHJIL2hKeFRYc0YzakpROWxNZWxUZ3V2dlQwNUFvSlk2UXlQS2QwbVBN?=
 =?utf-8?B?TXE3Q3JyZm4yU1lGV2V1ZW50ZjkwTUpqb3lpQUdUWkk2cjFZUnF4eTU3S1Rq?=
 =?utf-8?B?alZhbklMOWtxS1phZXRvNEhaUWd3M0J5MWFYd0RYSGNtN2U0OUVySno0aUlW?=
 =?utf-8?B?QkxUTzlRS3ZEWnFKMmFhN29pSm1RcmpML0RHYS9pQTFTV2JmTzNqZ3Z6WW1K?=
 =?utf-8?B?NWEzRWNNOThhZXlmdzRGSGNMdUVDd2QxZ2tvUGdnaXJmMmNhSUw2MjRlZHYx?=
 =?utf-8?B?bnk3RmZia1A2VE41c1N2SUtUK1BjdVRYMnhWS0dMWk8yWVpOZllUSDF3TVFC?=
 =?utf-8?B?SGh3bkQyc2NDRHowZFFibHZNWVFsck5ySFZFWmFuTFlhWkQzT2VHbmpVUUpl?=
 =?utf-8?B?S1RqUEoyODBJc2VQVDZIdjhXck9JTk9DQlhGeWlLZEFQeVMvRUJybWpJY3Rm?=
 =?utf-8?B?VXlaU2J1VHBMb0pRNzAwZitFbmJYQjFwcG9Eam4zTlpFLzFNcjJNRzZHRi9M?=
 =?utf-8?B?d0dUcjJUOGZsVmI5bDZtNnpxMnY3UmpmV3BjVmNiQVhWbmZ4bHBucU9rV1l0?=
 =?utf-8?B?RVh4b2psN2JOYVlZR2tmN09adFFPcjAyRWRSZFY5dlNwdE9lTS9UcWFNNmpS?=
 =?utf-8?B?M292VE5yR0hXRTgwbndBeWVpKzBZWlQveDFPT2hhVjhtR0hRak9GdU1LMkRB?=
 =?utf-8?B?bnBseFlkeTZ6QWFBU0hIc3lpQ3RTa2lRck9NSm90MHEreVZ0bGRDMDVaQm9t?=
 =?utf-8?B?OXZPNWZWRXoyL1ZjakdhUytGMGhaUFB0MFZ0cll1dUlDWFE4UUpLQk4rTzQ5?=
 =?utf-8?B?MGc9PQ==?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6f9543a-d3e6-4510-b839-08daade8a144
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4765.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2022 13:33:07.6937
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iAC6OEyafmVpivyKyHQFoA5G4uHjU94t7fkNyFjgyu2AfDkY1d+AaPkb/o7bNUbeFUz/+Va+1SyckHOu5B/+8nzJxCkWl7ogXU4esoMpUgul5uGuSgsPThPAYgdeZW7c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB6540
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14.10.22 16:01, David Hildenbrand wrote:
> On 14.10.22 14:50, Alexander Atanasov wrote:
>> Hello,
>>
>> On 11.10.22 12:23, David Hildenbrand wrote:
>>>>>>> Sounds to me that all you want is some notifier to be called from
>>>>>>> adjust_managed_page_count(). What am I missing?
>>>>>>
>>>>>> Notifier will act as an accumulator to report size of change and it
>>>>>> will make things easier for the drivers and users wrt locking.
>>>>>> Notifier is similar to the memory hotplug notifier.
>>>>>
>>>>> Overall, I am not convinced that there is any value of separating the
>>>>> value
>>>>> and the notifier. You can batch both or not batch both. In addition,
>>>>> as I
>>>>> mentioned, having two values seems racy.
>>>>
>>>> I have identified two users so far above - may be more to come.
>>>> One type needs the value to adjust. Also having the value is necessary
>>>> to report it to users and oom. There are options with callbacks and so
>>>> on but it will complicate things with no real gain. You are right about
>>>> the atomicity but i guess if that's a problem for some user it could
>>>> find a way to ensure it. i am yet to find such place.
>>>>
>>>
>>> I haven't followed the whole discussion, but I just wanted to raise that
>>> having a generic mechanism to notify on such changes could be valuable.
>>>
>>> For example, virtio-mem also uses adjust_managed_page_count() and might
>>> sometimes not trigger memory hotplug notifiers when adding more memory
>>> (essentially, when it fake-adds memory part of an already added Linux
>>> memory block).
>>>
>>> What might make sense is schedule some kind of deferred notification on
>>> adjust_managed_page_count() changes. This way, we could notify without
>>> caring about locking and would naturally batch notifications.
>>>
>>> adjust_managed_page_count() users would not require changes.
>>
>> Making it deferred will bring issues for both the users of the
>> adjust_managed_page_count and the receivers of the notification -
>> locking as first. And it is hard to know when the adjustment will
>> finish, some of the drivers wait and retry in blocks. It will bring
>> complexity and it will not be possible to convert users in small steps.
> 
> What exactly is the issue about handling that deferred? Who needs an 
> immediate, 100% precise notification? >
> Locking from a separate workqueue shouldn't be too hard, or what am i 
> missing?
>

We do not need immediate but most of the current callers of 
adjust_managed_page_count work in +1/-1 updates - so we want to defer 
the notification until they are done with changes. Deferring to a wq is 
not the problem, it would need to be done most likely.


>>
>> Other problem is that there are drivers that do not use
>> adjust_managed_page_count().
> 
> Which ones? Do we care?

VMWare and Virtio balloon drivers. I recently proposed to unify them and 
the objection was that it would break existing users - which is valid so 
we must care i guess.

-- 
Regards,
Alexander Atanasov

