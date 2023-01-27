Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8211B67F071
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 22:32:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229533AbjA0VcL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 16:32:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjA0VcJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 16:32:09 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90D7C199E6;
        Fri, 27 Jan 2023 13:32:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 55BE6B821EC;
        Fri, 27 Jan 2023 21:32:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECB15C433A1;
        Fri, 27 Jan 2023 21:32:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674855126;
        bh=4+1HdPalIF26/Jx7D5F4nVUT+Y0EyvNy1tTfIlvU7WI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=m1SOff2Jld5NMu7jjStPh4+P2RheTRS4zLJSV2QdBmOXdqLFiSqiYKMuoLRw4CNVM
         otK+U5HkxtCCgBV4Px7f9tP6mEF2QIOELSAcApQs9xfjPuVmttGb4knZRIqCx8l/rH
         eyoki57K97sKbH3PHEF9EYot3tO3Kji8PxiF4Pl4EZdx9ukwPmlxLQhmR5v8hVvO8p
         ZqCVqFXYqblsPVLuRRyNCtuNWUq6I9yFmBKfjO12rXFMK6XNvuX4lZmKgy8vousbJZ
         u6KRqlpjzaudgIfTsig8xw2BFR19MyQnINcTaGL1S8lIrYYgQaNG7mvaYbtfIBoPr6
         QN/4yRJu3W4GA==
Received: by mail-lf1-f41.google.com with SMTP id bp15so10120841lfb.13;
        Fri, 27 Jan 2023 13:32:05 -0800 (PST)
X-Gm-Message-State: AFqh2kqqHAUEWwqjbtkiBFcpEeCC6Nho8zNqanoN9qkgzS5s173YWpdM
        U6KTiWGpNJmhtG5Jc4IAdX2G8HXe+N7Vcapb3HQ=
X-Google-Smtp-Source: AMrXdXuj5cT0wzZDzeJakyQRQUvbsFPBHaSSnesNBuYwQ4XuAL6rMs3Ujs8Pg2QG1n3yD3stssJSBJDLD49RFbbmsYo=
X-Received: by 2002:a05:6512:3450:b0:4b5:7dcb:161b with SMTP id
 j16-20020a056512345000b004b57dcb161bmr3562201lfr.74.1674855123888; Fri, 27
 Jan 2023 13:32:03 -0800 (PST)
MIME-Version: 1.0
References: <20230126233606.1317794-1-song@kernel.org> <20230127204011.GA45594@roeck-us.net>
In-Reply-To: <20230127204011.GA45594@roeck-us.net>
From:   Song Liu <song@kernel.org>
Date:   Fri, 27 Jan 2023 13:31:51 -0800
X-Gmail-Original-Message-ID: <CAPhsuW4nPo_OFwspn18N-pKpPjc6vOYBJp8hE7O5mYEweKUySg@mail.gmail.com>
Message-ID: <CAPhsuW4nPo_OFwspn18N-pKpPjc6vOYBJp8hE7O5mYEweKUySg@mail.gmail.com>
Subject: Re: [PATCH v3] module: replace module_layout with module_memory
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, Luis Chamberlain <mcgrof@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guenter,

Thanks for running the test!

On Fri, Jan 27, 2023 at 12:40 PM Guenter Roeck <linux@roeck-us.net> wrote:
>
> On Thu, Jan 26, 2023 at 03:36:06PM -0800, Song Liu wrote:
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
> >         MOD_MEM_TYPE_TEXT,
> >         MOD_MEM_TYPE_DATA,
> >         MOD_MEM_TYPE_RODATA,
> >         MOD_MEM_TYPE_RO_AFTER_INIT,
> >         MOD_MEM_TYPE_INIT_TEXT,
> >         MOD_MEM_TYPE_INIT_DATA,
> >         MOD_MEM_TYPE_INIT_RODATA,
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
> >
> > ---
>
> Build reference: v6.2-rc5-52-gc96fb00
> Compiler version: powerpc64-linux-gcc (GCC) 11.3.0
> Assembler version: GNU assembler (GNU Binutils) 2.39
>
> Building powerpc:defconfig ... passed
> Building powerpc:allmodconfig ... passed
> Building powerpc:ppc32_allmodconfig ... failed
> --------------
> Error log:
> kernel/module/main.c: In function 'show_coresize':
> kernel/module/main.c:938:22: error: unused variable 'size' [-Werror=unused-variable]
>   938 |         unsigned int size = 0;

Fixed this in my local branch:

diff --git c/kernel/module/main.c w/kernel/module/main.c
index 32f63c6eaa61..da2bca75e4a8 100644
--- c/kernel/module/main.c
+++ w/kernel/module/main.c
@@ -935,8 +935,6 @@ struct module_attribute module_uevent =
 static ssize_t show_coresize(struct module_attribute *mattr,
                             struct module_kobject *mk, char *buffer)
 {
-       unsigned int size = 0;
-
        return sprintf(buffer, "%u\n",
                       mk->mod->mod_mem[MOD_MEM_TYPE_TEXT].size);
 }

Song
