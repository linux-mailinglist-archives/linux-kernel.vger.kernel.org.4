Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A42666E36BA
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Apr 2023 11:44:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230292AbjDPJn4 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 16 Apr 2023 05:43:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230221AbjDPJnx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 05:43:53 -0400
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C95482709;
        Sun, 16 Apr 2023 02:43:51 -0700 (PDT)
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-54f6a796bd0so276730477b3.12;
        Sun, 16 Apr 2023 02:43:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681638231; x=1684230231;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eGZ8vTVUDzMj6tlghPjPrAsFRulY7ZaPrM9DcatIBAM=;
        b=g4liQ7U2AS0j0zlN9uek2QeiaJnNujlSfyDCbAaWE6Oy2UImehFg8sMgq3+am1rtxV
         8ibSaQ6wZxRWM+oph97Dlt7bO1Mxj49TnHKHDOebAMTGeDB5N1XFFfjuSHpf2TXbifE5
         FXCy/Cz7KET4VUjQ68WU8T7fJDqUGCTgw2EYd8wcK9BU7wjXp0mJ/Sb6rkwYUm+xdwuh
         H9w2RujNvIV+MHgmHwDsLme1Y1OCwsMa+uBo7eOX9BAKBwNA8in6K1XPNMW5V85OPi8b
         YhKLbC5pIFJOwD4zLKYKBJzyoWJ7B7xxm9c9UosChM5fK467c5dkN0H3Mj1ZcU4yKcSM
         3XWA==
X-Gm-Message-State: AAQBX9cpKltK6WzipALtK3mAaoNrqhQNCSoej95XSEvj6o/IIQmwQZlf
        B/EQvXxRT5f0p1YfJ5IuxWZSB7nkie6FwA==
X-Google-Smtp-Source: AKy350aohQNyiNHBnwR/yyAnqjMGsCSEh5XnEj0ec37xOCvPwMmeI4CaoEzz8PGsqL/xiE1A8DgY3g==
X-Received: by 2002:a81:60d5:0:b0:54f:e4d8:f4a6 with SMTP id u204-20020a8160d5000000b0054fe4d8f4a6mr6959730ywb.42.1681638230771;
        Sun, 16 Apr 2023 02:43:50 -0700 (PDT)
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com. [209.85.128.180])
        by smtp.gmail.com with ESMTPSA id e199-20020a811ed0000000b005463c7417c6sm2402300ywe.8.2023.04.16.02.43.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Apr 2023 02:43:50 -0700 (PDT)
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-54fe82d8bf5so77585127b3.3;
        Sun, 16 Apr 2023 02:43:49 -0700 (PDT)
X-Received: by 2002:a81:b65b:0:b0:54f:dc41:8edf with SMTP id
 h27-20020a81b65b000000b0054fdc418edfmr6862753ywk.2.1681638229566; Sun, 16 Apr
 2023 02:43:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230410011325.26850-1-rdunlap@infradead.org> <099028386d683dcc585693d85b6b2739952fcdeb.camel@sipsolutions.net>
 <ZDuTotxqsrysNaYu@infradead.org>
In-Reply-To: <ZDuTotxqsrysNaYu@infradead.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Sun, 16 Apr 2023 11:43:38 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXRezGfUE4OOc3OjSmP6sS7oQXEd5QnC-G+d+Hv9uVz9Q@mail.gmail.com>
Message-ID: <CAMuHMdXRezGfUE4OOc3OjSmP6sS7oQXEd5QnC-G+d+Hv9uVz9Q@mail.gmail.com>
Subject: Re: [PATCH v3] UML: pata_cs5536: fix build for X86_32 UML with TRACEPOINTS
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org, Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        linux-ide@vger.kernel.org, linux-um@lists.infradead.org
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

Hi Christoph,

On Sun, Apr 16, 2023 at 8:20 AM Christoph Hellwig <hch@infradead.org> wrote:
> On Fri, Apr 14, 2023 at 03:55:07PM +0200, Johannes Berg wrote:
> > On Sun, 2023-04-09 at 18:13 -0700, Randy Dunlap wrote:
> > > Current build of pata_cs5536 for i386 UML fails with:
> > >
> > > ERROR: modpost: "__tracepoint_write_msr" [drivers/ata/pata_cs5536.ko] undefined!
> > > ERROR: modpost: "do_trace_write_msr" [drivers/ata/pata_cs5536.ko] undefined!
> > > ERROR: modpost: "__tracepoint_read_msr" [drivers/ata/pata_cs5536.ko] undefined!
> > > ERROR: modpost: "do_trace_read_msr" [drivers/ata/pata_cs5536.ko] undefined!
> > >
> > > Add the arch/x86/lib/msr.o binary to resolve these undefined symbols.
> > >
> >
> > Hm. Does this make sense? I can't see it'd work on UML to configure an
> > IDE device through MSRs? Surely that can't work? IOW, that entire driver
> > can't really work anyway can it?
> >
> > OTOH, maybe theoretically it could work in PCI, just not with MSRs, and
> > then this patch makes some sense?
>
> I think it is is integrated into actual Geode SOCs.  That being
> said something like the patch below seems as simple as it gets and
> at least gives build coverage on uml

CS5536 is the Geode Companion Device, i.e. the South Bridge, which
can be used with other devices, AFAIK.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
