Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72E8E734D0F
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 10:06:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229664AbjFSIGl convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 19 Jun 2023 04:06:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230254AbjFSIGI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 04:06:08 -0400
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0CEA10F2;
        Mon, 19 Jun 2023 01:06:07 -0700 (PDT)
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-45a0ee1c411so645482e0c.0;
        Mon, 19 Jun 2023 01:06:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687161967; x=1689753967;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=utNK9LgaL1L2HZly9sF4v0ujqKTHIGGnCZiurfX8mMo=;
        b=EUpAm2JxigY0y15tdFIyZLqcfT27nv3b5cs8E1jcGi45c+n+Kk6QGpOr+ke4Cbj6Nm
         oO9Rk51Pa2dWdHFyxywURjghT3Se9SyaNjXzdcBcF0P7hFSwv1IXd2Wf/jN+SSG/Wxqi
         2CPZJuJWFpHa7HeZF1qzowbistdLoSXSuUNEtCVIfapT1N6Qu6+B4kgmJ/5BOpH1Jgoz
         eNmtOXs6vrrRZMpHYUJ1NZLzUY6ptLHcWdIXotZp+00EW2EaSTRD8ZdfPktFMc7i7EyL
         jp2iL5jr6RVnhK4fRMc0UADc9FG/jrCVtJmWXbVMcHUc5h5J6Od7JaIxMonZDzXrJAXw
         8YHA==
X-Gm-Message-State: AC+VfDzX3TNrK0/QNOucV/DdJuNCp2XGqCc4Hw9Q2uAC+zrIKffgI4OY
        HITo11cYuXnQdwFWlARR8RmCV+nhW2++6A==
X-Google-Smtp-Source: ACHHUZ6TQ7qfAF0r8ONZExHFGP5W5qb3/O5aGiYjFe21zFB/VBGEKB6TaHmzWHATAFpY7UKdoZd+ng==
X-Received: by 2002:a1f:5f84:0:b0:46f:809d:26a0 with SMTP id t126-20020a1f5f84000000b0046f809d26a0mr988797vkb.11.1687161966626;
        Mon, 19 Jun 2023 01:06:06 -0700 (PDT)
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com. [209.85.222.45])
        by smtp.gmail.com with ESMTPSA id h199-20020a1f9ed0000000b0046e93302213sm1960895vke.24.2023.06.19.01.06.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Jun 2023 01:06:06 -0700 (PDT)
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-783eef15004so503033241.3;
        Mon, 19 Jun 2023 01:06:06 -0700 (PDT)
X-Received: by 2002:a05:6102:135a:b0:440:aa84:631c with SMTP id
 j26-20020a056102135a00b00440aa84631cmr500238vsl.10.1687161965876; Mon, 19 Jun
 2023 01:06:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230617150302.38477-1-aford173@gmail.com> <20230617150302.38477-2-aford173@gmail.com>
In-Reply-To: <20230617150302.38477-2-aford173@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 19 Jun 2023 10:05:51 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUS26rEBnSB-OnTgn1F66k37xstxdqiNn7Ti6tzjhZsGA@mail.gmail.com>
Message-ID: <CAMuHMdUS26rEBnSB-OnTgn1F66k37xstxdqiNn7Ti6tzjhZsGA@mail.gmail.com>
Subject: Re: [PATCH 2/4] clk: renesas: r8a774a1: Add 3dge and ZG support
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
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Thanks, will queue in renesas-clk-for-v6.6.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
