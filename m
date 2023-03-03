Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75C706A9E23
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 19:05:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231447AbjCCSF4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 13:05:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230512AbjCCSFy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 13:05:54 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FDF65CC29
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 10:05:53 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id cy23so13527437edb.12
        for <linux-kernel@vger.kernel.org>; Fri, 03 Mar 2023 10:05:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1677866751;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xj/aW7rv2hnxMKwTINLCdxn8Xpp5R3jKA3qZ2i6tZD4=;
        b=XHgVAIvE4meRLWen/etowUrZu8sS+DUubGFdL4qz/BkZ7AfvIzfDiQooj4TYdTGGBa
         QhacT/cEMq9umv8jT8lotS2p/U89+GCy8MSsH6a03GqHtfkflpwc9aiFZH39qliMAYwW
         V49AJgiA3oevvtBF4j6HxQliGIMdJzdpyKzdk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677866751;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xj/aW7rv2hnxMKwTINLCdxn8Xpp5R3jKA3qZ2i6tZD4=;
        b=zHan+QMkoA4lIfrSNywe99GVHnWCZqG4JL+LCloHxxwPLtm8xmd5KIGuE+3T/l0lrr
         xekdcSHX5KKetED79b+d9WaVmOUReHSqb1d1lthHov1k6LH1LinhgWkAkParcUB5Ri1g
         yqRfvKThWTvDDxlMtVjclayovfwlqDkfN2vWqRbwUwDn9JifUAuQBeoFGFBnwa7kBH9Z
         QT8HjzmDkqdO7L+VuDLEf4ijGR1Ds2UbA5mDdj9Rm5lfH2UF9Bt4sNc+9+zHMZXadb50
         fqdH/78IQsc8054Wvr7cAhKbJ39RmDTUOTjXSB41sHFhCE00k+Uyjs6rMeQyYQsFuVZL
         /uOQ==
X-Gm-Message-State: AO0yUKWX5J4w1UlTotVX507T+Zhjsh8pYi8i4jf4WCVZ6OOc3fXCx6fS
        okNiLPkQ63Vgq4dk5214JAmCX5xPxuVGJW3dADjRfg==
X-Google-Smtp-Source: AK7set+RAsozA8MOJcZlvdB1z+lBgcYfiomd7h0EQl+l67vw6UG82cx4GcjGC5dmu+kv3uG0eAMnrg==
X-Received: by 2002:a17:907:94c5:b0:8b1:3821:1406 with SMTP id dn5-20020a17090794c500b008b138211406mr3412071ejc.45.1677866751218;
        Fri, 03 Mar 2023 10:05:51 -0800 (PST)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com. [209.85.208.53])
        by smtp.gmail.com with ESMTPSA id dx11-20020a170906a84b00b008e493b7bb61sm1182653ejb.153.2023.03.03.10.05.50
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Mar 2023 10:05:50 -0800 (PST)
Received: by mail-ed1-f53.google.com with SMTP id i34so13650906eda.7
        for <linux-kernel@vger.kernel.org>; Fri, 03 Mar 2023 10:05:50 -0800 (PST)
X-Received: by 2002:a17:906:498e:b0:901:e556:6e23 with SMTP id
 p14-20020a170906498e00b00901e5566e23mr1304879eju.0.1677866750385; Fri, 03 Mar
 2023 10:05:50 -0800 (PST)
MIME-Version: 1.0
References: <C8C4DFDA-998F-48AD-93C9-DE16F8080A02@meta.com>
 <CAHk-=wghhViNZCj4ibSr42HjVGdHro_DWW7wCOQ61p2v59cciw@mail.gmail.com>
 <4BA6A759-F69C-406E-9D29-EDCC9B48F798@meta.com> <CAHk-=wjCNtTJ3DrG1266xXPZF=qH=GvpWApkYStJ9knskRnU3w@mail.gmail.com>
In-Reply-To: <CAHk-=wjCNtTJ3DrG1266xXPZF=qH=GvpWApkYStJ9knskRnU3w@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 3 Mar 2023 10:05:33 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjb2refiXJeVPUCcfLo=G+sozZOHsdQn4jAq17YBKP7eg@mail.gmail.com>
Message-ID: <CAHk-=wjb2refiXJeVPUCcfLo=G+sozZOHsdQn4jAq17YBKP7eg@mail.gmail.com>
Subject: Re: [GIT PULL] zstd changes for v6.3-rc1
To:     Nick Terrell <terrelln@meta.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nick Terrell <nickrterrell@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 3, 2023 at 9:59=E2=80=AFAM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> You should not rebase your public trees.
>
> But you should not merge mainline either.

So lwn has several articles about this, the one I found quickly with google=
 was

    https://lwn.net/Articles/791284/

and it's worth noting that the rule is "don't rebase" and "don't merge
from upstream", but as always, those are rules that then have to be
balanced against other rules and concerns.

Sometimes rebasing _is_ the right thing to do. Sometimes the public
history simply ended up being so full of garbage that the only right
thing to do is to just admit that and start again.

And sometimes merging from upstream _is_ the right thing to do. Maybe
there is something really important that made it upstream that is very
relevant.

But both situations need to be things that you really think about, and
have a reason for. And when you do a merge, that reason should very
much go into the merge message.

For rebases, there's no "rebase message", so those you basically have
to explain at pull time ("this was rebased last week to fix bad
problem XYZ").

              Linus
