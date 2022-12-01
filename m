Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FFD263F2D8
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 15:27:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229481AbiLAO1w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 09:27:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229968AbiLAO1u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 09:27:50 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24D9C1F2DE
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 06:26:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669904811;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=+dnLI4LC6eJgJxf7sHC6b0Dpc13wWosQCy3Z8sjl1q8=;
        b=g8FmWw/PUxFl/LezhaPNMTMWKkkzRYh9Lzx9flo4b6wzlQcrLju5uEf4hUnSVEbM7hscj+
        erEgUk4hSZvv6cOStGLglf50rCBtMzo2tCkIirTJAhoL4gbEpPi+G8cvwgpDLQd2Dk6IEv
        fRqyTN958BtMEwp+yls+gwn+veerNSk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-351-D7-L7xyyPcu9OwdViQLV7w-1; Thu, 01 Dec 2022 09:26:49 -0500
X-MC-Unique: D7-L7xyyPcu9OwdViQLV7w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A875A185A7A3;
        Thu,  1 Dec 2022 14:26:48 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (ovpn-192-172.brq.redhat.com [10.40.192.172])
        by smtp.corp.redhat.com (Postfix) with SMTP id D42E4111E3F8;
        Thu,  1 Dec 2022 14:26:46 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Thu,  1 Dec 2022 15:26:47 +0100 (CET)
Date:   Thu, 1 Dec 2022 15:26:44 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Denys Vlasenko <dvlasenk@redhat.com>,
        Seiji Nishikawa <snishika@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] uprobes/x86: allow to probe a "nop" insn with 0x66 prefix
Message-ID: <20221201142644.GA27185@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Denys Vlasenko <dvlasenk@redhat.com>

Intel icc -hotpatch inserts 2-byte "0x66 0x90" NOP at the start of each
function to reserve extra space for hot-patching, and currently it is not
possible to probe these functions because branch_setup_xol_ops() wrongly
nacks NOP with REP prefix.

Fixes: 250bbd12c2fe ("uprobes/x86: Refuse to attach uprobe to "word-sized" branch insns")
Reported-by: Seiji Nishikawa <snishika@redhat.com>
Signed-off-by: Oleg Nesterov <oleg@redhat.com>
---
 arch/x86/kernel/uprobes.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/uprobes.c b/arch/x86/kernel/uprobes.c
index b63cf8f7745e..6c07f6daaa22 100644
--- a/arch/x86/kernel/uprobes.c
+++ b/arch/x86/kernel/uprobes.c
@@ -722,8 +722,9 @@ static int branch_setup_xol_ops(struct arch_uprobe *auprobe, struct insn *insn)
 	switch (opc1) {
 	case 0xeb:	/* jmp 8 */
 	case 0xe9:	/* jmp 32 */
-	case 0x90:	/* prefix* + nop; same as jmp with .offs = 0 */
 		break;
+	case 0x90:	/* prefix* + nop; same as jmp with .offs = 0 */
+		goto setup;
 
 	case 0xe8:	/* call relative */
 		branch_clear_offset(auprobe, insn);
@@ -753,6 +754,7 @@ static int branch_setup_xol_ops(struct arch_uprobe *auprobe, struct insn *insn)
 			return -ENOTSUPP;
 	}
 
+setup:
 	auprobe->branch.opc1 = opc1;
 	auprobe->branch.ilen = insn->length;
 	auprobe->branch.offs = insn->immediate.value;
-- 
2.25.1.362.g51ebf55


