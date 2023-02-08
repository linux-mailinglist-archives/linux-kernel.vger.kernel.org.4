Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 885AF68E9FA
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 09:37:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230296AbjBHIh0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 03:37:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjBHIhZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 03:37:25 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6826FF1F;
        Wed,  8 Feb 2023 00:37:23 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1675845441;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uDbjeGgIYWaFAExc2nluK89DKG6OXifSTuEpjBp5fwI=;
        b=QyZBW7lq3MBckKY/jl+SMVkPNApyyxouz1QP/+JsSP7uqUqR/CzFzQmh0LMQsytXdhfL/B
        bxK+a/sOgm5fcazzmjiUxdK9PIEH7FWkhh2JpkBCbIwISmWo1WxrFVrxJkhkV/azPYnmf6
        /mL+9mq+F045Glth7VDG4YzFUp7seqDT0/Ad6w7aeT9moTkKBeIhgHI6B4ENtENyUdNeXC
        vPYybrptemIOqUP7XVIy/sskq1p3GmuWRA8KVuDj/eFColW2v8i1V/AmbzR2Us3U2TccNI
        wji4o67nx3ZYHeAbIRTW/06H+k1N2NbeGUUt3KLdZMH0EFVlE9PHJUMzxsk4Ag==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1675845441;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uDbjeGgIYWaFAExc2nluK89DKG6OXifSTuEpjBp5fwI=;
        b=tZ4E57KZE9hJ6JtORuVoYAHVh3WSKDm8aPh0PgMBx6oxbaeMpVpumMjV/K3XJjDxNJen8D
        mE07vsS7egJa9GDg==
To:     Song Liu <song@kernel.org>, linux-modules@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     hch@lst.de, kernel-team@meta.com, Song Liu <song@kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: Re: [PATCH v10] module: replace module_layout with module_memory
In-Reply-To: <20230207002802.2514802-1-song@kernel.org>
References: <20230207002802.2514802-1-song@kernel.org>
Date:   Wed, 08 Feb 2023 09:37:21 +0100
Message-ID: <87357gv9ha.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 06 2023 at 16:28, Song Liu wrote:
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
>         MOD_TEXT,
>         MOD_DATA,
>         MOD_RODATA,
>         MOD_RO_AFTER_INIT,
>         MOD_INIT_TEXT,
>         MOD_INIT_DATA,
>         MOD_INIT_RODATA,
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

With the comment update folded in:

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
