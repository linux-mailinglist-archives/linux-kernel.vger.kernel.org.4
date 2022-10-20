Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A57D060642A
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 17:19:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230180AbiJTPT2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 11:19:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230334AbiJTPTJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 11:19:09 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E33841645E1;
        Thu, 20 Oct 2022 08:18:57 -0700 (PDT)
Date:   Thu, 20 Oct 2022 15:17:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1666279077;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=REkz0EKzIlK/GALKmbUCwMeQcbqiQnCP6nUbBx72gis=;
        b=ddrV6sMyoOyEfkOBsfSBIFEEW+irM+0MWqxRVl/hSpeuG7qj3rGfcTitxWn2eBFO3ZCzyW
        3epoX4WHLbp46KuQPkFU3kXADZc9XGtCff+cUGSpxo/PF7CehMj2CNW6efvAlKZZsnEPO5
        9knirdUFgl2XuQO5q3+a/qXc1BcNGj96ry1sOhuYmbf/7SE6dAH7/Iz84YlSlZAjJ0qZtD
        JF5W4kg23BtPKVlb1r36RKj7GPSIbo5YIcNrGUn1V//vq8DpLIks9iixs7yC6jWejh65GK
        cIGzuaKhPgRtSAwepdrb5mh7UDHu7mo0WD9lHf9QIdmtlXhsjMXVtO+pWJKoSg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1666279077;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=REkz0EKzIlK/GALKmbUCwMeQcbqiQnCP6nUbBx72gis=;
        b=6Kho1Y4qLaAGey8k23908DZQ6eqEf8caaow+njiPyid1sncx0252bNcA5Jb07wHRgQP7us
        7TYEZ2aCu+8fZuAw==
From:   "tip-bot2 for Maxim Levitsky" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] perf/x86/intel/lbr: Use setup_clear_cpu_cap()
 instead of clear_cpu_cap()
Cc:     Maxim Levitsky <mlevitsk@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Kan Liang <kan.liang@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220718141123.136106-2-mlevitsk@redhat.com>
References: <20220718141123.136106-2-mlevitsk@redhat.com>
MIME-Version: 1.0
Message-ID: <166627907623.401.782680400478591314.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     b329f5ddc9ce4b622d9c7aaf5c6df4de52caf91a
Gitweb:        https://git.kernel.org/tip/b329f5ddc9ce4b622d9c7aaf5c6df4de52caf91a
Author:        Maxim Levitsky <mlevitsk@redhat.com>
AuthorDate:    Mon, 18 Jul 2022 17:11:19 +03:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 20 Oct 2022 17:10:28 +02:00

perf/x86/intel/lbr: Use setup_clear_cpu_cap() instead of clear_cpu_cap()

clear_cpu_cap(&boot_cpu_data) is very similar to setup_clear_cpu_cap()
except that the latter also sets a bit in 'cpu_caps_cleared' which
later clears the same cap in secondary cpus, which is likely what is
meant here.

Fixes: 47125db27e47 ("perf/x86/intel/lbr: Support Architectural LBR")
Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
Link: https://lkml.kernel.org/r/20220718141123.136106-2-mlevitsk@redhat.com
---
 arch/x86/events/intel/lbr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
index 4fce1a4..8259d72 100644
--- a/arch/x86/events/intel/lbr.c
+++ b/arch/x86/events/intel/lbr.c
@@ -1596,7 +1596,7 @@ void __init intel_pmu_arch_lbr_init(void)
 	return;
 
 clear_arch_lbr:
-	clear_cpu_cap(&boot_cpu_data, X86_FEATURE_ARCH_LBR);
+	setup_clear_cpu_cap(X86_FEATURE_ARCH_LBR);
 }
 
 /**
