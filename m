Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7F9072610A
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 15:19:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239588AbjFGNTH convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 7 Jun 2023 09:19:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240468AbjFGNTB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 09:19:01 -0400
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A35B91735;
        Wed,  7 Jun 2023 06:18:59 -0700 (PDT)
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-568af2f6454so74619037b3.1;
        Wed, 07 Jun 2023 06:18:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686143938; x=1688735938;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2EhyJ5aZEtTnnCQG4rmoDuT6EFvmS86Dv0UQ+RFBMuE=;
        b=SAScDh5r0dh8iMwRSagqIRt2ywLqilE0PtCEjgUuuoeq7PGSsWTltSExfyFRpft+o1
         uNf1Wjai+FyEMShvx691kWuZ6MpktxFlrJV3nEUSPRVrVJedC7m+jVM/nK+eqeKZzEzF
         a7Pg14VIfvi+SKzAWHpFm8PYlyoYAw/Wr8UvVkafA00pvOnrO2x3Fo+Xkjrve5pO16lO
         4L60RwTco8trqEE9AKl9/cw1e9954CbMEi/8Q7J0C0H2sxJ7DP3P/AzbQilB1ynb3rnZ
         l1zsNa/SUV9deCnWHZcy7l/4i8ufBfwU/8Dgo9LcSClZMaKIW7o1VULOaPHNb5L8xQhz
         Nx4Q==
X-Gm-Message-State: AC+VfDyow40sHnN8r+ZvIlSC6vuc02OA8F+G2/FGLG9SBNWd7LgPAby/
        8FloYXw2qqAVGvdFmM9NgJfTopciNxHT+A==
X-Google-Smtp-Source: ACHHUZ4SW1QtIWNj8cpsnMXrzh/ejwSW8pzEsXCMHAT/lbdOg13aurJzYD782Gnv9wiMTgWj+Ipeog==
X-Received: by 2002:a0d:cb89:0:b0:55a:985e:8ac9 with SMTP id n131-20020a0dcb89000000b0055a985e8ac9mr6038210ywd.22.1686143937932;
        Wed, 07 Jun 2023 06:18:57 -0700 (PDT)
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com. [209.85.219.169])
        by smtp.gmail.com with ESMTPSA id w140-20020a814992000000b0054f8b201c70sm4731924ywa.108.2023.06.07.06.18.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jun 2023 06:18:56 -0700 (PDT)
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-ba82059ef0bso7960647276.1;
        Wed, 07 Jun 2023 06:18:56 -0700 (PDT)
X-Received: by 2002:a25:baca:0:b0:bb3:8945:d236 with SMTP id
 a10-20020a25baca000000b00bb38945d236mr5397442ybk.53.1686143936338; Wed, 07
 Jun 2023 06:18:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230530112050.5635-1-aford173@gmail.com> <20230530112050.5635-2-aford173@gmail.com>
In-Reply-To: <20230530112050.5635-2-aford173@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 7 Jun 2023 15:18:44 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWVwJVAtcCD019-QxHe9UXf7JKe4T2x2=kvHbPoJ=aDtQ@mail.gmail.com>
Message-ID: <CAMuHMdWVwJVAtcCD019-QxHe9UXf7JKe4T2x2=kvHbPoJ=aDtQ@mail.gmail.com>
Subject: Re: [RFC 2/3] clk: renesas: r8a7741a: Add 3dge and ZG support
To:     Adam Ford <aford173@gmail.com>
Cc:     linux-renesas-soc@vger.kernel.org, biju.das.jz@bp.renesas.com,
        marek.vasut+renesas@gmail.com, cstevens@beaconembedded.com,
        aford@beaconembedded.com, Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 30, 2023 at 1:21 PM Adam Ford <aford173@gmail.com> wrote:
> The 3dge and ZG clocks are necessary to support the 3D graphics.
>
> Signed-off-by: Adam Ford <aford173@gmail.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
