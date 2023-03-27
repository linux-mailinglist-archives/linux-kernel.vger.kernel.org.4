Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC5676CA9D8
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 18:01:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232787AbjC0QB2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 12:01:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232880AbjC0QBM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 12:01:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADA796599
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 09:00:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EF06E61300
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 16:00:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B00CC433D2;
        Mon, 27 Mar 2023 16:00:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679932855;
        bh=pDEwLF+kUL8Y/39fHcZt14EVNn++vLRYxhexDs/fnZ0=;
        h=From:To:Cc:Subject:Date:From;
        b=Z5ESoB9VsipYWtfd5Dugvq9Rsz50lWuqO6aITQRasxdT9DR6tlAShDWMkmrael4HK
         YJAwNzXDY58WyR5upUmaWSaZMDGLcf/t0GujdZKJFez5xp+snCTv4fxB1wBDwaEsZO
         6JJzbjaE4CkiNeuzgxUDeDZT8HcWhUjUmwZGz0t6n5Jdh7eOQiSt/LoSeraP9hc7NE
         QeCSVquS/5Tkb678pnmgxkfnOxiWbz47PHqidHQns44kb4Bk3wqA9SNCa4U3L4rMtJ
         0ynd/OBOrF83WpWFueZH32SgQCK7X9/nl6VyCQr5M9MMJO6etvIWRDERLnCdm/ocbr
         FLQ75NaT0a89Q==
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 0/5] objtool: warning improvements
Date:   Mon, 27 Mar 2023 09:00:43 -0700
Message-Id: <cover.1679932620.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add some user-friendliness to the warnings:

- Add OBJTOOL_ARGS="--verbose" option for making it easier to debug
  objtool warnings over email

- Remove per-file rate limiting (doesn't make sense for vmlinux.o)

- Add "missing __noreturn" warning

Josh Poimboeuf (5):
  objtool: Add '--verbose' option for disassembling affected functions
  objtool: Combine '--backtrace' with '--verbose'
  objtool: Remove superfluous dead_end_function() check
  objtool: Add per-function rate limiting for unreachable warnings
  objtool: Add "missing __noreturn" warning

 tools/objtool/Documentation/objtool.txt | 12 ++++++
 tools/objtool/builtin-check.c           |  2 +-
 tools/objtool/check.c                   | 45 ++++++++++++---------
 tools/objtool/include/objtool/builtin.h |  2 +-
 tools/objtool/include/objtool/elf.h     |  1 +
 tools/objtool/include/objtool/warn.h    | 52 ++++++++++++++++++++++---
 6 files changed, 88 insertions(+), 26 deletions(-)

-- 
2.39.2

