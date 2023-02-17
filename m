Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64CF569ADF0
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 15:22:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbjBQOWv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 09:22:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjBQOWt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 09:22:49 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE6756D27A
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 06:21:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676643696;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MjVXynfbooLeK3lh/BnC3ySYEJ/T8LeumorHab9HlOY=;
        b=has+5tL3KfCTt/MgKM2Pb0YgIeR6i832hGWBDfe3kZ2T5VxAycqL3AwVTU0B4zHaa9h9LG
        9uWxiMZOusc1NLmN2XNhKSHlgYYl6lY7JCMqIJAZI3E+NsnVSni745QLU5yvxdP7eXQ2U9
        vkvypuYP7PPIKH0dSVdv5P0goKQVJ8c=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-672-RgGbByAVPBmBxs3XCk8YgA-1; Fri, 17 Feb 2023 09:21:30 -0500
X-MC-Unique: RgGbByAVPBmBxs3XCk8YgA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CE4523801F58;
        Fri, 17 Feb 2023 14:21:29 +0000 (UTC)
Received: from localhost (ovpn-12-99.pek2.redhat.com [10.72.12.99])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id BAB3A492B01;
        Fri, 17 Feb 2023 14:21:27 +0000 (UTC)
Date:   Fri, 17 Feb 2023 22:21:23 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Matthew Wilcox <willy@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        David Laight <David.Laight@aculab.com>,
        Stafford Horne <shorne@gmail.com>,
        "James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>,
        "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>
Subject: Re: [PATCH v4 12/16] parisc: mm: Convert to GENERIC_IOREMAP
Message-ID: <Y++NY7iPvNAVbwMv@MiWiFi-R3L-srv>
References: <20230216123419.461016-1-bhe@redhat.com>
 <20230216123419.461016-13-bhe@redhat.com>
 <Y+40p3oegc2Of9w2@casper.infradead.org>
 <Y+5Fcc6wsbr0qmoN@MiWiFi-R3L-srv>
 <bff4f286-ccf8-40bc-8fe5-d4041adf89f5@app.fastmail.com>
 <Y++Bypsg9YCmUEcd@MiWiFi-R3L-srv>
 <107be2c9-021b-85f6-d32d-ddb9e75ce24f@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <107be2c9-021b-85f6-d32d-ddb9e75ce24f@csgroup.eu>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/17/23 at 01:46pm, Christophe Leroy wrote:
> 
> 
> Le 17/02/2023 à 14:31, Baoquan He a écrit :
> > On 02/16/23 at 04:18pm, Arnd Bergmann wrote:
> >> On Thu, Feb 16, 2023, at 16:02, Baoquan He wrote:
> >>> On 02/16/23 at 01:50pm, Matthew Wilcox wrote:
> >>> It's not if including asm-generic/iomap.h. The ARCH_HAS_IOREMAP_xx is to
> >>> avoid redefinition there.
> >>>
> >>> include/asm-generic/iomap.h:
> >>> ----
> >>> #ifndef ARCH_HAS_IOREMAP_WC
> >>> #define ioremap_wc ioremap
> >>> #endif
> >>
> >> I'd change that to the usual '#ifndef ioremap_wc' in that case.
> > 
> > Not sure if I got you. Kill all ARCH_HAS_IOREMAP_xxx in kernel? If yes,
> > sounds like a good idea.
> > 
> 
> At least kill that one at the first place in your series, and then the 
> other ones in a follow-up series maybe.

Then we can make a preparation patch to change that in iomap.h, then
remove all ARCH_HAS_IOREMAP_WC definition in arch. I thought to let this
patch as is,  then get rid of all ARCH_HAS_IOREMAP_xxx in a follow-up
series. While the former is also fine to me. Thanks, Christophe.

diff --git a/include/asm-generic/iomap.h b/include/asm-generic/iomap.h
index 08237ae8b840..5fa1e9ca951c 100644
--- a/include/asm-generic/iomap.h
+++ b/include/asm-generic/iomap.h
@@ -93,7 +93,7 @@ extern void __iomem *ioport_map(unsigned long port, unsigned int nr);
 extern void ioport_unmap(void __iomem *);
 #endif
 
-#ifndef ARCH_HAS_IOREMAP_WC
+#ifndef ioremap_wc
 #define ioremap_wc ioremap
 #endif

[~]$ git grep ARCH_HAS_IOREMAP_WC
arch/loongarch/include/asm/io.h:#define ARCH_HAS_IOREMAP_WC
arch/mips/include/asm/io.h:#define ARCH_HAS_IOREMAP_WC
arch/powerpc/include/asm/io.h:#define ARCH_HAS_IOREMAP_WC
arch/x86/include/asm/io.h:#define ARCH_HAS_IOREMAP_WC
drivers/net/ethernet/sfc/io.h:#ifdef ARCH_HAS_IOREMAP_WC
drivers/net/ethernet/sfc/siena/io.h:#ifdef ARCH_HAS_IOREMAP_WC
include/asm-generic/iomap.h:#ifndef ARCH_HAS_IOREMAP_WC


