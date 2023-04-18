Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD57D6E6E27
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 23:28:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232804AbjDRV2O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 17:28:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232194AbjDRV2L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 17:28:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74FA6D329
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 14:28:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F15C46394E
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 21:27:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27CECC433EF;
        Tue, 18 Apr 2023 21:27:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681853279;
        bh=KHENKxaF55SQBliT/mpnTGG5cuTM0pkWpkCrg3hcaZI=;
        h=From:To:Cc:Subject:Date:From;
        b=txCks2cQ+CUtoBAX6cM++h3A0wEt6SCndJG3vAuJ9ZAl9C2X4UD6ZxqvFPUBaf5BC
         BpXJ7ShyHv82arUH7S14OoEi63QuTI7RibwXl1OKCGXmrOiGYxU0M2PSVXNA6MSwDf
         FGp2Bnw5UnV3vgxiYi/jnOpDlf+bOj7FW6FhT+YQW8covPvnDJrySNvrnM9DOv3hkp
         tKGCYcpqF1yE//XLV/oYJTFpkJ4LaTjKE43i8newu1gE/aYqmO3TNTXvrlbzKmUVxY
         vWei9pCKFcXZtzxLM1CUc34OrZQeoI6dooXuHIojQR9+mNCMLCiXCC9sYwY3abLmtD
         Q2HIn6MHjaxIQ==
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: [PATCH v3 0/8] objtool: warning improvements
Date:   Tue, 18 Apr 2023 14:27:46 -0700
Message-Id: <cover.1681853186.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-type: text/plain
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

v3:
- dropped merged patches and rebased on tip/objtool/core
- moved list of noreturn functions to separate file
- improved WARN_INSN() to do single evaluation of insn arg

Josh Poimboeuf (8):
  objtool: Limit unreachable warnings to once per function
  objtool: Add verbose option for disassembling affected functions
  objtool: Include backtrace in verbose mode
  objtool: Detect missing __noreturn annotations
  objtool: Ignore exc_double_fault() __noreturn warnings
  objtool: Remove superfluous global_noreturns entries
  tools/lib/subcmd: Replace NORETURN usage with __noreturn
  objtool: Move noreturn function list to separate file

 tools/lib/subcmd/parse-options.h        |   8 +-
 tools/lib/subcmd/subcmd-util.h          |   5 +-
 tools/objtool/Documentation/objtool.txt |  10 ++
 tools/objtool/builtin-check.c           |   5 +
 tools/objtool/check.c                   | 195 ++++++++++++++++--------
 tools/objtool/include/objtool/builtin.h |   1 +
 tools/objtool/include/objtool/elf.h     |   1 +
 tools/objtool/include/objtool/warn.h    |  21 ++-
 tools/objtool/noreturns.h               |  45 ++++++
 9 files changed, 214 insertions(+), 77 deletions(-)
 create mode 100644 tools/objtool/noreturns.h

-- 
2.39.2

