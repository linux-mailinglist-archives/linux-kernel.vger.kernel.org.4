Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9669C69F064
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 09:36:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbjBVIgd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 03:36:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230207AbjBVIga (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 03:36:30 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 357352C64F
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 00:35:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677054919;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rmxOmW2Bi0X9FdGRBJxRliQUyu7bX3a5ch+5lNPbh68=;
        b=ftydmFf1zAW3bh4a9vHDTgHxHxO899wVd0EjTomSQaj6pi9Q1TM10xAbA5znv5Gfijy6IW
        QExuS3RsTkucEANXmQYejmShEn8fEr3tVZ+U6d5pVxMsLqQbV2LhI6zaQ2Cp/yqJrYZJTM
        kdyNmeKB/XDBQdDSFTs8O7s4T3wr4UQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-3-MmktJbUpMh-UegbYJy6C9Q-1; Wed, 22 Feb 2023 03:35:14 -0500
X-MC-Unique: MmktJbUpMh-UegbYJy6C9Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 39BDD858F0E;
        Wed, 22 Feb 2023 08:35:13 +0000 (UTC)
Received: from localhost (ovpn-13-7.pek2.redhat.com [10.72.13.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 223FB440D9;
        Wed, 22 Feb 2023 08:35:11 +0000 (UTC)
Date:   Wed, 22 Feb 2023 16:35:08 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     Matthew Wilcox <willy@infradead.org>,
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
Message-ID: <Y/XTvJRtZXKa6b/M@MiWiFi-R3L-srv>
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
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christophe, Arnd,

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

I made a patch to remove all ARCH_HAS_IOREMAP_xx macros in architectures
and the ifdeffery of ARCH_HAS_IOREMAP_xx in asm-generic/iomap.h.
But the change will cause building error as below. Becuase we usually
have '#include <asm-generic/iomap.h>' at the beginning of
arch/xx/include/asm/io.h, and have '#include <asm-generic/io.h>' at the
end of arch/xx/include/asm/io.h. For architecutres which has
ARCH_HAS_IOREMAP_xx defining, we need move ''#include <asm-generic/iomap.h>
dowe to below '#include <asm-generic/io.h>'. Please help check if it's
still worth doing.


***move '#include <asm-generic/iomap.h>' below '#include <asm-generic/io.h>' 
***
diff --git a/arch/x86/include/asm/io.h b/arch/x86/include/asm/io.h
index 8ab68cde1f13..a8d55fc62959 100644
--- a/arch/x86/include/asm/io.h
+++ b/arch/x86/include/asm/io.h
@@ -209,8 +209,6 @@ void memset_io(volatile void __iomem *, int, size_t);
 #define memcpy_toio memcpy_toio
 #define memset_io memset_io
 
-#include <asm-generic/iomap.h>
-
 /*
  * ISA space is 'always mapped' on a typical x86 system, no need to
  * explicitly ioremap() it. The fact that the ISA IO space is mapped
@@ -329,6 +327,8 @@ extern bool is_early_ioremap_ptep(pte_t *ptep);
 #include <asm-generic/io.h>
 #undef PCI_IOBASE
 
+#include <asm-generic/iomap.h>
+
 #ifdef CONFIG_MTRR
 extern int __must_check arch_phys_wc_index(int handle);
 #define arch_phys_wc_index arch_phys_wc_index


***Building error after removing ARCH_HAS_IOREMAP_xx
***
In file included from ./include/linux/io.h:13,
                 from ./include/linux/irq.h:20,
                 from ./include/xen/events.h:6,
                 from arch/x86/entry/common.c:25:
./arch/x86/include/asm/io.h:321: warning: "ioremap_wc" redefined
  321 | #define ioremap_wc ioremap_wc
      | 
In file included from ./arch/x86/include/asm/io.h:212:
./include/asm-generic/iomap.h:97: note: this is the location of the previous definition
   97 | #define ioremap_wc ioremap
      | 
./arch/x86/include/asm/io.h:323: warning: "ioremap_wt" redefined
  323 | #define ioremap_wt ioremap_wt
      | 
./include/asm-generic/iomap.h:101: note: this is the location of the previous definition
  101 | #define ioremap_wt ioremap

