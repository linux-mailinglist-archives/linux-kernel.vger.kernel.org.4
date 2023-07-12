Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8D9A74FD95
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 05:16:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231858AbjGLDQb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 23:16:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231608AbjGLDQ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 23:16:26 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 57E6110DD
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 20:16:24 -0700 (PDT)
Received: from loongson.cn (unknown [10.2.9.158])
        by gateway (Coremail) with SMTP id _____8CxLOsGG65kfscDAA--.5572S3;
        Wed, 12 Jul 2023 11:16:22 +0800 (CST)
Received: from kvm-1-158.loongson.cn (unknown [10.2.9.158])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8CxWM0GG65kA7cpAA--.53483S3;
        Wed, 12 Jul 2023 11:16:22 +0800 (CST)
From:   Bibo Mao <maobibo@loongson.cn>
To:     Huacai Chen <chenhuacai@kernel.org>,
        Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, WANG Xuerui <kernel@xen0n.name>
Subject: [PATCH 1/3] mm/percpu: Remove some local variables in pcpu_populate_pte
Date:   Wed, 12 Jul 2023 11:16:20 +0800
Message-Id: <20230712031622.1888321-2-maobibo@loongson.cn>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20230712031622.1888321-1-maobibo@loongson.cn>
References: <20230712031622.1888321-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8CxWM0GG65kA7cpAA--.53483S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7uFWrCr1UWw4fXrWUJr13trc_yoW8Xr4Up3
        93W3s29r4fJwnrGan3Gas8Wr17Xw4rta4Fk3srXr1rZ3W3ZrnxWr4jyw42ga42yFWfZF1x
        Jr45Ja9rAan0v3cCm3ZEXasCq-sJn29KB7ZKAUJUUUUx529EdanIXcx71UUUUU7KY7ZEXa
        sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
        0xBIdaVrnRJUUUBFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
        IYs7xG6rWj6s0DM7CIcVAFz4kK6r126r13M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
        e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
        0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
        6r4j6r4UJwAaw2AFwI0_JF0_Jw1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0c
        Ia020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jw0_
        WrylYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwI
        xGrwCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWU
        JVW8JwCFI7km07C267AKxVWUAVWUtwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4
        vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IY
        x2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26c
        xKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAF
        wI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jr6p9UUUUU=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In function pcpu_populate_pte there are already variable defined,
it can be reused for later use, here remove duplicated local
variables.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 mm/percpu.c | 24 +++++++++---------------
 1 file changed, 9 insertions(+), 15 deletions(-)

diff --git a/mm/percpu.c b/mm/percpu.c
index 28e07ede46f6..85e3f9b2a61f 100644
--- a/mm/percpu.c
+++ b/mm/percpu.c
@@ -3189,32 +3189,26 @@ void __init __weak pcpu_populate_pte(unsigned long addr)
 	pmd_t *pmd;
 
 	if (pgd_none(*pgd)) {
-		p4d_t *new;
-
-		new = memblock_alloc(P4D_TABLE_SIZE, P4D_TABLE_SIZE);
-		if (!new)
+		p4d = memblock_alloc(P4D_TABLE_SIZE, P4D_TABLE_SIZE);
+		if (!p4d)
 			goto err_alloc;
-		pgd_populate(&init_mm, pgd, new);
+		pgd_populate(&init_mm, pgd, p4d);
 	}
 
 	p4d = p4d_offset(pgd, addr);
 	if (p4d_none(*p4d)) {
-		pud_t *new;
-
-		new = memblock_alloc(PUD_TABLE_SIZE, PUD_TABLE_SIZE);
-		if (!new)
+		pud = memblock_alloc(PUD_TABLE_SIZE, PUD_TABLE_SIZE);
+		if (!pud)
 			goto err_alloc;
-		p4d_populate(&init_mm, p4d, new);
+		p4d_populate(&init_mm, p4d, pud);
 	}
 
 	pud = pud_offset(p4d, addr);
 	if (pud_none(*pud)) {
-		pmd_t *new;
-
-		new = memblock_alloc(PMD_TABLE_SIZE, PMD_TABLE_SIZE);
-		if (!new)
+		pmd = memblock_alloc(PMD_TABLE_SIZE, PMD_TABLE_SIZE);
+		if (!pmd)
 			goto err_alloc;
-		pud_populate(&init_mm, pud, new);
+		pud_populate(&init_mm, pud, pmd);
 	}
 
 	pmd = pmd_offset(pud, addr);
-- 
2.27.0

