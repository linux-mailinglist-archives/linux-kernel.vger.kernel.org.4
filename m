Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 404185F07BF
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 11:36:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230455AbiI3Jgj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 05:36:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231441AbiI3JgZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 05:36:25 -0400
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1485D12C682
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 02:36:24 -0700 (PDT)
Received: by mail-qv1-f44.google.com with SMTP id u8so2463363qvv.9
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 02:36:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=M1K0WsiF135t2j3SUZO6oV2iG51jDxP4cy8f0SHNSvU=;
        b=jAh4V30iAn1/c6UspDHDuoDO1pggb/8yc0S5C60uIBUWsyOjesnyQxlrj1yaAvam0R
         /jaCVuI5MwuiWVyslwo0knXA1hFAVq3C5Jnp/oY0+7KkXrc/g41OW/Q/P9vPbxcJrUmS
         AS3Fm2RiAqXHbCfQGqQT6zz97s/tPerjKGDQnonCDUz+XtpoYYyl6tqdKx6R4mn4FRhv
         Vf47VtWUna9nWxiI1BGzoSvw3sM+hpbZrHtRdDjSm4BiZcNsiHavf4TkK2UEOHUxgTi5
         T/5m2C798vEgn8Yd8dtOE2z8tgRIY7Q7aTFislAmhhOdy9BSylu1cj3epwiWg66PkOgx
         FQDQ==
X-Gm-Message-State: ACrzQf3UYi3K6fbmBTDDa8wYWndIKYiTykcwPfSE6dpmU1DZfdzc5ByO
        E4frnw+M2fKx7/EaIVnRm/srYaTESDBhyA==
X-Google-Smtp-Source: AMsMyM6BuzEn9NYqXQFSQlnEL++uXtPvzBucsrSAOpxFOLS5nCDZqQhsQOWT3eEiGCMPydxuCGkIqA==
X-Received: by 2002:a05:6214:401d:b0:4ac:add9:ed3f with SMTP id kd29-20020a056214401d00b004acadd9ed3fmr5978783qvb.10.1664530582958;
        Fri, 30 Sep 2022 02:36:22 -0700 (PDT)
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com. [209.85.219.175])
        by smtp.gmail.com with ESMTPSA id w6-20020a05620a444600b006bc0980db76sm2195105qkp.126.2022.09.30.02.36.22
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Sep 2022 02:36:22 -0700 (PDT)
Received: by mail-yb1-f175.google.com with SMTP id l76so1687992ybl.2
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 02:36:22 -0700 (PDT)
X-Received: by 2002:a25:8e84:0:b0:696:466c:baa with SMTP id
 q4-20020a258e84000000b00696466c0baamr7335432ybl.604.1664530582128; Fri, 30
 Sep 2022 02:36:22 -0700 (PDT)
MIME-Version: 1.0
References: <20220930080717.290016-1-xu.panda@zte.com.cn>
In-Reply-To: <20220930080717.290016-1-xu.panda@zte.com.cn>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 30 Sep 2022 11:36:11 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVQJkY=+CSez7FmOb2no0SZ9rkeAAWpRr_zLvBAYUwKXw@mail.gmail.com>
Message-ID: <CAMuHMdVQJkY=+CSez7FmOb2no0SZ9rkeAAWpRr_zLvBAYUwKXw@mail.gmail.com>
Subject: Re: [PATCH linux-next] m68k: Move from strlcpy with unused retval to strscpy
To:     cgel.zte@gmail.com
Cc:     laurent@vivier.eu, arnd@arndb.de, rppt@kernel.org,
        dmitry.osipenko@collabora.com, fthain@linux-m68k.org,
        linux-kernel@vger.kernel.org, Xu Panda <xu.panda@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>
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

CC linux-m68k

On Fri, Sep 30, 2022 at 10:07 AM <cgel.zte@gmail.com> wrote:
> From: Xu Panda <xu.panda@zte.com.cn>
>
> The implementation of strscpy() is more robust and safer.
> That's now the recommended way to copy NUL terminated strings.
>
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Xu Panda <xu.panda@zte.com.cn>
> ---
>  arch/m68k/kernel/setup_mm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/m68k/kernel/setup_mm.c b/arch/m68k/kernel/setup_mm.c
> index 06ee394db610..401a8deb6ffc 100644
> --- a/arch/m68k/kernel/setup_mm.c
> +++ b/arch/m68k/kernel/setup_mm.c
> @@ -231,7 +231,7 @@ void __init setup_arch(char **cmdline_p)
>         setup_initial_init_mm((void *)PAGE_OFFSET, _etext, _edata, _end);
>
>  #if defined(CONFIG_BOOTPARAM)
> -       strncpy(m68k_command_line, CONFIG_BOOTPARAM_STRING, CL_SIZE);
> +       strscpy(m68k_command_line, CONFIG_BOOTPARAM_STRING, CL_SIZE);
>         m68k_command_line[CL_SIZE - 1] = 0;
>  #endif /* CONFIG_BOOTPARAM */
>         process_uboot_commandline(&m68k_command_line[0], CL_SIZE);
> --
> 2.15.2
