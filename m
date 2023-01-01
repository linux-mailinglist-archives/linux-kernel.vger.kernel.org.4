Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BF5D65A9F8
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Jan 2023 13:24:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230088AbjAAMYg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Jan 2023 07:24:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjAAMYe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jan 2023 07:24:34 -0500
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9060EB2D;
        Sun,  1 Jan 2023 04:24:32 -0800 (PST)
Received: by mail-qt1-f176.google.com with SMTP id j16so20579060qtv.4;
        Sun, 01 Jan 2023 04:24:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WU4mZYTUdP8Bxx/sJlJybQ4hqWHwyg4u2SGVhjlH2Cc=;
        b=wU/CG4TabFTYmmJ1pD8z/qhh49MZPZZO2u1BgiLrq70h2T717iYIVaRV4FlToJC1W+
         /zI8tdz3FtTzIO6nWZXoP1Kh8VPMV25kwWIJ2k1bwq4QM7SyfxyH/1ixc++PUqLnUm81
         n3KmU8MuXCIRPKWXeGbbog2EdQX864bUqkqb6zl/U6moeT4iLHbNcZflUBf5KwsIzxjm
         HkZCUDFvqAg92gmSVSWUisx7DLkg/Dd48kThZcfVIL9oGj0W3pAQJPXBeSdmM6AJ3Gl1
         bPXtVmNbYJRRkzfxjX1qGP1wG+yfgdjaws4RR72wEyoP8PSz0c1k/EF5EQ66hCKmSuDJ
         CfHw==
X-Gm-Message-State: AFqh2kpch8SdU2xc66Z76BvnVi6u6dw+pWmBaxxA/oyeGE0CJ7CYWh38
        ahlkPPj/4INM5AxJBUGKP0pxgFpeZ9AcMQ==
X-Google-Smtp-Source: AMrXdXt8+2A2+spLle73KkjUVhNnLC0+ybEtCWAamfYqgp0xlDVpuKlQkHq1hLS4BqaeFfEpIKe9/g==
X-Received: by 2002:a05:622a:5144:b0:3a5:ad81:8aff with SMTP id ew4-20020a05622a514400b003a5ad818affmr58326519qtb.55.1672575871257;
        Sun, 01 Jan 2023 04:24:31 -0800 (PST)
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com. [209.85.219.173])
        by smtp.gmail.com with ESMTPSA id r19-20020ac87953000000b00342f8d4d0basm16095352qtt.43.2023.01.01.04.24.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 Jan 2023 04:24:31 -0800 (PST)
Received: by mail-yb1-f173.google.com with SMTP id e141so27917016ybh.3;
        Sun, 01 Jan 2023 04:24:30 -0800 (PST)
X-Received: by 2002:a25:d103:0:b0:75d:3ecb:1967 with SMTP id
 i3-20020a25d103000000b0075d3ecb1967mr3169037ybg.604.1672575870549; Sun, 01
 Jan 2023 04:24:30 -0800 (PST)
MIME-Version: 1.0
References: <CAHk-=wgf929uGOVpiWALPyC7pv_9KbwB2EAvQ3C4woshZZ5zqQ@mail.gmail.com>
 <20221227082932.798359-1-geert@linux-m68k.org> <alpine.DEB.2.22.394.2212270933530.311423@ramsan.of.borg>
 <397291cd-4953-8b47-6021-228c9eb38361@landley.net>
In-Reply-To: <397291cd-4953-8b47-6021-228c9eb38361@landley.net>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Sun, 1 Jan 2023 13:24:19 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVX4Yz-zHvnwB0oCuLfiNAiEsSupcyjfeH+1oKTfQKC9A@mail.gmail.com>
Message-ID: <CAMuHMdVX4Yz-zHvnwB0oCuLfiNAiEsSupcyjfeH+1oKTfQKC9A@mail.gmail.com>
Subject: Re: Build regressions/improvements in v6.2-rc1
To:     Rob Landley <rob@landley.net>
Cc:     linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        kasan-dev@googlegroups.com,
        Linux-sh list <linux-sh@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On Sun, Jan 1, 2023 at 2:22 AM Rob Landley <rob@landley.net> wrote:
> On 12/27/22 02:35, Geert Uytterhoeven wrote:
> > sh4-gcc11/sh-allmodconfig (ICE = internal compiler error)
>
> What's your actual test config here? Because when I try make ARCH=sh
> allmodconfig; make ARCH=sh it dies in arch/sh/kernel/cpu/sh2/setup-sh7619.c with:

[re-adding the URL you deleted]

> > [2] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/830b3c68c1fb1e9176028d02ef86f3cf76aa2476/ (all 152 configs)

Following to
http://kisskb.ellerman.id.au/kisskb/target/212841/ and
http://kisskb.ellerman.id.au/kisskb/buildresult/14854440/
gives you a page with a link to the config.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
