Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F04D96CABF8
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 19:40:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229538AbjC0RkD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 13:40:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjC0RkB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 13:40:01 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3359B170C
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 10:40:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
        bh=pZyn7jSE3myi5GOQcd/Alvk1yAzY2UEotzjk0nWF3cs=; b=KgiSjIhBCI5KS+1Jou000yQ3+R
        RxSVbYlH3MlRUgh1iNJw0W2Uh1dT9oHUCfrPMfQGgX2D6hy701vuT4h1S3pxXTB6hdSikaCW4j05O
        1gRAkS8YpEj5Zyel+vEsGkc+Yv2keYM0im61MeXnfzzRrzS8mlas7CvAVexqTiJXaQrRGdTdUlXDf
        iyAZJdrDWydtpvZRUiI1ssmREs12UKyKobHaIPKH0k0WVAXl6F6rxamNXSsLBOhxdD0xPElr4Nwwt
        IlSFhace3k2bsR1BBpGNNcEQNQ0LaDULcTsRhjFL7B8/rATvPG8do0vqeqOZZ7q1NhP2rtrxurx7S
        HReY5T2Q==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pgqp0-00Bv81-0E;
        Mon, 27 Mar 2023 17:39:54 +0000
Date:   Mon, 27 Mar 2023 10:39:54 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Eric Van Hensbergen <ericvh@gmail.com>
Cc:     Josef Bacik <josef@toxicpanda.com>,
        Jeff Layton <jlayton@kernel.org>, lucho@ionkov.net,
        asmadeus@codewreck.org, v9fs-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>,
        Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: 9p caching with cache=loose and cache=fscache
Message-ID: <ZCHU6k56nF5849xj@bombadil.infradead.org>
References: <ZA0FEyOtRBvpIXbi@bombadil.infradead.org>
 <CAFkjPTmVbyuA0jEAjYhsOsg-SE99yXgehmjqUZb4_uWS_L-ZTQ@mail.gmail.com>
 <ZBSc1jjYJn6noeMl@bombadil.infradead.org>
 <CAFkjPTmc-OgMEj9kF3y04sRGeOVO_ogEv1fGG=-CfKP-0ZKC_g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFkjPTmc-OgMEj9kF3y04sRGeOVO_ogEv1fGG=-CfKP-0ZKC_g@mail.gmail.com>
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

On Mon, Mar 27, 2023 at 08:05:21AM -0500, Eric Van Hensbergen wrote:
> Sorry, took a bit to unstack from day job, but while going through the
> patch queue I remembered I still had some questions to answer here.
> 
> On Fri, Mar 17, 2023 at 12:01 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
> >
> > On Sun, Mar 12, 2023 at 01:22:34PM -0500, Eric Van Hensbergen wrote:
> > > I was looking at kdevops the other day - cool stuff.  Was trying to
> > > figure out how we could do v9fs CI with it.
> >
> > Happy to help any questions you may have about it!
> >
> > > Both cache=loose and cache=fscache currently don't validate via host.
> >
> > What does this mean exactly?
> >
> 
> That's a good question - I guess the answer is "by design" they don't
> do anything special to check that the cache is up to date with the
> host.

From a user perspective none of this is clear from any of the
documentation I read.

> That being said, there are several places in the code where the
> cache will be invalidated

<-- elaboration of current invalidation schemes when cache is enabled -->
> 
> > Right now a host with debian 6.0.0-6-amd64 certainly does not seem to push
> > out changes to 9p clients on VMs but Josef informs me that with 6.2-rc8
> > he did see the changes propagate.
> 
> I did tighten up some of the invalidation in the last round of
> patches, however these are likely more on the overly conservative side
> versus doing the right thing -- however, its really not at the point
> where you can rely on it.  If consistency is something you care about,
> I'd suggest cache=none until you can get cache=readahead.

Indeed that fixes things and makes things work *exactly* as one would
expect. The simple case of just editing a file and immediately comparing
sha1sum on the host and guest yields the exact same result.

In comparison using the default cache of loose... things are not what
you'd expect. The cache is completley useless even if you do a full
kernel compilation on the host. The guest will not get any updates at
all.

> > Do none of the existing 9p cache modes not support open-to-close policies
> > at all?
> >
> 
> not specifically open-to-close, loose supports file and dir caching
> but without consistency, it might be tempting to try cache=mmap to see
> if it gets you closer, but my frame of reference is more the current
> patches versus the old code so not sure it would buy you anything.

OK thanks, it seems we should probably help test 9p with fstests and get
a baseline, and then check to see how many tests actually do test cache
modes. If none exists, we should add some to test for each invalidation
strategy possible.

We can certainly use kdevops to help test this but I suspect that
since it relies on a client / host model it may make sense to share
some code for automation on bringup with what NFS folks are doing
with kdevops.

> > Right now the cache mode used is cache=loose as that's the default,
> > what do you recommend for a typical kernel development environemnt?
> 
> As I said, if you are interactively changing things I think you'd want
> to go for cache=none for now (as painful as it is).

The documentation is not so clear what the pain is in terms of
performance.

> I have fixed what
> I hope to be my last bug with the new patch series so it should be
> going into linux-next today.

Nice, thanks, since kdevops relies on a host kernel though and we strive
to have stability for that, I personally like to recommend distro
kernels and so they're a few kernel releases out of date. So debian-testing
is on 6.1 as of today for example.

So I'll go with the following for now on kdevops for now. This seems to
fix all the woes I had for now. Once a cache mode with proper testign
proves to pass most tests in fstests we can switch to it on kdevops.

diff --git a/playbooks/roles/bootlinux/tasks/main.yml b/playbooks/roles/bootlinux/tasks/main.yml
index 297a42794a09..477cacdee887 100644
--- a/playbooks/roles/bootlinux/tasks/main.yml
+++ b/playbooks/roles/bootlinux/tasks/main.yml
@@ -111,7 +111,7 @@
     name: "{{ target_linux_dir_path }}"
     src: "{{ bootlinux_9p_mount_tag }}"
     fstype: "9p"
-    opts: "ro,trans=virtio,version=9p2000.L,posixacl,cache=loose"
+    opts: "ro,trans=virtio,version=9p2000.L,posixacl,cache=none"
     state: "mounted"
   tags: [ 'data_partition' ]
   when:

BTW the qemu wiki seems to suggest cache=loose and its why I used it on
kdevops as a default. What about the following so to avoid folks running
into similar issues? I can go and update the wiki too.

diff --git a/Documentation/filesystems/9p.rst b/Documentation/filesystems/9p.rst
index 0e800b8f73cc..476944912312 100644
--- a/Documentation/filesystems/9p.rst
+++ b/Documentation/filesystems/9p.rst
@@ -56,6 +56,12 @@ seen by reading /sys/bus/virtio/drivers/9pnet_virtio/virtio<n>/mount_tag files.
 Options
 =======
 
+Note that a none of the currently supported cache modes validate against data
+againgst the host, they don't do anything special to check that the cache is up
+to date with the host. If you really need some synchronization the cache mode
+you should use is default "none", that will ensure data is kept up to date
+synchronously right away despite some performance overhead.
+
   ============= ===============================================================
   trans=name	select an alternative transport.  Valid options are
   		currently:
