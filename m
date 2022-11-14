Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC24162841C
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 16:38:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236919AbiKNPid (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 10:38:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236124AbiKNPib (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 10:38:31 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6813BBB8;
        Mon, 14 Nov 2022 07:38:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=uZjZHgVZVYg09RCV/ZTHwTfPg4g7gHQcNAZSrhfP1yM=; b=RLG9JtfNVlXDGmV0guc6KvbTz3
        fh8FFURX7gYuI3TIW9ZnqLfXE9CudFz+ZRU/xNGIZL+n+/t92bbez8w7h9/6YdpssgK7ZBtr4ZzmK
        iffoMPI7rdAa/jDBSZZ6DwpFBxZ2NzArKVyM4YDcesekoirLhHJ+SbZ2JpyIsL+tEyOF/6JJ/hElm
        MlGz3bxpExPImeok3oDW8t+6+b2ESDfo46zEKmtU/aJO/fnXcVwDDc/wVMGkl+cUty1qyCNpM5c9v
        TtzmYK4gbfYpiZ3TNFsowHkEippuBtOabOr0naWjCiO/GCCISKIZaShN0UqAg+TrQRKr0eI7m10Uv
        OzMCtGRw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oubXV-002IRv-CR; Mon, 14 Nov 2022 15:38:25 +0000
Date:   Mon, 14 Nov 2022 07:38:25 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     Prarit Bhargava <prarit@redhat.com>, pmladek@suse.com,
        Petr Pavlu <petr.pavlu@suse.com>,
        linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] module: Merge same-name module load requests
Message-ID: <Y3Jg8X7qv2AKPU1J@bombadil.infradead.org>
References: <20220919123233.8538-1-petr.pavlu@suse.com>
 <20220919123233.8538-3-petr.pavlu@suse.com>
 <YzdR0gRNQI2BGnJ9@bombadil.infradead.org>
 <aa8d9456-b260-d999-0296-8e6ab876af7a@suse.com>
 <Y07xX2ejlg0oFoEy@bombadil.infradead.org>
 <d0bc50e3-0e42-311b-20ed-7538bb918c5b@suse.com>
 <Y277Jb9i2VeXQoTL@bombadil.infradead.org>
 <e070839f-c224-047b-9411-91143c1d8394@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e070839f-c224-047b-9411-91143c1d8394@redhat.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 14, 2022 at 09:57:56AM +0100, David Hildenbrand wrote:
> On 12.11.22 02:47, Luis Chamberlain wrote:
> > On Wed, Oct 19, 2022 at 02:00:55PM +0200, Petr Pavlu wrote:
> > > On 10/18/22 20:33, Luis Chamberlain wrote:
> > > > On Sat, Oct 15, 2022 at 11:27:10AM +0200, Petr Pavlu wrote:
> > > > > The patch does address a regression observed after commit 6e6de3dee51a
> > > > > ("kernel/module.c: Only return -EEXIST for modules that have finished
> > > > > loading"). I guess it can have a Fixes tag added to the patch.
> > > > > 
> > > > > I think it is hard to split this patch into parts because the implemented
> > > > > "optimization" is the fix.
> > > > 
> > > > git describe --contains 6e6de3dee51a
> > > > v5.3-rc1~38^2~6
> > > > 
> > > > I'm a bit torn about this situation. Reverting 6e6de3dee51a would be the
> > > > right thing to do, but without it, it still leaves the issue reported
> > > > by Prarit Bhargava. We need a way to resolve the issue on stable and
> > > > then your optimizations can be applied on top.
> > > 
> > > Simpler could be to do the following:
> > > 
> > > diff --git a/kernel/module/main.c b/kernel/module/main.c
> > > index d02d39c7174e..0302ac387e93 100644
> > > --- a/kernel/module/main.c
> > > +++ b/kernel/module/main.c
> > > @@ -2386,7 +2386,8 @@ static bool finished_loading(const char *name)
> > >   	sched_annotate_sleep();
> > >   	mutex_lock(&module_mutex);
> > >   	mod = find_module_all(name, strlen(name), true);
> > > -	ret = !mod || mod->state == MODULE_STATE_LIVE;
> > > +	ret = !mod || mod->state == MODULE_STATE_LIVE
> > > +		|| mod->state == MODULE_STATE_GOING;
> > >   	mutex_unlock(&module_mutex);
> > >   	return ret;
> > > @@ -2566,7 +2567,8 @@ static int add_unformed_module(struct module *mod)
> > >   	mutex_lock(&module_mutex);
> > >   	old = find_module_all(mod->name, strlen(mod->name), true);
> > >   	if (old != NULL) {
> > > -		if (old->state != MODULE_STATE_LIVE) {
> > > +		if (old->state == MODULE_STATE_COMING
> > > +		    || old->state == MODULE_STATE_UNFORMED) {
> > >   			/* Wait in case it fails to load. */
> > >   			mutex_unlock(&module_mutex);
> > >   			err = wait_event_interruptible(module_wq,
> > > @@ -2575,7 +2577,7 @@ static int add_unformed_module(struct module *mod)
> > >   				goto out_unlocked;
> > >   			goto again;
> > >   		}
> > > -		err = -EEXIST;
> > > +		err = old->state != MODULE_STATE_LIVE ? -EBUSY : -EEXIST;
> > >   		goto out;
> > >   	}
> > >   	mod_update_bounds(mod);
> > 
> > 
> > Prarit, can you verify this still does not break the issue you reported?
> > David, does this also fix your issue?
> 
> I didn't try, but from a quick glimpse I assume no. Allocating module space
> happens before handling eventual duplicates right now, before a module even
> is "alive" and in the MODULE_STATE_UNFORMED state.

The first two hunks are a revert of commit 6e6de3dee51a and I'm under
the impression that cauased your issues as *more* modules states are
allowed through.

The last hunk tries to fix what 6e6de3dee51a wanted to do.

> But maybe I am missing something important.

Please do test if you can.

  Luis
