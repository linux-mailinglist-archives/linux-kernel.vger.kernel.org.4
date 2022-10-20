Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7740C605F15
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 13:38:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231398AbiJTLih (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 07:38:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231407AbiJTLia (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 07:38:30 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8C9D1DEC01
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 04:38:03 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 92DE21FCFA;
        Thu, 20 Oct 2022 11:38:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1666265881; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=bOeIQs06Ph1bJ91eHAC9fBVgauw5j59B8/KvO9VWdAY=;
        b=PBpvCe+eKaNf8bwyjdesNestAeyQ6jmQl9dMvpuhLdQXjqPFo9p9VBZgDru/8YYuiEsJmQ
        M0a4vZAgkjF5JxMl8e5xw+lL3Gdm19fY3NtK8sbry4qXU0+EZFADAIQWui+2pHnFqOrQMh
        DHvIn+IF35Oa8nHjrGVNSMG5sLUEBEI=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4090D13494;
        Thu, 20 Oct 2022 11:38:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id REBlDhkzUWPEBgAAMHmgww
        (envelope-from <jgross@suse.com>); Thu, 20 Oct 2022 11:38:01 +0000
From:   Juergen Gross <jgross@suse.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, xen-devel@lists.xenproject.org,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH] x86/xen: silence smatch warning in pmu_msr_chk_emulated()
Date:   Thu, 20 Oct 2022 13:37:59 +0200
Message-Id: <20221020113759.17402-1-jgross@suse.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 8714f7bcd3c2 ("xen/pv: add fault recovery control to pmu msr
accesses") introduced code resulting in a warning issued by the smatch
static checker, claiming to use an uninitialized variable.

This is a false positive, but work around the warning nevertheless.

Fixes: 8714f7bcd3c2 ("xen/pv: add fault recovery control to pmu msr accesses")
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Juergen Gross <jgross@suse.com>
---
 arch/x86/xen/pmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/xen/pmu.c b/arch/x86/xen/pmu.c
index 68aff1382872..898a252ed6f1 100644
--- a/arch/x86/xen/pmu.c
+++ b/arch/x86/xen/pmu.c
@@ -302,7 +302,7 @@ static bool xen_amd_pmu_emulate(unsigned int msr, u64 *val, bool is_read)
 static bool pmu_msr_chk_emulated(unsigned int msr, uint64_t *val, bool is_read,
 				 bool *emul)
 {
-	int type, index;
+	int type = 0, index = 0;
 
 	if (is_amd_pmu_msr(msr))
 		*emul = xen_amd_pmu_emulate(msr, val, is_read);
-- 
2.35.3

