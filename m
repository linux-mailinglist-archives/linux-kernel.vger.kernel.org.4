Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 484A3625E06
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 16:15:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234071AbiKKPO5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 10:14:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234955AbiKKPOO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 10:14:14 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFFC779D1F;
        Fri, 11 Nov 2022 07:12:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=D8FZp1ft+cLCoa6pMiMxNTi9KI6vPR9oR1nW5qk0rhk=; b=kSljiM25WwO9sf5SP1+ICLgxio
        h82G82U3fZtIowY2I7F7nZ6Shey0Zh27YWNa2tPXwax+rdhKgxFY9hlGjXFzstiJcINsWpZw7e9wi
        JDZJY/r89oDzUn7iqBA0jadugqrdbmSX6VB4Nk3n+SAiQ7eu6rLrpxoiBO1LUAZ+VCfPQUVfpgI3b
        q4j/CCfp0GUeeJEYY9lkeq1vcvHycthqZJ+LvCJB16L3V37uML/AvFoEDE8wKQ4Ji7KKR7w7EXGjR
        qtKVM1z/aS2zkqofvgrXzQ3KTZwLlAMVNizN37f76cmj0lYV57LYfa3NNcc/zPwkzZ4zlVm5fHX6Y
        kHKTTlsg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1otVhk-00GUTe-5b; Fri, 11 Nov 2022 15:12:28 +0000
Date:   Fri, 11 Nov 2022 07:12:28 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Nick Alcock <nick.alcock@oracle.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        arnd@arndb.de, akpm@linux-foundation.org, eugene.loh@oracle.com,
        kris.van.hees@oracle.com
Subject: Re: [PATCH v9 2/8] kbuild: add modules_thick.builtin
Message-ID: <Y25mXAGty35I5lQx@bombadil.infradead.org>
References: <20221109134132.9052-1-nick.alcock@oracle.com>
 <20221109134132.9052-3-nick.alcock@oracle.com>
 <Y2x22mKtaZvC7ZSk@bombadil.infradead.org>
 <87h6z5wqlk.fsf@esperi.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87h6z5wqlk.fsf@esperi.org.uk>
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

On Fri, Nov 11, 2022 at 01:47:03PM +0000, Nick Alcock wrote:
> +arch/x86/crypto/libblake2s-x86_64.o: arch/x86/crypto/blake2s-core.o arch/x86/crypto/blake2s-glue.o
> 
> But...
> 
> obj-$(CONFIG_CRYPTO_BLAKE2S_X86) += libblake2s-x86_64.o
> libblake2s-x86_64-y := blake2s-core.o blake2s-glue.o
> 
> config CRYPTO_BLAKE2S_X86
>         bool "Hash functions: BLAKE2s (SSSE3/AVX-512)"
> 
> This cannot be built as a module.

mcgrof@fulton ~/linux (git::modules-next)$ git grep MODULE_LICENSE arch/x86/crypto/blake2s-*
arch/x86/crypto/blake2s-glue.c:MODULE_LICENSE("GPL v2");

Try removing that.

  Luis
