Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 962F562815D
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 14:33:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236520AbiKNNdy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 08:33:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235560AbiKNNdv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 08:33:51 -0500
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D85ECD8;
        Mon, 14 Nov 2022 05:33:51 -0800 (PST)
Received: by mail-qt1-f176.google.com with SMTP id cg5so6699167qtb.12;
        Mon, 14 Nov 2022 05:33:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1K/wuMBtmfV3gngJ5qtvyvpnfAjWydRqLmTe3lIS7S8=;
        b=IdANzP57iWzICsvJI92LTL/urEpvQK4GuADfaS5MtfjSuhXWVi4yRYXTAf0vxEv6em
         jGYs4ZnVtsuL86NikVs2AiEI7EfbkJmlnuSEi1LMKdJwlBwJfk54q+O8vOHaRc8Xdjmn
         dd7Sar2Rp+mIBes0Rbc3xQEUBo5kfpljJaXK0Lckk2YIVGhJtgA/KIXbngpp4TqZnaTu
         5r7zw993um0NjMr2gULPqHIUeSm0CLVlqr3K+p9Rq24X/Ti8TJWpErQTEICVbRKuJjHL
         ys3MiCVCfdMs0tZEBdDlwU9Qh70zfZftqb1HvJc/Q4YY4k5D/whR8cOST5hrl+DQ2yF6
         QoMQ==
X-Gm-Message-State: ANoB5pn9BS1HjtyWWgWzQKshDr4b9qu4dq2CRF/gD4Q5F2ln2ZQwRG9j
        l9k3Nh9Yp0QgLgXD2QunCrSCIn4qOqGKDQ==
X-Google-Smtp-Source: AA0mqf6csCsBmTaEFyC3aPDjKb6/ISphKzgLVaUtaIefJT76E4ZMPlWNYmPPNGkN+OzU4kyzg7ZgIQ==
X-Received: by 2002:ac8:4445:0:b0:3a5:2c7c:c915 with SMTP id m5-20020ac84445000000b003a52c7cc915mr12369558qtn.499.1668432830094;
        Mon, 14 Nov 2022 05:33:50 -0800 (PST)
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com. [209.85.219.171])
        by smtp.gmail.com with ESMTPSA id 188-20020a370bc5000000b006bbc09af9f5sm6331435qkl.101.2022.11.14.05.33.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Nov 2022 05:33:49 -0800 (PST)
Received: by mail-yb1-f171.google.com with SMTP id f201so12199629yba.12;
        Mon, 14 Nov 2022 05:33:49 -0800 (PST)
X-Received: by 2002:a25:ba4c:0:b0:6dc:dc81:aaf4 with SMTP id
 z12-20020a25ba4c000000b006dcdc81aaf4mr11261269ybj.365.1668432829380; Mon, 14
 Nov 2022 05:33:49 -0800 (PST)
MIME-Version: 1.0
References: <20221114111513.1436165-1-herve.codina@bootlin.com> <20221114111513.1436165-2-herve.codina@bootlin.com>
In-Reply-To: <20221114111513.1436165-2-herve.codina@bootlin.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 14 Nov 2022 14:33:37 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWQD8pXLpuFH3O4_odUpPu3sZXpoHxkS=qopXit3OQVrA@mail.gmail.com>
Message-ID: <CAMuHMdWQD8pXLpuFH3O4_odUpPu3sZXpoHxkS=qopXit3OQVrA@mail.gmail.com>
Subject: Re: [PATCH v2 1/7] soc: renesas: r9a06g032-sysctrl: Export function
 to get the usb role
To:     Herve Codina <herve.codina@bootlin.com>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        Gareth Williams <gareth.williams.jx@renesas.com>,
        linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 14, 2022 at 12:15 PM Herve Codina <herve.codina@bootlin.com> wrote:
> The usb role retrieved is determined from the CFG_USB[H2MODE]
> value. The CFG_USB register is located within the system
> controller.
>
> We need a helper to get the usb role based on H2MODE value from
> the CFG_USB register without syscon.
>
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
