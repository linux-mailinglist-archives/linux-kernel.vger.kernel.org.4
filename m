Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 443816E31FE
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Apr 2023 16:54:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229969AbjDOOyA convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 15 Apr 2023 10:54:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbjDOOx7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Apr 2023 10:53:59 -0400
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E17D198A;
        Sat, 15 Apr 2023 07:53:56 -0700 (PDT)
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-5491fa028adso703822347b3.10;
        Sat, 15 Apr 2023 07:53:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681570435; x=1684162435;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=44xrs6sO2sMiW3hY5H+zH32Qhk01nAYZ9WHFCRpWgXY=;
        b=UvAx/moodxM2XJvzfwOtfw17A6L+Bs9dqDoY0B0n7sPlYIFe6RORog99r3KfRuTwd2
         vt7nMdowO+rM0ipUzhfQHMqHKMS0GoX1cG3a/JQCb3SbuNQf2xnuo9sxH5P0DtWlr0qt
         EBIR+fcLQERFipVKiXn17d8t9kFf7OzqLVNkiWepxJkk+0bUjsxYA8P9Hz2vQ+SGSTVF
         xhWHtlMLjzxOKd69AZNeBdEziNvPPWQLkrpPohy1OgQAoglN/OqlG8Mkz+q2ki+aObWo
         /3dRnC5CwUAHu/rrENn7OnxFN5C2g45EosyOiQAVNIsoPhqbpHEb6ZnRQccIVxuF1Wr1
         C52A==
X-Gm-Message-State: AAQBX9ep4fFlfj8Ki9+A1o4vj9lVUTNN2CutABHXyneFX+IdMaLSZOAN
        RWAyx61mgRPZ5N8Smx/ZAlFSUndIheOAmg==
X-Google-Smtp-Source: AKy350bIp3EP+VdDtrzfDOfBffuXVzCQnjODWXKy7jxOQz879K/tJwew3B2WXjyzB+zWNcGyJyJUdQ==
X-Received: by 2002:a0d:cb4a:0:b0:54f:aa28:c908 with SMTP id n71-20020a0dcb4a000000b0054faa28c908mr8946918ywd.49.1681570434979;
        Sat, 15 Apr 2023 07:53:54 -0700 (PDT)
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com. [209.85.219.178])
        by smtp.gmail.com with ESMTPSA id 195-20020a810fcc000000b00545a08184f6sm1913349ywp.134.2023.04.15.07.53.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 15 Apr 2023 07:53:54 -0700 (PDT)
Received: by mail-yb1-f178.google.com with SMTP id m14so4224432ybk.4;
        Sat, 15 Apr 2023 07:53:53 -0700 (PDT)
X-Received: by 2002:a25:d608:0:b0:b67:d295:d614 with SMTP id
 n8-20020a25d608000000b00b67d295d614mr4690087ybg.12.1681570433755; Sat, 15 Apr
 2023 07:53:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230327143733.14599-1-akinobu.mita@gmail.com> <20230327143733.14599-2-akinobu.mita@gmail.com>
In-Reply-To: <20230327143733.14599-2-akinobu.mita@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Sat, 15 Apr 2023 16:53:41 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXhRvq3nktP4Kzjk8TuX1G=RfO3eOODGt5GRC6vGnfwzw@mail.gmail.com>
Message-ID: <CAMuHMdXhRvq3nktP4Kzjk8TuX1G=RfO3eOODGt5GRC6vGnfwzw@mail.gmail.com>
Subject: Re: [PATCH 1/2] fault-inject: allow configuration via configfs
To:     Akinobu Mita <akinobu.mita@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        akpm@linux-foundation.org, axboe@kernel.dk,
        Linux-Next <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mita-san,

On Mon, Mar 27, 2023 at 4:48 PM Akinobu Mita <akinobu.mita@gmail.com> wrote:
> This provides a helper function to allow configuration of fault-injection
> for configfs-based drivers.
>
> The config items created by this function have the same interface as the
> one created under debugfs by fault_create_debugfs_attr().
>
> Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>

Thanks for your patch, which is now commit 4668c7a2940d134b
("fault-inject: allow configuration via configfs") in linux-next
(to be tagged soon as next-20140414).

> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -1977,9 +1977,20 @@ config FAIL_SUNRPC
>           Provide fault-injection capability for SunRPC and
>           its consumers.
>
> +config FAULT_INJECTION_CONFIGFS
> +       bool "Configfs interface for fault-injection capabilities"
> +       depends on FAULT_INJECTION && CONFIGFS_FS

noreply@ellerman.id.au reported build failures for e.g. m68k-allmodconfig
http://kisskb.ellerman.id.au/kisskb/buildresult/14911188/:

fault-inject.c:(.text+0x1ee): undefined reference to
`config_group_init_type_name'

This fails because FAULT_INJECTION=y but CONFIGFS_FS=m.

> +       help
> +         This option allows configfs-based drivers to dynamically configure
> +         fault-injection via configfs.  Each parameter for driver-specific
> +         fault-injection can be made visible as a configfs attribute in a
> +         configfs group.
> +
> +

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
