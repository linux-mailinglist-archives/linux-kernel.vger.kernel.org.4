Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2ECE74E3BC
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 03:51:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230196AbjGKBv1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 21:51:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbjGKBvR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 21:51:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A46EA4;
        Mon, 10 Jul 2023 18:50:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0811861217;
        Tue, 11 Jul 2023 01:50:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 832D4C433C7;
        Tue, 11 Jul 2023 01:50:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689040241;
        bh=cTcnxfSzuVVM/ut1v16kNJC2utrcIMhUy/MYvzw6ZiY=;
        h=From:To:Cc:Subject:Date:From;
        b=k5BcaLv4ER43AGPRZqmLo7SZxdxqYVs9UMsjP/4SI9tQrN15Sfc2/JRCZyivckvqI
         3iAoFbakXjgK3TDOAkQ3I08SWC2tw01e0WaIJuBNVIlzInvXPEmy/NJUhtkSu+9Ap2
         nvrp0FeyFwYj7E0Dtrm4XK1nEMUyJJspz0UwZjVlcnp7IXS6rd8u8AJX3p13dS+A+n
         RO/CBQhv04A32sUyF7dySrQVZ5ZZjz7NCq6xBNyZeY53l75V8lgADgJ3u4ADUTDJj+
         sB0AMGFBGjVDhVIlihcXnKqJ2ksKptuVzia7wLzVm2IltwcYKFl0AACvQYVE3/75P5
         IMFFXNulbpxNQ==
From:   "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Petr Pavlu <petr.pavlu@suse.com>, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, samitolvanen@google.com, x86@kernel.org,
        linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH v2 0/2] x86: kprobes: Fix CFI_CLANG related issues
Date:   Tue, 11 Jul 2023 10:50:35 +0900
Message-Id: <168904023542.116016.10540228903086100726.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here is the 2nd version of the kprobe patches for kernel CFI.
Previous version is here;

https://lore.kernel.org/all/168899125356.80889.17967397360941194229.stgit@devnote2/

In this version "__pfx_" prefix symbols also are prohibited and that check
is done unconditionally [1/2].

- Prohibit probing on __cfi_* and __pfx_* preamble symbols, which have CFI info.
- Prohibit probing on compiler generated movl/addl which is used for
  detecting typeid on x86.

Thank you,

---

Masami Hiramatsu (Google) (2):
      kprobes: Prohibit probing on CFI preamble symbol
      x86/kprobes: Prohibit probing on compiler generated CFI checking code


 arch/x86/kernel/kprobes/core.c |   34 ++++++++++++++++++++++++++++++++++
 kernel/kprobes.c               |   14 +++++++++++++-
 2 files changed, 47 insertions(+), 1 deletion(-)

--
Masami Hiramatsu (Google) <mhiramat@kernel.org>
