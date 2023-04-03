Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 551B36D3E5B
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 09:46:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231447AbjDCHq3 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 3 Apr 2023 03:46:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbjDCHq1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 03:46:27 -0400
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D836F10B;
        Mon,  3 Apr 2023 00:46:25 -0700 (PDT)
Received: by mail-lj1-f177.google.com with SMTP id a11so29327803lji.6;
        Mon, 03 Apr 2023 00:46:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680507983;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XZqsSeG92QJB+FkeLdPRDqSn7lcMPGjoOntxd0P/7FA=;
        b=y/pfF2WOcs3dACT2+fn0lyql63awEFKhgvhHAvZrL1r64oKJwGk8B67u33ZVW/yxst
         0MuI/0od3fv8m6l9VK7jMO7ftJ0BrRZ8PQnC3AAXO1b89twBsgBHDZ7qalk3qDDjzV4J
         Gq9hCGlfCRM126toP6Hs82B8IpF3dMgbGHCno9OXB0+n2TF8Z7dqbUiku5VtmiqNCkQc
         i+jaho/S094cJySfSnCMM+QYq7eGMusKydL+fuX8g+Xbo3+sG+xsEJC7IAjBWkHSf83F
         dQLE1A5japnEK6w6csJFI4Me9/CGJD5luwvXKfCMD73DLWWglX34UuNhxDGJRPLhxXhM
         d9qw==
X-Gm-Message-State: AAQBX9cSGxCMFyBbUqEEM5SUizNIhVo4FqsOYSLvuIaVZWQCBzG9VXko
        o04RD0THT4ZWYxPQPMDcOPfzafjnjwrMxw==
X-Google-Smtp-Source: AKy350ZNDjKygjfviBsMUOhOKygQhYAdSKrVTkor5iHGmBEzPRGN7xkIfKGokPvsk5xz3B9nJuToMg==
X-Received: by 2002:a2e:ba09:0:b0:295:b10f:7c9a with SMTP id p9-20020a2eba09000000b00295b10f7c9amr5133016lja.4.1680507983257;
        Mon, 03 Apr 2023 00:46:23 -0700 (PDT)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com. [209.85.208.171])
        by smtp.gmail.com with ESMTPSA id 18-20020a05651c00d200b0029bfcbeac09sm1625009ljr.41.2023.04.03.00.46.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Apr 2023 00:46:23 -0700 (PDT)
Received: by mail-lj1-f171.google.com with SMTP id 20so29366006lju.0;
        Mon, 03 Apr 2023 00:46:23 -0700 (PDT)
X-Received: by 2002:a2e:86d8:0:b0:299:ac1c:d8b3 with SMTP id
 n24-20020a2e86d8000000b00299ac1cd8b3mr10752173ljj.9.1680507983008; Mon, 03
 Apr 2023 00:46:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230331095545.31823-1-lidaxian@hust.edu.cn> <CAMuHMdV5guFbo76nq27aZjWsYqneOfGNf0Ozyh0C53+VgnXgXw@mail.gmail.com>
 <d2688eb2-d7b6-4e80-a13e-55ed541ac9b8@kili.mountain> <CAMuHMdX2b+GV4+Ee0yQ2hfNCvHaU_jAsnmF28=4ffCmdVy58xg@mail.gmail.com>
 <302d88ca-7d28-4450-8e60-d0bb40f4174d@kili.mountain>
In-Reply-To: <302d88ca-7d28-4450-8e60-d0bb40f4174d@kili.mountain>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 3 Apr 2023 09:46:09 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVE3Fcb9Rx9bF4NTyGH=gdRY3maNY6S5W7iFFiGrFeOJw@mail.gmail.com>
Message-ID: <CAMuHMdVE3Fcb9Rx9bF4NTyGH=gdRY3maNY6S5W7iFFiGrFeOJw@mail.gmail.com>
Subject: Re: [PATCH] soc: renesas: renesas-soc: release 'chipid' from ioremap()
To:     Dan Carpenter <error27@gmail.com>
Cc:     Li Yang <lidaxian@hust.edu.cn>,
        Magnus Damm <magnus.damm@gmail.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=0.5 required=5.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dan,

On Mon, Apr 3, 2023 at 9:34 AM Dan Carpenter <error27@gmail.com> wrote:
> On Mon, Apr 03, 2023 at 09:12:55AM +0200, Geert Uytterhoeven wrote:
> > Perhaps we need a different mechanism to annotate error handling code
> > that cannot ever happen in a real product, so it can be thrown away by
> > the compiler, while still pleasing the static checkers?  All these
> > checks and error handling code do affect kernel size.  There are
> > Linux products running on SoCs with 8 MiB of internal SRAM.
>
> People sometimes call BUG_ON(!soc_dev_attr).  It's sort of rare these

BUG_ON() is also not cheap, space-wise (except if CONFIG_BUG=n).

> days.  It would be easy to make a function which silences Smatch...
>
>         __system_is_dead();

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
