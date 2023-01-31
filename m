Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B6E868395A
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 23:29:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231552AbjAaW31 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 17:29:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229962AbjAaW3Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 17:29:25 -0500
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B8D31CF73
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 14:29:24 -0800 (PST)
Received: by mail-yb1-xb2b.google.com with SMTP id c124so20021511ybb.13
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 14:29:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zeRarg6CqXMEX8rLftL5bCcpMW/NHnhU9LHLUUmOD0U=;
        b=gBXFgUNPHp3apwCjs098LhxtEdcLfrKpSRz1EDvEhiVP7XyiRn8CziBjpO9abvkoGd
         sJ0mKqwK39pY6Ui/D2BqBcWhGdC5o3xDnFL+yq4seXwW32rw3Uaz/r5uoOHGveb1U7zI
         //RD+171zjH7SHww5egifnPZ0h8VGrbAptEElNF34N+ZeXERk5DJ63C+2P6Wrlby9aWI
         ZiYVyMynkcl5YZ1Ps7mJy+RcqUgGLqnxr/vfE7MEBcngrtg3F6OfLkxSku9j8WdPSD8j
         6lIWm2+x+wqM9b3823Ksq7KZCFx6vflqkJUOTNCjA8mVdhu37w82DgsZoXkS9H9of0U4
         s19w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zeRarg6CqXMEX8rLftL5bCcpMW/NHnhU9LHLUUmOD0U=;
        b=jelVCI5RiWQP0g5muU6EJgp8S/Z4IQiRSNokLxFn/8NKNqdvQrawRJkqSscMFmgNii
         F+R27JCnDolqxxSNmoqSXCAor2VqKLUAle1bYAqhhQSpT9hie5w/YxXUBeswhfscV8eD
         UsHQ1Be0Uwyvv1nDnd3mjoV0DnuAaNH1gf/urkitnIGZJT/2nVuliK3wa6y3feACED8z
         +IsAICXQSuC4Pub8EUTsqhLMVa6rm+uyH/5Wtu4o4QBG/2J3EC5kEb3O1Vee7P2NTIFb
         aOwp5IShe2t34iV3rElK/jE7YnZI6/JwHA7IuPClHG0dnxooAORQSy3uhKgDbyg/LcSB
         QkQw==
X-Gm-Message-State: AO0yUKUUENy0yxkQWdKya3iLf/Nh7mG+GSWdZDfO/68j7jj/FQRU+/uG
        V36tbs7bFGRCIcVaaNCgWULD+RBy0AIxaMCCifc4+w==
X-Google-Smtp-Source: AK7set/cWlCmeUTW+A8zJSzg38BetBn2D9i2nnIo50u/JNifuJOrAFuyiJOsRmP5GCPK0vR5sOeaRY4fEyV557sJXuA=
X-Received: by 2002:a25:908:0:b0:703:e000:287 with SMTP id 8-20020a250908000000b00703e0000287mr83847ybj.171.1675204163710;
 Tue, 31 Jan 2023 14:29:23 -0800 (PST)
MIME-Version: 1.0
References: <20230131210051.475983-4-andrei.gherzan@canonical.com>
 <CA+FuTScJCaW+UL0dDDg-7nNdhdZV7Xs5MrfBkGAg-jR4az+DRQ@mail.gmail.com> <Y9mTRER69Z7BGqB5@qwirkle>
In-Reply-To: <Y9mTRER69Z7BGqB5@qwirkle>
From:   Willem de Bruijn <willemb@google.com>
Date:   Tue, 31 Jan 2023 17:28:47 -0500
Message-ID: <CA+FuTSfHtidA9zLZMpo+1AoVh=rN=nWyxfVtsUDuuJHmr9UFUw@mail.gmail.com>
Subject: Re: [PATCH net-next v3 4/4] selftests: net: udpgso_bench_tx: Cater
 for pending datagrams zerocopy benchmarking
To:     Andrei Gherzan <andrei.gherzan@canonical.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Fred Klassen <fklassen@appneta.com>, netdev@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 31, 2023 at 5:16 PM Andrei Gherzan
<andrei.gherzan@canonical.com> wrote:
>
> On 23/01/31 04:51PM, Willem de Bruijn wrote:
> > On Tue, Jan 31, 2023 at 4:01 PM Andrei Gherzan
> > <andrei.gherzan@canonical.com> wrote:
> > >
> > > The test tool can check that the zerocopy number of completions value is
> > > valid taking into consideration the number of datagram send calls. This can
> > > catch the system into a state where the datagrams are still in the system
> > > (for example in a qdisk, waiting for the network interface to return a
> > > completion notification, etc).
> > >
> > > This change adds a retry logic of computing the number of completions up to
> > > a configurable (via CLI) timeout (default: 2 seconds).
> > >
> > > Fixes: 79ebc3c26010 ("net/udpgso_bench_tx: options to exercise TX CMSG")
> > > Signed-off-by: Andrei Gherzan <andrei.gherzan@canonical.com>
> > > Cc: Willem de Bruijn <willemb@google.com>
> > > Cc: Paolo Abeni <pabeni@redhat.com>
> > > ---
> > >  tools/testing/selftests/net/udpgso_bench_tx.c | 34 +++++++++++++++----
> > >  1 file changed, 27 insertions(+), 7 deletions(-)
> > >
> > > diff --git a/tools/testing/selftests/net/udpgso_bench_tx.c b/tools/testing/selftests/net/udpgso_bench_tx.c
> > > index b47b5c32039f..ef887842522a 100644
> > > --- a/tools/testing/selftests/net/udpgso_bench_tx.c
> > > +++ b/tools/testing/selftests/net/udpgso_bench_tx.c
> > > @@ -62,6 +62,7 @@ static int    cfg_payload_len = (1472 * 42);
> > >  static int     cfg_port        = 8000;
> > >  static int     cfg_runtime_ms  = -1;
> > >  static bool    cfg_poll;
> > > +static int     cfg_poll_loop_timeout_ms = 2000;
> > >  static bool    cfg_segment;
> > >  static bool    cfg_sendmmsg;
> > >  static bool    cfg_tcp;
> > > @@ -235,16 +236,17 @@ static void flush_errqueue_recv(int fd)
> > >         }
> > >  }
> > >
> > > -static void flush_errqueue(int fd, const bool do_poll)
> > > +static void flush_errqueue(int fd, const bool do_poll,
> > > +               unsigned long poll_timeout, const bool poll_err)
> >
> > nit: his indentation looks off though
>
> This one I've missed but I couldn't find any guidelines on it. Could you
> clarify to me what this should be or point me to soem docs? Happy to fix
> otherwise. I'm currently using vim smartindent but it is definitely not
> in line with what is here already.

It should align with the parameter above.

https://www.kernel.org/doc/html/latest/process/coding-style.html#breaking-long-lines-and-strings
