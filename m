Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C79B167DA17
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 00:58:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231485AbjAZX6o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 18:58:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230271AbjAZX6i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 18:58:38 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88E4935A8;
        Thu, 26 Jan 2023 15:58:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=JrUQl5Zg1GCL3QhZbSaC+fu5O6Oij/6noMvajuoC/G4=; b=s5rceDIruzP/VgMHl8FWZJ+x9F
        YZx1jeCDxJlJag+SYrAEOEpLHj7i/0/GzFf8x9lzz3tRtQtMbKjM6McGv7FbsP82oV0YajUolPfPH
        n9cLwRolCA6GU3depGrCUNXt/C6EQFk+oyy/cMu9umuegUJzDcBmH0ayzjGr+bN65Ginp8uRa7bW/
        wzBml/7KvTxiTXieoc/6jLC4I9tsVPfi0fTdXb10cExl4zul3qK7QkY+gh3fv8in0ShJHVEt3L2RE
        wUU5rjSFbmDzYrz0wFu8ndlD8Trr1oROkYtBIGkI495BYh3/vn8tuU64NosTA9L/BoWZph6kBxYN5
        B/0IcoWw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pLC8P-00Crmm-69; Thu, 26 Jan 2023 23:58:25 +0000
Date:   Thu, 26 Jan 2023 15:58:25 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Song Liu <song@kernel.org>
Cc:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v3] module: replace module_layout with module_memory
Message-ID: <Y9MToQW512fmyEYl@bombadil.infradead.org>
References: <20230126233606.1317794-1-song@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230126233606.1317794-1-song@kernel.org>
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

On Thu, Jan 26, 2023 at 03:36:06PM -0800, Song Liu wrote:
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

Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>

I'll add this new version to modules-testing. If we get any other
Reviewed-by, I'll throw onto modules-next.

  Luis
