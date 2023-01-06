Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E6BC65FA1D
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 04:24:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231576AbjAFDYf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 22:24:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbjAFDYb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 22:24:31 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAE11676C0
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 19:24:30 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id m8-20020a05600c3b0800b003d96f801c48so2757757wms.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jan 2023 19:24:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rjo4Jghjutr6bluz62hoCdS6glZQG3a52/9FK2lukzI=;
        b=s532sJFg8u450Qtnjvc/7S8yDiQlxN44MCQwiYg3nBAaEj1ihbFjS7mgygzUH7flRU
         UxThz7fma4uKEzG3fmC1GTapPHlMJUmmBYYR3Fdd7BDVgpVAYeNX1ncZzX5IcIEpcq4P
         EUWrl9zP55XM1wVxSKy7ERkn1duQrGbRcXFKBnZIUCaTRyRW3uhtg53516nGSDsG1BKL
         C4pyo8OLuPv/Hxe8MJ/9yrk6CURl1evRKG79PO3eGHNGfydg0KMOX80uFeX/uEjmHxuw
         sJbfY2Tkwl9zJlglXGqs2PSAxuUEMikqeGIkku8xwlrljedzrVyU7XPkJVddlXPh7ak5
         uIow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rjo4Jghjutr6bluz62hoCdS6glZQG3a52/9FK2lukzI=;
        b=d5Y2vlok6lhmCqsmRscHyjXLtWJFDCsNeNyAsltzgwR2jcydJa31amM+b2mhKk+nGZ
         6CSvkdUoaT7a6PmaHXkkIyoKWlU1LVUosH+sTKj5ri2cSVYExTlE6w6ebz3mXKLUwi8A
         omp7YLaAuYPFRTZ65Fym73A5gf0q2E+O1rC6pX4Gdp4jjJIyvaxlhThkvOeq7D19cUWO
         deHeD/rVLkqPvV2Ki565fEplJ5LatPMlsrXfEiCMk5T0ZUoxTbD6kdpsOL+ai5OSx2kh
         68RqXfjhYisIM7pJUozvLH6TkP7dejFtaWq4Z7Y0XDFwxcfpGBPQhaFMlODVEKfFtOR/
         gi7A==
X-Gm-Message-State: AFqh2kpjL9CDZNbTvXaSQ6PLg7d0FlDXbqpN5Q6fhstMJmBbLZlsHDs0
        7zbINhfuHti0XxEOilNHGLwpN2TrRbpLYFJsrNCLbg==
X-Google-Smtp-Source: AMrXdXuclwraqquA0vdBuCnonnX0190xDNUHXXwRDo+5voZW91MmYn4hpV5T0ELSUtQJm0ZM+GQ27IA6C4zEHvHBNys=
X-Received: by 2002:a05:600c:2d84:b0:3cf:77cc:5f65 with SMTP id
 i4-20020a05600c2d8400b003cf77cc5f65mr2990503wmg.25.1672975469284; Thu, 05 Jan
 2023 19:24:29 -0800 (PST)
MIME-Version: 1.0
References: <20230105100014.1935-1-cuiyunhui@bytedance.com> <20230105090807.51213cea@gandalf.local.home>
In-Reply-To: <20230105090807.51213cea@gandalf.local.home>
From:   =?UTF-8?B?6L+Q6L6J5bSU?= <cuiyunhui@bytedance.com>
Date:   Fri, 6 Jan 2023 11:24:18 +0800
Message-ID: <CAEEQ3wmnUpuZxLbrMwPCk+pnbC27fo4bi-nN-848o6QGO6Xt+Q@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v2] sock: add tracepoint for send recv length
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     mhiramat@kernel.org, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, duanxiongchun@bytedance.com,
        kuniyu@amazon.com, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 5, 2023 at 10:08 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Thu,  5 Jan 2023 18:00:14 +0800
> Yunhui Cui <cuiyunhui@bytedance.com> wrote:
>
> > @@ -715,6 +716,10 @@ static inline int sock_sendmsg_nosec(struct socket=
 *sock, struct msghdr *msg)
> >                                    inet_sendmsg, sock, msg,
> >                                    msg_data_left(msg));
> >       BUG_ON(ret =3D=3D -EIOCBQUEUED);
> > +
> > +     trace_sock_sendmsg_length(sock->sk, sock->sk->sk_family,
> > +                               sock->sk->sk_protocol,
> > +                               ret > 0 ? ret : 0, ret > 0 ? 0 : ret, 0=
);
>
> The length and error seem confusing. Basically, length is ret > 0 and err=
or
> is ret < 0, right?
>
> That means we don't need both. We could simply have:
>
> > +     TP_ARGS(sk, family, protocol, length, error, flags),
>
>         TP_ARGS(sk, family, protocol, ret, flags)
>

Hi Steve, thank you for your advice=EF=BC=8Ci'll modify it on v3.

> >
> > @@ -992,9 +997,17 @@ INDIRECT_CALLABLE_DECLARE(int inet6_recvmsg(struct=
 socket *, struct msghdr *,
> >  static inline int sock_recvmsg_nosec(struct socket *sock, struct msghd=
r *msg,
> >                                    int flags)
> >  {
> > -     return INDIRECT_CALL_INET(sock->ops->recvmsg, inet6_recvmsg,
> > +     int ret =3D INDIRECT_CALL_INET(sock->ops->recvmsg, inet6_recvmsg,
> >                                 inet_recvmsg, sock, msg, msg_data_left(=
msg),
> >                                 flags);
> > +
> > +     trace_sock_recvmsg_length(sock->sk, sock->sk->sk_family,
> > +                               sock->sk->sk_protocol,
> > +                               (ret > 0 && !(flags & MSG_PEEK)) ?
> > +                               ret : 0,
> > +                               (ret > 0 && !(flags & MSG_PEEK)) ? 0 : =
ret,
>
> Since both length and error are zero when flags has MSG_PEEK set:
>
>         trace_sock_recvmsg_length(sock->sk, sock->sk->sk_family,
>                                   sock->sk->sk_protocol,
>                                   !(flags & MSG_PEEK) ? ret : 0,
>
> -- Steve

Regardless of whether the MSG_PEEK flag is set or not, it is possible
to return -errno,
but based on your suggestion, I plan to modify it like this:

trace_sock_recvmsg_length(sock->sk, sock->sk->sk_family,
                          sock->sk->sk_protocol,
                          !(flags & MSG_PEEK) ? ret : (ret < 0 ? ret : 0),

what do you think?

Thanks,
Yunhui
