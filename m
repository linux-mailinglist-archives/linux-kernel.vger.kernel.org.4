Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1084068C549
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 18:56:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229911AbjBFR4R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 12:56:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbjBFR4P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 12:56:15 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FD682E0E0;
        Mon,  6 Feb 2023 09:56:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6016AB815BA;
        Mon,  6 Feb 2023 17:55:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA3A2C4339B;
        Mon,  6 Feb 2023 17:55:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675706140;
        bh=Ae8ahgrXCjguoyjKP55HCIgm3aCLf8flqpkKfxRi2UE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=i3MQ4jguZX3O/24lIfurL6OHr2x/g+Nzr5gyj3DHF7br3GjFUnrdnw05Jadt2X7IC
         L+I8kx2OWxzXI78cN5AmKhEZvkT5MqPyrE3j44s/lkJwegzVk55mug+J6ALpBSE6Ur
         NAS654e0WMfnOBkIn3cVG0NYpeoibJqfzHAN56IZzfDi4w0iUprue0xaupzL0vtCfU
         iWwd6N3AMD8slVZyGj9lptSgY8fh7yG1/NqghZs1e7RM9SSy3rKlqQ0QIECUV1vwG5
         3QxkP+JAD5yJquiDDftw+qggr4C6eAsPk+QhG/1ZPei9kngFoHGwI/sdb/qznO0ywi
         xFK5NkpFXFfOQ==
Received: by mail-lj1-f179.google.com with SMTP id b13so12876791ljf.8;
        Mon, 06 Feb 2023 09:55:39 -0800 (PST)
X-Gm-Message-State: AO0yUKWM7vul4XHQSzw0Hh+TIkp+JaqEo2rMiCjei+y1WrhQJgCBKopE
        R1ClgZO6L3JL0cczk3uRVhyOHvGFknwZKMyP0Eg=
X-Google-Smtp-Source: AK7set99WtGxzi4v3ZIly20BIVKCHLH1EkVF7rLJBssDy9UdrGrh6Wh7TQovW6dTzTvx5N78sdVgE3tHfXLU1CymD50=
X-Received: by 2002:a2e:9254:0:b0:290:7c03:a98 with SMTP id
 v20-20020a2e9254000000b002907c030a98mr5901ljg.74.1675706137989; Mon, 06 Feb
 2023 09:55:37 -0800 (PST)
MIME-Version: 1.0
References: <20230203214500.745276-1-song@kernel.org>
In-Reply-To: <20230203214500.745276-1-song@kernel.org>
From:   Song Liu <song@kernel.org>
Date:   Mon, 6 Feb 2023 09:55:23 -0800
X-Gmail-Original-Message-ID: <CAPhsuW6KyaqHHXzFCfd9TBWkt-393Z7=SmQswTaYpifcKTd8tg@mail.gmail.com>
Message-ID: <CAPhsuW6KyaqHHXzFCfd9TBWkt-393Z7=SmQswTaYpifcKTd8tg@mail.gmail.com>
Subject: Re: [PATCH v9] module: replace module_layout with module_memory
To:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     hch@lst.de, kernel-team@meta.com,
        Luis Chamberlain <mcgrof@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 3, 2023 at 1:45 PM Song Liu <song@kernel.org> wrote:
>
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

This version passed build test by kernel test bot:

https://lore.kernel.org/linux-raid/63df0daa.eKYOEelTitBUzF+e%25lkp@intel.com/T/#u

>
> Signed-off-by: Song Liu <song@kernel.org>
> Cc: Luis Chamberlain <mcgrof@kernel.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: Christophe Leroy <christophe.leroy@csgroup.eu>>

[...]
