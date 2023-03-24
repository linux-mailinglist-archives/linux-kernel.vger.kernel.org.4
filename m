Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4054E6C7AE8
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 10:12:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231274AbjCXJMU convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 24 Mar 2023 05:12:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbjCXJMT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 05:12:19 -0400
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A8B71DBAD;
        Fri, 24 Mar 2023 02:12:17 -0700 (PDT)
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-53d277c1834so21913167b3.10;
        Fri, 24 Mar 2023 02:12:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679649136;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vT0ZVyn9E4En44HeFsXHWItwUGr+VOia6O/prroLLsM=;
        b=pqVlgUvvpMIsNgyhKlFDo35jlxQlqQHdSIKWUeu5d7Sit1oE38nxhXVmTj9pnZ2paj
         zehAuLWrG/FCAOoilfd44u3TSSs5YFSKpXr4dQ0nmOt+dx68O3D5oVBrBPgrG1XWLCuH
         aZ5wM+QgZ0ij8FAQDUu8zcXhjLcu5mNoTQ5y7HR/IMGElOCcZe6fi6BMKgMnqOzKblf4
         sXfi0zUD527g0pkjVVdiz6Zr9KajF/n6mAoG0XBOos2tynJlCjmJfZlmh4Q6+ww3rH+X
         m61IDuaC8CWDVuZi9IUEkQrEACixn1lvcqg305yPz+vSkQtZ5xCZ1uBtSJ46IgDlA1sp
         aM+w==
X-Gm-Message-State: AAQBX9fXjUlsMHdqasdt3H3Fip1d4Ky3w+FWCR4f7eC8W/35zMA/GRtw
        HHlZoHZfDHg33ryGyryGLxKY6b6BeCZo+Q==
X-Google-Smtp-Source: AKy350ZrZw8DXURpeyXI2O6fnSecPNLWuLpbmyyOukwloyCLC2Az+8iK+LOwqvn6v/WSl7iO1G6ZzA==
X-Received: by 2002:a81:a196:0:b0:545:2a12:bb04 with SMTP id y144-20020a81a196000000b005452a12bb04mr1676545ywg.19.1679649136527;
        Fri, 24 Mar 2023 02:12:16 -0700 (PDT)
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com. [209.85.219.173])
        by smtp.gmail.com with ESMTPSA id d8-20020a81d808000000b00545a08184dcsm305559ywj.108.2023.03.24.02.12.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Mar 2023 02:12:16 -0700 (PDT)
Received: by mail-yb1-f173.google.com with SMTP id i6so1342327ybu.8;
        Fri, 24 Mar 2023 02:12:15 -0700 (PDT)
X-Received: by 2002:a05:6902:10c3:b0:b75:9519:dbcd with SMTP id
 w3-20020a05690210c300b00b759519dbcdmr945578ybu.12.1679649135194; Fri, 24 Mar
 2023 02:12:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230302211759.30135-1-nick.alcock@oracle.com>
 <20230302211759.30135-11-nick.alcock@oracle.com> <ZAoGLhRpTr5f7AD/@kroah.com>
 <ZApf0iNOsSAUbhMz@bombadil.infradead.org> <ZArc0ib697JIwKou@kroah.com>
 <ZAuGE2ay3q0MT4Yi@bombadil.infradead.org> <CAMuHMdVZODAr77KSp3Yicoyjz=y8OqQB+z6zTLbxO1HMKoJMSA@mail.gmail.com>
In-Reply-To: <CAMuHMdVZODAr77KSp3Yicoyjz=y8OqQB+z6zTLbxO1HMKoJMSA@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 24 Mar 2023 10:12:03 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVZLmRv_L-iTXBvTC_83oBG6nAMOGwTSeHtfVR6k1nAxA@mail.gmail.com>
Message-ID: <CAMuHMdVZLmRv_L-iTXBvTC_83oBG6nAMOGwTSeHtfVR6k1nAxA@mail.gmail.com>
Subject: Re: [PATCH 10/17] tty: remove MODULE_LICENSE in non-modules
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Christoph Hellwig <hch@infradead.org>,
        Nick Alcock <nick.alcock@oracle.com>,
        linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>,
        Jiri Slaby <jirislaby@kernel.org>
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

On Fri, Mar 24, 2023 at 10:08 AM Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> And some of the modified files have no SPDX-License-Identifier
> lines yet, so we are losing important licensing information:
>
> $ git grep -L SPDX-License-Identifier -- $(git show $(git log
> --oneline v6.3-rc1..linux-next/master | grep "remove MODULE_LICENSE in
> non-modules" | cut -d " " -f 1) | lsdiff --strip=1)
> drivers/bus/arm-cci.c
> drivers/bus/imx-weim.c
> drivers/bus/simple-pm-bus.c
   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
This is a false-positive, as I grepped against my current tree.
> drivers/gpu/drm/drm_mipi_dsi.c
> drivers/irqchip/irq-mvebu-pic.c
> drivers/reset/reset-axs10x.c
> drivers/reset/reset-hsdk.c
> drivers/soc/sunxi/sunxi_sram.c
> drivers/video/fbdev/asiliantfb.c
> drivers/video/fbdev/gbefb.c
> drivers/video/fbdev/imsttfb.c
> drivers/xen/xenbus/xenbus_probe.c
> lib/glob.c

You want to use instead:
git grep -L SPDX-License-Identifier linux-next/master  -- $(git show
$(git log --oneline v6.3-rc1..linux-next/master | grep "remove
MODULE_LICENSE in non-modules" | cut -d " " -f 1) | lsdiff --strip=1)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
