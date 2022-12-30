Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EE97659E3F
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Dec 2022 00:28:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230468AbiL3X2l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Dec 2022 18:28:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229938AbiL3X2c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Dec 2022 18:28:32 -0500
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D57FE13D4C;
        Fri, 30 Dec 2022 15:28:31 -0800 (PST)
Received: by mail-oi1-x22e.google.com with SMTP id i127so20506466oif.8;
        Fri, 30 Dec 2022 15:28:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4IkI6vy8eebK2fwJ2aoil/AxN2eFftPhnKXap/KdveM=;
        b=XdxM+f3d1DUsLGej44Offnqr5B8TwxtwS2lslLz3sekorPPaK3HVcMqforvpCVZNbj
         Ce1P+j2/pZHpKBFeMiunlRtQJZL4HVC8Jxj86rsu0LcG46sZS+q9eoEx40NpUiMPMs2z
         nU5wvUv8auYYXPJv6zixea6eWW3ZOoXZAGzfxx046N3UVMnWqNy7YqarvestStU/Grsw
         Jx0Hx1z3Qjj4N9W90tjKnKP4ts49V4iCVh9hAwW8ikylOshnJCfOw+t4oSIGF9TPn7D1
         WPeUNq/eIKgW4L/SbESaWIL+YBvsC4nSaKIe7c8o3J37noRD0FutJwlQj0GDpTF6ZdLi
         Jj+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4IkI6vy8eebK2fwJ2aoil/AxN2eFftPhnKXap/KdveM=;
        b=yk0wjCgtl/CiI9hHnyjHAaYr5soEojhRtcXysNkiTAvQXr55FVg9XMLQ3yrI4urQmh
         Xp85u13VaACMIepxijvyoeg+q6Zmw0fibeB9m3dc4wwybk44UC4Hw2EhIOKA0F0LDTap
         ToLP9Kby8GN72Ayyw0Z8Fq1Lb3SmpvbjJqX4qlxfVIcke0tUmwQvfSN/vRAM+y0YFmSk
         yhzYm6s4LOhButt5GLdIHCI6Tgfd6NzzAMwalgzDGalc5k0ObIeBlqR5h9VhUhrHFeUo
         vvEXkhPZKUGA2qe6rZUq59HfBz8xuI2sFr86IsV7aWd3NmiWJvpJjm1fL2wO1f6C2MGD
         IjUQ==
X-Gm-Message-State: AFqh2kr+hD27OvhPyVFCZNKFUwhnS5Md1oNFtWn5FmKDFLWntmb/ioj7
        Q9K9RMdGAp+j6nkfxX/QUis76lzFpp9EahcGnsj80ByZCEY=
X-Google-Smtp-Source: AMrXdXuFKQhABZItpKWCjyIMyzhC84k1nK1KJjvORQuidPmiB0EGFzq9zpZHo4M+corWJdxPWjgixVrSBFszfAaoyoo=
X-Received: by 2002:a05:6808:1904:b0:35e:55de:13ae with SMTP id
 bf4-20020a056808190400b0035e55de13aemr1625470oib.199.1672442911175; Fri, 30
 Dec 2022 15:28:31 -0800 (PST)
MIME-Version: 1.0
References: <20221227063335.61474-1-zh.nvgt@gmail.com> <CAJZ5v0jmOMHHXvRnDcetDbh+0CySh5ddZJx1g3xTXPzCHokZRg@mail.gmail.com>
In-Reply-To: <CAJZ5v0jmOMHHXvRnDcetDbh+0CySh5ddZJx1g3xTXPzCHokZRg@mail.gmail.com>
From:   Hang Zhang <zh.nvgt@gmail.com>
Date:   Fri, 30 Dec 2022 18:28:20 -0500
Message-ID: <CAO2zrtbXDdWLhyZkJhisou4zxypxA-Fhpxx1Cop1ZXXf3oUxeA@mail.gmail.com>
Subject: Re: [PATCH] ACPI: custom_method: fix potential use-after-free issues
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 30, 2022 at 1:31 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Tue, Dec 27, 2022 at 7:34 AM Hang Zhang <zh.nvgt@gmail.com> wrote:
> >
> > cm_write() is the .write callback of the custom_method debugfs
> > interface, it operates on a global pointer "buf" (e.g., dereference,
> > allocate, free, and nullification), the problem is that cm_write()
> > is not protected by any locks, so concurrent invocations of it
> > may cause use-after-free issues for "buf", e.g., one invocation
> > may have just freed "buf" while being preempted before nullifying
> > the pointer, then another invocation can dereference the now dangling
> > "buf" pointer.
> >
> > Fix the issue by protecting the "buf" operations in cm_write() with
> > the inode write lock. Note that the .llseek callback of the debugfs
> > interface has been protected by the same lock, this patch basically
> > introduces it to the .write callback as well.
>
> The problem is there, but the whole state is not protected from
> concurrent use and the fix doesn't look sufficient to me (for example,
> a different writer may start writing into the file before the previous
> one has finished and the result will still be broken AFAICS).
>
> It looks like the file should be prevented from being opened by more
> than one writer at a time.
>
> Or maybe it's time to drop this interface from the kernel altogether.

Hi, Rafael,

Thank you very much for your feedback! We initially intended to bring
up this potential concurrent UAF issue to the community with this
tentative patch, but we do not have deep domain knowledge for the
ACPI subsystem and the bigger picture, so your comment is highly
valuable to us!

As far as I can understand, inode_lock is uniquely associated with
the opened file, e.g., if two writers open the same debugfs file
and write to it, then inode_lock as used in this patch should be
able to synchronize their concurrent write because their inode_lock
are on the same semaphore. Do you mean that this "custom_method"
driver will handle the .open/.write of multiple different debugfs
file instances, so that writers accessing different file instances
will not be properly synchronized with inode_lock? Sorry if I missed
anything here, and thank you in advance for your explanation!

I also think it is a good solution to totally drop this interface
if the maintainers consider it appropriate (I do not have
the knowledge to assess the role this interface plays, though).
Thank you for your help!
