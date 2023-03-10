Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E95D26B3A7B
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 10:31:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230145AbjCJJbg convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 10 Mar 2023 04:31:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230344AbjCJJbO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 04:31:14 -0500
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E94F928218
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 01:28:34 -0800 (PST)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-159-vKUi8V-KMYKHbSDPHvzBqg-1; Fri, 10 Mar 2023 09:28:22 +0000
X-MC-Unique: vKUi8V-KMYKHbSDPHvzBqg-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.47; Fri, 10 Mar
 2023 09:28:19 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.047; Fri, 10 Mar 2023 09:28:19 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Jaegeuk Kim' <jaegeuk@kernel.org>
CC:     'Chao Yu' <chao@kernel.org>,
        "linux-f2fs-devel@lists.sourceforge.net" 
        <linux-f2fs-devel@lists.sourceforge.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Zhiguo Niu <zhiguo.niu@unisoc.com>
Subject: RE: [PATCH] f2fs: fix unaligned field offset in 32-bits platform
Thread-Topic: [PATCH] f2fs: fix unaligned field offset in 32-bits platform
Thread-Index: AQHZUQf4b45n81mohk6KYf6qmq4uP67wqZ1AgAJ5ZoCAAJUJQA==
Date:   Fri, 10 Mar 2023 09:28:19 +0000
Message-ID: <362576043b2f4c56a3ea112364d04fcd@AcuMS.aculab.com>
References: <20230307151408.58490-1-chao@kernel.org>
 <942fe8111fdb48e583b846f3e2902228@AcuMS.aculab.com>
 <ZApxy2u9j3yKFRyS@google.com>
In-Reply-To: <ZApxy2u9j3yKFRyS@google.com>
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

From: Jaegeuk Kim
> Sent: 09 March 2023 23:55
> 
> On 03/08, David Laight wrote:
> > From: Chao Yu <chao@kernel.org>
> > > Sent: 07 March 2023 15:14
> > >
> > > F2FS-fs (dm-x): inconsistent rbtree, cur(3470333575168) next(3320009719808)
> > > ------------[ cut here ]------------
> > > kernel BUG at fs/f2fs/gc.c:602!
> > > Internal error: Oops - BUG: 0 [#1] PREEMPT SMP ARM
> > > PC is at get_victim_by_default+0x13c0/0x1498
> > > LR is at f2fs_check_rb_tree_consistence+0xc4/0xd4
> > > ....
> > > [<c04d98b0>] (get_victim_by_default) from [<c04d4f44>] (f2fs_gc+0x220/0x6cc)
> > > [<c04d4f44>] (f2fs_gc) from [<c04d4780>] (gc_thread_func+0x2ac/0x708)
> > > [<c04d4780>] (gc_thread_func) from [<c015c774>] (kthread+0x1a8/0x1b4)
> > > [<c015c774>] (kthread) from [<c01010b4>] (ret_from_fork+0x14/0x20)
> > >
> > > The reason is there is __packed attribute in struct rb_entry, but there
> > > is no __packed attribute in struct victim_entry, so wrong offset of key
> > > field will be parsed in struct rb_entry in f2fs_check_rb_tree_consistence,
> > > it describes memory layouts of struct rb_entry and struct victim_entry in
> > > 32-bits platform as below:
> > >
> > > struct rb_entry {
> > >    [0] struct rb_node rb_node;
> > >        union {
> > >            struct {...};
> > >   [12]     unsigned long long key;
> > >        } __packed;
> >
> > This __packed removes the 4-byte pad before the union.
> > I bet it should be removed...
> 
> struct rb_node {
>         unsigned long  __rb_parent_color;
>         struct rb_node *rb_right;
>         struct rb_node *rb_left;
> } __attribute__((aligned(sizeof(long))));
> 
> Hmm, isn't this aligned to 32bits originally? Why does 32bits pad 4-bytes
> if we remove __packed?

That attribute is entirely pointless.
IIRC It is a request to increase the alignment to that of long.
It wouldn't have any effect even if 'packed' was also specified.
(Unless you are building for 64-bit windows.)

The 'issue' is that on arm32 (unlike x86) 'long long' has
64bit alignment.
So without the __packed on the union there is a 4 byte hole
before the union.

...
> IIUC, the problem comes since we access the same object with two structures
> to handle rb_tree.
> 
> E.g.,
> 
> [struct extent_node]                   [struct rb_entry]
> struct rb_node rb_node;                struct rb_node rb_node;
>                                        union {
> struct extent_info ei;                   struct {
>   unsigned int fofs;                       unsigned int ofs;
>   unsigned int len;                        unsigned int len;
>                                          };
>                                          unsigned long long key;
>                                        } __packed;
> 
> So, I think if we get a different offset of fofs or ofs between in
> extent_node and rb_entry, further work'll access a wrong memory since
> we simply cast the object pointer between two.

That example actually happens to work.
But replace 'unsigned int' with 'long long' and it all fails.

That is horribly broken (by design).
You can't do that and expect it to work at all.
This is another case where you don't want __packed, but to
request a compilation error if padding was added.

The safest 'fix' (it is still broken by design) is to change the
alignment of rb_node to be that of 'long long' and remove the
__packed from the union.
That adds a 4 byte pad to rb_node on some, but not all, 32bit
architectures.
Then all the code that used the above pattern is (probably) ok.

You can use (if I've spelt them right) aligned(Alignof(long long))
but not aligned(__alignof(long long)) because the latter returns
the preferred alignment not the actual alignment (8 not 4 on x86).
I think Alignof() is ok for current kernels, but not for anything
that might get backported to stable.
You can use __alignof(struct {long long x;}).

Actually this should also work:
struct rb_node {
    union {
        long long alignment;
        struct {
            unsigned long  __rb_parent_color;
            struct rb_node *rb_right;
            struct rb_node *rb_left;
        }
    }
};

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

