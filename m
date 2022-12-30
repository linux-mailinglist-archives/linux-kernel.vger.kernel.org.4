Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9EFA65974A
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 11:30:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234484AbiL3KaQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Dec 2022 05:30:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbiL3KaO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Dec 2022 05:30:14 -0500
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2102.outbound.protection.outlook.com [40.107.95.102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECDB812AD1;
        Fri, 30 Dec 2022 02:30:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ki0QrJOv5h+5BUeDXLRpI4Ps/nMIqvMBfqDFVoI6ErHj9KRAYJ1NnXXVv6zXD24dskbHuDnYSEwS8MO3qCNzRFAWCDzOFstTbnq67OIWDtoX3pvr5JMpkUNstFDWQxQJFmhUBuhL5QRJVQaYkZyvANwSWRnOKXNR1D7TRUR5oieQawy+vM01xbRL1Y6maJldlcCJZwKnxzc467lSwmV14xN6EPsHrrnHGrs7GXaB0CJzOOyplPefgFcqx5/1YOOQpkefB3c0B2nPcMZGjmYAs6QcG/xKIh6sQWOJ9mh0C7fJoGGlBLrhQY+brG9jfkj3GO69P4DR+evQ5UPPAVRYhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=taovbouu108n5VI1EzSPP2cb45zY6lqkPZ+FdUcrIA0=;
 b=gGahexYhoS1y0uy7UnFMQGvUTIsHQMu/a7RxXVR14QrcRJ43t/Z3Bu30YW1a1eg9TB8aAF8cNWRAbyVQHNl6ZLE/zY1od4CJGu/MGpiEpLeqh+/WfFLJIdP5NETu2ZAR3MxkhGh4PGiLvuBttsg+I1wOa8LX28OoZghdZrfQSdODhTDnFWtdYeXnnXNa4MFjmMeTREGmDDqNTeOae/XEQDsCXHyjP88r1fGZXBpfI2AjDaTmjr7GTzZ7qfU8XVwsmbdR9xtEWSiC+tmgjGB+oUhIMENy/g1AAGvXuMWZBqYWk4Nxpm7N7sc/7WjsO9Iw7eN6QDbjarwprmtv4cAxag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=amperemail.onmicrosoft.com; dkim=pass
 header.d=amperemail.onmicrosoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amperemail.onmicrosoft.com; s=selector1-amperemail-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=taovbouu108n5VI1EzSPP2cb45zY6lqkPZ+FdUcrIA0=;
 b=EflMe4PgSn1WBtNEvtaPIBb3qlPNxunM/erFq/jv4Lm8MlMIGJWSll7XQxoUxLERB4ifFoRbqXoYrlrk19s0DqBaTn9AJq1CSyhQWpQ7OCN9+lJuJzrfhfjIIHYjORN7JScYmWEdnG7vwjDIHxOsWSjOwE58t8HUlqkpjuhOPNw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amperemail.onmicrosoft.com;
Received: from SN6PR01MB4973.prod.exchangelabs.com (2603:10b6:805:c4::13) by
 MW4PR01MB6177.prod.exchangelabs.com (2603:10b6:303:76::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5944.14; Fri, 30 Dec 2022 10:30:08 +0000
Received: from SN6PR01MB4973.prod.exchangelabs.com
 ([fe80::1e67:38ac:ed37:be1c]) by SN6PR01MB4973.prod.exchangelabs.com
 ([fe80::1e67:38ac:ed37:be1c%3]) with mapi id 15.20.5944.016; Fri, 30 Dec 2022
 10:30:08 +0000
Message-ID: <56b0f4ad-9194-eb20-cffd-79c57171163b@amperemail.onmicrosoft.com>
Date:   Fri, 30 Dec 2022 17:29:57 +0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH v2] USB: gadget: Add ID numbers to configfs-gadget driver
 names
To:     Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        Chanh Nguyen <chanh@os.amperecomputing.com>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Frank Li <frank.li@nxp.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Dan Vacura <w36195@motorola.com>,
        Jakob Koschel <jakobkoschel@gmail.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Vijayavardhan Vennapusa <vvreddy@codeaurora.org>,
        Rondreis <linhaoguo86@gmail.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Open Source Submission <patches@amperecomputing.com>
References: <20221221091317.19380-1-chanh@os.amperecomputing.com>
 <f7067028-9662-7776-80a5-3bbe046c92e0@collabora.com>
Content-Language: en-US
From:   Chanh Nguyen <chanh@amperemail.onmicrosoft.com>
In-Reply-To: <f7067028-9662-7776-80a5-3bbe046c92e0@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR02CA0030.apcprd02.prod.outlook.com
 (2603:1096:3:18::18) To SN6PR01MB4973.prod.exchangelabs.com
 (2603:10b6:805:c4::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR01MB4973:EE_|MW4PR01MB6177:EE_
X-MS-Office365-Filtering-Correlation-Id: 03c84aba-0817-4d55-7c84-08daea50d27b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tlOl7snkP445WH+YlL3vZwv8n3B2aaHioRmHXhOiiwcd5d5+uHkklHMAAgRZMTmj+Cc+MPh5xkRSaNia7XELyh9dQzCvp8S8JDDrKDB0R2YcHeFSJo/S1/FmTwcTd001i4zV8zhULTY0P2X/x8JrKJr9wnHfkQh6SzvKpHJA2Id3XWnCFG/FFD+WETSru4mJtJLvoF0RPDpcVvjXrPmgK3X7qV5cO0c78ZHTAZ1Fnnn9MJFKui8PkURgeq7ggJdmZB9xGaGPAaBFcKS36CCZx8CtjjonYLipdr0j5mRQuLa9tDuipL0xoiBH4U1a8AnG7PLcpYQ3Ynecmzp93M4eDu430wYi1aDKx+a5+jeQaqja6P1zGEg8T99zGgajZjzCH2jC0sqdri3IG3b6E83PDb42fnAbEXMiOe11CLlQLOA5l0c5LZeuCYis7orPt1zgrvmZzbmIZzAlYvgh/FsoFsMmhU67YNe7rmovyoX0mpRQAoen3Y4jHxp2PYRhauOCddf0znIO+zT40o6nFUm2Lq1wjYEDybkkRb/KE4IL1unsEwV/v8YopD57jwrVuLiHRccGUVcbOiWpUls5/ZYLyiksUDjJYpjuRVpo8N37/CRv/u+uHkQivzFs/BtpyDw24PV7BQJqTF/B7RG3uID3FPD52euCFyQOKFGAk+SOHuUKWpTMq8YV05ORxU5eNoGgCXVcilkr6SH+rT2BLBwJUQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR01MB4973.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(376002)(366004)(136003)(39850400004)(346002)(451199015)(53546011)(6506007)(2616005)(42882007)(6512007)(186003)(478600001)(6486002)(316002)(2906002)(6666004)(31696002)(110136005)(26005)(31686004)(41300700001)(38100700002)(7416002)(66946007)(5660300002)(66556008)(83170400001)(921005)(8676002)(66476007)(83380400001)(8936002)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d1B2eDlYbE53TXpFN1N4bkxaUjJFUzFnbjNyclNXbklJS05tdDdJWFovWEd4?=
 =?utf-8?B?K2VVYkxSTmVya0twRndRSHRRMjN0YUtiSEZFK2kzRHIzL1hCcHBVSFhwdXky?=
 =?utf-8?B?UGROanRxODhVSER1Vk9rdy9keWJta0pramRwbU56Vy9iL05KcVdGakJ4ZmE1?=
 =?utf-8?B?Q0xnOFNkSnl4aTltK29kTFU3cldoUFc3T040aXcyVDE0b0h3UjNZSzNhOU5x?=
 =?utf-8?B?NnBHeGRKWUZOZmhuVnJGVjN3c2xSaVI2UnJuTzZXaWpIWG5HYTUrRXhpalFR?=
 =?utf-8?B?REpBV0RYOCtkK1hrd1UrM3VtTjl5aWRDUDZzaVQ5dFlWSGw4aHRwZktId2tt?=
 =?utf-8?B?S2pxNzFqRWZsYXZIeGJWdlZKVXlpVXRuSC81aTliaHo4QXY4ZytsZXNNd2lv?=
 =?utf-8?B?L2pBWEhkR0F1L1pOMi93Z2tpRStIT2JGcTA4ejZCcCtnaW5SWlNpeDBScWVI?=
 =?utf-8?B?S0YxdEFWRVdKS1pibUozdnVtV29ZMlJ5dTNQQkduMUhUTXUwaFdVQUlqcTQz?=
 =?utf-8?B?SDZhbFBiMXRTWmdQSFQ4cmpPUXNud1dleHdXMzczcWRmdXBLUUlmc1Nac3Rr?=
 =?utf-8?B?MUdPSDJzSWQyTU81d2s2NXpxbDRhbGhPS2czTXBvYXJNbEtQS1RSRFNsd2xh?=
 =?utf-8?B?dURvVmN5T3VPZUk1dytUUUJCRHhXMy9QK0hLeWpBazB3a3UyWUV0MWNCVkc4?=
 =?utf-8?B?aWpkNTFuQldPbENQZmc5c010MGVaT1kzZVUwQXpuczBBN1llU0RwbmNpME9x?=
 =?utf-8?B?dE0zM2ZKdVNzZkpaZURyWW1qdFhlYXRXcER1YVIxcDdSYWh6aURUcUJ3RUVH?=
 =?utf-8?B?eUo3Qzc3U3B6TDlvTEFnK29qWnZ0aFh1b3FoYUs0NWZybGJ4bzdTbnVSeEpO?=
 =?utf-8?B?d1FKK0s2eWtMc1hnSC9lT1NsUWNZMzNnZlNtL0VNU3hEZzVOZzNRbENZU3JJ?=
 =?utf-8?B?bmRkRklQaVlBak1KQXZ3ODQwTjhidGcwQjBFTGhIY3o3K2lCa0dGM3BtL2p5?=
 =?utf-8?B?RE5NQXFOZDJzVS9HbzhCYU5JZXJOTng4ampXU3VaK2ZWNkh6VVArZklmZkZr?=
 =?utf-8?B?ZHl4ZTlJejdqdE00RVhCSGVVa0RobTIrdFcwcHdZTXFlcWp5Wit3OW1YcnNL?=
 =?utf-8?B?azJObmJPekNPM29KNW95V1FUc0NHMTRjWk1HNE1kQi9FcTcvbE05TXpDd1Zy?=
 =?utf-8?B?RXVDb2ZaYlVvZjRUaVJNMEo5QlZDVGowN3R5ZTgvUU9XaDhiZUtLQm05WEh6?=
 =?utf-8?B?VkxLQ1ovYmtOMlMybzFWQzAwOVg3SjVnclljZGovS1hpNjViNmxpcHIvYy9p?=
 =?utf-8?B?QW9HNFN0SGVnQ0tZOUFnVncrbks4YnpzSzZyY3oyKzdMb3hBV2YyVUVrdkFT?=
 =?utf-8?B?R09VaW55bEJQRkZka3E5MTMvQjQ2NG1SYkVkOWFWcTV4UXlLNDRsNEZveWVN?=
 =?utf-8?B?dnJhUVlRS2tZVVJjV2ZTeTN3NEtOZHVWTDdxTnVaL214NUhWMzZManBJZW9x?=
 =?utf-8?B?aXN0MWt6WnozczdiY0Z1ME5YZnVOZTR6WHNpRU9sS3pNRjJsekNxYnB4elZZ?=
 =?utf-8?B?cTlPNnVOdEQ4QVBvMWxWc1lqajFVSGFyWE9xdHkyQWpsOWVJTDdCaDc5ekVi?=
 =?utf-8?B?TWdQTldHVE13b0M0ZDV3T1FHMVNhV0x4MkdLdllRdXhpZUZPM0d3UGY1T1gw?=
 =?utf-8?B?Y2FWTjFkazlkZEw4UlVYVkRSM09LRGRjQXdaUXlFendpMHJTVlU0dFBiZTNM?=
 =?utf-8?B?RG9UVHB5Z0FIWUNrK0lKc3FYSDd6YXIxWVNxZllod0xGNUtCV3FvclpkM1RF?=
 =?utf-8?B?Vmh3bHArRWhsUGxRdHBjQytseERYcTNJVXd2cGZYVW55U0UwODFzTnA1N2Ru?=
 =?utf-8?B?UHVNM2RQWmVPUDJITkdnRkVjQmtTMmMzWXdWRVhJS0hqdEdkT0htTVB4YnZm?=
 =?utf-8?B?RCtaZXBlbzVrNk5ocEFvRUxqM0pKd1A0bGRKV1BzWXBuN0NWTWVjK2czdVRG?=
 =?utf-8?B?aTc1MjJhaTR2TFBsb3p4N21Ec3ora1dKL1FQdTBxeUx4M3lSRDNkRlgyVzFo?=
 =?utf-8?B?UlgxTmZsekJoRysyejNzY0N3K1NwaFBjN0ovZWUrQ0ZaczFhR2JXUldsVlov?=
 =?utf-8?B?M2MrclRJazFGYzZWeW5XaE51Ry94UkEzQmxMaFJLcWtVR0N5cFppd0dMcEFa?=
 =?utf-8?Q?ViQ4urgtxwfNm5FG42mBs0Y=3D?=
X-OriginatorOrg: amperemail.onmicrosoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03c84aba-0817-4d55-7c84-08daea50d27b
X-MS-Exchange-CrossTenant-AuthSource: SN6PR01MB4973.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Dec 2022 10:30:08.0312
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E222KNA0yqEtURyXmN3mrx8P33y6LbNBRyZNIDXp35YnFonX8Qhl/yFGFh/fHQ3aJLKc3JughOwnpkxqWalSyL3zhHgRA2YcPUbnTci/7cjYHmIMSrnX1mWfsOwh5ISL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR01MB6177
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 22/12/2022 22:20, Andrzej Pietrasiewicz wrote:
> Hi,
> 
> W dniu 21.12.2022 o 10:13, Chanh Nguyen pisze:
>> It is unable to use configfs to attach more than one gadget. When
>> attaching the second gadget, it always fails and the kernel message
>> prints out:
>>
>> Error: Driver 'configfs-gadget' is already registered, aborting...
>> UDC core: g1: driver registration failed: -16
>>
> 
> I assume you are interested in a scenario where there is more than one
> UDC available which means you can have more than one active gadget?
> 

Yes, I'd like to have more active gadgets. For example, mass_storage and 
ecm usb, ...

>> This commit fixes the problem by a ".N" suffix added to each
>> configfs_gadget's driver name (where N is a unique ID number),
>> thus making the names distinct.
>>
>> Fixes: fc274c1e9973 ("USB: gadget: Add a new bus for gadgets")
>> Signed-off-by: Chanh Nguyen <chanh@os.amperecomputing.com>
>>
>> ---
>> Changes in v2:
>>    - Replace scnprintf() by kasprintf() to simplify the code [CJ]
>>    - Move the clean up code from gadgets_drop() to
>>      gadget_info_attr_release()                        [Frank Li]
>>    - Correct the resource free up in gadges_make()   [Alan Stern]
>>    - Remove the unnecessary variable in gadgets_make()    [Chanh]
>>    - Fixes minor grammar issue in commit message          [Chanh]
>> ---
>>   drivers/usb/gadget/configfs.c | 25 ++++++++++++++++++++++++-
>>   1 file changed, 24 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/usb/gadget/configfs.c 
>> b/drivers/usb/gadget/configfs.c
>> index 96121d1c8df4..7faf68bfa716 100644
>> --- a/drivers/usb/gadget/configfs.c
>> +++ b/drivers/usb/gadget/configfs.c
>> @@ -3,6 +3,7 @@
>>   #include <linux/module.h>
>>   #include <linux/slab.h>
>>   #include <linux/device.h>
>> +#include <linux/idr.h>
>>   #include <linux/kstrtox.h>
>>   #include <linux/nls.h>
>>   #include <linux/usb/composite.h>
>> @@ -11,6 +12,8 @@
>>   #include "u_f.h"
>>   #include "u_os_desc.h"
>> +static DEFINE_IDA(driver_id_numbers);
>> +
>>   int check_user_usb_string(const char *name,
>>           struct usb_gadget_strings *stringtab_dev)
>>   {
>> @@ -52,6 +55,9 @@ struct gadget_info {
>>       char qw_sign[OS_STRING_QW_SIGN_LEN];
>>       spinlock_t spinlock;
>>       bool unbind;
>> +
>> +    /* Make driver names unique */
>> +    int driver_id_number;
>>   };
>>   static inline struct gadget_info *to_gadget_info(struct config_item 
>> *item)
>> @@ -393,6 +399,8 @@ static void gadget_info_attr_release(struct 
>> config_item *item)
>>       WARN_ON(!list_empty(&gi->string_list));
>>       WARN_ON(!list_empty(&gi->available_func));
>>       kfree(gi->composite.gadget_driver.function);
>> +    kfree(gi->composite.gadget_driver.driver.name);
>> +    ida_free(&driver_id_numbers, gi->driver_id_number);
>>       kfree(gi);
>>   }
>> @@ -1623,13 +1631,28 @@ static struct config_group *gadgets_make(
>>       gi->composite.gadget_driver = configfs_driver_template;
>> +    gi->driver_id_number = ida_alloc(&driver_id_numbers, GFP_KERNEL);
>> +    if (gi->driver_id_number < 0)
>> +        goto err;
>> +
>> +    gi->composite.gadget_driver.driver.name = kasprintf(GFP_KERNEL,
>> +                                "configfs-gadget.%d",
>> +                                gi->driver_id_number);
> 
> I'm wondering if it maybe makes more sense to use the gadget name as a 
> suffix
> instead?
> 
>      gi->composite.gadget_driver.driver.name =
>          kasprintf(GFP_KERNEL, "configfs-gadget.%s" name);
> 
> So that when you
> 
> mkdir g1
> 
> you will ultimately see /sys/bus/gadget/drivers/configfs-gadget.g1
> 
> instead of /sys/bus/gadget/drivers/configfs-gadget.0
> 
> Gadget names are guaranteed to be unique because they are created
> as sibling subdirectories in configfs. Your patch would then be greatly
> simplified (no need for ida).
> 
> Regards,
> 
> Andrzej
> 

Thanks, Andrzej! I'll update that in patch v3

>> +    if (!gi->composite.gadget_driver.driver.name)
>> +        goto out_free_driver_id_number;
>> +
>>       gi->composite.gadget_driver.function = kstrdup(name, GFP_KERNEL);
>>       gi->composite.name = gi->composite.gadget_driver.function;
>>       if (!gi->composite.gadget_driver.function)
>> -        goto err;
>> +        goto out_free_driver_name;
>>       return &gi->group;
>> +
>> +out_free_driver_name:
>> +    kfree(gi->composite.gadget_driver.driver.name);
>> +out_free_driver_id_number:
>> +    ida_free(&driver_id_numbers, gi->driver_id_number);
>>   err:
>>       kfree(gi);
>>       return ERR_PTR(-ENOMEM);
> 
