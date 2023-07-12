Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12C0C750273
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 11:06:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233250AbjGLJGE convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 12 Jul 2023 05:06:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232626AbjGLJFd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 05:05:33 -0400
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EE0F2724;
        Wed, 12 Jul 2023 02:04:33 -0700 (PDT)
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7679d75940fso584616485a.0;
        Wed, 12 Jul 2023 02:04:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689152672; x=1691744672;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uIF186mRaGX5BFXMSlH2BgP4u+RcqYufJt4GrXqOpCU=;
        b=jobu/vNOftR2lpurXpGcQu7ojLTUcBOMfCRPEXoKqu9kWjNUob61h8o22ryYsAwd7H
         7Np3lCaTj6ZjYzquVWgqCpB2dGGB9JGHPF6UiOlOGbcSl/UNuWKvD8lKk2P+8DCeidAm
         8DL6YvHiQuzWmx+6yEh2K7/sSCY6zPz8KJRJprzGqktVW9a5aZ951uZ86LuS7+gf27jL
         R/bFxTn/IYNmMWoZvAZoz7OBkDKYNdNh9+ao5s1eZG7qgLgZ5VkQ5dfmkA414mctQVjp
         za3jv3IYSHcL64q1ZLjTisjDIML20TTTBUWgsnivvx1YD04y0s73bWb2yxXBihgbuP07
         EI/g==
X-Gm-Message-State: ABy/qLaZ3i+Ce/9OSCJBMFCpI+fLLJqSNvyTGY9PX6AaBc0oSmBvHJnd
        RUqO1l1Y7zRsZODYOQX311KbmUmN6SNJfg==
X-Google-Smtp-Source: APBJJlHRYOUv25KUCxkJccL53H535+lbcKGBj66auOLOAOuJE3/We/1zfX2OodslL+8fqfxOmJFWLQ==
X-Received: by 2002:a05:620a:2401:b0:767:30a5:4ca1 with SMTP id d1-20020a05620a240100b0076730a54ca1mr21216067qkn.46.1689152672485;
        Wed, 12 Jul 2023 02:04:32 -0700 (PDT)
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com. [209.85.219.176])
        by smtp.gmail.com with ESMTPSA id s2-20020a81bf42000000b0057d24f8278bsm631250ywk.104.2023.07.12.02.04.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jul 2023 02:04:31 -0700 (PDT)
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-bc379e4c1cbso7766516276.2;
        Wed, 12 Jul 2023 02:04:31 -0700 (PDT)
X-Received: by 2002:a05:6902:28b:b0:c4b:41ce:f68b with SMTP id
 v11-20020a056902028b00b00c4b41cef68bmr16459258ybh.41.1689152670844; Wed, 12
 Jul 2023 02:04:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230511181931.869812-1-tj@kernel.org> <20230511181931.869812-7-tj@kernel.org>
 <ZF6WsSVGX3O1d0pL@slm.duckdns.org> <CAMuHMdVCQmh6V182q4g---jvsWiTOP2hBPZKvma6oUN6535LEg@mail.gmail.com>
 <CAMuHMdW1kxZ1RHKTRVRqDNAbj1Df2=v0fPn5KYK3kfX_kiXR6A@mail.gmail.com>
 <ZK3MBfPS-3-tJgjO@slm.duckdns.org> <20230712080504.GA3100107@hirez.programming.kicks-ass.net>
In-Reply-To: <20230712080504.GA3100107@hirez.programming.kicks-ass.net>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 12 Jul 2023 11:04:16 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUMRS9_nJXp3rrWQrODRQcBQggze0k=0GjSScCknFmmgQ@mail.gmail.com>
Message-ID: <CAMuHMdUMRS9_nJXp3rrWQrODRQcBQggze0k=0GjSScCknFmmgQ@mail.gmail.com>
Subject: Re: Consider switching to WQ_UNBOUND messages (was: Re: [PATCH v2
 6/7] workqueue: Report work funcs that trigger automatic CPU_INTENSIVE mechanism)
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel-team@meta.com, Linux PM list <linux-pm@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        linux-rtc@vger.kernel.org,
        linux-riscv <linux-riscv@lists.infradead.org>,
        netdev <netdev@vger.kernel.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        Linux MMC List <linux-mmc@vger.kernel.org>,
        "open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)" 
        <linux-ide@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hoi Peter,

On Wed, Jul 12, 2023 at 10:05 AM Peter Zijlstra <peterz@infradead.org> wrote:
> On Tue, Jul 11, 2023 at 11:39:17AM -1000, Tejun Heo wrote:
> > I wonder whether the right thing to do here is somehow scaling the threshold
> > according to the relative processing power. It's difficult to come up with a
> > threshold which works well across the latest & fastest and really tiny CPUs.
> > I'll think about it some more but if you have some ideas, please feel free
> > to suggest.
>
> We could scale by BogoMIPS I suppose, it's a bogus measurement, as per
> the name, but it does have some relation to how fast the machine is.

That's gonna fail miserably on e.g. ARM and RISC-V, where BogoMIPS
depends on some timer frequency.

R-Car M2-W with 1.5 GHz Cortex-A15: 40.00 BogoMIPS
R-Car V4H with 1.8 GHz Cortex-A76: 33.33 BogoMIPS

while the real slow 48 MHz VexRiscV gets 128 BogoMIPS.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
