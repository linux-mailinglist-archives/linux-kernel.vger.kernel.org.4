Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85A165BFC0B
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 12:11:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230487AbiIUKKx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 06:10:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230072AbiIUKKU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 06:10:20 -0400
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F65B65826;
        Wed, 21 Sep 2022 03:10:20 -0700 (PDT)
Received: by mail-qt1-f181.google.com with SMTP id g23so3695779qtu.2;
        Wed, 21 Sep 2022 03:10:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=/SSEuwrmJLJj9UMZKTCar/0/cGO6w/t/L7XekBxJJtM=;
        b=qifR23m+5qwnjumNkChgxvkSA4OnaJwIJGST3orenlU+RlPakWWnVK8DvEZmYXs1W1
         xQSMjVakdg7VPUzuP2RDZvNRtcBGTMJ/vX0sdeC1L7xCFQW/ICSz4uZhgDbAmxoOloHE
         Mdc+cMQFAuVcoO64uK9u4h6A/PtI9x298E5CGh0kraxju3pCxShuAiQQeBHAsH1drtc3
         bmlyS8jgEmwfN9HoM6k6MIttuG6SPno8/zUl0DSI8A3vIkxiz2T3ttmmICeuSLmrtIJG
         oKjGhDtjQFnq4/0inlhdjikmYF+oQCIdQGF/Acj6CsrOTFnWeK+8oLP7LywT5JtZk9UB
         gapQ==
X-Gm-Message-State: ACrzQf0CzWnPdwB27ORmnHuHeQng8xC+lzZ/zVlYbAZum+Ih7dO2JKBV
        bxpcPpx1ZNr6RN52ysL5cLGsTIBixn/wTpDQ
X-Google-Smtp-Source: AMsMyM4b2MpSD2szwGj4+wZUUhpxVjAzdBW0EUTrk5EtZ3kClIFjSuBPwenyWVYxly8uku2wudfDmQ==
X-Received: by 2002:a05:622a:5d4:b0:344:98a8:8dae with SMTP id d20-20020a05622a05d400b0034498a88daemr23067150qtb.164.1663755018880;
        Wed, 21 Sep 2022 03:10:18 -0700 (PDT)
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com. [209.85.219.179])
        by smtp.gmail.com with ESMTPSA id w7-20020ac857c7000000b0035bbb6268e2sm1560858qta.67.2022.09.21.03.10.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Sep 2022 03:10:17 -0700 (PDT)
Received: by mail-yb1-f179.google.com with SMTP id 130so7295812ybz.9;
        Wed, 21 Sep 2022 03:10:16 -0700 (PDT)
X-Received: by 2002:a05:6902:2c1:b0:6b2:8bb0:79a0 with SMTP id
 w1-20020a05690202c100b006b28bb079a0mr18992385ybh.202.1663755016378; Wed, 21
 Sep 2022 03:10:16 -0700 (PDT)
MIME-Version: 1.0
References: <CAMuHMdUPm36RsxHdVwspR3NCAR3C507AyB6R65W42N2gXWq0ag@mail.gmail.com>
 <b0f2e13a-ff5d-5bfc-6dda-ca39bb57803e@linaro.org>
In-Reply-To: <b0f2e13a-ff5d-5bfc-6dda-ca39bb57803e@linaro.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 21 Sep 2022 12:10:05 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVKcikM0b97G99UhVtSwrxc07asB0nBqB6OL9XNXFb-gw@mail.gmail.com>
Message-ID: <CAMuHMdVKcikM0b97G99UhVtSwrxc07asB0nBqB6OL9XNXFb-gw@mail.gmail.com>
Subject: Re: Similar SoCs with different CPUs and interrupt bindings
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andre Przywara <andre.przywara@arm.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Samuel Holland <samuel@sholland.org>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Atish Patra <atishp@atishpatra.org>,
        "Lad, Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On Wed, Sep 21, 2022 at 10:49 AM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
> On 21/09/2022 09:46, Geert Uytterhoeven wrote:
> > This is a topic that came up at the RISC-V BoF at Plumbers, and it was
> > suggested to bring it up with you.
>
> I guess you also need SoC maintainers as well (+Cc Arnd and Olof). :)

Indeed, I had intended to include them, but forgot in the end.
Thanks for adding!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
