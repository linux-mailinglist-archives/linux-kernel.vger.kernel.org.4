Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FCF7741686
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 18:33:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbjF1QdF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 12:33:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232114AbjF1Qcb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 12:32:31 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5000419AF
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 09:32:23 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-6687096c6ddso3375785b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 09:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1687969943; x=1690561943;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qDGMYCjLis4jKxTwr/XdUXoNY3JVle8y3T0ovRza2gI=;
        b=So0cQmmYjKO65vw+/JsinQBhmojmi5xblarthQ+XwK6zfOrl6nidesbKTUolCr2pTj
         v6gEfN3NB9a8q4sxVqNolfWNnRp4XqLAHKowxUgtk9uf3sWNhisK6K8UMc+/sGQs7zl3
         7wNc+mBDuFAzumNdKdKkBJsTHBdBLtEE96zHw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687969943; x=1690561943;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qDGMYCjLis4jKxTwr/XdUXoNY3JVle8y3T0ovRza2gI=;
        b=KBxB4o4yYmoDhaaXjjq9taZLE9KXQTy1qVKPqp1VCT+d2kyWVXXRpAkddUBidq3UYm
         ZWKAsCiGhn3KDVsHbSax3xDvBGi6I0+xNzrw68Q07/8dVsmx4BJ1fAgAfrvw/crKJsvY
         1zBKwBobL8TvFMf+DJJVixKwUpv9BQDwjQtMcGFUJcmKz9RNdmrdqJZvp5p35Rh3oOcx
         BrdScM54twWY+mkwEugOFI0/TRJ9LG8Gb3ItHWGH34/TFaI6nd9Vlqqb0Yi+o27RaNLw
         jG3lSmNLataLaFBz4OZFAuhzPzNurhJHphOtiPtbLChPV3S1XuENehTWANoaz7klKnPC
         M/zQ==
X-Gm-Message-State: AC+VfDwJf96vHUTwGLVvrlSxgqrpBqY+rv5lTooV6q9Ay6ZygglI2wia
        O/VzBfyxABNwgw5ZxEq0nDYyyy/4iXkQfl1D8dQ=
X-Google-Smtp-Source: ACHHUZ4hwJdblgv/IjbPFH+BZPSdbdvvXEegZidz0b10Rp2sJOYq5ixdTjeKDAOTEUFq8KxIhGOHvQ==
X-Received: by 2002:a05:6a00:3994:b0:66a:3812:7eda with SMTP id fi20-20020a056a00399400b0066a38127edamr20180226pfb.9.1687969942751;
        Wed, 28 Jun 2023 09:32:22 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id bm2-20020a056a00320200b00681783cfc85sm1263377pfb.144.2023.06.28.09.32.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 09:32:21 -0700 (PDT)
Date:   Wed, 28 Jun 2023 09:32:20 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Samuel Thibault <samuel.thibault@ens-lyon.org>,
        Kees Cook <kees@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Simon Brand <simon.brand@postadigitale.de>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        Dave@mielke.cc
Subject: Re: [PATCH v3 2/2] tty: Allow TIOCSTI to be disabled
Message-ID: <202306280930.8CBBB9B@keescook>
References: <20221022182828.give.717-kees@kernel.org>
 <20221022182949.2684794-2-keescook@chromium.org>
 <20221227234000.jgosvixx7eahqb3z@begin>
 <C95AF535-7A95-48BA-8921-1932C15A1931@kernel.org>
 <20221228205726.rfevry7ud6gmttg5@begin>
 <20230625155625.s4kvy7m2vw74ow4i@begin>
 <202306271944.E80E1D0@keescook>
 <20230628060716.vvgtlgbushyjh6km@begin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230628060716.vvgtlgbushyjh6km@begin>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 28, 2023 at 08:07:16AM +0200, Samuel Thibault wrote:
> Kees Cook, le mar. 27 juin 2023 19:48:45 -0700, a ecrit:
> > On Sun, Jun 25, 2023 at 05:56:25PM +0200, Samuel Thibault wrote:
> > > > Can we perhaps just introduce a CAP_TIOCSTI that the brltty daemon would
> > > > be able to use? We could even make it only allow TIOCSTI on the linux
> > > > console (tty->ops == con_ops).
> > 
> > Does brltty run with CAP_SYS_ADMIN?
> 
> ATM most often, yes, though we are trying to reduce the CAP_* privileges
> to what it actually needs.
> 
> > > *Please* comment on this so we can progress. ATM people are
> > > advising each other to set dev.tty.legacy_tiocsti=1, which is just
> > > counter-productive in terms of security...
> > 
> > So is there really no solution for brltty and TIOCSTI being disabled?
> 
> No, there is no way to simulate characters on the Linux console. The
> alternative would be to use uinput, but that simulates keycodes, not
> characters, thus requiring backtranslating first, which is very fragile.
> 
> > What is FreeBSD doing? I imagine it's the same situation there too,
> > though maybe there is just no support?
> 
> There is just no support in the kernel, only a patch against "screen".
> 
> > > Really, this a serious regression for the people affected by this.
> > 
> > Can you send a patch adding a CAP_SYS_ADMIN exception?
> 
> Sure!

Thanks! (And be sure to use file->f_cred for the check[1], not "current",
that way brltty can open the tty and drop caps and still do the ioctl.)

-Kees

https://docs.kernel.org/security/credentials.html?highlight=confused+deputy#open-file-credentials

-- 
Kees Cook
