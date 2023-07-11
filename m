Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14ECA74EA4E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 11:25:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232160AbjGKJZO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 05:25:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231782AbjGKJYs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 05:24:48 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBA1FF7;
        Tue, 11 Jul 2023 02:20:15 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 676B4226B8;
        Tue, 11 Jul 2023 09:20:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1689067214; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=1jlkb8dUUa0Nv29PncgxS1y0JcIN/aXBsVfRkm+5+/k=;
        b=SQcGB8uQgfa14QM7KSMT2CXef1FZOxkEY2eO9m0hIECqCvg5dyDqs8GjTLcYrp0Nuccupd
        +JnmjAwVPOUkF1dNu+dMSvE1kEKTrx/L2t/Y4ojlka+tm0s8PG8UUHQ1otJVUZ6Mybieal
        7Iks0BXJEpBdVuAUVSInOe+W/AQ0qRk=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 34BD71390F;
        Tue, 11 Jul 2023 09:20:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id jtwYDM4erWSiVwAAMHmgww
        (envelope-from <petr.pavlu@suse.com>); Tue, 11 Jul 2023 09:20:14 +0000
From:   Petr Pavlu <petr.pavlu@suse.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, mhiramat@kernel.org,
        peterz@infradead.org
Cc:     samitolvanen@google.com, x86@kernel.org,
        linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Petr Pavlu <petr.pavlu@suse.com>
Subject: [PATCH v2 0/2] x86/retpoline,kprobes: Fix the [__indirect_thunk_start, ..end] range
Date:   Tue, 11 Jul 2023 11:19:50 +0200
Message-Id: <20230711091952.27944-1-petr.pavlu@suse.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix problems with an output position of thunk sections and the
associated definition of range [__indirect_thunk_start,
__indirect_thunk_end] which affects the kprobes optimization.

Initial v1 of the series kept the mentioned range but it turns out the
logic which uses it is not necessary so it is removed altogether.

Changes since v1 [1]:
- Drop the patch which moved the return thunk out of
  [__indirect_thunk_start, ..end] and instead replace it with a removal
  of the kprobes optimization check which looked for calls to indirect
  thunks.
- Slightly adjust the commit message for the first patch, to better
  match the new second patch.

[1] https://lore.kernel.org/lkml/20230705081547.25130-1-petr.pavlu@suse.com/

Petr Pavlu (2):
  x86/retpoline,kprobes: Fix position of thunk sections with
    CONFIG_LTO_CLANG
  x86/retpoline,kprobes: Skip optprobe check for indirect jumps with
    retpolines and IBT

 arch/x86/include/asm/nospec-branch.h |  3 ---
 arch/x86/kernel/kprobes/opt.c        | 40 +++++++++++-----------------
 arch/x86/kernel/vmlinux.lds.S        |  4 +--
 arch/x86/lib/retpoline.S             |  4 +--
 tools/perf/util/thread-stack.c       |  4 +--
 5 files changed, 20 insertions(+), 35 deletions(-)

-- 
2.35.3

