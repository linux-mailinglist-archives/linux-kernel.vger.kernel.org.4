Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 569E15B37C1
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 14:28:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230369AbiIIMZX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 08:25:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231274AbiIIMZS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 08:25:18 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66592E4DF3
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 05:25:14 -0700 (PDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 289AIRCT022631;
        Fri, 9 Sep 2022 12:24:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : references : date : in-reply-to : message-id : mime-version :
 content-type; s=pp1; bh=v5bvn163iwGf4Ju6erOb8jNBok75yN9g8F0tQULJJKg=;
 b=Ovo7dPdanuOJfsRkUJQLtgwWTsF8JXYTAGQqFcPe6nKvlbJUBhMh6Na3Zzptk0XLnndX
 hFRAAGZQZfLfls5JmGdEEztGcIDm83CIqHZXKDLKTeW+NGuBvU+fBMvznpRT3VLCE5+a
 EiBf8MdkSmD156TZQwsExaL59t6re1w1R29XOGofntGWY3BnOg6y43aRXJIkFezRnfnB
 8Xz7C5ADXhw+VR+ROp3+VKHrc94Ho6j+hwCBzAH41wPvFB2Qd3ODeq20TUy0E9VvK3Ep
 etGNf0n0v5NxTDs23aitAgWkFUaVZj1z6zGGtI7ZAX8nBBLpTyxIw8DwNfBNbwrkYzLU 6w== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jg3fnuy89-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 09 Sep 2022 12:24:36 +0000
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 289C5fQN031726;
        Fri, 9 Sep 2022 12:24:36 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jg3fnuy7b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 09 Sep 2022 12:24:36 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 289CKC2W025211;
        Fri, 9 Sep 2022 12:24:34 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma04ams.nl.ibm.com with ESMTP id 3jbxj8yy4t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 09 Sep 2022 12:24:34 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 289COWiq33816946
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 9 Sep 2022 12:24:32 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E46544C040;
        Fri,  9 Sep 2022 12:24:31 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 813654C044;
        Fri,  9 Sep 2022 12:24:31 +0000 (GMT)
Received: from tuxmaker.linux.ibm.com (unknown [9.152.85.9])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Fri,  9 Sep 2022 12:24:31 +0000 (GMT)
From:   Sven Schnelle <svens@linux.ibm.com>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Valentin Schneider <vschneid@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Alexey Klimov <klimov.linux@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andy Whitcroft <apw@canonical.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        David Laight <David.Laight@aculab.com>,
        Dennis Zhou <dennis@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Kees Cook <keescook@chromium.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Russell King <linux@armlinux.org.uk>
Subject: Re: [PATCH v3 3/4] lib/find_bit: optimize find_next_bit() functions
References: <20220827175807.4017673-1-yury.norov@gmail.com>
        <20220827175807.4017673-4-yury.norov@gmail.com>
        <xhsmhfsh3b15v.mognet@vschneid.remote.csb>
        <YxjNeqLjGgRPIm+y@yury-laptop>
Date:   Fri, 09 Sep 2022 14:24:31 +0200
In-Reply-To: <YxjNeqLjGgRPIm+y@yury-laptop> (Yury Norov's message of "Wed, 7
        Sep 2022 09:57:30 -0700")
Message-ID: <yt9dv8pwspkw.fsf@linux.ibm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: tmaO4FLZDO1dXpsVbhO68qnjb8rk7s9r
X-Proofpoint-ORIG-GUID: moCwVTLU5z8H75NZX0MVjH1U1210AlIs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-09_06,2022-09-09_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 impostorscore=0 phishscore=0 mlxlogscore=323 priorityscore=1501
 malwarescore=0 spamscore=0 clxscore=1011 adultscore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2209090042
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yury,

Yury Norov <yury.norov@gmail.com> writes:

> On Wed, Sep 07, 2022 at 05:27:08PM +0100, Valentin Schneider wrote:
>> On 27/08/22 10:58, Yury Norov wrote:
>> > +#define FIND_NEXT_BIT(FETCH, MUNGE, size, start)				\
>> > +({										\
>> > +	unsigned long mask, idx, tmp, sz = (size), __start = (start);		\
>> > +										\
>> > +	if (unlikely(__start >= sz))						\
>> > +		goto out;							\
>> > +										\
>> > +	mask = MUNGE(BITMAP_FIRST_WORD_MASK(__start));				\
>> > +	idx = __start / BITS_PER_LONG;						\
>> > +										\
>> > +	for (tmp = (FETCH) & mask; !tmp; tmp = (FETCH)) {			\
>> > +		if (idx > sz / BITS_PER_LONG)					\
>> 
>> Does that want to be
>
> Yes, I already fixed this.
>  
>>                 if (idx + 1 >= sz / BITS_PER_LONG)
>> 
>> ?

Did you push that already? We're still seeing crashes in CI, and the
'idx + 1' doesnt seem to be in next-20220908. Adding it makes the
out-of-bound access go away, but the kernel will crash later in the
block mq code:

[    0.760803] NET: Registered PF_PACKET protocol family
[    0.760808] bridge: filtering via arp/ip/ip6tables is no longeravailable by default. Update your scripts to load br_netfilter if youneed this.
[    0.760938] Key type dns_resolver registered
[    0.760967] cio: Channel measurement facility initialized using format extended (mode autodetected)
[    0.761789] dasd-eckd 0.0.3850: A channel path to the device has become operational
[    0.762577] dasd-eckd 0.0.3850: A channel path to the device has become operational
[    0.772623] dasd-eckd 0.0.3850: New DASD 3390/0C (CU 3990/01) with 30051 cylinders, 15 heads, 224 sectors
[    0.806105] dasd-eckd 0.0.3850: DASD with 4 KB/block, 21636720 KB total size, 48 KB/track, compatible disk layout
[    0.806131] Unable to handle kernel pointer dereference in virtual kernel address space
[    0.806132] Failing address: fffffffffffff000 TEID: fffffffffffff803
[    0.806134] Fault in home space mode while using kernel ASCE.
[    0.806137] AS:0000000001f14007 R3:0000000081360007 S:0000000000000020
[    0.806154] Oops: 0038 ilc:2 [#1] SMP
[    0.806333] Modules linked in:
[    0.806337] CPU: 0 PID: 42 Comm: kworker/0:3 Not tainted 6.0.0-rc4-next-20220908-dirty #463
[    0.806339] Hardware name: IBM 3906 M04 704 (z/VM 7.1.0)
[    0.806340] Workqueue: events do_kick_device
[    0.806344] Krnl PSW : 0704c00180000000 0000000000811ee4 (blk_rq_merge_ok+0x1c/0x120)
[    0.806362]            R:0 T:1 IO:1 EX:1 Key:0 M:1 W:0 P:0 AS:3 CC:0 PM:0 RI:0 EA:3
[    0.806368] Krnl GPRS: 8000000000000001 00000000018461e0 ffffffffffffffb8 0000000080ac6200
[    0.806379]            00000000ffffbfff 00000000fee80000 0000000001fbe4a8 00000000822cbda0
[    0.806387]            0000000000000008 0000000080ac6200 000003ff7f842108 ffffffffffffffb8
[    0.806390]            00000000822aa100 00000380003b78d0 00000380003b7590 00000380003b7550
[    0.806413] Krnl Code: 0000000000811ed4: b90400ef            lgr     %r14,%r15
[    0.806413]            0000000000811ed8: e3f0ffc0ff71        lay     %r15,-64(%r15)
[    0.806413]           #0000000000811ede: e3e0f0980024        stg     %r14,152(%r15)
[    0.806413]           >0000000000811ee4: 58102018            l       %r1,24(%r2)
[    0.806413]            0000000000811ee8: 4210f0a7            stc     %r1,167(%r15)
[    0.806413]            0000000000811eec: ec4138bf0055        risbg   %r4,%r1,56,191,0
[    0.806413]            0000000000811ef2: b90400b2            lgr     %r11,%r2
[    0.806413]            0000000000811ef6: b90400a3            lgr     %r10,%r3
[    0.806427] Call Trace:
[    0.806431]  [<0000000000811ee4>] blk_rq_merge_ok+0x1c/0x120
[    0.806470]  [<0000000000d07a5a>] blk_bio_list_merge+0x7a/0xd0
[    0.806474]  [<0000000000820456>] blk_mq_sched_bio_merge+0xde/0x150
[    0.806478]  [<0000000000815110>] blk_mq_get_new_requests+0x88/0x190
[    0.806481]  [<000000000081a346>] blk_mq_submit_bio+0x286/0x438
[    0.806484]  [<00000000008090d2>] __submit_bio+0x12a/0x1d8
[    0.806498]  [<0000000000809738>] submit_bio_noacct_nocheck+0xa0/0xf8
[    0.806502]  [<000000000047e02e>] submit_bh_wbc+0x16e/0x1b0
[    0.806505]  [<0000000000481384>] block_read_full_folio+0x2ec/0x400
[    0.806508]  [<0000000000348518>] filemap_read_folio+0x38/0xc8
[    0.806512]  [<000000000034998e>] do_read_cache_folio+0x13e/0x1e8
[    0.806516]  [<0000000000349a60>] read_cache_folio+0x28/0x38
[    0.806520]  [<0000000000826d56>] read_part_sector+0x5e/0xe8
[    0.806524]  [<0000000000828ed4>] read_lba+0xb4/0x170
[    0.806528]  [<00000000008294d6>] find_valid_gpt.constprop.0+0xde/0x568
[    0.806532]  [<0000000000829c92>] efi_partition+0x332/0x398
[    0.806559]  [<0000000000826586>] check_partition+0x12e/0x248
[    0.806567]  [<0000000000826a1c>] bdev_disk_changed.part.0+0xcc/0x378
[    0.806578]  [<0000000000ca8016>] dasd_scan_partitions+0x76/0x120
[    0.806582]  [<0000000000ca1018>] dasd_change_state+0x310/0x3a0
[    0.806584]  [<0000000000ca10e8>] do_kick_device+0x40/0xc8
[    0.806587]  [<0000000000174ae0>] process_one_work+0x200/0x458
[    0.806591]  [<000000000017526e>] worker_thread+0x66/0x480
[    0.806594]  [<000000000017cf98>] kthread+0x108/0x110
[    0.806596]  [<0000000000103354>] __ret_from_fork+0x3c/0x58
[    0.806600]  [<0000000000d1eb0a>] ret_from_fork+0xa/0x40
[    0.806604] Last Breaking-Event-Address:
[    0.806606]  [<0000000000d07a54>] blk_bio_list_merge+0x74/0xd0
[    0.806610] Kernel panic - not syncing: Fatal exception: panic_on_oops

Reverting the 'lib/find_bit: optimize find_next_bit() functions' patch
'fixes' these issues.

Regards
Sven
