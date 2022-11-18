Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A3E462FE5A
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 20:53:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232128AbiKRTx3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 14:53:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230489AbiKRTxP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 14:53:15 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F10CFB73B5;
        Fri, 18 Nov 2022 11:53:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8EBC66269B;
        Fri, 18 Nov 2022 19:53:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15285C433D6;
        Fri, 18 Nov 2022 19:53:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668801193;
        bh=oCcQw1i+vbEvQa0imfswLqu9LcCgXgtGypVXEgkYVrI=;
        h=From:To:Cc:Subject:Date:From;
        b=Zu+EUvf1DfBtyHV8k+pPcUYPuluFRmcisHgY/dNzlPp4+hOnJIoOFYTxPXv1rdAvx
         WfohebcfdJCN8lmm2vVUZbE5EvWbyRlpY/0NtkUagebAo0CEhJA0hDJEQLJBjv+geW
         e3IdvXMvZpw8Ljd6j1+Q4mExUYfHhq7WRu0CxJfuj2NeEu+GELYKaBXQZqCqKDJhtr
         E/kcWx0sI9EmO8+Vej5YXyy8gVDXJXxmAtPKTX72Xtyx5sZh0k+KScwrYr+fW78O6q
         smseNpLYZnt/U/s/CL4ctKfbt0bdAhoedAWu42Wb7XwAsFOq+FwrkjuqBocPtygLWQ
         g/+WRNUUj9Sqg==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH 0/6] kbuild: strive to avoid $(shell ...) invocations
Date:   Sat, 19 Nov 2022 04:53:01 +0900
Message-Id: <20221118195307.86049-1-masahiroy@kernel.org>
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


$(shell ...) forks process(es).
Built-in functions are more efficient.



Masahiro Yamada (6):
  kbuild: add test-{le,ge,lt,gt} macros
  kbuild: make CONFIG_*_VERSION always 6-digit
  kbuild: implement {gcc,clang}-min-version only with built-in functions
  kbuild: add read-file macro
  kconfig: refactor Makefile to reduce process forks
  kbuild: check Make version

 Documentation/kbuild/makefiles.rst          |  6 +--
 Makefile                                    |  9 +++--
 arch/arm/mach-rpc/Kconfig                   |  2 +-
 arch/arm64/Kconfig                          |  4 +-
 arch/mips/vdso/Kconfig                      |  2 +-
 arch/powerpc/Kconfig                        |  2 +-
 arch/riscv/Kconfig                          |  4 +-
 arch/riscv/Makefile                         |  2 +-
 arch/x86/Makefile                           |  2 +-
 drivers/gpu/drm/amd/display/dc/dml/Makefile |  2 +-
 init/Kconfig                                | 18 ++++-----
 lib/Kconfig.debug                           |  6 +--
 lib/Kconfig.kasan                           |  2 +-
 scripts/Kbuild.include                      | 22 +++++++++++
 scripts/Makefile.compiler                   |  6 +--
 scripts/Makefile.modfinal                   |  2 +-
 scripts/Makefile.modinst                    |  2 +-
 scripts/as-version.sh                       |  6 +--
 scripts/cc-version.sh                       |  6 +--
 scripts/kconfig/.gitignore                  |  4 +-
 scripts/kconfig/Makefile                    | 43 +++++++++++----------
 scripts/kconfig/gconf-cfg.sh                |  7 +++-
 scripts/kconfig/mconf-cfg.sh                | 25 ++++++------
 scripts/kconfig/nconf-cfg.sh                | 23 ++++++-----
 scripts/kconfig/qconf-cfg.sh                | 10 +++--
 scripts/ld-version.sh                       |  6 +--
 scripts/remove-stale-files                  |  2 +
 27 files changed, 135 insertions(+), 90 deletions(-)

-- 
2.34.1

