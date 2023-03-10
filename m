Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85B666B387E
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 09:24:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230369AbjCJIYo convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 10 Mar 2023 03:24:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229654AbjCJIYe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 03:24:34 -0500
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6E13104922;
        Fri, 10 Mar 2023 00:24:32 -0800 (PST)
Received: by mail-qt1-f182.google.com with SMTP id c19so4851598qtn.13;
        Fri, 10 Mar 2023 00:24:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678436672;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6tbDlSIaO3/jiqD80O4ij9Gm4MwJA0fTC0h0kloiqAU=;
        b=g52CT9PE7wafM3Eu2QUl0gEMz5UsyFFfAMc/VkVYqUqnshtWSgLP2l5Zvy7zUHaPbw
         jRQX/zw0KzdiRuigYVsPKl+cxvXFi1zr4CJEkuxObiyShGkgGWbhdXuXHnKJ5tQ8cHnq
         jErjbpuEk6lf8uUIimjL3LQo97vMpY062zONdAsKjk8X571SEF6S52DL7kCWLjIKCHkR
         PD46cLN7Za1PTOeQVrmvOFjnpLzeK+q/39CEmciF26LdP0j10M+opKLcWFc8Zb6pLLGp
         otkUvylPN/b/bcE3KiWSBzd2QRp2wdFvPmuxuBajP54S3ireKNjGbFc9p5V2XqBRHVC7
         kJCw==
X-Gm-Message-State: AO0yUKWfLzIKfM06vos91Rca2QqRy68pBUXu7YmLCU6928kspBZNxZtN
        cnXxzoXrB0hrWc06yeAfCj62LTaiSvkz2A==
X-Google-Smtp-Source: AK7set80WMOjUoKIX4Fgl0lTIXYXKtrZI63h3ZBLKe9GBDtH/QBVXOqsKret16zGtksw5p3xF5waIA==
X-Received: by 2002:ac8:7c48:0:b0:3bf:abd5:f1ef with SMTP id o8-20020ac87c48000000b003bfabd5f1efmr8259735qtv.7.1678436671775;
        Fri, 10 Mar 2023 00:24:31 -0800 (PST)
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com. [209.85.219.181])
        by smtp.gmail.com with ESMTPSA id w10-20020ac86b0a000000b003bfad864e81sm965275qts.69.2023.03.10.00.24.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Mar 2023 00:24:30 -0800 (PST)
Received: by mail-yb1-f181.google.com with SMTP id i6so4475870ybu.8;
        Fri, 10 Mar 2023 00:24:29 -0800 (PST)
X-Received: by 2002:a05:6902:208:b0:acd:7374:f154 with SMTP id
 j8-20020a056902020800b00acd7374f154mr15193253ybs.7.1678436669227; Fri, 10 Mar
 2023 00:24:29 -0800 (PST)
MIME-Version: 1.0
References: <20230309160201.5163-1-tzimmermann@suse.de>
In-Reply-To: <20230309160201.5163-1-tzimmermann@suse.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 10 Mar 2023 09:24:16 +0100
X-Gmail-Original-Message-ID: <CAMuHMdX9mmPDvTpeHQWMoi1pAqoDn1go4in995pGkamOQmBXjA@mail.gmail.com>
Message-ID: <CAMuHMdX9mmPDvTpeHQWMoi1pAqoDn1go4in995pGkamOQmBXjA@mail.gmail.com>
Subject: Re: [PATCH v2 000/101] fbdev: Fix memory leak in option parsing
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     deller@gmx.de, timur@kernel.org, rdunlap@infradead.org,
        paulus@samba.org, benh@kernel.crashing.org, linux@armlinux.org.uk,
        pjones@redhat.com, adaplas@gmail.com, s.hauer@pengutronix.de,
        shawnguo@kernel.org, mbroemme@libmpq.org, thomas@winischhofer.net,
        James.Bottomley@hansenpartnership.com, sudipm.mukherjee@gmail.com,
        teddy.wang@siliconmotion.com, corbet@lwn.net,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

On Thu, Mar 9, 2023 at 5:02 PM Thomas Zimmermann <tzimmermann@suse.de> wrote:
> Introduce struct option_iter and helpers to parse command-line
> options with comma-separated key-value pairs. Then convert fbdev
> drivers to the new interface. Fixes a memory leak in the parsing of
> the video= option.
>
> Before commit 73ce73c30ba9 ("fbdev: Transfer video= option strings to
> caller; clarify ownership"), a call to fb_get_options() either
> returned an internal string or a duplicated string; hence ownership of
> the string's memory buffer was not well defined, but depended on how
> users specified the video= option on the kernel command line. For
> global settings, the caller owned the returned memory and for per-driver
> settings, fb_get_options() owned the memory. As calling drivers were
> unable to detect the case, they had no option but to leak the the memory.
>
> Commit 73ce73c30ba9 ("fbdev: Transfer video= option strings to caller;
> clarify ownership") changed semantics to caller-owned strings. Drivers
> still leaked the memory, but at least ownership was clear.

While I can find the actual patch[1], I cannot find this commit?
Where was it applied?

[1] https://lore.kernel.org/all/20230209135509.7786-3-tzimmermann@suse.de

> This patchset fixes the memory leak and changes string ownership back
> to fb_get_options(). Patch 1 introduces struct option_iter and a few
> helpers. The interface takes an option string, such as video=, in the
> common form value1,key2:value2,value3 etc and returns the individual
> comma-separated pairs. Various modules use this pattern, so the code
> is located under lib/.
>
> Patches 2 to 100 go through fbdev drivers and convert them to the new
> interface. This often requires a number of cleanups. A driver would
> typically refer to the option string's video mode. Such strings are now
> copied to driver-allocated memory so that drivers don't refer directly
> to the option string's memory. The option iterator then replaces manual
> parsing loops based on strsep(","). All driver-allocated memory is
> released by removing the device or unloading the module.
>
> Patch 101 finally changes the ownership of the option string to be
> internal to fb_get_option(); thereby fixing the memory leak. The option
> iterator holds its own copy of the string and is not affected by the
> change.
>
> Most fbdev drivers only support to parse option strings if they are
> built-in. I assume that's because of the original fuzzy semantics of
> fb_get_options(). A later patchset could change the driver to respect
> video= settings in any configuration.
>
> v2:
>         * use kstrdup()/kfree() for video strings (Geert, Timur)
>         * fix iterator docs (Randy)
>         * update iterator interface

Thanks for the update, this looks much better!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
