Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 308A468F2D5
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 17:07:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230365AbjBHQHF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 11:07:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjBHQHD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 11:07:03 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CB7B460BB;
        Wed,  8 Feb 2023 08:07:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=I+8/zUoQiK+vQy80qJDNf+yWTBzPHdJgShoFpq1p2MA=; b=SoJIEnEY/Cemy5seqHZ9JFmTMd
        a06i0nD26pTQDw/xDS5VYYD4VB5/YEA534bCu0v3imj+4+yu8Q98hf06hGLZ7rBCDv3N45I6TFWiN
        arYFsB7TZ6IlE+CpG++ifMttPiyqx2wZilomoPoGFWjliol1lVl0nf8l+qk9KmQu4wH85R2MStxLx
        IDR7+yQ2uBY0S81kINNTtEN9vnxJuyk+iYJCrsOAZA4uWQtEDsC+sSc4eFLTxLlM9Fc0hFmicAz1z
        /ezAS+1NDGAcCEhnKsigJh7cPV3oxqu6cvVga0wHNAslyuI9o4u8aOPDvaYs4DnGEC2ZEsxViLCBI
        vnDNxmsA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pPmyI-00GChE-QD; Wed, 08 Feb 2023 16:06:58 +0000
Date:   Wed, 8 Feb 2023 08:06:58 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Song Liu <song@kernel.org>, linux-modules@vger.kernel.org,
        linux-kernel@vger.kernel.org, hch@lst.de, kernel-team@meta.com,
        Peter Zijlstra <peterz@infradead.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: Re: [PATCH v10] module: replace module_layout with module_memory
Message-ID: <Y+PIohsycXjJpdr5@bombadil.infradead.org>
References: <20230207002802.2514802-1-song@kernel.org>
 <87357gv9ha.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87357gv9ha.ffs@tglx>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 08, 2023 at 09:37:21AM +0100, Thomas Gleixner wrote:
> On Mon, Feb 06 2023 at 16:28, Song Liu wrote:
> > module_layout manages different types of memory (text, data, rodata, etc.)
> > in one allocation, which is problematic for some reasons:
> >
> > 1. It is hard to enable CONFIG_STRICT_MODULE_RWX.
> > 2. It is hard to use huge pages in modules (and not break strict rwx).
> > 3. Many archs uses module_layout for arch-specific data, but it is not
> >    obvious how these data are used (are they RO, RX, or RW?)
> >
> > Improve the scenario by replacing 2 (or 3) module_layout per module with
> > up to 7 module_memory per module:
> >
> >         MOD_TEXT,
> >         MOD_DATA,
> >         MOD_RODATA,
> >         MOD_RO_AFTER_INIT,
> >         MOD_INIT_TEXT,
> >         MOD_INIT_DATA,
> >         MOD_INIT_RODATA,
> >
> > and allocating them separately. This adds slightly more entries to
> > mod_tree (from up to 3 entries per module, to up to 7 entries per
> > module). However, this at most adds a small constant overhead to
> > __module_address(), which is expected to be fast.
> >
> > Various archs use module_layout for different data. These data are put
> > into different module_memory based on their location in module_layout.
> > IOW, data that used to go with text is allocated with MOD_MEM_TYPE_TEXT;
> > data that used to go with data is allocated with MOD_MEM_TYPE_DATA, etc.
> >
> > module_memory simplifies quite some of the module code. For example,
> > ARCH_WANTS_MODULES_DATA_IN_VMALLOC is a lot cleaner, as it just uses a
> > different allocator for the data. kernel/module/strict_rwx.c is also
> > much cleaner with module_memory.
> >
> > Signed-off-by: Song Liu <song@kernel.org>
> > Cc: Luis Chamberlain <mcgrof@kernel.org>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Guenter Roeck <linux@roeck-us.net>
> > Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
> 
> With the comment update folded in:
> 
> Reviewed-by: Thomas Gleixner <tglx@linutronix.de>

Thanks! I've merged this onto modules-next for winder testing.
It is too late for v6.2 as we're on rc7 but this just means we'll
get testing on linux-next for a good while for v6.3.

If other folks do complete review please send your Reviewed-by
annotation so I can ammend the commit log as we go.

  Luis
