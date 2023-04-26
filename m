Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2454B6EF1C1
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 12:13:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240427AbjDZKNU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 06:13:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240418AbjDZKNR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 06:13:17 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2064.outbound.protection.outlook.com [40.107.105.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A36E10EA;
        Wed, 26 Apr 2023 03:13:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=noe9A43R4xlOUJSjp/fa99tThh1oCcH++S0ubgUQKYaDbloZ6D0D2MEFYQSpVRe1ffwvAqV7Vqw2mxL0+7m2vd0amXfnhfak7f3mCO1l6McgOkYPM91t3TGZGGFKX7/8MEf+32jdQhI7/Ti4KubQnlwN9UfMblBELF17lwxQjDTd+u0vfe2kgjBFAtbRVVWVtViJwEwfjZCmUwl9VZ12WjxM25gn9iVPQ0fuBq6xwfvS1yFSW7neWTGLC+DLNFc1EraXBPN14O7Cyw30zWOYpZ7pN7365sUOKsi1xS793AzJiHEBTE2uOvQQkbnB/0b4RmTbE3c/AjFuO/1nYFOl3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zcEIcTmHJH3Do4F5YBeheWeFlOE4SNrnq/s1uX9Ote4=;
 b=JyInhAtSFMzTgacXFLY+w0WvoeiItu8CrO2bYjzWrR8tGPwoedvwkBg0IrsQTSseMD7DobcXl8rn2Irr0vthfiY+RK0ae+LgsfyI8093HSOC3lnqz66DaYYSAzlRWJWIiGj/AxU7DV/LHt8pcIWbDuZ2rJnDJR9xOBBc+VgAhYEAxMtMC+hSD0wnEnwwQFyhYnSmozLpye5mV87AjhRwGFz6j0GSFtK9vMylnyl2ZuOJo/VXygFOoKdAWCWr0OPmmYQtiul05ml1Gvmsvka9p/gMwWi8ts2ERXh7cL+dzlWkG1JsSEDd/xHBXAFkEwmNfoIUEJZ5BgYS/o2wC7LItA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zcEIcTmHJH3Do4F5YBeheWeFlOE4SNrnq/s1uX9Ote4=;
 b=dsj8Bogv4uKCkFzKpdElVZmNYmXskTIiaBByCzxNG7Q30647zzXPhGwiV4AVu1lGTN1zCAV/pNE62ormV+7LYaQcGgOULCyOAp9Uu3MtXwL08hO4y+FMlU7DNvikRHwZOjGdMdoJUjxiJINCOWl3XeSsWWC0pTKI98gtEuV2BOHInxGygxRB7zfbsvTIp7a5rzMU+rV48/dMbl90bIrrthQgsWXUSXaRUA6mORfTScWl8YoIroktHkXH2l1EenKXC88UvsffstoYIP0BjhSJvGFxPJ/fxuovS/r0YLonm4hBkuLgGokzpGw9yuRXkWjm4FXUoBdA/L3rv8z1vLCNqw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AM0PR0402MB3395.eurprd04.prod.outlook.com
 (2603:10a6:208:1a::16) by VI1PR04MB6989.eurprd04.prod.outlook.com
 (2603:10a6:803:131::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.21; Wed, 26 Apr
 2023 10:13:10 +0000
Received: from AM0PR0402MB3395.eurprd04.prod.outlook.com
 ([fe80::c1be:e15a:5cf9:b881]) by AM0PR0402MB3395.eurprd04.prod.outlook.com
 ([fe80::c1be:e15a:5cf9:b881%4]) with mapi id 15.20.6319.034; Wed, 26 Apr 2023
 10:13:10 +0000
Message-ID: <23bd0ce6-ef78-1cd8-1f21-0e706a00424a@suse.com>
Date:   Wed, 26 Apr 2023 12:13:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] module: add debugging auto-load duplicate module support
Content-Language: en-US
To:     Lucas De Marchi <lucas.demarchi@intel.com>,
        Luis Chamberlain <mcgrof@kernel.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>, david@redhat.com,
        patches@lists.linux.dev, linux-modules@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org, pmladek@suse.com,
        prarit@redhat.com, torvalds@linux-foundation.org,
        rafael@kernel.org, christophe.leroy@csgroup.eu, tglx@linutronix.de,
        peterz@infradead.org, song@kernel.org, rppt@kernel.org,
        dave@stgolabs.net, willy@infradead.org, vbabka@suse.cz,
        mhocko@suse.com, dave.hansen@linux.intel.com,
        colin.i.king@gmail.com, jim.cromie@gmail.com,
        catalin.marinas@arm.com, jbaron@akamai.com,
        rick.p.edgecombe@intel.com, j.granados@samsung.com
References: <20230418204636.791699-1-mcgrof@kernel.org>
 <2023041951-evolution-unwitting-1791@gregkh>
 <ZEB6DmF+l3LVrpFI@bombadil.infradead.org> <ZEDOWi8ifghwmOjp@kroah.com>
 <ZEGopJ8VAYnE7LQ2@bombadil.infradead.org> <ZEKn89wPH19r2bM4@kroah.com>
 <bnhskcp6hy6liwlefyjcxumlnvmkmyvhvatkq7ve3kb2zecyxl@c3jq2apjqlcy>
 <ZELKKVJ11LdFsBYo@bombadil.infradead.org>
 <wjgsfhr642ec2ly24tsdqb5a3hlhvsyxknyajqql4zziqemrwh@w5rdsmxuownn>
From:   Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <wjgsfhr642ec2ly24tsdqb5a3hlhvsyxknyajqql4zziqemrwh@w5rdsmxuownn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0001.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::11) To AM0PR0402MB3395.eurprd04.prod.outlook.com
 (2603:10a6:208:1a::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR0402MB3395:EE_|VI1PR04MB6989:EE_
X-MS-Office365-Filtering-Correlation-Id: af026ebd-6b01-4a21-37de-08db463ed605
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8htAEdqomUsK2N9i4WzcGcGUW17leY1wKJZ8ayNCNlfr3fUZwH6SobCrmepqZsFLabXecqATPuNCP7Xqt16kzVjiW6DD+z3NwjpM1NmVKjlh7P/zNkCN3jr2BKyMk7wI7sF2L9ynl1bxUQttny6b7sIS9ucn0A4dUKYfuiQveBiSvPq5FQt+SUl++whkL7laPkN4+3G6FwJDFvxuzD7L1brn5sA0ooNrVr/1G/8t10JiZqcR5chADS7dDxViLDfXy0TrOidcvk8TW+PQ1SClAQxnOWHQIPefKMKIRmS/fpu8bexf1GYpvpiQCX05k5I4K6wGNaIczOWcn7kx0fItybjAQk1yk91p31j18L/X978uRXwjd2t8XLxriDUD9ftkTnuCZxS/0HGo0F1dETdH8PeX7Kx0CKRv9b7kk/xFieZJUd2dzPv/77YcKBhbYKlmKaSo92ssvazWb1xINOrYmeb2G9h5v6+IARab510EYSveBnwxhF8QxY6CqSoCUYKDVCrJ039plBV+63w6Ezqr8KSwLuxhjhOugh27ua9+80WDRmDMBXHSKIKVRFOW/9Ewvnm2Gqetwh/ti3Bi3xAC6fZhkFQ53pfwFDaX62yQa7BVHMDodRs+BNAZlIwlytVyt/3aHWuPWMV4CF2bVklQ8g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR0402MB3395.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(136003)(346002)(366004)(396003)(39850400004)(451199021)(31686004)(53546011)(6512007)(6506007)(4326008)(55236004)(316002)(8676002)(2616005)(7416002)(8936002)(2906002)(44832011)(86362001)(31696002)(36756003)(5660300002)(478600001)(110136005)(6666004)(186003)(26005)(41300700001)(83380400001)(38100700002)(66556008)(66476007)(66946007)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c3AyV3p4QlJRSG8vRzlNUVgyNW9rK3FyWDdFcXpDbGVtMWxyNnNGc081cU5Z?=
 =?utf-8?B?UW5HdHpaeHJpOWZsdlRWaWY3RVlWUWJ6ZEQ0RUo4dVBQNXVuNGwyajRLZU5S?=
 =?utf-8?B?am9rVDZHR0hLQThhS2g2VDJXZDFZV2NkUG5UQkZwdkc5emR3d1k1SjlxWDV0?=
 =?utf-8?B?OHhDWkNBUzluTkxQRmNpWSsyVFBBY2tsZENWakYxVUFrbXZTWVdyVSt5SmhQ?=
 =?utf-8?B?WFUvUElGM1ZhK0JLZGhZN1J0MDJ4L3hYMWZMajNWMjRpU2VQZHBtaFpSOE9U?=
 =?utf-8?B?cHJsODd3V0RXQ2lTeE9NQWVlQllWVG1DWXZWSzAwUVltb2JGRi9MZ21lN2ln?=
 =?utf-8?B?RUhPNW5UUitGTWlKVWxnQW1HV3NqbUh0OUJuWU54WUliQjc1V2c5Yjg2QmtE?=
 =?utf-8?B?RFN1T0EwcTVyUHM3eDdCdWlWVWEzbitxd3l6Y0J3SkpzYmJVaGc0VVRBUTlP?=
 =?utf-8?B?TkUrTm40SmIxeHZ6T2R5MmZPZTl0RHdWS0s0VnNzcGgrWXNjVWRUU3ZEVXRC?=
 =?utf-8?B?RnVreGJwYVdXci95aFo0NjhPeW54S3UwbUZENWprWHJYdytTdEFZSmw4WEFl?=
 =?utf-8?B?OC9IV3kxWml3a1E5V0M1azRWZjI2Yi93TDZoaWkxY3R6WjJERHJ1R2tXY1k4?=
 =?utf-8?B?TnMxMXV0SU5vVUh4SlByUjVudlora1VLdUZpSnE0Zk93QWJTZkpseFRrSE0w?=
 =?utf-8?B?b0FYcmd4RFc0SHpTcXNHL0FvR1Nqc3JBY3d1bGRhMGZUbEE0L0o5UVpSTGFW?=
 =?utf-8?B?QThkbUhjNU5na0ZPaFZ3ejRqRGJhbWdSbzI4dnN5VURtdG5MempyeC9IQ2F4?=
 =?utf-8?B?SjZoZWV5ZEQrYmJrcXV3YUw2eG9lOTJxVFNmbU8rZDhaRkNTMVRJZEx2RTNF?=
 =?utf-8?B?cmdNa0YxclBMdFhkSlh1b2ZaSU1BRSsrYU9iS2gySnZUL3F5eFFFQUVRQklw?=
 =?utf-8?B?VVBBZWZpdVZ3WUtOWlU5ZVFVSlIyak44TjJTV2Y1R3JtNHFZVjd5VDFXeDFC?=
 =?utf-8?B?b2U4NWMzZjZteEoxYS9FV1BvdzlpM2NjWTlKTmFlTjZYWXBKM0toYXNDUUgx?=
 =?utf-8?B?K3JmcWRUWDBDVVU0ZjlHRkJlbUEwblF4RG9jeTVrNDN3SkoydmRaa1dFOFFk?=
 =?utf-8?B?aUtaaC91aVJ5b3padWNxd05FT2swNzNaOXlteDJoSGl3U1hFWTVnNS9henVY?=
 =?utf-8?B?VnFPMlNQTlZReEZ1bE5ROGc5RE5paXJDaUxWaUdjMUNsSDE3Zk4vVjlZaENW?=
 =?utf-8?B?anNZSjBOZ3pPUHJHREJMSm4vZkJRZTBJYnBTbC9NTXdnRkRCdnJkL0xxMGZB?=
 =?utf-8?B?Z2JiNEM3Q29meDNpeVg2d2lGRVZ0Y1dYRTJNQUZHWk1BWllVa2NDS3B1cndG?=
 =?utf-8?B?cmVVclJnOWVkbVY2d00wWEh2MkNKVWtyY0NNcEh0ZUpoRS9zN1lYNGVEWnJw?=
 =?utf-8?B?dVdLWlhQK2ZDdHBYci9MUVZ3dTcwQ29nMTR4alYvS2ZWUXpUYXFxeVJtRG9o?=
 =?utf-8?B?TUFkc3cxNnZBVWkvb3BzYVlObC9XTWpmNFM0UGF5R0hGRWQybjJ6WkVKUUFQ?=
 =?utf-8?B?allseEt4eXBQeDJmSWI0ZkpBUmQzbktGZVdabWEzeGQ1MmlFdEhOWGIvRlU3?=
 =?utf-8?B?K1VLRU1xRFpvWkxaVzNMWGFZRmF0c3JPYjMrOTh6ZjV3cXI1eUdhV2VwOHor?=
 =?utf-8?B?TzFsRmhnOFYwWHZQK2J5VkRiUWNUeDh0dmxmSFNRc2Z4dE5pcHRRN1F3bkR4?=
 =?utf-8?B?MWpGTXFEaFJXWkM4bHQ5Y2ZLNWJRWGQ4MDB1U2xpUHM0V2tFOUhFaGRrR2lV?=
 =?utf-8?B?dExXM2FuRjFEeE52cEp3MUdub29rMlQ1RkgrbTc5REQzbTFJOFE5NFVkeFFv?=
 =?utf-8?B?QXdpRUtSNExxZy9RS3lvT3F6QTlrR0IwNFYra25mQTRXN09PbzBIRDYvYVdi?=
 =?utf-8?B?bUM3bGlYcHA5M0hJbVQwakJFYUxWcE1rbkh5MFY1VitWVWxLb0hJQ3REZ0pZ?=
 =?utf-8?B?VzRoYlZKZWhCTjRCczB4UkwwcldFcjVyNnVNclpoK1VWZ1RPZit0ckh5VzQz?=
 =?utf-8?B?NDl4Rm9pVHl6OHUvdG1CaUlpUStpU3dNYU1uUzhMckZmWjJmVmhZZVNDRVJw?=
 =?utf-8?Q?m4CiuYZ/V0Vocn9vE6egRKsoe?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af026ebd-6b01-4a21-37de-08db463ed605
X-MS-Exchange-CrossTenant-AuthSource: AM0PR0402MB3395.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2023 10:13:09.8169
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ty3uI6Ykr6Yw39ChWMQyZLeuBMNOz2FSHZ6o4MkvTYyXxUNuoR6gQEMHz76VdLAWbGxkIHbEOGj2M7RTggjdZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6989
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/21/23 20:31, Lucas De Marchi wrote:
> On Fri, Apr 21, 2023 at 10:38:49AM -0700, Luis Chamberlain wrote:
[...]
>>> libkmod only skips the call if the module is already in
>>> the live state.
>>
>> It can do better, it can converge requests to avoid a kernel_read*()
>>from using vmalloc space. Note that this was not well known before,
>> but now it is clear.
> 
> in userspace, if using the same context and using init_module() rather
> than finit_module(), I **guess** we would have a similar thing due to
> the memory pool for modules: we don't read the module again. That is not
> true for finit_module() though as we just open and pass the fd.
> 
>>
>> I realize though that this could mean sharing a context between all
>> loads thoughs in udev, and such a change could take significant time
>> and review to complete.
> 
> But there is only one context. There aren't multiple paralell requests
> from multiple sources. Probably need to Cc someone still changing
> udev's builtin...  but from a quick look, from what I remember about
> that the last time I touched it and without data to prove me wrong,
> it seems we are not looking at the right problem space to come up with a
> solution.

My understanding is that udev workers are forked. An initial kmod context is
created by the main udevd process but no sharing happens after the fork. It
means that the mentioned memory pool logic doesn't really kick in.

Multiple parallel load requests come from multiple udev workers, for instance,
each handling an udev event for one CPU device and making the exactly same
requests as all others are doing at the same time.

The optimization idea would be to recognize these duplicate requests at the
udevd/kmod level and converge them.

Cheers,
Petr
