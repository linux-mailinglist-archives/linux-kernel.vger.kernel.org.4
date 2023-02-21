Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02F9C69DF42
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 12:50:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233678AbjBULuC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 06:50:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234444AbjBULty (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 06:49:54 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B470D1BAFA
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 03:49:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676980149;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lQY8us4jogeZT2v9O2ixwk253cOCKZ2II1S+4Vrvqn8=;
        b=Knqs/svQiUM2vqY2aB5F1d/6SkOqKfMtd3AZfAPQCxqXB3hgbInQrv4O2xKTNAt8zOijwg
        DH3vOfqL8m019sW+a/MI+xtK7H/SnZncglQ013B3qY+lt79BHWXNuSAX6d93d4Euj+mcAZ
        W6Z9LXBtqtXzFoDWBlSj4scPuKEIxqo=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-638-yOHMpki1Ova29bUuoQP46A-1; Tue, 21 Feb 2023 06:49:03 -0500
X-MC-Unique: yOHMpki1Ova29bUuoQP46A-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8F1653848C29;
        Tue, 21 Feb 2023 11:49:02 +0000 (UTC)
Received: from localhost (ovpn-13-7.pek2.redhat.com [10.72.13.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C9FF840C1423;
        Tue, 21 Feb 2023 11:49:01 +0000 (UTC)
Date:   Tue, 21 Feb 2023 19:48:57 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Niklas Schnelle <schnelle@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, christophe.leroy@csgroup.eu,
        hch@infradead.org, agordeev@linux.ibm.com,
        wangkefeng.wang@huawei.com, David.Laight@aculab.com,
        shorne@gmail.com, arnd@arndb.de,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org
Subject: Re: [PATCH v4 09/16] s390: mm: Convert to GENERIC_IOREMAP
Message-ID: <Y/SvqcWQ+5sgozX/@MiWiFi-R3L-srv>
References: <20230216123419.461016-1-bhe@redhat.com>
 <20230216123419.461016-10-bhe@redhat.com>
 <9bb1154b07dc21e5d3dda8cc5238c5385f32c2e0.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9bb1154b07dc21e5d3dda8cc5238c5385f32c2e0.camel@linux.ibm.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/16/23 at 05:21pm, Niklas Schnelle wrote:
> On Thu, 2023-02-16 at 20:34 +0800, Baoquan He wrote:
> > By taking GENERIC_IOREMAP method, the generic generic_ioremap_prot(),
> > generic_iounmap(), and their generic wrapper ioremap_prot(), ioremap()
> > and iounmap() are all visible and available to arch. Arch needs to
> > provide wrapper functions to override the generic versions if there's
> > arch specific handling in its ioremap_prot(), ioremap() or iounmap().
> > This change will simplify implementation by removing duplicated codes
> > with generic_ioremap_prot() and generic_iounmap(), and has the equivalent
> > functioality as before.
> > 
> > Here, add wrapper functions ioremap_prot() and iounmap() for s390's
> > special operation when ioremap() and iounmap().
> > 
> > Signed-off-by: Baoquan He <bhe@redhat.com>
> > Cc: Niklas Schnelle <schnelle@linux.ibm.com>
> > Cc: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
> > Cc: Heiko Carstens <hca@linux.ibm.com>
> > Cc: Vasily Gorbik <gor@linux.ibm.com>
> > Cc: Alexander Gordeev <agordeev@linux.ibm.com>
> > Cc: Christian Borntraeger <borntraeger@linux.ibm.com>
> > Cc: Sven Schnelle <svens@linux.ibm.com>
> > Cc: linux-s390@vger.kernel.org
> > ---
> >  arch/s390/Kconfig          |  1 +
> >  arch/s390/include/asm/io.h | 21 ++++++++------
> >  arch/s390/pci/pci.c        | 57 +++++++-------------------------------
> >  3 files changed, 23 insertions(+), 56 deletions(-)
> 
> Thanks for the patch. This is a very clear improvement for us! I tested
> this series with s390 systems with and without the PCI memory-I/O (MIO)
> support and everything works as expected.
> 
> One thing I did stumble upon but which is independent from this patch
> is that I think memremap(…, MEMREMAP_WB) on system RAM outside the
> direct map is broken for us. At least on systems without PCI memory-I/O
> support. I think with this series it would be much easier to fix
> though. Basically I think we would have to define arch_memremap_wb() to
> generic_ioremap_prot(…, PAGE_KERNEL) and then have iounmap() check
> is_ioremap_addr() to see if it is an actual mapping or an address
> cookie. But again this is independent of this patch which doesn't
> change the behavior in this area.

OK, I can check this after this patchset done.

> 
> So feel free to add my:
> 
> Reviewed-by: Niklas Schnelle <schnelle@linux.ibm.com>
> Tested-by: Niklas Schnelle <schnelle@linux.ibm.com>

Thanks a lot, will add these when repost.

