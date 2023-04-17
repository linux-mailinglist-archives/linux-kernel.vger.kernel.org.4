Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CF8B6E40EE
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 09:30:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230296AbjDQHaH convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 17 Apr 2023 03:30:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230422AbjDQH3i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 03:29:38 -0400
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5F9440C8
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 00:29:20 -0700 (PDT)
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-54fc337a650so156662937b3.4
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 00:29:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681716560; x=1684308560;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1iD+IdtmQpICkgSYBVB1p70CyjZ1NhTQA9JDwcbh810=;
        b=FAYExQTm9fmSeyYEGmINyt8CSbP7Bc9KWzrKO19P+4iH2jyp/hg8RQty9A3CsEbSAF
         T5yW09Fi6QzsX0Wi2IKYESeFqjtGps8cPPMrexym3lyVE1n2cQJPjr8fZ3ZqO9H1sI1/
         4PcbiEbndT/EN1rAgrqRbNz0whdgQGIso3zfrK3E6w6UjBoUgrx7LMJWQTuvDBAUTZFX
         +PdfxWHMIsPIXigtM+rmmSGuNJkkm1Iiyp2Cep1YOKPxB1bnhrAO6t2paxoVNPOIDnSV
         2oOmclYLwJxgFOMZKTaYFbiYkcNXdfYYX484ybX1b3q68XxLqMKhbcIb2YZUiGhNi67E
         0h2w==
X-Gm-Message-State: AAQBX9eGXaVpSpwGRxkMKdvAZ9yLeergB2PMiQGRodeJ/RBCiF6dvTaY
        nqTLdPeOgWFE/Ccp+O6zrfkOw4yYYWk5gQ==
X-Google-Smtp-Source: AKy350YKhXzaEweaNCSWVstZEVRv5bNMSC5dcBsZ5TeMyAisuBUny1vC/wrZ2zvBs59SHy8bIF8kFg==
X-Received: by 2002:a0d:c9c6:0:b0:541:6d79:9291 with SMTP id l189-20020a0dc9c6000000b005416d799291mr12841908ywd.43.1681716559968;
        Mon, 17 Apr 2023 00:29:19 -0700 (PDT)
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com. [209.85.219.174])
        by smtp.gmail.com with ESMTPSA id 68-20020a810b47000000b00545a0818495sm2997274ywl.37.2023.04.17.00.29.19
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Apr 2023 00:29:19 -0700 (PDT)
Received: by mail-yb1-f174.google.com with SMTP id u13so24896953ybu.5
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 00:29:19 -0700 (PDT)
X-Received: by 2002:a25:d8d7:0:b0:b92:2c78:1481 with SMTP id
 p206-20020a25d8d7000000b00b922c781481mr4583239ybg.12.1681716559170; Mon, 17
 Apr 2023 00:29:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230412183834.3769519-1-j.neuschaefer@gmx.net>
 <20230412183834.3769519-2-j.neuschaefer@gmx.net> <CAMuHMdVUC9n8vQYq+5tXX1jVPSnhyKoMAcB0dd6GFMXA=Apobw@mail.gmail.com>
In-Reply-To: <CAMuHMdVUC9n8vQYq+5tXX1jVPSnhyKoMAcB0dd6GFMXA=Apobw@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 17 Apr 2023 09:29:08 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUjThNaANe1zG_JiqE1AdvwM-SDsyvY1m5R29CFZLjU4A@mail.gmail.com>
Message-ID: <CAMuHMdUjThNaANe1zG_JiqE1AdvwM-SDsyvY1m5R29CFZLjU4A@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] soc: nuvoton: Add "select REGMAP" to WPCM450 SoC driver
To:     =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Cc:     openbmc@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Joel Stanley <joel@jms.id.au>,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        Arnd Bergmann <arnd@arndb.de>
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

On Mon, Apr 17, 2023 at 9:26 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> On Wed, Apr 12, 2023 at 8:38 PM Jonathan Neuschäfer
> <j.neuschaefer@gmx.net> wrote:
> > Select CONFIG_REGMAP from CONFIG_WPCM450_SOC, because the driver relies
> > on regmap to work.
> >
> > Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> > Link: https://lore.kernel.org/lkml/CAMuHMdWo5vHCeE6BeSHrUy12uT7_wFhW-VbQmQ5u+4Q8c7-wYQ@mail.gmail.com/
> > Fixes: 77b8c67b5637 ("soc: nuvoton: Add SoC info driver for WPCM450")

This reference is wrong, it should be 7dbb4a38bff3.

> > Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
