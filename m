Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 064E168D095
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 08:29:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbjBGH3N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 02:29:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbjBGH3K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 02:29:10 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 791BC34C2E
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 23:29:06 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E3CB433F80;
        Tue,  7 Feb 2023 07:29:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1675754944; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=MhzFDtsAW7HGFyJsdd8sgxJcagJnKbvVl09kVEsq7/Y=;
        b=FgGXb0n9hWrBfJEwv4hvJrzDHw/8BMKtRnbedQIrAirbHgNX531oiTRnXK/SnBUMR/d+LT
        9pSgt/4BzlbqiinSSlL8lVBOQ1ilr2cx/sNByTQAySnYecA3qD9OhkP3qEIw+GeEiO857z
        BtAIzLsaJIlGVecvWdPu3Sfcn65N3cI=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8AF5B13A8C;
        Tue,  7 Feb 2023 07:29:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 2u6WIMD94WOYUQAAMHmgww
        (envelope-from <jgross@suse.com>); Tue, 07 Feb 2023 07:29:04 +0000
From:   Juergen Gross <jgross@suse.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     lists@nerdbynature.de, mikelley@microsoft.com,
        torvalds@linux-foundation.org, Juergen Gross <jgross@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 0/6] x86/mtrr: fix handling with PAT but without MTRR
Date:   Tue,  7 Feb 2023 08:28:56 +0100
Message-Id: <20230207072902.5528-1-jgross@suse.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series tries to fix the rather special case of PAT being available
without having MTRRs (either due to CONFIG_MTRR being not set, or
because the feature has been disabled e.g. by a hypervisor).

The main use cases are Xen PV guests and SEV-SNP guests running under
Hyper-V.

Patch 2 seems to be a little hacky, as it special cases only
memtype_reserve() and memtype_free(), but OTOH this doesn't seem to
be worse than in previous days, where PAT was disabled when MTRRs
haven't been available.

My tests with Xen didn't show any problems, but I'm rather sure I
couldn't cover all corner cases.

The only cleaner solution I could think of would be to introduce MTRR
read-only access. It would theoretically be possible to get the actual
MTRR contents for the variable MTRRs from Xen, but I'm not sure this
is really the way to go.

For the SEV-SNP case with Hyper-V I guess such a read-only mode could
be rather simple, but I'm really not sure this would cover all needed
corner cases (I'd basically say always "WB" in that case).

I have added more cleanup which has been discussed when looking into
the most recent failures.

Juergen Gross (6):
  x86/mtrr: make mtrr_enabled() non-static
  x86/pat: check for MTRRs enabled in memtype_reserve()
  x86/mtrr: revert commit 90b926e68f50
  x86/mtrr: don't let mtrr_type_lookup() return MTRR_TYPE_INVALID
  x86/mm: only check uniform after calling mtrr_type_lookup()
  x86/mtrr: drop sanity check in mtrr_type_lookup_fixed()

 arch/x86/include/asm/mtrr.h        | 13 +++++++++++--
 arch/x86/include/uapi/asm/mtrr.h   |  6 +++---
 arch/x86/kernel/cpu/mtrr/generic.c | 10 +++-------
 arch/x86/kernel/cpu/mtrr/mtrr.c    |  2 +-
 arch/x86/mm/pat/memtype.c          | 13 ++++++++-----
 arch/x86/mm/pgtable.c              |  6 ++----
 6 files changed, 28 insertions(+), 22 deletions(-)

-- 
2.35.3

