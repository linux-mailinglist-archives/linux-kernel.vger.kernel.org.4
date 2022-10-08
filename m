Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF47D5F8878
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Oct 2022 01:24:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229624AbiJHXYE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Oct 2022 19:24:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiJHXYB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Oct 2022 19:24:01 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF572131
        for <linux-kernel@vger.kernel.org>; Sat,  8 Oct 2022 16:24:00 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id w196so3006349oiw.8
        for <linux-kernel@vger.kernel.org>; Sat, 08 Oct 2022 16:24:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KNh5d7RpT4q5e4cVUbZ7EKIYh1y2ShTgP2W47SsQ5Pk=;
        b=HO3OCYjlz/W3La0rL+GSpPObtGfCHBY0cYVAVgTSQZRfRyGX05rzhItM9bT5oELPyR
         EzT7s44CMZ69M//h9bmszsxTKdU5VB+1wpxGbyDck0xQFAKi3YU1l2ibI2qybEYGzlJq
         p58K79QM/Imd9DBTu3r6wNUnBdMoCTGTbPK0M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KNh5d7RpT4q5e4cVUbZ7EKIYh1y2ShTgP2W47SsQ5Pk=;
        b=uCs6aDOATVUHoZs900FOtzDiD4zfWX/oI6EJ4m76zphC4PXTRR8GspeXjPPzBtw6RM
         yk0Y7plY0ZJcnKPL6m3AGYsByo+4EKN+/LGj+pxy8frFmPZgf5dc+fQbNSXQdApQENLt
         LDk5uAqAL8xQoykTTlAnaNadhqCb3SofOqZFLiTKnByPeNcsLDntf4CYTqc+FABz+mOT
         74vSqdU2Q9x2Q13tp9W7Wy8ZYQOdwejkEeQgt+6pG8K3OxPDn4MFO2kcaYBp//XXskCZ
         S/+ATgOMD39TjtRswaRutogWD8DbWpyZM+ekJh4JKiwOya71on64RYhouccoRkm1msvv
         hiMA==
X-Gm-Message-State: ACrzQf3M/fEegdWO8mG6vuOgkwGRNMOrJOBG7pFuIq3VxSA1CP5q8ljT
        bZwBbnu5jpcb0BfrU5ZDEM/n23eKbDoQzw==
X-Google-Smtp-Source: AMsMyM7wlU8LYaejMLRiTek9BgQnrMlNhcQIqHLZlzQioalpKHyicLNNMJOEgTvjCS9ngI4A76f6vg==
X-Received: by 2002:a05:6808:bd3:b0:350:e312:9abf with SMTP id o19-20020a0568080bd300b00350e3129abfmr10837974oik.78.1665271439019;
        Sat, 08 Oct 2022 16:23:59 -0700 (PDT)
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com. [209.85.160.41])
        by smtp.gmail.com with ESMTPSA id l15-20020a9d550f000000b006393ea22c1csm3107830oth.16.2022.10.08.16.23.58
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 08 Oct 2022 16:23:58 -0700 (PDT)
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-1321a1e94b3so9203731fac.1
        for <linux-kernel@vger.kernel.org>; Sat, 08 Oct 2022 16:23:58 -0700 (PDT)
X-Received: by 2002:a05:6870:c888:b0:12c:7f3b:d67d with SMTP id
 er8-20020a056870c88800b0012c7f3bd67dmr6194479oab.229.1665271437750; Sat, 08
 Oct 2022 16:23:57 -0700 (PDT)
MIME-Version: 1.0
References: <Yz18QA27+gN0oaM3@google.com> <CAHk-=whK-q1W-X0q0f_nBJ9sKyta-DVJhEAS4BF_oKAVAUQ4Jw@mail.gmail.com>
 <Y0AmmR2NfKc/Y7Mb@google.com> <CAHk-=wg=hh8xkPjiySnjAyR66AG64eyZ1Y9gHw+MCs8uuSZReA@mail.gmail.com>
 <Y0HB3K8IRVhX5IvT@smile.fi.intel.com> <CAHk-=wixtjmiENLbc1=Hds3mMSjVRA3ZiwXN7yg8mw_1MCg_QQ@mail.gmail.com>
 <d66fa3ea-1efe-e7da-be80-89507067e2a9@redhat.com>
In-Reply-To: <d66fa3ea-1efe-e7da-be80-89507067e2a9@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 8 Oct 2022 16:23:41 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgF_0+au4cz-ZmH4qOpgDWmmbJC101fh_RVAbsJRH7d-Q@mail.gmail.com>
Message-ID: <CAHk-=wgF_0+au4cz-ZmH4qOpgDWmmbJC101fh_RVAbsJRH7d-Q@mail.gmail.com>
Subject: Re: [GIT PULL] Backlight for v6.1
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lee Jones <lee@kernel.org>, Mark Brown <broonie@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 8, 2022 at 12:59 PM Hans de Goede <hdegoede@redhat.com> wrote:
> >
> > Yeah, I don't expect he driver to work on real hardware,
>
> I'm not sure what you mean here. I guess you mean that you
> do not expect to be able to test the driver on real hw
> yourself?

Well, that too, but I really along the lines of "make it build as a
module when I2C_DESIGNWARE_PLATFORM is a module"

Because if it depends on some symbols from I2C_DESIGNWARE_PLATFORM,
and that one can be a module, then the Intel PMI driver also needs to
be built as a module to just get the build coverage, at least.

And I can imagine that that will not work very well on actual hardware
with some of these core drivers that may want to initialize early?

But I'd love to at least have the build coverage.

                 Linus
