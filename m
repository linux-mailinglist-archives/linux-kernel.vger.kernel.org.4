Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7323F6F1569
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 12:28:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230262AbjD1K2b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 06:28:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346056AbjD1K22 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 06:28:28 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83E0CE69
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 03:28:27 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3f09b4a1584so66542275e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 03:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1682677706; x=1685269706;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZfGMC/jhsgLfQzo0SHoljXr/2t2JYSln8rtomysk++I=;
        b=hD7I0XgjY/BZDDPHQ+bgeA+CzkoJHzb94OGZh6JPpB6nTGgMf6Abo9pAWt5zAJQsKh
         Uw/tqn9PDEPNuqMLk0xc+X5fxNeH8EnQdTGpKw4S7WqAMjj5jiRPUio15MtGFNgiUiWD
         8ZAefvucanbeodh2jPn8dWJYIJBsjCLdbW1KBVO8jjmHhRONh6kJVNj+MfeLWvtAMw94
         TVDxz1b6zM+IAX8DIbBjjBO8vmIrSevukwEvv/Vl3mM1LgzV5fwTq0keO1kKEuaARJmp
         gXLIZCJaGXCRDNwEAqaGsFGATpr7G+6/lalolDT6hfYSTHSrJpPnQw1kYksm2pYXpVmp
         hnWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682677706; x=1685269706;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZfGMC/jhsgLfQzo0SHoljXr/2t2JYSln8rtomysk++I=;
        b=NGjP543AoQfuoOgMObeEur18eN4X2X0BkLVW+8oN14Y0MHLXUu1FMycuYreYvwCXGt
         O0KckVLTbXY2mujBgdgCyTf+iPJnY+/HsuEh6XpW8bkx93Gspd04RtfQK01A8xk558aW
         PYlD1N+2XfDkGoWpCGvg1SbSk6QCyf23XluGi6k/Jk1UL+cXGP2Gkn5BjbHkgMlMT50F
         VlTVPKt35jOIy+7tBZD0Pkj/3nQBuLm/s0oigUORZ+kfahGIrGzFQV8kS8zTgHe9dw2t
         q/cBXmoet6fUML3MtwTq5S2yni8pwXpJF8anRsACiutRFV8NzWbWq5rdTWslNDlmT5Ys
         EMIA==
X-Gm-Message-State: AC+VfDxrkyUAwMyn5PVhVxNH8Q4kvTGS+ijbTRmqs58dOZ4ex9j442A0
        fxgNcFJGk3J/XTbnqlqhTlItHQ==
X-Google-Smtp-Source: ACHHUZ635hgVhCN8pnLlW+6Lu4Byx+Ptd0TOnsSoSl2JFuNMjarpMQdZkrvvjK/Qn/HAEKr8ROkJ9Q==
X-Received: by 2002:a05:600c:2205:b0:3f1:6ead:34fe with SMTP id z5-20020a05600c220500b003f16ead34femr3747198wml.26.1682677705900;
        Fri, 28 Apr 2023 03:28:25 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id v15-20020a05600c444f00b003f09cda253esm27676885wmn.34.2023.04.28.03.28.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Apr 2023 03:28:25 -0700 (PDT)
Date:   Fri, 28 Apr 2023 12:28:24 +0200
From:   Andrew Jones <ajones@ventanamicro.com>
To:     Conor Dooley <conor@kernel.org>
Cc:     Heiko =?utf-8?Q?St=C3=BCbner?= <heiko@sntech.de>,
        Conor Dooley <conor.dooley@microchip.com>, palmer@dabbelt.com,
        linux-riscv@lists.infradead.org, paul.walmsley@sifive.com,
        kito.cheng@sifive.com, jrtc27@jrtc27.com, matthias.bgg@gmail.com,
        heinrich.schuchardt@canonical.com, greentime.hu@sifive.com,
        nick.knight@sifive.com, christoph.muellner@vrull.eu,
        philipp.tomsich@vrull.eu, richard.henderson@linaro.org,
        arnd@arndb.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] RISC-V: add support for vendor-extensions via
 AT_BASE_PLATFORM and xthead
Message-ID: <d6lqggv2bbtmv7exalcqqwgbntibdxotsswataxqxhx6kmf4rg@5kgb3axdwgst>
References: <20230424194911.264850-1-heiko.stuebner@vrull.eu>
 <20230424194911.264850-5-heiko.stuebner@vrull.eu>
 <20230426-spirits-ludicrous-a5d8275686e6@wendy>
 <5016896.Mh6RI2rZIc@diego>
 <20230427-maybe-skier-51e7cf09795c@spud>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230427-maybe-skier-51e7cf09795c@spud>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 27, 2023 at 07:28:49PM +0100, Conor Dooley wrote:
> Hey Heiko,
> 
> On Thu, Apr 27, 2023 at 07:15:58PM +0200, Heiko Stübner wrote:
> > Am Mittwoch, 26. April 2023, 14:29:16 CEST schrieb Conor Dooley:
> > > On Mon, Apr 24, 2023 at 09:49:11PM +0200, Heiko Stuebner wrote:
> > > > From: Heiko Stuebner <heiko.stuebner@vrull.eu>
...
> > > What do you mean by virtualisation here? It's the job of the hypervisor
> > > etc to make sure that what it passes to its guest contains only what it
> > > wants the guest to see, right?
> > > IIUC, that's another point against doing what this patch does.
> > 
> > I guess I'm still seeing Zbb and friends - with just computational
> > instructions as always good to have. But I guess you're right that the
> > hypervisor should be able to control itself which extensions.
> 
> Yah, there may not be any obvious downsides to something like Zbb, but I
> think that taking control away from the hypervisors etc isn't a good
> idea.

If there's any chance that a VM will need to migrate from a host with,
e.g. Zbb, to one without it, then the VM will need Zbb disabled from the
start.

> Having a simple policy of blocking things that are known to misbehave
> would require less maint. than a list of things that are okay to pass
> through, but both are probably cans-of-worms.
> I think we need to think carefully about what policy is chosen here.
> Allowlist will be slower, but at least we'll not tell userspace
> something that is not usable. Blocklist will be easier to manage, but
> can only be reactive.

I have experience [trying] to maintain deny-lists for CPU features,
both for x86 Xen guests and Arm KVM guests. I don't recommend it. To
do it right, you need to be proactive, tracking upcoming CPU features
to add the ones that can't be supported by virt or aren't ready to
be supported by virt to the deny-list before somebody trips over them.
In practice, usually somebody trips over it first, causing fires which
have to be put out. If an allow-list is used, then, when a new feature
is missed, no fires are started. The worst that can happen is somebody
expected the feature and didn't see it, so they complain, at which
point you add it.

...

> Also, in a world where we do do some sort of passing, should we only
> forward the vendor extensions, or should we forward the standard ones
> too?

I guess we need to forward anything userspace can and should use.

> What about supervisor mode only stuff?

That's not something userspace can use. If we want to expose which
supervisor mode features the CPU has to userspace, for information
purposes, then I think proc or sysfs would be sufficient for that.

The downside of using an allow-list for what extensions get exposed
to userspace is that even extensions the kernel can't/won't use
will need a kernel patch before userspace can use them. But, as
I stated above, that downside (people complaining a feature they
expect is missing), is, IMO, better than the alternative of exposing
things that shouldn't be.

Thanks,
drew
