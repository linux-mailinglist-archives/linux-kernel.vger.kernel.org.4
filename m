Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F1F5709A5E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 16:48:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232173AbjESOsm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 10:48:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232026AbjESOsc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 10:48:32 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF48D1A7
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 07:48:27 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-96f588bc322so181697566b.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 07:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1684507706; x=1687099706;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BD6qB7twnufisotyY5nBfpaakG3WUms/sLLcs5/qPcg=;
        b=JDuBiVDj8o8HaMzkIB840oZkGv5wJJi7TNtUIrYqKhMie/96QidOGQDjQXE7b5+5S9
         tK8GWP5SEiIeHDVPjC3T2ENDFCeYqLi5SHh6A0hgK/rjIefTVUgKtRZiA8w7MSYtyRXh
         R0aHFCTNuZeLm/jFjl0vcQ1z/eRP+0aN//K8c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684507706; x=1687099706;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BD6qB7twnufisotyY5nBfpaakG3WUms/sLLcs5/qPcg=;
        b=h5A6njbIS6ZQ1xC3K+SgXnNVPrpZI13vscDc55i61oOudhgENDksjys82RPBN0UFwH
         fKsciqv2g7AJo2/a07HIUYt46+4ltmPvV2hhfu0sLBKe3ShljuUItYvmdkD+K324Jtbx
         I9cPkaOEdfkTq9pvo+wlCRFwWf9HP6eEP3Vu1KEmX4nzQ3UZEAGPJSotn8FZ5couNgaX
         gj0wZUTMJi72v4CiQ65VnwQ5YR7sQNqoNWhtcnp1ij0JxPAGvY8rIuuiDoyTm0bib791
         RI5vhkgC8UkJO3b9vFKp8qQzXNg7jqfY884p1FkjlLZjtQqAv0Kp5X3Dm3LY2MtMpcnx
         C1lA==
X-Gm-Message-State: AC+VfDwkrm9gEaoWb7GlHuc4aSiVW4XFmlWY5NkjpMoeZYeLuPhKI7PX
        CsSp7H7e2KAzNy9wpINuXCHwTg==
X-Google-Smtp-Source: ACHHUZ6OprUYGsS72ehmUtvrfFocAu2GyTDDqdde/uRgkGX7E/HjFZLPkMJjnA4KZkxfiwtIcIB0dw==
X-Received: by 2002:a17:907:1609:b0:94f:1c90:cb71 with SMTP id hb9-20020a170907160900b0094f1c90cb71mr2302378ejc.65.1684507706237;
        Fri, 19 May 2023 07:48:26 -0700 (PDT)
Received: from alco.roam.corp.google.com ([2620:0:1059:10:62fd:274b:c2ab:69bb])
        by smtp.gmail.com with ESMTPSA id a2-20020a17090680c200b0096a68648329sm2349437ejx.214.2023.05.19.07.48.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 May 2023 07:48:25 -0700 (PDT)
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Fri, 19 May 2023 16:47:37 +0200
Subject: [PATCH v7 2/4] x86/purgatory: Remove PGO flags
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230321-kexec_clang16-v7-2-b05c520b7296@chromium.org>
References: <20230321-kexec_clang16-v7-0-b05c520b7296@chromium.org>
In-Reply-To: <20230321-kexec_clang16-v7-0-b05c520b7296@chromium.org>
To:     Eric Biederman <ebiederm@xmission.com>,
        Philipp Rudo <prudo@linux.vnet.ibm.com>,
        Dave Young <dyoung@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Tom Rix <trix@redhat.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     Baoquan He <bhe@redhat.com>, Philipp Rudo <prudo@redhat.com>,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        Ross Zwisler <zwisler@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Simon Horman <horms@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        llvm@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org,
        Ricardo Ribalda <ribalda@chromium.org>, stable@vger.kernel.org
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1218; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=ZdKmKWLc9TEOfphmrnN/WwYYNZStN7R/TxB0+Zjd8HY=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBkZ4wxpLapFX/30sji37lAIaagKHpP8BO2TaX+/
 sJHabfFQk2JAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCZGeMMQAKCRDRN9E+zzrE
 iBOhEACRW3xOCPLHp71KLmHTYNCd71GtWrKjkfxklAL33OghFmTvUpYrsF9LpYB/m7hEcL/ThHl
 hL85+iGqortM23o+IHkavb1dGe2lPjzhRrAlOP3VRhZdMb4Z30GB9soPtsVB1wTkIHAffgMXlXl
 OX9TTvAAdTwiK3QpxHsQTI7Zrwd7j4F5PLFwLvF1EJ5B9vHk24k8qUliTckaIUupc8s90pL+blD
 76ekelf8r6J/OuHnqjwfBNPIN+L5PKM1Qnvc+nhDbVClbug/NZoYEOQncnJUQzy4+pPlgWMhh1n
 jSBpPsZLhRFaaAvgOmnCFcJ4QK855FrYlgSZ62gNGa18oujDvo8M/P3rMJl+ZptFWkJHg4ftqjk
 d2p50qqwa36cAZSdv5xiIorPYJAvQcKnfbLTa/33NmhdJsRmYKEIBmzoJJMVV1WM2GQ1GoS3iqQ
 xsIbbnRtyfu5Oj+092A0UrmjBv44l9VFL0GioJ/h1dybPyj/xRudpeipiBI5UHl+PsrthS0eXyR
 BEhiiCDkPPQVspdv9HGVTw7RtC+jrD2P59F2ZJdHKAj43rczvbjLU1aFhLmXOsvEzExQ7jdyhrD
 dtwIMAsWCKWuA82FW3a1RMjpQzwZn57XSc6vVKzBJhtayoAZ/RnFP3+dNNhzAJAuESXOXu/+Yc9
 KoQnpw6oiVlAnVA==
X-Developer-Key: i=ribalda@chromium.org; a=openpgp;
 fpr=9EC3BB66E2FC129A6F90B39556A0D81F9F782DA9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If profile-guided optimization is enabled, the purgatory ends up with
multiple .text sections.
This is not supported by kexec and crashes the system.

Cc: stable@vger.kernel.org
Fixes: 930457057abe ("kernel/kexec_file.c: split up __kexec_load_puragory")
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 arch/x86/purgatory/Makefile | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/x86/purgatory/Makefile b/arch/x86/purgatory/Makefile
index 82fec66d46d2..42abd6af1198 100644
--- a/arch/x86/purgatory/Makefile
+++ b/arch/x86/purgatory/Makefile
@@ -14,6 +14,11 @@ $(obj)/sha256.o: $(srctree)/lib/crypto/sha256.c FORCE
 
 CFLAGS_sha256.o := -D__DISABLE_EXPORTS
 
+# When profile-guided optimization is enabled, llvm emits two different
+# overlapping text sections, which is not supported by kexec. Remove profile
+# optimization flags.
+KBUILD_CFLAGS := $(filter-out -fprofile-sample-use=% -fprofile-use=%,$(KBUILD_CFLAGS))
+
 # When linking purgatory.ro with -r unresolved symbols are not checked,
 # also link a purgatory.chk binary without -r to check for unresolved symbols.
 PURGATORY_LDFLAGS := -e purgatory_start -z nodefaultlib

-- 
2.40.1.698.g37aff9b760-goog

