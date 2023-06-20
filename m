Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF798736D33
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 15:23:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232923AbjFTNXg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 09:23:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232912AbjFTNXV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 09:23:21 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 320A82122;
        Tue, 20 Jun 2023 06:22:34 -0700 (PDT)
Received: from loongson.cn (unknown [117.81.87.34])
        by gateway (Coremail) with SMTP id _____8Ax3erKp5Fk7TcHAA--.14748S3;
        Tue, 20 Jun 2023 21:21:14 +0800 (CST)
Received: from localhost.localdomain (unknown [117.81.87.34])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8BxB93Dp5FkawgAAA--.139S2;
        Tue, 20 Jun 2023 21:21:12 +0800 (CST)
From:   WANG Rui <wangrui@loongson.cn>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Huacai Chen <chenhuacai@loongson.cn>
Cc:     loongarch@lists.linux.dev, Tiezhu Yang <yangtiezhu@loongson.cn>,
        WANG Xuerui <kernel@xen0n.name>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        loongson-kernel@lists.loongnix.cn, WANG Rui <wangrui@loongson.cn>
Subject: [PATCH] perf annotate: Fix instruction association and parsing for LoongArch
Date:   Tue, 20 Jun 2023 21:20:25 +0800
Message-ID: <20230620132025.105563-1-wangrui@loongson.cn>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8BxB93Dp5FkawgAAA--.139S2
X-CM-SenderInfo: pzdqw2txl6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxtFyxAw45JF45Cw4DAry8CrX_yoW3XF1rpa
        y7Z345Jr4rXrWru3ZrtF4j9w13Grs3GrWqqayrtasaya1Iqryxt3W8JFWayFyrG345Wr4j
        qFnYvr1jkF4UJabCm3ZEXasCq-sJn29KB7ZKAUJUUUUf529EdanIXcx71UUUUU7KY7ZEXa
        sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
        0xBIdaVrnRJUUUBFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
        IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
        e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
        0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v2
        6F4UJVW0owAaw2AFwI0_JF0_Jw1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0c
        Ia020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JF0_
        Jw1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwI
        xGrwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWU
        JVW8JwCFI7km07C267AKxVWUAVWUtwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4
        vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IY
        x2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26c
        xKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAF
        wI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07j0mhrUUUUU=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the perf annotate view for LoongArch, there is no arrowed line
pointing to the target from the branch instruction. This issue is
caused by incorrect instruction association and parsing.

$ perf record alloc-6276705c94ad1398 # rust benchmark
$ perf report

  0.28 │       ori        $a1, $zero, 0x63
       │       move       $a2, $zero
 10.55 │       addi.d     $a3, $a2, 1(0x1)
       │       sltu       $a4, $a3, $s7
  9.53 │       masknez    $a4, $s7, $a4
       │       sub.d      $a3, $a3, $a4
 12.12 │       st.d       $a1, $fp, 24(0x18)
       │       st.d       $a3, $fp, 16(0x10)
 16.29 │       slli.d     $a2, $a2, 0x2
       │       ldx.w      $a2, $s8, $a2
 12.77 │       st.w       $a2, $sp, 724(0x2d4)
       │       st.w       $s0, $sp, 720(0x2d0)
  7.03 │       addi.d     $a2, $sp, 720(0x2d0)
       │       addi.d     $a1, $a1, -1(0xfff)
 12.03 │       move       $a2, $a3
       │     → bne        $a1, $s3, -52(0x3ffcc)  # 82ce8 <test::bench::Bencher::iter+0x3f4>
  2.50 │       addi.d     $a0, $a0, 1(0x1)

This patch fixes instruction association issues, such as associating
branch instructions with jump_ops instead of call_ops, and corrects
false instruction matches. It also implements branch instruction parsing
specifically for LoongArch. With this patch, we will be able to see the
arrowed line.

  0.79 │3ec:   ori        $a1, $zero, 0x63
       │       move       $a2, $zero
 10.32 │3f4:┌─→addi.d     $a3, $a2, 1(0x1)
       │    │  sltu       $a4, $a3, $s7
 10.44 │    │  masknez    $a4, $s7, $a4
       │    │  sub.d      $a3, $a3, $a4
 14.17 │    │  st.d       $a1, $fp, 24(0x18)
       │    │  st.d       $a3, $fp, 16(0x10)
 13.15 │    │  slli.d     $a2, $a2, 0x2
       │    │  ldx.w      $a2, $s8, $a2
 11.00 │    │  st.w       $a2, $sp, 724(0x2d4)
       │    │  st.w       $s0, $sp, 720(0x2d0)
  8.00 │    │  addi.d     $a2, $sp, 720(0x2d0)
       │    │  addi.d     $a1, $a1, -1(0xfff)
 11.99 │    │  move       $a2, $a3
       │    └──bne        $a1, $s3, 3f4
  3.17 │       addi.d     $a0, $a0, 1(0x1)

Signed-off-by: WANG Rui <wangrui@loongson.cn>
---
 .../arch/loongarch/annotate/instructions.c    | 116 ++++++++++++++++--
 tools/perf/arch/s390/annotate/instructions.c  |   3 -
 tools/perf/util/annotate.c                    |   8 +-
 3 files changed, 109 insertions(+), 18 deletions(-)

diff --git a/tools/perf/arch/loongarch/annotate/instructions.c b/tools/perf/arch/loongarch/annotate/instructions.c
index ab21bf122135..98e19c5366ac 100644
--- a/tools/perf/arch/loongarch/annotate/instructions.c
+++ b/tools/perf/arch/loongarch/annotate/instructions.c
@@ -5,25 +5,115 @@
  * Copyright (C) 2020-2023 Loongson Technology Corporation Limited
  */
 
+static int loongarch_call__parse(struct arch *arch, struct ins_operands *ops, struct map_symbol *ms)
+{
+	char *c, *endptr, *tok, *name;
+	struct map *map = ms->map;
+	struct addr_map_symbol target = {
+		.ms = { .map = map, },
+	};
+
+	c = strchr(ops->raw, '#');
+	if (c++ == NULL)
+		return -1;
+
+	ops->target.addr = strtoull(c, &endptr, 16);
+
+	name = strchr(endptr, '<');
+	name++;
+
+	if (arch->objdump.skip_functions_char &&
+	    strchr(name, arch->objdump.skip_functions_char))
+		return -1;
+
+	tok = strchr(name, '>');
+	if (tok == NULL)
+		return -1;
+
+	*tok = '\0';
+	ops->target.name = strdup(name);
+	*tok = '>';
+
+	if (ops->target.name == NULL)
+		return -1;
+
+	target.addr = map__objdump_2mem(map, ops->target.addr);
+
+	if (maps__find_ams(ms->maps, &target) == 0 &&
+	    map__rip_2objdump(target.ms.map, map__map_ip(target.ms.map, target.addr)) == ops->target.addr)
+		ops->target.sym = target.ms.sym;
+
+	return 0;
+}
+
+static struct ins_ops loongarch_call_ops = {
+	.parse	   = loongarch_call__parse,
+	.scnprintf = call__scnprintf,
+};
+
+static int loongarch_jump__parse(struct arch *arch, struct ins_operands *ops, struct map_symbol *ms)
+{
+	struct map *map = ms->map;
+	struct symbol *sym = ms->sym;
+	struct addr_map_symbol target = {
+		.ms = { .map = map, },
+	};
+	const char *c = strchr(ops->raw, '#');
+	u64 start, end;
+
+	ops->raw_comment = strchr(ops->raw, arch->objdump.comment_char);
+	ops->raw_func_start = strchr(ops->raw, '<');
+
+	if (ops->raw_func_start && c > ops->raw_func_start)
+		c = NULL;
+
+	if (c++ != NULL)
+		ops->target.addr = strtoull(c, NULL, 16);
+	else
+		ops->target.addr = strtoull(ops->raw, NULL, 16);
+
+	target.addr = map__objdump_2mem(map, ops->target.addr);
+	start = map__unmap_ip(map, sym->start);
+	end = map__unmap_ip(map, sym->end);
+
+	ops->target.outside = target.addr < start || target.addr > end;
+
+	if (maps__find_ams(ms->maps, &target) == 0 &&
+	    map__rip_2objdump(target.ms.map, map__map_ip(target.ms.map, target.addr)) == ops->target.addr)
+		ops->target.sym = target.ms.sym;
+
+	if (!ops->target.outside) {
+		ops->target.offset = target.addr - start;
+		ops->target.offset_avail = true;
+	} else {
+		ops->target.offset_avail = false;
+	}
+
+	return 0;
+}
+
+static struct ins_ops loongarch_jump_ops = {
+	.parse	   = loongarch_jump__parse,
+	.scnprintf = jump__scnprintf,
+};
+
 static
 struct ins_ops *loongarch__associate_ins_ops(struct arch *arch, const char *name)
 {
 	struct ins_ops *ops = NULL;
 
-	if (!strncmp(name, "beqz", 4) ||
-	    !strncmp(name, "bnez", 4) ||
-	    !strncmp(name, "beq", 3) ||
-	    !strncmp(name, "bne", 3) ||
-	    !strncmp(name, "blt", 3) ||
-	    !strncmp(name, "bge", 3) ||
-	    !strncmp(name, "bltu", 4) ||
-	    !strncmp(name, "bgeu", 4) ||
-	    !strncmp(name, "bl", 2))
-		ops = &call_ops;
-	else if (!strncmp(name, "jirl", 4))
+	if (!strcmp(name, "bl"))
+		ops = &loongarch_call_ops;
+	else if (!strcmp(name, "jirl"))
 		ops = &ret_ops;
-	else if (name[0] == 'b')
-		ops = &jump_ops;
+	else if (!strcmp(name, "b") ||
+		 !strncmp(name, "beq", 3) ||
+		 !strncmp(name, "bne", 3) ||
+		 !strncmp(name, "blt", 3) ||
+		 !strncmp(name, "bge", 3) ||
+		 !strncmp(name, "bltu", 4) ||
+		 !strncmp(name, "bgeu", 4))
+		ops = &loongarch_jump_ops;
 	else
 		return NULL;
 
diff --git a/tools/perf/arch/s390/annotate/instructions.c b/tools/perf/arch/s390/annotate/instructions.c
index de925b0e35ce..da5aa3e1f04c 100644
--- a/tools/perf/arch/s390/annotate/instructions.c
+++ b/tools/perf/arch/s390/annotate/instructions.c
@@ -45,9 +45,6 @@ static int s390_call__parse(struct arch *arch, struct ins_operands *ops,
 	return 0;
 }
 
-static int call__scnprintf(struct ins *ins, char *bf, size_t size,
-			   struct ins_operands *ops, int max_ins_name);
-
 static struct ins_ops s390_call_ops = {
 	.parse	   = s390_call__parse,
 	.scnprintf = call__scnprintf,
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index cdd1924a4418..ad40adbd8895 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -61,6 +61,10 @@ static regex_t	 file_lineno;
 static struct ins_ops *ins__find(struct arch *arch, const char *name);
 static void ins__sort(struct arch *arch);
 static int disasm_line__parse(char *line, const char **namep, char **rawp);
+static int call__scnprintf(struct ins *ins, char *bf, size_t size,
+			  struct ins_operands *ops, int max_ins_name);
+static int jump__scnprintf(struct ins *ins, char *bf, size_t size,
+			  struct ins_operands *ops, int max_ins_name);
 
 struct arch {
 	const char	*name;
@@ -323,7 +327,7 @@ static struct ins_ops call_ops = {
 
 bool ins__is_call(const struct ins *ins)
 {
-	return ins->ops == &call_ops || ins->ops == &s390_call_ops;
+	return ins->ops == &call_ops || ins->ops == &s390_call_ops || ins->ops == &loongarch_call_ops;
 }
 
 /*
@@ -464,7 +468,7 @@ static struct ins_ops jump_ops = {
 
 bool ins__is_jump(const struct ins *ins)
 {
-	return ins->ops == &jump_ops;
+	return ins->ops == &jump_ops || ins->ops == &loongarch_jump_ops;
 }
 
 static int comment__symbol(char *raw, char *comment, u64 *addrp, char **namep)
-- 
2.41.0

