Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42EC85F3DEB
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 10:12:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230049AbiJDIML (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 04:12:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbiJDILn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 04:11:43 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E1594F670
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 01:10:34 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id BEFBE1F8D7;
        Tue,  4 Oct 2022 08:10:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1664871032; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FRQlMbR3LekauN/VGAqwz3/4iPTsfJTb9AkfSRaurK0=;
        b=Bc321u1uSx/Woo0VO1AgbzJrbEz3j0u/T50iz/y3r4mphjnc9Un9ZWZ3fE3YmPrp8RZSW7
        SAf2fH3CQUoQAvjV0Qf0AV6hOhKMWXDgXgj5s50xhgNhU6kMqOr7EzZksDvhXmA1tNyfa2
        KRPh0WuuTofShaWUItutW5O38uE/xCI=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 82513139EF;
        Tue,  4 Oct 2022 08:10:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id uq1sHnjqO2MlSAAAMHmgww
        (envelope-from <jgross@suse.com>); Tue, 04 Oct 2022 08:10:32 +0000
From:   Juergen Gross <jgross@suse.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Juergen Gross <jgross@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH v4 01/16] x86/mtrr: add comment for set_mtrr_state() serialization
Date:   Tue,  4 Oct 2022 10:10:08 +0200
Message-Id: <20221004081023.32402-2-jgross@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20221004081023.32402-1-jgross@suse.com>
References: <20221004081023.32402-1-jgross@suse.com>
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

Add a comment how set_mtrr_state() is needing serialization.

Suggested-by: Borislav Petkov <bp@alien8.de>
Signed-off-by: Juergen Gross <jgross@suse.com>
---
V3:
- new patch instead of old patch 1
---
 arch/x86/kernel/cpu/mtrr/generic.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/mtrr/generic.c b/arch/x86/kernel/cpu/mtrr/generic.c
index 558108296f3c..cd64eab02393 100644
--- a/arch/x86/kernel/cpu/mtrr/generic.c
+++ b/arch/x86/kernel/cpu/mtrr/generic.c
@@ -684,7 +684,10 @@ static u32 deftype_lo, deftype_hi;
 /**
  * set_mtrr_state - Set the MTRR state for this CPU.
  *
- * NOTE: The CPU must already be in a safe state for MTRR changes.
+ * NOTE: The CPU must already be in a safe state for MTRR changes, including
+ *       measures that only a single CPU can be active in set_mtrr_state() in
+ *       order to not be subject to races for usage of deftype_lo (this is
+ *       accomplished by taking set_atomicity_lock).
  * RETURNS: 0 if no changes made, else a mask indicating what was changed.
  */
 static unsigned long set_mtrr_state(void)
-- 
2.35.3

