Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A332B73FCD4
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 15:26:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229790AbjF0N0X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 09:26:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230106AbjF0N0O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 09:26:14 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F4BF19B9;
        Tue, 27 Jun 2023 06:26:13 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-98d34f1e54fso459783866b.2;
        Tue, 27 Jun 2023 06:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687872371; x=1690464371;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6S4/hBpcq9fn95F7UiT7442wCV5lG3nYUQpBdlngERU=;
        b=KYSl1w1kl4+4Xk4M0X+cBmSe7SNSiDMpJjfK/d3Wdr1aDd+ov8pWpf5OiM/i7Uthx9
         HkDXee1eLt39RJfuphrRIqeTcdXpPapxP+UQuX9q5FvkXqPOAQO8QX3kVjBLDp4OFfVZ
         rA0jz34nhYP/3bnOmcxXNj7W8qBn3WehbBzKf0aTwhZE4nNI5gRZxe0L5cXzc6l2CcdD
         Rk4GXd+WQBIIJd212Oaw9WDFy5B9Binpw71db2O2ML5sLD79sw2sr/xVQgWksCFLTVAX
         zsaTj6TB7ygJxtfPG6JsB274Q4lst6bj95x7QZbDQBrldxR5oGuMLPLANL+HnKln9vTG
         ffLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687872371; x=1690464371;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6S4/hBpcq9fn95F7UiT7442wCV5lG3nYUQpBdlngERU=;
        b=lB/1jPSHikZBvh02fGJ0fPn6r5xoWt69JcZysZZGeQd2sI0+30N9lff522qSJFxrIC
         bLwXKwiyBYImGArvJt+R6yY3mWkscwMHkXcVzgk96Euhn4iFnn7eHsDFULDGGcmg15f9
         PP5arUJVwfvkpPKQx7tg+MuWK6R7GewsHGMdV8pEgDDTYqN/r6zbgTp6zNvFVkNYuZDJ
         G4EsA0w5FfxcKul4XaHEhsl8zD0WuBthQ0KwhKHRKoA6VhtVPQhw/YF//H5fMC1isBUn
         NaIqX+vhtcmrLojpbwSEOLkH79Vag8HqlHAOOKLOa6NDTgt8IBgUi4PB074dEo9/Waxm
         zBvQ==
X-Gm-Message-State: AC+VfDwIQQMf9WlMDY8VbbPahsJsPpXlDbFNETlaX3yEq44d6mTs1l3f
        swriqleEUgO8MKmWso0jd8Pv2Iqek+1UkzEq15U=
X-Google-Smtp-Source: ACHHUZ6ACvph/qn6yTFkB7J8H1FalScmv4hLG9cKnYhZl9WOH6W6I76t0jnICUK4i/K9deZ8V7nHfH+Gr71ZCzv64UE=
X-Received: by 2002:a17:907:a01:b0:974:56aa:6dce with SMTP id
 bb1-20020a1709070a0100b0097456aa6dcemr23792032ejc.46.1687872371406; Tue, 27
 Jun 2023 06:26:11 -0700 (PDT)
MIME-Version: 1.0
References: <3111635.1687813501@warthog.procyon.org.uk>
In-Reply-To: <3111635.1687813501@warthog.procyon.org.uk>
From:   Ilya Dryomov <idryomov@gmail.com>
Date:   Tue, 27 Jun 2023 15:25:59 +0200
Message-ID: <CAOi1vP9y7-nMye8u82+O-FxoAPecbecasfY0=yH3TvQYYyCEtA@mail.gmail.com>
Subject: Re: [PATCH net-next v2] libceph: Partially revert changes to support MSG_SPLICE_PAGES
To:     David Howells <dhowells@redhat.com>
Cc:     netdev@vger.kernel.org, Xiubo Li <xiubli@redhat.com>,
        Jeff Layton <jlayton@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Matthew Wilcox <willy@infradead.org>,
        ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Mon, Jun 26, 2023 at 11:05=E2=80=AFPM David Howells <dhowells@redhat.com=
> wrote:
>
> Fix the mishandling of MSG_DONTWAIT and also reinstates the per-page
> checking of the source pages (which might have come from a DIO write by
> userspace) by partially reverting the changes to support MSG_SPLICE_PAGES
> and doing things a little differently.  In messenger_v1:
>
>  (1) The ceph_tcp_sendpage() is resurrected and the callers reverted to u=
se
>      that.
>
>  (2) The callers now pass MSG_MORE unconditionally.  Previously, they wer=
e
>      passing in MSG_MORE|MSG_SENDPAGE_NOTLAST and then degrading that to
>      just MSG_MORE on the last call to ->sendpage().
>
>  (3) Make ceph_tcp_sendpage() a wrapper around sendmsg() rather than
>      sendpage(), setting MSG_SPLICE_PAGES if sendpage_ok() returns true o=
n
>      the page.
>
> In messenger_v2:
>
>  (4) Bring back do_try_sendpage() and make the callers use that.
>
>  (5) Make do_try_sendpage() use sendmsg() for both cases and set
>      MSG_SPLICE_PAGES if sendpage_ok() is set.
>
> Fixes: 40a8c17aa770 ("ceph: Use sendmsg(MSG_SPLICE_PAGES) rather than sen=
dpage")
> Fixes: fa094ccae1e7 ("ceph: Use sendmsg(MSG_SPLICE_PAGES) rather than sen=
dpage()")
> Reported-by: Ilya Dryomov <idryomov@gmail.com>
> Link: https://lore.kernel.org/r/CAOi1vP9vjLfk3W+AJFeexC93jqPaPUn2dD_4Nrzx=
woZTbYfOnw@mail.gmail.com/
> Link: https://lore.kernel.org/r/CAOi1vP_Bn918j24S94MuGyn+Gxk212btw7yWeDrR=
cW1U8pc_BA@mail.gmail.com/
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Ilya Dryomov <idryomov@gmail.com>
> cc: Xiubo Li <xiubli@redhat.com>
> cc: Jeff Layton <jlayton@kernel.org>
> cc: "David S. Miller" <davem@davemloft.net>
> cc: Eric Dumazet <edumazet@google.com>
> cc: Jakub Kicinski <kuba@kernel.org>
> cc: Paolo Abeni <pabeni@redhat.com>
> cc: Jens Axboe <axboe@kernel.dk>
> cc: Matthew Wilcox <willy@infradead.org>
> cc: ceph-devel@vger.kernel.org
> cc: netdev@vger.kernel.org
> Link: https://lore.kernel.org/r/3101881.1687801973@warthog.procyon.org.uk=
/ # v1
> ---
> Notes:
>     ver #2)
>      - Removed mention of MSG_SENDPAGE_NOTLAST in comments.
>      - Changed some refs to sendpage to MSG_SPLICE_PAGES in comments.
>      - Init msg_iter in ceph_tcp_sendpage().
>      - Move setting of MSG_SPLICE_PAGES in do_try_sendpage() next to comm=
ent
>        and adjust how it is cleared.
>
>  net/ceph/messenger_v1.c |   58 ++++++++++++++++++++-----------
>  net/ceph/messenger_v2.c |   88 ++++++++++++++++++++++++++++++++++++++---=
-------
>  2 files changed, 107 insertions(+), 39 deletions(-)
>
> diff --git a/net/ceph/messenger_v1.c b/net/ceph/messenger_v1.c
> index 814579f27f04..51a6f28aa798 100644
> --- a/net/ceph/messenger_v1.c
> +++ b/net/ceph/messenger_v1.c
> @@ -74,6 +74,39 @@ static int ceph_tcp_sendmsg(struct socket *sock, struc=
t kvec *iov,
>         return r;
>  }
>
> +/*
> + * @more: MSG_MORE or 0.
> + */
> +static int ceph_tcp_sendpage(struct socket *sock, struct page *page,
> +                            int offset, size_t size, int more)
> +{
> +       struct msghdr msg =3D {
> +               .msg_flags =3D MSG_DONTWAIT | MSG_NOSIGNAL | more,
> +       };
> +       struct bio_vec bvec;
> +       int ret;
> +
> +       /*
> +        * MSG_SPLICE_PAGES cannot properly handle pages with page_count =
=3D=3D 0,
> +        * we need to fall back to sendmsg if that's the case.
> +        *
> +        * Same goes for slab pages: skb_can_coalesce() allows
> +        * coalescing neighboring slab objects into a single frag which
> +        * triggers one of hardened usercopy checks.
> +        */
> +       if (sendpage_ok(page))
> +               msg.msg_flags |=3D MSG_SPLICE_PAGES;
> +
> +       bvec_set_page(&bvec, page, size, offset);
> +       iov_iter_bvec(&msg.msg_iter, ITER_DEST, &bvec, 1, size);

Hi David,

Shouldn't this be ITER_SOURCE?

Thanks,

                Ilya
