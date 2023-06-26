Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 314DB73EBC1
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 22:23:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229808AbjFZUXQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 16:23:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229943AbjFZUXN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 16:23:13 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F418510CC;
        Mon, 26 Jun 2023 13:23:05 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2b5c231f842so32003071fa.2;
        Mon, 26 Jun 2023 13:23:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687810984; x=1690402984;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N+afpUqUgO3CcUicCLnW8oZ9GpmDccQRCfUB8BuBpHM=;
        b=fRayBtAFFLvM/R80MwuZwHpKxY5vA0bV9vqTBPstxOg2J42R7YtQwQUN+o2bNMxF2y
         yRvEw+LBnLBrUr/yPHdF7oC+ClQaxpyhZtJg/eLyuXSWvHvxJ5lsQ94SHRFy7Zbt4AFB
         AH1tuLhExN1znW20ABkCEIru5eihiGFssZzVkC84upAi0RBUV5C0iv/c0ws9oSR6BCqw
         vsRNiUocx8O3tWuUGbKVGI/tgIcmCADY99ubeP1AKg5uoOqeRO1rXFY4j+RmX229KaRx
         Yt3RcrxLJuKxXT1Z+N+IhVgiaiB1eXDVNtSQC5J/w8V9aMKGgX5jknWgXZqxx5Tmu92j
         odyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687810984; x=1690402984;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N+afpUqUgO3CcUicCLnW8oZ9GpmDccQRCfUB8BuBpHM=;
        b=ea0cWFslDGEHKqof4wigvLVgzIz89xTepVLaj9fs/alR7vjjgzNzeF07F+BXmwyjJe
         gc7iNZus+knhXNQSadh9OTnNVBV9BR1Lab4yF8XLfhC0xxT9PrEU6tTasuyIMWM/qYcH
         kMf1wf+y4VWYbBmCeqyfNHeM21ztoqHwAVDdPQk9WYg56qL+0Pag9aprKd9/H/9+V543
         Kigv7FvMQRVQZjKtZBRScp3ZcOPlkBofJCSa97UjpPpD60gJ2ibQoYYDj4TD9kuqWZUd
         2t65DtkFqCb+zOU1ERdoV+HOzPq3OxDwknWfystFurL4qwbrqtE1MKqMT7P9CBlv/QHb
         Ukqg==
X-Gm-Message-State: AC+VfDya8MXRHUkIfvGwtrpaV8gbXVzSqf4h7Xxh69H83OGk29HqrsNO
        IOPhlrVcnLD9ke/FHH9QtRxAQgUDX7uKFMLCYcw=
X-Google-Smtp-Source: ACHHUZ5hvqpJrwoenjnisP2tLiZFIA1b1al2OZoYk7zoF2GBn8JP4rgdpeXWgxKVqLFZG0bqK2fGtqZBCQFFwCrpTgo=
X-Received: by 2002:a2e:9982:0:b0:2b6:a6a6:4a16 with SMTP id
 w2-20020a2e9982000000b002b6a6a64a16mr1487497lji.3.1687810983897; Mon, 26 Jun
 2023 13:23:03 -0700 (PDT)
MIME-Version: 1.0
References: <3101881.1687801973@warthog.procyon.org.uk>
In-Reply-To: <3101881.1687801973@warthog.procyon.org.uk>
From:   Ilya Dryomov <idryomov@gmail.com>
Date:   Mon, 26 Jun 2023 22:22:51 +0200
Message-ID: <CAOi1vP_g70kV_YFjHNoS1hHPpCiMxW1hTfm92Ud35ehYrmv=1Q@mail.gmail.com>
Subject: Re: [PATCH net-next] libceph: Partially revert changes to support MSG_SPLICE_PAGES
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

On Mon, Jun 26, 2023 at 7:53=E2=80=AFPM David Howells <dhowells@redhat.com>=
 wrote:
>
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
> Note that libceph is using sendpage_ok() for this, but it should not real=
ly
> be considered exhaustive in this regard - this is, however, what libceph =
is
> doing upstream.

Such use spans far beyond libceph: drbd, iSCSI, NVMe-over-TCP, etc.
sendpage_ok() the only tool we have got...

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
> ---
>  net/ceph/messenger_v1.c |   57 +++++++++++++++++++------------
>  net/ceph/messenger_v2.c |   87 ++++++++++++++++++++++++++++++++++++++---=
-------
>  2 files changed, 105 insertions(+), 39 deletions(-)
>
> diff --git a/net/ceph/messenger_v1.c b/net/ceph/messenger_v1.c
> index 814579f27f04..1ee58cbaf151 100644
> --- a/net/ceph/messenger_v1.c
> +++ b/net/ceph/messenger_v1.c
> @@ -74,6 +74,38 @@ static int ceph_tcp_sendmsg(struct socket *sock, struc=
t kvec *iov,
>         return r;
>  }
>
> +/*
> + * @more: either or both of MSG_MORE and MSG_SENDPAGE_NOTLAST

MSG_SENDPAGE_NOTLAST flag doesn't exist anymore.

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
> +        * sendpage cannot properly handle pages with page_count =3D=3D 0=
,

I would suggest sendpage -> MSG_SPLICE_PAGES here like was done in
the other file.

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

The bvec is not added to the message, so I don't think this actually
sends anything...

> +
> +       ret =3D sock_sendmsg(sock, &msg);
> +       if (ret =3D=3D -EAGAIN)
> +               ret =3D 0;
> +
> +       return ret;
> +}
> +
>  static void con_out_kvec_reset(struct ceph_connection *con)
>  {
>         BUG_ON(con->v1.out_skip);
> @@ -450,10 +482,6 @@ static int write_partial_message_data(struct ceph_co=
nnection *con)
>          */
>         crc =3D do_datacrc ? le32_to_cpu(msg->footer.data_crc) : 0;
>         while (cursor->total_resid) {
> -               struct bio_vec bvec;
> -               struct msghdr msghdr =3D {
> -                       .msg_flags =3D MSG_SPLICE_PAGES,
> -               };
>                 struct page *page;
>                 size_t page_offset;
>                 size_t length;
> @@ -465,13 +493,8 @@ static int write_partial_message_data(struct ceph_co=
nnection *con)
>                 }
>
>                 page =3D ceph_msg_data_next(cursor, &page_offset, &length=
);
> -               if (length !=3D cursor->total_resid)
> -                       msghdr.msg_flags |=3D MSG_MORE;
> -
> -               bvec_set_page(&bvec, page, length, page_offset);
> -               iov_iter_bvec(&msghdr.msg_iter, ITER_SOURCE, &bvec, 1, le=
ngth);
> -
> -               ret =3D sock_sendmsg(con->sock, &msghdr);
> +               ret =3D ceph_tcp_sendpage(con->sock, page, page_offset, l=
ength,
> +                                       MSG_MORE);
>                 if (ret <=3D 0) {
>                         if (do_datacrc)
>                                 msg->footer.data_crc =3D cpu_to_le32(crc)=
;
> @@ -501,22 +524,14 @@ static int write_partial_message_data(struct ceph_c=
onnection *con)
>   */
>  static int write_partial_skip(struct ceph_connection *con)
>  {
> -       struct bio_vec bvec;
> -       struct msghdr msghdr =3D {
> -               .msg_flags =3D MSG_SPLICE_PAGES | MSG_MORE,
> -       };
>         int ret;
>
>         dout("%s %p %d left\n", __func__, con, con->v1.out_skip);
>         while (con->v1.out_skip > 0) {
>                 size_t size =3D min(con->v1.out_skip, (int)PAGE_SIZE);
>
> -               if (size =3D=3D con->v1.out_skip)
> -                       msghdr.msg_flags &=3D ~MSG_MORE;
> -               bvec_set_page(&bvec, ZERO_PAGE(0), size, 0);
> -               iov_iter_bvec(&msghdr.msg_iter, ITER_SOURCE, &bvec, 1, si=
ze);
> -
> -               ret =3D sock_sendmsg(con->sock, &msghdr);
> +               ret =3D ceph_tcp_sendpage(con->sock, ceph_zero_page, 0, s=
ize,
> +                                       MSG_MORE);
>                 if (ret <=3D 0)
>                         goto out;
>                 con->v1.out_skip -=3D ret;
> diff --git a/net/ceph/messenger_v2.c b/net/ceph/messenger_v2.c
> index 87ac97073e75..139b61598f4f 100644
> --- a/net/ceph/messenger_v2.c
> +++ b/net/ceph/messenger_v2.c
> @@ -117,38 +117,89 @@ static int ceph_tcp_recv(struct ceph_connection *co=
n)
>         return ret;
>  }
>
> +static int do_sendmsg(struct socket *sock, struct iov_iter *it)
> +{
> +       struct msghdr msg =3D { .msg_flags =3D CEPH_MSG_FLAGS };
> +       int ret;
> +
> +       msg.msg_iter =3D *it;
> +       while (iov_iter_count(it)) {
> +               ret =3D sock_sendmsg(sock, &msg);
> +               if (ret <=3D 0) {
> +                       if (ret =3D=3D -EAGAIN)
> +                               ret =3D 0;
> +                       return ret;
> +               }
> +
> +               iov_iter_advance(it, ret);
> +       }
> +
> +       WARN_ON(msg_data_left(&msg));
> +       return 1;
> +}
> +
> +static int do_try_sendpage(struct socket *sock, struct iov_iter *it)
> +{
> +       struct msghdr msg =3D {};
> +       struct bio_vec bv;
> +       int ret;
> +
> +       if (WARN_ON(!iov_iter_is_bvec(it)))
> +               return -EINVAL;
> +
> +       while (iov_iter_count(it)) {
> +               msg.msg_flags =3D CEPH_MSG_FLAGS;
> +               if (sendpage_ok(bv.bv_page))
> +                       msg.msg_flags |=3D MSG_SPLICE_PAGES;
> +
> +               /* iov_iter_iovec() for ITER_BVEC */
> +               bvec_set_page(&bv, it->bvec->bv_page,
> +                             min(iov_iter_count(it),
> +                                 it->bvec->bv_len - it->iov_offset),
> +                             it->bvec->bv_offset + it->iov_offset);
> +
> +               /*
> +                * MSG_SPLICE_PAGES cannot properly handle pages with
> +                * page_count =3D=3D 0, we need to fall back to sendmsg i=
f
> +                * that's the case.
> +                *
> +                * Same goes for slab pages: skb_can_coalesce() allows
> +                * coalescing neighboring slab objects into a single frag
> +                * which triggers one of hardened usercopy checks.
> +                */

This comment is now misplaced.  I would suggest

  if (sendpage_ok(bv.bv_page))
          msg.msg_flags |=3D MSG_SPLICE_PAGES;
  else
          msg.msg_flags &=3D ~MSG_SPLICE_PAGES;

here and keeping the initialization

  struct msghdr msg =3D { .msg_flags =3D CEPH_MSG_FLAGS };

above thus staying closer to the original.

Thanks,

                Ilya
