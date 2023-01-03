Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D449E65C78D
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 20:32:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239023AbjACTba (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 14:31:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233920AbjACTbJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 14:31:09 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7630813D06
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 11:31:05 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id cp9-20020a17090afb8900b00226a934e0e5so535670pjb.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jan 2023 11:31:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GfjrvxCRgV3vcT3TiLbdLY/UTFxhC+HimhMaHMPiFqY=;
        b=lArsKCWjaQrB20DDdwcxHZshdTmlKenjx9q1kEE6MWgGogRQe1DWuhUAXVToG8qYiA
         8U8uXUk4teUMCrqDh5YtbMTi0o6YZOYfyQyxJjOD4NylWdGhThCq8q5I2boGk/1RWJca
         1bI+yV0oKGCQmpGLKKhqmgyiBJsK1/96ROlvc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GfjrvxCRgV3vcT3TiLbdLY/UTFxhC+HimhMaHMPiFqY=;
        b=tr6fUHgN+wP8/yvLrL3+PQUjcceyIbFe9Y/bLvqWXuB0OdZfPpfBK0LKBCpl966KEU
         DoNBJhu3S9Ld9EfpT4WtmYhge3CxldlZ55GkkVSUqiUoNyhfgg61pW92gTEU5OKzepWT
         kSGKliymE0c+WIQA5O+wuFJuZR2qJsA26lTRIpxemKopM1yLpzhwDyyIh/n/pqPa0ax7
         dWP05PNAY9pEOHEVtpYTn4sle2kXgNBWgqtst9a8k1dcJhjURQ3/JysAGFn+uc6bFd8m
         aso9w90/3u9fVmSXvsgVolgP861U8G1ID+asoybmpfxa4N46UauH2DKEFqUq2Gl5RK5y
         N8uQ==
X-Gm-Message-State: AFqh2ko6z8KqvWk8HZxCf5iDqb1FzkAH6q/XHOUNZXmp9y9UnXEm+AWN
        tY0E7awKLbN3ckYf+zxyLTtIZQ==
X-Google-Smtp-Source: AMrXdXsKEEFQguyagMQJh3jY/kGtdS7/3uuyfSVz8A0CqGldjL2bRyaXEVYiTKdrfQ9NZagj701hNg==
X-Received: by 2002:a17:902:ca95:b0:189:e711:173 with SMTP id v21-20020a170902ca9500b00189e7110173mr42031348pld.33.1672774264931;
        Tue, 03 Jan 2023 11:31:04 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:d4fc:5992:1009:1647])
        by smtp.gmail.com with ESMTPSA id l2-20020a170903244200b001888cadf8f6sm22727951pls.49.2023.01.03.11.31.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jan 2023 11:31:04 -0800 (PST)
Date:   Tue, 3 Jan 2023 11:31:02 -0800
From:   Brian Norris <briannorris@chromium.org>
To:     Guenter Roeck <groeck@google.com>
Cc:     Julius Werner <jwerner@chromium.org>,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Guenter Roeck <groeck@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Jack Rosenthal <jrosenth@chromium.org>, coreboot@coreboot.org,
        Kees Cook <keescook@chromium.org>
Subject: Re: memcpy: detected field-spanning write (size 168) of single field
 "&device->entry" at drivers/firmware/google/coreboot_table.c:103 (size 8)
Message-ID: <Y7SCdrL+xZm5CSjy@google.com>
References: <03ae2704-8c30-f9f0-215b-7cdf4ad35a9a@molgen.mpg.de>
 <CAODwPW8=1R53Dir+CFHu-NADygCZVqDjsg0q+xT-KheZHghxtw@mail.gmail.com>
 <CABXOdTcvBe5PzO6RrUDC-NcYpWYuabZkN1qXA=gSqbhPHLxqsw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABXOdTcvBe5PzO6RrUDC-NcYpWYuabZkN1qXA=gSqbhPHLxqsw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 29, 2022 at 12:28:14PM -0800, Guenter Roeck wrote:
> On Thu, Dec 29, 2022 at 6:43 AM Julius Werner <jwerner@chromium.org> wrote:
> >
> > I can confirm that this warning is a false positive, at least. We're
> > intentionally copying bytes from beyond the end of the header
> > structure in this case.
> >
> > I don't know what kind of kernel system detects this stuff at runtime
> > and how to silence it. Probably need to add a void pointer cast or
> > something?
> >
> 
> This is part of kernel hardening code. Kees Cook might know what to do about it.

One could probably throw in casts, like this example did:

  0d043351e5ba ext4: fix fortify warning in fs/ext4/fast_commit.c:1551

Or one could probably imitate this example, and insert an appropriate
flexible array (possibly with yet another union?):

  b43088f30db1 s390/zcrypt: fix warning about field-spanning write

Side mostly-unrelated note: coreboot_table_populate() doesn't do any
bounds checking that the individual entry copies don't overflow the
table buffer size. We're _probably_ not that interested in recovering
from a malicious (or even buggy) Coreboot, but it does seem like an area
of improvement.

Brian

> 
> Guenter
> 
> > On Thu, Dec 29, 2022 at 11:46 AM Paul Menzel <pmenzel@molgen.mpg.de> wrote:
> > >
> > > Dear Linux folks,
> > >
> > >
> > > Running Linux v6.2-rc1+ on a motherboard using coreboot as firmware, the
> > > warning below is shown.
> > >
> > > ```
> > > [    1.630244] ------------[ cut here ]------------
> > > [    1.630249] memcpy: detected field-spanning write (size 168) of
> > > single field "&device->entry" at
> > > drivers/firmware/google/coreboot_table.c:103 (size 8)
> > > [    1.630299] WARNING: CPU: 1 PID: 150 at
> > > drivers/firmware/google/coreboot_table.c:103
> > > coreboot_table_probe+0x1ea/0x210 [coreboot_table]
[...]
