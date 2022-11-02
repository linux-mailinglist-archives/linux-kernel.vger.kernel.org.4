Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 275B8615D1C
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 08:47:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230420AbiKBHr1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 03:47:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230419AbiKBHrX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 03:47:23 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F6D225EAA
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 00:47:22 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 55A521F8F6;
        Wed,  2 Nov 2022 07:47:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1667375241; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2leKddvHcFKOPECovCQoX+YzpPkMWoS3wh7BhleyL14=;
        b=qFgHZiO+6+gBo4apQivoOgk7d+PDAndeKnWMGSowg6KGs6QioJHppeR7vHkmYpH6KtMdgF
        cfzprQcBHxXtNLEUIaqOn+EWTQrTuPdKkviAL7c1c2/IGtql0fIxihe8NlKNOAHv5ul4aP
        J/cF3nKW98YaLLZ0NFGUupSp9zkkHtM=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1C4171376E;
        Wed,  2 Nov 2022 07:47:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id zhumBYkgYmOLcgAAMHmgww
        (envelope-from <jgross@suse.com>); Wed, 02 Nov 2022 07:47:21 +0000
From:   Juergen Gross <jgross@suse.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Juergen Gross <jgross@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH v5 01/16] x86/mtrr: add comment for set_mtrr_state() serialization
Date:   Wed,  2 Nov 2022 08:46:58 +0100
Message-Id: <20221102074713.21493-2-jgross@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20221102074713.21493-1-jgross@suse.com>
References: <20221102074713.21493-1-jgross@suse.com>
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

Note that this patch has already been applied to tip.git.

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

