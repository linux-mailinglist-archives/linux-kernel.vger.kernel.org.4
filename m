Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 858AB6471DC
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 15:37:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229735AbiLHOhB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 09:37:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229912AbiLHOgx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 09:36:53 -0500
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2041.outbound.protection.outlook.com [40.107.15.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AA016C71B;
        Thu,  8 Dec 2022 06:36:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LIjbQsOggxBW6gRZ7qrLC38jNsrtBaJekC8qeh/AAssnnU/9KhKKu6+i8FHW8dTifHh8iFYpCKhc2foCfnnZ7ce06kr8KmmIX7b2a7/bjMeq6MstbK7KCt1Ckoys7qd6wbpvGoLaJx/UPmj3b1AV8P5h/rVZIzcMu4ZsQcA8gH3jZSMkXT1+lD4e8wN2a2OIEjTGAYX2rFoReuksAjQLF2wBpGMTy+8GaL0qzSIhvj2zjAR0kJVfUm1zlbbLTUs8/ANdL2uQxyIzaKwk+NvkK8tVeJ5RL9t/QpVjO48evjoh32vmSR1VavkjqWrswZr7w+BA+Fzc2yTrOmgQV9KrKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F5EFyQlUY4e2hSf5joRw+/7suh6JAaz0t5CjDyYePec=;
 b=PHZ7kCnNbAee5AeO5ng1+VJ97YvfoCv0zTUNW+8UdbWeKBI2xP+dNthv7tnFIdURz6nO6FgmL0pWcMtrKDAxff0eLLhlKDsMTH/4c65WLD7OWxKbCbR3taH4phSvtYb3V/2y+uH3JeyBTbpZJU1jsJ9hAez/j1k8VAduzGaKqqfcLG5ePemGXrt878TN32AkG7/R4CAecrSQASJBSx1OruOautKWjZaOSjRej5c4AQKjpEKOmjPbEJO7oRxfsvWUoSLSR7vIws6VQlK76a31MExLsLLvhvXAHUi9YWCJVvmfV8oKHasUJUOl2g64G5XPlPGPZGJfsZeUKs3eoicemQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F5EFyQlUY4e2hSf5joRw+/7suh6JAaz0t5CjDyYePec=;
 b=Flzc7EHtQsM/u8xuyY1aFDZ1mlphefcxGayEIulVyxCjUZZqZ5vodzPrYj+Ep0OutUBU00ktfAQVc+YMxigP7C4qu69TAPdLyksET9heOYWs/fqhCoXSOFvlirNrwf3YEqdRRSJbBjbHX8k5PBc4LWN1T4T0k2ZH/16QFcvyqzIbIcLoOEqPJ9IDRv819iQRoG1EzxvaYDC8TkviwHXdCxopMd6rwYxq8qEDb+4ZbLoe6AD9JT8bP0JAVIGstYCqZUUEamEhDKSdGGmpQKiQVloft29iO/MzFrBGbS3Txm4CgTCz4zXIQ0oTqZM6lnUQaCkK67WPVOlX5pcv+vm+/Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR04MB7104.eurprd04.prod.outlook.com (2603:10a6:800:126::9)
 by PA4PR04MB7759.eurprd04.prod.outlook.com (2603:10a6:102:c6::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.10; Thu, 8 Dec
 2022 14:36:48 +0000
Received: from VI1PR04MB7104.eurprd04.prod.outlook.com
 ([fe80::ae59:a542:9cbc:5b3]) by VI1PR04MB7104.eurprd04.prod.outlook.com
 ([fe80::ae59:a542:9cbc:5b3%9]) with mapi id 15.20.5880.014; Thu, 8 Dec 2022
 14:36:48 +0000
Message-ID: <cac60598-5080-5876-d28d-e8caab8b9b0f@suse.com>
Date:   Thu, 8 Dec 2022 15:36:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [syzbot] KASAN: use-after-free Read in __usb_hcd_giveback_urb (2)
Content-Language: en-US
To:     Alan Stern <stern@rowland.harvard.edu>,
        Oliver Neukum <oneukum@suse.com>,
        syzbot <syzbot+712fd0e60dda3ba34642@syzkaller.appspotmail.com>
Cc:     WeitaoWang-oc@zhaoxin.com, arnd@arndb.de,
        gregkh@linuxfoundation.org, khalid.masum.92@gmail.com,
        kishon@ti.com, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, syzkaller-bugs@googlegroups.com
References: <0000000000002fc8dc05ef267a9f@google.com>
 <Y49h3MX8iXEO/na+@rowland.harvard.edu>
From:   Oliver Neukum <oneukum@suse.com>
In-Reply-To: <Y49h3MX8iXEO/na+@rowland.harvard.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0130.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9e::11) To VI1PR04MB7104.eurprd04.prod.outlook.com
 (2603:10a6:800:126::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB7104:EE_|PA4PR04MB7759:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a4e876b-239d-471d-896f-08dad929a2f1
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QelkzmpXGN6MWaqcBed+2L0M5nbqiF4DoGDuLvgPh8dD+UqMfg5izzD4zKggAnalX0xwYhZ7K9Fgs3XhFQ8uWWuvl5jDVV9g+cyvvpkDHPBY1uN2/vfyWcLGTu7medkPz9lO3IjHSO3JAxdUGoUKZEoIgoUssOb9ll4f8Qopv5b04/I6vMmdTERCZXnPBqh56pEvIs4S8rBQVKXpS0mmJnJlckZqMr0BnTnL1Ge7j5eScV8ttLegkEYg8SeOZ0sRwZSYdfeSIQCrpDQDS/AgDTRmmKnOtOhRNWRMV8YoHx3cQU7ymCxugNnOezO8Dd90HwxrZsPjYQz6La8H7SNhkP7OyDc416RSLu5wP1wN5AjcGi0pm5ISrzLVMoOT0unEpqwbp/WMvmQUHp6KPejB3ioDUq5yz4TCRv9w6aTtoKlH0PC3vRmp+CeDIChjwKXn/WUDU0zzNiRvlU0oX8UaF/t8yrDzUMrrPrOTzJtOitOW6u/uh8g+QkcwEhQ2N4UdmI6/rYE+ZHzR8Yflzp10f2FkAvaZUvQM9EY3Ng7WVgBH1fwtgzcsXcLmgThV/k4gvrmfvBePmD7TSwPOxSXUP2lSKOR1mJxlLfhTfqK+69O8wN8QwErT54zxn7lh5jaXbVqcad0+Gnpi12opoC6/mxcTXJKKgNhwAa+/pDIvr1oWNrnImneuiqiebT+eV12TBxO/Br6epUearQo0aJydtmduzp9d6eLZrAicpnJfO7FXjES/7kLsOy6cYGcIFvb9j88zVXHlNmldJ7LEttTw3emuycnf4p5jXKCTLSthRTgUlfJzFGC9fBi7X7CtHbEyTdVKeGW+EMK2/WVThgNalA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB7104.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(136003)(366004)(346002)(39850400004)(376002)(451199015)(83380400001)(31686004)(4326008)(8936002)(86362001)(5660300002)(31696002)(2906002)(8676002)(186003)(6506007)(6512007)(966005)(6666004)(53546011)(2616005)(66946007)(110136005)(66476007)(316002)(7416002)(41300700001)(66556008)(6486002)(478600001)(66899015)(38100700002)(36756003)(87944006)(99710200001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aDYrRlJCRk40djhScENpTDR1bnlqY2UrcWlrb0Z2a3VTQTJyTkhTTnJwNnNj?=
 =?utf-8?B?ckc2VncwQnpaMURnTk1KWjdMZ0FsdmltOFBZWE1ZNHp5QmRIemJEYkdNNEhF?=
 =?utf-8?B?NFdURzdWeXJ3Z3ZWRXRjdXpiVjVOaWF4VE5DT2FPWVhVVmkzQXkweDZuMSs3?=
 =?utf-8?B?U1RBbERndlpMVGhUL2RxVDQwRXJwZXhkUklVT3RCczAyVEs3Y0w3LzdldmZz?=
 =?utf-8?B?N1Y1ZHp4WG5ucmNtNkNKWmpIR0h4aU5lcnlKVXJ5Y1p5RGJQWFU4ZnM2WlZx?=
 =?utf-8?B?Nkt0SC93MXZjL1RneTErdVV4Q0o2TmdOcEt5L3kwZDhpNFphcVVDUCtrYVlH?=
 =?utf-8?B?VklpWjdLenVLTXRKMU9HNGtIcDJubG1kQy9YcFpLdHM0SVJMamZXN1Rvb21p?=
 =?utf-8?B?MkwzblZyU20wYm1CVEFMbk1mbFdUcForOElYejNVZEh3RUF0QUQyNm80TUFw?=
 =?utf-8?B?R1h0OVV4YVRUMW5JT2IzVzdhM3JBdTl3bVg4UFV0M2lvVzZ6ejM3Wml4SlV6?=
 =?utf-8?B?d1NQTFR6MXhudEtJNWY4My9KQ3JNODlPLzI4bmVINFNOcmZkVkdtNFVDWFcz?=
 =?utf-8?B?WlVqcG43aVNoNGtKUWdvSEZOandxWGhYbml6eVJDMTJndytQMVh2WEZXTzls?=
 =?utf-8?B?MFVVY2UxbC96MS9Qa09ZZU56QS9QZUpxTXU5amNNdGhVVkxLZXpBeUwxWjFF?=
 =?utf-8?B?eW41amNDNjZPT1lTcUpnaHdpOTVwM2ZpNmN1MTR5R0R5WlFmNzk1YlBMcDdS?=
 =?utf-8?B?WE9GcFB0bXVOZ2NTZXVSZDFLUmlDWXVPb0plNEJ1dSs0cUNDVmxuZ3lTWnVY?=
 =?utf-8?B?elNselpjNjlBUWxKQnNyVThGYnEyZ1dwY0hPN2FoeFowVE4xU1YxVlg5NTh1?=
 =?utf-8?B?RENuUmtpa2NXVXFmTHlkcnNpS3YvYURPNm1RbzBxb1dYSWdxdFBrcjFNRlcv?=
 =?utf-8?B?c0s1ZGwrb1gzbDlRWGlFaWRKQVRuNUVYTS9CUnI2eWloajdyclNnMkx3NGhj?=
 =?utf-8?B?OVYrVXIrMEtaTUw2eVFGb2VXU1dmYy9oWHo2Qmk3YS9XbnlHUVNROGNiZ2xq?=
 =?utf-8?B?a3gyK0RwanZkUk5XUnNLNk03VGNYS1Y3cEk4c0p3RWViTjl4MEhGbmpTK0ht?=
 =?utf-8?B?M1FxVW8yVFIrZkxLeGNWenhzSktFdUxRbTRIK2VaT1JlYkFnSlF0cjYvcDBQ?=
 =?utf-8?B?UGZYS0lLeGcvcFpJL2o2R0RuYlhjMXZpdnVSdHVTdnNFcjJsNUpSa3lBQkxY?=
 =?utf-8?B?bTNrT1A2SEU0S0ZzcU5Bd0V3ckhKeFdxQXN5bTFqYWFEaU5uZURZdFE2Yy9I?=
 =?utf-8?B?U0hSNW1GNWNmcDJoY3UyTko0RlpaWXVVL0NUOXk2UGNhY1RCRUJsQlk2TG9X?=
 =?utf-8?B?WHgxd1BVTytEaWVMdWttOEM3dU45WE53azM1WXdzbWdVbHBVOUdlUXYwNWJu?=
 =?utf-8?B?OC94RnNqNklPOEU2VUd6dTR4cElFRUNNTWJZc0dLYU4vK1JwYmtTdXBQTnNM?=
 =?utf-8?B?dDVoUlFtTFcrMmEzdXJ6dExvbjRRQ1JnWHphcGx4Z1pmdFgrUlU4bjZJNGds?=
 =?utf-8?B?cXR5V2pkdUFzOXp1Nm0rKytVVmp1Wk5XeDNsVGorZjErcmN5a1daQm5BL29y?=
 =?utf-8?B?cm0rbkNpc3pPd1NEcStncGdkU3ZYVDdETU1GSk1uMHJrYzhoRFFXamxpS3lB?=
 =?utf-8?B?VDNLZ1lhdWhGVnZ1aFVnZzNGYUwwcjZ2VFRSTEVGL2dWKzVIcUlIdDZobmI5?=
 =?utf-8?B?UFZ0ekY1cDdlZEw1N1lTY21URTFOL2lzSGR5OU44aHYvdXRxQWR5NDViOXh1?=
 =?utf-8?B?MDVDU3dGU0VaSWVUblpEUjg1Q2lweFJSMm1aRGRuQnd2TjgzQm02ai9tYWVa?=
 =?utf-8?B?cTNTSjZ1d1Ivd2xCS29xcmRnNHNuLzAzSnVxaU1KOHNzRXNZM2tiemJCUjhZ?=
 =?utf-8?B?UEd6ZFM5NVcwR0FUbXorUzk0Z2ZjV1FWY2pzZ0Q2ZjlkOFZCMU91MEFSYTRP?=
 =?utf-8?B?OVppYUNvWkxZdjlsRG85Q2ZuTzZTYURWd3dMUitzQlBQbjRwbTBtbHN3QWN3?=
 =?utf-8?B?b0FlbVpBaStVeEFtL2RzQWxjN3RyUFFRZ2dnQXhWaVJnQnlqVVRzejdNRHcw?=
 =?utf-8?B?M3Y0dkMvVUtWQXV0SXhJTy96VHNDVzlvcU43ajlTdXhCbXpEYWprcEEya1Fy?=
 =?utf-8?Q?3BmhI8IY/XJySVK7M1IWkS1euLvnD69fIijF3uJThUph?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a4e876b-239d-471d-896f-08dad929a2f1
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB7104.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2022 14:36:47.9158
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EGFtySo0ELYIDla0P43vYzoxMnFY1zWiGLyvgrYZKGeUGjlwxIKOPE5DiScv/OAkRSaEF3Mjop0PxpH8qrsTxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7759
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06.12.22 16:38, Alan Stern wrote:

Hi,

> Oliver:
> 
> This looks like a bug in the anchor API.

Yes, it does.
  
> On Tue, Dec 06, 2022 at 02:43:41AM -0800, syzbot wrote:
>> Hello,
>>
>> syzbot found the following issue on:
>>
>> HEAD commit:    ef4d3ea40565 afs: Fix server->active leak in afs_put_server
>> git tree:       upstream
>> console output: https://syzkaller.appspot.com/x/log.txt?x=100b244d880000
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=8e7e79f8a1e34200
>> dashboard link: https://syzkaller.appspot.com/bug?extid=712fd0e60dda3ba34642
>> compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
>>
>> Unfortunately, I don't have any reproducer for this issue yet.
>>
>> Downloadable assets:
>> disk image: https://storage.googleapis.com/syzbot-assets/ef790e7777cd/disk-ef4d3ea4.raw.xz
>> vmlinux: https://storage.googleapis.com/syzbot-assets/2ed3c6bc9230/vmlinux-ef4d3ea4.xz
>> kernel image: https://storage.googleapis.com/syzbot-assets/f1dbd004fa88/bzImage-ef4d3ea4.xz
>>
>> IMPORTANT: if you fix the issue, please add the following tag to the commit:
>> Reported-by: syzbot+712fd0e60dda3ba34642@syzkaller.appspotmail.com
>>
>> xpad 3-1:179.65: xpad_irq_in - usb_submit_urb failed with result -19
>> xpad 3-1:179.65: xpad_irq_out - usb_submit_urb failed with result -19
>> ==================================================================
>> BUG: KASAN: use-after-free in register_lock_class+0x8d2/0x9b0 kernel/locking/lockdep.c:1338
>> Read of size 1 at addr ffff88807a58b091 by task kworker/u4:3/46
>>
>> CPU: 0 PID: 46 Comm: kworker/u4:3 Not tainted 6.1.0-rc7-syzkaller-00103-gef4d3ea40565 #0
>> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
>> Workqueue: bat_events batadv_nc_worker
>> Call Trace:
>>   <IRQ>
>>   __dump_stack lib/dump_stack.c:88 [inline]
>>   dump_stack_lvl+0x1e3/0x2cb lib/dump_stack.c:106
>>   print_address_description+0x74/0x340 mm/kasan/report.c:284
>>   print_report+0x107/0x220 mm/kasan/report.c:395
>>   kasan_report+0x139/0x170 mm/kasan/report.c:495
>>   register_lock_class+0x8d2/0x9b0 kernel/locking/lockdep.c:1338
>>   __lock_acquire+0xe4/0x1f60 kernel/locking/lockdep.c:4934
>>   lock_acquire+0x1a7/0x400 kernel/locking/lockdep.c:5668
>>   __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
>>   _raw_spin_lock_irqsave+0xd1/0x120 kernel/locking/spinlock.c:162
>>   __wake_up_common_lock kernel/sched/wait.c:136 [inline]
>>   __wake_up+0xf8/0x1c0 kernel/sched/wait.c:156
>>   __usb_hcd_giveback_urb+0x3a0/0x530 drivers/usb/core/hcd.c:1674


> This is the call to usb_anchor_resume_wakeups().  The call is made after
> the completion handler callback.  Evidently the xpad driver deallocated
> the anchor during that time window.  This can happen if the driver is
> just waiting for its last URB to complete before freeing all its memory.

Yes, complete() had run.
> 
> I don't know what the best solution is.  It may be necessary to refcount
> anchors somehow.

Then we cannot embed them anymore. Many drivers would need a lot of changes.
xpad included.

As far as I can tell the order we decrease use_count is correct. But:

6ec4147e7bdbd (Hans de Goede             2013-10-09 17:01:41 +0200 1674)        usb_anchor_resume_wakeups(anchor);
94dfd7edfd5c9 (Ming Lei                  2013-07-03 22:53:07 +0800 1675)        atomic_dec(&urb->use_count);

Do we need to guarantee memory ordering here?

	Regards
		Oliver
