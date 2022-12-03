Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E4666413EB
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Dec 2022 04:05:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235182AbiLCDFw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 22:05:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230483AbiLCDFp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 22:05:45 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75EE4F4EA3
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 19:05:44 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id b11so6586248pjp.2
        for <linux-kernel@vger.kernel.org>; Fri, 02 Dec 2022 19:05:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=to:from:cc:content-transfer-encoding:mime-version:references
         :in-reply-to:message-id:date:subject:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oUHGCrN2/GzmAYwHPUyKBA8Ge6xsvUhA3e+Vb+bqY68=;
        b=GTPXNM4I8XSeRWKFJbfehEVG870eOYMF/pKY9yMWeVjzuXAmyGPMV5Nuhgkd2Rpezc
         s+BSs8uV7IDAeaosxWjvuIEHbnwRyildLgIAk88UrLwNCF86OOw+gvsvp87gvdO7j5yY
         khg7Alr0W4R4/KHofpJ9D+lLwLem7Qb0wpi6ArvXA+llBKDEm0aE2tH//UDUW/zvNNNy
         gfVSZqmFmW+aoOXgq4s35qIFSAZ9WmYlvLQAEJEUCLULeQimBikv4W8YGE42LNgyHFBS
         veDXzJC3LeHh7Nnv4F5UhC6Q9SyzW2T+bBN93Ioth3DJNcJNlGBAnbsRy+dlZx3PTjOZ
         6m8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:cc:content-transfer-encoding:mime-version:references
         :in-reply-to:message-id:date:subject:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oUHGCrN2/GzmAYwHPUyKBA8Ge6xsvUhA3e+Vb+bqY68=;
        b=bQPq/X5HZ4g1ishzuC9sXBOYLAwhZPSxDmZohAorpM3yYuDLijRJKlOLqzITzyL/ye
         960cC+sptE08o63cWt9SiGs3PQlH2m/AeS1OZeGSAWU9PFUJQ6IAFDmV8GyLdT5l1mhX
         h8K74eW6FB9hLGldw+YqNkiIG4hOuv+clTZgEblLxr/HG3xCJmNOovsPHqZO/8E2Z5n2
         A8m1RJBV6bijz9peBlt6LJNEBtevITpge7y9gcGkVi7V23797QfM2+AlwdzNFuxp9hEI
         7eEXvd4tGsGsvP8cLg8+5fK8BhL5D9NtS5HxT87bybWaIz3Uw6dFYUf1nuidVwheIThc
         WvKg==
X-Gm-Message-State: ANoB5pmTn2rNZ682OSV/NZi6XZNWY+uzZLVmc+jE7pbbzJDt0+PWz3an
        jKVYVBLGTI0vq/9COoRN/LrJwA==
X-Google-Smtp-Source: AA0mqf6uIzMwjns2LD/gQeHWIsS+ZDiU1QORTWoif/bzBJr4V+crCrb3KCajLaMXkOYnYMNn1jPFyA==
X-Received: by 2002:a17:90b:609:b0:219:3ad9:64f5 with SMTP id gb9-20020a17090b060900b002193ad964f5mr29166277pjb.138.1670036743958;
        Fri, 02 Dec 2022 19:05:43 -0800 (PST)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id b2-20020a62a102000000b005745635c5b5sm5713256pff.183.2022.12.02.19.05.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 19:05:43 -0800 (PST)
Subject: [PATCH 2/5] mm: Add VM_FAULT_ARCH_* codes
Date:   Fri,  2 Dec 2022 19:03:53 -0800
Message-Id: <20221203030356.3917-3-palmer@rivosinc.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221203030356.3917-1-palmer@rivosinc.com>
References: <20221203030356.3917-1-palmer@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc:     Palmer Dabbelt <palmer@rivosinc.com>
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
           linux-s390@vger.kernel.org, linux-arm-kernel@lists.infradead.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A handful of architectures (arm, s390, and soon RISC-V) define their
own internal fault codes, so instead dedicate a few standard codes as
being architecture-specific to avoid conflicts.

Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
---
 include/linux/mm_types.h | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 758eb70829cb..df1aa8d58444 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -880,6 +880,11 @@ enum vm_fault_reason {
 	VM_FAULT_NEEDDSYNC      = (__force vm_fault_t)0x0002000,
 	VM_FAULT_COMPLETED      = (__force vm_fault_t)0x0004000,
 	VM_FAULT_HINDEX_MASK    = (__force vm_fault_t)0x00f0000,
+	VM_FAULT_ARCH_0         = (__force vm_fault_t)0x0100000,
+	VM_FAULT_ARCH_1         = (__force vm_fault_t)0x0200000,
+	VM_FAULT_ARCH_2         = (__force vm_fault_t)0x0400000,
+	VM_FAULT_ARCH_3         = (__force vm_fault_t)0x0800000,
+	VM_FAULT_ARCH_4         = (__force vm_fault_t)0x1000000,
 };
 
 /* Encode hstate index for a hwpoisoned large page */
@@ -903,7 +908,12 @@ enum vm_fault_reason {
 	{ VM_FAULT_RETRY,               "RETRY" },	\
 	{ VM_FAULT_FALLBACK,            "FALLBACK" },	\
 	{ VM_FAULT_DONE_COW,            "DONE_COW" },	\
-	{ VM_FAULT_NEEDDSYNC,           "NEEDDSYNC" }
+	{ VM_FAULT_NEEDDSYNC,           "NEEDDSYNC" },  \
+	{ VM_FAULT_ARCH_0,              "ARCH_0" },     \
+	{ VM_FAULT_ARCH_1,              "ARCH_1" },     \
+	{ VM_FAULT_ARCH_2,              "ARCH_2" },     \
+	{ VM_FAULT_ARCH_3,              "ARCH_3" },     \
+	{ VM_FAULT_ARCH_4,              "ARCH_4" },     \
 
 struct vm_special_mapping {
 	const char *name;	/* The name, e.g. "[vdso]". */
-- 
2.38.1

