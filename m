Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C24D56994AD
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 13:46:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230187AbjBPMqM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 07:46:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230150AbjBPMqL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 07:46:11 -0500
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 266B613521
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 04:46:05 -0800 (PST)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B62261EC0910;
        Thu, 16 Feb 2023 13:46:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1676551563;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZODk5R/YkDJAlRJf+qFXMqR68KhosC42e65SUklu92Q=;
        b=NC8MltrnuncGKOb7lmsVC76RwpprJWS93SaybI/2EV1cuoBOAOgPrUFQpmun9oE96bkAZH
        vfnc5/hnp9T8KsVFVwXeZXm26lJgNywGJoujaB1iI8cKtDpLFkZwtYitbV6MFeW6iw/kCj
        O/ftLpFQnOLNg9llkEtFp6A28FCIOss=
From:   Borislav Petkov <bp@alien8.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Dionna Glaze <dionnaglaze@google.com>,
        Joerg Roedel <jroedel@suse.de>,
        Michael Roth <michael.roth@amd.com>,
        Nikunj A Dadhania <nikunj@amd.com>,
        Peter Gonda <pgonda@google.com>,
        Tom Lendacky <Thomas.Lendacky@amd.com>,
        linux-coco@lists.linux.dev, x86@kernel.org
Subject: [PATCH 07/11] virt/coco/sev-guest: Convert the sw_exit_info_2 checking to a switch-case
Date:   Thu, 16 Feb 2023 13:45:58 +0100
Message-Id: <20230216124602.26849-2-bp@alien8.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230216124602.26849-1-bp@alien8.de>
References: <20230216124120.26578-1-bp@alien8.de>
 <20230216124602.26849-1-bp@alien8.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Borislav Petkov (AMD)" <bp@alien8.de>

snp_issue_guest_request() checks the value returned by the hypervisor in
sw_exit_info_2 and returns a different error depending on it.

Convert those checks into a switch-case to make it more readable when
more error values are going to be checked in the future.

No functional changes.

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
---
 arch/x86/kernel/sev.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index ee53cab887fa..d6655fccefc8 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -2209,17 +2209,23 @@ int snp_issue_guest_request(u64 exit_code, struct snp_req_data *input, unsigned
 	if (ret)
 		goto e_put;
 
-	if (ghcb->save.sw_exit_info_2) {
+	*fw_err = ghcb->save.sw_exit_info_2;
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
 
-		*fw_err = ghcb->save.sw_exit_info_2;
+	default:
+		ret = -EIO;
+		break;
 	}
 
 e_put:
-- 
2.35.1

