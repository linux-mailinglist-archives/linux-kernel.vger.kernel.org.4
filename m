Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7B9B662C53
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 18:11:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237255AbjAIRKu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 12:10:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237305AbjAIRKY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 12:10:24 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B0B53E84F
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 09:08:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673284138; x=1704820138;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Zp55EcXBjA8/SI7v5C56vmySTDi0uq3BVnyiRmn/O9I=;
  b=ads1sGtOqw5HpY1P/gOyH2BYDlTc0Jrki7hBQ0VkynEJMHfQBKm2kubf
   II4wwtCCtKc81nNJX/f9aF1G3LFGfbaDHejBfLbty48rQl6sHqNFue4fE
   AyOvyIOFmI8BVNq8ei52z/mi35NioRjIL4sSXvg4WEqk0xxVpcuJ+Dze6
   g4C8bmv5OlI6ehysyRANAHehSaJzyt7WSqnopg5ii/n0nARQNJMJ5AFL0
   OQmMKDOMRuzTrkh8G2pD88zkRonW9Sa+hJU4aqn/rTGom72yvyo29bNst
   1bPJ0kvk7nFOXFDarzT/oSykjmdGlJm+w/VwRNGYy08SdA0xYAaxI1guN
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10585"; a="310722816"
X-IronPort-AV: E=Sophos;i="5.96,311,1665471600"; 
   d="scan'208";a="310722816"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2023 09:05:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10585"; a="725236429"
X-IronPort-AV: E=Sophos;i="5.96,311,1665471600"; 
   d="scan'208";a="725236429"
Received: from irvmail001.ir.intel.com ([10.43.11.63])
  by fmsmga004.fm.intel.com with ESMTP; 09 Jan 2023 09:05:12 -0800
Received: from newjersey.igk.intel.com (newjersey.igk.intel.com [10.102.20.203])
        by irvmail001.ir.intel.com (8.14.3/8.13.6/MailSET/Hub) with ESMTP id 309H5Bdw030759;
        Mon, 9 Jan 2023 17:05:11 GMT
From:   Alexander Lobakin <alexandr.lobakin@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>
Cc:     Alexander Lobakin <alexandr.lobakin@intel.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Tony Luck <tony.luck@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Masahiro Yamada <masahiroy@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/2] x86/boot: fix relying on link order
Date:   Mon,  9 Jan 2023 18:04:01 +0100
Message-Id: <20230109170403.4117105-1-alexandr.lobakin@intel.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, the x86 decompressor code expects the kernel entry point to be
exactly at the beginning of the kernel image. It's always been true, but
is hacky in multiple ways: special .head.text section and linking certain
object files first to have them at the beginning.
Make the code independent from the link order and then kill the latter.
The former is to be resolved a bit later.

I didn't put any "Fixes:" tag since it's not linear. The lines changed
with 0001 came from the initial x86 KASLR series, but that unconditional
jump to the kernel beginning already was there. It goes at least from the
set that brought relocatable kernel support to x86, but this is quite
prehistoric already and might not look really relatable.

Alexander Lobakin (2):
  x86/boot: robustify calling startup_{32,64}() from the decompressor
    code
  scripts/head-object-list: remove x86 from the list

 arch/x86/boot/compressed/head_32.S |  2 +-
 arch/x86/boot/compressed/head_64.S |  2 +-
 arch/x86/boot/compressed/misc.c    | 18 +++++++++++-------
 scripts/head-object-list.txt       |  6 ------
 4 files changed, 13 insertions(+), 15 deletions(-)

---
From v2[0]:
 * rebase on top of 6.2;
 * prettify debug entry point print.

From v1[1]:
 * collect the Tested-by tags (Jiri);
 * don't add pathetic returns after noreturn error() (Jiri);
 * debug-print the entry point offset via debug_putaddr() before
   booting (Jiri);
 * always have an empty line before return statements (Jiri). 

[0] https://lore.kernel.org/all/20221101161529.1634188-1-alexandr.lobakin@intel.com
[1] https://lore.kernel.org/all/20221031151047.167288-1-alexandr.lobakin@intel.com
-- 
2.39.0

