Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30EDE67D28E
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 18:06:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231150AbjAZRGZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 12:06:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231876AbjAZRGX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 12:06:23 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3B883A9D
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 09:06:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id D8B17CE237D
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 17:06:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02C87C433D2;
        Thu, 26 Jan 2023 17:06:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674752777;
        bh=x1dh74Zz7B/AcbhnGni/ZuDkEB7kGpdHTuvy/SN6UpM=;
        h=From:To:Cc:Subject:Date:From;
        b=idRsfVSw6RJymcT8zExoT0EtgCYd7mQUYU9XmOd0QgQtOcw1bX7Ebhf14CHAK0PEz
         FhuieMyXFiAe7GeffAofmPGMmIVUgdU1n1MUCMle7YhFLRo5mVz4JvWgbnimq1RLLD
         jZzR3ejw0vHhG57iAoFlSF4+bcK3jUH9lnHw386BF3zfnW2IlZ6qFdHDQl7WRurFxb
         75De03jbzRrOKlO/wUYIDsz6HiWgQfIbOOdiKPhrW8sct2dXa380ZiIyGJ7VUZ7/wU
         kpAnNaasry+ewkXfoDnsx+1P7QRVRmkK0/NetWNi/ZuoORgwFwsVnvatZMyGISIsqZ
         /BXOF/cHQ7YUw==
From:   guoren@kernel.org
To:     guoren@kernel.org, palmer@dabbelt.com, paul.walmsley@sifive.com,
        mhiramat@kernel.org, conor.dooley@microchip.com,
        penberg@kernel.org, mark.rutland@arm.com, jrtc27@jrtc27.com,
        andy.chiu@sifive.com, zong.li@sifive.com
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH -next V3 0/2] riscv: jump_label: Fixup & Optimization
Date:   Thu, 26 Jan 2023 12:06:05 -0500
Message-Id: <20230126170607.1489141-1-guoren@kernel.org>
X-Mailer: git-send-email 2.36.1
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

From: Guo Ren <guoren@linux.alibaba.com>

Patch 1 is the fixup patch should be merged into stable-tree.
Patch 2 is a continuous optimization for jump_label patch_text
atomicity.

Changes in V3:
 - Correct the typo C.JAL -> C.J (Thx Jessica)
 - Fixup compile error when CONFIG_RISCV_ISA_C=n
 - Rebase on riscv for-next (20230127)

Changes in V2:
https://lore.kernel.org/linux-riscv/20221210100927.835145-3-guoren@kernel.org/

Changes in V1:
https://lore.kernel.org/linux-riscv/20220913094252.3555240-6-andy.chiu@sifive.com/

Andy Chiu (1):
  riscv: jump_label: Fixup unaligned arch_static_branch function

Guo Ren (1):
  riscv: jump_label: Optimize the code size with compressed instruction

 arch/riscv/include/asm/jump_label.h | 14 ++++++++++++--
 arch/riscv/kernel/jump_label.c      | 30 +++++++++++++++++++++++++++--
 2 files changed, 40 insertions(+), 4 deletions(-)

-- 
2.36.1

