Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DB7773E432
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 18:07:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231646AbjFZQHh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 12:07:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbjFZQHd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 12:07:33 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1DD4FA;
        Mon, 26 Jun 2023 09:07:31 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2b69e6d324aso21827371fa.0;
        Mon, 26 Jun 2023 09:07:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687795650; x=1690387650;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+4iSzTg8EChOOzM4BxDcM+RvFk02kmVmbliMB8mfUCk=;
        b=RlnK3OZoaEKxJnom2X8CXl92pbWx7OOPW4z0jpKaCHbGXroW0iQAsSISlIaV4C8G8x
         gK1MOooiRRWfenFnvdfXiSVEVcMWb8LVrk+kNPSJIiB4OthW+XopAMs0ohxXFBO6MZzx
         xSS+fZp9IO2IqrTy2iaKTdrItk2cvv2xVSz2QF7kcl2N3PQsgFWom2cZkSD7OlepUhRh
         QeyFDcM0MFp5+izZO5CpgbepvcNdsGpIMb9zj2O9x3o9Wz383Fh4CGG6pOxAOoVXe+26
         Ud/6Sl6lcVCtQjx7rER0jxpx+HyFIEctGfvtCyVSt1QRfo4NaN7sZ6JzkmyeXZNdV+mw
         6o5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687795650; x=1690387650;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+4iSzTg8EChOOzM4BxDcM+RvFk02kmVmbliMB8mfUCk=;
        b=hVK5CsuX4NcJqQAbmE4tmF6kCGlqHVmQ0kNLhh/q0Hzs4sOKfw4oMOLQysFsnuFUKp
         gtyFTSeIj6N4PRx1unjFeFJq+3jxpaGG80FAMyCRnFpCc2zU3nkKK/ofuRMdFDXekNJr
         rLY9AGLSWGuQb4Y6Tf52nhGNNE83WnnrsTqDtq4o6SYhza4Iw6cUzbFX5aa28Us7EABC
         6N7hVLtXcqjAo36bXyLXInC8YENRm70a9dqGVN/JfUqMA/6imh7zVIO4crgj4PVfYlPB
         ZGdl141KeY5SHB9/aU6EHhSjNSNPlZl/o279NBu+DfvdxGpOm1lf6Kq9eV961a9A0+R+
         e/Kw==
X-Gm-Message-State: AC+VfDy9i2E//s7LCpdkIQayJ2h7LrWot5tIK1XzguiI3iufdCxXHAOI
        alAdhVnnanYHb6x7tzsbCikI2m3cXaF+IH3GJDY=
X-Google-Smtp-Source: ACHHUZ4lqZ0HZVO22tySvTRMn9GTWb4kquzbA2i7q+jgXEC8Llv50w26JmRWX6NR8AVm/Q3ttM2tntum2WpC3Qy2R/A=
X-Received: by 2002:a2e:a401:0:b0:2b6:a186:52ac with SMTP id
 p1-20020a2ea401000000b002b6a18652acmr1820365ljn.47.1687795649926; Mon, 26 Jun
 2023 09:07:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230623225513.2732256-1-dhowells@redhat.com> <20230623225513.2732256-5-dhowells@redhat.com>
 <CAOi1vP_Bn918j24S94MuGyn+Gxk212btw7yWeDrRcW1U8pc_BA@mail.gmail.com> <3070989.1687793422@warthog.procyon.org.uk>
In-Reply-To: <3070989.1687793422@warthog.procyon.org.uk>
From:   Ilya Dryomov <idryomov@gmail.com>
Date:   Mon, 26 Jun 2023 18:07:18 +0200
Message-ID: <CAOi1vP9hOhaAWp6ext=6tH7XjKUFAkC0xhkB91QozWr0-fw0NA@mail.gmail.com>
Subject: Re: [PATCH net-next v5 04/16] ceph: Use sendmsg(MSG_SPLICE_PAGES)
 rather than sendpage()
To:     David Howells <dhowells@redhat.com>
Cc:     netdev@vger.kernel.org,
        Alexander Duyck <alexander.duyck@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        David Ahern <dsahern@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Xiubo Li <xiubli@redhat.com>,
        Jeff Layton <jlayton@kernel.org>, ceph-devel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 26, 2023 at 5:30=E2=80=AFPM David Howells <dhowells@redhat.com>=
 wrote:
>
> Ilya Dryomov <idryomov@gmail.com> wrote:
>
> > write_partial_message_data() is net/ceph/messenger_v1.c specific, so it
> > doesn't apply here.  I would suggest squashing the two net/ceph patches
> > into one since even the titles are the same.
>
> I would, but they're now applied to net-next, so we need to patch that.

I don't see a problem with that given that the patches themselves have
major issues (i.e. it's not just a commit message/title nit).

>
> > >   * Write as much as possible.  The socket is expected to be corked,
> > > - * so we don't bother with MSG_MORE/MSG_SENDPAGE_NOTLAST here.
> > > + * so we don't bother with MSG_MORE here.
> > >   *
> > >   * Return:
> > > - *   1 - done, nothing (else) to write
> > > + *  >0 - done, nothing (else) to write
> >
> > It would be nice to avoid making tweaks like this to the outer
> > interface as part of switching to a new internal API.
>
> Ok.  I'll change that and wrap the sendmsg in a loop.  Though, as I asked=
 in
> an earlier reply, why is MSG_DONTWAIT used here?

See my reply there.

>
> > > +       if (WARN_ON(!iov_iter_is_bvec(&con->v2.out_iter)))
> > > +               return -EINVAL;
> >
> > Previously, this WARN_ON + error applied only to the "try sendpage"
> > path.  There is a ton of kvec usage in net/ceph/messenger_v2.c, so I'm
> > pretty sure that placing it here breaks everything.
>
> This should have been removed as MSG_SPLICE_PAGES now accepts KVEC and XA=
RRAY
> iterators also.
>
> Btw, is it feasible to use con->v2.out_iter_sendpage to apply MSG_SPLICE_=
PAGES
> to the iterator to be transmitted as a whole?  It seems to be set dependi=
ng on
> iterator type.

I'm not sure I understand what you mean by "transmitted as a whole".
con->v2.out_iter_sendpage is set only when zerocopy is desired.  If the
underlying data is not guaranteed to remain stable, zerocopy behavior
is not safe.

Thanks,

                Ilya
