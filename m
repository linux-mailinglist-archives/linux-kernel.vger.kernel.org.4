Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2828C74DE26
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 21:25:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229801AbjGJTZb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 15:25:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231230AbjGJTZP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 15:25:15 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1C2DE60
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 12:25:00 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-9939fbb7191so968592566b.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 12:25:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689017098; x=1691609098;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z71M3kv4pOhHERmm48IRm9ZZKlLgpwDQJ/Fo9wvNP5c=;
        b=ASZ3K3ti6Bg/EbHuGo8ohRbr1fAme2CHAabDjiV/uN16VxosIlNQ6g9LHfm3xurH/c
         lnEZhyrQ5BpkOGbo0OVMsFbLSGtiKDrFdhS6Ct/trK1XyUBMl1sIPlDvaueYOklhMhBH
         LsVtQTFSqIldpa1nRu8firvs9QmQG5792VyW0EmunqskCC0IpXzSYyeRT0PPVsQJGoxM
         fDsla/SjoRdP5k4jl7hEMhe59+kRMbneOuStHbBmghQORD9WGjdtlwlFWnQ00Cj2jwFa
         DOLb86EDnRYJ+z6nA8mxVcwoLtAeiY1TLcjNh7CVzxtevL1YQ+y9jdX23HC5SvWfanjW
         Hhsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689017098; x=1691609098;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z71M3kv4pOhHERmm48IRm9ZZKlLgpwDQJ/Fo9wvNP5c=;
        b=RlGSFAv7A9oZJaHQH0uyoT3eZKMXAzm4L/dgVBd6aUTYIHXPGCsrY5Nrs+0IiiQLEm
         lP0FQGX0CnjputrsZA1WB6WdQUCaGj7xv0TtxdY/xJi+98KuvQ+rHIrESlC2gWL4CeRF
         CsuYEg8rYbmgVq0wJfO9i+3NspgoEkj0GQgbn9N93aZFxTBDQv6XQ27b5/zMpKwxIro/
         29Z9eVZGzJMPObegj8HHDj+E7WFezNd9yQRGtE+kc4bLmBOwalaWvsqYTsBEIuzVbDnx
         BJALVw/LJGRnd0iDAcdnKcfnou8/lk6JMLSVeMT0A3xadAjIhNFVw0tomnw5uWXYYM4L
         crXg==
X-Gm-Message-State: ABy/qLbeeyM0Ppf1rhic2wQuQ/WOuaEGGeMLuzW1luSDBuQA6XGb0+NZ
        pNcAqGWZFDjuv9hsENqFvvAGFESaKl5i3wPt
X-Google-Smtp-Source: APBJJlGthri1wuPEMGs27pEajcM7hryhEfxctXKvA699qawtyhyGJ5wNksSwjTUqpLoTCr/9vPqPrw==
X-Received: by 2002:a17:907:3c0a:b0:98e:370c:be69 with SMTP id gh10-20020a1709073c0a00b0098e370cbe69mr15702590ejc.6.1689017098266;
        Mon, 10 Jul 2023 12:24:58 -0700 (PDT)
Received: from localhost.localdomain ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id w15-20020a170906480f00b0096a6be0b66dsm110076ejq.208.2023.07.10.12.24.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 12:24:57 -0700 (PDT)
From:   Uros Bizjak <ubizjak@gmail.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org,
        xen-devel@lists.xenproject.org
Cc:     Uros Bizjak <ubizjak@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH 2/3] locking/x86: Wire up sync_try_cmpxchg
Date:   Mon, 10 Jul 2023 21:21:55 +0200
Message-ID: <20230710192440.47140-2-ubizjak@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230710192440.47140-1-ubizjak@gmail.com>
References: <20230710192440.47140-1-ubizjak@gmail.com>
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

Implement target specific support for sync_try_cmpxchg.

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
---
 arch/x86/include/asm/cmpxchg.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/x86/include/asm/cmpxchg.h b/arch/x86/include/asm/cmpxchg.h
index d53636506134..5612648b0202 100644
--- a/arch/x86/include/asm/cmpxchg.h
+++ b/arch/x86/include/asm/cmpxchg.h
@@ -221,12 +221,18 @@ extern void __add_wrong_size(void)
 #define __try_cmpxchg(ptr, pold, new, size)				\
 	__raw_try_cmpxchg((ptr), (pold), (new), (size), LOCK_PREFIX)
 
+#define __sync_try_cmpxchg(ptr, pold, new, size)			\
+	__raw_try_cmpxchg((ptr), (pold), (new), (size), "lock; ")
+
 #define __try_cmpxchg_local(ptr, pold, new, size)			\
 	__raw_try_cmpxchg((ptr), (pold), (new), (size), "")
 
 #define arch_try_cmpxchg(ptr, pold, new) 				\
 	__try_cmpxchg((ptr), (pold), (new), sizeof(*(ptr)))
 
+#define arch_sync_try_cmpxchg(ptr, pold, new) 				\
+	__sync_try_cmpxchg((ptr), (pold), (new), sizeof(*(ptr)))
+
 #define arch_try_cmpxchg_local(ptr, pold, new)				\
 	__try_cmpxchg_local((ptr), (pold), (new), sizeof(*(ptr)))
 
-- 
2.41.0

