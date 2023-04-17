Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 060D46E40D4
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 09:27:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230282AbjDQH1L convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 17 Apr 2023 03:27:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230356AbjDQH05 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 03:26:57 -0400
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89C9A3C3B
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 00:26:41 -0700 (PDT)
Received: by mail-yb1-f178.google.com with SMTP id m14so7311713ybk.4
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 00:26:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681716400; x=1684308400;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UnHCIIu6B3qiVRFBtGIosQ/MV7BEV+uDGlhW9VKcxis=;
        b=Jpi0WzGmqxfc3iSJi5X4KDt+ODwOs6IvGJJyD97Iw4tkCnsrVAoN79ekOh9C11utH1
         dJlIv7dHAmxwQdrS6cYu4D7EaGYEHy5lMlsK3RZNcqLi68d65Nl9U7gn81ApmlrkDDr6
         70YOLt5W0lxyOEidBJwi04ZyoNuGPvlR1e0cKYC1N9mw0Ru1y/DeAoabqTbnakAA0MAW
         IYcn22ND1uNz3q82frJip/AfWp/p5S2f0QyGh0IP9xEEcUJDQpydk07nfhyu014tCY1w
         FsDu0unpE6S2yf4aRw7192wt2MSFORvUeFNncJ7dyN07KdNFsiIa+CJR7b03HFkUdw3D
         4kNA==
X-Gm-Message-State: AAQBX9c00asbBRn1Z4bVNgPxevzUi9m5gCCLXyfdwPIr+uixHIn/7Xsv
        wB/cVUqOLXf8xAfYpqwG89YYujzj7nTmtw==
X-Google-Smtp-Source: AKy350ZqYHUj87GJFaRrCM2sqWRmV5fMDdRopqt1VPwRvx4zZQUEU/zqWdC2WuhzGeFQyOoMnjfcbA==
X-Received: by 2002:a05:6902:707:b0:b8f:3685:c12a with SMTP id k7-20020a056902070700b00b8f3685c12amr15972870ybt.39.1681716400580;
        Mon, 17 Apr 2023 00:26:40 -0700 (PDT)
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com. [209.85.219.175])
        by smtp.gmail.com with ESMTPSA id 126-20020a250a84000000b00b8f54571fc0sm1300552ybk.5.2023.04.17.00.26.40
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Apr 2023 00:26:40 -0700 (PDT)
Received: by mail-yb1-f175.google.com with SMTP id n193so2252221ybf.12
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 00:26:40 -0700 (PDT)
X-Received: by 2002:a25:d707:0:b0:b8f:578c:4e3a with SMTP id
 o7-20020a25d707000000b00b8f578c4e3amr6749432ybg.12.1681716399950; Mon, 17 Apr
 2023 00:26:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230412183834.3769519-1-j.neuschaefer@gmx.net> <20230412183834.3769519-2-j.neuschaefer@gmx.net>
In-Reply-To: <20230412183834.3769519-2-j.neuschaefer@gmx.net>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 17 Apr 2023 09:26:28 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVUC9n8vQYq+5tXX1jVPSnhyKoMAcB0dd6GFMXA=Apobw@mail.gmail.com>
Message-ID: <CAMuHMdVUC9n8vQYq+5tXX1jVPSnhyKoMAcB0dd6GFMXA=Apobw@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] soc: nuvoton: Add "select REGMAP" to WPCM450 SoC driver
To:     =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Cc:     openbmc@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Joel Stanley <joel@jms.id.au>,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        Arnd Bergmann <arnd@arndb.de>
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

On Wed, Apr 12, 2023 at 8:38 PM Jonathan Neuschäfer
<j.neuschaefer@gmx.net> wrote:
> Select CONFIG_REGMAP from CONFIG_WPCM450_SOC, because the driver relies
> on regmap to work.
>
> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Link: https://lore.kernel.org/lkml/CAMuHMdWo5vHCeE6BeSHrUy12uT7_wFhW-VbQmQ5u+4Q8c7-wYQ@mail.gmail.com/
> Fixes: 77b8c67b5637 ("soc: nuvoton: Add SoC info driver for WPCM450")
> Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
> ---
> v3:
> - Split the commit into two
> - Reword the commit messages a bit

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
