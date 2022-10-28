Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DEBD610AA5
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 08:46:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229531AbiJ1GqC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 02:46:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230077AbiJ1Gpb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 02:45:31 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 339B21BC151;
        Thu, 27 Oct 2022 23:42:48 -0700 (PDT)
Date:   Fri, 28 Oct 2022 06:42:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1666939365;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=UvfhjA69pBBZjPlt4RruyUpepFtfZDFG/fA4o0CWAOA=;
        b=CFOShDiJUrXieRH+UzopdkA+Diub8JTYqtsuR9HLD7EB4pwfSje5Ii2eyaTolCII3BKsGR
        nmGA1ywD/v7wkfePKu/WJgmA4gVC3bfbt/x1pnOKKCcWlOwVJ6/3GlJrd6wotnvECNUbvq
        m6u7/IB2pVq9ZMLdDhkAidYFvnvE64GG47iCYl1r1AohqXI5TmQC225Qx3gJoy9cLmc5Io
        Mrfdhnlrxhes/NKJ4+fTthWXeRqnwx3Qo/LL3gTgJpvqnWG/8KWU0iKWWpogcGkBTQUINH
        Z7slNxMJiujhOglc0zjaVafB6dHmx44qsh7hlFDTFrMKlY3Gm5D7bhxBXwZ6uA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1666939365;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=UvfhjA69pBBZjPlt4RruyUpepFtfZDFG/fA4o0CWAOA=;
        b=XDZ0fZcenr1/LUPpZqV7jF1Uba1IffSACLiJ6Vv2LTWjkApen1xpXmQCRCsqJWHCp0l89+
        nHSanZ9Vs2l367DQ==
From:   "tip-bot2 for Dan Carpenter" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/retpoline: Fix crash printing warning
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <166693936407.29415.9974572427874008565.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     ae25e00ba84073450c07d8ffd2d74f914a027230
Gitweb:        https://git.kernel.org/tip/ae25e00ba84073450c07d8ffd2d74f914a027230
Author:        Dan Carpenter <dan.carpenter@oracle.com>
AuthorDate:    Tue, 25 Oct 2022 18:32:49 +03:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Tue, 25 Oct 2022 12:27:08 -07:00

x86/retpoline: Fix crash printing warning

The first argument of WARN() is a condition, so this will use "addr"
as the format string and possibly crash.

Fixes: 3b6c1747da48 ("x86/retpoline: Add SKL retthunk retpolines")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://lore.kernel.org/all/Y1gBoUZrRK5N%2FlCB@kili/
---
 arch/x86/kernel/alternative.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 19221d7..b4ac4e5 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -418,7 +418,7 @@ clang_jcc:
 		break;
 
 	default:
-		WARN("%pS %px %*ph\n", addr, addr, 6, addr);
+		WARN(1, "%pS %px %*ph\n", addr, addr, 6, addr);
 		return -1;
 	}
 
