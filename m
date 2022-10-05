Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C83D5F530A
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 13:03:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229737AbiJELDM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 07:03:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbiJELDK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 07:03:10 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6448B6CF4F;
        Wed,  5 Oct 2022 04:03:07 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 0FDCB218FE;
        Wed,  5 Oct 2022 11:03:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1664967785; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=Mn2ERzJt4xEctpaemvG4sO9hC3a9tpeTQ3BtEW76vKI=;
        b=PfVG4z/1OzaVpXpTB/EtYtDvm0Clx6Ojw24ScC8wkwrg3FX8MZ8CHsTfH1GXTTEqfOLljI
        152mpZVrMGozo3d/l+uCpTkGfqL//JcoKMWw2bvXKyPv1mgILh/FNFjVO1X1o+Cwc253iA
        3zrdguoCBHG1ytezJtEmFNBAJURdWzg=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B03A313345;
        Wed,  5 Oct 2022 11:03:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id dt+zKWhkPWPbQgAAMHmgww
        (envelope-from <jgross@suse.com>); Wed, 05 Oct 2022 11:03:04 +0000
From:   Juergen Gross <jgross@suse.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-doc@vger.kernel.org
Cc:     Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, xen-devel@lists.xenproject.org,
        Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v3 0/4] xen/pv: sanitize xen pv guest msr accesses
Date:   Wed,  5 Oct 2022 13:02:58 +0200
Message-Id: <20221005110302.13455-1-jgross@suse.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Historically when running as Xen PV guest all MSR accesses have been
silently swallowing any GP faults, even when the kernel was using not
the *msr_safe() access functions.

Change that by making the behavior controllable via kernel config and
via a boot parameter.

This will help finding paths where MSRs are being accessed under Xen
which are not emulated by the hypervisor.

Changes in V3:
- new patch 2
- addressed comments

Juergen Gross (4):
  xen/pv: add fault recovery control to pmu msr accesses
  xen/pv: fix vendor checks for pmu emulation
  xen/pv: refactor msr access functions to support safe and unsafe
    accesses
  xen/pv: support selecting safe/unsafe msr accesses

 .../admin-guide/kernel-parameters.txt         |  6 ++
 arch/x86/xen/Kconfig                          |  9 ++
 arch/x86/xen/enlighten_pv.c                   | 99 +++++++++++++------
 arch/x86/xen/pmu.c                            | 71 +++++++------
 4 files changed, 127 insertions(+), 58 deletions(-)

-- 
2.35.3

