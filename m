Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54D516887E2
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 20:57:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232726AbjBBT5W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 14:57:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230070AbjBBT5U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 14:57:20 -0500
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22C511E2A1
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 11:56:37 -0800 (PST)
Received: by mail-qt1-f178.google.com with SMTP id m12so3221429qth.4
        for <linux-kernel@vger.kernel.org>; Thu, 02 Feb 2023 11:56:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=puPH7Nn4Vxt3kUnQKHCGR9XbgEDlt42vfosxQIpu+cs=;
        b=ZQBAwRQXQM7IpNDrPxeXDMkj3mJaaJxqe3bVq2vK7T4k73XxaBQa5N7wP0RHM7m8Ph
         oQMxVhUXwCX0u0K1QARSCQyrbqVHwGviTPCwnIsc5l+MpqE4TF7IFNf5+pxhAfdsEngO
         063tKIDSrEPYJf8hcdqThzPAiaP/vD4h6wnhdg6UTp89JQ6bAlTApLlULxw2LS9oVDET
         +FGCTWZOYVBvj0Qoh9B3GkaJYJ9WJOGzK2eySyWjPmWlqdTe43ESxgEsskjmDGleKh1/
         Z5UC23n+li/7UgE5EWQcBXq3cEi6gFFlCZdFmDMrcO2fi5s7ZKlS9MGpE6C5QgOYe+yS
         XBfg==
X-Gm-Message-State: AO0yUKWfpIisGxDwjv7gxwn74BJtUlSFNfm2z6BzekxCAxOiGDsjq8Ne
        gyer8JYHLuuaf1Ezn17Nd1Ul
X-Google-Smtp-Source: AK7set92dyhIkHCdWF7e92O2MXu6mUmZ6lpekQmSoPBHbD1dR3CVvDYQ1CtAQ9IvY8M0gdRPR2pO1A==
X-Received: by 2002:a05:622a:511:b0:3b8:6c68:6109 with SMTP id l17-20020a05622a051100b003b86c686109mr13439452qtx.21.1675367796153;
        Thu, 02 Feb 2023 11:56:36 -0800 (PST)
Received: from localhost (pool-68-160-166-30.bstnma.fios.verizon.net. [68.160.166.30])
        by smtp.gmail.com with ESMTPSA id h6-20020a05620a10a600b007246f005d8bsm293223qkk.116.2023.02.02.11.56.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 11:56:35 -0800 (PST)
Date:   Thu, 2 Feb 2023 14:56:34 -0500
From:   Mike Snitzer <snitzer@kernel.org>
To:     Demi Marie Obenour <demi@invisiblethingslab.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Roger Pau =?iso-8859-1?Q?Monn=E9?= <roger.pau@citrix.com>,
        Alasdair Kergon <agk@redhat.com>,
        Marek =?iso-8859-1?Q?Marczykowski-G=F3recki?= 
        <marmarek@invisiblethingslab.com>, Juergen Gross <jgross@suse.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        xen-devel@lists.xenproject.org, dm-devel@redhat.com
Subject: Re: [RFC PATCH 0/7] Allow race-free block device handling
Message-ID: <Y9wVcskXyOk3bbzC@redhat.com>
References: <20230126033358.1880-1-demi@invisiblethingslab.com>
 <Y9vp3XDEQAl7TLND@redhat.com>
 <Y9wEF3rWfpiCKc2i@itl-email>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y9wEF3rWfpiCKc2i@itl-email>
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 02 2023 at  1:41P -0500,
Demi Marie Obenour <demi@invisiblethingslab.com> wrote:

> On Thu, Feb 02, 2023 at 11:50:37AM -0500, Mike Snitzer wrote:
> > On Wed, Jan 25 2023 at 10:33P -0500,
> > Demi Marie Obenour <demi@invisiblethingslab.com> wrote:
> > 
> > > This work aims to allow userspace to create and destroy block devices
> > > in a race-free and leak-free way,
> > 
> > "race-free and leak-free way" implies there both races and leaks in
> > existing code. You're making claims that are likely very specific to
> > your Xen use-case.  Please explain more carefully.
> 
> Will do in v2.
> 
> > > and to allow them to be exposed to
> > > other Xen VMs via blkback without leaks or races.  It’s marked as RFC
> > > for a few reasons:
> > > 
> > > - The code has been only lightly tested.  It might be unstable or
> > >   insecure.
> > > 
> > > - The DM_DEV_CREATE ioctl gains a new flag.  Unknown flags were
> > >   previously ignored, so this could theoretically break buggy userspace
> > >   tools.
> > 
> > Not seeing a reason that type of DM change is needed. If you feel
> > strongly about it send a separate patch and we can discuss it.
> 
> Patch 2/7 is the diskseq change.  v2 will contain a revised and tested
> version with a greatly expanded commit message.

I'm aware that 2/7 is where you make the DM change to disallow unknown
flags, what I'm saying is I don't see a reason for that change.

Certainly doesn't look to be a requirement for everything else in that
patch.

So send a separate patch, but I'm inclined to _not_ accept it because
it does potentially break some userspace.
 
> > > - I have no idea if I got the block device reference counting and
> > >   locking correct.
> > 
> > Your headers and justifcation for this line of work are really way too
> > terse. Please take the time to clearly make the case for your changes
> > in both the patch headers and code.
> 
> I will expand the commit message in v2, but I am not sure what you want
> me to add to the code comments.  Would you mind explaining?

Nothing specific about code, was just a general reminder (based on how
terse the 2/7 header was).

Mike
