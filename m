Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D20B73D0D8
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 14:20:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232095AbjFYMUn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 08:20:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232076AbjFYMUl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 08:20:41 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E947D1BD;
        Sun, 25 Jun 2023 05:20:39 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-98802908fedso279885566b.1;
        Sun, 25 Jun 2023 05:20:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687695638; x=1690287638;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V7KPNN3dcJM6yUTrzmIqZSy+gTXexfBKQa7fvuuRSyc=;
        b=cZKLxUCppVrYmgBeC4LLrwI2N0DBxnvV6gp+t7dX1Y5mxHj8MHxz4QHPYLiIBOplhN
         pf6iiwdh+drvo6yKZIx9pxLUfk1WeH9vd+nM7nPA8Im3H7XVy0VC1ggf0ZQS1DEd9+M7
         QFX8wzk8WMHQUA61YooaN5MvF3GnQafJYtfc4TXA3z0pslH1vPZyNdcUEx4BVjtpNUOK
         gZ4q0h3p7S4NeH5TC7POjGpoZh2iW1Qc8F8EKr5nnG6/FE7hSCz6emUamQgOM/iqdlmY
         shATfJLRR55YpKoFHbtUmh7KddrDs5FZWvWlW/6wa/keyt9+kBc75yhLq7FWDR8w8jFd
         bNkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687695638; x=1690287638;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V7KPNN3dcJM6yUTrzmIqZSy+gTXexfBKQa7fvuuRSyc=;
        b=XekSssrncB5iTRml2XjXZepzVm6JsApQNR0gPSS4TDH7tZgLaoqvnUlPoNQ1grdgyU
         oC5ZXTw8s0tqP5H1cqYSjs+OVXUMvxNTsCUPqUb7A2PNpHYpqOaJL0wWhPAzISh8Mhia
         B5NsySdxJOZ+XwSPMib+PgMRuTXyG9FcrAcBCdIU1zbsXCcLRvqQL4is4gy2PMZ4C5jM
         pIc+f8JpSlu/TcpN9X+vUSOu+S7vCCh2IXmQ/o82pDi9qmxOzvwX8Dj1i3EMQka9hHRv
         nhZq/3wp2DCvr6tRPAgqV6N/x8lT4dOh0nTUv9caFlo+ztNRQRfX+2Lmef8aCuBsJtaY
         Uq3Q==
X-Gm-Message-State: AC+VfDxoNovECxcLTezqmNP6lv6Kxn6Bu9wzXNIEXmsjhefyTMjejp4u
        94+HQdibBTCwuFUlSirv5O9Je+oD5eSs8PhpNGw=
X-Google-Smtp-Source: ACHHUZ7KwJHRqX1MuUtimjsWYw/kK4Obl2eXn5iOMkVJDNbY7TLmwUvwuWQEXwGbqlfggQ7cjnwnCsW2h4IaJ80NM80=
X-Received: by 2002:a17:907:7892:b0:98e:933:28fe with SMTP id
 ku18-20020a170907789200b0098e093328femr2558618ejc.66.1687695638195; Sun, 25
 Jun 2023 05:20:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230623225513.2732256-1-dhowells@redhat.com> <20230623225513.2732256-4-dhowells@redhat.com>
In-Reply-To: <20230623225513.2732256-4-dhowells@redhat.com>
From:   Ilya Dryomov <idryomov@gmail.com>
Date:   Sun, 25 Jun 2023 14:20:26 +0200
Message-ID: <CAOi1vP9vjLfk3W+AJFeexC93jqPaPUn2dD_4NrzxwoZTbYfOnw@mail.gmail.com>
Subject: Re: [PATCH net-next v5 03/16] ceph: Use sendmsg(MSG_SPLICE_PAGES)
 rather than sendpage
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

On Sat, Jun 24, 2023 at 12:55=E2=80=AFAM David Howells <dhowells@redhat.com=
> wrote:
>
> Use sendmsg() and MSG_SPLICE_PAGES rather than sendpage in ceph when
> transmitting data.  For the moment, this can only transmit one page at a
> time because of the architecture of net/ceph/, but if
> write_partial_message_data() can be given a bvec[] at a time by the
> iteration code, this would allow pages to be sent in a batch.
>
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
> ---
>
> Notes:
>     ver #5)
>      - Switch condition for setting MSG_MORE in write_partial_message_dat=
a()
>
>  net/ceph/messenger_v1.c | 60 ++++++++++++++---------------------------
>  1 file changed, 20 insertions(+), 40 deletions(-)
>
> diff --git a/net/ceph/messenger_v1.c b/net/ceph/messenger_v1.c
> index d664cb1593a7..814579f27f04 100644
> --- a/net/ceph/messenger_v1.c
> +++ b/net/ceph/messenger_v1.c
> @@ -74,37 +74,6 @@ static int ceph_tcp_sendmsg(struct socket *sock, struc=
t kvec *iov,
>         return r;
>  }
>
> -/*
> - * @more: either or both of MSG_MORE and MSG_SENDPAGE_NOTLAST
> - */
> -static int ceph_tcp_sendpage(struct socket *sock, struct page *page,
> -                            int offset, size_t size, int more)
> -{
> -       ssize_t (*sendpage)(struct socket *sock, struct page *page,
> -                           int offset, size_t size, int flags);
> -       int flags =3D MSG_DONTWAIT | MSG_NOSIGNAL | more;
> -       int ret;
> -
> -       /*
> -        * sendpage cannot properly handle pages with page_count =3D=3D 0=
,
> -        * we need to fall back to sendmsg if that's the case.
> -        *
> -        * Same goes for slab pages: skb_can_coalesce() allows
> -        * coalescing neighboring slab objects into a single frag which
> -        * triggers one of hardened usercopy checks.
> -        */
> -       if (sendpage_ok(page))
> -               sendpage =3D sock->ops->sendpage;
> -       else
> -               sendpage =3D sock_no_sendpage;
> -
> -       ret =3D sendpage(sock, page, offset, size, flags);
> -       if (ret =3D=3D -EAGAIN)
> -               ret =3D 0;
> -
> -       return ret;
> -}
> -
>  static void con_out_kvec_reset(struct ceph_connection *con)
>  {
>         BUG_ON(con->v1.out_skip);
> @@ -464,7 +433,6 @@ static int write_partial_message_data(struct ceph_con=
nection *con)
>         struct ceph_msg *msg =3D con->out_msg;
>         struct ceph_msg_data_cursor *cursor =3D &msg->cursor;
>         bool do_datacrc =3D !ceph_test_opt(from_msgr(con->msgr), NOCRC);
> -       int more =3D MSG_MORE | MSG_SENDPAGE_NOTLAST;
>         u32 crc;
>
>         dout("%s %p msg %p\n", __func__, con, msg);
> @@ -482,6 +450,10 @@ static int write_partial_message_data(struct ceph_co=
nnection *con)
>          */
>         crc =3D do_datacrc ? le32_to_cpu(msg->footer.data_crc) : 0;
>         while (cursor->total_resid) {
> +               struct bio_vec bvec;
> +               struct msghdr msghdr =3D {
> +                       .msg_flags =3D MSG_SPLICE_PAGES,

Hi David,

This appears to be losing MSG_DONTWAIT | MSG_NOSIGNAL flags which were
set previously?

> +               };
>                 struct page *page;
>                 size_t page_offset;
>                 size_t length;
> @@ -493,10 +465,13 @@ static int write_partial_message_data(struct ceph_c=
onnection *con)
>                 }
>
>                 page =3D ceph_msg_data_next(cursor, &page_offset, &length=
);
> -               if (length =3D=3D cursor->total_resid)
> -                       more =3D MSG_MORE;
> -               ret =3D ceph_tcp_sendpage(con->sock, page, page_offset, l=
ength,
> -                                       more);
> +               if (length !=3D cursor->total_resid)
> +                       msghdr.msg_flags |=3D MSG_MORE;
> +
> +               bvec_set_page(&bvec, page, length, page_offset);
> +               iov_iter_bvec(&msghdr.msg_iter, ITER_SOURCE, &bvec, 1, le=
ngth);
> +
> +               ret =3D sock_sendmsg(con->sock, &msghdr);
>                 if (ret <=3D 0) {

And this is losing munging -EAGAIN -> 0?

>                         if (do_datacrc)
>                                 msg->footer.data_crc =3D cpu_to_le32(crc)=
;
> @@ -526,7 +501,10 @@ static int write_partial_message_data(struct ceph_co=
nnection *con)
>   */
>  static int write_partial_skip(struct ceph_connection *con)
>  {
> -       int more =3D MSG_MORE | MSG_SENDPAGE_NOTLAST;
> +       struct bio_vec bvec;
> +       struct msghdr msghdr =3D {
> +               .msg_flags =3D MSG_SPLICE_PAGES | MSG_MORE,
> +       };
>         int ret;
>
>         dout("%s %p %d left\n", __func__, con, con->v1.out_skip);
> @@ -534,9 +512,11 @@ static int write_partial_skip(struct ceph_connection=
 *con)
>                 size_t size =3D min(con->v1.out_skip, (int)PAGE_SIZE);
>
>                 if (size =3D=3D con->v1.out_skip)
> -                       more =3D MSG_MORE;
> -               ret =3D ceph_tcp_sendpage(con->sock, ceph_zero_page, 0, s=
ize,
> -                                       more);
> +                       msghdr.msg_flags &=3D ~MSG_MORE;
> +               bvec_set_page(&bvec, ZERO_PAGE(0), size, 0);
> +               iov_iter_bvec(&msghdr.msg_iter, ITER_SOURCE, &bvec, 1, si=
ze);
> +
> +               ret =3D sock_sendmsg(con->sock, &msghdr);
>                 if (ret <=3D 0)

Same here...  I would suggest that you keep ceph_tcp_sendpage() function
and make only minimal modifications to avoid regressions.

Thanks,

                Ilya
