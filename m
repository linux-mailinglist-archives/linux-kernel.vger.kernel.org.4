Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EF1769365C
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Feb 2023 08:17:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229599AbjBLHRs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Feb 2023 02:17:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjBLHRr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Feb 2023 02:17:47 -0500
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6523E12863;
        Sat, 11 Feb 2023 23:17:46 -0800 (PST)
Received: by mail-qt1-x829.google.com with SMTP id q13so10727789qtx.2;
        Sat, 11 Feb 2023 23:17:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dj/mjlSWyy8D7sem3Xq7H9aE4xWUXTvKfBZb3PK5eN0=;
        b=N8yfPYPIYoEstZAgozDt6SoDUHuyMIh27W8p77E/12OLrkhMfJ6wyLfG56qJ018uiC
         XgQzQALaU2C1a5vfY3cyLFdXUO9bmeO5+tbTJ30f1+s7NeCFMIAYJzuQwxECmvs3D/2H
         RHihEz4SUH2nk3uFpqz9JyyqJS5O+FEhabBmXH0TfkwAnVv1cKLYU9zL9zexOYMudXna
         iCyaNEc9n52n5A31S9WJIYbMMUR8KDCQu+en8FLt+6XC3SPSwUvoDdf+XIJGrkPCmVv+
         gPlbxfH0tAwMZJOUQ57ncEgK2RbX9/B9eXtxbzLUUSlQTkIaqhFTF6H+a9ZywF/jHqKO
         LB+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dj/mjlSWyy8D7sem3Xq7H9aE4xWUXTvKfBZb3PK5eN0=;
        b=RYUXG2TIGBh1MJJMfyq3n148Lel5XRj+NR1A7GguGkYg9Ec3DFGyBtleaMao8R81Ze
         9K4RySdY6RPDT2MgiuHQzYWaO+XInaqfeVHGybmFxiMcK1qfFKSxXnVYH6gJa/i7VBTN
         xAbY9Cd8E2gH/ueMwQJIOtH+BFcrS4zTHaIcH7SIYLveTbz0Kx7aVwu6WGcxAQunzLDO
         2pVNxtQIXpdmQP1SEH2WAHCQghav4l86Sz/Gx5pGJMdbdMeWS4jX5TSabHsM99aJKK/X
         tGVuWLBJYEtvesKoxLSatAtBMCwv3NnKfnhUCBhF32haiBBhPB2X/c1g7OZ3Zk3STt2y
         FT1g==
X-Gm-Message-State: AO0yUKUJUeXOEPvGyB7/rwnnrHIzY2keV4OystQLOKYXaswEHJVqE8MS
        a2D9pgyOA1cPieSzhSauiDn5A6JvPdVJBwkzaAs=
X-Google-Smtp-Source: AK7set83jJ9617n0phsImWW5xRUrXIZ/J7J+kM9Exrj5K8eVgkyRKc57XiunBfV99SSLOwj4nE5x5qY7MtcaFcSsUgk=
X-Received: by 2002:a05:622a:610:b0:3b9:a37e:3a23 with SMTP id
 z16-20020a05622a061000b003b9a37e3a23mr3093912qta.418.1676186265462; Sat, 11
 Feb 2023 23:17:45 -0800 (PST)
MIME-Version: 1.0
References: <20230203190413.2559707-1-nphamcs@gmail.com> <20230203190413.2559707-3-nphamcs@gmail.com>
 <834254e6-a9c2-440c-9c67-fc5fa5ca43bc@app.fastmail.com>
In-Reply-To: <834254e6-a9c2-440c-9c67-fc5fa5ca43bc@app.fastmail.com>
From:   Nhat Pham <nphamcs@gmail.com>
Date:   Sat, 11 Feb 2023 23:17:34 -0800
Message-ID: <CAKEwX=OCURhs77Rdz81m8xyOKER_FvmVGVAKdmSWMgG--jWkKA@mail.gmail.com>
Subject: Re: [PATCH v9 2/3] cachestat: implement cachestat syscall
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, bfoster@redhat.com,
        Matthew Wilcox <willy@infradead.org>,
        linux-api@vger.kernel.org, kernel-team@meta.com
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

On Sun, Feb 5, 2023 at 1:56 AM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Fri, Feb 3, 2023, at 20:04, Nhat Pham wrote:
>
> > +SYSCALL_DEFINE5(cachestat, unsigned int, fd, loff_t, off, size_t, len,
> > +             struct cachestat __user *, cstat, unsigned int, flags)
> > +{
> > +     return ksys_cachestat(fd, off, len, cstat, flags);
> > +}
> > +
> > +#ifdef CONFIG_COMPAT
> > +COMPAT_SYSCALL_DEFINE6(cachestat, unsigned int, fd,
> > compat_arg_u64_dual(off),
> > +             size_t, len, struct cachestat __user *, cstat, unsigned int, flags)
> > +{
> > +     return ksys_cachestat(fd, compat_arg_u64_glue(off), len, cstat,
> > flags);
> > +}
>
> This still looks wrong to me, as this compat definition does not match
> the native variant on architectures that require 64-bit arguments to
> be passed in aligned register pairs, such as arm, mips or ppc, but
> not x86, s390 or riscv.

(looks like I sent the last email in the wrong format - resending this
in plain text to see if the problem persists...)

Oh I see - thanks for pointing that out! And the last bit means this
is a non-issue for x86, s390 or riscv right?

And iirc from the last thread, this is fixable via a simple reordering
of the args in order to properly align the 64-bit arguments, for e.g:

SYSCALL_DEFINE5(cachestat, loff_t, off, unsigned int, fd, size_t, len,
              struct cachestat __user *, cstat, unsigned int, flags)

...

COMPAT_SYSCALL_DEFINE6(cachestat, compat_arg_u64_dual(off),
             unsigned int, fd, size_t, len, struct cachestat __user *, cstat,
             unsigned int, flags)


It looks a bit odd to me that fd is not the first argument, but perhaps this
is an acceptable sacrifice to avoid unused arg and keep the flags...

Let me know what you think about this!

>
>      Arnd
