Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D1067331BB
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 14:58:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345522AbjFPM57 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 08:57:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345503AbjFPM5x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 08:57:53 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A02251BF8
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 05:57:51 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 50C241F8AB;
        Fri, 16 Jun 2023 12:57:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1686920270; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=UUblm1SLH8JXbxs3N8jNcwJvhuYGSYIY3MAUPHTUEXI=;
        b=P+EKUSAwUOrNKY6sk+VCTMfVT45yeH/Xpdx83vR7sjnTL3K+o4jTOGPrEDaLJGJ321AZQm
        aqMm3JfVNzh385bRLsxM+sOSHReH2PgKp5eRJf6zcCv1KNhNZ+i8xzvn7lrmeWj4EbJp2U
        CZFkDVv3uVsL/1M3MWUrjkOXyjJ5r9g=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B350E1330B;
        Fri, 16 Jun 2023 12:57:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id XW8RKU1cjGTjNwAAMHmgww
        (envelope-from <nik.borisov@suse.com>); Fri, 16 Jun 2023 12:57:49 +0000
From:   Nikolay Borisov <nik.borisov@suse.com>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, mhocko@suse.com, jslaby@suse.cz,
        Nikolay Borisov <nik.borisov@suse.com>
Subject: [PATCH v3 0/5] Make IA32_EMULATION boot time overridable
Date:   Fri, 16 Jun 2023 15:57:25 +0300
Message-Id: <20230616125730.1164989-1-nik.borisov@suse.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Sending you to to gather a round of internals reviews before sending upstream]

Here's v3 of the patchset making IA32_EMULATION a boot time overridable switch.

Changes since v2:

* Re-worded the commit message of the first patch (tglx)
* Added help description for the newly introduces IA32_EMULATION_DEFAULT_DISABLED (rdunlap)
* Change the order of the last 2 patches (brgerst)
* Reworked the way ia32_enabled state is being checked - introduced a function
and eliminated code duplication (tglx)
* Reworked the way the idt table is being initialized (tglx)
* Split the rename and unconditional compile of of ignore_sysret (tglx)

Nikolay Borisov (5):
  x86: Make IA32_EMULATION boot time configurable
  x86/entry: Rename ignore_sysret
  x86/entry: Compile entry_SYSCALL32_ignore unconditionally
  x86/elf: Predicate loading of 32bit processes on ia32_enabled()
  x86/entry: Make IA32 syscalls availability depend on ia32_enabled()

 .../admin-guide/kernel-parameters.txt         |  5 +++
 arch/x86/Kconfig                              |  9 +++++
 arch/x86/entry/common.c                       | 16 ++++++++
 arch/x86/entry/entry_64.S                     |  6 +--
 arch/x86/include/asm/elf.h                    |  3 +-
 arch/x86/include/asm/ia32.h                   | 17 ++++++++-
 arch/x86/include/asm/processor.h              |  2 +-
 arch/x86/include/asm/proto.h                  |  3 ++
 arch/x86/kernel/cpu/common.c                  | 37 ++++++++++---------
 arch/x86/kernel/idt.c                         | 10 +++++
 10 files changed, 82 insertions(+), 26 deletions(-)

--
2.34.1

