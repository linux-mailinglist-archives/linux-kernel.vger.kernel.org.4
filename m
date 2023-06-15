Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25C6B7317DA
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 13:49:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344658AbjFOLtW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 07:49:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344630AbjFOLsy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 07:48:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47AC06589
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 04:44:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 79EE663B4E
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 11:43:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B9DAC433C0;
        Thu, 15 Jun 2023 11:43:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686829397;
        bh=TiiRBJUWh3aDlJ6vQx4ygwCEC3o6aA0ix2061Cv4wqI=;
        h=From:To:Cc:Subject:Date:From;
        b=sQqnG7eLwcxeaIAt01tDaX9MU5TGLlCLZKD94YWH8zjL3pL1JjAsOiKoSmozKJVKX
         6krKrhEl533xgJHGJpbbG0xJr6DnnggP4iDCXM7nZGt+0Cm3t4IInzx41rAP7pGqhC
         5hCC7vRjXFrpLiiVWygrgStgF4bWSG+llryE76y+WbAUdz2hvqIpN4ps5browEAx2l
         O4ej+Bm3bN+gxR4JjL4YddEprn14GCR+jEr07y4K/Ri5iXyeMXfjhDLPpVm/zk7xhv
         jKSAB1uxMSvOtea9jkQF5FghOiKiCGe1MMKhR9ufZSI33qV/z6Bqrodh3Ia+0EY24d
         Pnqre3xQL8WMQ==
From:   Mark Brown <broonie@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] regmap fixes for v6.4-rc6
Date:   Thu, 15 Jun 2023 12:43:07 +0100
Message-Id: <20230615114317.4B9DAC433C0@smtp.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 0cc6578048e0980d254aee345130cced4912f723:

  regmap: maple: Drop the RCU read lock while syncing registers (2023-05-24 11:21:52 +0100)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git tags/regmap-fix-v6.4-rc6

for you to fetch changes up to 44e46572f0bae431a6092e3cfd2f47bff8b8d18c:

  regmap: regcache: Don't sync read-only registers (2023-06-13 13:15:00 +0100)

----------------------------------------------------------------
regmap: One more fix for v6.4

Another fix for the maple tree cache, Takashi noticed that unlike other
caches the maple tree cache didn't check for read only registers before
trying to sync which would result in spurious syncs for read only
registers where we don't have a default.  This was due to the check
being open coded in the caches, we now check in the shared "does this
register need sync" function so that is fixed for this and future
caches.

----------------------------------------------------------------
Takashi Iwai (1):
      regmap: regcache: Don't sync read-only registers

 drivers/base/regmap/regcache.c | 3 +++
 1 file changed, 3 insertions(+)
