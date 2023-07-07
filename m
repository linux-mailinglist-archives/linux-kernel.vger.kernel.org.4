Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0E7874B6A4
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 20:52:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232735AbjGGSv5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 14:51:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbjGGSvz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 14:51:55 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C773AC
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 11:51:52 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id 6a1803df08f44-6237faa8677so13336996d6.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jul 2023 11:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688755911; x=1691347911;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=romzeBS8AQcCaxGDGtiWDiCeBo0WM3euDdBNpNt7b5Q=;
        b=b1wr5zvnfC8JlKkOGM1E6IsMn/ZL9sv/8Bnhk/WWaZwvdKI3X/NywgJ7mGSps1Lb0G
         TXuxReVGcFiz2FRbfu8xqRI7IitgTQWVbonsW9LMFOzGRhP8wxx8SELd8N7syHN1FO+J
         0If/IthQhLEiYzQID602E0m9WLWKHKyxlBye+kEpVm40MDoUw94YFruea/O0BymINAT8
         RvsG7zw5e6HTXPceSgmtoVUl9Pv5Z9vaoGLU9RdX1waaEcvE5iOXL1YGBxQ3TnCG8xm6
         9y39XXogDLgF/n+nkrxa5EyGJjVHtxZ3araerKEwMd6WpUfOCPxRcKez51bt6dH8dUow
         ranw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688755911; x=1691347911;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=romzeBS8AQcCaxGDGtiWDiCeBo0WM3euDdBNpNt7b5Q=;
        b=MGIwaW8Yk6/D7rdiSXGMjdJwCFBBQc3IvDNv807FP1pYzXnWtKo28xJwGk6iZem9CD
         fKr5ERv5xA8MWja6KWz0Dxme+32Qqn9nggOYcUltTaSTroe9GP7GQgrl1FFrXc98vGe4
         GlzDA/iGxeMSU/PKtOuQHzboijYCmC+tK+KVJyftwAYbDgoLZVa7hfip06qXyQwiwCvS
         zaWdRiivS3A5DH6Vw0JsfTijuTdptdFPaS5ucNm+ZdHvSh7KjOMsxoEp44ClOA3hkBRe
         sLs/u7SssOz/jU6yUFsGBWOKoNLqb4L6rBwW7QO47a1Rb0crr9HkF6T7EG3tdVPWvoTi
         6DGA==
X-Gm-Message-State: ABy/qLZO+CR16VUNVbiMzloa794NNSeE7dMq8Z5j/wj5EBMktDj9Xuoo
        XfhZ6S4I0aeQ3+NS9iWUt8dRoDdEkMK86KRXH6racPOAcDTUiq3liu4=
X-Google-Smtp-Source: APBJJlH3pS/P5z1lMPBJ+sXNhFl1Y6qV1Nf5a//inoxIr4u/SQjlCwnOd7CA7BLROPbQfy8wc0EITt/xGiJYKyPu+04=
X-Received: by 2002:a0c:aac9:0:b0:635:ed4c:50e with SMTP id
 g9-20020a0caac9000000b00635ed4c050emr4721057qvb.15.1688755911262; Fri, 07 Jul
 2023 11:51:51 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wiJHMje8cpiTajqrLrM23wZK0SWetuK1Bd67c0OGM_BzQ@mail.gmail.com>
 <20230704211509.GA21834@1wt.eu> <CAHk-=wjH4O6v_EwVB=t_6Haky2jOiejHbCkCTvgNQWo1ghy8-w@mail.gmail.com>
 <20230704213415.GA21872@1wt.eu> <CAHk-=wjPEjrB7eCukREhWu-0qfjbFD-K8sk1TYYRgeHzYr1tuQ@mail.gmail.com>
 <20230704215600.GA22271@1wt.eu> <CAHk-=whMytacPBHfKKi8GYdgfadNy5LA-1TDHrTtz22eJr2B1Q@mail.gmail.com>
 <20230704222758.GB22271@1wt.eu> <20230705004129.GI1178919@mit.edu>
In-Reply-To: <20230705004129.GI1178919@mit.edu>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 7 Jul 2023 11:51:40 -0700
Message-ID: <CAKwvOd=ktNGZ=uBVxF7Wicooy7VMz1UNe5MRDkEDZPcg1_DJ2A@mail.gmail.com>
Subject: Re: Overly aggressive .gitignore file?
To:     "Theodore Ts'o" <tytso@mit.edu>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Willy Tarreau <w@1wt.eu>, Masahiro Yamada <masahiroy@kernel.org>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 4, 2023 at 5:42=E2=80=AFPM Theodore Ts'o <tytso@mit.edu> wrote:
>
> For whatever it's worth, I always run "b4 am -o /tmp/m ...", so all of
> the .mbox files end up in /tmp/m.  Similarly, I'll always run "git ty

FWIW

$ b4 shazam <lore link>

is what I use to fetch and apply patches. Doesn't seem to leave behind
any mbox files.

I don't really understand why *.patch is ok to have in .gitignore but
*.mbox is not?  Wouldn't autocomplete fail due to `git status` for the
exact same reason?

I don't care one way or the other, but why the inconsistency?  Let's
pick one and stick with it?
--=20
Thanks,
~Nick Desaulniers
