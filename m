Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CA00617BA8
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 12:36:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231316AbiKCLgz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 07:36:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231151AbiKCLgu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 07:36:50 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89A8C6401
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 04:36:46 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 0B6971F88C;
        Thu,  3 Nov 2022 11:36:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1667475405; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=R2jqME7F+qdUftTzWR72PDDjTzwv0qCQjs1xhw+ZdsU=;
        b=lMyg6ETc97azzoW47K210vpzsQEyM8fTV4c+5WVVzcj+0lcLDHxabMpcsuQMWDFQvtAZN4
        0hHPII4l8tRuDyGpgjP5TscidSmhQjiCJvhdysgX8my9WIWoEW2vGXjt+IpIi1/24B0r9O
        Dk7aO6PBwgzOCy9oygMAKvYkeLf/lvk=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A806913480;
        Thu,  3 Nov 2022 11:36:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id zT6jJ8ynY2PoHgAAMHmgww
        (envelope-from <jgross@suse.com>); Thu, 03 Nov 2022 11:36:44 +0000
From:   Juergen Gross <jgross@suse.com>
To:     linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        x86@kernel.org
Cc:     Juergen Gross <jgross@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Pu Wen <puwen@hygon.cn>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 0/4] Switch X86_FEATURE_XENPV to cpu_feature_enabled() use
Date:   Thu,  3 Nov 2022 12:36:32 +0100
Message-Id: <20221103113636.25543-1-jgross@suse.com>
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

Make especially kernels without CONFIG_XEN_PV more efficient by
using cpu_feature_enabled(X86_FEATURE_XENPV) instead of boot_cpu_has()
and friends.

Juergen Gross (4):
  x86: add X86_FEATURE_XENPV to disabled-features.h
  x86: remove unneeded 64-bit dependency in arch_enter_from_user_mode()
  x86: drop 32-bit Xen PV guest code in update_task_stack()
  x86: switch to cpu_feature_enabled() for X86_FEATURE_XENPV

 arch/x86/include/asm/disabled-features.h | 8 +++++++-
 arch/x86/include/asm/entry-common.h      | 4 ++--
 arch/x86/include/asm/switch_to.h         | 7 ++-----
 arch/x86/kernel/cpu/amd.c                | 2 +-
 arch/x86/kernel/cpu/bugs.c               | 2 +-
 arch/x86/kernel/cpu/hygon.c              | 2 +-
 arch/x86/kernel/process_64.c             | 4 ++--
 arch/x86/kernel/topology.c               | 2 +-
 arch/x86/mm/cpu_entry_area.c             | 2 +-
 9 files changed, 18 insertions(+), 15 deletions(-)

-- 
2.35.3

