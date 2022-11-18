Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BB5562FE08
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 20:34:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235444AbiKRTea (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 14:34:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235666AbiKRTeY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 14:34:24 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4130A2D5
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 11:33:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668800004;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AG1SKrUV7k0X5TWOfCvNitOlF8TPG3jUR8Z8g6cbZlA=;
        b=bb/NbTGioALLx/x7qW2DkG+xfag0CQQUTq+VRmYpxbsN+0TPoJizfvkN1EDiRmS7rccyru
        d6pcutmLPXQ2jQ41nvzWpyMWJpEhjgwoZ1uAkE5MKSpZfrIUZrBunx5DBe8jw6v36f2/OE
        i5fdWtYNaW8mtHUzkSJHM9claONETlU=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-141-n_LDrY5YM6mHxHOfEqTmjA-1; Fri, 18 Nov 2022 14:33:23 -0500
X-MC-Unique: n_LDrY5YM6mHxHOfEqTmjA-1
Received: by mail-qt1-f199.google.com with SMTP id i13-20020ac8764d000000b003a4ec8693dcso5866562qtr.14
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 11:33:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AG1SKrUV7k0X5TWOfCvNitOlF8TPG3jUR8Z8g6cbZlA=;
        b=uWtRCiYxCuZI9Tf5x6j3wSRACzO9NjVsOIz13iXDZ5b5yDU7BGc6upbQPNTcwKaXKF
         lQ0QnjawyX41lhJB0a0Xv2MhUJ5CYF2KxYLjAKKDpYlZTapHTxgeL5sguUyfMCptprMz
         lOPd3560P0P1Ho2gwLtRc3wgt5ah5yp8AkZQyDmnBBc2+17Zj3/BSLUGuTLBw6KBdCLz
         xtxJK4kZo9PQIagLwLHPjeRz5f9u4VmefbCNBGzIJX9sUWEmVcj5J6boSuLhjZ2wR1pv
         isvvNF1Y1QASABACA+HZjwXPcpQRpPoBbKqDrGTYBZ+iHmnPDgUvN3LQ7mAQmh0smady
         XYOw==
X-Gm-Message-State: ANoB5pnLX7QD7CTn6LeeG1Sh/clcZvVYz191U6pdkL/U4LcNtUQD7nUa
        lYIPBmBFjojDCLamMs8hAiOOkqElURGwDtwh9aB8j5CDGiclp0r4o51dq0iliGXZc8W/cnHsFFF
        XKShU4TOWhtJ1CQLn+TWGnnSB
X-Received: by 2002:a0c:f254:0:b0:4af:b70e:1305 with SMTP id z20-20020a0cf254000000b004afb70e1305mr7988783qvl.127.1668800002825;
        Fri, 18 Nov 2022 11:33:22 -0800 (PST)
X-Google-Smtp-Source: AA0mqf62x/DXTMrV3cfVNb2/5/8QoAelvIHCdhWqK8AdHzTbIPuGWWkL/VTiCZLNiZKnYFc2xT3sTQ==
X-Received: by 2002:a0c:f254:0:b0:4af:b70e:1305 with SMTP id z20-20020a0cf254000000b004afb70e1305mr7988767qvl.127.1668800002597;
        Fri, 18 Nov 2022 11:33:22 -0800 (PST)
Received: from bfoster (c-24-61-119-116.hsd1.ma.comcast.net. [24.61.119.116])
        by smtp.gmail.com with ESMTPSA id a13-20020ac84d8d000000b003a5430ee366sm2391449qtw.60.2022.11.18.11.33.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 11:33:22 -0800 (PST)
Date:   Fri, 18 Nov 2022 14:33:27 -0500
From:   Brian Foster <bfoster@redhat.com>
To:     Ivan Babrou <ivan@cloudflare.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@cloudflare.com, Alexey Dobriyan <adobriyan@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Theodore Ts'o <tytso@mit.edu>,
        David Laight <David.Laight@aculab.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Christoph Anton Mitterer <mail@christoph.anton.mitterer.name>,
        Mike Rapoport <rppt@kernel.org>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Kalesh Singh <kaleshsingh@google.com>,
        Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v4] proc: report open files as size in stat() for
 /proc/pid/fd
Message-ID: <Y3feB8wHdfx48uCl@bfoster>
References: <20221024173140.30673-1-ivan@cloudflare.com>
 <Y3fYu2VCBgREBBau@bfoster>
 <CABWYdi3csS3BpoMd8xO=ZXFeBH7KtuLkxzQ8VE5+rO5wrx-yQQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABWYdi3csS3BpoMd8xO=ZXFeBH7KtuLkxzQ8VE5+rO5wrx-yQQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 18, 2022 at 11:18:36AM -0800, Ivan Babrou wrote:
> On Fri, Nov 18, 2022 at 11:10 AM Brian Foster <bfoster@redhat.com> wrote:
> > > +static int proc_fd_getattr(struct user_namespace *mnt_userns,
> > > +                     const struct path *path, struct kstat *stat,
> > > +                     u32 request_mask, unsigned int query_flags)
> > > +{
> > > +     struct inode *inode = d_inode(path->dentry);
> > > +     int rv = 0;
> > > +
> > > +     generic_fillattr(&init_user_ns, inode, stat);
> > > +
> >
> > Sorry I missed this on v3, but shouldn't this pass through the
> > mnt_userns parameter?
> 
> The mnt_userns parameter was added in 549c729 (fs: make helpers idmap
> mount aware), and it's not passed anywhere in fs/proc.
> 
> Looking at other uses of generic_fillattr, all of them use "init_user_ns":
> 

Interesting. It looks like this would have used mnt_userns from
vfs_getattr_nosec() before proc_fd_getattr() is wired up, right? I'm not
familiar enough with that change to say whether /proc should use one
value or the other, or perhaps it just doesn't matter.?

Christian?

Brian

> $ rg generic_fillattr fs/proc
> fs/proc/proc_net.c
> 301: generic_fillattr(&init_user_ns, inode, stat);
> 
> fs/proc/base.c
> 1970: generic_fillattr(&init_user_ns, inode, stat);
> 3856: generic_fillattr(&init_user_ns, inode, stat);
> 
> fs/proc/root.c
> 315: generic_fillattr(&init_user_ns, d_inode(path->dentry), stat);
> 
> fs/proc/generic.c
> 150: generic_fillattr(&init_user_ns, inode, stat);
> 
> fs/proc/proc_sysctl.c
> 841: generic_fillattr(&init_user_ns, inode, stat);
> 

