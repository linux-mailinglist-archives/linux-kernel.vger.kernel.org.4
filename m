Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D1E073B5E6
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 13:14:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231789AbjFWLOT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 07:14:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231272AbjFWLOQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 07:14:16 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F90F10A
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 04:14:15 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id B6FC41F390;
        Fri, 23 Jun 2023 11:14:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1687518853; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=VPkRF0yMkyjofOEDttGkbk+ydecH5rRboOUBk8Lt91E=;
        b=rf70uEgs8HTF81hkvHG9Llfel+MSbhSxdIiwAu8L7vgJxCp2RFS3r2w7mcKlCU62BTxvGA
        pNaMuWKEvxFlPCKNMy8ML8nNxVkRWrRwkshFeiZzRTVS/x+M+eYX3JTT8yL5G4YNtKJYRp
        RsZ6v6C0UwvqdQz2XiFS4DYo0VcN/bQ=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5BF5D1331F;
        Fri, 23 Jun 2023 11:14:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 7jahE4V+lWTcFAAAMHmgww
        (envelope-from <nik.borisov@suse.com>); Fri, 23 Jun 2023 11:14:13 +0000
From:   Nikolay Borisov <nik.borisov@suse.com>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, mohocko@suse.com, jslaby@suse.cz,
        Nikolay Borisov <nik.borisov@suse.com>
Subject: [PATCH v4 0/6] Make IA32_EMULATION boot time overridable
Date:   Fri, 23 Jun 2023 14:14:03 +0300
Message-Id: <20230623111409.3047467-1-nik.borisov@suse.com>
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

Here's v4 of the patchset, incorporating latest round of reviews, Namely,

* Split the first patch into 2  - one introducing the ia32_enabled() function
which simply return true if IA32_EMULATION is selected.

* Some minor typos (rdunlap)

* Reworked some changelogs.

* Added one final patch which introduces the Kconfig/boot time parameter after
everything is predicated on ia32_enabled. This allows the config switch to be
fully operable when it's introduced. (tgxl)

* Renamed the runtime parameter name to ia32_emulation and its format to bool.

Nikolay Borisov (6):
  x86: Introduce ia32_enabled
  x86/entry: Rename ignore_sysret
  x86/entry: Compile entry_SYSCALL32_ignore unconditionally
  x86/elf: Make loading of 32bit processes depend on ia32_enabled()
  x86/entry: Make IA32 syscalls' availability depend on ia32_enabled()
  x86: Make IA32_EMULATION boot time configurable

 .../admin-guide/kernel-parameters.txt         |  5 +++
 arch/x86/Kconfig                              |  9 +++++
 arch/x86/entry/common.c                       | 20 ++++++++++
 arch/x86/entry/entry_64.S                     |  6 +--
 arch/x86/include/asm/elf.h                    |  3 +-
 arch/x86/include/asm/ia32.h                   | 16 +++++++-
 arch/x86/include/asm/processor.h              |  2 +-
 arch/x86/include/asm/proto.h                  |  3 ++
 arch/x86/kernel/cpu/common.c                  | 37 ++++++++++---------
 arch/x86/kernel/idt.c                         |  7 ++++
 10 files changed, 83 insertions(+), 25 deletions(-)

--
2.34.1

