Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BAD1670D22
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 00:20:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229617AbjAQXUL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 18:20:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbjAQXSf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 18:18:35 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 267B34A1CE
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 13:04:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673989466;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pW43ao2tEH/LxsdL6zrphpLrrLEB0plzx0YbyplJfAw=;
        b=GH3cWb+wbWT7BtKIPfdHHkTwymjEa4CS30E9kNnJP933cFXhqyYNf4tp0eYMcVGFaJyCgf
        tZBGCHRuxlwsKJIluO+WiekVT/C6F66gvHEUrikqqI3wifiOPRrKH+yh8Qfe/i+GhZLMcT
        mvumTbfmRv1Nz7lG9TkN57Q5J5mAHPw=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-80-ip1bjVe1N5yt0OT62Bu1Kg-1; Tue, 17 Jan 2023 16:04:25 -0500
X-MC-Unique: ip1bjVe1N5yt0OT62Bu1Kg-1
Received: by mail-qv1-f72.google.com with SMTP id q17-20020a056214019100b004b1d3c9f3acso16461562qvr.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 13:04:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pW43ao2tEH/LxsdL6zrphpLrrLEB0plzx0YbyplJfAw=;
        b=Fv7hlCQ1bmLbz2zQNxgqPKooZdD4U3kaoxHpHeOaVs5rx5Z0qOe5U9sydnWMwrJVth
         EXdm9TZ0h540Xkp4byWkP1py4nm38oDXa4z0Wwo0clnowFmCjlyX6b58Biv6Po2e9lSW
         VKlNv8R7bpa2EURXiYKuIYEwlcghEPAmSaDPu4H2ZX7idCGccA/YdvicVUFI19xr6wNk
         ok5q9c01x2sW38UxjM6ArDafTuE6oEVpHAdxn9NThwALfIChgEY63OAxiKk2IYiSmiEu
         4DjbSuk/e6PHjNKus4PTDpFeUc4uHhbsKN2RGUjWPw+Yi7pBhx0eI0AcHzodCQTY5YJV
         i1CQ==
X-Gm-Message-State: AFqh2krE6p0i4LAPLIdQF5f67zcGVHE/4S6betX2yHt0hbxdE/nBol7+
        5YIFFC8WYr3ysRhk8bixpnZ8wtYp7PjG5ry60xKJFJop7EX//06HxzwRIFrfQaCOCMzewkIf8Vu
        /ETcs/bKuDTnmjueO3fFmgT4=
X-Received: by 2002:a05:622a:a028:b0:3b1:e5f9:18ff with SMTP id jt40-20020a05622aa02800b003b1e5f918ffmr5169654qtb.20.1673989464362;
        Tue, 17 Jan 2023 13:04:24 -0800 (PST)
X-Google-Smtp-Source: AMrXdXufKZbWVcbFy3kMd+mmd8upoPIcr+7Axl90eYSjWOzSk8zkAKegbBdp2dFzivEDNp9ibYuQ6Q==
X-Received: by 2002:a05:622a:a028:b0:3b1:e5f9:18ff with SMTP id jt40-20020a05622aa02800b003b1e5f918ffmr5169626qtb.20.1673989464027;
        Tue, 17 Jan 2023 13:04:24 -0800 (PST)
Received: from localhost (pool-68-160-145-102.bstnma.fios.verizon.net. [68.160.145.102])
        by smtp.gmail.com with ESMTPSA id d7-20020ac80607000000b003a7ec97c882sm16480887qth.6.2023.01.17.13.04.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 13:04:23 -0800 (PST)
Date:   Tue, 17 Jan 2023 16:04:22 -0500
From:   Mike Snitzer <snitzer@redhat.com>
To:     Sergei Shtepa <sergei.shtepa@veeam.com>
Cc:     axboe@kernel.dk, corbet@lwn.net, linux-block@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 00/21] blksnap - block devices snapshots module
Message-ID: <Y8cNVv4O+vjL+aAy@redhat.com>
References: <20221209142331.26395-1-sergei.shtepa@veeam.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221209142331.26395-1-sergei.shtepa@veeam.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 09 2022 at  9:23P -0500,
Sergei Shtepa <sergei.shtepa@veeam.com> wrote:

> Hi Jens. Hi Jonathan. Hi all.
> 
> I am happy to offer a modified version of the Block Devices Snapshots
> Module. It allows to create non-persistent snapshots of any block devices.
> The main purpose of such snapshots is to provide backups of block devices.
> See more in Documentation/block/blksnap.rst.
> 
> The Block Device Filtering Mechanism is added to the block layer. This
> allows to attach and detach block device filters to the block layer.
> Filters allow to extend the functionality of the block layer.
> See more in Documentation/block/blkfilter.rst.
> 
> A tool, a library for working with blksnap and tests can be found at
> www.github.com/veeam/blksnap.
> 
> The first version was suggested at 13 June 2022. Many thanks to
> Christoph Hellwig and Randy Dunlap for the review of that version.
> 
> Changes:
> - Forgotten "static" declarations have been added.
> - The text of the comments has been corrected.
> - It is possible to connect only one filter, since there are no others in
>   upstream.
> - Do not have additional locks for attach/detach filter.
> - blksnap.h moved to include/uapi/.
> - #pragma once and commented code removed.
> - uuid_t removed from user API.
> - Removed default values for module parameters from the configuration file.
> - The debugging code for tracking memory leaks has been removed.
> - Simplified Makefile.
> - Optimized work with large memory buffers, CBT tables are now in virtual
>   memory.
> - The allocation code of minor numbers has been optimized.
> - The implementation of the snapshot image block device has been
>   simplified, now it is a bio-based block device.
> - Removed initialization of global variables with null values.
> - Only one bio is used to copy one chunk.
> - Checked on ppc64le.
> 
> The v1 version was suggested at 2 November 2022. Many thanks to Fabio
> Fantoni for his for his participation in the "blksnap" project on github
> and Jonathan Corbet for his article https://lwn.net/Articles/914031/.
> Thanks to the impartial kernel test robot.
> 
> Changes:
> - Added documentation for Block Device Filtering Mechanism.
> - Added documentation for Block Devices Snapshots Module (blksnap).
> - The MAINTAINERS file has been updated.
> - Optimized queue code for snapshot images.
> - Fixed comments, log messages and code for better readability.

[this reply got long...]

I think it is important to revisit how we've gotten to this point.
The catalyst for blkfilter and now blksnap was that I removed the
export for blk_mq_submit_bio -- which veeam was using for enablement
of their commercial backup software product, the offending commit was 
681cc5e8667e ("dm: fix request-based DM to not bounce through indirect dm_submit_bio")

The way veeam started to address this change was to request Red Hat
modify RHEL (by reverting my change in RHEL8, whereby restoring the
export) to give them a stopgap while they worked to identify a more
lasting solution to them having depended on such a fragile interface
with which to hijack IO for all Linux block devices.

They then came up with blk-interposer.  I tried to be helpful and
replied quite regularly to blk-interposer patchsets, e.g.:
https://listman.redhat.com/archives/dm-devel/2021-March/045900.html
https://listman.redhat.com/archives/dm-devel/2021-March/045838.html
(I won't dig out more pointers, but can if you doubt this assertion).
The last reply I got on this topic was very dense and so I
tabled it with the idea of revisiting it. But I dropped the ball and
never did reply to this:
https://listman.redhat.com/archives/dm-devel/2021-April/046184.html

Sorry. But that wasn't out of malice. I was just busy with other
things and blk-interposer took the back seat. I never imagined that my
inaction would foster completely abandoning the approach.

But my thanks is I'm now made to defend myself on LWN:
https://lwn.net/Articles/920245/
https://lwn.net/Articles/920249/

I happened to trip over that LWN thread because I saw Hannes reference
"blksnap" as something that somehow is a tolerated advance but other
efforts are not:
https://lore.kernel.org/linux-block/06e4d03c-3ecf-7e91-b80e-6600b3618b98@suse.de/

blksnap really needs to stand on its own merits and it could be that
in conjunction with blkfilter it does. But the way it has evolved has
been antithetical to how to properly engage the Linux community and
subsystem mainatiners like myself. The PR campaign to raise awareness
with LWN became more important than cc'ing me. That says it all
really.

But hopefully you can take my words as my truth: I think what you're
wanting to do is useful. I never intended to act as some gatekeeper. I
don't have a problem with what your goals are, I just ask that _how_
you achieve your goals be done with care and consideration (the
attempts I reviewed prior to your most recent work were lacking).

But my one and only request for this line of development would be: I
_really_ want DM code to be able to used as an endpoint for IO
remapping associated with any new block core hook added to accomplish
dynamic remapping of IO.  If I need to take an active role in the
development of that capability, so be it.

I've yet to look closely at all this code (but wow there is quite a
lot under drivers/block/blksnap).  I'll have a look at the block-core
changes and then try to make sense of things from there.

But you've already bypassed me, my hope is that Jens and Christoph
agree that we need this line of development to be in service to other
areas of the Linux block subsystem and its drivers that were
established for the purposes of remapping IO.  It cannot just be
the subset needed to cement veeam's ability to use Linux for its 
purposes (but I completely understand that is the point of veeam's
exercise).

Mike



> 
> Sergei Shtepa (21):
>   documentation, blkfilter: Block Device Filtering Mechanism
>   block, blkfilter: Block Device Filtering Mechanism
>   documentation, capability: fix Generic Block Device Capability
>   documentation, blksnap:  Block Devices Snapshots Module
>   block, blksnap: header file of the module interface
>   block, blksnap: module management interface functions
>   block, blksnap: init() and exit() functions
>   block, blksnap: interaction with sysfs
>   block, blksnap: attaching and detaching the filter and handling I/O
>     units
>   block, blksnap: map of change block tracking
>   block, blksnap: minimum data storage unit of the original block device
>   block, blksnap: buffer in memory for the minimum data storage unit
>   block, blksnap: functions and structures for performing block I/O
>     operations
>   block, blksnap: storage for storing difference blocks
>   block, blksnap: event queue from the difference storage
>   block, blksnap: owner of information about overwritten blocks of the
>     original block device
>   block, blksnap: snapshot image block device
>   block, blksnap: snapshot
>   block, blksnap: Kconfig and Makefile
>   block, blksnap: adds a blksnap to the kernel tree
>   block, blksnap: adds a maintainer for new files
> 
>  Documentation/block/blkfilter.rst    |  50 ++
>  Documentation/block/blksnap.rst      | 348 ++++++++++++++
>  Documentation/block/capability.rst   |   3 +
>  Documentation/block/index.rst        |   2 +
>  MAINTAINERS                          |  14 +
>  block/bdev.c                         |  70 +++
>  block/blk-core.c                     |  19 +-
>  drivers/block/Kconfig                |   2 +
>  drivers/block/Makefile               |   2 +
>  drivers/block/blksnap/Kconfig        |  12 +
>  drivers/block/blksnap/Makefile       |  18 +
>  drivers/block/blksnap/cbt_map.c      | 268 +++++++++++
>  drivers/block/blksnap/cbt_map.h      | 114 +++++
>  drivers/block/blksnap/chunk.c        | 345 ++++++++++++++
>  drivers/block/blksnap/chunk.h        | 139 ++++++
>  drivers/block/blksnap/ctrl.c         | 410 ++++++++++++++++
>  drivers/block/blksnap/ctrl.h         |   9 +
>  drivers/block/blksnap/diff_area.c    | 655 +++++++++++++++++++++++++
>  drivers/block/blksnap/diff_area.h    | 177 +++++++
>  drivers/block/blksnap/diff_buffer.c  | 133 ++++++
>  drivers/block/blksnap/diff_buffer.h  |  75 +++
>  drivers/block/blksnap/diff_io.c      | 168 +++++++
>  drivers/block/blksnap/diff_io.h      | 118 +++++
>  drivers/block/blksnap/diff_storage.c | 317 +++++++++++++
>  drivers/block/blksnap/diff_storage.h |  93 ++++
>  drivers/block/blksnap/event_queue.c  |  86 ++++
>  drivers/block/blksnap/event_queue.h  |  63 +++
>  drivers/block/blksnap/main.c         | 164 +++++++
>  drivers/block/blksnap/params.h       |  12 +
>  drivers/block/blksnap/snapimage.c    | 275 +++++++++++
>  drivers/block/blksnap/snapimage.h    |  69 +++
>  drivers/block/blksnap/snapshot.c     | 670 ++++++++++++++++++++++++++
>  drivers/block/blksnap/snapshot.h     |  78 +++
>  drivers/block/blksnap/sysfs.c        |  80 ++++
>  drivers/block/blksnap/sysfs.h        |   7 +
>  drivers/block/blksnap/tracker.c      | 683 +++++++++++++++++++++++++++
>  drivers/block/blksnap/tracker.h      |  74 +++
>  drivers/block/blksnap/version.h      |  10 +
>  include/linux/blk_types.h            |   2 +
>  include/linux/blkdev.h               |  71 +++
>  include/uapi/linux/blksnap.h         | 549 +++++++++++++++++++++
>  41 files changed, 6452 insertions(+), 2 deletions(-)
>  create mode 100644 Documentation/block/blkfilter.rst
>  create mode 100644 Documentation/block/blksnap.rst
>  create mode 100644 drivers/block/blksnap/Kconfig
>  create mode 100644 drivers/block/blksnap/Makefile
>  create mode 100644 drivers/block/blksnap/cbt_map.c
>  create mode 100644 drivers/block/blksnap/cbt_map.h
>  create mode 100644 drivers/block/blksnap/chunk.c
>  create mode 100644 drivers/block/blksnap/chunk.h
>  create mode 100644 drivers/block/blksnap/ctrl.c
>  create mode 100644 drivers/block/blksnap/ctrl.h
>  create mode 100644 drivers/block/blksnap/diff_area.c
>  create mode 100644 drivers/block/blksnap/diff_area.h
>  create mode 100644 drivers/block/blksnap/diff_buffer.c
>  create mode 100644 drivers/block/blksnap/diff_buffer.h
>  create mode 100644 drivers/block/blksnap/diff_io.c
>  create mode 100644 drivers/block/blksnap/diff_io.h
>  create mode 100644 drivers/block/blksnap/diff_storage.c
>  create mode 100644 drivers/block/blksnap/diff_storage.h
>  create mode 100644 drivers/block/blksnap/event_queue.c
>  create mode 100644 drivers/block/blksnap/event_queue.h
>  create mode 100644 drivers/block/blksnap/main.c
>  create mode 100644 drivers/block/blksnap/params.h
>  create mode 100644 drivers/block/blksnap/snapimage.c
>  create mode 100644 drivers/block/blksnap/snapimage.h
>  create mode 100644 drivers/block/blksnap/snapshot.c
>  create mode 100644 drivers/block/blksnap/snapshot.h
>  create mode 100644 drivers/block/blksnap/sysfs.c
>  create mode 100644 drivers/block/blksnap/sysfs.h
>  create mode 100644 drivers/block/blksnap/tracker.c
>  create mode 100644 drivers/block/blksnap/tracker.h
>  create mode 100644 drivers/block/blksnap/version.h
>  create mode 100644 include/uapi/linux/blksnap.h
> 
> -- 
> 2.20.1
> 

