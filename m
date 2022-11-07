Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A24B561F9C2
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 17:30:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232212AbiKGQaS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 11:30:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232113AbiKGQ36 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 11:29:58 -0500
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 626C82181F;
        Mon,  7 Nov 2022 08:27:58 -0800 (PST)
Received: by mail-qv1-f51.google.com with SMTP id w10so8446031qvr.3;
        Mon, 07 Nov 2022 08:27:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+pquVRvPM2Ug94AZ4Ogi5augDPbFclTaGPnWcHVEL9Q=;
        b=f4R5P2fUXkghb3/t0YaJS2MJSuVdVKujikc6fpUOp+CJSbv5nwnIgRZ2JqdOoO4t94
         gqGUOkridGo9iccsrVf3tHa+lJaXBZPdO0nxGfAQE+jHbbf5bQurGLTRBYRncc8pRdFZ
         Y1IpIKiAWYCZWACz4XQzumy51X3qvzL8kZBBWXfV8uWZN56gmldhzAqFJ8tCDeMPWFXv
         s6yJzNQ/+zE9PCedZZkyzVqD4pMe7+g6j4DKGZ499dC/FmjRhXGrlBTCazHJuDDGSuCq
         FHLCeI7peeKAvY305lMo5TaG4JSXEaXiJ8XaB23KPSSNHv7yKODuEmjiYtxdrwj9a+tW
         0ymA==
X-Gm-Message-State: ACrzQf1PnsyQcnCQpDf3tsmYcQ47HYq6gmLRL2BdwI2FzjqKzUo4u7vX
        BUVg5HWIhvpHHWKeEMetndpDcoFWOCI9oZTv
X-Google-Smtp-Source: AMsMyM5WvrWsL66G0CIMUEGsaF6r1FpsVCmApSZa+PvVETM4+Pah52npKpxxUF9nb0ZJEBl5oTtOJQ==
X-Received: by 2002:a0c:e2c8:0:b0:4b7:c1bf:784a with SMTP id t8-20020a0ce2c8000000b004b7c1bf784amr46055185qvl.17.1667838477160;
        Mon, 07 Nov 2022 08:27:57 -0800 (PST)
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com. [209.85.219.171])
        by smtp.gmail.com with ESMTPSA id br8-20020a05620a460800b006cf38fd659asm7244778qkb.103.2022.11.07.08.27.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Nov 2022 08:27:56 -0800 (PST)
Received: by mail-yb1-f171.google.com with SMTP id 131so9843312ybl.3;
        Mon, 07 Nov 2022 08:27:56 -0800 (PST)
X-Received: by 2002:a25:6b07:0:b0:6cd:3a43:bfe5 with SMTP id
 g7-20020a256b07000000b006cd3a43bfe5mr37692694ybc.89.1667838476378; Mon, 07
 Nov 2022 08:27:56 -0800 (PST)
MIME-Version: 1.0
References: <20221104151135.4706-1-wsa+renesas@sang-engineering.com> <20221104151135.4706-2-wsa+renesas@sang-engineering.com>
In-Reply-To: <20221104151135.4706-2-wsa+renesas@sang-engineering.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 7 Nov 2022 17:27:45 +0100
X-Gmail-Original-Message-ID: <CAMuHMdU63pCKumPvT0r-iGJBXJ9X9e1E+eu0xcrPG7XD3bUcCA@mail.gmail.com>
Message-ID: <CAMuHMdU63pCKumPvT0r-iGJBXJ9X9e1E+eu0xcrPG7XD3bUcCA@mail.gmail.com>
Subject: Re: [PATCH 1/3] clk: renesas: r8a779g0: Add CMT clocks
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-renesas-soc@vger.kernel.org,
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

On Fri, Nov 4, 2022 at 4:11 PM Wolfram Sang
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
