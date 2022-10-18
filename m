Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DD5E6026A3
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 10:20:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbiJRIU5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 04:20:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbiJRIUz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 04:20:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2837B80F55;
        Tue, 18 Oct 2022 01:20:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A1054614B9;
        Tue, 18 Oct 2022 08:20:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06662C4347C;
        Tue, 18 Oct 2022 08:20:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666081253;
        bh=lzJoGCCoxM2N2aUxL+sofQ9Ewzh0rmNyHzU7j6u9ujo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Ree7kUlqn6RF/C4bM0Sj/IsHoNhG+v0cnCz5A1u2DUNOmkY4497va9zNMQlAuEBse
         Wj6f3+CiNo1lKSthD69b2WP52nTyr+SbLIYOevYnQUqqAefXhkZ/iiRPEgc4b7mhQ1
         FyUSJsoZXpyDYRt4Qq4MgcOWEcE5B6aAV4ZqJMDW02xaVAQyyDkDfcqEDqsNM+POH/
         apMOZ17fpW5Pp+YkHbcU+d+wCnMdfKKe/yTiFYyhvs0TBH82K9UhTSkUg0VdApfV9F
         IR0OfF/FK7t2v1xLHYZsgcZCF4lUTaWsT+Hx8d+yGhtX/9EYzrLI4jGs9kIXXtmizT
         VjLlutQ2RMuxg==
Received: by mail-lf1-f50.google.com with SMTP id b1so21306230lfs.7;
        Tue, 18 Oct 2022 01:20:52 -0700 (PDT)
X-Gm-Message-State: ACrzQf2KV/gPzxOTQKaqhVklSyb8AH+11KbryZtVmcT0OIBdb/+VfOfp
        0dcaH06HRapHCCFHTeLtthid26yjYkvy9OMFna4=
X-Google-Smtp-Source: AMsMyM6L84iqkEwGUEuZU4ZaF6a6BvThJMz5KNlsHr6VosJotCoQ0vFz6PesWH97RzAGQVXE0KAd6HKJ++ek8GMi+fI=
X-Received: by 2002:a05:6512:150e:b0:492:d9fd:9bdf with SMTP id
 bq14-20020a056512150e00b00492d9fd9bdfmr567295lfb.583.1666081250880; Tue, 18
 Oct 2022 01:20:50 -0700 (PDT)
MIME-Version: 1.0
References: <20221018020519.never.337-kees@kernel.org>
In-Reply-To: <20221018020519.never.337-kees@kernel.org>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 18 Oct 2022 10:20:39 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGjF63wK7m8BqC=WX6sA425BTVwQWk9ERN3gG8s==4mjw@mail.gmail.com>
Message-ID: <CAMj1kXGjF63wK7m8BqC=WX6sA425BTVwQWk9ERN3gG8s==4mjw@mail.gmail.com>
Subject: Re: [PATCH 0/5] pstore: Use zstd directly by default for compression
To:     Kees Cook <keescook@chromium.org>
Cc:     Tony Luck <tony.luck@intel.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Nick Terrell <terrelln@fb.com>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Oct 2022 at 04:08, Kees Cook <keescook@chromium.org> wrote:
>
> Hi,
>
> Okay, here is a very lightly tested version of using zstd directly, which
> should save 128KB per CPU compare to using crypto API. This leaves the
> crypto API available, though, if someone wants to use it instead. Even
> supporting both, this is a net reduction in code, due to dropping all
> the zbufsize logic.
>
> How does this look?
>

The code changes all look correct and reasonable to me.

As for supporting both the library and the crypto API interface: I did
a little digging, and it turns out all additional compression modes
were added by the same contributor, with no justification other than
'this might be useful to some people' (see below)

However, I did a quick experiment with the output of dmesg on my
workstation, and these are the results I am getting

Input file:
-rw-r--r-- 1 ard ard 111792 Oct 18 09:23 uncompressed

Default compression
-rw-r--r-- 1 ard ard  21810 Oct 18 09:23 uncompressed.gz
-rw-r--r-- 1 ard ard  33923 Oct 18 09:23 uncompressed.lz4
-rw-r--r-- 1 ard ard  34238 Oct 18 09:23 uncompressed.lzo
-rw-r--r-- 1 ard ard  21599 Oct 18 09:23 uncompressed.zst

Max compression (-9)
-rw-r--r-- 1 ard ard  21589 Oct 18 09:23 uncompressed.gz
-rw-r--r-- 1 ard ard  28848 Oct 18 09:25 uncompressed.lz4 (== lz4hc?)
-rw-r--r-- 1 ard ard  26917 Oct 18 09:23 uncompressed.lzo
-rw-r--r-- 1 ard ard  19883 Oct 18 09:23 uncompressed.zst

So the patches in question don't actually fulfill their claim of
improving the compression ratio. Only zstd, which was added later,
improves upon zlib, but not significantly unless you override the
compression level (which we don't).

So I seriously doubt that those patches were inspired by the need to
solve an actual problem anyone was experiencing at the time, given
that they don't. It just seems that nobody bothered to ask the 'why?'
question.

So again, I suggest to simply drop this non-feature, and standardize
on either zlib or zstd using the library interface exclusively. If
someone present a compelling use case, we can always consider adding
it back in some form.

As for the choice of algorithm, given the equal performance using the
default compression level, and the difference in code size, I don't
see why zstd should be preferred here. If anything, it only increases
the likelihood of hitting another error if we are panicking due to
some memory corruption issue.

$ size  lib/zstd/zstd_compress.ko lib/zlib_deflate/zlib_deflate.ko
   text    data     bss     dec     hex filename
 218411     768       0 219179   3582b lib/zstd/zstd_compress.ko
  16231     876    2288   19395    4bc3 lib/zlib_deflate/zlib_deflate.ko






commit 8cfc8ddc99df9509a46043b14af81f5c6a223eab
Author:     Geliang Tang <geliangtang@163.com>
AuthorDate: Thu Feb 18 22:04:22 2016 +0800
Commit:     Kees Cook <keescook@chromium.org>
CommitDate: Thu Jun 2 10:59:31 2016 -0700

    pstore: add lzo/lz4 compression support

    Like zlib compression in pstore, this patch added lzo and lz4
    compression support so that users can have more options and better
    compression ratio.

commit 239b716199d9aff0d09444b0086e23aacd6bd445
Author:     Geliang Tang <geliangtang@gmail.com>
AuthorDate: Tue Feb 13 14:40:39 2018 +0800
Commit:     Kees Cook <keescook@chromium.org>
CommitDate: Tue Mar 6 15:06:11 2018 -0800

    pstore: Add lz4hc and 842 compression support


>
> Kees Cook (5):
>   pstore: Remove worse-case compression size logic
>   pstore: Allow for arbitrary compression algorithm
>   pstore: Use size_t for compress/decompression type widths
>   pstore: Refactor compression initialization
>   pstore: Use zstd directly by default for compression
>
>  fs/pstore/Kconfig    | 131 +++++-----------
>  fs/pstore/platform.c | 358 ++++++++++++++++++++-----------------------
>  2 files changed, 209 insertions(+), 280 deletions(-)
>
> --
> 2.34.1
>
