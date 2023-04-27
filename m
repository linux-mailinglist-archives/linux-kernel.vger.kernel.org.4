Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 265E46F06CF
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 15:43:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243284AbjD0NnW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 09:43:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232885AbjD0NnU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 09:43:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D07F19AC;
        Thu, 27 Apr 2023 06:43:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CA9B861444;
        Thu, 27 Apr 2023 13:43:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 634C4C433EF;
        Thu, 27 Apr 2023 13:43:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682602998;
        bh=mP3zZ2WOxYXRJhsA5VsEIgXN9HuZoulQG9PKo94GzvU=;
        h=From:To:Cc:Subject:Date:From;
        b=C48jjRFdCt14kncc2Y42SttpbJ+fBR0xmzaHIp2kx3SdP8ngjnbKSYeK8FTqnKXH6
         EP3+PIseLFytsRd3+EqOjmtpheHYZE74k6DsGiNI4xp6MO7UIVhWmF36UJgijaz+He
         r85VEWDAKJLmIZS516+EzwH0XYDmpvH5pLpraMJTEuFsrJd0OAtbgmq9YBROYTEZ0K
         wfxW1h8BZD/T+nZSijnGLlR6XaPk2nX/yGE3dC0aJvkJ4WBcJkiLGz2TyatT3mV5Sw
         QuWb4cBJoz035bWOO/WKyJdgNM2R4sn9bwI/5RXcAboXyxWJcRhXJV3SOYVM94phYa
         2avdy3pCHOBXA==
From:   broonie@kernel.org
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     David Sterba <dsterba@suse.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the tip tree with the origin tree
Date:   Thu, 27 Apr 2023 14:43:13 +0100
Message-Id: <20230427134313.45596-1-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Today's linux-next merge of the tip tree got a conflict in:

  tools/objtool/check.c

between commit:

  f372463124df5 ("btrfs: mark btrfs_assertfail() __noreturn")

from the origin tree and commits:

  071c44e427815 ("sched/idle: Mark arch_cpu_idle_dead() __noreturn")
  09c5ae30d0075 ("btrfs: Mark btrfs_assertfail() __noreturn")
  9ea7e6b62c2bd ("init: Mark [arch_call_]rest_init() __noreturn")

from the tip tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

diff --cc tools/objtool/check.c
index 931cdb7dba190,5b600bbf2389b..0000000000000
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
