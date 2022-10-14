Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 254065FEE1B
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 14:50:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbiJNMus (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 08:50:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiJNMuq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 08:50:46 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70133.outbound.protection.outlook.com [40.107.7.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 826D9DB75B
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 05:50:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U3DV7gTUC9h6tZNp/a/HhAh2Wq1/tQhIID0iZJIth4i4beDrKz6tQptzaj8boz0zoB9d5OIUmz+emTdq/NSsZjaHPEGUjf8e2RqJeaKKqv3XosTzz5TgvxQtcMrmv/GcjWW40inCsQb1ybnyxAK5KTYhnZuLgE7xBgX2PwlaPQ9tRHSnBrXGCI/V8hTJIA21xThrmfNo/svPtyL/0k80tAjoIxzxTH3GdicCSGfZ3JFWvQ85WkFTK575qzBs4XTT1hLzowGtycA2xKpFMe38oz22qfd1Iyht6rDRZWTzePgdD42BrF29+eBIv6rucIk26TgDG8apXR74ykGtpnQqJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a6Koh4zv4h6h640jfCCEPP0OCU2u40qcIORO/1XeP+0=;
 b=P+Z9Xvatx15Hufn0i+YyT7CiRPsw7NuwuLy496kVy59ip5PWD2UtE9fnlIRdXXvLDmrz/h2NA7b5bSRqDXRJ7QOLWuPMwux/nlrD1unqAJ7VPsO8sfOFPAYQYPgDdneWrjlRYkLcV60RiEPNIV1sXzU4QqLsDjthRyrA3HYJ6B8jAeBpOCShrOIJiMiaRyShJhlAZF1IFH9r6zONNaQU2nJz76JAf9QdSOtyjydGHTkJDNND6+fjfro3YTtAh5Zski2kdSPyrrH8yyz2QFDo1OL8U/5EY5Tk9ky2JZ63Fpq2Hs+eVKMBUkfd+jyKYDeHwtaGBO9sBgHStrK+tx3WTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a6Koh4zv4h6h640jfCCEPP0OCU2u40qcIORO/1XeP+0=;
 b=RHEqIaaSNeyZCsre1BWZFLzeD/n/+eBx1b9+Ytq4i5XzS9PG5IWY9CL1nRHMG9Y6t9oEL1uh5lCL1eC5HhQLjJLCMgIX3qwEdGQwh4mF4rA6AlkhCmtbqmQwWAD9mQr/4zQTjaFz9djGg8uS+CJx61bU6SB2QCaxCYigYk6q504xkjulZFQz+xxcKVhMaaPwXWMYfD+79me38VvyceRRcKRo2PUu80T9k1rqh2FxLNl58s4+E0gOnYCV+nLZKupHmnEpQof4xgW2XHYyxY+Dzie0hcqUemf3TC+bA/a5EtqgSe/lC1cTQR/9jZw4qXjwmqRLUDQVydAGFgpW7UeDug==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VE1PR08MB4765.eurprd08.prod.outlook.com (2603:10a6:802:a5::16)
 by VI1PR08MB5344.eurprd08.prod.outlook.com (2603:10a6:803:13e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.29; Fri, 14 Oct
 2022 12:50:39 +0000
Received: from VE1PR08MB4765.eurprd08.prod.outlook.com
 ([fe80::6809:fef7:a205:b08a]) by VE1PR08MB4765.eurprd08.prod.outlook.com
 ([fe80::6809:fef7:a205:b08a%7]) with mapi id 15.20.5723.026; Fri, 14 Oct 2022
 12:50:39 +0000
Message-ID: <04e5a2e4-052d-0f80-d642-4e104307f38b@virtuozzo.com>
Date:   Fri, 14 Oct 2022 15:50:37 +0300
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
From:   Alexander Atanasov <alexander.atanasov@virtuozzo.com>
In-Reply-To: <063efd58-8373-90ea-7c5e-9d0e9161d2ba@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P190CA0030.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:802:2b::43) To VE1PR08MB4765.eurprd08.prod.outlook.com
 (2603:10a6:802:a5::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR08MB4765:EE_|VI1PR08MB5344:EE_
X-MS-Office365-Filtering-Correlation-Id: dc95fbc3-7c7c-4fc3-a246-08daade2b258
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ToAH+6zIsM9qvnCmxIYDzw9/RCvhj8F/yUgPzNinommhWWP6dvLqLij8XLrs+tEt55GM9zEpN5i5sV0ksFXa/9IVdrvegyhIN5N6HzqTHO5K1UZV3NyMJ60y9bRraq1fzk6U53HkfP4AKQaGTJ5eaJb8Mk6NXPz3zx01xB3gWB8pT+8qYKOJmJrt60OsozoT94vLalG7jxX+ZTjJ2wdFVsLC6K0vxChqMpZjU+mldMR98zFJKQ/DMuzXKI7jRclMSdDoLZjUmYJHVWzrkcwEPJaxmOoCggZQa0pltK0zNgNdAv90jq5j2faT3LwlV+oddYZ9e2k/JszfU3HPYJHV6BKob8+O9VS7RiI0dygcVhdjWo6wjcUDNdhdxFYpXKmz/qkwlr5zbs9sHTHhMU/cQaOMfdV16LhPNfTmAmys0k1P/DlWp2jPx3QLq/yeoXF3pVj4bDTABQWorh+gz1aCVCX5VJ06Jyoz2W9mXzMphIp9m2PnZWRF7R0r17ClTD5tIArxnWC7+rmxfN5AzjLzPGmWXz3Ph/7UXPZYJg9mthunvaD4JTsNKViTHXJUzKfa2WNRJsbNOI3aO15OmB5a2sbaiKW/YoVXVOmIo96NnHaunw233twiQs17qTl3oL+Ew7sfgV5QfLEI2yeB10ILvYnitP8DSQZulyjN3gB2fpyc5eAdoCUuQHPDK7VJi3s9gSrZ37k3noRUJ0l2aa3uYqnZJEs3BNcUIqQL3/5xb9M+py+FgJbdrOS/hk+rZBH6D3RB4O5GCamFG/qM0BL4Ujsop0o0UBbgkrGCdyBlJwc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4765.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(396003)(136003)(366004)(376002)(39850400004)(451199015)(6486002)(36756003)(2906002)(110136005)(83380400001)(54906003)(316002)(38100700002)(41300700001)(6506007)(186003)(53546011)(8936002)(31696002)(86362001)(5660300002)(478600001)(4326008)(2616005)(26005)(44832011)(6512007)(66946007)(66476007)(66556008)(8676002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MEN5OXdHaGlrOXNRa0xkaTVvYlpSa1RwLzJJSGhmMDZWOUU2aEl0ZmFYSWkw?=
 =?utf-8?B?RVprMzhCT0cxSHpOTGJ2NVNJTUtnRVNEREtwazRhR2NRSnhlMXlRRFJHNDN4?=
 =?utf-8?B?VWFXRllqVFJLR3phdnE4OEttcWJjeEk4NEZVWnZJOGxlM0VoSExORWhpbVdj?=
 =?utf-8?B?RUZFakpxVE1QMEx1bmZtZ0Q2czluenlLN2tqOVJWSHUwdXAyakRMaGFmdGl6?=
 =?utf-8?B?UEVldkV6bnZkdjJZbFVaQkZNMkpheUdKSzNQOHV1dUVMdk16bHhWMzNhc0xh?=
 =?utf-8?B?TEVnN0Rid2N3eWZrYWVvWUh2ZWVrWllVM3V0c3R2TGx2T1NvT09xcnJvOTVo?=
 =?utf-8?B?ZE4ySWkvOHVRaGlac3o3N215MHNlMlVYYXFEV3BUbElzZXNVUWowSDdzOHBw?=
 =?utf-8?B?MnVaWmFBT2FWd3hFaDBZSnBFUXBNVVZ2QlM3YkNqQVZodTVvYzM3MlJlazdx?=
 =?utf-8?B?Q2JnOW4zTGk4YmRlTGZ6QUMreGk3K2hVNjZ5VEtQTHRGMThkek9Wc2FiWS9Y?=
 =?utf-8?B?cXJkNk14cExkb3BwRmF4a0pOakVLV2tsVGRWdDMvU3dPd0x4M2NKV20zd3dI?=
 =?utf-8?B?K3FQZmpVU2VXRFBPNTVjVFdIS2tMa1BmZmZhdDl5REF2S0ZkcnMwUmtFaGN5?=
 =?utf-8?B?YXMzN2hsWXZVK0lETldsMjdFVTdaa1dxelVzZldzdnVic2M2cjFvSW5BeG9h?=
 =?utf-8?B?ZFM2MGp5L1NpRDA0cFlUYi9IQldDTmFZQlhRNmVsVDJvcWNOYlo1WHpIWHZU?=
 =?utf-8?B?cFpvM1p5UXVlTlhEbmRTclZkcytBbjUxeFJnZlRESmRTZTNUMnozd2tIZkpZ?=
 =?utf-8?B?aWpkU1pyV0hOOVVLTUdKbTl1R3ByTkppWGtNdGkrSit2eGNBb2pnSW5wVmI3?=
 =?utf-8?B?NFJlUFB4eG42R2V1ay8vV29XWmlDVHpjQm1RcGNTNGY0ekgwK0J6SWRkbjQ3?=
 =?utf-8?B?ZXNqSUJ0VUFqNi9jbVlMQk9zU2Z1d2ZFMFJxcGtVVHR0ZythOHdjTm9SdVUz?=
 =?utf-8?B?ODdkLzBhVmJjMEhoZTZiKzNWMlR3S0dOOENwekVURlFHUVpQSHBNcm03YVNh?=
 =?utf-8?B?bS9qMU80WXBUREd2cDE5cHdtV0JyZGhSeWNrclBuRVlPTUVQcWFWNjQ2Znhp?=
 =?utf-8?B?ZnA0SUpqdFBqdDFuVEVqUWU3QmI5RzFoaEQ4K2V1TXk1NW5IdllhL2ZNc29z?=
 =?utf-8?B?RGhXQ1FGdXJDZEkyQ01UalB0OGNhWHhQRVFRMmQ1M0NUaUk0djFram5YSkpQ?=
 =?utf-8?B?R3dKaDd4K1gzRzQ0cVFOTU5NWTA4YTRXYVhlOVZiQXNFeEdOZDhlU2FOSUpX?=
 =?utf-8?B?bWFRZWxYekNUNENQdUFZUzh3NURTQnh5VENaN1d5TjJUN0t2SmFEaHZSSzZM?=
 =?utf-8?B?clFCZjAya2VxdlF3Wm1VV256RGI2aTBYeG5zb1oxd1paMDRaWUdHcklFT2hy?=
 =?utf-8?B?MWpKazhPSTV5RnVna2l6cThZNDhRb2VnL0VKUkJIek9VOVZBd0syTytmeXNB?=
 =?utf-8?B?QlhSQnJXUnFkSXh2R25RSThCVFo5RDVVTmt4TzRzOVZYZkhRZTh6dlQzdmxp?=
 =?utf-8?B?Zkt4aVdGaWRhQU43NXlMTVNUMFcyb2JyZVpMdnNwQm9iMGRmRGFCWGtLVmJT?=
 =?utf-8?B?Y054NFpVWXRKeTExbjFOMHBIMW01aHBZMFdZQkJPRGtjYmxTSGF6RGtUZWll?=
 =?utf-8?B?dk9ENWMxbGlqSkhqZkI0Tit3NkE0azRacEQxSmJCblhjQ0tHbjNwSHRhYW9n?=
 =?utf-8?B?a0ZJeDVOdy9ZeWptekRnc25jMHdzcjh0UjZiSC9sdUJhMDl5enJMakRtZUU5?=
 =?utf-8?B?N0RGMU85QnJpdC80RW1seGxPWXRqNWE1NzFTejNEd1ZLS2VRWCtBUzErbHkv?=
 =?utf-8?B?eXdWNGV4d2txSzduM1oybnE1bmgwbG9TbjB5cWRGZm5ac0dOcE0zVit2UCtv?=
 =?utf-8?B?d1ByaFhlZDZxcEVkU1BlUVU5aVlJMEpubTIycE9sL3FTeUNYZC9RckU0U1VJ?=
 =?utf-8?B?cE51K0I4UGsrSHF2Nkt4SHBDTmFMK0FuWU5OOXhDcXZXaHVoYlJ2TnVKYkVi?=
 =?utf-8?B?MU5GcnAwdWNLSmUwYlJTazlLVjJQOC91TWpLbkZ2Zno5amRoRTBhZTJxS1oz?=
 =?utf-8?B?YzRweXZPVjRnMSsyM2srdzRBZzIrMUNqSjc1VXJWTDZ6WXBvQnVuVVNHNFZ5?=
 =?utf-8?B?N1E9PQ==?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc95fbc3-7c7c-4fc3-a246-08daade2b258
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4765.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2022 12:50:39.3651
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6cEhYv9bhHD6n9tzWvWBvVKP0STl383GR6i6OSQG2MJZU7mNR0WnQhjfdw62U09N2KPOLLFhCFME6XhUHQTwxjlSVTYynKo2/939IYlxmVTSB32YN+t8bMrKKt6SeGjo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB5344
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On 11.10.22 12:23, David Hildenbrand wrote:
>>>>> Sounds to me that all you want is some notifier to be called from
>>>>> adjust_managed_page_count(). What am I missing?
>>>>
>>>> Notifier will act as an accumulator to report size of change and it 
>>>> will make things easier for the drivers and users wrt locking.
>>>> Notifier is similar to the memory hotplug notifier.
>>>
>>> Overall, I am not convinced that there is any value of separating the 
>>> value
>>> and the notifier. You can batch both or not batch both. In addition, 
>>> as I
>>> mentioned, having two values seems racy.
>>
>> I have identified two users so far above - may be more to come.
>> One type needs the value to adjust. Also having the value is necessary
>> to report it to users and oom. There are options with callbacks and so
>> on but it will complicate things with no real gain. You are right about
>> the atomicity but i guess if that's a problem for some user it could
>> find a way to ensure it. i am yet to find such place.
>>
> 
> I haven't followed the whole discussion, but I just wanted to raise that 
> having a generic mechanism to notify on such changes could be valuable.
> 
> For example, virtio-mem also uses adjust_managed_page_count() and might 
> sometimes not trigger memory hotplug notifiers when adding more memory 
> (essentially, when it fake-adds memory part of an already added Linux 
> memory block).
> 
> What might make sense is schedule some kind of deferred notification on 
> adjust_managed_page_count() changes. This way, we could notify without 
> caring about locking and would naturally batch notifications.
> 
> adjust_managed_page_count() users would not require changes.

Making it deferred will bring issues for both the users of the 
adjust_managed_page_count and the receivers of the notification - 
locking as first. And it is hard to know when the adjustment will 
finish, some of the drivers wait and retry in blocks. It will bring 
complexity and it will not be possible to convert users in small steps.

Other problem is that there are drivers that do not use 
adjust_managed_page_count().

Extending the current memory hotplug notifier is not an option too much 
things can break.

I think some new option CONFIG_DYN_MEM_CONSTRAINTS or a better name.
Add a dynmem_notifier that bring size changes to the subscribers.
CONFIG_DYN_MEM_CONSTRAINTS to be able to convert current __init 
functions without growing kernel in size when not using it.

One idea about the absolut values in sysfs/proc is to check if the 
option is set by the user or it is the same as was calculated at init 
time - if it is not set by the user it can be adjusted up/down by 
percent of the change in memory - it may require min/max value boundaries.

Does anyone know - if it is possible to know if a sysfs/proc file has 
been written to since boot?


-- 
Regards,
Alexander Atanasov

