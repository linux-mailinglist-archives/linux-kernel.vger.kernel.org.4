Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 614C76DFE49
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 21:03:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbjDLTDt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 15:03:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjDLTDr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 15:03:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7105CE69
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 12:03:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0E1DC634CF
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 19:03:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38F9AC433EF;
        Wed, 12 Apr 2023 19:03:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681326225;
        bh=tk0gTkVsrT2b6u/MIFUtJxjB1P/8QDFYpBCTGntsMPg=;
        h=From:To:Cc:Subject:Date:From;
        b=Wp5VgqhGAbdq0Nr4KwOnxNZYEXKARgd5f1YK0oWJuFMDeEbTAbm21VlhkUjh+OgKB
         GZLMH4oFr3tIQH+CKmP2Fps27kFmBe6tJTRnHdySyedVPtifsDf8d1fdjuzDKcjBlW
         v9KHEQtn5+hDKDE1R88HAQsiQpOo5CaOJLU9w07sRePOjiTUDlt90W/cYSYG3nS4FX
         fVVTUUAyLSL4U7Q663VOe1BIjuwCJIzcjQON+iUPUfFZYn718nEwC4cl/tm3LJdoch
         RngVhdjA847fSsPOvx16u6m5yz5jtXW9nZHdpDdUcP31Yn0shvrIlOOJugkdB1i8pu
         71qWrFwwFIYzQ==
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Miroslav Benes <mbenes@suse.cz>
Subject: [PATCH v2 0/9] objtool: warning improvements
Date:   Wed, 12 Apr 2023 12:03:15 -0700
Message-Id: <cover.1681325924.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v2:
- keep --backtrace
- hard-code awk logic (don't use objdump-func script)
- add OBJTOOL_VERBOSE=1
- add WARN_INSN()
- several other improvements/fixes - best to review from scratch ;-)

Josh Poimboeuf (9):
  scripts/objdump-func: Support multiple functions
  objtool: Add WARN_INSN()
  objtool: Limit unreachable warnings to once per function
  objtool: Add symbol iteration helpers
  objtool: Add verbose option for disassembling affected functions
  objtool: Include backtrace in verbose mode
  objtool: Remove superfluous dead_end_function() check
  objtool: Detect missing __noreturn annotations
  objtool: Ignore exc_double_fault() __noreturn warnings

 scripts/objdump-func                    |  34 +-
 tools/objtool/Documentation/objtool.txt |  11 +
 tools/objtool/builtin-check.c           |   5 +
 tools/objtool/check.c                   | 421 +++++++++++++-----------
 tools/objtool/elf.c                     |   2 +-
 tools/objtool/include/objtool/builtin.h |   1 +
 tools/objtool/include/objtool/elf.h     |  10 +
 tools/objtool/include/objtool/warn.h    |  22 +-
 tools/objtool/orc_gen.c                 |   9 +-
 9 files changed, 307 insertions(+), 208 deletions(-)

-- 
2.39.2

