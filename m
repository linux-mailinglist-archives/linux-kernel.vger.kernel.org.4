Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C469973E3F8
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 17:53:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231535AbjFZPxD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 11:53:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbjFZPxB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 11:53:01 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1EEAAA;
        Mon, 26 Jun 2023 08:52:47 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-991aac97802so183932466b.1;
        Mon, 26 Jun 2023 08:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687794766; x=1690386766;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o89Xl8sumR+a/JQGWKqb/MvKGfCSwc6E741ND5ks+BU=;
        b=UvHZ1p093j9l8Bo4IqKhWyxuMi83Z9LqBZk6+ZbEfd52QkuOS5jCFKgbi5TLH7G87w
         TMk9esoBHsBIueS7mc+2HystrO5BPvRUmAcFzjXoziOg4eDJXi7ZHkFJRCi6kDWjlpYl
         buM5YSJpTfmZqgPKFrWVYnm7d4pYLIFEcq5IXSnzlEs8PsNgo8Z5F2OgWBiMHrubucik
         PrgbDIWro9z9lmKS2nC/wnbJxpA7ABI//Aw78sBdzbp8XRLy4IK0jS+STAkGhVcQCrtj
         kbbDaGu+sH1ZNYesQIzTBydurRb/ZAvcf+jIvHHLu0lIv8ELog0H/YpGTEu7O9oF9y8c
         +iEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687794766; x=1690386766;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o89Xl8sumR+a/JQGWKqb/MvKGfCSwc6E741ND5ks+BU=;
        b=GGlpW+5E8VtQED6EnM9xqm8tkLwzQYOhYW80uAed4V4hFfey9MLluI8ej2fYYjYCv4
         VoikhxOL1LPs10/d95bQclSu+dWD2PW0Pm3hn5Z7WSt4QNNOHzyk2ACr29C/e+JPUDIS
         vtu8UOtotHac5nIddx6f+dKwDVs0uX53m51jZ51az2g1Qok1a/oLvRiX8XAGRAX7WVoF
         xCjVlumset7x/fL+3kcHJPqHwyppwu/iD+VmYYDXZckIbZ9r8UpZEg7BGOUwrWYD4Cau
         3VJLS4QODcppouZ8sHHpWFv6knmnqgeWTbUY304z8jEgdDLqgip9tWxec7d1B/tVgSzC
         Z5RQ==
X-Gm-Message-State: AC+VfDzwv2hOtdJntML5BM8xjGbcCvC6LDsaS4v7MwNrHQby6Vm7zgvk
        ZlY1/OcAcGG1NAxx3Qul+vqWBbqtE4qz40ks1Zg=
X-Google-Smtp-Source: ACHHUZ7XnDeycUp4pUe7j3Q88b0Gw1/C0bViMqRuArbnTr1VYfSU+hD7wX1I92kAeekeUSg17sTL5jLyYREWZH0nCno=
X-Received: by 2002:a17:907:97cf:b0:991:e961:a5f4 with SMTP id
 js15-20020a17090797cf00b00991e961a5f4mr1282227ejc.20.1687794766223; Mon, 26
 Jun 2023 08:52:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230623225513.2732256-1-dhowells@redhat.com> <20230623225513.2732256-4-dhowells@redhat.com>
 <CAOi1vP9vjLfk3W+AJFeexC93jqPaPUn2dD_4NrzxwoZTbYfOnw@mail.gmail.com> <3070680.1687792331@warthog.procyon.org.uk>
In-Reply-To: <3070680.1687792331@warthog.procyon.org.uk>
From:   Ilya Dryomov <idryomov@gmail.com>
Date:   Mon, 26 Jun 2023 17:52:34 +0200
Message-ID: <CAOi1vP93bAhYbgEz+oBbWaB4nzm=vBhfRu0Dj5Cs6_GHJrxWpQ@mail.gmail.com>
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

On Mon, Jun 26, 2023 at 5:12=E2=80=AFPM David Howells <dhowells@redhat.com>=
 wrote:
>
> Ilya Dryomov <idryomov@gmail.com> wrote:
>
> > > -       int flags =3D MSG_DONTWAIT | MSG_NOSIGNAL | more;
>
> Btw, why are you setting MSG_DONTWAIT?  If you're in the middle of
> transmitting a message on a TCP socket, surely you can't just switch to
> transmitting a different message on the same socket without doing some so=
rt of
> reframing?

We don't want to hog kworker threads.  You are correct that we can't
switch to transmitting a different message on the same socket but Ceph
is massively parallel and there can be dozens or even hundreds of other
sockets to work on.

Thanks,

                Ilya
