Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D817E5F3EA6
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 10:44:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbiJDIoW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 04:44:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbiJDIoU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 04:44:20 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C94BA3ECD9;
        Tue,  4 Oct 2022 01:44:15 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id EE5721F906;
        Tue,  4 Oct 2022 08:44:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1664873053; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=pkvZorSqwy2f71DPO/+7+BS5jmcswx42HigCezR1J2c=;
        b=htAnD9jVfSLDJkzaPxT31pjcyxBQjj+t59V8w6XLyz8YrjMUa8Vy2EzU84Kq52RaRo6d5n
        aa0YhuQ/1q9iaLI+0ULaX/7o/9+88FXRcgFgk15Hewr1mj3Kk21JhfWOpbTj2nGhGu/won
        PXqtACp/oAEAq1Gx8lVJ7ky+TV3sg4A=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9A4D3139D2;
        Tue,  4 Oct 2022 08:44:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id m9ZEJF3yO2OjVwAAMHmgww
        (envelope-from <jgross@suse.com>); Tue, 04 Oct 2022 08:44:13 +0000
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
Subject: [PATCH v2 0/3] xen/pv: sanitize xen pv guest msr accesses
Date:   Tue,  4 Oct 2022 10:43:32 +0200
Message-Id: <20221004084335.2838-1-jgross@suse.com>
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

Historically when running as Xen PV guest all MSR accesses have been
silently swallowing any GP faults, even when the kernel was using not
the *msr_safe() access functions.

Change that by making the behavior controllable via kernel config and
via a boot parameter.

This will help finding paths where MSRs are being accessed under Xen
which are not emulated by the hypervisor.

Juergen Gross (3):
  xen/pv: allow pmu msr accesses to cause GP
  xen/pv: refactor msr access functions to support safe and unsafe
    accesses
  xen/pv: support selecting safe/unsafe msr accesses

 .../admin-guide/kernel-parameters.txt         |  6 ++
 arch/x86/xen/Kconfig                          |  9 ++
 arch/x86/xen/enlighten_pv.c                   | 99 +++++++++++++------
 arch/x86/xen/pmu.c                            | 61 ++++++------
 4 files changed, 118 insertions(+), 57 deletions(-)

-- 
2.35.3

