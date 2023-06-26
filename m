Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42D8573E3AA
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 17:42:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230076AbjFZPl7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 11:41:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231343AbjFZPlz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 11:41:55 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40F861BDF;
        Mon, 26 Jun 2023 08:41:24 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2b6a1fe5845so16784251fa.3;
        Mon, 26 Jun 2023 08:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687794075; x=1690386075;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pfYjtj1R9OBqs+dVmgnQu3/n0GQzqWIXlWSAYyCQgfE=;
        b=ZC4tdxELBaEzsmkyrCDXSO4zrWdOHRW66r1aH4EZlhpnkAAIXHH6JHFNZgMHV97kLH
         WOuPG/Z/LMu4Jx40e2mXYXuNlsp8pGN7Mr9cjtCijXBsWURhkgTn1yMVbUCXv+mAsvTj
         EDc3zwgKi0AfwDX8md+tia3QCxgpDyVEQ39x/fixcn/aqfps8qdjVfFPbBy7fpqpx87m
         tFfrzz+Gomg3ypUedSrjtmiK3UCI5V2/KEs+Udwqmgj9lHEV33Qbs5PxXO5iP3ETt8vn
         4ns2G4yK0bQpMAkRLSgB/LKumhHwl80LtXN9zFUf3Nxj5ZY3O+Bp5C1NWf1RYm7HaWVr
         6KTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687794075; x=1690386075;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pfYjtj1R9OBqs+dVmgnQu3/n0GQzqWIXlWSAYyCQgfE=;
        b=WfaW+MVgVsLlpdFC+L2vafK+Wz7OG6FKqVB/dWeO8SsVuHWbZl7s+3m8mvqXrFakJv
         5hUy9/E6wRrCH/DISJPqbixhlHJZhWeMbLA7aqyazIjhW7+hiYBYz3duq7jow0X7WC5x
         tRX0G/kKvB8NAcKnqlPeh6w9FnVYYRRRIy2y6N/Z195ymN0CADYQEj64t0kZ2R0q/mI9
         RgvrCHp2PO3CVGT5ihkAXvLDHTp0wgRFmwM2/JZJtm3y6N50dahsKhXdxcG5Ds+Jf1Sp
         SWC6vSUhztwwk+E4Z2/4FpoEwMFoSn4IFp+3vj6f8lbjcU8P+uDOplNYbRWaO/ifbDAm
         9YwA==
X-Gm-Message-State: AC+VfDwcSMHc8XAdunc1aJZQ19J0Akm1ZDKPqr8JxrYH/itG3W+xKbxL
        xm7I2nIQ4/aKYDF/oq6p/LhfJ6rP/KmMpA0JI28=
X-Google-Smtp-Source: ACHHUZ7VE+8iZfotd1r+SiAoEv3NvBloeBmppqXFsMvjW04FYaybsoeMhBTGyEWcgQXFE0Lrufy5XWjXJ5HBl9IL5ik=
X-Received: by 2002:a05:651c:207:b0:2b4:7d01:f174 with SMTP id
 y7-20020a05651c020700b002b47d01f174mr15122288ljn.13.1687794075146; Mon, 26
 Jun 2023 08:41:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230623225513.2732256-1-dhowells@redhat.com> <20230623225513.2732256-4-dhowells@redhat.com>
 <CAOi1vP9vjLfk3W+AJFeexC93jqPaPUn2dD_4NrzxwoZTbYfOnw@mail.gmail.com> <3068221.1687788027@warthog.procyon.org.uk>
In-Reply-To: <3068221.1687788027@warthog.procyon.org.uk>
From:   Ilya Dryomov <idryomov@gmail.com>
Date:   Mon, 26 Jun 2023 17:41:03 +0200
Message-ID: <CAOi1vP8AyL=nsqDw-QKjPsC8wMsEnq+hSh29PobADYLm-L9ZNg@mail.gmail.com>
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

On Mon, Jun 26, 2023 at 4:00=E2=80=AFPM David Howells <dhowells@redhat.com>=
 wrote:
>
> Ilya Dryomov <idryomov@gmail.com> wrote:
>
> > Same here...  I would suggest that you keep ceph_tcp_sendpage() functio=
n
> > and make only minimal modifications to avoid regressions.
>
> This is now committed to net-next.

This needs to be dropped from linux-next because both this and
especially the other (net/ceph/messenger_v2.c) patch introduce
regressions.

> I can bring ceph_tcp_sendpage() back into
> existence or fix it in place for now if you have a preference.

I already mentioned that I would prefer if ceph_tcp_sendpage() was
brought back into existence.

>
> Note that I'm working on patches to rework the libceph transmission path =
so
> that it isn't dealing with transmitting a single page at a time, but it's=
 not
> ready yet.

That is a worthwhile improvement now that sock_sendmsg() can take
advantage of multiple pages!  It would be pretty invasive though so
I think ceph_tcp_sendpage() is better to remain in place until then.

Thanks,

                Ilya
