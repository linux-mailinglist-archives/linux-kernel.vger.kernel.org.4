Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BC9E5ECC82
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 20:59:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230411AbiI0S7V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 14:59:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbiI0S7S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 14:59:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 290901DCC5B;
        Tue, 27 Sep 2022 11:59:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6971861B41;
        Tue, 27 Sep 2022 18:59:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FCCFC433C1;
        Tue, 27 Sep 2022 18:59:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664305156;
        bh=FgUVRWsqzSirqvc5ylkIWLr3qT7Y+55iMusvUwJW2iY=;
        h=From:To:Cc:Subject:Date:From;
        b=WOeu9N6EO3i9bhzc5FbeLjlabhhIyvgjztbOos0lViO3MI5O5wr76H8+4KrO6tgxK
         IiwKzGa2woNJ4ZK47HFGHr852Xu6tuzxfBGr2jwMNGqnZX901iRrSkcDzMeixj1aul
         DcFPGieBbtUN5595SopirsS/agR1gJwfMG/dNRgB9aRwnMFPq3x4X38L4lypr7Tn+M
         1XpbMIypchr/j6H5vpOQAbt1T9bc9OdvK/hu+Dsdcfiz41vPmJY6CoMUPqoPwTdq5L
         PQGdUuL7j5cOnkHuhg5Oq/vZ1tqslM1TzxRY5nEZj1gIxB3P378KYF0NCDJktlxtE6
         ZqsS/zgwKwDKw==
From:   broonie@kernel.org
To:     Kees Cook <keescook@chromium.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sami Tolvanen <samitolvanen@google.com>
Subject: linux-next: manual merge of the kspp tree with the arm64 tree
Date:   Tue, 27 Sep 2022 19:59:11 +0100
Message-Id: <20220927185911.512737-1-broonie@kernel.org>
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

Today's linux-next merge of the kspp tree got a conflict in:

  arch/arm64/kernel/alternative.c

between commit:

  b723edf3a12a2 ("arm64: alternatives: make alt_region const")

from the arm64 tree and commit:

  5f20997c194e8 ("arm64: Drop unneeded __nocfi attributes")

from the kspp tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

diff --cc arch/arm64/kernel/alternative.c
index 64045e3ef03a9,d2c66507398d7..0000000000000
--- a/arch/arm64/kernel/alternative.c
+++ b/arch/arm64/kernel/alternative.c
@@@ -139,9 -133,8 +139,9 @@@ static void clean_dcache_range_nopatch(
  	} while (cur += d_size, cur < end);
  }
  
- static void __nocfi __apply_alternatives(const struct alt_region *region,
- 					 bool is_module,
- 					 unsigned long *feature_mask)
 -static void __apply_alternatives(struct alt_region *region, bool is_module,
++static void __apply_alternatives(const struct alt_region *region,
++				 bool is_module,
+ 				 unsigned long *feature_mask)
  {
  	struct alt_instr *alt;
  	__le32 *origptr, *updptr;
