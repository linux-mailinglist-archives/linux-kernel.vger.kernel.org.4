Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E02C6191E0
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 08:27:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231339AbiKDH1T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 03:27:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbiKDH1G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 03:27:06 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5A9D29C8F
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 00:27:05 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 023DE1F74A;
        Fri,  4 Nov 2022 07:27:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1667546824; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=bESrsZp5nkJG/KdIDLKESNyabZqvX9dwTKnh7zplFPc=;
        b=n9o+6s3UG78TbvKngU6Oi+3uY2MUMWfFweD7Wtr6ymwqRx4TqaGq8uvAMGtf83rd5scylQ
        CVX9dPWF40VZMavSSC6wYSTPb4UhtbL+OspARLblOSHwGV3nXiydvJ94caPsOJUvkYjpCW
        ITxrIbaCKjSBJNpgH6PrJran/aYm0MA=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A76AD1346F;
        Fri,  4 Nov 2022 07:27:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id MCOfJ8e+ZGPWQAAAMHmgww
        (envelope-from <jgross@suse.com>); Fri, 04 Nov 2022 07:27:03 +0000
From:   Juergen Gross <jgross@suse.com>
To:     linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        x86@kernel.org
Cc:     Juergen Gross <jgross@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, Pu Wen <puwen@hygon.cn>
Subject: [PATCH v2 0/5] x86: Switch X86_FEATURE_XENPV to cpu_feature_enabled() use
Date:   Fri,  4 Nov 2022 08:26:56 +0100
Message-Id: <20221104072701.20283-1-jgross@suse.com>
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

Changes in V2:
- new patch 4

Juergen Gross (5):
  x86: add X86_FEATURE_XENPV to disabled-features.h
  x86: remove unneeded 64-bit dependency in arch_enter_from_user_mode()
  x86: drop 32-bit Xen PV guest code in update_task_stack()
  x86: remove X86_FEATURE_XENPV usage in setup_cpu_entry_area()
  x86: switch to cpu_feature_enabled() for X86_FEATURE_XENPV

 arch/x86/include/asm/disabled-features.h | 8 +++++++-
 arch/x86/include/asm/entry-common.h      | 4 ++--
 arch/x86/include/asm/switch_to.h         | 7 ++-----
 arch/x86/kernel/cpu/amd.c                | 2 +-
 arch/x86/kernel/cpu/bugs.c               | 2 +-
 arch/x86/kernel/cpu/hygon.c              | 2 +-
 arch/x86/kernel/process_64.c             | 4 ++--
 arch/x86/kernel/topology.c               | 2 +-
 arch/x86/mm/cpu_entry_area.c             | 8 ++------
 9 files changed, 19 insertions(+), 20 deletions(-)

-- 
2.35.3

