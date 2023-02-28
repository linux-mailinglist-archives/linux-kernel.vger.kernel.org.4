Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 135936A54CE
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 09:52:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231174AbjB1IwN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 03:52:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230525AbjB1Ivm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 03:51:42 -0500
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4A752C65F;
        Tue, 28 Feb 2023 00:51:23 -0800 (PST)
Received: by mail-qt1-f176.google.com with SMTP id l18so8564908qtp.1;
        Tue, 28 Feb 2023 00:51:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BcmyBR9r9vfVMy46Zbtjihg4aGWAqOJpiApC3nmtT5U=;
        b=VkIehAxmOHYsetkOTlsxfic02WHwjpYg6raHWgDamr0Rwga0QBniT6ifY+XznBhxGZ
         C2/ZMOxnVE2Rpb7i9IyxY2SC4H7TotS7kTqDbR7pBomeK6eYH2MpbvtvGDirmgRlZx3D
         XXkgbvtA20FZowzh8itdVN55V0tIAcyfdHdYy4iEqEfOO0S6Q7f4Ot+jWsoyKPuZahMm
         WtvfZGb247IqVgu8ZtwA0MeGR8yEhllC2EYh2kiYWSYqUJzwXziPCRyc5owRdRCrZ1rr
         Lt0hTnIsG2QKr4YqY9aud3y0BnOyajUryX7QaEZj9OHd5swUj6DktoCn7uBI0ZsmVAlZ
         4rNg==
X-Gm-Message-State: AO0yUKWe4MNeuHvxUM0n30RZF5Mw/677/Rt3n0hIBTAkuQYuXk1+BNIL
        nSCOeecKCN1T3iIFfBmVlhwtSHRzUp7asA==
X-Google-Smtp-Source: AK7set82mB5ZQohThxITbvXngTvY3SbUv7JJ6gWv3nhM+jxiv0K674MpNpK/jJqAXWvnpWTW0lghSA==
X-Received: by 2002:a05:622a:50:b0:3bf:e2ff:4c35 with SMTP id y16-20020a05622a005000b003bfe2ff4c35mr3753015qtw.1.1677574282471;
        Tue, 28 Feb 2023 00:51:22 -0800 (PST)
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com. [209.85.128.181])
        by smtp.gmail.com with ESMTPSA id s67-20020a374546000000b007424239e4casm6478232qka.117.2023.02.28.00.51.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Feb 2023 00:51:22 -0800 (PST)
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-536c2a1cc07so251284597b3.5;
        Tue, 28 Feb 2023 00:51:22 -0800 (PST)
X-Received: by 2002:a25:8d0e:0:b0:a67:c976:c910 with SMTP id
 n14-20020a258d0e000000b00a67c976c910mr772114ybl.7.1677574281918; Tue, 28 Feb
 2023 00:51:21 -0800 (PST)
MIME-Version: 1.0
References: <20230214132052.1556699-1-arnd@kernel.org>
In-Reply-To: <20230214132052.1556699-1-arnd@kernel.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 28 Feb 2023 09:51:05 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVD9VXwv6DjjKQNvxpXehvjR4pxr76yF=zt903OuU6ywA@mail.gmail.com>
Message-ID: <CAMuHMdVD9VXwv6DjjKQNvxpXehvjR4pxr76yF=zt903OuU6ywA@mail.gmail.com>
Subject: Re: [PATCH] power: supply: qcom_battmgr: remove bogus do_div()
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
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

On Tue, Feb 14, 2023 at 2:23 PM Arnd Bergmann <arnd@kernel.org> wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>
> The argument to do_div() is a 32-bit integer, and it was read from a
> 32-bit register so there is no point in doing a 64-bit division on it.
>
> On 32-bit arm, do_div() causes a compile-time warning here:
>
> include/asm-generic/div64.h:238:22: error: passing argument 1 of '__div64_32' from incompatible pointer type [-Werror=incompatible-pointer-types]
>   238 |   __rem = __div64_32(&(n), __base); \
>       |                      ^~~~
>       |                      |
>       |                      unsigned int *
> drivers/power/supply/qcom_battmgr.c:1130:4: note: in expansion of macro 'do_div'
>  1130 |    do_div(battmgr->status.percent, 100);
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
