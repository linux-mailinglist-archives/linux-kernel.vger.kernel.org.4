Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D623C6E0117
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 23:42:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230024AbjDLVmk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 17:42:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjDLVmi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 17:42:38 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6761F6199
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 14:42:37 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-54bfa5e698eso398969077b3.13
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 14:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681335756;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6gcZqtT4lnmibkmAhvy5qSkAj7O4zzOnoHrhb2P4JMQ=;
        b=zyZLaOsl6yJiuXzO/tP8LLLLkurKniXcJiiOPaHXlkzEwgHR/qjIyx0oemyPqV2M8o
         8cNIE5cZg9U6it+lQAT4o/BIfqGJIWHbCvnSoBpt6xZOH27cJ6hTzJnnv1HB71HKpErB
         9M0orwgXiW7Ipwdh0rOoEu79qMgFWjsqdBSTmRLoaTdrslWMSY3pnSXpTdm6JMWK3pb9
         F9WFE/X9NRwXd3N8fsm25Rjhb0jRqM5eOGu68AIxzmleO5PFQbkE7JKMq4vMiqcn4z9u
         XGy7j4bnCX/2eBDZbwkug3feURl9BugCC0dgxrEdCBirqVI46nVeYg2qjjc33MROyvp5
         jtlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681335756;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6gcZqtT4lnmibkmAhvy5qSkAj7O4zzOnoHrhb2P4JMQ=;
        b=eeI9hqxOkU36+wWAkv129CsSCc7CX/czHiDKHBZlN1w/aWDN/qVmKsDEGr9nyg9dTk
         kVRSUlAhEfINYqHtrtzQXpqyfNWYnsB/bH/n6ebeZmitNxADUTXi9cFmGgwKXRNmUMOE
         nQv90Y4mosgQkHYOPFnh6SLqCYjHpOPq3LSlXyMJcuaFbLSwzAlYi/tjwMnfBpcRYESw
         vQ/xh7VyJbKxmzLMnWQ60er+FZMvylE1JAMC7ytE/nUJOwr45MNv40tSuNXjrXrTRALL
         b4WWaf/IzGfiYD8zX6qi4wXDT0570LPOvUunWJw3qxozONkpPGp64//lkmsaqHDRgLwu
         gAjQ==
X-Gm-Message-State: AAQBX9eJFAnH3eEPp2ZT5vHG3+rbW0PCIC1zxNuy1qeepgKgCr0OquQX
        b7/2E+SmuiYmwMvLvPQ18NY6763Smg2Ojxo+LZ3DEQ==
X-Google-Smtp-Source: AKy350YqDKQf8R10aYjJykD9u3BO/umK0kaV2L9eci/uO+Y7fkYPhpJYHdEL4fU3sY/AI/o6WKq/vrJ0vnf/2kJSDvc=
X-Received: by 2002:a81:ed06:0:b0:541:693f:cdd1 with SMTP id
 k6-20020a81ed06000000b00541693fcdd1mr2458880ywm.9.1681335756617; Wed, 12 Apr
 2023 14:42:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230412212126.3966502-1-j.neuschaefer@gmx.net> <20230412212126.3966502-2-j.neuschaefer@gmx.net>
In-Reply-To: <20230412212126.3966502-2-j.neuschaefer@gmx.net>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 12 Apr 2023 23:42:25 +0200
Message-ID: <CACRpkdaVTsPtXkdj3kc4n_0tLhziGfSQ8+1Yi5dKxL+0=8JS_Q@mail.gmail.com>
Subject: Re: [PATCH 1/3] ARM: compressed: Pass the actual output length to the decompressor
To:     =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Cc:     linux-arm-kernel@lists.infradead.org,
        Russell King <linux@armlinux.org.uk>,
        Nick Terrell <terrelln@fb.com>, Arnd Bergmann <arnd@arndb.de>,
        Tony Lindgren <tony@atomide.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Nick Hawkins <nick.hawkins@hpe.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Xin Li <xin3.li@intel.com>,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        Paul Bolle <pebolle@tiscali.nl>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-kernel@vger.kernel.org,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 12, 2023 at 11:21=E2=80=AFPM Jonathan Neusch=C3=A4fer
<j.neuschaefer@gmx.net> wrote:

> ZSTD writes outside of the space that is necessary for the uncompressed
> data, when it is told it has unlimited output length. To fix this, pass
> the actual output length (the length of the uncompressed kernel) to the
> decompressor.
>
> The uncompressed length is already stored as a little endian 32-bit
> constant before the input_data_end symbol.
>
> Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>

Really neat fix!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
