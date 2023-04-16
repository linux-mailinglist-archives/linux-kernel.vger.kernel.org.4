Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A5836E36CF
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Apr 2023 11:53:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230421AbjDPJxi convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 16 Apr 2023 05:53:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230363AbjDPJxc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 05:53:32 -0400
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 401241BDA;
        Sun, 16 Apr 2023 02:53:31 -0700 (PDT)
Received: by mail-yb1-f180.google.com with SMTP id y16so7901146ybb.2;
        Sun, 16 Apr 2023 02:53:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681638810; x=1684230810;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vy0goH1eR4IHNE8qypyyzP1OUcgfs+Sxeg1e6E0IW/k=;
        b=MNTIB/514fLN8+REJ+SUiqDm3FemzuDzeeOJM2+yltuLiDNRPQ8gHdpjHYYA/K34xr
         w317Cxd/lj/qoJlq4d7evz37RYQCqb8qgzOHAosmnDBlEYHqdTiG7PFIKYx/hDELbQvD
         JBdGWbLlxnDTadColGMxS5/9HONdGtgpaLm98KPOc1jcbhUNZLP4OrK4bAv8c86ZoTlN
         /RU57jg3JypA/7HVXjJ/ve1rncJpVx2X/kW3AYCj/9iwS1dzCjSUwOrrA8BK8eYLWqTi
         ulLOfMMJv+fe5YSkMDrQHHYFLNkxwSc5QceuKzCohL34dNeJizYk6kLLKyTRVYE7xeM6
         Matw==
X-Gm-Message-State: AAQBX9c31tXBZvW5CfPUZETIa18RWrmJY6auvelawfGLf9dA4+QDaP87
        af6+R0Ep0GPmgbQ8s0X1mr5plT414XUaLA==
X-Google-Smtp-Source: AKy350YJ5sgTQqbpk2nz2JhuJ0ZdAV99KHIhZ2YoNJjxxBLOwmpeNPDngqZFhmhxuX4a8fFMdywozw==
X-Received: by 2002:a25:7388:0:b0:b92:5277:ebc2 with SMTP id o130-20020a257388000000b00b925277ebc2mr28742ybc.29.1681638810279;
        Sun, 16 Apr 2023 02:53:30 -0700 (PDT)
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com. [209.85.128.170])
        by smtp.gmail.com with ESMTPSA id 126-20020a250a84000000b00b8f54571fc0sm785758ybk.5.2023.04.16.02.53.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Apr 2023 02:53:29 -0700 (PDT)
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-54fe3cd445aso86100027b3.5;
        Sun, 16 Apr 2023 02:53:29 -0700 (PDT)
X-Received: by 2002:a81:e54b:0:b0:552:d6aa:80d9 with SMTP id
 c11-20020a81e54b000000b00552d6aa80d9mr275295ywm.4.1681638809536; Sun, 16 Apr
 2023 02:53:29 -0700 (PDT)
MIME-Version: 1.0
References: <202304150025.K0hczLR4-lkp@intel.com> <20230415125705.180426-1-akinobu.mita@gmail.com>
In-Reply-To: <20230415125705.180426-1-akinobu.mita@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Sun, 16 Apr 2023 11:53:18 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWNQRgXzaEsb1M=SGm683dTOU2gLyjD2UuoD8qy+Ex74Q@mail.gmail.com>
Message-ID: <CAMuHMdWNQRgXzaEsb1M=SGm683dTOU2gLyjD2UuoD8qy+Ex74Q@mail.gmail.com>
Subject: Re: [PATCH -block] fault-inject: fix build error when
 FAULT_INJECTION_CONFIGFS=y and CONFIGFS_FS=m
To:     Akinobu Mita <akinobu.mita@gmail.com>
Cc:     lkp@intel.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, axboe@kernel.dk,
        oe-kbuild-all@lists.linux.dev, shinichiro.kawasaki@wdc.com,
        chaitanyak@nvidia.com, akpm@linux-foundation.org,
        hch@infradead.org, Arnd Bergmann <arnd@arndb.de>
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

Hi Mita-san,

On Sat, Apr 15, 2023 at 3:09 PM Akinobu Mita <akinobu.mita@gmail.com> wrote:
> This fixes a build error when CONFIG_FAULT_INJECTION_CONFIGFS=y and
> CONFIG_CONFIGFS_FS=m.
>
> Since the fault-injection library cannot built as a module, avoid building
> configfs as a module.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Link: https://lore.kernel.org/oe-kbuild-all/202304150025.K0hczLR4-lkp@intel.com/
> Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>

Thanks for your patch!

> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -1979,7 +1979,8 @@ config FAIL_SUNRPC
>
>  config FAULT_INJECTION_CONFIGFS
>         bool "Configfs interface for fault-injection capabilities"
> -       depends on FAULT_INJECTION && CONFIGFS_FS
> +       depends on FAULT_INJECTION
> +       select CONFIGFS_FS

My first thought was "please do not select CONFIGFS_FS", but
apparently this is what most users do, so I guess it's OK.

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

The alternative would be to do:

-       depends on FAULT_INJECTION && CONFIGFS_FS
+       depends on FAULT_INJECTION && (CONFIGFS_FS=y ||
CONFIGFS_FS=FAULT_INJECTION)

>         help
>           This option allows configfs-based drivers to dynamically configure
>           fault-injection via configfs.  Each parameter for driver-specific

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
