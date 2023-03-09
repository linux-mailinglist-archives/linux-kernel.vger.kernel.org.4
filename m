Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C30D6B326D
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 00:55:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231218AbjCIXy7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 18:54:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229874AbjCIXy6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 18:54:58 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76F585ADCF
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 15:54:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A9AF2B82142
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 23:54:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B879C433EF;
        Thu,  9 Mar 2023 23:54:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678406093;
        bh=NVI2OlJ900G4SGtLDQtVSYp/i7Iky39BU/S4ql+hYwc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Hn5jbEneu117NrVW3NwCd1ZDLW+pw4VrpIEutwIq2nYwpnuf+CM/KuonptYSnp8wP
         WA0o6VlL1aWQMsFe6V+4BugCw2h1Vq2Csr+OhNpN04jITeuJbIEOQIInYuzXIlsDMx
         +QZLVeScEdSjyA3+/htoEKcE7excUib6hay0574yCYfQBJC916HOT5S+J1y7KC4GRq
         n5MEPh4Uf6qKw9RYySUxMb2ImjAMtCi0LQQdqG/F4Z0LgtqkoS48fN/qTwnOIqHLcH
         LxaRI2gvbakexrA3KUDNmA6t7iXYCK6X/yFW4o7zdy/beWZvPLXrkKk05OE3T22uAk
         DsoX4CGJ6+ibA==
Date:   Thu, 9 Mar 2023 15:54:51 -0800
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     David Laight <David.Laight@aculab.com>
Cc:     'Chao Yu' <chao@kernel.org>,
        "linux-f2fs-devel@lists.sourceforge.net" 
        <linux-f2fs-devel@lists.sourceforge.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Zhiguo Niu <zhiguo.niu@unisoc.com>
Subject: Re: [PATCH] f2fs: fix unaligned field offset in 32-bits platform
Message-ID: <ZApxy2u9j3yKFRyS@google.com>
References: <20230307151408.58490-1-chao@kernel.org>
 <942fe8111fdb48e583b846f3e2902228@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <942fe8111fdb48e583b846f3e2902228@AcuMS.aculab.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/08, David Laight wrote:
> From: Chao Yu <chao@kernel.org>
> > Sent: 07 March 2023 15:14
> > 
> > F2FS-fs (dm-x): inconsistent rbtree, cur(3470333575168) next(3320009719808)
> > ------------[ cut here ]------------
> > kernel BUG at fs/f2fs/gc.c:602!
> > Internal error: Oops - BUG: 0 [#1] PREEMPT SMP ARM
> > PC is at get_victim_by_default+0x13c0/0x1498
> > LR is at f2fs_check_rb_tree_consistence+0xc4/0xd4
> > ....
> > [<c04d98b0>] (get_victim_by_default) from [<c04d4f44>] (f2fs_gc+0x220/0x6cc)
> > [<c04d4f44>] (f2fs_gc) from [<c04d4780>] (gc_thread_func+0x2ac/0x708)
> > [<c04d4780>] (gc_thread_func) from [<c015c774>] (kthread+0x1a8/0x1b4)
> > [<c015c774>] (kthread) from [<c01010b4>] (ret_from_fork+0x14/0x20)
> > 
> > The reason is there is __packed attribute in struct rb_entry, but there
> > is no __packed attribute in struct victim_entry, so wrong offset of key
> > field will be parsed in struct rb_entry in f2fs_check_rb_tree_consistence,
> > it describes memory layouts of struct rb_entry and struct victim_entry in
> > 32-bits platform as below:
> > 
> > struct rb_entry {
> >    [0] struct rb_node rb_node;
> >        union {
> >            struct {...};
> >   [12]     unsigned long long key;
> >        } __packed;
> 
> This __packed removes the 4-byte pad before the union.
> I bet it should be removed...

struct rb_node {
        unsigned long  __rb_parent_color;
        struct rb_node *rb_right;
        struct rb_node *rb_left;
} __attribute__((aligned(sizeof(long))));

Hmm, isn't this aligned to 32bits originally? Why does 32bits pad 4-bytes
if we remove __packed?

> 
> > }
> > size of struct rb_entry: 20
> > 
> > struct victim_entry {
> >    [0] struct rb_node rb_node;
> >        union {
> >            struct {...};
> >   [16]     struct victim_info vi;
> >        };
> >   [32] struct list_head list;
> > }
> > size of struct victim_entry: 40
> > 
> > This patch tries to add __packed attribute in below structure:
> > - discard_info, discard_cmd
> > - extent_info, extent_node
> > - victim_info, victim_entry
> > in order to fix this unaligned field offset issue in 32-bits platform.
> 
> Have you looked at the amount of extra code that gets generated
> on systems that fault misaligned accesses?
> 
> Plausibly adding __packed __aligned(4) will restrict the compiler
> to just aligning 64bit items on 32bit boundaries.
> But even then is you pass the address of a misaligned structure
> to another function it will fault later of.
> 
> You haven't actually said where the misalignment comes from.
> If the code is doing (foo *)(ptr + 1) then that is broken
> when the alignments of 'ptr' and 'foo' differ.

IIUC, the problem comes since we access the same object with two structures
to handle rb_tree.

E.g.,

[struct extent_node]                   [struct rb_entry]
struct rb_node rb_node;                struct rb_node rb_node;
                                       union {
struct extent_info ei;                   struct {
  unsigned int fofs;                       unsigned int ofs;
  unsigned int len;                        unsigned int len;
                                         };
                                         unsigned long long key;
                                       } __packed;

So, I think if we get a different offset of fofs or ofs between in
extent_node and rb_entry, further work'll access a wrong memory since
we simply cast the object pointer between two.

> 
> 	David
> 
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)
