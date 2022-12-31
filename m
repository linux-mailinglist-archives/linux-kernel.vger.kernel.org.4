Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C868A65A2F1
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Dec 2022 07:42:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230011AbiLaGmW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Dec 2022 01:42:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbiLaGmT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Dec 2022 01:42:19 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 857DC3B2;
        Fri, 30 Dec 2022 22:42:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 329A3B80066;
        Sat, 31 Dec 2022 06:42:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F4023C433F0;
        Sat, 31 Dec 2022 06:42:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672468935;
        bh=Q3TDSDFr/sJtluomc4BwL5YkxG8/1KW66Kq678sK91A=;
        h=From:To:Cc:Subject:Date:From;
        b=cwnNg+U+pDVojTYGdaksC2JJpE970eqINaEP6uu2OjZdwClKhTKgR+uS5juHUVPs/
         CKg1Iayv+Ayf1J/38YA5SgVU3N9T9z2ryPxULwND7HC/ilt/UUMAex5G8YvpnhINZo
         rwZAIsOuMlDxnX0XEaZQYDC896vFrmBR0FQLjpUanIte3SRUtfR1xXLGVS8OzEXSMB
         osfwm+Xv7LQoa2rO7zSPZmoz9yeZqiNk6b2qPuEg+ZV0BFOFZ7oHpBBkMF9FgeIo40
         zH6USqEV1GDrVpDti1HJsCaT/QERa70Mm2dBnumVOdjl6Cwx+2cJXqeGdG4xadw80P
         Kvajjkw3WKYGA==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>, Tom Rix <trix@redhat.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        llvm@lists.linux.dev, rust-for-linux@vger.kernel.org
Subject: [PATCH 0/6] kbuild: fix dep-file processing for rust
Date:   Sat, 31 Dec 2022 15:41:57 +0900
Message-Id: <20221231064203.1623793-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.34.1
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




Masahiro Yamada (6):
  kbuild: specify output names separately for each emission type from
    rustc
  fixdep: parse Makefile more correctly to handle comments etc.
  kbuild: remove sed commands after rustc rules
  fixdep: refactor hash table lookup
  fixdep: avoid parsing the same file over again
  fixdep: do not parse *.so, *.rmeta, *.rlib

 rust/Makefile          |  16 ++-
 scripts/Makefile.build |  26 ++---
 scripts/Makefile.host  |  10 +-
 scripts/basic/fixdep.c | 234 +++++++++++++++++++++++++++--------------
 4 files changed, 173 insertions(+), 113 deletions(-)

-- 
2.34.1

