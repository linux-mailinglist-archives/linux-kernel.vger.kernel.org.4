Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85098667971
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 16:36:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240474AbjALPgo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 10:36:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240314AbjALPft (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 10:35:49 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EF7F34765
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 07:26:57 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id 17so20607753pll.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 07:26:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WVlLxH2Rj+8QSEZoiILadbKJQqSAUcthH+jBOnJMZHA=;
        b=JftHModyBQyWOf9IbcHgv+wM+wAMjzeIgqay2Sc8xYfkI5JHsWwEEaR0BrMLIrDI0F
         yxykKOAvVOboJ8Q3inG5JiMM5zD9V4Wn648fS3KtICCIxD5uZqOMV4/KjWnV0Hk62u/K
         0g4zOe1NM3yXUlV8A36BJ7zUBJLOFJCN2pqMQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WVlLxH2Rj+8QSEZoiILadbKJQqSAUcthH+jBOnJMZHA=;
        b=3JA/hNOsPUCXSHyXPL+ipTLgcIvIpAgREzqflV6utGcUPJLFWKab+CBJjpYcqX1B7K
         aZ/za9VLIHFboBaDWEEaU7ssiZ2ZP97T8Gyv6auT2ir62M8ajdzbzqaNWJzRjfwvwgS2
         ng1QpBZPkKlxGoNQ9T35nPr2LrO7NRAZXtKkCmUPcXua1YMzzPLCXFvZVlKvc4NxmvfX
         V09dyUMRE6kED4UWGNYbo816Tnxz1+UloAm9x0Ln2j9uVU0/IYk/i3qO22TExp1QiCip
         5ksCUUBQDubOk4tzQwZ1otvjC7jULEiFkZgCNHEVKyU8RyQwWTq9OqJoCttqKRzR5u1Z
         KhAQ==
X-Gm-Message-State: AFqh2kqobvi0IkRfB2bI7/7G1gNAr5UfsSDAkYhvCILyFR+c2YJ2sHR1
        F/k6ODN2G8vRv9M5VqjB8nmpT5X4GQDdiIvSZB39cg==
X-Google-Smtp-Source: AMrXdXszpIuyfj/mHnCEnh6uhFgYKDm3M6iMpGAaIQNcUe0iGzTUPpaT/7EySwmrAqTumWdnNX0AssRqS0MYKX5qVxs=
X-Received: by 2002:a17:902:bf45:b0:189:505b:73dd with SMTP id
 u5-20020a170902bf4500b00189505b73ddmr5104347pls.143.1673537217363; Thu, 12
 Jan 2023 07:26:57 -0800 (PST)
MIME-Version: 1.0
References: <20230104175633.1420151-1-dragos.panait@windriver.com>
 <20230104175633.1420151-2-dragos.panait@windriver.com> <Y8ABeXQLzWdoaGAY@kroah.com>
In-Reply-To: <Y8ABeXQLzWdoaGAY@kroah.com>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Thu, 12 Jan 2023 16:26:45 +0100
Message-ID: <CAKMK7uEgzJU8ukgR3sQtSUB5+wrD9VyMwCHOA-SReFWd0tKzzw@mail.gmail.com>
Subject: Re: [PATCH 5.10 1/1] drm/amdkfd: Check for null pointer after calling kmemdup
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Dragos-Marian Panait <dragos.panait@windriver.com>,
        stable@vger.kernel.org, Jiasheng Jiang <jiasheng@iscas.ac.cn>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Oded Gabbay <oded.gabbay@gmail.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Kent Russell <kent.russell@amd.com>,
        Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Jan 2023 at 13:47, Greg KH <gregkh@linuxfoundation.org> wrote:
> On Wed, Jan 04, 2023 at 07:56:33PM +0200, Dragos-Marian Panait wrote:
> > From: Jiasheng Jiang <jiasheng@iscas.ac.cn>
> >
> > [ Upstream commit abfaf0eee97925905e742aa3b0b72e04a918fa9e ]
> >
> > As the possible failure of the allocation, kmemdup() may return NULL
> > pointer.
> > Therefore, it should be better to check the 'props2' in order to prevent
> > the dereference of NULL pointer.
> >
> > Fixes: 3a87177eb141 ("drm/amdkfd: Add topology support for dGPUs")
> > Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
> > Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
> > Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > Signed-off-by: Dragos-Marian Panait <dragos.panait@windriver.com>
> > ---
> >  drivers/gpu/drm/amd/amdkfd/kfd_crat.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> > index 86b4dadf772e..02e3c650ed1c 100644
> > --- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> > +++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> > @@ -408,6 +408,9 @@ static int kfd_parse_subtype_iolink(struct crat_subtype_iolink *iolink,
> >                       return -ENODEV;
> >               /* same everything but the other direction */
> >               props2 = kmemdup(props, sizeof(*props2), GFP_KERNEL);
> > +             if (!props2)
> > +                     return -ENOMEM;
>
> Not going to queue this up as this is a bogus CVE.

Are we at the point where CVE presence actually contraindicates
backporting? At least I'm getting a bit the feeling there's a surge of
automated (security) fixes that just don't hold up to any scrutiny.
Last week I had to toss out an fbdev locking patch due to static
checker that has no clue at all how refcounting works, and so
complained that things need more locking ... (that was -fixes, but
would probably have gone to stable too if I didn't catch it).

Simple bugfixes from random people was nice when it was checkpatch
stuff and I was fairly happy to take these aggressively in drm. But my
gut feeling says things seem to be shifting towards more advanced
tooling, but without more advanced understanding by submitters. Does
that holder in other areas too?
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
