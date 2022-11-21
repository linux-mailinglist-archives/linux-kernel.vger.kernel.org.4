Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 763316320F5
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 12:44:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231484AbiKULn6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 06:43:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231444AbiKULn1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 06:43:27 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF8DC1C111
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 03:42:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669030941;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=f0yfsdol+yJgmcL0Jiq/hqGtRju0QVsHN+RKjYJPQas=;
        b=gEOnELvplYAcYoop+/Jgazv41Hwc0vV30l3YGM+RyIWR2GZ42SaW43CdTocKMXv5REgmO5
        R6F0trFkD7iYyxRZ6SteRDY0SCcUiwpwRmHNuu7H5zbO4V+uoDw9LaEV5hTciKsyPtUocY
        /Ii5LKrXaHZDSJQSC3UxWFojt7I3mkI=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-66-lXs-on3ANIC09UCGABNV9Q-1; Mon, 21 Nov 2022 06:42:19 -0500
X-MC-Unique: lXs-on3ANIC09UCGABNV9Q-1
Received: by mail-qv1-f71.google.com with SMTP id z18-20020a0cfed2000000b004bc28af6f7dso11133002qvs.4
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 03:42:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f0yfsdol+yJgmcL0Jiq/hqGtRju0QVsHN+RKjYJPQas=;
        b=X58TaR9jrcoyytwU0pKsluhpXU7wXV1TOihlFhPMJNwBqu0bLVb0+fuN4l0orHuU5l
         5+1ltzAo7G6Cdwd6wlgAKLZ0n+3zLha5cfMNYt6hI+GmxHSFR8ameXYURyjFc1mNZ8mK
         43wyYFFL5mtQbVmvgTJZ8EVeioztyJRSgIrGf+/Ym4T6J/pP3Y5cN63F/AZiWVssRH9x
         0QA4ZB1KGogj5P5y7lUhGqtaQO3Ul5L5sfjnUo/QbnN3BgFgIssuVe6ka2Je/wmnK1h7
         uOVsZ2TSESP+TksH8r0iYmzxjZUt3OMMDoSym/MVhCPJafGyTQZSQA0VPC2MywTvVVe5
         cVwg==
X-Gm-Message-State: ANoB5pn2OJ8/ks19Gzqs+0NqZUejig4rVfpan3Xntu0fEP/fdo0Pljrz
        paZOlw2TAfqVjCiOeIBVtSjXw01t1xP2l4IcmwLVoUnUnNc3eVfBy29/oVfNsY8CqoKzMaHphk4
        deQZFVFK8QvKRDskxcylwKAqd
X-Received: by 2002:a0c:ec04:0:b0:4c6:7622:3107 with SMTP id y4-20020a0cec04000000b004c676223107mr16719993qvo.118.1669030939405;
        Mon, 21 Nov 2022 03:42:19 -0800 (PST)
X-Google-Smtp-Source: AA0mqf51P27yIXUDAMmN95CLRvQJ7pjzSqYkeXwmwj4+39MZ+JkgZotPJ6c+McvaUeb1FfoXdaTT2A==
X-Received: by 2002:a0c:ec04:0:b0:4c6:7622:3107 with SMTP id y4-20020a0cec04000000b004c676223107mr16719984qvo.118.1669030939203;
        Mon, 21 Nov 2022 03:42:19 -0800 (PST)
Received: from bfoster (c-24-61-119-116.hsd1.ma.comcast.net. [24.61.119.116])
        by smtp.gmail.com with ESMTPSA id u12-20020a05620a084c00b006ee949b8051sm7773590qku.51.2022.11.21.03.42.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Nov 2022 03:42:18 -0800 (PST)
Date:   Mon, 21 Nov 2022 06:42:24 -0500
From:   Brian Foster <bfoster@redhat.com>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Ivan Babrou <ivan@cloudflare.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@cloudflare.com,
        Alexey Dobriyan <adobriyan@gmail.com>,
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
        Kalesh Singh <kaleshsingh@google.com>
Subject: Re: [PATCH v4] proc: report open files as size in stat() for
 /proc/pid/fd
Message-ID: <Y3tkIFOk78O5A47X@bfoster>
References: <20221024173140.30673-1-ivan@cloudflare.com>
 <Y3fYu2VCBgREBBau@bfoster>
 <CABWYdi3csS3BpoMd8xO=ZXFeBH7KtuLkxzQ8VE5+rO5wrx-yQQ@mail.gmail.com>
 <Y3feB8wHdfx48uCl@bfoster>
 <20221119120111.2dh3tomoawwpyjrg@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221119120111.2dh3tomoawwpyjrg@wittgenstein>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 19, 2022 at 01:01:11PM +0100, Christian Brauner wrote:
> On Fri, Nov 18, 2022 at 02:33:27PM -0500, Brian Foster wrote:
> > On Fri, Nov 18, 2022 at 11:18:36AM -0800, Ivan Babrou wrote:
> > > On Fri, Nov 18, 2022 at 11:10 AM Brian Foster <bfoster@redhat.com> wrote:
> > > > > +static int proc_fd_getattr(struct user_namespace *mnt_userns,
> > > > > +                     const struct path *path, struct kstat *stat,
> > > > > +                     u32 request_mask, unsigned int query_flags)
> > > > > +{
> > > > > +     struct inode *inode = d_inode(path->dentry);
> > > > > +     int rv = 0;
> > > > > +
> > > > > +     generic_fillattr(&init_user_ns, inode, stat);
> > > > > +
> > > >
> > > > Sorry I missed this on v3, but shouldn't this pass through the
> > > > mnt_userns parameter?
> > > 
> > > The mnt_userns parameter was added in 549c729 (fs: make helpers idmap
> > > mount aware), and it's not passed anywhere in fs/proc.
> > > 
> > > Looking at other uses of generic_fillattr, all of them use "init_user_ns":
> > > 
> > 
> > Interesting. It looks like this would have used mnt_userns from
> > vfs_getattr_nosec() before proc_fd_getattr() is wired up, right? I'm not
> > familiar enough with that change to say whether /proc should use one
> > value or the other, or perhaps it just doesn't matter.?
> > 
> > Christian?
> 
> Hey Brian,
> 
> This should pass init_user_ns. So it is correct the way it is done now.
> The init_user_ns is used to indicate that no idmappings are used and
> since procfs doesn't support the creation of idmapped mounts and doesn't
> need to, passing it here makes the most sense. Technically passing down
> mnt_userns would work too but that would make it look like procfs could
> support idmapped mounts which isn't the case and so we don't do it this
> way.
> 

Got it, thanks for the context.

Ivan,

Sorry for the noise. FWIW, for this version of the patch:

Reviewed-by: Brian Foster <bfoster@redhat.com>

> Starting soon this will be a lot clearer too since we're about to
> introduce struct mnt_idmap and replace passing around userns here.
> That'll make things also safer as the helpers that currently could be
> passed a mnt_userns - which could be any userns - will now only be able
> to take mnt_idmap which is a different type.
> 
> Long story short, the way your patch does it is correct.
> 
> Thanks!
> Christian
> 

