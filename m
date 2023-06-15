Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85923731916
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 14:40:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245485AbjFOMkK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 08:40:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245029AbjFOMkE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 08:40:04 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D0751FE4
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 05:40:02 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 38D70223DE;
        Thu, 15 Jun 2023 12:40:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1686832801; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=sLKvpHmhwxzhGsa8RD9GXj1E3Cqd53RX8qPUzRGgONI=;
        b=Adcvt8jp3J6VJHStWp7XI8UqjjBdIO+60lveaGrjsR2IoO908L/uW+lrRpAlKri7Tr1U1b
        0rSAZhSTlsBqaIbAeAjCVNdKHFRgkFCQ/FRCyulDtp7vEKz/s5lL6REthbZkfhlyB+L2PA
        Eawu3ARj6wsxY5ljRaIEnRG2FZSLwEo=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D010513A47;
        Thu, 15 Jun 2023 12:40:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id JJxjMaAGi2T1OQAAMHmgww
        (envelope-from <jgross@suse.com>); Thu, 15 Jun 2023 12:40:00 +0000
From:   Juergen Gross <jgross@suse.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, xen-devel@lists.xenproject.org
Subject: [PATCH] x86/xen: set default memory type for pv guests to WB
Date:   Thu, 15 Jun 2023 14:39:59 +0200
Message-Id: <20230615123959.12298-1-jgross@suse.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When running as an unprivileged PV-guest under Xen (not dom0), the
default MTRR memory type should be write-back.

Signed-off-by: Juergen Gross <jgross@suse.com>
---
Based on tip x86/mtrr branch
---
 arch/x86/xen/enlighten_pv.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/xen/enlighten_pv.c b/arch/x86/xen/enlighten_pv.c
index 8732b85d5650..93b658248d01 100644
--- a/arch/x86/xen/enlighten_pv.c
+++ b/arch/x86/xen/enlighten_pv.c
@@ -187,6 +187,8 @@ static void __init xen_pv_init_platform(void)
 
 	if (xen_initial_domain())
 		xen_set_mtrr_data();
+	else
+		mtrr_overwrite_state(NULL, 0, MTRR_TYPE_WRBACK);
 }
 
 static void __init xen_pv_guest_late_init(void)
-- 
2.35.3

