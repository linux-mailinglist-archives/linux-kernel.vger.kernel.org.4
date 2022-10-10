Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D96085F966A
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 02:59:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230012AbiJJA7E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Oct 2022 20:59:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230371AbiJJA6l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Oct 2022 20:58:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE13CBD063
        for <linux-kernel@vger.kernel.org>; Sun,  9 Oct 2022 17:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665362538;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VDShjrzwK1jKnCnAs96UVbaV43RvPyzhTgdsrfXV+I8=;
        b=I22ABh3APGFcbDIJU8poyJ54tCLaX6DIh7KLj+nULmZwQMWuMQ6SQQHHn1A7Z3+tATG2zI
        wTi9Yvp/dactxKX7Z+sjjnjr5EQtA22jEhoBxvVA0/KceK2RYqCci3Xi/dTG317+0e4woS
        Ilusxu7jcHHzmNVwC9J0HqzcQOSSbXE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-369-j3XBEPeTPN2bfQw2tWweCg-1; Sun, 09 Oct 2022 20:17:09 -0400
X-MC-Unique: j3XBEPeTPN2bfQw2tWweCg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 44DBA849415;
        Mon, 10 Oct 2022 00:17:08 +0000 (UTC)
Received: from localhost (ovpn-12-34.pek2.redhat.com [10.72.12.34])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8FD8640FF656;
        Mon, 10 Oct 2022 00:17:06 +0000 (UTC)
Date:   Mon, 10 Oct 2022 08:17:02 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "hch@infradead.org" <hch@infradead.org>,
        "agordeev@linux.ibm.com" <agordeev@linux.ibm.com>,
        "wangkefeng.wang@huawei.com" <wangkefeng.wang@huawei.com>,
        "schnelle@linux.ibm.com" <schnelle@linux.ibm.com>,
        "David.Laight@ACULAB.COM" <David.Laight@aculab.com>,
        "shorne@gmail.com" <shorne@gmail.com>,
        Brian Cain <bcain@quicinc.com>,
        Mark Brown <broonie@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        "linux-hexagon@vger.kernel.org" <linux-hexagon@vger.kernel.org>
Subject: Re: [PATCH v3 01/11] hexagon: mm: Convert to GENERIC_IOREMAP
Message-ID: <Y0NkfggJTI1q/Yvy@MiWiFi-R3L-srv>
References: <20221009103114.149036-1-bhe@redhat.com>
 <20221009103114.149036-2-bhe@redhat.com>
 <83f292b8-0639-56b2-6dac-0475c34f623c@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <83f292b8-0639-56b2-6dac-0475c34f623c@csgroup.eu>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/09/22 at 04:39pm, Christophe Leroy wrote:
> 
> 
> Le 09/10/2022 à 12:31, Baoquan He a écrit :
> > By taking GENERIC_IOREMAP method, the generic ioremap_prot() and
> > iounmap() are visible and available to arch. Arch only needs to
> > provide implementation of arch_ioremap() or arch_iounmap() if there's
> > arch specific handling needed in its ioremap() or iounmap(). This
> > change will simplify implementation by removing duplicated codes with
> > generic ioremap() and iounmap(), and has the equivalent functioality.
> > 
> > For hexagon, the current ioremap() and iounmap() are the same as
> > generic version. After taking GENERIC_IOREMAP way, the old ioremap()
> > and iounmap() can be completely removed.
> > 
> > Signed-off-by: Baoquan He <bhe@redhat.com>
> > Cc: Brian Cain <bcain@quicinc.com>
> > Cc: Mark Brown <broonie@kernel.org>
> > Cc: Linus Walleij <linus.walleij@linaro.org>
> > Cc: linux-hexagon@vger.kernel.org
> > ---
> > v2->v3:
> >    Rewrite patch log.
> >    Put it at the beginning of patchset since it doesn't introduce new
> >    arch_ioremap()/arch_iounmap().
> > 
> >   arch/hexagon/Kconfig          |  1 +
> >   arch/hexagon/include/asm/io.h |  9 +++++--
> >   arch/hexagon/mm/ioremap.c     | 44 -----------------------------------
> >   3 files changed, 8 insertions(+), 46 deletions(-)
> >   delete mode 100644 arch/hexagon/mm/ioremap.c
> > 
> > diff --git a/arch/hexagon/Kconfig b/arch/hexagon/Kconfig
> > index 54eadf265178..17afffde1a7f 100644
> > --- a/arch/hexagon/Kconfig
> > +++ b/arch/hexagon/Kconfig
> > @@ -25,6 +25,7 @@ config HEXAGON
> >   	select NEED_SG_DMA_LENGTH
> >   	select NO_IOPORT_MAP
> >   	select GENERIC_IOMAP
> > +	select GENERIC_IOREMAP
> >   	select GENERIC_SMP_IDLE_THREAD
> >   	select STACKTRACE_SUPPORT
> >   	select GENERIC_CLOCKEVENTS_BROADCAST
> > diff --git a/arch/hexagon/include/asm/io.h b/arch/hexagon/include/asm/io.h
> > index 46a099de85b7..dcd9cbbf5934 100644
> > --- a/arch/hexagon/include/asm/io.h
> > +++ b/arch/hexagon/include/asm/io.h
> > @@ -170,8 +170,13 @@ static inline void writel(u32 data, volatile void __iomem *addr)
> >   #define writew_relaxed __raw_writew
> >   #define writel_relaxed __raw_writel
> >   
> > -void __iomem *ioremap(unsigned long phys_addr, unsigned long size);
> > -#define ioremap_uc(X, Y) ioremap((X), (Y))
> > +/*
> > + * I/O memory mapping functions.
> > + */
> > +#define _PAGE_IOREMAP (_PAGE_PRESENT | _PAGE_READ | _PAGE_WRITE | \
> > +		       (__HEXAGON_C_DEV << 6))
> > +
> > +#define ioremap_uc(addr, size) ioremap((addr), (size))
> 
> Why do you need to change this macro ?

I don't like the X, Y since they look meaningless. I can change back if
you like the old one. Thanks for checking.

