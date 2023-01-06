Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 945CF6606ED
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 20:09:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230085AbjAFTJO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 14:09:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231376AbjAFTJL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 14:09:11 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 888EC6A0E6;
        Fri,  6 Jan 2023 11:09:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
        bh=sJniDLa2D+Z/oazYjAaq4GySTvYvssj5sYXiiUAvXgo=; b=mW9l7tkx4ir7lOr/5jfuCs+hGI
        AFaFXzW5+MNROTrLpZaB5jmhnCR7vUmRxzhj/QJsiC2gLEPYmSW2tG02IHn04cNuV4yJkXG0TyjwL
        T5mRN9KQUGy0+jb3ip2tT+CPs4bM1BmYFTz4eX52M+AO6AOWSfbw0TPbMX+WaVg30D1ukBV0aAs8n
        3QOs/iO5En2fCIEvQCE47ZvlMJlVxvSxvRBmoXz2Ew6FHHg60ROv6epoGgkagicsz6/SE9j/t3JWm
        liXNyfUYZJztFhP+AOwghAlV7euJ83SLnyBSVWogr8GJmMNIiwdKb/CATAYkmLDl6GAzzHPRFUIEv
        Yk5wa8tA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pDs5R-00EXbQ-6r; Fri, 06 Jan 2023 19:09:05 +0000
Date:   Fri, 6 Jan 2023 11:09:05 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Tejun Heo <tj@kernel.org>, Dan Carpenter <error27@gmail.com>,
        Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [bug report] memcontrol: schedule throttling if we are congested
Message-ID: <Y7hx0QZ3m96F2wEv@bombadil.infradead.org>
References: <Y7g3L6fntnTtOm63@kili>
 <Y7hbYPSdLqW++y/p@slm.duckdns.org>
 <9ac3390c-055b-546c-f1f4-68350dfe04f8@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9ac3390c-055b-546c-f1f4-68350dfe04f8@kernel.dk>
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

On Fri, Jan 06, 2023 at 11:49:33AM -0700, Jens Axboe wrote:
> On 1/6/23 10:33 AM, Tejun Heo wrote:
> > Hello,
> > 
> > (cc'ing Luis, Christoph and Jens and quoting whole body)
> > 
> > On Fri, Jan 06, 2023 at 05:58:55PM +0300, Dan Carpenter wrote:
> >> Hello Tejun Heo,
> >>
> >> The patch 2cf855837b89: "memcontrol: schedule throttling if we are
> >> congested" from Jul 3, 2018, leads to the following Smatch static
> >> checker warning:
> >>
> >> block/blk-cgroup.c:1863 blkcg_schedule_throttle() warn: sleeping in atomic context
> >>
> >> The call tree looks like:
> >>
> >> ioc_rqos_merge() <- disables preempt
> >> __cgroup_throttle_swaprate() <- disables preempt
> >> -> blkcg_schedule_throttle()
> >>
> >> Here is one of the callers:
> >> mm/swapfile.c
> >>   3657          spin_lock(&swap_avail_lock);
> >>                 ^^^^^^^^^^^^^^^^^^^^^^^^^^^
> >> Takes spin lock.
> >>
> >>   3658          plist_for_each_entry_safe(si, next, &swap_avail_heads[nid],
> >>   3659                                    avail_lists[nid]) {
> >>   3660                  if (si->bdev) {
> >>   3661                          blkcg_schedule_throttle(si->bdev->bd_disk, true);
> >>                                 ^^^^^^^^^^^^^^^^^^^^^^^
> >> Calls blkcg_schedule_throttle().
> >>
> >>   3662                          break;
> >>   3663                  }
> >>   3664          }
> >>
> >> block/blk-cgroup.c
> >>   1851  void blkcg_schedule_throttle(struct gendisk *disk, bool use_memdelay)
> >>   1852  {
> >>   1853          struct request_queue *q = disk->queue;
> >>   1854  
> >>   1855          if (unlikely(current->flags & PF_KTHREAD))
> >>   1856                  return;
> >>   1857  
> >>   1858          if (current->throttle_queue != q) {
> >>   1859                  if (!blk_get_queue(q))
> >>   1860                          return;
> >>   1861  
> >>   1862                  if (current->throttle_queue)
> >>   1863                          blk_put_queue(current->throttle_queue);
> >>                                 ^^^^^^^^^^^^^^
> >> Sleeps.
> >>
> >>   1864                  current->throttle_queue = q;
> >>   1865          }
> >>   1866  
> >>   1867          if (use_memdelay)
> >>   1868                  current->use_memdelay = use_memdelay;
> >>   1869          set_notify_resume(current);
> >>   1870  }
> > 
> > In general, it's quite unusual for a put operation to require a sleepable
> > context and I could be missing sth but the actual put / release paths don't
> > seem to actually need might_sleep(). It seems sprious.
> > 
> > The might_sleep() in put was added by Christoph's 63f93fd6fa57 ("block: mark
> > blk_put_queue as potentially blocking") which promoted it from release to
> > put cuz the caller usually can't tell whether its put is the last put.
> > 
> > And that put in release was added by Luis in e8c7d14ac6c3 ("block: revert
> > back to synchronous request_queue removal") while making the release path
> > synchronous, the rationale being 

The rationale was that we reverted exepected userspace expection for
something that was sync to async so broke userspace expectations and
we can't do that.

> > that releasing asynchronously makes dynamic
> > device removal / readdition behaviors unpredictable and it also seems to
> > note that might_sleep() is no longer needed but still kept, which seems a
> > bit odd to me.
> > 
> > Here's my take on it:
> > 
> > * Let's please not require a sleepable context in a put operation. It's
> >   unusual, inconvenient and error-prone, and likely to cause its users to
> >   implement multiple copies of async mechanisms around it.
> > 
> > * A better way to deal with removal / readdition race is flushing release
> >   operaitons either at the end of removal or before trying to add something
> >   (you can get fancy w/ flushing only if there's name collision too), not
> >   making a put path synchronously call release which needs to sleep.
> > 
> > * If might_sleep() is currently not needed, let's please drop it. It just
> >   makes people scratch their head when reading the code.
> 
> I looked over the call path, and I don't think anything in there sleeps.
> So should be fine to remove the might_sleep().

As soon as commit 63f93fd6fa5717 ("block: mark blk_put_queue as
potentially blocking") on v6.2-rc1 it was upgraded to might_sleep()
directly on blk_put_queue(), I can't find a rationale after that
to justify the removal. But since it is not clear if we keep it,
we should document that rationale.

  Luis
