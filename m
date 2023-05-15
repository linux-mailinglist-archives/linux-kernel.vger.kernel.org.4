Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEC3E702655
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 09:47:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbjEOHrQ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 15 May 2023 03:47:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238286AbjEOHq6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 03:46:58 -0400
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C20F9C;
        Mon, 15 May 2023 00:46:56 -0700 (PDT)
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-ba7854ff5abso2411023276.2;
        Mon, 15 May 2023 00:46:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684136815; x=1686728815;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x+sesuhYFb2sMrWYAczp8907eYFIY/Qn6ML1DW9XCIk=;
        b=T7ycIbK7Dz+UPVbKp9pXyMWIuYuH4y4+1rU6eehIoztmpbM35thJFu5+c3uJ5NSkZi
         4NVKXw5136jwqCdgOIv6zlt36ILStuGqrWtYmVNMh1s1NiusS2F/HxSL+jY+4MPApd49
         L7wXYYHsluCdlA/w3iM9PzwLTawrHQYwtjNaELAmFPTLGmNwaKmobuwTSuFjFg8+jJW4
         +6gv47lIaGhQWirnlHJvDd3eaAU8WJy9ET6ZGqspElWss8ABziYHxAcDL4N9iyTX/vsS
         SfVxggIUI6LLjyUDgHg06LzLuV3YSZebN5vZdxuSolJF483GfIt6WgpPUGx3xubGcj/Z
         DyPw==
X-Gm-Message-State: AC+VfDy7w9gLAtCIpNmJ4OaqgEj/aS0RifcfbexJ5O5oKVp9JFvLo6Cf
        TlplE8wwDilPLyNP/Mm6YSe4up+gBSCWjw==
X-Google-Smtp-Source: ACHHUZ4p/UuEVpPL7oTnhZWORoxfzjoPLJTqeEFE0Obf+G4hjIxpYJ58Cg8rpAVWoyVVD1XQQCyzsw==
X-Received: by 2002:a05:6902:1008:b0:b94:bbf1:fec7 with SMTP id w8-20020a056902100800b00b94bbf1fec7mr31436113ybt.47.1684136814953;
        Mon, 15 May 2023 00:46:54 -0700 (PDT)
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com. [209.85.219.176])
        by smtp.gmail.com with ESMTPSA id n188-20020a2540c5000000b00b9eeffa1abfsm1759045yba.39.2023.05.15.00.46.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 May 2023 00:46:53 -0700 (PDT)
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-ba7854ff5abso2410931276.2;
        Mon, 15 May 2023 00:46:53 -0700 (PDT)
X-Received: by 2002:a25:d308:0:b0:b92:3ed2:1cae with SMTP id
 e8-20020a25d308000000b00b923ed21caemr33787915ybf.12.1684136812848; Mon, 15
 May 2023 00:46:52 -0700 (PDT)
MIME-Version: 1.0
References: <ZElaVmxDsOkZj2DK@debian> <51cff63a-3a04-acf5-8264-bb19b0bee8a3@leemhuis.info>
 <CAHk-=wgzU8_dGn0Yg+DyX7ammTkDUCyEJ4C=NvnHRhxKWC7Wpw@mail.gmail.com>
 <20230510090527.25e26127@sal.lan> <55d5ec29-f30f-4596-a3b9-7e5b8adf0582@kernel.org>
In-Reply-To: <55d5ec29-f30f-4596-a3b9-7e5b8adf0582@kernel.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 15 May 2023 09:46:41 +0200
X-Gmail-Original-Message-ID: <CAMuHMdV=b8j=X3XEBWsAghsHrPT58xp7peaMiTZisqf7wRJf3w@mail.gmail.com>
Message-ID: <CAMuHMdV=b8j=X3XEBWsAghsHrPT58xp7peaMiTZisqf7wRJf3w@mail.gmail.com>
Subject: Re: mainline build failure due to cf21f328fcaf ("media: nxp: Add
 i.MX8 ISI driver")
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux regressions mailing list <regressions@lists.linux.dev>,
        "Sudip Mukherjee (Codethink)" <sudipm.mukherjee@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-media@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On Sun, May 14, 2023 at 1:01 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
> On 10/05/2023 10:05, Mauro Carvalho Chehab wrote:
> > And another CI job testing bisect breakages as I receive pull requests,
> > applying patch per patch and using both allyesconfig and allmodconfig,
> > also on x86_64 arch with W=1:
> >
> >       https://builder.linuxtv.org/job/patchwork/
> >
> > The rule is to not merge stuff on media tree if any of those jobs
> > fail. I also fast-forward merging patches whose subject states that
> > the build has failed.
> >
> > In order to help with that, on normal situation, I usually take one week
> > to merge stuff from media_stage into media_tree, doing rebases at
> > media_stage if needed to avoid git bisect build breakages at media_tree
> > (which is from where I send my update PRs to you).
> >
> > Unfortunately, currently we don't have resources to do multiple randconfig
>
> Is you media staging tree included in LKP (kernel test robot)? You would
> get huge build coverage after every push to your staging repo.

As (multiple[*[) fixes for the build issues were submitted before the
opening of the merge window, there must have been some build coverage,
with even some people acting upon it...

[*] General note, not limited to media: please apply build fixes and
    regression fixes ASAP, to avoid multiple people running into the
    same issues, and spending time on bisecting, investigating,
    fixing, ...
    Thanks a lot!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
