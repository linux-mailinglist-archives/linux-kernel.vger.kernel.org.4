Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2804474EC01
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 12:52:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231308AbjGKKwL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 06:52:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230200AbjGKKwJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 06:52:09 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 325C0E69
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 03:52:08 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id e9e14a558f8ab-34570ed4cb8so21035415ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 03:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689072727; x=1691664727;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2lUqyNFR/3dbpsLATQPRyo4SUfiIO9bHmuUGRrxMZ08=;
        b=lAtnbdoFrngPAW5pUeXeJEeAvltQ++NgRMGvvUHaIp+rkJH2muolPGXKrMLNjH3cWf
         tDfDjf4rpr6uJUZd8QRB1Q1jMTFsQ26a9ehpmiXESXGgKl96LdereHIl1nIcHIg2PzuL
         jrG4ihC/baeZoNyCpS+aVcMxFSAuY1fKCKi5XGx6ZxjHl4djODDc7hmvytVLyz9MN9An
         Aeo90RvRF/IUdnQSNuVmlKyqjdIR3a3EZtS+AZPy+Cg0ajBbIMvN8Sv/4btQ4fqwNfmM
         4pncVSlwd74vz3B7B9E1tgK6D1D41ifUSnQYV9LmKyWJeg5iFIBpIdG+oUVFIXLtwdvl
         txng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689072727; x=1691664727;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2lUqyNFR/3dbpsLATQPRyo4SUfiIO9bHmuUGRrxMZ08=;
        b=HtDsErIqq/Ht0XDagXh0ncgQAR9INLdbb39HUgvQVAewnEjbQi8wnk+7j7WUwO5WIC
         odY2L1gaVR6kkhjllD9Pm+9YCOL5GgIeQxUZesfyrTHNG6TkSu+05DNQGvpo/Bg3Rhqs
         hM0a2xaLlUcOwTxaavzNRRT02VNJ2h6TFr/ZKxnI4jF+TyJmru+piJ/K3ATBPGXjnopC
         zDRPqz3InUT79JJYZ1Zz8tB6k0kIibsopyPYGVOEbfw2uOO/2xwUBk4IFfYVYVlha/5W
         7kiXck+W+Gqn1Ch5oaSNcFg6KzTwWAzRS/c2Nfy5cDQVgSO9h9GeIIEMQVVZTPvVJ/18
         ATbw==
X-Gm-Message-State: ABy/qLbPFLAwgoOmwhoIEqt/awqToMML33AuWpJo8Dy4OUZXm2+ntRW0
        94XdR/HidVYHnpKdHsN3t1w=
X-Google-Smtp-Source: APBJJlHnWcPq3rZ0s3CNgbTFqH3PLXbC9OQqyCNcDrjgDVv+oE384KHWjDyRjzBdB7UYG8wxUwVlyw==
X-Received: by 2002:a92:c987:0:b0:346:6afb:c9f5 with SMTP id y7-20020a92c987000000b003466afbc9f5mr3093263iln.1.1689072727475;
        Tue, 11 Jul 2023 03:52:07 -0700 (PDT)
Received: from localhost.localdomain ([58.240.82.166])
        by smtp.gmail.com with ESMTPSA id z12-20020aa785cc000000b0064cca73d911sm1422601pfn.103.2023.07.11.03.52.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 03:52:07 -0700 (PDT)
From:   Song Shuai <suagrfillet@gmail.com>
To:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, alexghiti@rivosinc.com, bjorn@rivosinc.com,
        suagrfillet@gmail.com
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] riscv: correct pt_level name via pgtable_l5/4_enabled
Date:   Tue, 11 Jul 2023 18:52:02 +0800
Message-Id: <20230711105202.842408-1-suagrfillet@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pt_level uses CONFIG_PGTABLE_LEVELS to display page table names.
But if downgrading page mode from kernel cmdline in 64BIT, it will
give a wrong name.

Like, using no4lvl for sv39, ptdump named the 1G-mapping as "PUD"
that should be "PGD":

0xffffffd840000000-0xffffffd900000000    0x00000000c0000000         3G PUD     D A G . . W R V

So select "P4D/PUD" or "PGD" via pgtable_l5/4_enabled to correct it.

Fixes: 26e7aacb83df ("riscv: Allow to downgrade paging mode from the command line")
Signed-off-by: Song Shuai <suagrfillet@gmail.com>
---
 arch/riscv/mm/ptdump.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/riscv/mm/ptdump.c b/arch/riscv/mm/ptdump.c
index 20a9f991a6d7..cfdd327981ee 100644
--- a/arch/riscv/mm/ptdump.c
+++ b/arch/riscv/mm/ptdump.c
@@ -384,6 +384,11 @@ static int __init ptdump_init(void)
 
 	kernel_ptd_info.base_addr = KERN_VIRT_START;
 
+#ifdef CONFIG_64BIT
+	pg_level[1].name = pgtable_l5_enabled ? "P4D" : "PGD";
+	pg_level[2].name = pgtable_l4_enabled ? "PUD" : "PGD";
+#endif
+
 	for (i = 0; i < ARRAY_SIZE(pg_level); i++)
 		for (j = 0; j < ARRAY_SIZE(pte_bits); j++)
 			pg_level[i].mask |= pte_bits[j].mask;
-- 
2.20.1

