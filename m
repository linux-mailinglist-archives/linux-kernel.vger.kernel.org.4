Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2A656B7832
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 13:58:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230316AbjCMM6X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 08:58:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230111AbjCMM6P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 08:58:15 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D668B455;
        Mon, 13 Mar 2023 05:58:12 -0700 (PDT)
Date:   Mon, 13 Mar 2023 12:58:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1678712290;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aH1/H5EzgBWv6vAtpMFm5z5LgCHFS3c/CqOtnbfEy/A=;
        b=4rBZVdn3BcCbOQDw8wyR5GC0RQbNrdeBzLUgG8Rj58onr6fsq/W4D4l21gr5AlIilDAaU4
        446wLz9AzxYej8v+n4zjC47ZbxIcTlkqQgu0CZ9Llf4yYN/z2KdAyuhzlNveMTFC3Uvc7y
        igzdGOM+PetSARCmGL3/FH5twBLPsZOxIQCSRJhPcfwLXGUeapM7WY+kpB6zDOozs9ontx
        JYqpeHi012IAlfZPGzFcc0iQU5DLzTYcNZsq6MzA0qX+dXORslzm81rRUXbTW3Zg+0COeD
        m3A4SJAXBK8MTaMuZkRuMJp8KLuSxJN0sN3Czj2Qbq3fZfU0G0mtnH0WJ7q/4Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1678712290;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aH1/H5EzgBWv6vAtpMFm5z5LgCHFS3c/CqOtnbfEy/A=;
        b=E42hB6NQnxLBQlvhbq6qvvRH3m3X1M2Vro0MwoFib0Ev6J+9Yq76OD2zdTciLFVfJRW/Dw
        0LpL7zjIgEm8GdBA==
From:   "tip-bot2 for Borislav Petkov (AMD)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] virt/coco/sev-guest: Convert the sw_exit_info_2
 checking to a switch-case
Cc:     "Borislav Petkov (AMD)" <bp@alien8.de>,
        Tom Lendacky <thomas.lendacky@amd.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230307192449.24732-8-bp@alien8.de>
References: <20230307192449.24732-8-bp@alien8.de>
MIME-Version: 1.0
Message-ID: <167871228994.5837.5974944076233094676.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     fa4ae42cc60a7dea30e8f2db444b808d80862345
Gitweb:        https://git.kernel.org/tip/fa4ae42cc60a7dea30e8f2db444b808d80862345
Author:        Borislav Petkov (AMD) <bp@alien8.de>
AuthorDate:    Thu, 16 Feb 2023 10:50:11 +01:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 13 Mar 2023 12:55:34 +01:00

virt/coco/sev-guest: Convert the sw_exit_info_2 checking to a switch-case

snp_issue_guest_request() checks the value returned by the hypervisor in
sw_exit_info_2 and returns a different error depending on it.

Convert those checks into a switch-case to make it more readable when
more error values are going to be checked in the future.

No functional changes.

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
Link: https://lore.kernel.org/r/20230307192449.24732-8-bp@alien8.de
---
 arch/x86/kernel/sev.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index 6a3e142..d67884f 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -2210,15 +2210,21 @@ int snp_issue_guest_request(u64 exit_code, struct snp_req_data *input, unsigned 
 		goto e_put;
 
 	*fw_err = ghcb->save.sw_exit_info_2;
-	if (ghcb->save.sw_exit_info_2) {
+	switch (*fw_err) {
+	case 0:
+		break;
+
+	case SNP_GUEST_REQ_INVALID_LEN:
 		/* Number of expected pages are returned in RBX */
-		if (exit_code == SVM_VMGEXIT_EXT_GUEST_REQUEST &&
-		    ghcb->save.sw_exit_info_2 == SNP_GUEST_REQ_INVALID_LEN) {
+		if (exit_code == SVM_VMGEXIT_EXT_GUEST_REQUEST) {
 			input->data_npages = ghcb_get_rbx(ghcb);
 			ret = -ENOSPC;
-		} else {
-			ret = -EIO;
+			break;
 		}
+		fallthrough;
+	default:
+		ret = -EIO;
+		break;
 	}
 
 e_put:
