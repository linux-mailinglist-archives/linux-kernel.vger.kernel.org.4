Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A8E45BFC1F
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 12:17:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230027AbiIUKRK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 06:17:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbiIUKRC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 06:17:02 -0400
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A64A993234
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 03:17:01 -0700 (PDT)
Received: by mail-qk1-f179.google.com with SMTP id o7so3565019qkj.10
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 03:17:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=dXHLrhRIwlzhRG/KoQtkwVgS7+IGnxtoWbd/GyVKzFQ=;
        b=bLu2XnbwHkXPeMDlUdwnpUF+9HAWp6Q6JBw/QNRB4kuB4guGVBR59qUGJuu7gLwTcC
         LR869jUwYsSL7iPsy5ANvRcjXQjSzFiAemUcuNuAhTALIo+CIS6VEXaq2vzSX1hVvxOv
         Da0RTb9Nh3crEDbaPJWAyX8zFITMJsnZ2spbKQg6xE1OZoaLcQ8X1HhbIo90NqUII5pk
         9fmz9H1yJcMLtK8YnV2EyeaUGGxoMOBP09cOQp4PgzQq5kWM6DYJvCnPGrTEON3+wXA+
         UOVkFJdRd3k+Cg0DxFlrA/9h9AEcIHgc8JTC8ehp1evzi4BpoKG2n+nFTWBY/VmV/jQv
         x06w==
X-Gm-Message-State: ACrzQf2JnVEuroSCYez0maZiklAXO+dFaqxtGkiDqmYIHn5c5d6DizeV
        fQX7MxRKoTB+FuyLaaADptD1F4RdZTqpyJ8Q
X-Google-Smtp-Source: AMsMyM5cT2JXg+td4+a4mI9FpZdjyo811bORWBJcIGnYh0LMdO4JBkBZdxfyHPh7dvpY8IpWgmLpdw==
X-Received: by 2002:a37:de15:0:b0:6cb:cdc7:529a with SMTP id h21-20020a37de15000000b006cbcdc7529amr18791507qkj.208.1663755420605;
        Wed, 21 Sep 2022 03:17:00 -0700 (PDT)
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com. [209.85.219.173])
        by smtp.gmail.com with ESMTPSA id bl21-20020a05620a1a9500b006ce30a5f892sm1515329qkb.102.2022.09.21.03.16.59
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Sep 2022 03:16:59 -0700 (PDT)
Received: by mail-yb1-f173.google.com with SMTP id s14so7336542ybe.7
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 03:16:59 -0700 (PDT)
X-Received: by 2002:a25:8e84:0:b0:696:466c:baa with SMTP id
 q4-20020a258e84000000b00696466c0baamr21874382ybl.604.1663755419235; Wed, 21
 Sep 2022 03:16:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220921092944.230413-1-ye.xingchen@zte.com.cn>
In-Reply-To: <20220921092944.230413-1-ye.xingchen@zte.com.cn>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 21 Sep 2022 12:16:48 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUtXQJDBMDBROHa0md5eFvnjtLNNBVvWjLKEPRxFzgg2g@mail.gmail.com>
Message-ID: <CAMuHMdUtXQJDBMDBROHa0md5eFvnjtLNNBVvWjLKEPRxFzgg2g@mail.gmail.com>
Subject: Re: [PATCH linux-next] um: use strscpy() is more robust and safer
To:     cgel.zte@gmail.com
Cc:     richard@nod.at, anton.ivanov@cambridgegreys.com,
        johannes@sipsolutions.net, baihaowen@meizu.com,
        linux-um@lists.infradead.org, linux-kernel@vger.kernel.org,
        ye xingchen <ye.xingchen@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
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

Hi Ye,

On Wed, Sep 21, 2022 at 11:45 AM <cgel.zte@gmail.com> wrote:
> From: ye xingchen <ye.xingchen@zte.com.cn>
>
> The implementation of strscpy() is more robust and safer.
>
> That's now the recommended way to copy NUL terminated strings.
>
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>

Thanks for your patch!

> --- a/arch/um/os-Linux/umid.c
> +++ b/arch/um/os-Linux/umid.c
> @@ -262,7 +262,7 @@ static int __init make_umid(void)
>         make_uml_dir();
>
>         if (*umid == '\0') {
> -               strlcpy(tmp, uml_dir, sizeof(tmp));
> +               strscpy(tmp, uml_dir, sizeof(tmp));
>                 strlcat(tmp, "XXXXXX", sizeof(tmp));

Do we need strscat(), too? ;-)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
