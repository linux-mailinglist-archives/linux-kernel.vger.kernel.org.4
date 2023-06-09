Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4CE07297EA
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 13:13:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229966AbjFILNT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 07:13:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231324AbjFILNR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 07:13:17 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 250511FDC
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 04:13:16 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id C95CB21A13;
        Fri,  9 Jun 2023 11:13:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1686309194; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=sARbpKkak15x0b93ZKVWPSJ4prKaBLUd7mvhcGT/ls8=;
        b=f4/AvFTMHtSbNbHRPcs5Fc8PBbKoqiLDgOp/ehr4KIeKJmTnQJ3Jm15NsXJqYAHkG6yNre
        FAhPaSp5Skuq8zdY2+yoZ22Zd0GPpaD6PGxAcSw9wijr3ktfDpn7TtX7oLZ5JChHgY+2wB
        pFsq8D4MkVUb8fqyV7v1kZT0M3F2CXU=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 711B0139C8;
        Fri,  9 Jun 2023 11:13:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id CgHGGEoJg2ReIwAAMHmgww
        (envelope-from <nik.borisov@suse.com>); Fri, 09 Jun 2023 11:13:14 +0000
From:   Nikolay Borisov <nik.borisov@suse.com>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, mhocko@suse.com, jslaby@suse.cz,
        Nikolay Borisov <nik.borisov@suse.com>
Subject: [PATCH v2 0/4] Make IA32_EMULATION boot time overridable
Date:   Fri,  9 Jun 2023 14:13:07 +0300
Message-Id: <20230609111311.4110901-1-nik.borisov@suse.com>
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

Here's the 2nd version of the patch which aims to make IA32_EMULATION essentially
a boot time option. The changes in this posting are:

* Introduced a compile-time option CONFIG_IA32_EMULATION_DEFAULT_DISABLED which
can be set during compile time and can be overriden at boot time via a new
parameter 'ia32_mode'.

* Documented the new parameter as per Thomas' suggestion

* Added a new patch which renames ignore_sysret as per Andrew Cooper's suggestion

* Fixed compat_elf_check_arch condition check to only affect compat process
loading and leave x32 abi processes alone

* Dropped GDT modification as this was deemed a separate change. Likely I'd need
to follow up with a more complete solution.

Nikolay Borisov (4):
  x86: Introduce CONFIG_IA32_EMULATION_DEFAULT_DISABLED Kconfig option
  x86/entry: Rename ignore_sysret and compile it unconditionally
  x86/entry: Disable IA32 syscall if ia32_disabled is true
  x86: Disable laoding 32bit processes if ia32_disabled is true

 .../admin-guide/kernel-parameters.txt         |  4 ++
 arch/x86/Kconfig                              |  5 +++
 arch/x86/entry/common.c                       | 16 ++++++++
 arch/x86/entry/entry_64.S                     |  6 +--
 arch/x86/include/asm/desc.h                   |  1 +
 arch/x86/include/asm/elf.h                    |  9 ++++-
 arch/x86/include/asm/processor.h              |  2 +-
 arch/x86/include/asm/traps.h                  |  4 ++
 arch/x86/kernel/cpu/common.c                  | 37 ++++++++++---------
 arch/x86/kernel/idt.c                         |  7 ++++
 10 files changed, 67 insertions(+), 24 deletions(-)

--
2.34.1

