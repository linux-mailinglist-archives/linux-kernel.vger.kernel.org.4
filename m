Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 020815B62B3
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 23:25:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbiILVZC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 17:25:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbiILVZA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 17:25:00 -0400
Received: from cae.in-ulm.de (cae.in-ulm.de [217.10.14.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E1B70DFAA
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 14:24:55 -0700 (PDT)
Received: by cae.in-ulm.de (Postfix, from userid 1000)
        id 222F214011C; Mon, 12 Sep 2022 23:24:52 +0200 (CEST)
Date:   Mon, 12 Sep 2022 23:24:52 +0200
From:   "Christian A. Ehrhardt" <lk@c--e.de>
To:     Tejun Heo <tj@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] kernfs: fix use-after-free in __kernfs_remove
Message-ID: <Yx+jpDxSjAad+fEq@cae.in-ulm.de>
References: <20220907200811.654034-1-lk@c--e.de>
 <YxojA7pDe8Ur7wpd@slm.duckdns.org>
 <Yxpr4HSSxNw3SDrI@cae.in-ulm.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yxpr4HSSxNw3SDrI@cae.in-ulm.de>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hello, Tejun,

On Fri, Sep 09, 2022 at 12:25:36AM +0200, Christian A. Ehrhardt wrote:
> 
> Hello Tejun,
> 
> On Thu, Sep 08, 2022 at 07:14:43AM -1000, Tejun Heo wrote:
> > Hello, Christian.
> > 
> > On Wed, Sep 07, 2022 at 10:08:11PM +0200, Christian A. Ehrhardt wrote:
> > > Concurrent calls to __kernfs_remove can race on the removal
> > > of the root node: The race occurs if the root node(kn) is freed
> > > during kernfs_drain. The child node(pos) is explicitly protected
> > > with an additional ref count. Do the same for the root node.
> > 
> > I don't think this is right. We don't support parallel invocations of
> > __kernfs_remove() this way. If @kn can be freed during kernfs_drain(), it
> > also means that it can be freed before kernfs_rwsem is grabbed in
> > kernfs_remove().
> 
> Point taken. However, the syzkaller reproducer reliably triggers
> the bug without the patch and the bug is gone with the patch.
> 
> > The caller must be responsible for ensuring that @kn
> > remains allocated. Otherwise, it can't be made reliable.
> 
> In this case the caller of __kernfs_remove is not kernfs_remove but
> kernfs_remove_by_name_ns and it fails to take a reference for the
> node that it looks up and deletes. Thus a second call to
> kernfs_remove_by_name_ns can remove the node while kernfs_drain
> drops the semaphore.
> 
> I'll post an updated patch tomorrow.

Sorry, no patch (yet). But here's the whole story of the initial
syzkaller report (form top to bottom). I'm not sure where we go wrong
but I think several places could do better here:

The code in net/9p/client.c creates one kmem-cache per client session.
All of these kmem caches use the same name ("9p-fcall-cache").
Is it ok to create several kmem caches with the same name? My feeling is
that this is somewhat unexpected but should probably be allowed.

In the setup in question slab caches are not merged. Thus the slub
code uses the kmem cache name directly to create the sysfs directory for
the slub cache. If we allow multiple kmem caches with the same name the
slub code should somehow make the sysfs names unique (e.g. by adding a
serial numer to the name), right?

Before creating the sysfs directory the slub code uses sysfs_remove_link
(aka kernfs_remove_by_name) with the following comment:
"If we have a leftover link remove it." In fact these "leftover"s
are the sysfs files of an active kmem cache with the same name.

Additionally, sysfs_remove_link() looks like a bit of a misnomer
as it removes whatever exists under the given name. This may be a
symlink but it can be an entire directory hierarchy, too.
Is this intentional? At least it's been like that forever.

If kmem cache creation is done in parallel we can now have
concurrent invocations of kernfs_remove_by_name_ns() for the same
parent and the same name. This is what eventually causes the race.

The race is possible as kernfs_remove_by_name_ns() looks up the
name of the target in its parent but does not acquire a ref count
on the target before calling __kernfs_remove(). __kernfs_remove()
may drop the kernfs_rwsem in kernfs_drain(). Thus a concurrent call
to __kernfs_remove can complete the removal except for the nodes
that the first instance of __kernfs_remove() holds refs for.
As explained above no ref is held on the root of the removed tree.
This causes the use-after-free that KASAN sees and complains about.

For kernfs_remove it is reasonable to expect the caller to hold
some kind of reference to prevent this type of race and from a quick
check, the callers seem to get this correct. The only exception that
I could find is kernfs_remove_by_name_ns. This is easy to fix if
kernfs_remove_by_name_ns() hold a reference on the root node across
the call to __kernfs_remove().
IMHO this should be done. Should I sent a patch?

Thanks for bearing with me. Oppinons?

      regards   Christian

