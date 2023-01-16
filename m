Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F0B366BBC3
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 11:32:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230134AbjAPKb7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 05:31:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbjAPKb4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 05:31:56 -0500
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 214FC72AD
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 02:31:55 -0800 (PST)
Received: by mail-yb1-xb2f.google.com with SMTP id o75so29767238yba.2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 02:31:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VUQbpg5HItyWZZQATZnM4RSqQnbK+YIpF8+VzAqkd5I=;
        b=IstoYocSG5xOkpunE8iwoJn5VW1Lf6txDYxlwbE9gLBA4UUbZcr2TsYfEIb7+6bVpa
         p31BAHAWnZz/ffgjLfOi2kZ4218d3P0P5yNcCSIE21W4PgPo5RAyXQLO2zSXfX9lBEVJ
         qiwvYlGO/06zz8euC5RyVJ0KBJf845R8Qj4egFcq3aSwfSh/bpuCy/XnYYAXMFid96pZ
         rXqqE6/KPqIisaVgCxYJLJFK3YOcw+xfWLgCvuR3DDL6oANtpDmhxtBFshAbp/XKksZr
         ltv8rLiFpujyenRrpCAR1IB0yInd9y73VzdZgyKNDbgqQBnxwvdx3R5nSuVQ/0c+BsZ3
         AY5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VUQbpg5HItyWZZQATZnM4RSqQnbK+YIpF8+VzAqkd5I=;
        b=PRX3KLS2E7WxynwUJDSrzSz1AHtdKBhgLq+WmkcExR6CzAjMayZ4pQTrFizBBK4Sza
         TW7NGK6TZ48b1O97ur6ko8oUCR9OHpwFiTCi3zWT7VId6tYeolAxWpNjZMyTdlZvqHCs
         PLvFzYhAdAv53nlI+PtmY2S023Exkcy+xTm3pbQjS8Ha0SrqKn3uwiFRhObCoYulcO+W
         yEUPRzJQVbVoO+IUbfvGd5JJvwlRFFEbjSDp59UvLvcjVchP5zNMKvgLGbFJmYiFZ/B9
         t6+DtL6uSEVyhmgBsNcCXCW3YDTRo9dERnelQJhkx4ynGoiyfzbtuNE+K5LOwZ3tNUGD
         O/xA==
X-Gm-Message-State: AFqh2krxR1UgGZ7NMqWPH80wxaG+6dkGPMVRPkHA2QRCth9AHWS/QykB
        Mz21tr/ffY0i0y1CecXE2WuCrB7ToEPAyuvrsrM1TP4TG+ZgzQ==
X-Google-Smtp-Source: AMrXdXtm3G4lKafxGxvq3NBWSBSPmy4LNh0BElo99Uxgk7TClAhifk5n9ULTCijISaHOiEGO3x4inVbPGzqsOcccfgk=
X-Received: by 2002:a25:6b0b:0:b0:7d2:8687:aea5 with SMTP id
 g11-20020a256b0b000000b007d28687aea5mr1186817ybc.210.1673865114014; Mon, 16
 Jan 2023 02:31:54 -0800 (PST)
MIME-Version: 1.0
References: <20230105215706.never.027-kees@kernel.org> <CACRpkdYfsY7K8GksccDunCfKHbq_Df8ddrYGRg2gmeu6CVCF5w@mail.gmail.com>
 <202301121452.14D1A95CA@keescook>
In-Reply-To: <202301121452.14D1A95CA@keescook>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 16 Jan 2023 11:31:42 +0100
Message-ID: <CACRpkdb7VcxgZKVYZJAU4mFS1RPwxpDTxvLjFRGFuEiyVgbE2Q@mail.gmail.com>
Subject: Re: [PATCH] ARM: ixp4xx: Replace 0-length arrays with flexible arrays
To:     Kees Cook <keescook@chromium.org>
Cc:     Krzysztof Halasa <khalasa@piap.pl>, Arnd Bergmann <arnd@arndb.de>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 12, 2023 at 11:54 PM Kees Cook <keescook@chromium.org> wrote:
> On Sun, Jan 08, 2023 at 12:58:37AM +0100, Linus Walleij wrote:
> > On Thu, Jan 5, 2023 at 10:57 PM Kees Cook <keescook@chromium.org> wrote:
> >
> > > Zero-length arrays are deprecated[1]. Replace npe_load_firmware's
> > > union of 0-length arrays with flexible arrays. Detected with GCC 13,
> > > using -fstrict-flex-arrays=3:
> > >
> > > drivers/soc/ixp4xx/ixp4xx-npe.c: In function 'npe_load_firmware':
> > > drivers/soc/ixp4xx/ixp4xx-npe.c:570:60: warning: array subscript i is outside array bounds of 'u32[0]' {aka 'unsigned int[]'} [-Warray-bounds=]
> > >   570 |                         image->data[i] = swab32(image->data[i]);
> > > include/uapi/linux/swab.h:115:54: note: in definition of macro '__swab32'
> > >   115 | #define __swab32(x) (__u32)__builtin_bswap32((__u32)(x))
> > >       |                                                      ^
> > > drivers/soc/ixp4xx/ixp4xx-npe.c:570:42: note: in expansion of macro 'swab32'
> > >   570 |                         image->data[i] = swab32(image->data[i]);
> > >       |                                          ^~~~~~
> > > drivers/soc/ixp4xx/ixp4xx-npe.c:522:29: note: while referencing 'data'
> > >   522 |                         u32 data[0];
> > >       |                             ^~~~
> > >
> > > [1] https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays
> > >
> > > Cc: Krzysztof Halasa <khalasa@piap.pl>
> > > Cc: Linus Walleij <linus.walleij@linaro.org>
> > > Cc: Arnd Bergmann <arnd@arndb.de>
> > > Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
> > > Cc: linux-arm-kernel@lists.infradead.org
> > > Signed-off-by: Kees Cook <keescook@chromium.org>
> >
> > Looks good to me:
> > Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
>
> Thanks!
>
> > Do you need me to funnel this to the SoC tree or do you have
> > some quickpath for fixes like this?
>
> I'll take it via my tree if unless you'd rather it go through yours.
> Most maintainers take these directly, but some don't want to. I'm
> flexible! :)

Just pick it into your tree, the IXP4xx is low activity and I do not
submit new material every merge window, so this is easiest.

Thanks!
Linus Walleij
