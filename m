Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E09B64037B
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 10:38:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232527AbiLBJiv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 04:38:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232577AbiLBJis (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 04:38:48 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15B68B0DC3;
        Fri,  2 Dec 2022 01:38:48 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id n20so10346524ejh.0;
        Fri, 02 Dec 2022 01:38:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tJDjgBXpMszFeIAvqAsFvMh1NYdd/aFzFWK8zEmUqAM=;
        b=U9mb0G6OeUfsr7F5qkXSmk4SmSORG85/hynvQ3+ZvNSDVJJSF9UUp3dvjqnV8dN3AQ
         b8R7Epvw/vVnuKFZZBf5CX50e2YB3bNRbr1mX5J0Ko8RsXQ3c+73nnbWgmYfpAmNl+OP
         EfWByawDHJnTPX1QmdsVi2NPI+6qDT7QCHLa9n53KBCgCDH4mUUgHaz7DyJu+4xlzFeK
         RTu5Y8Xc6hZ/yg/OwmvtBWTpIEkMZtMdUJtXa7HIrm0xa7FpGRfSa8ixUoBojckvRZNN
         liIEKa3Cg7ntlatroMxJOSoU5rLmyMMZDXHw73yebWyq282HSXPnHCIXP8tYyA3PMOgB
         rUUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tJDjgBXpMszFeIAvqAsFvMh1NYdd/aFzFWK8zEmUqAM=;
        b=yozWmOwQTlDZmOyJDb4MnBkF9ikpJ3RUmq6ytI+jhLbIGLDCdIdBUlYryhoU2NMo2S
         mflb0E86E62N/v93WA+LtTq3nFF13TOujoDCimKplO5ShrBRJQUg4Z64E3D+7vWNOIO2
         lJ2G3hsdlxQ81irt2ynjh60exM7u7AlhmGKG0jGTxkqG6iQLP8VgOSmiH3L2CRMWHf5p
         v0jQ2WiE06mtTtrayG2mIvtVteH4PfJDppdu5dWlkf62N+TIieD2v8hsYvDepjVaia4W
         1pRDSTGX4CIr5GA3UFV+qv6ykYr7/m7x1VymyETRiXhpJEu2wgQQfvvbh0zepFfCNLaz
         um4g==
X-Gm-Message-State: ANoB5pnyq+3Yu9PYLBFxYPgbhCA4vJV3bI2or3+uqPNRhsE9dE7S6zu+
        R9zQXw0OascoEbeYaXgps1Y1aYR0reOq4YttR4U=
X-Google-Smtp-Source: AA0mqf7FIABNiGeTLlM0hVvJiKrNKmFgn+etb0uKjE4IT1Q/r1PLThWQVRPMXCJk1tD3bz6ZJt+mnaCfzIV6oA0v5mI=
X-Received: by 2002:a17:906:9497:b0:7c0:cbc9:ab68 with SMTP id
 t23-20020a170906949700b007c0cbc9ab68mr635147ejx.155.1669973926567; Fri, 02
 Dec 2022 01:38:46 -0800 (PST)
MIME-Version: 1.0
References: <20221124172207.153718-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <Y4k6ct+iA4j0NZgR@spud>
In-Reply-To: <Y4k6ct+iA4j0NZgR@spud>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Fri, 2 Dec 2022 09:38:20 +0000
Message-ID: <CA+V-a8v5-nz_f-_P=L0miBPHOVAND-V8ed-tVttXV52nOJth6w@mail.gmail.com>
Subject: Re: [PATCH v4 0/7] AX45MP: Add support to non-coherent DMA
To:     Conor Dooley <conor@kernel.org>
Cc:     palmer@dabbelt.com, Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Conor,

On Thu, Dec 1, 2022 at 11:36 PM Conor Dooley <conor@kernel.org> wrote:
>
> Hi Prabhakar,
>
> I'm going to mark this series as "Changes Requested" in patchwork since
> there's been quite a lot of commentary and it looks like Samuel & Heiko
> have both suggested some changes.
Sounds good, I am working on the changes requested.

Cheers,
Prabhakar
