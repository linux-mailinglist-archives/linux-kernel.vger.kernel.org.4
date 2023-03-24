Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C2B16C79B4
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 09:26:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231569AbjCXI0k convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 24 Mar 2023 04:26:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231127AbjCXI0h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 04:26:37 -0400
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8EB2252BD
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 01:26:36 -0700 (PDT)
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-5416b0ab0ecso20540137b3.6
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 01:26:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679646396;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=45SbY74W6cAx8TBdsxbYd/fwuLq1btWb/YBacEQlBno=;
        b=zeqcr3vIyqq/FZ5KfgSRCPaZnGYnLEX+jVBMGhVrQlHTjQy1R8qm3ezKdRMhFV9SLE
         +1hgLckh7ajS7m7iJwnY74kjaaiLap66+m3dtU2rTLDDwvYWQlgwITX//PQ4deoQ4CkJ
         Afe23r7JNh2uTz1DT9zBoLBFOO0+oR7Msyc19GIapzDbyYMpKYhdShFEGj/309XNTSDi
         zxjfH05JNHQwZBaaoaDCVpbgTDg9rEcZGq9AuEHwkHVV9hVhD5Ht2tHLhXanKR1axCLC
         bi+U3wG2SWKOrhY0J8L52PJCZETvpq5w3YmkWtvzeJPgNBaAdwk6P3V1WQSEvR5j4c1k
         wKbQ==
X-Gm-Message-State: AAQBX9fH73Qbpa0NJlsiHQQrgEYHp92BavlqnZHx8qoq0/hRgkywP3KA
        am7wIwccX0NkUUJ03t2naXWjlDrrfD+uSg==
X-Google-Smtp-Source: AKy350aRfcqpRRmTFVyD4RbpeIfo+IeHE4+Qo9TByWC5P2EyzxvGSKp1fMyyQ6nnyNQrINiJgJ9fnw==
X-Received: by 2002:a81:b409:0:b0:538:49a4:b166 with SMTP id h9-20020a81b409000000b0053849a4b166mr1546888ywi.11.1679646396006;
        Fri, 24 Mar 2023 01:26:36 -0700 (PDT)
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com. [209.85.219.173])
        by smtp.gmail.com with ESMTPSA id i21-20020a81be15000000b00545a0818479sm294448ywn.9.2023.03.24.01.26.35
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Mar 2023 01:26:35 -0700 (PDT)
Received: by mail-yb1-f173.google.com with SMTP id p15so1228308ybl.9
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 01:26:35 -0700 (PDT)
X-Received: by 2002:a05:6902:10c2:b0:b6e:b924:b96f with SMTP id
 w2-20020a05690210c200b00b6eb924b96fmr1607389ybu.3.1679646395243; Fri, 24 Mar
 2023 01:26:35 -0700 (PDT)
MIME-Version: 1.0
References: <5b7c473247d66776343d82a55b9815195b1b11fb.1679551394.git.fthain@linux-m68k.org>
 <mvmttybx3ng.fsf@linux-m68k.org> <CAMuHMdUQ3+OUKZ-6DqcJfMgq8_90Cejzc=onhUmbaYTWJkZHRw@mail.gmail.com>
 <c882ca59-e75d-7ca2-d63f-70aab1b46ade@linux-m68k.org>
In-Reply-To: <c882ca59-e75d-7ca2-d63f-70aab1b46ade@linux-m68k.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 24 Mar 2023 09:26:23 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVSvPk8wYZKVKX_xW_VSHu2qMoX-N4ePRJHejw2nh9JKg@mail.gmail.com>
Message-ID: <CAMuHMdVSvPk8wYZKVKX_xW_VSHu2qMoX-N4ePRJHejw2nh9JKg@mail.gmail.com>
Subject: Re: [PATCH v2] nubus: Don't list card resources by default
To:     Finn Thain <fthain@linux-m68k.org>
Cc:     Andreas Schwab <schwab@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=0.5 required=5.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Finn,

On Fri, Mar 24, 2023 at 1:05 AM Finn Thain <fthain@linux-m68k.org> wrote:
> On Thu, 23 Mar 2023, Geert Uytterhoeven wrote:
> > On Thu, Mar 23, 2023 at 9:39 AM Andreas Schwab <schwab@linux-m68k.org> wrote:
> > > On Mär 23 2023, Finn Thain wrote:
> > > > Checkpatch says "externs should be avoided in .c files" and if this one
> > > > appeared twice I would agree. But as it only appears once, I can't see
> > > > any advantage to putting it in a new .h file instead of the .c file...
> > >
> > > Anything wrong with declaring it in <linux/nubus.h>?
> >
> > It's not meant for NuBus device drivers (at least in its current form).
> > So a drivers/nubus/nubus.h would be the most logical place.
>
> I think Andreas is right inasmuchas the existing prototypes shared between
> drivers/nubus/nubus.c and drivers/nubus/proc.c are found there, and this
> extern is another one of those.
>
> But I take Geert's point that much of include/linux/nubus.h could be moved
> to drivers/nubus/something.h. But is there anything to be gained from
> splitting it up that way?

Splitting it would prevent NuBus device drivers from messing with
internal NuBus variables they're not intended to access.
But I agree that's not a big concern...

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
