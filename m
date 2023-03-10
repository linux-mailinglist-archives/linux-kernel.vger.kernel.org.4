Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91CC36B5255
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 21:55:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231449AbjCJUzY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 15:55:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231440AbjCJUyy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 15:54:54 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BC1B12049D;
        Fri, 10 Mar 2023 12:54:52 -0800 (PST)
Date:   Fri, 10 Mar 2023 20:54:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1678481690;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hpjvksheAlrH1ake/5cWIudL5JtDU23VcsslNVfU99U=;
        b=gwcTdlG9Dcvb/H641BR5ANu+POza/mhUIOEWXQBJD7xchKu7LH72aNu9j2VuasdegiqA70
        w6VBhwax9L076/UFGOjzz44ceVZ99S8ZkCuaLcswfERcdpf30lIy9EOzBDBufZ5O9V0Dbx
        wFuYbid+H9Qsek/Phg7e5IWd7rHm+jlxfu74VIx4pG4W8NK5L4K9Eaq+VzOka8zNAV3/zx
        6FVZI4pUMUSkuC9htxd0q8YTQwqclVzUU9fiudgd0PkUX8tYPYUmO5KLw+SuxN9DfZOboD
        b036gZqiecvEQgtlXd0tBBLdTte3aYF4icuMQBFDs64eRn6a0yZSrseFloSHvw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1678481690;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hpjvksheAlrH1ake/5cWIudL5JtDU23VcsslNVfU99U=;
        b=njWkQCyv7+3grRLSvoiRhzSDNovb2Sq72FDIsX+Gtf+aGbZQkqjKCN5rCUoZWA45tQJZuY
        TG6VQsjLxF6VICAA==
From:   "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] sparc/cpu: Mark cpu_play_dead() __noreturn
Cc:     philmd@linaro.org, Josh Poimboeuf <jpoimboe@kernel.org>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <847fdb53cc7124bb7c94e3e104e443a29be85184.1676358308.git.jpoimboe@kernel.org>
References: <847fdb53cc7124bb7c94e3e104e443a29be85184.1676358308.git.jpoimboe@kernel.org>
MIME-Version: 1.0
Message-ID: <167848168986.5837.529760520352705249.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     b9952d5009440b01dedd793a57abbe6cfe10f995
Gitweb:        https://git.kernel.org/tip/b9952d5009440b01dedd793a57abbe6cfe1=
0f995
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Mon, 13 Feb 2023 23:05:50 -08:00
Committer:     Josh Poimboeuf <jpoimboe@kernel.org>
CommitterDate: Wed, 08 Mar 2023 08:44:25 -08:00

sparc/cpu: Mark cpu_play_dead() __noreturn

cpu_play_dead() doesn't return.  Annotate it as such.  By extension this
also makes arch_cpu_idle_dead() noreturn.

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
Link: https://lore.kernel.org/r/847fdb53cc7124bb7c94e3e104e443a29be85184.1676=
358308.git.jpoimboe@kernel.org
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 arch/sparc/include/asm/smp_64.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sparc/include/asm/smp_64.h b/arch/sparc/include/asm/smp_64.h
index e75783b..505b670 100644
--- a/arch/sparc/include/asm/smp_64.h
+++ b/arch/sparc/include/asm/smp_64.h
@@ -49,7 +49,7 @@ int hard_smp_processor_id(void);
=20
 void smp_fill_in_cpu_possible_map(void);
 void smp_fill_in_sib_core_maps(void);
-void cpu_play_dead(void);
+void __noreturn cpu_play_dead(void);
=20
 void smp_fetch_global_regs(void);
 void smp_fetch_global_pmu(void);
