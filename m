Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1145F69DF33
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 12:46:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234359AbjBULqc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 06:46:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234327AbjBULqa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 06:46:30 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE7F627D6A
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 03:45:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676979843;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rMHzw2ydkY11A8KH8mnM5ZEO8BtRWeaIPv7LTXKpT14=;
        b=bfjx5sXDtC71SpcN0Lo2knoSDfccVz+S0lk4Yqzc5JRT/swSxeHjE/k5Hj1c8FnrCfT8LW
        LEE1GFDvn/OSvqPC4hYzV/Te2B4eDhq9xIKPkJ5ROkHV0CzxYyTHC9DnXZatLVUb0q/eRQ
        GyO64HA/wf4BJnm9e0AMTvW+IG3F6VU=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-131-LeicoknDNlaydltwoh845g-1; Tue, 21 Feb 2023 06:43:58 -0500
X-MC-Unique: LeicoknDNlaydltwoh845g-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6C497380673E;
        Tue, 21 Feb 2023 11:43:57 +0000 (UTC)
Received: from localhost (ovpn-13-7.pek2.redhat.com [10.72.13.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 38D12C15BA0;
        Tue, 21 Feb 2023 11:43:54 +0000 (UTC)
Date:   Tue, 21 Feb 2023 19:43:51 +0800
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
Message-ID: <Y/SudyUShbcJXqbY@MiWiFi-R3L-srv>
References: <20230216123419.461016-1-bhe@redhat.com>
 <20230216123419.461016-13-bhe@redhat.com>
 <Y+40p3oegc2Of9w2@casper.infradead.org>
 <Y+5Fcc6wsbr0qmoN@MiWiFi-R3L-srv>
 <bff4f286-ccf8-40bc-8fe5-d4041adf89f5@app.fastmail.com>
 <Y++Bypsg9YCmUEcd@MiWiFi-R3L-srv>
 <107be2c9-021b-85f6-d32d-ddb9e75ce24f@csgroup.eu>
 <Y++NY7iPvNAVbwMv@MiWiFi-R3L-srv>
 <97732d97-06a7-9307-7ad1-ef69d980f3d2@csgroup.eu>
 <73f98755-9230-c4d5-0e12-38e6f3b0a189@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <73f98755-9230-c4d5-0e12-38e6f3b0a189@csgroup.eu>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/17/23 at 02:35pm, Christophe Leroy wrote:
...... 
> > Not so many:
> > 
> > $ git grep ARCH_HAS_IOREMAP_WC  | grep define
> > arch/loongarch/include/asm/io.h:#define ARCH_HAS_IOREMAP_WC
> > arch/mips/include/asm/io.h:#define ARCH_HAS_IOREMAP_WC
> > arch/powerpc/include/asm/io.h:#define ARCH_HAS_IOREMAP_WC
> > arch/x86/include/asm/io.h:#define ARCH_HAS_IOREMAP_WC
> > 
> > And also make sure they define ioremap_wc :
> > 
> > $ git grep "define ioremap_wc" `git grep -l "define ARCH_HAS_IOREMAP_WC"`
> > arch/loongarch/include/asm/io.h:#define ioremap_wc(offset, size)        \
> > arch/mips/include/asm/io.h:#define ioremap_wc(offset, size) 
> >                         \
> > arch/powerpc/include/asm/io.h:#define ioremap_wc ioremap_wc
> > arch/x86/include/asm/io.h:#define ioremap_wc ioremap_wc
> > 
> 
> 
> By the way there are so few, you can make all at once:

OK, I will try to pack this into one preparation patch. Thanks.

> 
> $ git grep ARCH_HAS_IOREMAP_ | grep define
> arch/loongarch/include/asm/io.h:#define ARCH_HAS_IOREMAP_WC
> arch/m68k/include/asm/kmap.h:#define ARCH_HAS_IOREMAP_WT
> arch/mips/include/asm/io.h:#define ARCH_HAS_IOREMAP_WC
> arch/powerpc/include/asm/io.h:#define ARCH_HAS_IOREMAP_WC
> arch/powerpc/include/asm/io.h:#define ARCH_HAS_IOREMAP_WT
> arch/x86/include/asm/io.h:#define ARCH_HAS_IOREMAP_WC
> arch/x86/include/asm/io.h:#define ARCH_HAS_IOREMAP_WT
> 
> Christophe

