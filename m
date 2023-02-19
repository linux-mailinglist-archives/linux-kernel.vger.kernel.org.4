Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F16169C2BB
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Feb 2023 22:33:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231736AbjBSVdg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Feb 2023 16:33:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231540AbjBSVdf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Feb 2023 16:33:35 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 348E3F777
        for <linux-kernel@vger.kernel.org>; Sun, 19 Feb 2023 13:33:34 -0800 (PST)
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com [209.85.128.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id BF2BB3F71B
        for <linux-kernel@vger.kernel.org>; Sun, 19 Feb 2023 21:33:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1676842412;
        bh=8R8frgxkiDD95gIO0fe6fOdEBdEu/5r0X1kDOciAmuU=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=CSKsk2WFxqodMY3GiFS+V5md/1U3r+WsPLMRkPsOzVu5j/cpMge7ChXQycGeyQ+pm
         AHJYuWLHiuJ1DHmjbHwx0Nb3v/9ob6bEkSXkhfg6R6AhsQmyIgu6zcsGEd2y/sDxj2
         ZuPuI39Z1gt6CACF57wlI4v8nHsOkHp1+nxx9aCQR7Khgjxu2j1FtK7/OrQEHWNL+A
         nfe/Oki0vpy0QkmD8Sng1TP9k7VHum9tHuU+BbVewkpy7I5S5AwleSmpwo170fDxQK
         vO1L1MAU8H98+2eSyjjqEgw5x1NY6K1gA69TSMvI3j8/gRDJHktB++uYeu+OlLrjW+
         DCXVY6jUPn75Q==
Received: by mail-wm1-f70.google.com with SMTP id bg26-20020a05600c3c9a00b003dd41ad974bso777921wmb.3
        for <linux-kernel@vger.kernel.org>; Sun, 19 Feb 2023 13:33:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8R8frgxkiDD95gIO0fe6fOdEBdEu/5r0X1kDOciAmuU=;
        b=DIob0OrF2X2gmsvQmlVMBXzc1WxI7pMcL4kXI0akOC4yKyhE79nKT0KXAJK2kRlJDX
         2BitHrjmUEc9AdsJMjo6npRCA3HT6iwjNgogYi31hwHU1LQrCYAt9MqCyy7QzHsWuvlf
         gKb9vhWuD3C6ZfTm9zKbylJFPvN/z2G6WRSpKiEjKgU0ZK3wg2P5xLRTm2BEqmcNlWAG
         trIzcI1vVXndjjBBm9jAzcz+TUbGw7jutY2k3xMbEPQpO/22wCjlEprLCXKFOt9yToWS
         xHRO96kzna8hIsXAhzM3ZYbqtFg6LeUWGBZjw7qRbOdbDlAjBPCO6ohWvofcwX5bM2B2
         tRkg==
X-Gm-Message-State: AO0yUKW387wVc56krgwfQrh/A9AfLvp2OMHJTVDZMLYvZv/MueuXTicg
        2dVS1leASuEheuSPBBTcD0XfL7YyyUSW0nRTOatu62rz8beom6ioOaABNwKKWtNgeAWu9oRkre6
        60GWhK5zSpcMUbcEbFNOpC+Yx4TDDuu/6XvIdTqxkUkuGjI/R1piEj7GiDg==
X-Received: by 2002:ac2:43dc:0:b0:4db:1aa4:fe08 with SMTP id u28-20020ac243dc000000b004db1aa4fe08mr25260lfl.1.1676842389566;
        Sun, 19 Feb 2023 13:33:09 -0800 (PST)
X-Google-Smtp-Source: AK7set/jqCxE7vysa+nLkM379Amt8o48UAX1vdCWM3PBOuY188t0gNT9otYGX3LH6uHIPrqc4/KhbzdCFeHafmAK5zQ=
X-Received: by 2002:ac2:43dc:0:b0:4db:1aa4:fe08 with SMTP id
 u28-20020ac243dc000000b004db1aa4fe08mr25246lfl.1.1676842389272; Sun, 19 Feb
 2023 13:33:09 -0800 (PST)
MIME-Version: 1.0
References: <20230211031821.976408-1-cristian.ciocaltea@collabora.com>
 <20230211031821.976408-5-cristian.ciocaltea@collabora.com> <Y+567t+kDjZI+fbo@spud>
In-Reply-To: <Y+567t+kDjZI+fbo@spud>
From:   Emil Renner Berthing <emil.renner.berthing@canonical.com>
Date:   Sun, 19 Feb 2023 22:32:52 +0100
Message-ID: <CAJM55Z_poY3dVu9fQ1W1VQw3V=8VdVKc1+qUcdHduM1aAveJUQ@mail.gmail.com>
Subject: Re: [PATCH 04/12] soc: sifive: ccache: Add non-coherent DMA handling
To:     Conor Dooley <conor@kernel.org>
Cc:     Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
        Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Sagar Kadam <sagar.kadam@sifive.com>,
        Yanhong Wang <yanhong.wang@starfivetech.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, kernel@collabora.com,
        daire.mcnamara@microchip.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Feb 2023 at 19:51, Conor Dooley <conor@kernel.org> wrote:
>
> Emil,
>
> +CC Daire
>
> On Sat, Feb 11, 2023 at 05:18:13AM +0200, Cristian Ciocaltea wrote:
> > From: Emil Renner Berthing <kernel@esmil.dk>
> >
> > Add functions to flush the caches and handle non-coherent DMA.
> >
> > Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
> > [replace <asm/cacheflush.h> with <linux/cacheflush.h>]
> > Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
> > ---
>
> > +void *sifive_ccache_set_uncached(void *addr, size_t size)
> > +{
> > +     phys_addr_t phys_addr = __pa(addr) + uncached_offset;
> > +     void *mem_base;
> > +
> > +     mem_base = memremap(phys_addr, size, MEMREMAP_WT);
> > +     if (!mem_base) {
> > +             pr_err("%s memremap failed for addr %p\n", __func__, addr);
> > +             return ERR_PTR(-EINVAL);
> > +     }
> > +
> > +     return mem_base;
> > +}
>
> The rest of this I either get b/c we did it, or will become moot so I
> amn't worried about it, but can you please explain this, in particular
> the memremap that you're doing here?

No, I can't really. As we talked about it's also based on a prototype
by Atish. I'm sure you know that the general idea is that we want to
return a pointer that accesses the same physical memory, but through
the uncached alias. I can't tell you exactly why it's done this way
though, sorry.

/Emil

> Cheers,
> Conor.
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
