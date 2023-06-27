Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1A517401AF
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 18:52:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232055AbjF0Qwm convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 27 Jun 2023 12:52:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231345AbjF0Qwj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 12:52:39 -0400
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 094AF10F;
        Tue, 27 Jun 2023 09:52:36 -0700 (PDT)
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3a04cb10465so3423329b6e.3;
        Tue, 27 Jun 2023 09:52:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687884755; x=1690476755;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3lIZI96K9vdLoSwUwpQZZH+ZWrx3VsFWqYpi3+69yqU=;
        b=j8UVkCGUTQm4cypu9sZY06fFuoeRVjQB3Tcp1KkWVs8FGlEHu5iHdNIL4L9wAZSM3g
         o4IxO8Yjz1rxMpjtE0FC2o+TnQVwgEALAAeErTkDjqwi9Txf4BFzLkDPhmxurP8dOGvv
         6sBmGi48HC+3bWDJAN9+L8+tOUyW0OQshYw3hG3ayOYi9hCVkkay00SSMPSnOOeg/8oT
         /RfaJjmecA8jEludnHWb5IJaeqiO3yIiPyuqsHeZWrUYYc0lBFfJEZfvTj+MKg8fqRs5
         buW6R+8RofQtFLa49bmBVE2sw9UTywsX2woGDUBwI0GcPVUY2mavaXttbB14mwpFnMXH
         MYsw==
X-Gm-Message-State: AC+VfDyA0/0QXiyqbweQsnfFKdaey+PECZBQGXRxM4Hd3MUGu+nNAybG
        uJRNp8H4MIRqzCRL9XaME3Ew094+gDnpUecO
X-Google-Smtp-Source: ACHHUZ7sEtTDbMtXMYZM4wQdcH42Gj87XiCWCRSbYSHNx3mT9t9vREEcit/ZxlmEgYFy4cLekney/A==
X-Received: by 2002:a05:6808:3098:b0:3a3:3a0b:aab8 with SMTP id bl24-20020a056808309800b003a33a0baab8mr1642135oib.48.1687884755254;
        Tue, 27 Jun 2023 09:52:35 -0700 (PDT)
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com. [209.85.210.47])
        by smtp.gmail.com with ESMTPSA id l1-20020a544501000000b003a3600182f8sm337192oil.57.2023.06.27.09.52.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Jun 2023 09:52:34 -0700 (PDT)
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-6b44b5adfd3so3927087a34.3;
        Tue, 27 Jun 2023 09:52:34 -0700 (PDT)
X-Received: by 2002:a05:6358:f55:b0:132:d3b1:c34a with SMTP id
 c21-20020a0563580f5500b00132d3b1c34amr12105551rwj.7.1687884753801; Tue, 27
 Jun 2023 09:52:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230327121317.4081816-1-arnd@kernel.org> <20230327121317.4081816-22-arnd@kernel.org>
 <OS0PR01MB5922EDAFCD6DA0313DB99C5E86989@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <66899d69-1339-4a61-8612-6f8e452b0b26@app.fastmail.com>
In-Reply-To: <66899d69-1339-4a61-8612-6f8e452b0b26@app.fastmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 27 Jun 2023 18:52:22 +0200
X-Gmail-Original-Message-ID: <CAMuHMdV5gT1GDLODsUe0XibPRsRHazF4K-UhxTOQCjtC9Ba4mQ@mail.gmail.com>
Message-ID: <CAMuHMdV5gT1GDLODsUe0XibPRsRHazF4K-UhxTOQCjtC9Ba4mQ@mail.gmail.com>
Subject: Re: [PATCH 21/21] dma-mapping: replace custom code with generic implementation
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>,
        Arnd Bergmann <arnd@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Vineet Gupta <vgupta@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, guoren <guoren@kernel.org>,
        Brian Cain <bcain@quicinc.com>,
        Michal Simek <monstr@monstr.eu>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Stafford Horne <shorne@gmail.com>,
        Helge Deller <deller@gmx.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Rich Felker <dalias@libc.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        "David S . Miller" <davem@davemloft.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Christoph Hellwig <hch@lst.de>,
        Robin Murphy <robin.murphy@arm.com>,
        "Lad, Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "Conor.Dooley" <conor.dooley@microchip.com>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-oxnas@groups.io" <linux-oxnas@groups.io>,
        "linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>,
        "linux-hexagon@vger.kernel.org" <linux-hexagon@vger.kernel.org>,
        "linux-m68k@lists.linux-m68k.org" <linux-m68k@lists.linux-m68k.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        "linux-openrisc@vger.kernel.org" <linux-openrisc@vger.kernel.org>,
        "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>,
        "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
        "linux-xtensa@linux-xtensa.org" <linux-xtensa@linux-xtensa.org>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>
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

On Thu, Apr 13, 2023 at 2:52 PM Arnd Bergmann <arnd@arndb.de> wrote:
> On Thu, Apr 13, 2023, at 14:13, Biju Das wrote:
> > FYI, this patch breaks on RZ/G2L SMARC EVK board and Arnd will send V2
> > for fixing this issue.
> >
> > [10:53] <biju> [    3.384408] Unable to handle kernel paging request at
> > virtual address 000000004afb0080
>
> Right, sorry about this, I accidentally removed the 'phys_to_virt()'
> conversion on arm64.

Meh, I missed that, so I ended up bisecting this same failure...

This patch is now commit 801f1883c4bb70cc ("dma-mapping: replace
custom code with generic implementation") in esmil/jh7100-dmapool,
and broke booting on R-Car Gen3.

The following gmail-whitespace-damaged patch fixes that:

diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
index 97b7cea5eb23aedd..77e0b68b43e5849a 100644
--- a/arch/arm64/mm/dma-mapping.c
+++ b/arch/arm64/mm/dma-mapping.c
@@ -15,17 +15,23 @@

 static inline void arch_dma_cache_wback(phys_addr_t paddr, size_t size)
 {
-       dcache_clean_poc(paddr, paddr + size);
+       unsigned long start = (unsigned long)phys_to_virt(paddr);
+
+       dcache_clean_poc(start, start + size);
 }

 static inline void arch_dma_cache_inv(phys_addr_t paddr, size_t size)
 {
-       dcache_inval_poc(paddr, paddr + size);
+       unsigned long start = (unsigned long)phys_to_virt(paddr);
+
+       dcache_inval_poc(start, start + size);
 }

 static inline void arch_dma_cache_wback_inv(phys_addr_t paddr, size_t size)
 {
-       dcache_clean_inval_poc(paddr, paddr + size);
+       unsigned long start = (unsigned long)phys_to_virt(paddr);
+
+       dcache_clean_inval_poc(start, start + size);
 }

 static inline bool arch_sync_dma_clean_before_fromdevice(void)

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
