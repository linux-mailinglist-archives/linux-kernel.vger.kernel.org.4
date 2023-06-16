Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D593732BE6
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 11:34:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343922AbjFPJep (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 05:34:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344315AbjFPJeX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 05:34:23 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22D972D62;
        Fri, 16 Jun 2023 02:33:51 -0700 (PDT)
Date:   Fri, 16 Jun 2023 09:33:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686907987;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kW1jugq60sJfmx5RfQMRVtnFU9KKTkP8DmbB1EN9IiU=;
        b=edMt7iXvYdR1moI7O2unZMnhyO+0xZhvW4XonRhiwbxWn+R5U6d15OrQG7x/8van3sR1bY
        FKGjOtEs6QDgysAAWKlZLSQADMR2dmq0Ft3sAUPhM9Bk6k1fa9zSNaYGuooNWiNWSUG71a
        7UZlYUwXwobnfBiazECuiQK+ubIGcTOMxi3IJO4HM6S/GhD0P/xBbkbeRIzbwQ8nRyIkql
        POkl1L93LycS4WS4m4lc7ywXiJuNcxZP5RFxKFU2Y5LHl6P+wzBOMf2JndAEPWDPZcYprm
        dhweDRNk/j7fYNUintA9vi8fTLSeXOnXqB38SA0ZniJPjbZRZoAZzK9KuwK1Mw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686907987;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kW1jugq60sJfmx5RfQMRVtnFU9KKTkP8DmbB1EN9IiU=;
        b=ox6jh+jwcFax4dCRiidd4Go72eTEzdSM8jZG/aCyybTqFH5FtUbyCQ9CtW8RwrFr+LJrj2
        6vHLIb9EeCRhbeBQ==
From:   "tip-bot2 for Juergen Gross" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mtrr] x86/xen: Set default memory type for PV guests to WB
Cc:     Juergen Gross <jgross@suse.com>,
        "Borislav Petkov (AMD)" <bp@alien8.de>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230615123959.12298-1-jgross@suse.com>
References: <20230615123959.12298-1-jgross@suse.com>
MIME-Version: 1.0
Message-ID: <168690798706.404.5612585523577062985.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/mtrr branch of tip:

Commit-ID:     30d65d1b19850c9bc8c17dba8ebe9be5e0c17054
Gitweb:        https://git.kernel.org/tip/30d65d1b19850c9bc8c17dba8ebe9be5e0c17054
Author:        Juergen Gross <jgross@suse.com>
AuthorDate:    Thu, 15 Jun 2023 14:39:59 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Fri, 16 Jun 2023 11:22:33 +02:00

x86/xen: Set default memory type for PV guests to WB

When running as an unprivileged PV guest under Xen (not dom0), the
default MTRR memory type should be write-back.

Signed-off-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Link: https://lore.kernel.org/r/20230615123959.12298-1-jgross@suse.com
---
 arch/x86/xen/enlighten_pv.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/xen/enlighten_pv.c b/arch/x86/xen/enlighten_pv.c
index 8732b85..93b6582 100644
--- a/arch/x86/xen/enlighten_pv.c
+++ b/arch/x86/xen/enlighten_pv.c
@@ -187,6 +187,8 @@ static void __init xen_pv_init_platform(void)
 
 	if (xen_initial_domain())
 		xen_set_mtrr_data();
+	else
+		mtrr_overwrite_state(NULL, 0, MTRR_TYPE_WRBACK);
 }
 
 static void __init xen_pv_guest_late_init(void)
