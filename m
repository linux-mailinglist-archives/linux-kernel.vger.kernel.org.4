Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E776867A991
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 05:18:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231281AbjAYESr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 23:18:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbjAYESl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 23:18:41 -0500
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 866274A214
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 20:18:39 -0800 (PST)
Received: by mail-pj1-x1043.google.com with SMTP id 88so5664339pjo.3
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 20:18:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2zm9CTlz+B7NJKOJgLLkEu+O8sHPBZCAAUFTPto5VIk=;
        b=3C51J7aWxQ6yjnwfiQ3VXcwFzqnYkU0WUSVdQfpEiwhxFLRBH850em1vH7fnmVYmk8
         ePkxkjpGEjHCZabc0wpfJazxapQfy0X12xtsXrNh0pGqnzdXIBmTTXY6zgEGT400wxp8
         cdQl7s20rjPfQPhmpjnxj16DWM7uehNCnZMBfXQQsKadteVVBfauCUHr2RUTvYrVRXNe
         52ExfDxXq3IIQsyWwovxBBIufwOlVpNsrKoAEd1Tg7VfdyJD562Ke9IZzoj+NfwhmnGX
         +CfTWbf4r0zgp7OL9oxys1olyev6DI4+dvkGlx+9UhhTqyxfAdrS56ujzWqj+BL9OY70
         akuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2zm9CTlz+B7NJKOJgLLkEu+O8sHPBZCAAUFTPto5VIk=;
        b=0NHZmttZWxU+Cu62CCZxtHzsicfOMGKJ9RCkVwMOLhEMpmkwMQQbp4efc6RHf7AAP6
         sP6twSb8KXu1nN1e8p+YpUIIsDFTZ4e9ANBAZzDLBEAEXpeqYof0wmQLwbo+Vt3eXzHO
         V0u2Tja8bpToM91YllDCRluEE/5NX4UQnCwT5ffo33ls2KJ6hDdtwgIP5IhfCwk810+8
         pKzhZrhDsKHo4yvKtVCR9lI3YRAPyyMx5I/mbAcs1zDcxEsOMqEkzYhQspTaG08CefXD
         eGPTb8OIftvzO15FMv6BZHe18eHhUQye2d0NaebzfOsvl9ajgHZpuNQoFdn1x06n3r6j
         pQDw==
X-Gm-Message-State: AFqh2kq1UL3DZuvDVRXHgZc4Wg0/O6T83/dFbg3QPEEL/8hCf4GXiKiz
        KEOvbewnSxo7b8GFooEDjpbApA==
X-Google-Smtp-Source: AMrXdXstCbKhe4ltOgpD7q8klZlIBNEMLWnyCNJ+hi2dh29mehTBM6rYD9fpUpFXjA2JNSkjdAovaA==
X-Received: by 2002:a05:6a20:e610:b0:9d:efbf:787d with SMTP id my16-20020a056a20e61000b0009defbf787dmr31979402pzb.50.1674620319091;
        Tue, 24 Jan 2023 20:18:39 -0800 (PST)
Received: from dread.disaster.area (pa49-186-60-71.pa.vic.optusnet.com.au. [49.186.60.71])
        by smtp.gmail.com with ESMTPSA id s17-20020a639251000000b004cc95c9bd97sm2196890pgn.35.2023.01.24.20.18.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jan 2023 20:18:38 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1pKXF5-007B4H-EB; Wed, 25 Jan 2023 15:18:35 +1100
Date:   Wed, 25 Jan 2023 15:18:35 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Alexander Larsson <alexl@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        gscrivan@redhat.com, brauner@kernel.org, viro@zeniv.linux.org.uk,
        Vivek Goyal <vgoyal@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: [PATCH v3 0/6] Composefs: an opportunistically sharing verified
 image filesystem
Message-ID: <20230125041835.GD937597@dread.disaster.area>
References: <cover.1674227308.git.alexl@redhat.com>
 <CAOQ4uxgGc33_QVBXMbQTnmbpHio4amv=W7ax2vQ1UMet0k_KoA@mail.gmail.com>
 <1ea88c8d1e666b85342374ed7c0ddf7d661e0ee1.camel@redhat.com>
 <CAOQ4uxinsBB-LpGh4h44m6Afv0VT5yWRveDG7sNvE2uJyEGOkg@mail.gmail.com>
 <5fb32a1297821040edd8c19ce796fc0540101653.camel@redhat.com>
 <CAOQ4uxhGX9NVxwsiBMP0q21ZRot6-UA0nGPp1wGNjgmKBjjBBA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxhGX9NVxwsiBMP0q21ZRot6-UA0nGPp1wGNjgmKBjjBBA@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 24, 2023 at 09:06:13PM +0200, Amir Goldstein wrote:
> On Tue, Jan 24, 2023 at 3:13 PM Alexander Larsson <alexl@redhat.com> wrote:
> > On Tue, 2023-01-24 at 05:24 +0200, Amir Goldstein wrote:
> > > On Mon, Jan 23, 2023 at 7:56 PM Alexander Larsson <alexl@redhat.com>
> > > wrote:
> > > > On Fri, 2023-01-20 at 21:44 +0200, Amir Goldstein wrote:
> > > > > On Fri, Jan 20, 2023 at 5:30 PM Alexander Larsson
> > > > > <alexl@redhat.com>
> > > > > wrote:
> > I'm not sure why the dentry cache case would be more important?
> > Starting a new container will very often not have cached the image.
> >
> > To me the interesting case is for a new image, but with some existing
> > page cache for the backing files directory. That seems to model staring
> > a new image in an active container host, but its somewhat hard to test
> > that case.
> >
> 
> ok, you can argue that faster cold cache ls -lR is important
> for starting new images.
> I think you will be asked to show a real life container use case where
> that benchmark really matters.

I've already described the real world production system bottlenecks
that composefs is designed to overcome in a previous thread.

Please go back an read this:

https://lore.kernel.org/linux-fsdevel/20230118002242.GB937597@dread.disaster.area/

Cold cache performance dominates the runtime of short lived
containers as well as high density container hosts being run to
their container level memory limits. `ls -lR` is just a
microbenchmark that demonstrates how much better composefs cold
cache behaviour is than the alternatives being proposed....

This might also help explain why my initial review comments focussed
on getting rid of optional format features, straight lining the
processing, changing the format or search algorithms so more
sequential cacheline accesses occurred resulting in less memory
stalls, etc. i.e. reductions in cold cache lookup overhead will
directly translate into faster container workload spin up.

> > > > This isn't all that strange, as overlayfs does a lot more work for
> > > > each lookup, including multiple name lookups as well as several
> > > > xattr
> > > > lookups, whereas composefs just does a single lookup in a pre-
> > > > computed
> > >
> > > Seriously, "multiple name lookups"?
> > > Overlayfs does exactly one lookup for anything but first level
> > > subdirs
> > > and for sparse files it does the exact same lookup in /objects as
> > > composefs.
> > > Enough with the hand waving please. Stick to hard facts.
> >
> > With the discussed layout, in a stat() call on a regular file,
> > ovl_lookup() will do lookups on both the sparse file and the backing
> > file, whereas cfs_dir_lookup() will just map some page cache pages and
> > do a binary search.
> >
> > Of course if you actually open the file, then cfs_open_file() would do
> > the equivalent lookups in /objects. But that is often not what happens,
> > for example in "ls -l".
> >
> > Additionally, these extra lookups will cause extra memory use, as you
> > need dentries and inodes for the erofs/squashfs inodes in addition to
> > the overlay inodes.
> 
> I see. composefs is really very optimized for ls -lR.

No, composefs is optimised for minimal namespace and inode
resolution overhead. 'ls -lR' does a lot of these operations, and
therefore you see the efficiency of the design being directly
exposed....

> Now only need to figure out if real users start a container and do ls -lR
> without reading many files is a real life use case.

I've been using 'ls -lR' and 'find . -ctime 1' to benchmark cold
cache directory iteration and inode lookup performance for roughly
20 years. The benchmarks I run *never* read file data, nor is that
desired - they are pure directory and inode lookup micro-benchmarks
used to analyse VFS and filesystem directory and inode lookup
performance.

I have been presenting such measurements and patches improving
performance of these microbnechmarks to the XFS and fsdevel lists
over 15 years and I have *never* had to justify that what I'm
measuring is a "real world workload" to anyone. Ever.

Complaining about real world relevancy of the presented benchmark
might be considered applying a double standard, wouldn't you agree?

-Dave.
-- 
Dave Chinner
david@fromorbit.com
