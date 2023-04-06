Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26C4B6DA41E
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 22:56:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237659AbjDFU4h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 16:56:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbjDFU4c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 16:56:32 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F6704ED6;
        Thu,  6 Apr 2023 13:56:31 -0700 (PDT)
Date:   Thu, 06 Apr 2023 20:56:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1680814590;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YjBvEYxvpoeX2vPb3Ms2POZwrN+eVBkKCaru7XNe9yQ=;
        b=omVAmUwnm8OA3akiYZAjbE48QfH+Kda2Li0M1rtO2Hd+Z5Slrsr4ejMRigY4fFlksK2fOg
        +6Q9pfhqi4+mBpsq219Esmok7x7zNKnU3sD1ZoKiSxrpeyrlDuHoB8n+z9cErOtg95t+k2
        A3DxCVPy1Y9q4Da+AmeIZzMY4ZVJF3dXNg8h1Bw0Mr74wl+LBtb/pu+UyUOuYLxTIvFO60
        ldb+G2CRMq4GlTDb378p24lwCMUAS6aTtzD/f629MAnY2e2neW1d63Hi2Sko7PM8C4y1k0
        FZnNUKUE/PV44hDPs6DJm6ZOy0VhWfTAaj1xF1IN3IzUHMgJigSa5Gp+3qnh0w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1680814590;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YjBvEYxvpoeX2vPb3Ms2POZwrN+eVBkKCaru7XNe9yQ=;
        b=S3Esd2nKhGlgqSmT91zLCrJ/rFcFrWmtgD+DLVd8tu5VrJZhPDNCakL2YmjNBYDRueMM96
        eZNDNJwAO3LYpVDQ==
From:   "tip-bot2 for Kirill A. Shutemov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] x86/mm/iommu/sva: Fix error code for LAM enabling
 failure due to SVA
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <CACT4Y+YfqSMsZArhh25TESmG-U4jO5Hjphz87wKSnTiaw2Wrfw@mail.gmail.com>
References: <CACT4Y+YfqSMsZArhh25TESmG-U4jO5Hjphz87wKSnTiaw2Wrfw@mail.gmail.com>
MIME-Version: 1.0
Message-ID: <168081458969.404.10805285525053802154.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/mm branch of tip:

Commit-ID:     fca1fdd2b0a6fcd491ec520afac80bc72b4c811e
Gitweb:        https://git.kernel.org/tip/fca1fdd2b0a6fcd491ec520afac80bc72b4c811e
Author:        Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
AuthorDate:    Mon, 03 Apr 2023 14:10:19 +03:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Thu, 06 Apr 2023 13:44:58 -07:00

x86/mm/iommu/sva: Fix error code for LAM enabling failure due to SVA

Normally, LAM and SVA are mutually exclusive. LAM enabling will fail if
SVA is already in use.

Correct error code for the failure. EINTR is nonsensical there.

Fixes: 23e5d9ec2bab ("x86/mm/iommu/sva: Make LAM and SVA mutually exclusive")
Reported-by: Dmitry Vyukov <dvyukov@google.com>
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Dmitry Vyukov <dvyukov@google.com>
Link: https://lore.kernel.org/all/CACT4Y+YfqSMsZArhh25TESmG-U4jO5Hjphz87wKSnTiaw2Wrfw@mail.gmail.com
Link: https://lore.kernel.org/all/20230403111020.3136-2-kirill.shutemov%40linux.intel.com
---
 arch/x86/kernel/process_64.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index b46924c..bc2ac56 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -758,7 +758,7 @@ static int prctl_enable_tagged_addr(struct mm_struct *mm, unsigned long nr_bits)
 
 	if (mm_valid_pasid(mm) &&
 	    !test_bit(MM_CONTEXT_FORCE_TAGGED_SVA, &mm->context.flags))
-		return -EINTR;
+		return -EINVAL;
 
 	if (mmap_write_lock_killable(mm))
 		return -EINTR;
