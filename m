Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8D06721922
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Jun 2023 20:07:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232115AbjFDSH2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jun 2023 14:07:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229886AbjFDSH0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jun 2023 14:07:26 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBCE3B0
        for <linux-kernel@vger.kernel.org>; Sun,  4 Jun 2023 11:07:25 -0700 (PDT)
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com [209.85.128.198])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 53D643F556
        for <linux-kernel@vger.kernel.org>; Sun,  4 Jun 2023 18:07:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1685902042;
        bh=eXPLCKZ8Jj450duZJrO5FmwhWWg+s1j3KuC7Lhd1iI4=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=UT+GSj6ZbTUtj0SZd4TFaqO7MhJn4MztOSWUZXe2Qsu7VkQJHhD+JGb2c3I73+yUE
         9ZHrCaREQv4acw+vhpIWfXMagxGjsqEhVryW2YzC+n5gqHJ2UqwcGdpg9FWFRokwpV
         8HxJ3daXWjWBIdhwNSsDf0+nT2ZfK5/kmAgo9VRr5BiQPdslscoLxEyWZ/XSn/z5B4
         r0MZPXBUewPVcBHXs+mcVw8V4zes4gTQcJN0UzetByCswdsB+XxeXVe3en7Acjak31
         NJMplBoYvL5yKYLpYd4bvy2TaPFu8cK+BZ3tSsJfapcKPRz06pbP6xlyDYgk/WCtM9
         J6UD8FdVAPZ5w==
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-568960f4596so69772017b3.1
        for <linux-kernel@vger.kernel.org>; Sun, 04 Jun 2023 11:07:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685902041; x=1688494041;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eXPLCKZ8Jj450duZJrO5FmwhWWg+s1j3KuC7Lhd1iI4=;
        b=bTjqSaVp7cBNN4FFzBtHKJDjb4kfBQFfmkAdTu7ysyFfJWElUTECOgynStqYPFy4CC
         jvznEbBlThdURZhLUQUTb1T/ekCO70rg4D9do2bvudHCcMe/QFjrft/5Qd9yae2Eu20C
         cShOwjNfbMgizERiq4Uv9vjhsYNnrAKb25pIiq2GqDDGD+o41PUIxavc9hrBsaUtL9Mb
         6jDhSSunUfzQq+8HXnOv8TVdLEc0tu5uMFtRebUf5+t3q6xBfySpG8QS00hfr2jBS3Tg
         i/0bXVHQDSaTeBWrCSaGiPVQPIK4iKFwxdb1C1G1sQ8Byoy4I40Y8DNktKwbRpEURZpC
         p+iw==
X-Gm-Message-State: AC+VfDx0y6xfTRuD+QVc1JVMVMtOYlAYBnPKk3WsgQOxsqJm0HDl6DxQ
        x4pFCdRvddwaJfzZgIv0ygq7HZujpSzY1JuP+4j7N2R6XPljUMXwzK+u84CkeY/vd2d0qyW8SPf
        SmHLyMAitJqfcUyHnQL4b2z4+TCvGF1w9mLPnDehXFHacc+6Tn7I6/LqtMQ==
X-Received: by 2002:a25:210b:0:b0:b9d:7887:4423 with SMTP id h11-20020a25210b000000b00b9d78874423mr6768247ybh.16.1685902040983;
        Sun, 04 Jun 2023 11:07:20 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ41k0JQ0Rgb4oamIPtOl2YDqXm2k+gWqhdlPbfMaObYYGP+EpFNoMd2Xr14SJFNxI1Y9SMEiabdS0cOpOTA3WE=
X-Received: by 2002:a25:210b:0:b0:b9d:7887:4423 with SMTP id
 h11-20020a25210b000000b00b9d78874423mr6768237ybh.16.1685902040769; Sun, 04
 Jun 2023 11:07:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230522132439.634031-1-aleksandr.mikhalitsyn@canonical.com>
 <20230522132439.634031-2-aleksandr.mikhalitsyn@canonical.com>
 <20230522133409.5c6e839a@kernel.org> <20230523-flechten-ortsschild-e5724ecc4ed0@brauner>
 <CAMw=ZnS8GBTDV0rw+Dh6hPv3uLXJVwapRFQHLMYEYGZHNoLNOw@mail.gmail.com>
 <20230523140844.5895d645@kernel.org> <CAEivzxeS2J5i0RJDvFHq-U_RAU5bbKVF5ZbphYDGoPcMZTsE3Q@mail.gmail.com>
 <CAMw=ZnRmNaoRb2uceatrV8EAufJSKZzD2AsfT5PJE8NBBOrHCg@mail.gmail.com>
 <20230524081933.44dc8bea@kernel.org> <CAEivzxcTEghPqk=9hQMReSGzE=ruWnJyiuPhW5rGd7eUOEg12A@mail.gmail.com>
 <20230604110211.3f6401c6@kernel.org>
In-Reply-To: <20230604110211.3f6401c6@kernel.org>
From:   Aleksandr Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Date:   Sun, 4 Jun 2023 20:07:09 +0200
Message-ID: <CAEivzxeVeuFW+ADJFO-kCBtyn345nTX=T3aKTdwWY01JgsLPQg@mail.gmail.com>
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 4, 2023 at 8:02=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Wed, 24 May 2023 17:45:25 +0200 Aleksandr Mikhalitsyn wrote:
> > > How about you put the UNIX -> bool patch at the end of the series,
> > > (making it a 4 patch series) and if there's a discussion about it
> > > I'll just skip it and apply the first 3 patches?
> >
> > Sure, I will do that!
>
> Hi Aleksandr! Did you disappear? Have I missed v7?

Dear Jakub,

of course I'm not, I've just got distracted with other things last
week. Will send -v7 this week!
Thanks for paying attention to the series ;-)

Kind regards,
Alex
