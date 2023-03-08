Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EFEE6B03D2
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 11:17:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230373AbjCHKRJ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 8 Mar 2023 05:17:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbjCHKRG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 05:17:06 -0500
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE653A5699
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 02:17:04 -0800 (PST)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-94-zZEPLqmLP0yTudXVspLNZQ-1; Wed, 08 Mar 2023 10:17:01 +0000
X-MC-Unique: zZEPLqmLP0yTudXVspLNZQ-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.47; Wed, 8 Mar
 2023 10:16:59 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.047; Wed, 8 Mar 2023 10:16:59 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Chao Yu' <chao@kernel.org>,
        "jaegeuk@kernel.org" <jaegeuk@kernel.org>
CC:     "linux-f2fs-devel@lists.sourceforge.net" 
        <linux-f2fs-devel@lists.sourceforge.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Zhiguo Niu <zhiguo.niu@unisoc.com>
Subject: RE: [PATCH] f2fs: fix unaligned field offset in 32-bits platform
Thread-Topic: [PATCH] f2fs: fix unaligned field offset in 32-bits platform
Thread-Index: AQHZUQf4b45n81mohk6KYf6qmq4uP67wqZ1A
Date:   Wed, 8 Mar 2023 10:16:59 +0000
Message-ID: <942fe8111fdb48e583b846f3e2902228@AcuMS.aculab.com>
References: <20230307151408.58490-1-chao@kernel.org>
In-Reply-To: <20230307151408.58490-1-chao@kernel.org>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,PDS_BAD_THREAD_QP_64,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chao Yu <chao@kernel.org>
> Sent: 07 March 2023 15:14
> 
> F2FS-fs (dm-x): inconsistent rbtree, cur(3470333575168) next(3320009719808)
> ------------[ cut here ]------------
> kernel BUG at fs/f2fs/gc.c:602!
> Internal error: Oops - BUG: 0 [#1] PREEMPT SMP ARM
> PC is at get_victim_by_default+0x13c0/0x1498
> LR is at f2fs_check_rb_tree_consistence+0xc4/0xd4
> ....
> [<c04d98b0>] (get_victim_by_default) from [<c04d4f44>] (f2fs_gc+0x220/0x6cc)
> [<c04d4f44>] (f2fs_gc) from [<c04d4780>] (gc_thread_func+0x2ac/0x708)
> [<c04d4780>] (gc_thread_func) from [<c015c774>] (kthread+0x1a8/0x1b4)
> [<c015c774>] (kthread) from [<c01010b4>] (ret_from_fork+0x14/0x20)
> 
> The reason is there is __packed attribute in struct rb_entry, but there
> is no __packed attribute in struct victim_entry, so wrong offset of key
> field will be parsed in struct rb_entry in f2fs_check_rb_tree_consistence,
> it describes memory layouts of struct rb_entry and struct victim_entry in
> 32-bits platform as below:
> 
> struct rb_entry {
>    [0] struct rb_node rb_node;
>        union {
>            struct {...};
>   [12]     unsigned long long key;
>        } __packed;

This __packed removes the 4-byte pad before the union.
I bet it should be removed...

> }
> size of struct rb_entry: 20
> 
> struct victim_entry {
>    [0] struct rb_node rb_node;
>        union {
>            struct {...};
>   [16]     struct victim_info vi;
>        };
>   [32] struct list_head list;
> }
> size of struct victim_entry: 40
> 
> This patch tries to add __packed attribute in below structure:
> - discard_info, discard_cmd
> - extent_info, extent_node
> - victim_info, victim_entry
> in order to fix this unaligned field offset issue in 32-bits platform.

Have you looked at the amount of extra code that gets generated
on systems that fault misaligned accesses?

Plausibly adding __packed __aligned(4) will restrict the compiler
to just aligning 64bit items on 32bit boundaries.
But even then is you pass the address of a misaligned structure
to another function it will fault later of.

You haven't actually said where the misalignment comes from.
If the code is doing (foo *)(ptr + 1) then that is broken
when the alignments of 'ptr' and 'foo' differ.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

