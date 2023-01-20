Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 512C46754A6
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 13:36:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230281AbjATMgJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 07:36:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230168AbjATMgA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 07:36:00 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1EDABD15B;
        Fri, 20 Jan 2023 04:35:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674218134; x=1705754134;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9Td56AXPQefHBhNcNDmLaayNhsuUevf9TJ/QNvlypS0=;
  b=STQG77oKiYSw/O0HI1bFpLgstPKox8xkxJIDDRQED4PpUEo+PYQYxlPu
   3yVcjaooXfDzuJYXb/W3MbdAvSOpsciGCDG2GvtB9O3f2+3OoJqzZPtu+
   w7PT4FxpPYlOABnMYPDFRgXU9MSRvfDfSd3G+dwpBghapnUbgP8xY/FDT
   uWWT2V0xM0HDCRI5rnIrMlpMM+1qzWuW15OuCMDENotJfg0SQLH9gNuR3
   vJ40XOShX6diwxTrO17GT9t1dqLckaXj2+d6Zo3I3j64R6aunDTbtAIwT
   uMqLPVgWEf+pQCCQXp5uxZMjR0G2eJY9HOZ2HfnH27KdRyb3viXmd76rq
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="387935279"
X-IronPort-AV: E=Sophos;i="5.97,232,1669104000"; 
   d="scan'208";a="387935279"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2023 04:35:33 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="692847452"
X-IronPort-AV: E=Sophos;i="5.97,232,1669104000"; 
   d="scan'208";a="692847452"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.251.223.163])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2023 04:35:31 -0800
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: [PATCH 08/10] perf symbols: Allow for .plt entries with no symbol
Date:   Fri, 20 Jan 2023 14:34:54 +0200
Message-Id: <20230120123456.12449-9-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230120123456.12449-1-adrian.hunter@intel.com>
References: <20230120123456.12449-1-adrian.hunter@intel.com>
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Create a sensible name for .plt entries with no symbol.

Example:

 Before:

   $ perf test --dso /usr/lib/x86_64-linux-gnu/libc.so.6 -vv Symbols 2>/tmp/cmp1.txt

 After:

   $ perf test --dso /usr/lib/x86_64-linux-gnu/libc.so.6 -vv Symbols 2>/tmp/cmp2.txt
   $ diff /tmp/cmp1.txt /tmp/cmp2.txt
    4c4
    < test child forked, pid 53043
    ---
    > test child forked, pid 54372
    23,62c23,62
    <  280f0-28100 g @plt
    <  28100-28110 g @plt
    <  28110-28120 g @plt
    <  28120-28130 g @plt
    <  28130-28140 g @plt
    <  28140-28150 g @plt
    <  28150-28160 g @plt
    <  28160-28170 g @plt
    <  28170-28180 g @plt
    <  28180-28190 g @plt
    <  28190-281a0 g @plt
    <  281a0-281b0 g @plt
    <  281b0-281c0 g @plt
    <  281c0-281d0 g @plt
    <  281d0-281e0 g @plt
    <  281e0-281f0 g @plt
    <  281f0-28200 g @plt
    <  28200-28210 g @plt
    <  28210-28220 g @plt
    <  28220-28230 g @plt
    <  28230-28240 g @plt
    <  28240-28250 g @plt
    <  28250-28260 g @plt
    <  28260-28270 g @plt
    <  28270-28280 g @plt
    <  28280-28290 g @plt
    <  28290-282a0 g @plt
    <  282a0-282b0 g @plt
    <  282b0-282c0 g @plt
    <  282c0-282d0 g @plt
    <  282d0-282e0 g @plt
    <  282e0-282f0 g @plt
    <  282f0-28300 g @plt
    <  28300-28310 g @plt
    <  28310-28320 g @plt
    <  28320-28330 g @plt
    <  28330-28340 g @plt
    <  28340-28350 g @plt
    <  28350-28360 g @plt
    <  28360-28370 g @plt
    ---
    >  280f0-28100 g offset_0x280f0@plt
    >  28100-28110 g offset_0x28100@plt
    >  28110-28120 g offset_0x28110@plt
    >  28120-28130 g offset_0x28120@plt
    >  28130-28140 g offset_0x28130@plt
    >  28140-28150 g offset_0x28140@plt
    >  28150-28160 g offset_0x28150@plt
    >  28160-28170 g offset_0x28160@plt
    >  28170-28180 g offset_0x28170@plt
    >  28180-28190 g offset_0x28180@plt
    >  28190-281a0 g offset_0x28190@plt
    >  281a0-281b0 g offset_0x281a0@plt
    >  281b0-281c0 g offset_0x281b0@plt
    >  281c0-281d0 g offset_0x281c0@plt
    >  281d0-281e0 g offset_0x281d0@plt
    >  281e0-281f0 g offset_0x281e0@plt
    >  281f0-28200 g offset_0x281f0@plt
    >  28200-28210 g offset_0x28200@plt
    >  28210-28220 g offset_0x28210@plt
    >  28220-28230 g offset_0x28220@plt
    >  28230-28240 g offset_0x28230@plt
    >  28240-28250 g offset_0x28240@plt
    >  28250-28260 g offset_0x28250@plt
    >  28260-28270 g offset_0x28260@plt
    >  28270-28280 g offset_0x28270@plt
    >  28280-28290 g offset_0x28280@plt
    >  28290-282a0 g offset_0x28290@plt
    >  282a0-282b0 g offset_0x282a0@plt
    >  282b0-282c0 g offset_0x282b0@plt
    >  282c0-282d0 g offset_0x282c0@plt
    >  282d0-282e0 g offset_0x282d0@plt
    >  282e0-282f0 g offset_0x282e0@plt
    >  282f0-28300 g offset_0x282f0@plt
    >  28300-28310 g offset_0x28300@plt
    >  28310-28320 g offset_0x28310@plt
    >  28320-28330 g offset_0x28320@plt
    >  28330-28340 g offset_0x28330@plt
    >  28340-28350 g offset_0x28340@plt
    >  28350-28360 g offset_0x28350@plt
    >  28360-28370 g offset_0x28360@plt

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/util/symbol-elf.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
index a8b7c3860b2d..6e4a22acefba 100644
--- a/tools/perf/util/symbol-elf.c
+++ b/tools/perf/util/symbol-elf.c
@@ -470,8 +470,11 @@ int dso__synthesize_plt_symbols(struct dso *dso, struct symsrc *ss)
 			demangled = demangle_sym(dso, 0, elf_name);
 			if (demangled != NULL)
 				elf_name = demangled;
-			snprintf(sympltname, sizeof(sympltname),
-				 "%s@plt", elf_name);
+			if (*elf_name)
+				snprintf(sympltname, sizeof(sympltname), "%s@plt", elf_name);
+			else
+				snprintf(sympltname, sizeof(sympltname),
+					 "offset_%#" PRIx64 "@plt", plt_offset);
 			free(demangled);
 
 			f = symbol__new(plt_offset, plt_entry_size,
@@ -496,8 +499,11 @@ int dso__synthesize_plt_symbols(struct dso *dso, struct symsrc *ss)
 			demangled = demangle_sym(dso, 0, elf_name);
 			if (demangled != NULL)
 				elf_name = demangled;
-			snprintf(sympltname, sizeof(sympltname),
-				 "%s@plt", elf_name);
+			if (*elf_name)
+				snprintf(sympltname, sizeof(sympltname), "%s@plt", elf_name);
+			else
+				snprintf(sympltname, sizeof(sympltname),
+					 "offset_%#" PRIx64 "@plt", plt_offset);
 			free(demangled);
 
 			f = symbol__new(plt_offset, plt_entry_size,
-- 
2.34.1

