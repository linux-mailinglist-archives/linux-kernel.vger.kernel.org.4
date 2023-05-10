Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 197386FE41D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 20:41:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235814AbjEJSlk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 14:41:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjEJSli (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 14:41:38 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBA2F4201
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 11:41:36 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-50c8d87c775so10005280a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 11:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683744095; x=1686336095;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DCODINovuD6W74TX3nJaKQ4TnYwjUa1Zq/w7R5QB2Is=;
        b=oDGDXzsIHkS0l2UOGndPXnmOneRjDU8JTdwD6suNH0Fl5HFU5tyZBF0oEhp09Ay99u
         zx5qrdMV8NxSMQdE8tcFQVofFYOtdhkqCPVCboAfQupzcbP65uE3lNefbS4nM884cF34
         O0GspYeSHhaslOjvPkgTBMQbcLv3lLGfcylJMYLsxbUg8Rv0hWsfAqPjylmC8090uAHa
         UwNdjrzkhoFsHEIJlyAmq/ouIiMTT1SMwfRACRpGrmqLvgP2X6f4zKKTc6on/23+Mgv1
         psJnRBnK3M5nhcDSaCWisvqTAfA/tMWLVfpVCJ/vU1JiiPZHedF/I4mNz4kb5SPNN2fG
         TFQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683744095; x=1686336095;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DCODINovuD6W74TX3nJaKQ4TnYwjUa1Zq/w7R5QB2Is=;
        b=MhGj19cYGz/aU9f0sr1rL6TNuLJdZqopntcLAhTTV95tEOGinKlquvhjUNeyn+3itR
         hNGg3VuwxvJzLQvmuk1HrxFvVwNoQA1wZKaDlGXJuFrDDg4w+yc0ZViVrFno+ppfEkra
         4obX0e+yBVNVwlT5/SERDsYZjbiHaXIKpYUZtsO9fwg2fW5fLpPZOBK3wcKKgalHN7tI
         ANadyAuJUjLd/psUH63TMw+zZWtQbo5y0KOkLTdcouYH1ge0vjxCuBCKe5VAf6kpeaOL
         Bn/3UC8DdKGLNrPmty+MkTpiFKB76gDQU4KDB/T2GajXHEEfLiEfh0ikHO7rLxZrgXes
         1JQg==
X-Gm-Message-State: AC+VfDxBnMnz2EtFvHHr0gSvC62Jnj2eBwJBUR8Fmb3FFNFUJKzb1zE6
        VRaMrHVT8/gAGlM0ylj9ptk=
X-Google-Smtp-Source: ACHHUZ4jSg1LYguTeA15quvP2rl6xkdq+J7V1B5Nh5vQJ2h8+gcGqKLRwx1TZ3YxZq5IKZpHYaAVxQ==
X-Received: by 2002:a17:907:9444:b0:966:5730:c3fe with SMTP id dl4-20020a170907944400b009665730c3femr13229604ejc.52.1683744095197;
        Wed, 10 May 2023 11:41:35 -0700 (PDT)
Received: from jernej-laptop.localnet (82-149-1-233.dynamic.telemach.net. [82.149.1.233])
        by smtp.gmail.com with ESMTPSA id ib8-20020a1709072c6800b0094f67ea6598sm2989106ejc.193.2023.05.10.11.41.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 May 2023 11:41:34 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Roman Beranek <me@crly.cz>, Frank Oltmanns <frank@oltmanns.dev>
Cc:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Samuel Holland <samuel@sholland.org>,
        Ondrej Jirman <megi@xff.cz>, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, Icenowy Zheng <uwu@icenowy.me>
Subject: Re: [PATCH v2 0/7] drm: sun4i: set proper TCON0 DCLK rate in DSI mode
Date:   Wed, 10 May 2023 20:41:33 +0200
Message-ID: <2682674.mvXUDI8C0e@jernej-laptop>
In-Reply-To: <87fs86q5h4.fsf@oltmanns.dev>
References: <20230418074008.69752-1-me@crly.cz> <87o7mvpayj.fsf@oltmanns.dev>
 <87fs86q5h4.fsf@oltmanns.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne ponedeljek, 08. maj 2023 ob 16:08:32 CEST je Frank Oltmanns napisal(a):
> Hello again,
> 
> On 2023-05-08 at 08:54:28 +0200, Frank Oltmanns <frank@oltmanns.dev> wrote:
> > Hello Roman,
> > 
> > On 2023-05-03 at 16:22:32 +0200, "Roman Beranek" <me@crly.cz> wrote:
> >> Hello everyone,
> >> 
> >> I apologize for my absence from the discussion during past week, I got
> >> hit with tonsillitis.
> > 
> > I hope you feel better!
> > 
> >> On Mon May 1, 2023 at 3:40 PM CEST, Frank Oltmanns wrote:
> >>> Looking at ccu_nkm_determine_rate(), we've found our culprit because it
> >>> does not try parent clock rates other than the current one. The same
> >>> applies to all other ccu_nkm_* functions.
> >> 
> >> Yes, that's why I dropped CLK_SET_RATE_PARENT from pll-mipi in v3.
> >> 
> >>>  b. Add functionality to ccu_nkm_* to also update the parent clock rate.
> >>> 
> >>> I'm actually interested in tackling b, but I can't make any promises as
> >>> to if and when I'll be able to solve it. I'm not certain about any side
> >>> effects this might have.
> >> 
> >> It sounds like an interesting exercise. But what if HDMI is then added
> >> to the mix?
> > 
> > Thanks for interest in this discussion! I really appreciate it!
> > 
> > First of all, let me admit that I'm no expert on this. But nobody else
> > has replied so far, and I want to keep this conversation going, so let
> > me share my view.
> > 
> > My understanding is that pll-mipi being able to set pll-video0's rate
> > should not have an impact on HDMI, neither positive nor negative. If I'm
> > not mistaken those two things are orthogonal.
> > 
> > The relevant part of the clk_summary with your v4 [1] patch on top of
> > 
> > drm-next looks like this:
> >                                  enable  protect              hardware
> >    
> >    clock                          count    count        rate    enable
> > 
> > ----------------------------------------------------------------------
> > 
> >     pll-video0                        1        1   294000000         Y
> >     
> >        hdmi                           0        0   294000000         N
> >        tcon1                          0        0   294000000         N
> >        pll-mipi                       1        1   431200000         Y
> >        
> >           tcon0                       2        1   431200000         Y
> >           
> >              tcon-data-clock          1        1   107800000         Y
> >        
> >        pll-video0-2x                  0        0   588000000         Y
> > 
> > Note, that pll-video0 is protected.
> > 
> > I don't own any boards that support HDMI in mainline. For the pinephone
> > this support is added e.g. in megi's kernel, where connecting an HDMI
> > output results in pll-video0's rate being set to 297MHz, even though it
> > is 294MHz after boot.
> > 
> > So, for reference, this is the same part of the clk_summary with megi's
> > 
> > 6.3.0 kernel, USB-C dock unplugged:
> >                                  enable  protect              hardware
> >    
> >    clock                          count    count        rate    enable
> > 
> > ----------------------------------------------------------------------
> > 
> >     pll-video0                        3        0   294000000         Y
> >     
> >        hdmi-phy-clk                   1        0    73500000         Y
> >        hdmi                           1        0   294000000         Y
> >        tcon1                          0        0   294000000         N
> >        pll-mipi                       1        0   431200000         Y
> >        
> >           tcon0                       2        0   431200000         Y
> >           
> >              tcon-pixel-clock         1        0   107800000         Y
> >        
> >        pll-video0-2x                  0        0   588000000         Y
> > 
> > pll-video0 is not protected. When plugging in the USB-C dock with an HDMI
> 
> > monitor connected, the situation looks like this:
> Just for reference, the protection count is disabled by this commit [1]
> in megi's kernel.
> 
> In the commit message Icenowy Zheng refers to "the ability to keep TCON0
> clock stable when HDMI changes its parent's clock." She implemented this
> in these two previous commits [2] [3]. None of this is in mainline.

Those commits are good follow up series to this, if anyone wants to improve 
things further.

Best regards,
Jernej

> 
> Best regards,
>   Frank
> 
> [1]:
> https://github.com/megous/linux/commit/039f7ee3f44adfbe4c6b7c2f1798b9a70c9f
> b9ee [2]:
> https://github.com/megous/linux/commit/a927843932f16e5a7f5ff57fbfd2d5f11c71
> 2b67 [3]:
> https://github.com/megous/linux/commit/0e305371eaa49128856acce9830e6af07944
> 2ad6
> >                                  enable  protect              hardware
> >    
> >    clock                          count    count        rate    enable
> > 
> > ----------------------------------------------------------------------
> > 
> >     pll-video0                        4        1   297000000         Y
> >     
> >        hdmi-phy-clk                   1        0   148500000         Y
> >        hdmi                           1        0   148500000         Y
> >        tcon1                          1        1   148500000         Y
> >        pll-mipi                       1        0   424285714         Y
> >        
> >           tcon0                       2        0   424285714         Y
> >           
> >              tcon-pixel-clock         1        0   106071428         Y
> >        
> >        pll-video0-2x                  0        0   594000000         Y
> > 
> > As you can see, pll-video0 is updated to 297 MHz. My understanding is
> > (again: not an expert here) this is only possible due to the missing
> > protection.
> > 
> > What I'm trying to say is that I don't see a connection between HDMI and
> > having the functionality in ccu_nkm_* to update the parent clock rate.
> > 
> > But I do think it would be preferable to have pll-video0 at 297 MHz
> > after boot on the pinephone. We could achieve this with my two previous
> > 
> > proposals:
> >  a) Set pll-video0 to 297 MHz on boot
> >  b) Add functionality to ccu_nkm_* to also update the parent clock rate.
> > 
> > If solution b is viable, the goal for the pinephone (and any other
> > boards supporting HDMI) would then be to select a pixel-data-clock so
> > that the rate for pll-video0 is set to 297 MHz (by selecting an
> > appropriate clock speed for the internal panel).
> > 
> > Maybe I'm misunderstanding something. If so, I'd appreciate any
> > corrections.
> > 
> > Thanks,
> > 
> >   Frank
> > 
> > [1]: https://lore.kernel.org/all/20230505052110.67514-1-me@crly.cz/
> > 
> >> Best regards
> >> Roman




