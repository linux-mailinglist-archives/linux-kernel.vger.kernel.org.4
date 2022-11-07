Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0067C61F9BD
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 17:29:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231350AbiKGQ3h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 11:29:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232302AbiKGQ3G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 11:29:06 -0500
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39C6AE62;
        Mon,  7 Nov 2022 08:27:27 -0800 (PST)
Received: by mail-qv1-f51.google.com with SMTP id n18so8426545qvt.11;
        Mon, 07 Nov 2022 08:27:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FHuZT/X3Udj945i4AGOq1IWIr+mvd6w8t7fykVu9RG0=;
        b=oGht8EEfTsNU3ERrUE6MMXYWSEqDEQSf24bQxWYP6LQvExnmUFcoLgEaJexB/fExGQ
         z/gJWZgGSSN+RyvEtndhGt5eM532IhgbHNMIUhYcCxuL9z1tQNrRBVenXAs3R0Z3r2ya
         xxb2bDXE4vyBbqi8q6Rau02hYb1bGVDvIvNBLbq4yhk09Eo6KqwwTg+5Gi9nTjjJB6qH
         adMyIIOLQfhlP+6wBC1KG9oDFxoGAhbFwPL7tNd/sBXFnSHJtwsVwj6ZQZUKawi7LXxw
         dImNaGeIoBH7eppqeE2jxMc8bKTzK5HmS/YHprsvEYJYvF/JF5+O0Q2zILaZ+MDGuKLl
         M6mg==
X-Gm-Message-State: ACrzQf1S4eailQk85HXhg+kQR9GSQcJilIIZTF3YJSo9Y3h5NCaGKB06
        Hz4SVhEspw+MUASHs0bagAzJVh+g9CwPWg==
X-Google-Smtp-Source: AMsMyM5qZiogsQgXMx520QV3QS+W55Vw0zB/WEdMC2Q2PMpDB2F/E6xeCXr5Kuksr/86mQW4Ki+LMw==
X-Received: by 2002:a05:6214:d6e:b0:4b9:692d:c486 with SMTP id 14-20020a0562140d6e00b004b9692dc486mr46025955qvs.104.1667838446157;
        Mon, 07 Nov 2022 08:27:26 -0800 (PST)
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com. [209.85.219.177])
        by smtp.gmail.com with ESMTPSA id i15-20020a05622a08cf00b00398313f286dsm6370141qte.40.2022.11.07.08.27.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Nov 2022 08:27:25 -0800 (PST)
Received: by mail-yb1-f177.google.com with SMTP id z192so14297801yba.0;
        Mon, 07 Nov 2022 08:27:25 -0800 (PST)
X-Received: by 2002:a25:6b07:0:b0:6cd:3a43:bfe5 with SMTP id
 g7-20020a256b07000000b006cd3a43bfe5mr37690368ybc.89.1667838445507; Mon, 07
 Nov 2022 08:27:25 -0800 (PST)
MIME-Version: 1.0
References: <20221103205546.24836-1-wsa+renesas@sang-engineering.com> <20221103205546.24836-2-wsa+renesas@sang-engineering.com>
In-Reply-To: <20221103205546.24836-2-wsa+renesas@sang-engineering.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 7 Nov 2022 17:27:14 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVxBEXWHK75tx0jxLOF5fFgcSDdtZZyqLmZ1MJO_Xmjvg@mail.gmail.com>
Message-ID: <CAMuHMdVxBEXWHK75tx0jxLOF5fFgcSDdtZZyqLmZ1MJO_Xmjvg@mail.gmail.com>
Subject: Re: [PATCH 1/4] clk: renesas: r8a779g0: Add TMU and SASYNCRT clocks
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-renesas-soc@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

On Thu, Nov 3, 2022 at 9:55 PM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-clk-for-v6.2.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
