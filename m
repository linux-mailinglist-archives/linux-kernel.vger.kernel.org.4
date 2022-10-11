Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B10D5FAE29
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 10:14:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229950AbiJKINs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 04:13:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230026AbiJKIN3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 04:13:29 -0400
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3169A8A7DD;
        Tue, 11 Oct 2022 01:13:21 -0700 (PDT)
Received: by mail-qv1-f48.google.com with SMTP id f14so8515462qvo.3;
        Tue, 11 Oct 2022 01:13:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LKbR4ieBilmLGumj/2iq1uroTruyZ95k0gYzbSgzxdk=;
        b=2Xh0hyudz2rxgfWocD5aJG6piaLuAd4X3fMH0IBZc+5avQCLLD20B+4TYi9cl8WTYf
         +0DI+5JA54+dc92q9ghQajXHyvzbl8rwEe76+9FhSYZPB4PHeggPA2/uGfnXdXtMGSoB
         Ui3bpw35AMsAupwsZB4z96T5Pe0sLRXVFiZzFsprm9ipgNNGwWoaf3Ol7ATC8hkLzG2D
         igQMQtvKfbbadiJAaxhX03LDiv3341Xhab+CTUBNDy014hNUdkYCT8tEz3hHRxmY9sJu
         PvulQw0KL3dd2HTNlNslnxfME8aRly16f6+n6GKpTWW9uTTJ1kCd4mM6aQK+wXfqXMad
         oIAQ==
X-Gm-Message-State: ACrzQf20VTt6fMO149VHxGBbN5zSEsNZYED1d/SB9edLmOVxCJGitzSL
        facCOUWuf6lWti1r8Mo72t/2/BFBjuqQOw==
X-Google-Smtp-Source: AMsMyM7zPNXnmRs8NYV1E3TeSajHDW08Hlher0ba1rh+yReBxXNzmneAQoYvABbuaFVQTx08dS/qwQ==
X-Received: by 2002:ad4:5bcc:0:b0:4b4:5029:8dd5 with SMTP id t12-20020ad45bcc000000b004b450298dd5mr1201731qvt.80.1665476000065;
        Tue, 11 Oct 2022 01:13:20 -0700 (PDT)
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com. [209.85.219.175])
        by smtp.gmail.com with ESMTPSA id r22-20020ae9d616000000b006ed30a8fb21sm4459671qkk.76.2022.10.11.01.13.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Oct 2022 01:13:19 -0700 (PDT)
Received: by mail-yb1-f175.google.com with SMTP id b145so15663660yba.0;
        Tue, 11 Oct 2022 01:13:18 -0700 (PDT)
X-Received: by 2002:a5b:506:0:b0:6af:ffac:4459 with SMTP id
 o6-20020a5b0506000000b006afffac4459mr20208800ybp.365.1665475998283; Tue, 11
 Oct 2022 01:13:18 -0700 (PDT)
MIME-Version: 1.0
References: <20221009230044.10961-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20221009230044.10961-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <Y0PBdDtFzcsmbtMv@shikoro> <CA+V-a8sOxyQj8J06kqnRN5G=L6KPdusJ-qLWntVa8kgFBh-MEQ@mail.gmail.com>
 <CAMuHMdXoDmwNnYNt6mVnHNYoNQY5fN207iyR_TopOsux6RKhnA@mail.gmail.com> <CA+V-a8sN6twzEHmMcK9Cnnjciqz0O2tDYEhDVz0QEMCrqHQLNA@mail.gmail.com>
In-Reply-To: <CA+V-a8sN6twzEHmMcK9Cnnjciqz0O2tDYEhDVz0QEMCrqHQLNA@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 11 Oct 2022 10:13:06 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWqm36JWKExZHZMKTQ6Bu6oFPMWux99JrO6wepBXGgYqA@mail.gmail.com>
Message-ID: <CAMuHMdWqm36JWKExZHZMKTQ6Bu6oFPMWux99JrO6wepBXGgYqA@mail.gmail.com>
Subject: Re: [PATCH 1/5] arm64: dts: renesas: rzg2l-smarc-som: Drop enabling WDT2
To:     "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Cc:     Wolfram Sang <wsa@kernel.org>, Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
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

On Tue, Oct 11, 2022 at 9:51 AM Lad, Prabhakar
<prabhakar.csengg@gmail.com> wrote:
> On Tue, Oct 11, 2022 at 8:39 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > On Mon, Oct 10, 2022 at 10:01 PM Lad, Prabhakar
> > <prabhakar.csengg@gmail.com> wrote:
> > > On Mon, Oct 10, 2022 at 7:53 AM Wolfram Sang <wsa@kernel.org> wrote:
> > > > On Mon, Oct 10, 2022 at 12:00:40AM +0100, Prabhakar wrote:
> > > > > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > > >
> > > > > WDT CH2 is specifically to check the operation of Cortex-M33 CPU and if
> > > > > used from CA55 CPU would result in an unexpected behaviour. Hence drop
> > > > > enabling WDT2.
> > > > >
> > > > > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > >
> > > > Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> > > >
> > > > I'd squash patches 1+2, but that's minor.
> > > >
> > > OK, I'll wait for Geert before sending a v2.
> >
> > I'd even squash the whole series into a single patch
> > "arm64: dts: renesas: rzg2l: Drop WDT2 node".
> >
> OK.
>
> > If that would be the only change for v2, I can take care of that while
> > applying.
> >
> Thanks for taking care of it.

OK.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-devel for v6.2.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
