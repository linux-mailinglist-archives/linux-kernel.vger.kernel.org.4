Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 589C8682B98
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 12:36:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230239AbjAaLg5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 06:36:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229985AbjAaLgv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 06:36:51 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 359757DA2;
        Tue, 31 Jan 2023 03:36:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ZL+Crz10hxNR+pj8dNZ96T3za2U74w03KPhLNLAS+Ds=; b=YR08jCcROeTCb45XeK2Tk7y5GL
        Pq6aRtclS0Yd31moGLqy3jRj3zUD69JOwcIsyFQt2dFM7WDDtyKhR+n067tn4IEMbpsNEBVLRowen
        ugSGyKLE34Z6LqyaAYP8GNGYOSdXzn427bZ+HW92LfLAlas2ORXaaPmdwz1t22D/bRfTWJnUk92Ym
        lLDoM2q9siJ+XueqOm4iOBAD9/ciVCiRJPOUNBqd2Em0FWJqW1V+hmPMnHopQ/xWzeKA9LqxLDTgN
        nq4gDg4WnyyIwiZoUmeCOV4YFSScYj2AAJCEXM0yRwn3Y/MJ6Ny1ynpqNKSMxL82jvA/ACMlG9hd9
        LqoOccyQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pMovo-004Kvq-2p;
        Tue, 31 Jan 2023 11:36:09 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 665933002BF;
        Tue, 31 Jan 2023 12:36:42 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4E88620B506EA; Tue, 31 Jan 2023 12:36:42 +0100 (CET)
Date:   Tue, 31 Jan 2023 12:36:42 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Song Liu <song@kernel.org>
Cc:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        hch@lst.de, kernel-team@meta.com,
        Luis Chamberlain <mcgrof@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Guenter Roeck <linux@roeck-us.net>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: Re: [PATCH v4] module: replace module_layout with module_memory
Message-ID: <Y9j9Svys7eb9E2Mh@hirez.programming.kicks-ass.net>
References: <20230130182109.3571524-1-song@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230130182109.3571524-1-song@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 30, 2023 at 10:21:09AM -0800, Song Liu wrote:
> module_layout manages different types of memory (text, data, rodata, etc.)
> in one allocation, which is problematic for some reasons:
> 
> 1. It is hard to enable CONFIG_STRICT_MODULE_RWX.
> 2. It is hard to use huge pages in modules (and not break strict rwx).
> 3. Many archs uses module_layout for arch-specific data, but it is not
>    obvious how these data are used (are they RO, RX, or RW?)
> 
> Improve the scenario by replacing 2 (or 3) module_layout per module with
> up to 7 module_memory per module:
> 
>         MOD_MEM_TYPE_TEXT,
>         MOD_MEM_TYPE_DATA,
>         MOD_MEM_TYPE_RODATA,
>         MOD_MEM_TYPE_RO_AFTER_INIT,
>         MOD_MEM_TYPE_INIT_TEXT,
>         MOD_MEM_TYPE_INIT_DATA,
>         MOD_MEM_TYPE_INIT_RODATA,
> 
> and allocating them separately. This adds slightly more entries to
> mod_tree (from up to 3 entries per module, to up to 7 entries per
> module). However, this at most adds a small constant overhead to
> __module_address(), which is expected to be fast.
> 
> Various archs use module_layout for different data. These data are put
> into different module_memory based on their location in module_layout.
> IOW, data that used to go with text is allocated with MOD_MEM_TYPE_TEXT;
> data that used to go with data is allocated with MOD_MEM_TYPE_DATA, etc.
> 
> module_memory simplifies quite some of the module code. For example,
> ARCH_WANTS_MODULES_DATA_IN_VMALLOC is a lot cleaner, as it just uses a
> different allocator for the data. kernel/module/strict_rwx.c is also
> much cleaner with module_memory.
> 
> Signed-off-by: Song Liu <song@kernel.org>
> Cc: Luis Chamberlain <mcgrof@kernel.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
> 
> ---
> 
> This is the preparation work for the type aware module_alloc() discussed
> in [1]. While this work is not covered much in the discussion, it is a
> critical step of the effort.
> 
> As this part grows pretty big (~1000 lines, + and -), I would like get
> some feedback on it, so that I know it is on the right track.
> 
> Please share your comments. Thanks!

Aside from the things already reported I like where this is going.
