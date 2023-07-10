Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D82A74C9E8
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 04:36:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230269AbjGJCgB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jul 2023 22:36:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjGJCf7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jul 2023 22:35:59 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54D72E0;
        Sun,  9 Jul 2023 19:35:58 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-57023c9be80so48020257b3.3;
        Sun, 09 Jul 2023 19:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688956557; x=1691548557;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6mF3L96LoTnWx2MEvXwnNhJXYkCF7/EN50oM+cK6gkY=;
        b=WRw0UaQiekWxZPXDwkitHOIuxH2s6UHIsbZEgRkEdA6rCSYl96U7eWiGWscQ6qsUTC
         gJV2rzrpDX6nxHsonY90dPDsKVFY+CGn81JqgnP1xB2JvjH98+rQhh/3KhaeMD4UnUc/
         6XsxiSp+iq410adY0PfarKUskq7/45cLJ2Ffz9OG1f0QyMsMOJlndzVlkXdBlGQyEGA8
         bCRwlJKBCClIni+Npc60hI+yK4L9n3KePYeOXwOogMKevsQpC5o83OTL59p5vU8Cg6Rc
         EbBAxkKQ/VshaA8wHUl9D0GGLqRZ4Yg6bUjtLiBUcD/kGytJmiN8v6FF1lCV4ru4vqH1
         JlxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688956557; x=1691548557;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6mF3L96LoTnWx2MEvXwnNhJXYkCF7/EN50oM+cK6gkY=;
        b=CzEFOMd6UQ0O3CFYorS/4VmiMWq3zVsdPg3c1BpXHOBj5mpe7KyYGWAssQRpqYVZM0
         rM5eK1yRfMy5+cURLFtYDp5T4M5+wkGi/XPtlQacAc8KzsHEHKtSxOgNKvB/Xp/oV11O
         I08EhizniDN/IkEpbLwzFn5BrQ6aUU3XTPcTnHgAZkLLNpmhh1xhV1pzvY/vmrGDlhcq
         JKcSCQ/LpFqPkjvKS6BPanpbJgMBz3If6Wpy1/0qVGGHxdpUB1Scr+9TN4xmAk2tOpcS
         IpTMIUL9BrVeNOmYlUCFYazbsM2UkZjHJrcMEfvepzG8yt8/WYbpvAm+LW7Ur+wR9pET
         ExWw==
X-Gm-Message-State: ABy/qLZ4XcJPjWvfRz7/uQw0op3+N2ZYZJ9hkYTtviQLgIMGjuZ1apTS
        nvTrMS/cvqPYhHsVDac59YGM19bH3rvLyQoD8ncseDUaDvg=
X-Google-Smtp-Source: APBJJlEePzrOeSKu/dCCO6swAe8NIexDP/nO5MptZzFfpfK5UueWI0VFmUhtLkKez2jxesbv31XOrlbcqTt17g/+qZk=
X-Received: by 2002:a81:a001:0:b0:577:f47:3d92 with SMTP id
 x1-20020a81a001000000b005770f473d92mr10556370ywg.23.1688956557447; Sun, 09
 Jul 2023 19:35:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230523021425.2406309-1-azeemshaikh38@gmail.com> <202305231020.37C95FD@keescook>
In-Reply-To: <202305231020.37C95FD@keescook>
From:   Azeem Shaikh <azeemshaikh38@gmail.com>
Date:   Sun, 9 Jul 2023 22:35:46 -0400
Message-ID: <CADmuW3UAHODqC5YAmjK1sOuo3C56noOa6hsHA+2Es2R9MT36_g@mail.gmail.com>
Subject: Re: [PATCH] soc: fsl: qe: Replace all non-returning strlcpy with strscpy
To:     Kees Cook <keescook@chromium.org>
Cc:     Qiang Zhao <qiang.zhao@nxp.com>, linux-hardening@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Li Yang <leoyang.li@nxp.com>,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 23, 2023 at 1:20=E2=80=AFPM Kees Cook <keescook@chromium.org> w=
rote:
>
> On Tue, May 23, 2023 at 02:14:25AM +0000, Azeem Shaikh wrote:
> > strlcpy() reads the entire source buffer first.
> > This read may exceed the destination size limit.
> > This is both inefficient and can lead to linear read
> > overflows if a source string is not NUL-terminated [1].
> > In an effort to remove strlcpy() completely [2], replace
> > strlcpy() here with strscpy().
> > No return values were used, so direct replacement is safe.
> >
> > [1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strl=
cpy
> > [2] https://github.com/KSPP/linux/issues/89
> >
> > Signed-off-by: Azeem Shaikh <azeemshaikh38@gmail.com>
>
> Reviewed-by: Kees Cook <keescook@chromium.org>
>

Friendly ping on this.
