Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9CD36E0F67
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 15:58:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231644AbjDMN6e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 09:58:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231510AbjDMN6c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 09:58:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 097FF109;
        Thu, 13 Apr 2023 06:58:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 90B1163EDE;
        Thu, 13 Apr 2023 13:58:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A999C433EF;
        Thu, 13 Apr 2023 13:58:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681394305;
        bh=ELNGDv+vluokZUPB3x+lMCFicXn8cWCZyU4JxAkwrmI=;
        h=From:To:Cc:Subject:Date:From;
        b=DLUR65kiTyXZH7YRuyl+sc/Y1zv72Zb16a6IEFdQlf2n6bKdkeHqNlOV/PRo8VJF5
         olvRJQS6yZGbWIX7lxt61HsrKtH/JTJ49jmAppmR/gt8K1+Zjo0Bu1K1zwEVFCaHx3
         QNhRF7sClLbboWq+8BSjsR2kPie7lde3OiL9yj8iXQja4MN0JalIyRxh35f6AHudEx
         dTXFJFqWCVSM2QgQ2jZr/SDjn+5LGWRe5nClmJLYgAV2Psmjj91j7vI+jAshSWjtCd
         ZbsDxNHKEm4d57ZbonLqyerhEbdMMoDImUEXyxYpQeEIygfN4Ci2bjAclZZhS6AFnV
         vAEZ02Cqe8aIQ==
From:   broonie@kernel.org
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Peter Xu <peterx@redhat.com>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: linux-next: manual merge of the sh tree with the mm-unstable tree
Date:   Thu, 13 Apr 2023 14:58:15 +0100
Message-Id: <20230413135815.3254620-1-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Today's linux-next merge of the sh tree got a conflict in:

  tools/testing/selftests/mm/Makefile

between commit:

  14940f545c315 ("selftests/mm: use TEST_GEN_PROGS where proper")

from the mm-unstable tree and commit:

  644a9cf0d2a83 ("sh: remove sh5/sh64 last fragments")

from the sh tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

diff --cc tools/testing/selftests/mm/Makefile
index 5a34344194035,fc35050b5542f..0000000000000
--- a/tools/testing/selftests/mm/Makefile
+++ b/tools/testing/selftests/mm/Makefile
@@@ -93,10 -90,10 +93,10 @@@ endi
  
  endif
  
- ifneq (,$(filter $(MACHINE),arm64 ia64 mips64 parisc64 ppc64 riscv64 s390x sh64 sparc64 x86_64))
+ ifneq (,$(filter $(MACHINE),arm64 ia64 mips64 parisc64 ppc64 riscv64 s390x sparc64 x86_64))
 -TEST_GEN_FILES += va_128TBswitch
 -TEST_GEN_FILES += virtual_address_range
 -TEST_GEN_FILES += write_to_hugetlbfs
 +TEST_GEN_PROGS += va_128TBswitch
 +TEST_GEN_PROGS += virtual_address_range
 +TEST_GEN_PROGS += write_to_hugetlbfs
  endif
  
  TEST_PROGS := run_vmtests.sh
