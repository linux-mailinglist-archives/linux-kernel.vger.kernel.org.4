Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A236A6385D6
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 10:04:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229686AbiKYJEq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 04:04:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiKYJEp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 04:04:45 -0500
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8928C1CFD4;
        Fri, 25 Nov 2022 01:04:43 -0800 (PST)
Received: by mail-qv1-f47.google.com with SMTP id r15so1826283qvm.6;
        Fri, 25 Nov 2022 01:04:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Na1uuPG0QUm3HxGryKPw8jShOXh4QNKTq09wipPjxvk=;
        b=GE/LTAqjw+BEIgrXikOi4e+5pNAOVo5KtiEZnDdckn3hU6UQK88U8bdi3v9+KhQ10B
         7xsXHW+6nR/+HlN6FWTc9vOs8Ek+mEYNlkMH+B1Z9XzvKYC7nW23DoEoGvpDK8nXY98B
         9bK35Zmi/s+hYCGxGK91On6T3+Sc1aaOhwwoQl+yS9fIM5tzyiSu38AhU3JK1MpoWwjf
         YaPY5qCSHvKBZikbU1fo75IoTUypDoNAgt9vIeaXL8Od/cZbYieGAAofUbRGixqFV/eP
         Ymep+HZlRzL/OjodUsPbZrVqRX567oQe2j6RHzobpWEzAQBYFhU9UkVw9DMSrb6bf8Wd
         Fv3w==
X-Gm-Message-State: ANoB5pnGWG9HO5UaXhreaNK/X6ZgDgUsAzEDvWg+/uLxvoTpYl+Vuaog
        Xigx6xLtBCLg9UotEALG9BXBfVj7K1AcRw==
X-Google-Smtp-Source: AA0mqf55B6VJ7ZX0fWyNDsbym+GlUZrv6CYp979IHqihxSFIwluFzAAMjRPbsUgijuUlXeMRwkGAzQ==
X-Received: by 2002:a05:6214:3b0e:b0:4bb:6b72:3c36 with SMTP id nm14-20020a0562143b0e00b004bb6b723c36mr15971524qvb.121.1669367082547;
        Fri, 25 Nov 2022 01:04:42 -0800 (PST)
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com. [209.85.219.177])
        by smtp.gmail.com with ESMTPSA id z127-20020a379785000000b006eed75805a2sm2375579qkd.126.2022.11.25.01.04.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Nov 2022 01:04:41 -0800 (PST)
Received: by mail-yb1-f177.google.com with SMTP id i131so4341989ybc.9;
        Fri, 25 Nov 2022 01:04:39 -0800 (PST)
X-Received: by 2002:a25:7204:0:b0:6f0:9ff5:1151 with SMTP id
 n4-20020a257204000000b006f09ff51151mr9302140ybc.543.1669367079638; Fri, 25
 Nov 2022 01:04:39 -0800 (PST)
MIME-Version: 1.0
References: <20221124172207.153718-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20221124172207.153718-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 25 Nov 2022 10:04:28 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWbunjdFo5YfQ2t4DSDm-LX8WhvLkzAogGrOg7HY4_uPw@mail.gmail.com>
Message-ID: <CAMuHMdWbunjdFo5YfQ2t4DSDm-LX8WhvLkzAogGrOg7HY4_uPw@mail.gmail.com>
Subject: Re: [PATCH v4 0/7] AX45MP: Add support to non-coherent DMA
To:     Prabhakar <prabhakar.csengg@gmail.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Magnus Damm <magnus.damm@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Guo Ren <guoren@kernel.org>,
        Jisheng Zhang <jszhang@kernel.org>,
        Atish Patra <atishp@rivosinc.com>,
        Anup Patel <apatel@ventanamicro.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Philipp Tomsich <philipp.tomsich@vrull.eu>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-renesas-soc@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
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

Hi Prabhakar,

On Thu, Nov 24, 2022 at 6:24 PM Prabhakar <prabhakar.csengg@gmail.com> wrote:
> Due to the above approach custom SBI calls have been implemented. The
> above implementation is in preparation for adding support for Renesas
> RZ/Five SoC which uses the AX45MP core. As with the above approach the
> kernel image might not be generic so that it can be used on other

might be generic?

> platforms.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
