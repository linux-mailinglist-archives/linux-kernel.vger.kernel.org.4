Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D6516FE20A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 18:04:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbjEJQD6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 12:03:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjEJQD4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 12:03:56 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C197729A
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 09:03:55 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3f315735514so252929405e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 09:03:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683734633; x=1686326633;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fvb5c8XHp0X/zl+kmljpZAR9ySI5JukAMLSjveQ9KvE=;
        b=SjDW8NOkcbo4wS9s5RXuLm9xUMD2fAwEdbM3mB/VDOwzylwy5VPcOvhSwXRnQ6kS1U
         r7/Pa3TDsn+pLDMF6Pk2JuuNrNoFhPCV9z82QAz84miyg0J+hdbxC+MIk0eOVzPhhq7n
         AchgMTLc8ow8Dlnzxje6WjPJdMYdCpW8gAu0cYHY5CZ4Fqx7X03dcRpJj9snP0KYmINv
         llZqoDik6I/2+Wbjf1eAhOSPIVD8Hd2QDxeaIW3sv9cdAmlcKdnWfFpfr0rrsojI9uoh
         c8/o/OtH2cNJ20h1u/wP14Z2+758qzQ1oqDITh64MPMCbWPmeOpzj+QjTydREnDKEVuA
         ZOEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683734633; x=1686326633;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fvb5c8XHp0X/zl+kmljpZAR9ySI5JukAMLSjveQ9KvE=;
        b=kvzNdUIZWvv0JQvGBzbBaaLoru1Hxy4+yvGoqCfGbDygktm6Mb8BaO48Ne4e/31b1l
         +VgH+jFCe8JSqhR2i8Es6XoRhKfL0P5kuQXf2qXqhdFJZi53NwYZT4gGqpzrWGvB+CTI
         xP5xnk+q4prJXJbt8ccpOwWFuYU8MLLyQ0o3cKHJddT+H1gcST61KK9YfocMpzUdxb0x
         3pMnqbN6G9ZW/+rkxQ0l2LugkyOkxw+fLaZ+0AMLYzF40xzaXkiPG6JpFYrqm9sPwtu1
         x3za7O8NyHNiHKDxVLBhOo0odxcVdDWDNfQuI0zXvUuZ962bmFlnHn6SBN8Z2TWEVD+m
         CleQ==
X-Gm-Message-State: AC+VfDweLwcBBc+L8s/841ISKI1GNVMJgkW27QryuWUE7Refm4PvNqmh
        CUzKrcWe1MfPAOWCqTwOcbt6sLNQH8bYvkrKWsU=
X-Google-Smtp-Source: ACHHUZ7EJQiLNXjlvmSoR4zq2SYEExRwgcJ4BJInW7W5zQb57/TbPQ1vw0USwh1GckVcSOo+5DxlsHX9sEpkGrhlZRs=
X-Received: by 2002:adf:e7ca:0:b0:303:daff:f1a3 with SMTP id
 e10-20020adfe7ca000000b00303dafff1a3mr17720801wrn.1.1683734633316; Wed, 10
 May 2023 09:03:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230510011122.3040915-1-azeemshaikh38@gmail.com> <ZFryVUHtkN5QbKTP@slm.duckdns.org>
In-Reply-To: <ZFryVUHtkN5QbKTP@slm.duckdns.org>
From:   Azeem Shaikh <azeemshaikh38@gmail.com>
Date:   Wed, 10 May 2023 12:03:41 -0400
Message-ID: <CADmuW3XiYpGK7BessXJWjGnnxZti_3mawDSX7QPawsfmATxCng@mail.gmail.com>
Subject: Re: [PATCH v2] kernfs: Prefer strscpy over strlcpy calls
To:     Tejun Heo <tj@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        security@kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 9, 2023 at 9:24=E2=80=AFPM Tejun Heo <tj@kernel.org> wrote:
>
> On Wed, May 10, 2023 at 01:11:22AM +0000, Azeem Shaikh wrote:
> ...
> > +/* strscpy_mock_strlcpy - imitates strlcpy API but uses strscpy undern=
eath. */
> > +static size_t strscpy_mock_strlcpy(char *dest, const char *src, size_t=
 count)
> > +{
> > +     strscpy(dest, src, count);
> > +     return strlen(src);
> > +}
>
> I'm not sure this is a meaningful conversion. One benefit of strscpy() is
> that it's less error-prone to check for overflows. What's the point of
> removing strlcpy() if we end up sprinkling lesser duplicates in the tree?
>

Thanks for your patience and helpful feedback on this Tejun, very much
appreciated.
I've responded to your comments below and added my notes on the
transitive usage of the functions.
Happy to send a smaller patch which directly replaces strlcpy->strscpy.

> >  static int kernfs_name_locked(struct kernfs_node *kn, char *buf, size_=
t buflen)
> >  {
> >       if (!kn)
> > -             return strlcpy(buf, "(null)", buflen);
> > +             return strscpy_mock_strlcpy(buf, "(null)", buflen);
> >
> > -     return strlcpy(buf, kn->parent ? kn->name : "/", buflen);
> > +     return strscpy_mock_strlcpy(buf, kn->parent ? kn->name : "/", buf=
len);
> >  }
>
> Can you follow the users and convert the users accordingly rather than
> masking it from here? ie. make kernfs_name() and friends return -E2BIG wh=
en
> source is too long like strscpy(). I don't think anybody cares, actually.
>

I found 4 transitive callers of kernfs_name across the kernel, all of
whom eventually ignored the return value:

1. fs/kernfs/dir.c: calls kernfs_name. Ignores return value.
2. include/linux/cgroup.h: calls kernfs_name from cgroup_name. returns
the value of kernfs_name.
3. kernel/cgroup/debug.c: calls cgroup_name. Ignores return value.
4.mm/page_owner.c: calls cgroup_name. Ignores return value.

So replacing directly with strscpy here should be safe. Let me know
what you think.

> >  /* kernfs_node_depth - compute depth from @from to @to */
> > @@ -141,13 +148,13 @@ static int kernfs_path_from_node_locked(struct ke=
rnfs_node *kn_to,
> >       int i, j;
> >
> >       if (!kn_to)
> > -             return strlcpy(buf, "(null)", buflen);
> > +             return strscpy_mock_strlcpy(buf, "(null)", buflen);
> >
> >       if (!kn_from)
> >               kn_from =3D kernfs_root(kn_to)->kn;
> >
> >       if (kn_from =3D=3D kn_to)
> > -             return strlcpy(buf, "/", buflen);
> > +             return strscpy_mock_strlcpy(buf, "/", buflen);
> >
> >       common =3D kernfs_common_ancestor(kn_from, kn_to);
> >       if (WARN_ON(!common))
> > @@ -159,16 +166,16 @@ static int kernfs_path_from_node_locked(struct ke=
rnfs_node *kn_to,
> >       buf[0] =3D '\0';
> >
> >       for (i =3D 0; i < depth_from; i++)
> > -             len +=3D strlcpy(buf + len, parent_str,
> > +             len +=3D strscpy_mock_strlcpy(buf + len, parent_str,
> >                              len < buflen ? buflen - len : 0);
> >
> >       /* Calculate how many bytes we need for the rest */
> >       for (i =3D depth_to - 1; i >=3D 0; i--) {
> >               for (kn =3D kn_to, j =3D 0; j < i; j++)
> >                       kn =3D kn->parent;
> > -             len +=3D strlcpy(buf + len, "/",
> > +             len +=3D strscpy_mock_strlcpy(buf + len, "/",
> >                              len < buflen ? buflen - len : 0);
> > -             len +=3D strlcpy(buf + len, kn->name,
> > +             len +=3D strscpy_mock_strlcpy(buf + len, kn->name,
> >                              len < buflen ? buflen - len : 0);
> >       }
>
> Ditto, please convert all the users accordingly. If that's not feasible, =
I
> think it'd be better to leave it as-is. I don't see how the new code is
> better.
>

kernfs_path_from_node has quite a few transitive callers. I'll leave
this as-is for now and consider tackling this separately.

> > @@ -851,7 +858,7 @@ static struct kernfs_node *kernfs_walk_ns(struct ke=
rnfs_node *parent,
> >
> >       spin_lock_irq(&kernfs_pr_cont_lock);
> >
> > -     len =3D strlcpy(kernfs_pr_cont_buf, path, sizeof(kernfs_pr_cont_b=
uf));
> > +     len =3D strscpy_mock_strlcpy(kernfs_pr_cont_buf, path, sizeof(ker=
nfs_pr_cont_buf));
> >
> >       if (len >=3D sizeof(kernfs_pr_cont_buf)) {
> >               spin_unlock_irq(&kernfs_pr_cont_lock);
>
> This is an easy conversion to strscpy().

Ack.

>
> Thanks.


>
> --
> tejun
