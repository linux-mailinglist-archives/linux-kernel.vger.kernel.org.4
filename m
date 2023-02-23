Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 920C06A04EF
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 10:34:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234058AbjBWJeL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 04:34:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233207AbjBWJeG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 04:34:06 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBA2753EE6
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 01:33:41 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id AD29B5C171;
        Thu, 23 Feb 2023 09:33:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1677144806; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YeH0hO+srtzbwE8WX1MqylWAbFnZLLMVUNqDdf20xnc=;
        b=JyT3S086+b+9IlesDpu0iz/0VjvWHRDGG5v/gWv5tK5fmdKCJKFE1DFnhHK2TCYlVz3M4j
        rDMaiSFmgwc/AD8EJoJh7R1c4N2VcMSlH+c/jfO3KlQfZFPswcjDzr+4lQ7lOgrm7EWn3y
        6gXVlR9FCW5NstmwkcW7N8KszYfV8M8=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 752D313928;
        Thu, 23 Feb 2023 09:33:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id GJVtG+Yy92PAbAAAMHmgww
        (envelope-from <jgross@suse.com>); Thu, 23 Feb 2023 09:33:26 +0000
From:   Juergen Gross <jgross@suse.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Juergen Gross <jgross@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH v3 07/12] x86/mtrr: allocate mtrr_value array dynamically
Date:   Thu, 23 Feb 2023 10:32:38 +0100
Message-Id: <20230223093243.1180-8-jgross@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230223093243.1180-1-jgross@suse.com>
References: <20230223093243.1180-1-jgross@suse.com>
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

The mtrr_value[] array is a static variable, which is used only in a
few configurations. Consuming 6kB is ridiculous for this case,
especially as the array doesn't need to be that large and it can easily
be allocated dynamically.

Signed-off-by: Juergen Gross <jgross@suse.com>
---
 arch/x86/kernel/cpu/mtrr/mtrr.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/mtrr/mtrr.c b/arch/x86/kernel/cpu/mtrr/mtrr.c
index 0c83990501f5..50cd2287b6e1 100644
--- a/arch/x86/kernel/cpu/mtrr/mtrr.c
+++ b/arch/x86/kernel/cpu/mtrr/mtrr.c
@@ -581,7 +581,7 @@ struct mtrr_value {
 	unsigned long	lsize;
 };
 
-static struct mtrr_value mtrr_value[MTRR_MAX_VAR_RANGES];
+static struct mtrr_value *mtrr_value;
 
 static int mtrr_save(void)
 {
@@ -750,6 +750,7 @@ static int __init mtrr_init_finialize(void)
 	 * TBD: is there any system with such CPU which supports
 	 * suspend/resume? If no, we should remove the code.
 	 */
+	mtrr_value = kcalloc(num_var_ranges, sizeof(*mtrr_value), GFP_KERNEL);
 	register_syscore_ops(&mtrr_syscore_ops);
 
 	return 0;
-- 
2.35.3

