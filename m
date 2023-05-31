Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74E8071798D
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 10:05:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235207AbjEaIF3 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 31 May 2023 04:05:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235209AbjEaIFW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 04:05:22 -0400
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EC4B186;
        Wed, 31 May 2023 01:05:19 -0700 (PDT)
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-ba8afcc82c0so9674230276.2;
        Wed, 31 May 2023 01:05:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685520318; x=1688112318;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WxrLCY7viWKO0bQukw/w0leEI6ByM9jS8ud+syXrPAA=;
        b=Uhx7nKUaoSkSR62NEBI4+hdfkKdDskOZ99h5ShAzEEXktLfci1qrtO8J4Ve/Grkfc2
         FoFoq5CC0yOptAp7JU1akzRvQZ/ZGeUAV7mcHuiLr6ZeRP8OiwKuCcN4zAJ9fkqPNHAt
         8TheNPExjOC8+OsJ6k/PctPH4rfgMKaOs3msibusdQAOpP7H7jR6CMFVDx7gtz6RkVkl
         HKy2szAZ8is3u74f0SoW1vAvBeOj68joKqlkHiMk4cKh5HgsWrzTh6DDimsP41ZSsOvq
         O4uI3adh9ktVG0iHvKeFZls66Ynss8TqqQ15tbKFQ3K0EsdudutY+9oeAQ3QnE0GhgB+
         79mQ==
X-Gm-Message-State: AC+VfDzeC9699+uAG8CkybjsAd/vx5ZofCw1hOMQWV7Yk3kqz3C+Q2IE
        mspNUqqvcpHZmgVVOMpqz+3pDBXqcJQjSQ==
X-Google-Smtp-Source: ACHHUZ6/z6LDEEniz4dMW/GZfwhHxNId7kISyGyx8wVuDyiYrHmJoLvTwM6mhugc/W0w+P3ZEiOwrw==
X-Received: by 2002:a25:c707:0:b0:ba8:9096:8207 with SMTP id w7-20020a25c707000000b00ba890968207mr6355433ybe.5.1685520318106;
        Wed, 31 May 2023 01:05:18 -0700 (PDT)
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com. [209.85.128.175])
        by smtp.gmail.com with ESMTPSA id cf13-20020a056902180d00b00bad07875d9bsm3545655ybb.11.2023.05.31.01.05.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 May 2023 01:05:17 -0700 (PDT)
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-565eb83efe4so51934557b3.0;
        Wed, 31 May 2023 01:05:16 -0700 (PDT)
X-Received: by 2002:a0d:ccd3:0:b0:561:e89d:e263 with SMTP id
 o202-20020a0dccd3000000b00561e89de263mr4627466ywd.52.1685520316792; Wed, 31
 May 2023 01:05:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230530164004.986750-1-azeemshaikh38@gmail.com>
 <202305311135.zGMT1gYR-lkp@intel.com> <09A0C6FA-669F-4B73-9620-43AEA17E5D0C@kernel.org>
 <103925562.158061.1685514200368.JavaMail.zimbra@nod.at>
In-Reply-To: <103925562.158061.1685514200368.JavaMail.zimbra@nod.at>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 31 May 2023 10:05:03 +0200
X-Gmail-Original-Message-ID: <CAMuHMdU70uRxnMNb8KCJe8M3BRPPxowRXtj+POcrh+KLkfQyAA@mail.gmail.com>
Message-ID: <CAMuHMdU70uRxnMNb8KCJe8M3BRPPxowRXtj+POcrh+KLkfQyAA@mail.gmail.com>
Subject: Re: [PATCH] uml: Replace all non-returning strlcpy with strscpy
To:     Richard Weinberger <richard@nod.at>
Cc:     Kees Cook <kees@kernel.org>,
        Azeem Shaikh <azeemshaikh38@gmail.com>,
        kernel test robot <lkp@intel.com>,
        Maxim Krasnyansky <maxk@qti.qualcomm.com>,
        oe-kbuild-all <oe-kbuild-all@lists.linux.dev>,
        linux-hardening@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        anton ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-um <linux-um@lists.infradead.org>
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

On Wed, May 31, 2023 at 8:23 AM Richard Weinberger <richard@nod.at> wrote:
> ----- Ursprüngliche Mail -----
> >>>> arch/um/os-Linux/drivers/tuntap_user.c:149:17: error: implicit declaration of
> >>>> function 'strscpy'; did you mean 'strncpy'?
> >>>> [-Werror=implicit-function-declaration]
> >>     149 |                 strscpy(ifr.ifr_name, pri->dev_name,
> >>     sizeof(ifr.ifr_name));
> >>         |                 ^~~~~~~
> >>         |                 strncpy
> >>   cc1: some warnings being treated as errors
> >
> > Ah, yeah, this is another "not actually in the kernel" cases. Let's ignore this
> > strlcpy for now.
>
> Well, actually it's another case of "not even compile tested". :-(

"But the AI said it was correct?!?" ;-)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
