Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEEE36D9E21
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 19:05:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239890AbjDFRFI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 13:05:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229977AbjDFRFF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 13:05:05 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A41183F2
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 10:05:04 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id cw23so3007331ejb.12
        for <linux-kernel@vger.kernel.org>; Thu, 06 Apr 2023 10:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1680800702; x=1683392702;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y+/M2omUP0H0I3+C442gwyIY7zx7Kzi7zGFIhChXSsk=;
        b=gVWm1nNuJp1udR2vQuOftYAPHlHihAmSyy5tDUSzL3m8ReBfsdDPXUCd45jJgjVQlI
         Y/FZi8zAZbgg+L+PemAiITXN3MOg1Lr8TrN5hNUC6GNHE8f1b0fdKGhdhlBjYvCp7be+
         yx6G2cBLtUZv8F1CEpcFNvSwIzxgYgW4hDw6o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680800702; x=1683392702;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y+/M2omUP0H0I3+C442gwyIY7zx7Kzi7zGFIhChXSsk=;
        b=TnoHlFyXELiYbI5yZj9VT8Mt65ozKjSwxn7AU2H4h+qnx9G1mp4RC98xJ0i0TTP1vO
         QAjIHC+NwaIaJ+k04R81at1ez/NvhTW1vS40R6srlJXcBUEtYz0Qb2Y5A4EFnsk9wHW8
         fz/ZYefkYXNHGO0nvAn/xKE5BxfzchbjX/7IJ9u9dSSNSxuMNVSAYukg14O9NPlZkqjO
         A3wE7s5w1NlHqiRcpfMHVATSjY1KF20r3UiMT9kdqccQlT5ckokPXCBoNE0lCpOY8q0s
         AA+pa+59I3tfx1l6AZlZralVifDVJJWPSXGbcwFh4B6hUDpHMq3owP+JV2GmwT1acG/q
         WlIg==
X-Gm-Message-State: AAQBX9fbepZZ9BrDU3leJrdywsh5HfaPJ8vrjwbgaqkAeOfy/aLqgQFz
        e86zFXL1c9Zlb9Pne7CrgTxacYuCI4NDFDUKjII7AQ==
X-Google-Smtp-Source: AKy350Yhsm0LAN2tvlm7djfj90nfySQh6uPJERe32xmRnRj6cFDrj8NgPGcNjYQeFSDLowQXNAWkMA==
X-Received: by 2002:a17:906:c44d:b0:92f:bef6:7843 with SMTP id ck13-20020a170906c44d00b0092fbef67843mr7587652ejb.22.1680800702482;
        Thu, 06 Apr 2023 10:05:02 -0700 (PDT)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com. [209.85.218.51])
        by smtp.gmail.com with ESMTPSA id v9-20020a170906488900b0093de5b42856sm1035909ejq.119.2023.04.06.10.05.01
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Apr 2023 10:05:01 -0700 (PDT)
Received: by mail-ej1-f51.google.com with SMTP id g18so3001432ejx.7
        for <linux-kernel@vger.kernel.org>; Thu, 06 Apr 2023 10:05:01 -0700 (PDT)
X-Received: by 2002:a17:906:3393:b0:933:7658:8b44 with SMTP id
 v19-20020a170906339300b0093376588b44mr3515396eja.15.1680800701412; Thu, 06
 Apr 2023 10:05:01 -0700 (PDT)
MIME-Version: 1.0
References: <f44680f5-df08-4034-9ed7-6d43ee4c4c2a@app.fastmail.com>
In-Reply-To: <f44680f5-df08-4034-9ed7-6d43ee4c4c2a@app.fastmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 6 Apr 2023 10:04:44 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgyY_FKpWk1LAHirjmWbABc78C+mgVhqaYHZts0fbkYJQ@mail.gmail.com>
Message-ID: <CAHk-=wgyY_FKpWk1LAHirjmWbABc78C+mgVhqaYHZts0fbkYJQ@mail.gmail.com>
Subject: Re: [GIT PULL] asm-generic fixes for 6.3
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Linux-Arch <linux-arch@vger.kernel.org>,
        linux-kernel@vger.kernel.org,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        Matt Evans <mev@rivosinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 6, 2023 at 1:13=E2=80=AFAM Arnd Bergmann <arnd@arndb.de> wrote:
>
> Some of the less common I/O accessors are missing __force casts and
> cause sparse warnings for their implied byteswap, and a recent change
> to __generic_cmpxchg_local() causes a warning about constant integer
> truncation.

Ugh. I'm not super-happy about those casts, and maybe sparse should be
less chatty about these things. It shouldn't be impossible to have
sparse not warn about losing bits in casts in code that is statically
dead.

But we seem to have lost our sparse maintainer, so I've pulled this.

I also wish we had a size-specific version of "_Generic()" instead of
having to play games with "switch (sizeof(..))" like we traditionally
do.

But things like xchg() and user accesses really just care about the
size of the object, and there is no size-specific "_Generic()" thing,
and I can't think of any cute trick either.

               Linus
