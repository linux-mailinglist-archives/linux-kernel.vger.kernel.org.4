Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AD05722FB1
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 21:21:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235789AbjFETVJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 15:21:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235649AbjFETU4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 15:20:56 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12143E49
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 12:20:42 -0700 (PDT)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 355H9Nkj016762
        for <linux-kernel@vger.kernel.org>; Mon, 5 Jun 2023 12:20:41 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=Jst2Lp+guze+PlobngIdDpSIritglNJll7WtUVF7Ztc=;
 b=ZzYdNmfzlN68a21AEWXResS+uoM0vqu62MVw4h6fyL4kXafwgTICa/sQxawnsXepf5+t
 jWvu8rwLfL2QXHK6UTOyJ4aq6MBKpWg/vX19NRCjlqQhSWZOR44Lyuy/2k6FIXqnpWyR
 9ST7djVUxLn8rSAwtQQ5yAQt1E37/o9kxr5JFU82X1hv/KbegavThu+zwA9v4Trrcj+k
 bz+nJ9AfxHNZPJ1T5PlzOJx2+EO+Tyoh857OxAM/HB6GlO3yVhXdLeEbJwSK4jG/VP1G
 xAIsdxUaYofBxFJZcac3oJHLIpXcsLFCa2a18NtL54cTTYC6nldIpyasE8HuIDy+iIn1 /A== 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3r1fxsu0ke-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jun 2023 12:20:41 -0700
Received: from twshared4466.29.prn2.facebook.com (2620:10d:c0a8:1b::2d) by
 mail.thefacebook.com (2620:10d:c0a8:83::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 5 Jun 2023 12:20:40 -0700
Received: by devbig863.prn1.facebook.com (Postfix, from userid 2982)
        id 55AC573CC1DC; Mon,  5 Jun 2023 12:20:29 -0700 (PDT)
From:   Tomislav Novak <tnovak@meta.com>
To:     Catalin Marinas <catalin.marinas@arm.com>
CC:     Alexei Starovoitov <ast@kernel.org>, Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Tomislav Novak <tnovak@meta.com>,
        Samuel Gosselin <sgosselin@google.com>
Subject: [PATCH v2] hw_breakpoint: fix single-stepping when using bpf_overflow_handler
Date:   Mon, 5 Jun 2023 12:19:23 -0700
Message-ID: <20230605191923.1219974-1-tnovak@meta.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <ZH40hgYbWc0x+1c3@tnovak-mbp.dhcp.thefacebook.com>
References: <ZH40hgYbWc0x+1c3@tnovak-mbp.dhcp.thefacebook.com>
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: vYfw4KwpKXJgeAb4lP4uMlXCBeQ-VZZk
X-Proofpoint-ORIG-GUID: vYfw4KwpKXJgeAb4lP4uMlXCBeQ-VZZk
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-05_31,2023-06-02_02,2023-05-22_02
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arm platforms use is_default_overflow_handler() to determine if the
hw_breakpoint code should single-step over the breakpoint trigger or
let the custom handler deal with it.

Since bpf_overflow_handler() currently isn't recognized as a default
handler, attaching a BPF program to a PERF_TYPE_BREAKPOINT event causes
it to keep firing (the instruction triggering the data abort exception
is never skipped). For example:

  # bpftrace -e 'watchpoint:0x10000:4:w { print("hit") }' -c ./test
  Attaching 1 probe...
  hit
  hit
  [...]
  ^C

(./test performs a single 4-byte store to 0x10000)

This patch replaces the check with uses_default_overflow_handler(),
which accounts for the bpf_overflow_handler() case by also testing
if one of the perf_event_output functions gets invoked indirectly,
via orig_default_handler.

Signed-off-by: Tomislav Novak <tnovak@meta.com>
Tested-by: Samuel Gosselin <sgosselin@google.com> # arm64
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Acked-by: Alexei Starovoitov <ast@kernel.org>
Link: https://lore.kernel.org/linux-arm-kernel/20220923203644.2731604-1-tno=
vak@fb.com/
---
 arch/arm/kernel/hw_breakpoint.c   |  8 ++++----
 arch/arm64/kernel/hw_breakpoint.c |  4 ++--
 include/linux/perf_event.h        | 22 +++++++++++++++++++---
 3 files changed, 25 insertions(+), 9 deletions(-)

diff --git a/arch/arm/kernel/hw_breakpoint.c b/arch/arm/kernel/hw_breakpoin=
t.c
index 054e9199f30d..dc0fb7a81371 100644
--- a/arch/arm/kernel/hw_breakpoint.c
+++ b/arch/arm/kernel/hw_breakpoint.c
@@ -626,7 +626,7 @@ int hw_breakpoint_arch_parse(struct perf_event *bp,
 	hw->address &=3D ~alignment_mask;
 	hw->ctrl.len <<=3D offset;
=20
-	if (is_default_overflow_handler(bp)) {
+	if (uses_default_overflow_handler(bp)) {
 		/*
 		 * Mismatch breakpoints are required for single-stepping
 		 * breakpoints.
@@ -798,7 +798,7 @@ static void watchpoint_handler(unsigned long addr, unsi=
gned int fsr,
 		 * Otherwise, insert a temporary mismatch breakpoint so that
 		 * we can single-step over the watchpoint trigger.
 		 */
-		if (!is_default_overflow_handler(wp))
+		if (!uses_default_overflow_handler(wp))
 			continue;
 step:
 		enable_single_step(wp, instruction_pointer(regs));
@@ -811,7 +811,7 @@ static void watchpoint_handler(unsigned long addr, unsi=
gned int fsr,
 		info->trigger =3D addr;
 		pr_debug("watchpoint fired: address =3D 0x%x\n", info->trigger);
 		perf_bp_event(wp, regs);
-		if (is_default_overflow_handler(wp))
+		if (uses_default_overflow_handler(wp))
 			enable_single_step(wp, instruction_pointer(regs));
 	}
=20
@@ -886,7 +886,7 @@ static void breakpoint_handler(unsigned long unknown, s=
truct pt_regs *regs)
 			info->trigger =3D addr;
 			pr_debug("breakpoint fired: address =3D 0x%x\n", addr);
 			perf_bp_event(bp, regs);
-			if (is_default_overflow_handler(bp))
+			if (uses_default_overflow_handler(bp))
 				enable_single_step(bp, addr);
 			goto unlock;
 		}
diff --git a/arch/arm64/kernel/hw_breakpoint.c b/arch/arm64/kernel/hw_break=
point.c
index b29a311bb055..9659a9555c63 100644
--- a/arch/arm64/kernel/hw_breakpoint.c
+++ b/arch/arm64/kernel/hw_breakpoint.c
@@ -654,7 +654,7 @@ static int breakpoint_handler(unsigned long unused, uns=
igned long esr,
 		perf_bp_event(bp, regs);
=20
 		/* Do we need to handle the stepping? */
-		if (is_default_overflow_handler(bp))
+		if (uses_default_overflow_handler(bp))
 			step =3D 1;
 unlock:
 		rcu_read_unlock();
@@ -733,7 +733,7 @@ static u64 get_distance_from_watchpoint(unsigned long a=
ddr, u64 val,
 static int watchpoint_report(struct perf_event *wp, unsigned long addr,
 			     struct pt_regs *regs)
 {
-	int step =3D is_default_overflow_handler(wp);
+	int step =3D uses_default_overflow_handler(wp);
 	struct arch_hw_breakpoint *info =3D counter_arch_bp(wp);
=20
 	info->trigger =3D addr;
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index d5628a7b5eaa..079e7e7c6428 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1305,15 +1305,31 @@ extern int perf_event_output(struct perf_event *eve=
nt,
 			     struct pt_regs *regs);
=20
 static inline bool
-is_default_overflow_handler(struct perf_event *event)
+__is_default_overflow_handler(perf_overflow_handler_t overflow_handler)
 {
-	if (likely(event->overflow_handler =3D=3D perf_event_output_forward))
+	if (likely(overflow_handler =3D=3D perf_event_output_forward))
 		return true;
-	if (unlikely(event->overflow_handler =3D=3D perf_event_output_backward))
+	if (unlikely(overflow_handler =3D=3D perf_event_output_backward))
 		return true;
 	return false;
 }
=20
+#define is_default_overflow_handler(event) \
+	__is_default_overflow_handler((event)->overflow_handler)
+
+#ifdef CONFIG_BPF_SYSCALL
+static inline bool uses_default_overflow_handler(struct perf_event *event)
+{
+	if (likely(is_default_overflow_handler(event)))
+		return true;
+
+	return __is_default_overflow_handler(event->orig_overflow_handler);
+}
+#else
+#define uses_default_overflow_handler(event) \
+	is_default_overflow_handler(event)
+#endif
+
 extern void
 perf_event_header__init_id(struct perf_event_header *header,
 			   struct perf_sample_data *data,
--=20
2.34.1

