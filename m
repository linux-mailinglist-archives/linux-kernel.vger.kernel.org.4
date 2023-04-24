Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A67776ED568
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 21:37:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232447AbjDXThR convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 24 Apr 2023 15:37:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229798AbjDXThP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 15:37:15 -0400
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50CFF5596;
        Mon, 24 Apr 2023 12:37:14 -0700 (PDT)
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-b992e28c141so5884936276.0;
        Mon, 24 Apr 2023 12:37:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682365033; x=1684957033;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GZol4aEZCkmHs4ejc2LNc9FEqv9LZk1pju+lVxytN+s=;
        b=lc5vN4yo0zDeUasfcdRjFaKNyWBieWqeNOmep5frIrHqynr/QwiL4ATDE0Aq5LI3cX
         zQzXTPp7Eh6cPxgag6XbKHzaM+9qLh+5cfwgVCbPZVog+RGwmAZL/3bp9kCHi772YfcY
         nBPZ73tOBmvxlPIqZtoReaehpRyC9fnlr3R2Ymshhz7wVjBxpynE8a1QuuMXbQbl1O56
         NFo4Ih8EOtvEdD2S2nhJeR5Isuuh2JvUALtcO0EiEyGgMmN3NMgFUesixxeaHr4LS3+d
         ktYSRkIfNbh8iJWIkveEEXuZQ52J96Qpc62c307DonOeuP24xGz0lTEIQVy5JB7U+kyq
         vIYg==
X-Gm-Message-State: AC+VfDyFp1RjYo45KgYPZwH2qTcaonvoIUkg3M4uzk9cNpCD6BC3C5ZA
        OP1ioJfKedGOnL0ROBkC0MA2Ph3O9bQyhw==
X-Google-Smtp-Source: ACHHUZ4xNY++x32fGVy8DGJyETJvQ/ZYNHqro/Tk08jYihjXy/cx7a+sJ4ampNDx4gjUjUMnAt7WyQ==
X-Received: by 2002:a25:5344:0:b0:b99:9c3d:7d22 with SMTP id h65-20020a255344000000b00b999c3d7d22mr2555846ybb.27.1682365033136;
        Mon, 24 Apr 2023 12:37:13 -0700 (PDT)
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com. [209.85.128.172])
        by smtp.gmail.com with ESMTPSA id u44-20020a25ab2f000000b00b999ed81794sm803519ybi.0.2023.04.24.12.37.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Apr 2023 12:37:12 -0700 (PDT)
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-54fc6949475so54805787b3.3;
        Mon, 24 Apr 2023 12:37:12 -0700 (PDT)
X-Received: by 2002:a81:488e:0:b0:552:f3d5:c156 with SMTP id
 v136-20020a81488e000000b00552f3d5c156mr8701161ywa.13.1682365032620; Mon, 24
 Apr 2023 12:37:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230307163041.3815-1-wsa+renesas@sang-engineering.com>
 <20230307163041.3815-6-wsa+renesas@sang-engineering.com> <CAMuHMdVQiMbupkCYhZ86WHND25E==iA1DyVwGf2rg32zJLcV2g@mail.gmail.com>
 <ZEbVyhjKs15Rj+5h@sai>
In-Reply-To: <ZEbVyhjKs15Rj+5h@sai>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 24 Apr 2023 21:37:00 +0200
X-Gmail-Original-Message-ID: <CAMuHMdW9F4adqsWj7BpvTSGMamPdM-OM+oY_nM0-xTMnuaFr-A@mail.gmail.com>
Message-ID: <CAMuHMdW9F4adqsWj7BpvTSGMamPdM-OM+oY_nM0-xTMnuaFr-A@mail.gmail.com>
Subject: Re: [PATCH 05/11] media: renesas: fdp1: remove R-Car H3 ES1.* handling
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-renesas-soc@vger.kernel.org,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
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

Hi Wolfram,

On Mon, Apr 24, 2023 at 9:17 PM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
> > > -#define FD1_IP_H3_ES1                  0x02010101
>
> ...
>
> > Apparently 0x02010101 is also used on (at least) R-Car M2-W ES1.0,
> > causing the following annoying (but further harmless?) messages
> > during boot:
> >
> >     rcar_fdp1 fe940000.fdp1: FDP1 Unidentifiable (0x02010101)
> >     rcar_fdp1 fe944000.fdp1: FDP1 Unidentifiable (0x02010101)
>
> Hmm, that means before my removal patch, Gen2 has been incorrectly
> defined as H3 ES1?

Indeed, but the driver doesn't seem to do anything with the detected
version, except for printing a debug or error message.

> > Note that the R-Car Gen2 documentation states the register's contents
> > are all zeroes.  But that value would trigger the error message, too.
>
> Bad, but well...
>
> > Sorry for not noticing before. Apparently I never booted a kernel
> > with this patch on koelsch...
>
> We could re-add this version and just let it print "FDP1 Initial
> Version" or something? I could test this on my Lager board.

I plan to test it on a few other boards, too...
Just wanted to let you know ASAP...

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
