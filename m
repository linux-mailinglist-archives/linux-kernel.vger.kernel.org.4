Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F3AF64BB4C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 18:45:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236331AbiLMRo6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 12:44:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236378AbiLMRon (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 12:44:43 -0500
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06B5E2339E
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 09:44:39 -0800 (PST)
Received: by mail-qv1-xf29.google.com with SMTP id a17so10892616qvt.9
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 09:44:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wOv+J0r/3B6i4POUYOzSGaAf/iSJPPOP/x/UlxsbTvQ=;
        b=WZ1mKRQBVKmDwustjDGt5j+lf+imbCmjpXPsg1BBATOLjJOwG70Wy78s8BR04q3Gdq
         6x0b8plbylv5t6lB95U7p/M74lW+sMEBPSmdvx4l+L+ANQFN/U8Uyh0ytjcXcuSBjnPC
         jFj5+j3oUZw+Z1DQEPds2syc7iY/qe6YjRUlk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wOv+J0r/3B6i4POUYOzSGaAf/iSJPPOP/x/UlxsbTvQ=;
        b=ZxU8eH5TyM/iXtJT/KeHijCk/b5xsaEh4MecSya6+ZIyA+KhldUibdeN1nihGQagyC
         gAd54YrLgl3uZ4zXpTRpdrcBqL7f+Mt/XUHljbhVQ0eQz9jw3GFFzU7S7oDnrgTpD2iG
         sTLi8h9p8IGLHh0tNPO2j6O+YltbAPLvjctPTEnNUcbl4eJJ6L2cPIMaVWlXANWE+UL4
         LTus4PKNPOHzBoD8s7wBlfi8rTGYtfVM0ksCSSVELEboaUHc06l0y3O6qNFbYS6G7LrX
         QoRHtsPhhF4Jdq5AChIauMdN3ePFcGou1BswlWNIYck04QA98Q4r/EtEsbZ9VyRThQbZ
         9FFA==
X-Gm-Message-State: ANoB5pne6hJYLBuuNG+ySBafEPlVzA/jY+nyp5CmbTz9m4ZpdzwmcwMf
        OOT9OsGL8Um47/bCeyw2TzuwYptb2RRXzuyC
X-Google-Smtp-Source: AA0mqf4arBfu3/bYb6wu2qic3w8H73AjrL5sQtGfzoL+h/i/SDqWnvI5zfb3/pjD4/90Bzzz9aO/AA==
X-Received: by 2002:ad4:404c:0:b0:4c7:884:7739 with SMTP id r12-20020ad4404c000000b004c708847739mr26462487qvp.52.1670953477546;
        Tue, 13 Dec 2022 09:44:37 -0800 (PST)
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com. [209.85.222.177])
        by smtp.gmail.com with ESMTPSA id u15-20020a05620a454f00b006fa22f0494bsm8374579qkp.117.2022.12.13.09.44.36
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Dec 2022 09:44:36 -0800 (PST)
Received: by mail-qk1-f177.google.com with SMTP id pa22so215276qkn.9
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 09:44:36 -0800 (PST)
X-Received: by 2002:ae9:ef48:0:b0:6fe:d4a6:dcef with SMTP id
 d69-20020ae9ef48000000b006fed4a6dcefmr10744372qkg.594.1670953476176; Tue, 13
 Dec 2022 09:44:36 -0800 (PST)
MIME-Version: 1.0
References: <CAHC9VhSmJHDRroUJifUuDNF+KvVPVtW17CuMzb_RrUKBBkTabA@mail.gmail.com>
In-Reply-To: <CAHC9VhSmJHDRroUJifUuDNF+KvVPVtW17CuMzb_RrUKBBkTabA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 13 Dec 2022 09:44:20 -0800
X-Gmail-Original-Message-ID: <CAHk-=whH53GKhcT0+cKGwCVOHXD0_Gh82w2SVojjgoN7XZ-71g@mail.gmail.com>
Message-ID: <CAHk-=whH53GKhcT0+cKGwCVOHXD0_Gh82w2SVojjgoN7XZ-71g@mail.gmail.com>
Subject: Re: [GIT PULL] SELinux patches for v6.2
To:     Paul Moore <paul@paul-moore.com>
Cc:     selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

On Mon, Dec 12, 2022 at 7:05 PM Paul Moore <paul@paul-moore.com> wrote:
>
>   Unfortunately, this pull request does
> conflict with fixes that were merged during the v6.1-rcX cycle so you
> will either need to do some manual fixup or you can pull the tag below
> which has the necessary fixes and has been sanity tested today.

I did the merge manually, but compared to your version. They were
identical except that you hadn't added the documentation entry for the
gfp_flags parameter.

That said, I'm not super-happy with that merge - it was the trivial
straightforward one, but when I looked at the code it struck me that
the only thing that actually seems to *use* that gfp_flags argument is
that

        if (oldc->str) {
                s = kstrdup(oldc->str, gfp_flags);
                if (!s)
                        return -ENOMEM;

sequence. And it strikes me that this is not the only place where
selinux ends up doing that whole

                str = kstrdup(ctx->str, GFP_xyz);

dance.

It feels to me like that thing shouldn't be an allocation at all, but
that selinux should use ref-counted strings instead (and just increase
the refcount). It's in other places like context_cpy(), but having it
be a refcounted string would also potentially help with
"context_cmp()" in that the string compare could be a "is it the same
ref-counted pointer" and maybe hit that case most of the time before
it even needs to do an actual strcmp.

Hmm?

Anyway, that was just my reaction to resolving that conflict, and
obviously *not* for this merge window. I'm just saying that if you
agree, maybe that could be a future improvement, making the whole
allocation - and the whole need for that gfp_flag - go away?

               Linus
