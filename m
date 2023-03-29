Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4060D6CD193
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 07:31:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229745AbjC2Fbl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 01:31:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbjC2Fbi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 01:31:38 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 915A635A7;
        Tue, 28 Mar 2023 22:31:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=e5fT7dqvTNJ/xLBKHYNfH3/nkMLFYlXtzKUuMccnRc8=; b=FwiA+X451qkIX+hLGyF4YNnBO6
        WbwXp8Bqlm9jXokJrOs78YlwixENqY/5rWgSgup9n4SzwGMM1nbZPD/uFWFPeI8pk857v9p1inpWK
        GlgZvD5QPuqiDRxlV80+DpYvHFIjjGf8W60qfagKKgYVNMU7d6ThdcUIdbTmAdTOyIx+ArUyXyRyB
        nQa19IcRGFuKYOHQcxO1HWFv1eUBSqvniRDbx4moxm62aN2UmkXUZVMyzQwm40N0QJj2i9rIn1hi0
        SaoQkrj0u4K4teFg9cAtfoTKzxD/AWNjiItVJFLymbSt/LN3XS1mk1Sz40/X34O3zYx3pcnMLRXgA
        KAZKI0xw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1phOPI-00GgKV-0z;
        Wed, 29 Mar 2023 05:31:36 +0000
Date:   Tue, 28 Mar 2023 22:31:36 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     Kees Cook <keescook@chromium.org>, linux-modules@vger.kernel.org,
        linux-kernel@vger.kernel.org, pmladek@suse.com,
        petr.pavlu@suse.com, prarit@redhat.com,
        christophe.leroy@csgroup.eu, song@kernel.org,
        torvalds@linux-foundation.org, dave@stgolabs.net,
        fan.ni@samsung.com, vincent.fu@samsung.com,
        a.manzanares@samsung.com, colin.i.king@gmail.com
Subject: Re: [RFC 00/12] module: avoid userspace pressure on unwanted
 allocations
Message-ID: <ZCPNONX3O3bp2Om1@bombadil.infradead.org>
References: <ZBjLp4YvN1m/cR4G@bombadil.infradead.org>
 <c0b2d9d0-ef5e-8c46-109e-742dbec8a07b@redhat.com>
 <ZBjO2LqBkayxG+Sd@bombadil.infradead.org>
 <ZBjPtV7xrAQ/l9nD@bombadil.infradead.org>
 <bb6e15e0-2831-6352-82c8-92648a29fb0b@redhat.com>
 <582aa586-e69c-99bb-caf8-eda468c332b6@redhat.com>
 <ZB3j3x4F2ozYX8UI@bombadil.infradead.org>
 <e5c2183a-f62a-6ca9-eec6-a7fab7ce4c91@redhat.com>
 <ZCKGI1LxktS7pKS9@bombadil.infradead.org>
 <5aceccdf-d268-7872-abb5-c14e9aa8b7b7@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5aceccdf-d268-7872-abb5-c14e9aa8b7b7@redhat.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 28, 2023 at 11:02:49PM +0200, David Hildenbrand wrote:
> 
> So we're a bit faster (0.2 -- 0.7s) than the original version without the
> rcu patch (~6s).

Groovy.

> > The commit log needs updateing to reflect the results I just collected:
> > 
> > With the alloc patch ("module: avoid allocation if module is already
> > present and ready") I see 145 MiB in memory difference in comparison
> > to its last patch, "module: extract patient module check into helper".
> > So I think that's a clear keeper and should help large CPU count boots.
> > 
> > The patch "module: add concurrency limiter" which puts the concurency
> > delimiter on the kread only saves about 2 MiB with 100 stress-ng ops,
> > which seems to be what I needed to reproduce your 400 CPU count original
> > issue.
> > 
> > The program used to reproduce is stress-ng with the new module option:
> > 
> > echo 0 > /proc/sys/vm/oom_dump_tasks
> > ./stress-ng --module 100 --module-name xfs
> 
> Above command fills for me with nfs (but also ext4) the kernel log with:
> 
> ...
> [  883.036035] nfs: Unknown symbol xdr_reserve_space (err -2)
> [  883.042221] nfs: Unknown symbol rpc_init_wait_queue (err -2)
> [  883.048549] nfs: Unknown symbol put_rpccred (err -2)
> [  883.054104] nfs: Unknown symbol __fscache_invalidate (err -2)
> [  883.060540] nfs: Unknown symbol __fscache_use_cookie (err -2)
> [  883.066969] nfs: Unknown symbol rpc_clnt_xprt_switch_has_addr (err -2)
> [  883.074264] nfs: Unknown symbol __fscache_begin_write_operation (err -2)
> [  883.081743] nfs: Unknown symbol nlmclnt_init (err -2)
> [  883.087396] nfs: Unknown symbol nlmclnt_done (err -2)
> [  883.093074] nfs: Unknown symbol nfs_debug (err -2)
> [  883.098429] nfs: Unknown symbol rpc_wait_for_completion_task (err -2)
> [  883.105640] nfs: Unknown symbol __fscache_acquire_cookie (err -2)
> [  883.163764] nfs: Unknown symbol rpc_put_task (err -2)
> [  883.169461] nfs: Unknown symbol __fscache_acquire_volume (err -2)
> [  883.176297] nfs: Unknown symbol rpc_proc_register (err -2)
> [  883.182430] nfs: Unknown symbol rpc_shutdown_client (err -2)
> [  883.188765] nfs: Unknown symbol rpc_clnt_show_stats (err -2)
> [  883.195097] nfs: Unknown symbol __fscache_begin_read_operation (err -2)
> ...
> 
> 
> I do *not* get these errors on manual morprobe/rmmod. BUG in concurrent
> handling or just side-effect of the concurrent loading?

It is just because modprobe deals with module dependencies, stress-ng
modprobe doesn't, it just calls finit_module() and expects dependencies
to be loaded first.

> > To see how much max memory I use, I just use:
> > 
> > free -k -s 1 -c 40 | grep Mem | awk '{print $3}' > foo.log
> > 
> > Run the test in another window, CTRL-C the test when above
> > finishes after 40 seconds and then:
> > 
> > sort -n -r foo.log  | head -1
> 
> [root@lenovo-sr950-01 fs]# sort -n -r foo.log  | head -1
> 14254024
> [root@lenovo-sr950-01 fs]# sort -n -r foo.log  | tail -1
> 12862528
> 
> So 1391496 (KiB I assume, so 1.3 GiB !?)

That is sadly correct.

> difference compared to before the
> test (I first start capturing and then run stress-ng).

That's a good chunk :-D

On a recent thread I do a full analysis of average module sizes [0], you
can use that to also get an average size estimate of your currently
loaded modules. Do a bit of math and that could give you the average
memory pressure on real vmap allocations. For a synthentic test as with
stress-ng modules we'd be doing twice the memory for a success load, and
only one time allocation due to kread for a failed allocation, since we
always allocate memory even for bogus modules on the kread side.

My xfs.ko is 42M on my test guest system, with 100 concurrent threads
doing two allocations each that puts the expected vmap allocation at
around:

42*2*100
8400
8400/1024
8.20312500000000000000

8.2 GiB

So on the worst case that's what we'd see. Since I saw seeing the
patches helped overall around 145 MiB in difference let's see what
that means. Let me re-test:

Idle memory: (note free -k uses kibibytes, KiB.

root@kmod ~ # free -k -s 1 -c 3 | grep Mem | awk '{print $3}' | sort -n -r  | head -1
416452

So while idle, the system is using up 416452 KiB, so 406 MiB.

While running stress-ng with 100 module ops

free -k -s 1 -c 40 | grep Mem | awk '{print $3}' > 2023-03-28-kmodsem-stress-ng-v1.txt
echo 0 > /proc/sys/vm/oom_dump_tasks
./stress-ng --module 100 --module-name xfs
root@kmod ~ # sort -n -r 2023-03-28-kmodsem-stress-ng-v1.txt | head -1
4886492

4886492/1024
4771.96484375000000000000
4886492/1024/1024
4.66012191772460937500

So during the stress test we see memory highest usage was about
4771.96 MiB or ~4.66 GiB.

What's the difference between idle and after the stress test:

4886492 - 416452
4470040
4470040/1024
4365.27343750000000000000
4470040/1024/1024
4.26296234130859375000

So about 4365.27 MiB or 4.26 GiB.

Now, the upper limit for the test should have been a delta of 8.2 GiB
and we get about 4.26, so it means we're rejecting more than half of
the requests. Why half not just half? I only see 40 successful loads
of XFS during a 40 second window:

  dmesg -c > /dev/null
  # run tests
  dmesg -c | grep XFS | wc -l

At 100 ops all running finit_module for 40 seconds those successful
loads only should have consumed about 40 * 2 * size of XFS (42 MiB):
3360 MiB or 3.28 GiB. But at any point in time only one module could
be loaded at a time, so in the *worst* consumption point a XFS in this
test should only be consuming 2*size_of_XFS(42 MiB) so 84 MiB.

4365.27 - 84
4281.27

So about 4281.27 MiB (4.18 GiB) are consumed by the 98.07% of the
failed module loads due to the kread*() calls from finit_module().

And get this... *if* you use module compression that also uses vmap()
*after* the kernel_read*() call which uses vmalloc(). *At least* in
that case we immediately free the buffer for the compressed module,
but *still* -- that is 3 possible vmap space allocations for every
module!

It'd be hard, but not impossible to collect stats for failed
finit_modules(). *That* could be indicative of areas in the kernel
we need to brush up on to stop doing stupid things, like we learned
about for the CPU frequency scaling modules. As I wrote this paragraph
I realized -- that this *is*  what we really have wanted all along to
help us debug these stupid things, so we can slowly learn where to
point fingers at to help optimize things. Altough I recently did some
tool scraping to collect stats and *wished* for this from userspace [0],
it wasn't hard to just a debug option for this to help us debug these
failures. So I added support for that and sent finally a new patch
series.

[0] https://lkml.kernel.org/r/CAB=NE6UTC4VkNM57GGJ3XkG_PWLkMfXv2e2=yQJhtM6Fc-uMsQ@mail.gmail.com

> > If you have xfs loaded already you probably wanna pick module just as big
> > that you don't have loaded. You must have dependencies loaded already as
> > it doesn't call modprobe, it just finit_module's the module.
> 
> My setup already has xfs in use. nfs and ext4 are a bit smaller, but still
> big.

Sure.

  Luis
