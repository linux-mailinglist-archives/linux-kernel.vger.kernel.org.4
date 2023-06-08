Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3036C728973
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 22:30:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231971AbjFHUaa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 16:30:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbjFHUaJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 16:30:09 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B361E3584
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 13:29:29 -0700 (PDT)
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com [209.85.167.200])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id CF4A73F364
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 20:29:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1686256147;
        bh=qREPRnbFoZDSkGcbr3ixpo6NMxfZ+kQ8GXlQeYCh42M=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=Htu1rTcgCJMupUbMIPAxKJSnF+9Yt/X34k0Ym4wrXFPF+UtR0NEQURwtHAwtelFbF
         1OfyNLo1U7xdIuoEcCt3EQuxy6UABjTMBq2tSqQ6MU57QFi5y1e8ZGUb7J+i5fOowy
         P0YxTYEJt4Yu3FmuORL9EEngbNjckwJzWEmGtflH8xJloZd9piTwHLqoQKE0lewy9X
         vnahNcmYXnGBcxc//iMNE/1FJFOHJXoqSf5NbSNo+WCKZkHAa3BJ2RoXGA506bjsmb
         fJ45dmwh6rkirFQvqf/C94OsuxRFNQZFhDylcItyYD/li7e8PupwxIPAsGEgduTPmw
         oq+DcpeT7udHQ==
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-3922d2460afso81876b6e.3
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jun 2023 13:29:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686256146; x=1688848146;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qREPRnbFoZDSkGcbr3ixpo6NMxfZ+kQ8GXlQeYCh42M=;
        b=YFjoFBeA54jwiG4VhsER6XyJ9RPPI3GsM8oh+tRa4MgnDFO/IOuwfECZHEoFxYVhu0
         MgSLifIqZ2GBeBBqJmbIlysRNevDdkNqcKw1zovp4GyyFx40K2sMwhVQGnmsYHwN5its
         +GLpKGg5cG6LTSXwcCof76PNAzqGjRgW+r/JdOK+7WOkebpjxXWDAhXK32rncDaqOImN
         g8dbaOG2p0SP2EhjvcTMO7PhykTP9lYZuxvqVyNaZfNXlnQUfsWksw+lkhQumiLVgRk0
         H8h4v8Cc1IBBF8kYq7sLP6x85Txoa9pUfZMnv0u5oVqfS+t73qveHJVM6Nxlj/+Jan5y
         DAKw==
X-Gm-Message-State: AC+VfDzUnaXraG3ctw+3U9q8/OxhuTKhUvWD29uBbu8Sdp/uZoniLs6n
        lnH2kHe73epifyWbBHhmCggfSVL4co6rSsfAG6vDy0cXPqQSyeUObIXALNYX3EbS9LmI4EfXRAx
        NEeS8cK3vd4EJP0ZYpzfavDQkW5hAx7QlMWTeTKukK7JkAD95mEYjlxEyLw==
X-Received: by 2002:a05:6808:1382:b0:39c:9433:97ad with SMTP id c2-20020a056808138200b0039c943397admr595879oiw.36.1686256146046;
        Thu, 08 Jun 2023 13:29:06 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ72K6gWbgyk1dbG1psn5iv219LzIs2MMeLeVtQcb1DQ4+7XfA+UeHix9z/VOcUqfx86K9lSQiK1HTQioy3qmrc=
X-Received: by 2002:a05:6808:1382:b0:39c:9433:97ad with SMTP id
 c2-20020a056808138200b0039c943397admr595861oiw.36.1686256145821; Thu, 08 Jun
 2023 13:29:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230522132439.634031-1-aleksandr.mikhalitsyn@canonical.com>
 <20230522132439.634031-2-aleksandr.mikhalitsyn@canonical.com>
 <20230522133409.5c6e839a@kernel.org> <20230523-flechten-ortsschild-e5724ecc4ed0@brauner>
 <CAMw=ZnS8GBTDV0rw+Dh6hPv3uLXJVwapRFQHLMYEYGZHNoLNOw@mail.gmail.com>
 <20230523140844.5895d645@kernel.org> <CAEivzxeS2J5i0RJDvFHq-U_RAU5bbKVF5ZbphYDGoPcMZTsE3Q@mail.gmail.com>
 <CAMw=ZnRmNaoRb2uceatrV8EAufJSKZzD2AsfT5PJE8NBBOrHCg@mail.gmail.com>
 <20230524081933.44dc8bea@kernel.org> <CAEivzxcTEghPqk=9hQMReSGzE=ruWnJyiuPhW5rGd7eUOEg12A@mail.gmail.com>
 <20230604110211.3f6401c6@kernel.org> <CAEivzxeVeuFW+ADJFO-kCBtyn345nTX=T3aKTdwWY01JgsLPQg@mail.gmail.com>
In-Reply-To: <CAEivzxeVeuFW+ADJFO-kCBtyn345nTX=T3aKTdwWY01JgsLPQg@mail.gmail.com>
From:   Aleksandr Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Date:   Thu, 8 Jun 2023 22:28:54 +0200
Message-ID: <CAEivzxfpih_5ES-pC=jdH4D8H2KN4qJqngC35Ce9KNUnjT2ddg@mail.gmail.com>
Subject: Re: [PATCH net-next v6 1/3] scm: add SO_PASSPIDFD and SCM_PIDFD
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Luca Boccassi <bluca@debian.org>,
        Christian Brauner <brauner@kernel.org>, davem@davemloft.net,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Leon Romanovsky <leon@kernel.org>,
        David Ahern <dsahern@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Kees Cook <keescook@chromium.org>,
        Kuniyuki Iwashima <kuniyu@amazon.com>,
        Lennart Poettering <mzxreary@0pointer.de>,
        linux-arch@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 4, 2023 at 8:07=E2=80=AFPM Aleksandr Mikhalitsyn
<aleksandr.mikhalitsyn@canonical.com> wrote:
>
> On Sun, Jun 4, 2023 at 8:02=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> w=
rote:
> >
> > On Wed, 24 May 2023 17:45:25 +0200 Aleksandr Mikhalitsyn wrote:
> > > > How about you put the UNIX -> bool patch at the end of the series,
> > > > (making it a 4 patch series) and if there's a discussion about it
> > > > I'll just skip it and apply the first 3 patches?
> > >
> > > Sure, I will do that!
> >
> > Hi Aleksandr! Did you disappear? Have I missed v7?
>
> Dear Jakub,
>
> of course I'm not, I've just got distracted with other things last
> week. Will send -v7 this week!
> Thanks for paying attention to the series ;-)
>
> Kind regards,
> Alex

Dear Jakub,

I've sent -v7:
https://lore.kernel.org/all/20230608202628.837772-1-aleksandr.mikhalitsyn@c=
anonical.com/

Kind regards,
Alex
