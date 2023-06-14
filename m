Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A88072F91B
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 11:28:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244053AbjFNJ2R convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 14 Jun 2023 05:28:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243994AbjFNJ2A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 05:28:00 -0400
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 846131FDC;
        Wed, 14 Jun 2023 02:27:52 -0700 (PDT)
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-3f86a7f3a65so17684901cf.0;
        Wed, 14 Jun 2023 02:27:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686734871; x=1689326871;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N0yjIX0KRuOC7G0fcJ6d1AuThz30GREhJw6MsawVV4o=;
        b=X9kHcttdTeNzWzZigoxXgEXrH2/AZJGAzj6EcnqlZRvBWsqvJ2F/UfoDKYJbAPU5ez
         2r6l57gTY2i6fuGgC48GiKvLoODNEOdaRCS64ZE+6YWpPTeBGMhM9oUmZE4x/yAdS4hT
         mtB4vu+zHen8I7n38L9bCeA70A4cgSJ52yQwBQ21YxqV71wAuWO5SV6lsnw2hyCAYhlW
         72GXqmTYvxO0lt6/QQocJ0acsei7GoGKeIeVeekfLOX6u6ktol/hv36dmghRkXCZeN5x
         e76bCLVcXNC7kiX17mqWEw1PcEinnLr56ijUarsRonNTjjchT1P7M75k78dkpjbUgVR0
         mEaQ==
X-Gm-Message-State: AC+VfDyDk7uiZnpE79mz7H5bOnw9Oac1N5G8M2oYhg/ahn/YOCHpAAYq
        Ww9WU5VPwkGYxpZ98f5gRIn7mQ3CqP5B5A==
X-Google-Smtp-Source: ACHHUZ40QLD0r7FQ+oH8qzAaHXlDa7z/eF2K6G4IAvLgfS0JoGJu+LKSt3wT/icBg4DRSiSU9TKWkg==
X-Received: by 2002:ac8:5994:0:b0:3f3:8819:67ef with SMTP id e20-20020ac85994000000b003f3881967efmr1755786qte.43.1686734871236;
        Wed, 14 Jun 2023 02:27:51 -0700 (PDT)
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com. [209.85.219.47])
        by smtp.gmail.com with ESMTPSA id w11-20020ac84d0b000000b003ee2fb84d0dsm4887221qtv.11.2023.06.14.02.27.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Jun 2023 02:27:51 -0700 (PDT)
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-62fe3f0903aso3329516d6.3;
        Wed, 14 Jun 2023 02:27:51 -0700 (PDT)
X-Received: by 2002:a25:3249:0:b0:ba8:199b:9ec2 with SMTP id
 y70-20020a253249000000b00ba8199b9ec2mr1412111yby.31.1686734566067; Wed, 14
 Jun 2023 02:22:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230613223827.532680283@linutronix.de> <20230613224545.254342916@linutronix.de>
In-Reply-To: <20230613224545.254342916@linutronix.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 14 Jun 2023 11:22:33 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUbBs5dE_Yi+gX8MNCqduP87S+w+T4B_JjVynbDyE=Waw@mail.gmail.com>
Message-ID: <CAMuHMdUbBs5dE_Yi+gX8MNCqduP87S+w+T4B_JjVynbDyE=Waw@mail.gmail.com>
Subject: Re: [patch 06/17] m68k/cpu: Switch to arch_cpu_finalize_init()
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Nikolay Borisov <nik.borisov@suse.com>,
        "Ahmed S. Darwish" <darwi@linutronix.de>,
        Arnd Bergmann <arnd@arndb.de>, linux-m68k@lists.linux-m68k.org,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>, loongarch@lists.linux.dev,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        linux-sh@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        sparclinux@vger.kernel.org, Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-um@lists.infradead.org,
        Richard Henderson <richard.henderson@linaro.org>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Chris Zankel <chris@zankel.net>,
        Tom Lendacky <thomas.lendacky@amd.com>
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

On Wed, Jun 14, 2023 at 1:39 AM Thomas Gleixner <tglx@linutronix.de> wrote:
> check_bugs() is about to be phased out. Switch over to the new
> arch_cpu_finalize_init() implementation.
>
> No functional change.
>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
