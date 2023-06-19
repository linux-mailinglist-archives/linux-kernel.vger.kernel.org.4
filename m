Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DDC3734D17
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 10:07:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbjFSIHm convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 19 Jun 2023 04:07:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229994AbjFSIHX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 04:07:23 -0400
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9E271999;
        Mon, 19 Jun 2023 01:07:11 -0700 (PDT)
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-57045429f76so36516217b3.0;
        Mon, 19 Jun 2023 01:07:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687162031; x=1689754031;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Efm64+sITwa/wAHwZhMmjzdTXlRzuCyl8np0SHwPoYs=;
        b=I/3QF5xxnFhL0XgwlO7F9suSYj3M0crT3hPuvB4DpCW99PUfmUZi+b2N96qVA+lqnD
         PyIrHLdaSfYNv3A3vlIKhngzju22nOHaZj5J1KRo3zhOXKqCAFiwJh1EG6vJhSF3wr86
         j5G03w4+MT5MBO4oer4+NVJPkdWSWLVA9WROk77ztB/YK1Od/DcJ3qOLfos2jVQ2gDog
         KZ5Xehro+rWPchrBiQyYwbkoBMc53nMHlqC8F+CZoPOuNwmni17BL0FsnakrndDrRvzb
         Dsm+9dd2HcBMEsvRC9QYyW4epqadUB7e14J9BpnFPox7yKzwlIIxnuDta/JbSx1gDRhG
         Ja9Q==
X-Gm-Message-State: AC+VfDyxwvza9vVywi7er4YocMhLJT5RO+RaNcsBCfCRBbmO/Edfz7+J
        gBIwAYk4N5AvehCzp2oPoed2Epqui96qBw==
X-Google-Smtp-Source: ACHHUZ4a2cOcQf3dwr9QBtdRJi8Rb20pTiYhK++V3f9nkft+MDgCFg83OaGQY2a44g8XPLYWKf2SvA==
X-Received: by 2002:a0d:d808:0:b0:56d:2c9e:6148 with SMTP id a8-20020a0dd808000000b0056d2c9e6148mr9148904ywe.9.1687162030776;
        Mon, 19 Jun 2023 01:07:10 -0700 (PDT)
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com. [209.85.219.180])
        by smtp.gmail.com with ESMTPSA id r73-20020a0de84c000000b0056d1a2455c1sm3267378ywe.38.2023.06.19.01.07.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Jun 2023 01:07:10 -0700 (PDT)
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-bcc29cdcdc9so3369613276.0;
        Mon, 19 Jun 2023 01:07:10 -0700 (PDT)
X-Received: by 2002:a25:aab3:0:b0:bcb:523e:addf with SMTP id
 t48-20020a25aab3000000b00bcb523eaddfmr6043147ybi.65.1687162029972; Mon, 19
 Jun 2023 01:07:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230617150302.38477-1-aford173@gmail.com> <20230617150302.38477-3-aford173@gmail.com>
In-Reply-To: <20230617150302.38477-3-aford173@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 19 Jun 2023 10:06:51 +0200
X-Gmail-Original-Message-ID: <CAMuHMdU2Ab_FbUwrU8WfBk46QDXG+9zw-GtH200z=Bi0PXW91Q@mail.gmail.com>
Message-ID: <CAMuHMdU2Ab_FbUwrU8WfBk46QDXG+9zw-GtH200z=Bi0PXW91Q@mail.gmail.com>
Subject: Re: [PATCH 3/4] clk: renesas: r8a774e1: Add 3dge and ZG support
To:     Adam Ford <aford173@gmail.com>
Cc:     linux-clk@vger.kernel.org, aford@beaconembedded.com,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Sat, Jun 17, 2023 at 5:03 PM Adam Ford <aford173@gmail.com> wrote:
> The 3dge and ZG clocks are necessary to support the 3D graphics.
>
> Signed-off-by: Adam Ford <aford173@gmail.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-clk-for-v6.6.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
