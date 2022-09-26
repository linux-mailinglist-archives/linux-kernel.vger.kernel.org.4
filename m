Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08A4A5EB52F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 01:13:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230327AbiIZXNC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 19:13:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230298AbiIZXM7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 19:12:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3512DABF36;
        Mon, 26 Sep 2022 16:12:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AD9BD614B9;
        Mon, 26 Sep 2022 23:12:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8218C433D6;
        Mon, 26 Sep 2022 23:12:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664233978;
        bh=i+4cYWvvbX6eB0hVVJ0oMScoDAoRVCjurrZ2ldB88mI=;
        h=From:To:Cc:Subject:Date:From;
        b=EXll/xeeQCl+YhmYZ6UqxFaW/iha5aafiybSf8zR9XSfb+TYeKvsKHt0v35nZDvrf
         pKzPxYe/iRJ299NKHCGS40Cj6wVGkQ/hq49Pu9X0MrSJTppWoE1hEYGU9CZ9HtBdMs
         rGbjCMzhKZR+j/+0QeI+37zgIo3wgACx0tIS3fHTzZqJX9x22CxBJOVIq0EJzI+Fvr
         Bzk5+cfJuBgZj6i/C84k4DSrMAdBqteleTWMWKWbUGRQjsGoDwkWDPsocH8Erqen1N
         Q28/YGaWQaC6fJtTWEkHKGSjPgbM+QbHeHeKaidGwpJ6HIgw6WGeZl0ykOvQu3dzKe
         eUDfBo7qwcB3Q==
From:   broonie@kernel.org
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Adam Bratschi-Kaye <ark.email@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Antonio Terceiro <antonio.terceiro@linaro.org>,
        =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Boris-Chengbiao Zhou <bobo1239@web.de>,
        Daniel Xu <dxu@dxuuu.xyz>,
        Dariusz Sosnowski <dsosnowski@dsosnowski.pl>,
        Douglas Su <d0u9.su@outlook.com>, Finn Behrens <me@kloenk.de>,
        Gary Guo <gary@garyguo.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Miguel Ojeda <ojeda@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sven Van Asbroeck <thesven73@gmail.com>,
        Wedson Almeida Filho <wedsonaf@google.com>
Subject: linux-next: manual merge of the rust tree with the kbuild tree
Date:   Tue, 27 Sep 2022 00:12:46 +0100
Message-Id: <20220926231246.1140133-1-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

FIXME: Add owner of second tree to To:
       Add author(s)/SOB of conflicting commits.

Today's linux-next merge of the rust tree got a conflict in:

  Makefile

between commit:

  a6036a41bffba ("kbuild: drop support for CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE_O3")

from the kbuild tree and commit:

  4f6a738b5c348 ("Kbuild: add Rust support")

from the rust tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

diff --cc Makefile
index 2dba99828e893,a105cb893b4ca..0000000000000
--- a/Makefile
+++ b/Makefile
@@@ -757,10 -819,20 +821,17 @@@ KBUILD_CFLAGS	+= $(call cc-disable-warn
  
  ifdef CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE
  KBUILD_CFLAGS += -O2
+ KBUILD_RUSTFLAGS += -Copt-level=2
 -else ifdef CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE_O3
 -KBUILD_CFLAGS += -O3
 -KBUILD_RUSTFLAGS += -Copt-level=3
  else ifdef CONFIG_CC_OPTIMIZE_FOR_SIZE
  KBUILD_CFLAGS += -Os
+ KBUILD_RUSTFLAGS += -Copt-level=s
  endif
  
