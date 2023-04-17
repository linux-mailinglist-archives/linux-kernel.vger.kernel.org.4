Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5E136E478C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 14:22:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230489AbjDQMWQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 08:22:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231163AbjDQMVu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 08:21:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4593D9746;
        Mon, 17 Apr 2023 05:21:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8429D62343;
        Mon, 17 Apr 2023 12:21:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D856C433EF;
        Mon, 17 Apr 2023 12:21:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681734067;
        bh=v6GeTyqbTX2Q85J3eve/ZjdwGEtZ70QLU5PDsHNjMNM=;
        h=From:To:Cc:Subject:Date:From;
        b=bJYof9iTHwmCBFCQvVtPDNrilh2yIbNrxB1SSz9ksP+sOCFflxdtqGSXbA51mX8hm
         oFeLbNee+xgqt6XD+4NvzhuW/kHMzmUqZGBvCWB311Ajk/fP3ovWe3ObsAiZfTFbJP
         z/Vy3nqSYw9Lggn8lK9Qc5IH/o2HjcBnGGI1G303oBs5cn+HD+YvGFbupyqGiZj/Vc
         53zSnWiZpTH26bwIriIrE+YGE/d5afCfELzMp+c/ZBkAAw4DpMQ1Cah7k8dlv5vpHJ
         UsfptrPMHl/rcXA0/abFh1TzksFBizZfagPPWnJG3/n3+4p5Dl6gu27XuCAllvkwWj
         3TmXkSJ49zw7Q==
From:   broonie@kernel.org
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Peter Xu <peterx@redhat.com>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: linux-next: manual merge of the sh tree with the mm-unstable tree
Date:   Mon, 17 Apr 2023 13:20:55 +0100
Message-Id: <20230417122056.244444-1-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Today's linux-next merge of the sh tree got a conflict in:

  tools/testing/selftests/mm/Makefile

between commit:

  aaf87fd8703a5 ("selftests/mm: use TEST_GEN_PROGS where proper")

from the mm-unstable tree and commit:

  644a9cf0d2a83 ("sh: remove sh5/sh64 last fragments")

from the sh tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

diff --git a/tools/testing/selftests/mm/Makefile b/tools/testing/selftests/mm/Makefile
index a913397c6b3c5..3ad614d359e44 100644
--- a/tools/testing/selftests/mm/Makefile
+++ b/tools/testing/selftests/mm/Makefile
@@ -93,7 +93,7 @@ endif
 
 endif
 
-ifneq (,$(filter $(MACHINE),arm64 ia64 mips64 parisc64 ppc64 riscv64 s390x sh64 sparc64 x86_64))
+ifneq (,$(filter $(MACHINE),arm64 ia64 mips64 parisc64 ppc64 riscv64 s390x sparc64 x86_64))
 TEST_GEN_PROGS += va_high_addr_switch
 TEST_GEN_PROGS += virtual_address_range
 TEST_GEN_PROGS += write_to_hugetlbfs
