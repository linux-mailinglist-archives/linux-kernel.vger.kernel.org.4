Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BE557255C4
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 09:35:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239279AbjFGHew (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 03:34:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238403AbjFGHe3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 03:34:29 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7E84E6B
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 00:29:42 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 868EB1FDA8;
        Wed,  7 Jun 2023 07:29:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1686122981; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=2xz45jiB4HUD1RJdTPfmRcnsCKtUN8cV29Vg55Nf0vU=;
        b=sPBeW+4QFQMUi1yyebZ0dSyaojzpnzxZ8Z4u9h5LD+E+wVHWpGgy8lBdEcLBkB+8lWmnVa
        YJl04uy4qc11m3C1yjK0FmA+TKCHaV+J+43fSHvIOQCXIV3np4SA1JmZDsTqDnGafvfrwU
        0ws4FKY00Ivccf68ZDYQdu2Rdh0eoJA=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3577413776;
        Wed,  7 Jun 2023 07:29:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id X+4/CuUxgGSUIQAAMHmgww
        (envelope-from <nik.borisov@suse.com>); Wed, 07 Jun 2023 07:29:41 +0000
From:   Nikolay Borisov <nik.borisov@suse.com>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, mhocko@suse.com, jslaby@suse.cz,
        Nikolay Borisov <nik.borisov@suse.com>
Subject: [RFC PATCH 0/3] Add ability to disable ia32 at boot time
Date:   Wed,  7 Jun 2023 10:29:33 +0300
Message-Id: <20230607072936.3766231-1-nik.borisov@suse.com>
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

We at SUSE would like to have the ability to disable IA32 compat layer and to
give users the ability to override this decision. The motivation behind this is
the fact that the compat layer is not as thoroughly tested/exercised as the native
64bit one. At the same time there are environments where 32bit is still in use
and we'd like to cater to those as well.

As a first step this patchset introduces the 'ia32_disabled' boot time parameter
which breaks 32bit support. This is achieved mainly by setting the user32 cs in the
GDT as not present (P bit set to 0) and making the int 0x80 call gate also not
present. It also re-uses the existing code which makes sysenter defunct when
IA32_EMULATION is not selected. Finally, it also ensures that 32bit processes
can't be loaded by the compat elf loader.

I'm sending now to solicit opinions whether this is an acceptable solution, in the
future likely the mechanism for enabling this would be changed. I.e instead of a
boot time parameter to disable I think we'd ideally introduce a new Kconfig option
which in the distro case might default to "ia32_disabled" whilst the upstream would
retain the current behavior. But before getting into this discussion I'd like to
get confirmation that what I'm doing w.r.t to x86 architecture is not completely
bogus.

Nikolay Borisov (3):
  x86: Introduce ia32_disabled boot parameter
  x86/entry: Disable IA32 syscalls in the presence of ia32_disabled
  x86: Disable running 32bit processes if ia32_disabled is passed

 arch/x86/entry/common.c      | 12 ++++++++++++
 arch/x86/entry/entry_64.S    |  2 --
 arch/x86/include/asm/desc.h  |  5 +++++
 arch/x86/include/asm/elf.h   |  5 +++--
 arch/x86/include/asm/traps.h |  4 ++++
 arch/x86/kernel/cpu/common.c | 37 +++++++++++++++++++++++++-----------
 6 files changed, 50 insertions(+), 15 deletions(-)

--
2.34.1

