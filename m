Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D8CF68D098
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 08:29:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230242AbjBGH3c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 02:29:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230215AbjBGH3Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 02:29:25 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9622036086
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 23:29:23 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 3CC2633AF4;
        Tue,  7 Feb 2023 07:29:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1675754962; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=t8iNxepBulbWBgnAjdjtTKND+wFOVAwDCXZSevLudto=;
        b=Rq9h6mL+GTP/xnNyQnFdDsiIX+OQFnbl36tCwnJMdbwQvxr1N0kws9YN6BmImuHXn1JItC
        IIx/ndq4Q045WM2t2P6/NFeSRfczbTnJ7931JE1mX4jojk+bgyXvfiN5SHSH0NLWq0irZQ
        c21gnfbm/eoEHlaEEYJmvju92DYm1h4=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DBBD113A8C;
        Tue,  7 Feb 2023 07:29:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id tUFjNNH94WO+UQAAMHmgww
        (envelope-from <jgross@suse.com>); Tue, 07 Feb 2023 07:29:21 +0000
From:   Juergen Gross <jgross@suse.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     lists@nerdbynature.de, mikelley@microsoft.com,
        torvalds@linux-foundation.org, Juergen Gross <jgross@suse.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH 3/6] x86/mtrr: revert commit 90b926e68f50
Date:   Tue,  7 Feb 2023 08:28:59 +0100
Message-Id: <20230207072902.5528-4-jgross@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230207072902.5528-1-jgross@suse.com>
References: <20230207072902.5528-1-jgross@suse.com>
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

Commit 90b926e68f50 ("x86/pat: Fix pat_x_mtrr_type() for MTRR disabled
case") has introduced a regression with Xen.

Revert the patch.

Signed-off-by: Juergen Gross <jgross@suse.com>
---
 arch/x86/mm/pat/memtype.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/x86/mm/pat/memtype.c b/arch/x86/mm/pat/memtype.c
index 18f612b43763..2c6d95f95b49 100644
--- a/arch/x86/mm/pat/memtype.c
+++ b/arch/x86/mm/pat/memtype.c
@@ -387,8 +387,7 @@ static unsigned long pat_x_mtrr_type(u64 start, u64 end,
 		u8 mtrr_type, uniform;
 
 		mtrr_type = mtrr_type_lookup(start, end, &uniform);
-		if (mtrr_type != MTRR_TYPE_WRBACK &&
-		    mtrr_type != MTRR_TYPE_INVALID)
+		if (mtrr_type != MTRR_TYPE_WRBACK)
 			return _PAGE_CACHE_MODE_UC_MINUS;
 
 		return _PAGE_CACHE_MODE_WB;
-- 
2.35.3

