Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8F647012A2
	for <lists+linux-kernel@lfdr.de>; Sat, 13 May 2023 01:50:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240007AbjELXuh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 19:50:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238380AbjELXuc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 19:50:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF64C2101
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 16:50:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5B83C65952
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 23:50:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 435ADC433D2;
        Fri, 12 May 2023 23:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1683935430;
        bh=hzop67DZgJlzybdRGNxWTsRFrxurG5n+8LvYrld9il0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=vvA0DDvRtyGiLNjGx1uCyKUbKt0d5DR/833iZeGeW+T4knyrOg3Yh9zON/OdPvLWH
         7NS4miXpHZ+w4nk0aoHxX9BNe8lY5nfrq/aiZThDR/zciA8sRPMUuYea43A5eMmjMa
         Y2FGA2Lb3vT8u2eK3XXWeRECHWzz2AuoTSOvw++M=
Date:   Fri, 12 May 2023 16:50:29 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Mark Brown <broonie@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com, linux-mm@kvack.org
Subject: Re: [PATCH 2/2] [v3] kasan: use internal prototypes matching gcc-13
 builtins
Message-Id: <20230512165029.9ce044570a2906e7185fe38c@linux-foundation.org>
In-Reply-To: <20230509145735.9263-2-arnd@kernel.org>
References: <20230509145735.9263-1-arnd@kernel.org>
        <20230509145735.9263-2-arnd@kernel.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue,  9 May 2023 16:57:21 +0200 Arnd Bergmann <arnd@kernel.org> wrote:

> gcc-13 warns about function definitions for builtin interfaces
> that have a different prototype, e.g.:
> 
> In file included from kasan_test.c:31:
> kasan.h:574:6: error: conflicting types for built-in function '__asan_register_globals'; expected 'void(void *, long int)' [-Werror=builtin-declaration-mismatch]
>   574 | void __asan_register_globals(struct kasan_global *globals, size_t size);
> kasan.h:577:6: error: conflicting types for built-in function '__asan_alloca_poison'; expected 'void(void *, long int)' [-Werror=builtin-declaration-mismatch]
>   577 | void __asan_alloca_poison(unsigned long addr, size_t size);
> kasan.h:580:6: error: conflicting types for built-in function '__asan_load1'; expected 'void(void *)' [-Werror=builtin-declaration-mismatch]
>   580 | void __asan_load1(unsigned long addr);
> kasan.h:581:6: error: conflicting types for built-in function '__asan_store1'; expected 'void(void *)' [-Werror=builtin-declaration-mismatch]
>   581 | void __asan_store1(unsigned long addr);
> kasan.h:643:6: error: conflicting types for built-in function '__hwasan_tag_memory'; expected 'void(void *, unsigned char,  long int)' [-Werror=builtin-declaration-mismatch]
>   643 | void __hwasan_tag_memory(unsigned long addr, u8 tag, unsigned long size);

I added cc:stable to these, but staged them for the next merge window.

Because I expect many people will compile earlier kernels many times
with gcc-13 and later, and they won't want to have to see these
warnings all the time.

