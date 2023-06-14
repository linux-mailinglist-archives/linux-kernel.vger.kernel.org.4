Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B98B7162F7
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 16:03:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232827AbjE3ODk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 10:03:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232839AbjE3OD2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 10:03:28 -0400
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88D31E8
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 07:02:42 -0700 (PDT)
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-75ca95c4272so269936485a.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 07:02:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685455361; x=1688047361;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SLXZZ4okt0cYFY/QNAJJGFsPl/H71jdcBcEpr3wA2kw=;
        b=h8TY0Wnm7gOEcVBAbX+NnravAZAQPrP2tE9SVG4EdMcaPWVXS0A+1gyUxP38OXFToz
         gRY4QBa5MAxKKJAfE1VkNhLKXCC04jLAm/qxZmBwgUJ9yl8zDwP+ARHtCtRbqDi1HakK
         FKFIQjID1+dIsBldln2UASdtFEhMcagBwG7HwCgAmeKljlElp1ZMM5ptZzo8MopuJ5xq
         XflJcc+ACMCU0pc+5YNYTHjeeaBVENNEJC7bkzb3vUuwIQbC2w2KlSKo9QxmOJtP4WCZ
         47oizOAP9AtYALizyu4UmNL1POoeQHg3RYQC6fldMMFLdC0oYzCia242VRnlfOQBC+Q3
         26uA==
X-Gm-Message-State: AC+VfDyCZb1Lorag0s6YecsSZV5J/AexEyV5c+HiJ+aDYvUGtfKWmeNZ
        yJwJCHx3OxQPcTBBqGW+0Njo
X-Google-Smtp-Source: ACHHUZ7c+L67lbfSXpLgK/LYE2fkMm11TxLSTkagmUtFWm5173a2X+RzwOCM3DIH+r9HCG6yNT7q6w==
X-Received: by 2002:a05:6214:40a:b0:626:299b:68ee with SMTP id z10-20020a056214040a00b00626299b68eemr2306743qvx.55.1685455361523;
        Tue, 30 May 2023 07:02:41 -0700 (PDT)
Received: from localhost (pool-68-160-166-30.bstnma.fios.verizon.net. [68.160.166.30])
        by smtp.gmail.com with ESMTPSA id jh18-20020a0562141fd200b0062382e1e228sm4619878qvb.49.2023.05.30.07.02.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 07:02:40 -0700 (PDT)
Date:   Tue, 30 May 2023 10:02:39 -0400
From:   Mike Snitzer <snitzer@kernel.org>
To:     Joe Thornber <thornber@redhat.com>
Cc:     Dave Chinner <david@fromorbit.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Brian Foster <bfoster@redhat.com>,
        Bart Van Assche <bvanassche@google.com>,
        linux-kernel@vger.kernel.org, Joe Thornber <ejt@redhat.com>,
        Christoph Hellwig <hch@infradead.org>, dm-devel@redhat.com,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Sarthak Kukreti <sarthakkukreti@chromium.org>,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        Jason Wang <jasowang@redhat.com>,
        Alasdair Kergon <agk@redhat.com>
Subject: Re: [PATCH v7 0/5] Introduce provisioning primitives
Message-ID: <ZHYB/6l5Wi+xwkbQ@redhat.com>
References: <ZGgBQhsbU9b0RiT1@dread.disaster.area>
 <ZGu0LaQfREvOQO4h@redhat.com>
 <ZGzIJlCE2pcqQRFJ@bfoster>
 <ZGzbGg35SqMrWfpr@redhat.com>
 <ZG1dAtHmbQ53aOhA@dread.disaster.area>
 <ZG+KoxDMeyogq4J0@bfoster>
 <ZHB954zGG1ag0E/t@dread.disaster.area>
 <CAJ0trDbspRaDKzTzTjFdPHdB9n0Q9unfu1cEk8giTWoNu3jP8g@mail.gmail.com>
 <ZHFEfngPyUOqlthr@dread.disaster.area>
 <CAJ0trDZJQwvAzngZLBJ1hB0XkQ1HRHQOdNQNTw9nK-U5i-0bLA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJ0trDZJQwvAzngZLBJ1hB0XkQ1HRHQOdNQNTw9nK-U5i-0bLA@mail.gmail.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 30 2023 at  3:27P -0400,
Joe Thornber <thornber@redhat.com> wrote:

> On Sat, May 27, 2023 at 12:45 AM Dave Chinner <david@fromorbit.com> wrote:
> 
> > On Fri, May 26, 2023 at 12:04:02PM +0100, Joe Thornber wrote:
> >
> > > 1) We have an api (ioctl, bio flag, whatever) that lets you
> > > reserve/guarantee a region:
> > >
> > >   int reserve_region(dev, sector_t begin, sector_t end);
> >
> > A C-based interface is not sufficient because the layer that must do
> > provsioning is not guaranteed to be directly under the filesystem.
> > We must be able to propagate the request down to the layers that
> > need to provision storage, and that includes hardware devices.
> >
> > e.g. dm-thin would have to issue REQ_PROVISION on the LBA ranges it
> > allocates in it's backing device to guarantee that the provisioned
> > LBA range it allocates is also fully provisioned by the storage
> > below it....
> >
> 
> Fine, bio flag it is.
> 
> 
> >
> > >   This api should be used minimally, eg, critical FS metadata only.
> >
> >
> >
> > Plan for having to support tens of GBs of provisioned space in
> > filesystems, not tens of MBs....
> >
> 
> Also fine.
> 
> 
> I think there's a 2-3 solid days of coding to fully implement
> > REQ_PROVISION support in XFS, including userspace tool support.
> > Maybe a couple of weeks more to flush the bugs out before it's
> > largely ready to go.
> >
> > So if there's buy in from the block layer and DM people for
> > REQ_PROVISION as described, then I'll definitely have XFS support
> > ready for you to test whenever dm-thinp is ready to go.
> >
> 
> Great, this is what I wanted to hear.  I guess we need an ack from the
> block guys and then I'll get started.

The block portion is where this discussion started (in the context of
this thread's patchset, now at v7).

During our discussion I think there were 2 gaps identified with this
patchset:

1) provisioning should be opt-in, and we need a clear flag that upper
   layers look for to know if REQ_PROVISION available
   - we do get this with the max_provision_sectors = 0 default, is
     checking queue_limits (via queue_max_provision_sectors)
     sufficient for upper layers like xfs?

2) DM thinp needs REQ_PROVISION passdown support
   - also dm_table_supports_provision() needs to be stricter by
     requiring _all_ underlying devices support provisioning?

Bonus dm-thinp work: add ranged REQ_PROVISION support to reduce number
of calls (and bios) block core needs to pass to dm thinp.

Also Joe, for you proposed dm-thinp design where you distinquish
between "provision" and "reserve": Would it make sense for REQ_META
(e.g. all XFS metadata) with REQ_PROVISION to be treated as an
LBA-specific hard request?  Whereas REQ_PROVISION on its own provides
more freedom to just reserve the length of blocks? (e.g. for XFS
delalloc where LBA range is unknown, but dm-thinp can be asked to
reserve space to accomodate it).

Mike
