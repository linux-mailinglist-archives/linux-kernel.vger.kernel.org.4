Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 024AA6DAD22
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 15:10:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231588AbjDGNJ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 09:09:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232213AbjDGNJ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 09:09:57 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2BB35590;
        Fri,  7 Apr 2023 06:09:55 -0700 (PDT)
Date:   Fri, 07 Apr 2023 13:09:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1680872993;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JkVxDgCZzaUHhuVaWEGGlfuqQmfyNAV5VnpdsyyVXF4=;
        b=QhFAC6uWupGXMnLQYOhBBBp30bECDy3o7IgZq7CWdbmrqzkMH3sDcv2eGNNQxUTavq5yFB
        c/DPc0Ak8enL8w0B6sev8g6kq2r0lxQDlgPFhSkzSe3/gzbQApbqmLuxfZGXOTLF14uELN
        ArNbRFHjoTAQ3AmyL0/5tEg4dzOzg8TsOVs6+TFWnfVqiJC/dFkVXiPQ2St4BhXduT+285
        G0XlDtQQUMm/BEmxtZZwarT7/2OUttIARZgKxBsSlqKgCCD3SmJ4Kg6jg3SarLgXiDL+u4
        S2V/F/Up7vH9g00ONrO6dAuC3/YVhp4ANYe2EIcJbVJlTYvCUceuEtAQsPSa9w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1680872993;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JkVxDgCZzaUHhuVaWEGGlfuqQmfyNAV5VnpdsyyVXF4=;
        b=3iaIQXeoUyME4d97qa1Y6BcsvrFyaBEDU2ElgIBjgap2VjSbY+wY2a8BkSdfiuh4RFDq3c
        bsvGqFZAN7XIQrBw==
From:   "tip-bot2 for Uros Bizjak" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/apic] x86/apic: Fix atomic update of offset in
 reserve_eilvt_offset()
Cc:     Uros Bizjak <ubizjak@gmail.com>,
        "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230227160917.107820-1-ubizjak@gmail.com>
References: <20230227160917.107820-1-ubizjak@gmail.com>
MIME-Version: 1.0
Message-ID: <168087299261.404.3541260516013039940.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/apic branch of tip:

Commit-ID:     f96fb2df3eb31ede1b34b0521560967310267750
Gitweb:        https://git.kernel.org/tip/f96fb2df3eb31ede1b34b0521560967310267750
Author:        Uros Bizjak <ubizjak@gmail.com>
AuthorDate:    Mon, 27 Feb 2023 17:09:17 +01:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Fri, 07 Apr 2023 14:34:24 +02:00

x86/apic: Fix atomic update of offset in reserve_eilvt_offset()

The detection of atomic update failure in reserve_eilvt_offset() is
not correct. The value returned by atomic_cmpxchg() should be compared
to the old value from the location to be updated.

If these two are the same, then atomic update succeeded and
"eilvt_offsets[offset]" location is updated to "new" in an atomic way.

Otherwise, the atomic update failed and it should be retried with the
value from "eilvt_offsets[offset]" - exactly what atomic_try_cmpxchg()
does in a correct and more optimal way.

Fixes: a68c439b1966c ("apic, x86: Check if EILVT APIC registers are available (AMD only)")
Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20230227160917.107820-1-ubizjak@gmail.com
---
 arch/x86/kernel/apic/apic.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index 20d9a60..7705571 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -422,10 +422,9 @@ static unsigned int reserve_eilvt_offset(int offset, unsigned int new)
 		if (vector && !eilvt_entry_is_changeable(vector, new))
 			/* may not change if vectors are different */
 			return rsvd;
-		rsvd = atomic_cmpxchg(&eilvt_offsets[offset], rsvd, new);
-	} while (rsvd != new);
+	} while (!atomic_try_cmpxchg(&eilvt_offsets[offset], &rsvd, new));
 
-	rsvd &= ~APIC_EILVT_MASKED;
+	rsvd = new & ~APIC_EILVT_MASKED;
 	if (rsvd && rsvd != vector)
 		pr_info("LVT offset %d assigned for vector 0x%02x\n",
 			offset, rsvd);
