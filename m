Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 095C669DD84
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 11:03:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234105AbjBUKDb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 05:03:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233236AbjBUKD3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 05:03:29 -0500
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89DBCAD2C
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 02:03:27 -0800 (PST)
Received: by mail-qt1-f174.google.com with SMTP id h19so1057349qtk.7
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 02:03:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8IkLkYW3Mrz4W4E6CahA4nVgDfr/jjbUUP9owXsZ0sQ=;
        b=dQDSba9616M4Jg0F4wduILT+SPTnV74M79S0iglzJVpgOpz0WEKv6/65dI6sPQrQ/E
         851rJnVSqzUh81g5bnoexzUGwPdzGWdN3eGk2AUWb0zM26d4w3FOVdekDpEB18tAs2sz
         +LNnM6dR8EOUymnVqrFPhwSeYo0/kz5PmkFEBVF7yMEPtci2W7qeMZGZ17FhISOj2B53
         0yZx3iroDm9fAae+hFmV54tMA4BpWr3PklNTJYqZxR/54HY3Fcm5MNRptAXNskIkKeTq
         VNIO3zfO6MttmMZkjWF/3hDD4aewTpmI44DvlqY2oBCtxAaAsdUwVJ+GqiBbfS/yRFWy
         LSBA==
X-Gm-Message-State: AO0yUKV9El7B5wlSev4TVUgn57kiT18H4QKuNa0osGkzdZOqIft/V/sR
        o0VOIDu4nmg7BJMo3s+XXt+xa2UnK/M00w==
X-Google-Smtp-Source: AK7set+QrKQeEW6csqqCSxAqijGPDFkARU0piSpDpXZg7CstSE7agy9owfJUyJ8nUgey13/Zc0dHvg==
X-Received: by 2002:a05:622a:1793:b0:3bd:1a07:2086 with SMTP id s19-20020a05622a179300b003bd1a072086mr6290608qtk.36.1676973806317;
        Tue, 21 Feb 2023 02:03:26 -0800 (PST)
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com. [209.85.219.178])
        by smtp.gmail.com with ESMTPSA id 16-20020ac85950000000b003b82489d8acsm1751245qtz.21.2023.02.21.02.03.25
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Feb 2023 02:03:26 -0800 (PST)
Received: by mail-yb1-f178.google.com with SMTP id cf8so3791023ybb.11
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 02:03:25 -0800 (PST)
X-Received: by 2002:a25:e206:0:b0:95b:7778:5158 with SMTP id
 h6-20020a25e206000000b0095b77785158mr440109ybe.12.1676973805392; Tue, 21 Feb
 2023 02:03:25 -0800 (PST)
MIME-Version: 1.0
References: <20230221060723.26291-1-bhe@redhat.com> <20230221060723.26291-3-bhe@redhat.com>
In-Reply-To: <20230221060723.26291-3-bhe@redhat.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 21 Feb 2023 11:03:14 +0100
X-Gmail-Original-Message-ID: <CAMuHMdV4efVX8X1KoLJ-3pmzsxnU6TODw3b_37ZK771rfrqi7A@mail.gmail.com>
Message-ID: <CAMuHMdV4efVX8X1KoLJ-3pmzsxnU6TODw3b_37ZK771rfrqi7A@mail.gmail.com>
Subject: Re: [RFC PATCH 2/2] arch/*/io.h: remove ioremap_uc in some architectures
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org, arnd@arndb.de,
        hch@infradead.org, mcgrof@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Baoquan,

Thanks for your patch!

On Tue, Feb 21, 2023 at 7:36 AM Baoquan He <bhe@redhat.com> wrote:
> ioremap_uc() is only meaningful on old x86-32 systems with the PAT
> extension, and on ia64 with its slightly unconventional ioremap()
> behavior, everywhere else this is the same as ioremap() anyway.
>
> So here, remove the ioremap_uc() definition in architecutures other
> than x86 and ia64. These architectures all have asm-generic/io.h
> included and will have the default ioremap_uc() definition which
> returns NULL. If any ARCH really needs a specific ioremap_uc() for

Please make it very clear that this changes existing behavior.
At first, I had completely missed that.

And of course the documentation should be updated to reflect that.

> its own usage, one ioremap_uc() can be added in the ARH.

s/ARH/ARCH/

>  arch/m68k/include/asm/kmap.h   | 1 -

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
