Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 376B5663654
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 01:33:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231392AbjAJAcn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 19:32:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237687AbjAJAcV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 19:32:21 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCD1BFACE
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 16:32:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7EE7FB810A8
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 00:32:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BCDFC433D2;
        Tue, 10 Jan 2023 00:32:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673310738;
        bh=l1VSkHBB0CxME/IdgOEe10bicdDDr3YWeWOHSBsngLQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uuQBRvicwt5Qrkb3Mvbi1fad0NsjU2jXSYqu+pjzPxYShCeMLlL/7AdkwW/qpe88I
         MD57HYZitN6UkAcB4Uv3ttkZ4Exy74kDdhKQlvWBYljzPoUV3RvscHvPsuQhtvbGJn
         F68PNCZlANgntqo7rHMXk441+RZplL0BMqmv4Oa/hG1jg7Cf11vW3e/kMZOktVnUC9
         8Gs6gaQUNIRi2TeUis6wORuTIb0pAi6jZr1H4bPS/E8YHwYLv2+EjBmUsxLvQAWeoR
         cmHRLkTXK6Vcark72OEZIarSDYtWL50DbUnw65aglmV1E1MV0vWKMSuI/Opx9j9Ht9
         /PfphiqZbVlXg==
From:   SeongJae Park <sj@kernel.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        SeongJae Park <sj@kernel.org>
Subject: Re: Linux 6.2-rc2
Date:   Tue, 10 Jan 2023 00:32:15 +0000
Message-Id: <20230110003215.139072-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <CAMj1kXHqQoqoys83nEp=Q6oT68+-GpCuMjfnYK9pMy-X_+jjKw@mail.gmail.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Jan 2023 11:58:48 +0100 Ard Biesheuvel <ardb@kernel.org> wrote:

> On Tue, 3 Jan 2023 at 03:13, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > On Mon, Jan 2, 2023 at 5:45 PM Guenter Roeck <linux@roeck-us.net> wrote:
> > >
[...] 
> --- a/include/asm-generic/vmlinux.lds.h
> +++ b/include/asm-generic/vmlinux.lds.h
> @@ -896,7 +896,7 @@
>   * Otherwise, the type of .notes section would become PROGBITS
> instead of NOTES.
>   */
>  #define NOTES                                                          \
> -       /DISCARD/ : { *(.note.GNU-stack) }                              \
> +       .note.GNU-stack : { *(.note.GNU-stack) }                        \
>         .notes : AT(ADDR(.notes) - LOAD_OFFSET) {                       \
>                 BOUNDED_SECTION_BY(.note.*, _notes)                     \
>         } NOTES_HEADERS                                                 \
> 
> The .note.GNU-stack has zero size, so the result should be the same.
> 

This also fixes ARCH=um build error on my system.

Tested-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ
