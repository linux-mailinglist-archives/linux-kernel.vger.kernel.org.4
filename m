Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96448675DDF
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 20:21:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230283AbjATTVL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 14:21:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230037AbjATTVI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 14:21:08 -0500
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B20857B2DA
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 11:21:07 -0800 (PST)
Received: by mail-qv1-xf29.google.com with SMTP id h10so4440908qvq.7
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 11:21:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=oKc6aNElBeAjI0A5h4AlsuIRL0OuAo/OC+4hdSyr7ko=;
        b=cNyecBjx4GrRbbQB+eKy3OkwQjZ2Qa0TMinfaoUdN/IRX0MBlZa/RsYnhvR2kAZb6x
         CtXGnDx05z8vkmXXN1skLmANGwZ7jJIKWbLP864IS6hmrqdNLYeQTmVwNqz+d3RGX7Y7
         Y2j2qq4OX70FgEDGJmBIxLHz0/f14J8oiZ154=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oKc6aNElBeAjI0A5h4AlsuIRL0OuAo/OC+4hdSyr7ko=;
        b=gLaydzJRomPvYhjXMPrdDrz/uryt+Wnh2L60OYiVMRl1AwBPa9eFX0c7y8uSL7Q+M7
         a/6GYqUXP8NR5nvvFot2AgO0R8K6RUfskEcTaK+i3h0imTLM0xWoooQKoMG3xmRLwLSC
         r7y3fR4MTwUnt8cWn+6mMLp9XMrhHO/kgJAyoHmGPl7ANm3/pFSCnbti+dh+ip8kbU7Y
         bQpY2ov6IJXMvGdWCn++16fEXA+WVK8nftYbE+So3WaOcFgJwEWoNgCpFOxyvbsQEdal
         iC85UDfh/RC1rIelKALTw0jU0Qhe5/af3udueQKNoaU43lMYTvEMVwOT5pLiZ5Ts0yCA
         NhNg==
X-Gm-Message-State: AFqh2kra1wTjLgui4vBj3GWyHBC8dNUl/S/QJvKp4D+3Rsh2FhS3Hl3U
        8upkKCZAccBU5015NLGTwZPGJqjdPUZcn+N3
X-Google-Smtp-Source: AMrXdXtT5rsGTw/whpwMXolkxz6qb459W6TGkCFSaxd4a7FIRIZKHVtvBVRZyW/2Pna5kBJ53ptXHg==
X-Received: by 2002:a05:6214:2e8c:b0:532:3b1a:283b with SMTP id oc12-20020a0562142e8c00b005323b1a283bmr25427105qvb.1.1674242466390;
        Fri, 20 Jan 2023 11:21:06 -0800 (PST)
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com. [209.85.222.175])
        by smtp.gmail.com with ESMTPSA id w25-20020a05620a0e9900b006fcab4da037sm3414761qkm.39.2023.01.20.11.21.05
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Jan 2023 11:21:06 -0800 (PST)
Received: by mail-qk1-f175.google.com with SMTP id i28so3420638qkl.6
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 11:21:05 -0800 (PST)
X-Received: by 2002:a05:620a:144a:b0:6ff:cbda:a128 with SMTP id
 i10-20020a05620a144a00b006ffcbdaa128mr837664qkl.697.1674242465702; Fri, 20
 Jan 2023 11:21:05 -0800 (PST)
MIME-Version: 1.0
References: <20230119185300.517048-1-kuba@kernel.org> <20230120085114.6c30d514@kernel.org>
 <CAHk-=wgsKaO7qxOso_PrmsBEfpN-Wot=V0fUAy3oKOSFuAQxVw@mail.gmail.com>
In-Reply-To: <CAHk-=wgsKaO7qxOso_PrmsBEfpN-Wot=V0fUAy3oKOSFuAQxVw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 20 Jan 2023 11:20:49 -0800
X-Gmail-Original-Message-ID: <CAHk-=whEAtZ+p0svZ1i1jg3=bh2MWPm_KQo9Mq3AiKwKWaNHxQ@mail.gmail.com>
Message-ID: <CAHk-=whEAtZ+p0svZ1i1jg3=bh2MWPm_KQo9Mq3AiKwKWaNHxQ@mail.gmail.com>
Subject: Re: [PULL] Networking for v6.2-rc5
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 20, 2023 at 9:30 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> So I undid my pull and will do your v2,

Side note: that late merge, and its revert is pretty ugly.

It seems to be a pattern that the networking tree has, which is not a
great sign (merging much too eargerly into the wrong branches).

Doing a

   git log --grep='Revert "Merge '

does seem to show that this is a networking pattern. Nasty.

But I hope it also means that you know how to deal with the fallout.

In particular, reverting a merge means that re-doing that merge later
will just be a no-op: the original commits are already merged. You'll
need to revert the revert to get the changes back (or you just need to
re-do the whole thing).

            Linus
