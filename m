Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4E946E95DF
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 15:29:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231289AbjDTN31 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 20 Apr 2023 09:29:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjDTN3Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 09:29:24 -0400
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D1EA44BB;
        Thu, 20 Apr 2023 06:29:23 -0700 (PDT)
Received: by mail-yb1-f170.google.com with SMTP id n17so2214986ybq.2;
        Thu, 20 Apr 2023 06:29:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681997362; x=1684589362;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SwYnTl+Plx0PSrLU1IU0gj4WvioW389t1+c4+HFYYy8=;
        b=aMuaIBESkhd6cIqKp/fUvPBHTl9zYc2UsO5fhhQlZTudA8e2eojbh6/xi70ASvHJ9K
         yj2X5OPDY5LFDHRu3k/0jrflMxMoAZrZqOBlNkvlf3ovhsyWpz+zg5b7CdkJax5ZKqUx
         oiqNYR6HNW1AgQjBIx0ewPxPU6RQK9+ZV1+2YKrzglbGMgsNZRXTpw9Bz9H/Tk8/zj0J
         BnF//Icr3/rYhdBCKbgXqJaAPOoLyARhwONENLg3p423ZJ5+Q0xcleRrtgloajeYuCjB
         hjGmkuTYp4hARvtjK7vmL6K4wD4+wA5rgSJwHDmIBuQmlchU4xiqVQMZDg92qfuLGG3u
         rGpQ==
X-Gm-Message-State: AAQBX9eWcey0svecW4gR6Wz4izjmk4BEYIMP7zuiS6aNxiqCQVltp1l0
        E+OkZMsLLvdnJFNkM4ZtMJRC97Ou52ZFddOM
X-Google-Smtp-Source: AKy350ZObBBjrEaGjs6J/nRBACRz90Tm63SgDNyyAOgOpPqPJ7UYPFqP/iwu9wLmV6crB5Lu3FuvnA==
X-Received: by 2002:a25:a047:0:b0:b92:588e:7360 with SMTP id x65-20020a25a047000000b00b92588e7360mr1209438ybh.50.1681997362639;
        Thu, 20 Apr 2023 06:29:22 -0700 (PDT)
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com. [209.85.128.171])
        by smtp.gmail.com with ESMTPSA id a3-20020a256603000000b00b8ed4bee6absm293468ybc.48.2023.04.20.06.29.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Apr 2023 06:29:22 -0700 (PDT)
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-54fa9da5e5bso41922437b3.1;
        Thu, 20 Apr 2023 06:29:22 -0700 (PDT)
X-Received: by 2002:a0d:d146:0:b0:54f:d7f7:9d61 with SMTP id
 t67-20020a0dd146000000b0054fd7f79d61mr815807ywd.14.1681997362050; Thu, 20 Apr
 2023 06:29:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230411100346.299768-1-biju.das.jz@bp.renesas.com> <20230411100346.299768-9-biju.das.jz@bp.renesas.com>
In-Reply-To: <20230411100346.299768-9-biju.das.jz@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 20 Apr 2023 15:29:10 +0200
X-Gmail-Original-Message-ID: <CAMuHMdV7p0BZEp4NCZCRKkxuRCYDHHEN+udwb5wuRgT+tMWxBw@mail.gmail.com>
Message-ID: <CAMuHMdV7p0BZEp4NCZCRKkxuRCYDHHEN+udwb5wuRgT+tMWxBw@mail.gmail.com>
Subject: Re: [PATCH v2 8/8] arm64: dts: renesas: rzg2lc-smarc: Link DSI with ADV7535
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        linux-renesas-soc@vger.kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
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

On Tue, Apr 11, 2023 at 12:04 PM Biju Das <biju.das.jz@bp.renesas.com> wrote:
> Enable DSI and ADV7535 and link DSI with ADV7535 on RZ/G2LC SMARC EVK.
>
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---
> v2:
>  * New patch

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-devel for v6.5.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
