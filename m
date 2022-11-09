Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 822766234D1
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 21:45:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230096AbiKIUpL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 15:45:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231567AbiKIUpG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 15:45:06 -0500
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF4F914D14;
        Wed,  9 Nov 2022 12:45:05 -0800 (PST)
Received: by mail-qk1-f175.google.com with SMTP id x18so11715083qki.4;
        Wed, 09 Nov 2022 12:45:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bKBYazOHxtCaO2FguzlHAhQzUkX2fPZcyJSc9EJ/FY8=;
        b=3xRlWMsgCkcR79jyh3WOgGV76MpIG21ajgHWtQ907kPfAHF/xeCHRpGQ7azcnJyoS4
         5M/to2goWIkvIMOxnByokm6JCwZI6ixhkILG3PjnzgUq0BVkOMiHr1VlvFZUmt/nLgiw
         +SQe+w+tkQ3wMMXAkYbur9ue0VIDiBbjhI7g3uKd0Gsj0T8Ol5iCHyg1bSiFzjtm/m92
         CLOLjsDIImUb+pGpXz/i+xlO7vqXURtal9iKPVfTmFK56F7tRHYkbeln5VjceOFDSlj8
         HeC+Hzgm/om6Y8nOL3HjMYuch2wB7iAtClnZwSm36fR4PqE1P0aLZpT/zFyazHSmqKVv
         rtQQ==
X-Gm-Message-State: ACrzQf38V5ww+Ayp/1aohuSVymz56qwDKLvPodfENXE4gOesB+tY3CpW
        UqTG5omLND/438ufu6/VXCDBPoeimZhatg==
X-Google-Smtp-Source: AMsMyM5hwAbiKOLz1InhnM8WYemxE/bsnl52vm/hllaWED6zfxxXUSmwi8WvJORo29NNfF+5FCaDmA==
X-Received: by 2002:a05:620a:280d:b0:6cf:ab57:a130 with SMTP id f13-20020a05620a280d00b006cfab57a130mr45145181qkp.749.1668026704698;
        Wed, 09 Nov 2022 12:45:04 -0800 (PST)
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com. [209.85.219.173])
        by smtp.gmail.com with ESMTPSA id br7-20020a05620a460700b006bbc09af9f5sm11851997qkb.101.2022.11.09.12.45.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Nov 2022 12:45:03 -0800 (PST)
Received: by mail-yb1-f173.google.com with SMTP id 131so117413ybl.3;
        Wed, 09 Nov 2022 12:45:03 -0800 (PST)
X-Received: by 2002:a05:6902:503:b0:6cf:c510:6a23 with SMTP id
 x3-20020a056902050300b006cfc5106a23mr41506442ybs.380.1668026703709; Wed, 09
 Nov 2022 12:45:03 -0800 (PST)
MIME-Version: 1.0
References: <20220613131033.10053-1-wsa+renesas@sang-engineering.com>
 <20220613131033.10053-2-wsa+renesas@sang-engineering.com> <CAMuHMdX-56GZmZJ-JvkFvZ6NsozsamtoKURPzsS-3+AYtZBhFQ@mail.gmail.com>
 <YqmoWYARVsXos3me@shikoro>
In-Reply-To: <YqmoWYARVsXos3me@shikoro>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 9 Nov 2022 21:44:52 +0100
X-Gmail-Original-Message-ID: <CAMuHMdU7foCN873wrwUVgCyuoN6Y52Ds-ENXUSoEH0wKpD_qBQ@mail.gmail.com>
Message-ID: <CAMuHMdU7foCN873wrwUVgCyuoN6Y52Ds-ENXUSoEH0wKpD_qBQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] arm64: dts: renesas: spider-cpu: Switch from SCIF3 to HSCIF0
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

Hi Wolfram,

On Wed, Jun 15, 2022 at 11:37 AM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
> > I.e. the U-Boot on the Spider in Magnus' lab has "baudrate=115200"
> > in its environment, while I can read the output from ICUMXA Loader
> > to U-Boot, and Linux just fine.
>
> Earlier U-Boot may have no HSCIF support. Recent ones have and the
> installer suggests to set baudrate to highspeed. ICUMXA loaders never
> worked for me in 115200.
>
> I can keep my patch local if you prefer 115200.

As all active white-hawk users are now suffering from this,
I will queue your patch in renesas-devel for v6.2.

Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
