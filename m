Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9A2067CBBB
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 14:14:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236396AbjAZNN7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 08:13:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236409AbjAZNN4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 08:13:56 -0500
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CDDB67784;
        Thu, 26 Jan 2023 05:13:51 -0800 (PST)
Received: by mail-qt1-f171.google.com with SMTP id d3so1150751qte.8;
        Thu, 26 Jan 2023 05:13:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=majz38lMPqk/gVdV/lNxw6X6vrB1y+ZfmrOfKAYhAHM=;
        b=2gE1Yrl4IP4hSu2eZGToinLH6ieMx+FwrkeqYF/PyHlK8Ku0EvvBuZ5uMAUnaoHehL
         Z3prYWxC355348y7jT33bN64VW8DoQqhiJO26h4kVcMEfDf0vKkWGSyu03HRZYj6IFmS
         bq/VlFkAYEFrNajVzDnnlU7OfYXTzojh/mja4rvcWKBhubTi29F5frV82C9NTfciS6v3
         w3sl5PO+dz6hTNphhbiF5YuYd+51V1Wm1qUDwIjngRWttvguKHaT5yquFGHdmz+Ccdhy
         rIQuIrqponvbUL0zCfOBjWAVkkQQew3KlntAiJEynKQfS3Pogoe21GUdfVXsjnFT2+tP
         ukCQ==
X-Gm-Message-State: AFqh2krmJdV7VZpA5YllOz2tcA218svzBasga2LWWLek+2bm0Oh+fuUm
        xcfrf/idY+KGMLusx71mlOfcW/G3ykiPjA==
X-Google-Smtp-Source: AMrXdXsmBLxwrSNBsDoSt59DwK+CsBhZjLH3DwrvKnFIP07VhYl/wpV5juYN41Oj2ADKlOqfXKXdUw==
X-Received: by 2002:a05:622a:428c:b0:3a7:e9dc:699d with SMTP id cr12-20020a05622a428c00b003a7e9dc699dmr41946759qtb.20.1674738830085;
        Thu, 26 Jan 2023 05:13:50 -0800 (PST)
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com. [209.85.128.178])
        by smtp.gmail.com with ESMTPSA id 84-20020a370a57000000b006b61b2cb1d2sm885197qkk.46.2023.01.26.05.13.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Jan 2023 05:13:49 -0800 (PST)
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-4ff07dae50dso22328297b3.2;
        Thu, 26 Jan 2023 05:13:49 -0800 (PST)
X-Received: by 2002:a81:bd6:0:b0:48d:1334:6e38 with SMTP id
 205-20020a810bd6000000b0048d13346e38mr4212916ywl.316.1674738829474; Thu, 26
 Jan 2023 05:13:49 -0800 (PST)
MIME-Version: 1.0
References: <20230118104656.67706-1-wsa+renesas@sang-engineering.com>
 <CAMuHMdXY0c4qKCi057CtJdhUJ+443rtyCjwYyK3qGgwWTZ2a0A@mail.gmail.com> <Y9J2oPHHNQoU+7m7@ninjato>
In-Reply-To: <Y9J2oPHHNQoU+7m7@ninjato>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 26 Jan 2023 14:13:37 +0100
X-Gmail-Original-Message-ID: <CAMuHMdU2HU=-pbaA1vz8HRpyWQPYZ2CmvmsAD2oSXdO_9ZgTKA@mail.gmail.com>
Message-ID: <CAMuHMdU2HU=-pbaA1vz8HRpyWQPYZ2CmvmsAD2oSXdO_9ZgTKA@mail.gmail.com>
Subject: Re: [PATCH v2] memory: renesas-rpc-if: Fix PHYCNT.STRTIM setting
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-renesas-soc@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wolfram,

On Thu, Jan 26, 2023 at 1:48 PM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
> > > +       regmap_update_bits(rpc->regmap, RPCIF_PHYCNT,
> > > +                          /* create mask with all affected bits set */
> > > +                          RPCIF_PHYCNT_STRTIM(BIT(fls(rpc->info->strtim)) - 1),
> >
> > fls(0) = 0, and BIT(-1) is undefined, so this won't work for R-Car
> > H3 ES1.x.  So I'm afraid you cannot handle this without storing the
> > actual mask ;-)
>
> You misread the parens, it is: BIT(0) - 1 = 0

Doh... You're right.

Still, it won't clear the bits on H3 ES1.x.
And when changing strtim to a value smaller than 4, it may not work
as expected, as it doesn't clear the upper bits.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
