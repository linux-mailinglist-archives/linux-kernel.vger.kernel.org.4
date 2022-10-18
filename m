Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 247ED6028B3
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 11:48:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbiJRJsL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 05:48:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229843AbiJRJsJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 05:48:09 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85169B0B0C
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 02:48:08 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id y8so13547904pfp.13
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 02:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jgN57VsOmEbW0oef2R7lDWd91i+seWCcSmuwkn3qm8s=;
        b=CXpoZkphNnzb3HdWkvbxbX+OdQIuzsEiDKIALM04EGdA0N5wGbiAERk0wougKpWT7B
         ZYPyDYdtKD65v7HlfNRkRhb9a5c/7Qs5Dt9bFQDUqTyBXIIDG57SRGr+H1igaqm4O35U
         nkXYGwJLT5JP7o0fjJn1V1eRGDGTnjs3Co0Ydp+Fe87uScw4Z43sLrfd6OoHFaXaYeKd
         KQ5oa6fXbGltBKCDCreI3T9P7zeZPvoeBW4dYGcN/qKG9JDmkgFuS5BqQLuA72jt53z9
         B3UwHk7OSxxM9gCqhwzpCNhupg5xGuNqWt1fxhcQef3jC2qtTqJOtZAhfPjoJjBr0TaL
         bOtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jgN57VsOmEbW0oef2R7lDWd91i+seWCcSmuwkn3qm8s=;
        b=wk6UVAk3l3c1xln1Gtef6MdK/0hhk742SwOvBsaqaLLiwMAi9SakP+xXi0W0Vu8IWR
         NdZxSZaIL07dVorU8cUIcX3xbq1/1ic+6hUJ24OW/ORE8byMW93IEnv/kJ/sjREtxa8e
         kLQiDe7KBVOJnaDfofAI6KKdkXLVKEDiIpD7Cx6S/y2xavt0Swd4z6hj4Vyiv0bEHJ2U
         pxPR5dyw0ev1ME2MCDuS7Bx/taPO3h+YG4yEeZI1ZF+3XXv3eZozVtd5F8naxDpj3HhS
         OZDoYxjgLjVbw+toBU9vMrsU8pmFpiNtDu+W+PgWS0SaZs8ZJZCwX1jPfOd4uQsvMcST
         LtMQ==
X-Gm-Message-State: ACrzQf3lydtgZbMKJnH0rTgpAVmOedVnDEvXvyYjdSaHDiM0q/Lj+4mD
        gg4FmGkdUDEdyJPASD3itKM=
X-Google-Smtp-Source: AMsMyM7YrZlETnFnw/Z85QePmZIRib8ilbCH1b/A+iimOLBUdYKd0zLRQzbpBTayU56qlrjADefY6A==
X-Received: by 2002:a63:8549:0:b0:461:3995:60d1 with SMTP id u70-20020a638549000000b00461399560d1mr1931790pgd.105.1666086488060;
        Tue, 18 Oct 2022 02:48:08 -0700 (PDT)
Received: from localhost.localdomain ([43.132.141.4])
        by smtp.gmail.com with ESMTPSA id q19-20020aa79613000000b005635477c42dsm8775730pfg.133.2022.10.18.02.48.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 02:48:07 -0700 (PDT)
From:   zys.zljxml@gmail.com
To:     chenhuacai@kernel.org
Cc:     kernel@xen0n.name, oleg@redhat.com, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org, chenhuacai@loongson.cn,
        lixuefeng@loongson.cn, yangtiezhu@loongson.cn,
        Yushan Zhou <katrinzhou@tencent.com>
Subject: [PATCH] LoongArch: use flexible-array member instead of zero-length array
Date:   Tue, 18 Oct 2022 17:47:42 +0800
Message-Id: <20221018094742.324576-1-zys.zljxml@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yushan Zhou <katrinzhou@tencent.com>

Eliminate the following coccicheck warning:
./arch/loongarch/include/asm/ptrace.h:32:15-21: WARNING use flexible-array member instead

Signed-off-by: Yushan Zhou <katrinzhou@tencent.com>
---
 arch/loongarch/include/asm/ptrace.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/loongarch/include/asm/ptrace.h b/arch/loongarch/include/asm/ptrace.h
index 17838c6b7ccd..7437b9366c3b 100644
--- a/arch/loongarch/include/asm/ptrace.h
+++ b/arch/loongarch/include/asm/ptrace.h
@@ -29,7 +29,7 @@ struct pt_regs {
 	unsigned long csr_euen;
 	unsigned long csr_ecfg;
 	unsigned long csr_estat;
-	unsigned long __last[0];
+	unsigned long __last[];
 } __aligned(8);
 
 static inline int regs_irqs_disabled(struct pt_regs *regs)
-- 
2.27.0

