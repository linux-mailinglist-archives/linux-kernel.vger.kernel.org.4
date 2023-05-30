Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 300A6716AB4
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 19:21:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232036AbjE3RVg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 13:21:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230479AbjE3RVe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 13:21:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F195DA3
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 10:21:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8E66F630DB
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 17:21:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDB40C433D2;
        Tue, 30 May 2023 17:21:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685467291;
        bh=c+O+LLgqN5oTgo0HoROZJSsAcr4bfSI/Bxgq9ilr0CY=;
        h=From:To:Cc:Subject:Date:From;
        b=ld4IKAPwxj/ynldPT0K7p0sFQXmymcalYygVqgTSLvetQxplpPXJW+4DXYx7vjFDj
         MncBS9L83qTMabZBXoFHiPXz8gxtIT3UInNn35S0lKnQzGyinOpyj4R4QIBTrVG46U
         2vYTw05WfSSho7UCN6mSURos7PXsWsVcW1hgB/xiQ2pdqJyevzaG6nQ9SQPeDwBDmN
         NMUeXLKfN/AB9dbZE8wWxqMLGRSSk1CYbwtqCP/ZOwkMUNNQ7CELF3OljX9STkSzDv
         r//Oy8STI51wF5KiT7ESk5hcB3n/FwAtXbeXEzI4fcBYO8MZbQwrvM//XdTXNDqBDZ
         QGPOnjK7+SDPw==
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Miroslav Benes <mbenes@suse.cz>
Subject: [PATCH 00/22] objtool: Reduce memory usage with CONFIG_DEBUG_INFO
Date:   Tue, 30 May 2023 10:20:52 -0700
Message-Id: <cover.1685464332.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.40.1
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

DWARF uses a LOT of relocations, causing objtool to need a LOT of memory
for processing vmlinux.o.

In the worst case of an allyesconfig+CONFIG_DEBUG_INFO kernel, DWARF
creates almost 200 million relocations, ballooning objtool's peak heap
usage to 53GB.  These patches reduce that to 25GB.

On a distro-type kernel with kernel IBT enabled, they reduce objtool's
peak heap usage from 4.2GB to 2.8GB.

They also improve the runtime significantly (from 2m50s to 1m54s on my
system with allyesconfig+CONFIG_DEBUG_INFO), though most of that comes
from fixing the size calculation for reloc_hash.

Josh Poimboeuf (22):
  objtool: Tidy elf.h
  objtool: Remove flags argument from elf_create_section()
  objtool: Improve reloc naming
  objtool: Consolidate rel/rela handling
  objtool: Fix reloc_hash size
  objtool: Add mark_sec_changed()
  objtool: Add elf_create_section_pair()
  objtool: Keep GElf_Rel[a] structs synced
  objtool: Don't free memory in elf_close()
  objtool: Add for_each_reloc()
  objtool: Allocate relocs in advance for new rela sections
  objtool: Get rid of reloc->list
  objtool: Get rid of reloc->idx
  objtool: Get rid of reloc->offset
  objtool: Get rid of reloc->type
  objtool: Get rid of reloc->addend
  objtool: Get rid of reloc->jump_table_start
  objtool: Shrink reloc->sym_reloc_entry
  objtool: Shrink elf hash nodes
  objtool: Get rid of reloc->rel[a]
  objtool: Free insns when done
  objtool: Skip reading DWARF section data

 tools/objtool/arch/powerpc/include/arch/elf.h |  11 +-
 tools/objtool/arch/x86/decode.c               |   6 +-
 tools/objtool/arch/x86/include/arch/elf.h     |  11 +-
 tools/objtool/arch/x86/special.c              |   6 +-
 tools/objtool/check.c                         | 429 +++++++-------
 tools/objtool/elf.c                           | 537 +++++++-----------
 tools/objtool/include/objtool/elf.h           | 326 ++++++++---
 tools/objtool/orc_gen.c                       |   8 +-
 tools/objtool/special.c                       |   4 +-
 9 files changed, 698 insertions(+), 640 deletions(-)

-- 
2.40.1

