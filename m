Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34E185EAB29
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 17:33:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236700AbiIZPdZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 11:33:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236694AbiIZPcy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 11:32:54 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F6764F69D;
        Mon, 26 Sep 2022 07:18:54 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 322F31F37C;
        Mon, 26 Sep 2022 14:18:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1664201933; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=IJOwLXU5t8JM8hMm9HW6Yq2/D7SfLk9zyZ5L9cgxtWU=;
        b=JGtbcNXpGA40iBntCL6y1LJnluPYXxk3hzbip2fUXMIhzCg1Xn8jmfj2iOPpA9x6KAs9NW
        YFuKaG8NHm486HGNuT/bNwlh+6lojOUffG9Q/iTOc+B+uVsGcwYiAlYTbp+wKKlU1tnWOf
        b9Ixakc+U1inpqhbv2Gcq6mLZpRVhWI=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CC7D6139BD;
        Mon, 26 Sep 2022 14:18:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id qBw/MMy0MWN/BgAAMHmgww
        (envelope-from <jgross@suse.com>); Mon, 26 Sep 2022 14:18:52 +0000
From:   Juergen Gross <jgross@suse.com>
To:     xen-devel@lists.xenproject.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Cc:     Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 0/3] xen/pv: sanitize xen pv guest msr accesses
Date:   Mon, 26 Sep 2022 16:18:46 +0200
Message-Id: <20220926141849.21805-1-jgross@suse.com>
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
 arch/x86/xen/enlighten_pv.c                   | 97 +++++++++++++------
 arch/x86/xen/pmu.c                            | 44 +++++----
 4 files changed, 110 insertions(+), 46 deletions(-)

-- 
2.35.3

