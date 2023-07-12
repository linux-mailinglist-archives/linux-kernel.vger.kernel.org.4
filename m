Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75DA975074A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 13:58:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230054AbjGLL6d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 07:58:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233644AbjGLL6O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 07:58:14 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4D0E1BF2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 04:57:48 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-676f16e0bc4so3416977b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 04:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689163067; x=1691755067;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oRloNku7QBs7+rRFTQTcTft39Fk9qqWwqKwoNHtqY6Y=;
        b=GXfTHOiFHimVzVMyq6dwDFjDSd2l+xRXuVvggA2r16bp1OoUTuadnvDEOCq2pxn9gK
         A+XzxKfJ6raDbyBFXGK1TCC0P2cNgoJtIrV1MEnflPjaYN9WqeOhv1lCQ6rrQ3dlFDaR
         lc67+wPX8acphX6x2hy+BYSXIl5JVoyG+EV8U4g//iNjoJS5GjhK/+Ev2i9z2nW9/5p6
         LJ/SNJ/1pbaar1wsUk7/YqU+YIbcEEaOkJu9xm/UNNrlwMj419ytSIIezE9OjcEswJI2
         Mqsff2yj9v9RSp/nhuz62nZ4dsV8owMiRnFgjR+fEHamOlFKyvv1mlFZMyCXyvk55dkq
         K5hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689163067; x=1691755067;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oRloNku7QBs7+rRFTQTcTft39Fk9qqWwqKwoNHtqY6Y=;
        b=JEJKAU1hq3aEUhhV+2eC133fHOr+Zu0U5VHi+mubXmcXCx7SZmIlHAQWT4GeM7K0tQ
         7QCdjyYKbXKpk89nhbZjSW2U4Uj5lEBspVMJ1FugrzVODnWuub36+KxSAhG1ssoY+xt+
         YKdjUwYB98Sqx8Hz8ceTYZue5CA3IB5KHY3AQs4F0gGdP+J3eAfChiybe6qGKULv4Q6V
         GPRW7WQ23TXAvDFxAeNIETxD4ZC/+dLrmill2g3HxCxwW9UYWzSByBQmiN1NmMzUmIL/
         tc5CnHw7qLEjUcRZQU8iHKgRO5o5d9zGOWDzD2SF/OgqQ+afh1asjiMA+VzfFSk33/In
         wxgQ==
X-Gm-Message-State: ABy/qLayo1gw5dHQdUaLlwSQQb+RVEf33I1wJCXJNpiBIxcAK1FEhXFj
        7K8YqV3PA3uLxNu3bG5P2dg=
X-Google-Smtp-Source: APBJJlEn1w7vlNNZvNj/9mgFOogZbrzCs+YZCTWMxvopFTpsoveDWfKTbwjCosOSn9r5qFc8VSdgyg==
X-Received: by 2002:a05:6a20:138c:b0:126:a5e3:3927 with SMTP id hn12-20020a056a20138c00b00126a5e33927mr12662680pzc.8.1689163067326;
        Wed, 12 Jul 2023 04:57:47 -0700 (PDT)
Received: from localhost.localdomain ([58.240.82.166])
        by smtp.gmail.com with ESMTPSA id ji19-20020a170903325300b001b7cbc5871csm3830336plb.53.2023.07.12.04.57.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 04:57:46 -0700 (PDT)
From:   Song Shuai <suagrfillet@gmail.com>
To:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, alexghiti@rivosinc.com, bjorn@rivosinc.com,
        suagrfillet@gmail.com
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH V2] riscv: correct pt_level name via pgtable_l5/4_enabled
Date:   Wed, 12 Jul 2023 19:57:40 +0800
Message-Id: <20230712115740.943324-1-suagrfillet@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pt_level uses CONFIG_PGTABLE_LEVELS to display page table names.
But if page mode is downgraded from kernel cmdline or restricted by
the hardware in 64BIT, it will give a wrong name.

Like, using no4lvl for sv39, ptdump named the 1G-mapping as "PUD"
that should be "PGD":

0xffffffd840000000-0xffffffd900000000    0x00000000c0000000         3G PUD     D A G . . W R V

So select "P4D/PUD" or "PGD" via pgtable_l5/4_enabled to correct it.

Fixes: e8a62cc26ddf ("riscv: Implement sv48 support")
Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Signed-off-by: Song Shuai <suagrfillet@gmail.com>
---
Changes since V1:
https://lore.kernel.org/linux-riscv/20230711105202.842408-1-suagrfillet@gmail.com/
- remove the reduntant #ifdef
- correct the Fixes tag and add Reviewed-by from Alex
---
 arch/riscv/mm/ptdump.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/riscv/mm/ptdump.c b/arch/riscv/mm/ptdump.c
index 20a9f991a6d7..e9090b38f811 100644
--- a/arch/riscv/mm/ptdump.c
+++ b/arch/riscv/mm/ptdump.c
@@ -384,6 +384,9 @@ static int __init ptdump_init(void)
 
 	kernel_ptd_info.base_addr = KERN_VIRT_START;
 
+	pg_level[1].name = pgtable_l5_enabled ? "P4D" : "PGD";
+	pg_level[2].name = pgtable_l4_enabled ? "PUD" : "PGD";
+
 	for (i = 0; i < ARRAY_SIZE(pg_level); i++)
 		for (j = 0; j < ARRAY_SIZE(pte_bits); j++)
 			pg_level[i].mask |= pte_bits[j].mask;
-- 
2.20.1

