Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 491B76F30F5
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 14:39:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232577AbjEAMjL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 08:39:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232553AbjEAMjD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 08:39:03 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25078E52
        for <linux-kernel@vger.kernel.org>; Mon,  1 May 2023 05:39:02 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-50bc3088b7aso2523951a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 May 2023 05:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1682944740; x=1685536740;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ecmOgKj4rHuYIab/sfV0jN5x+nFDKq6SG67BJPIt7F0=;
        b=mKg+bkq0NR+B9AinP7+ox3WRRdl5CMkW6hn7AD82Fgqa+7fbUMNiNltYuZCdWKFzGc
         unhr5yMOsZL/or9r8PjKGOGnbVzP8zPkt+LRSVK8mg5G/t33oA9o1PY698FnKY8PYIET
         /LDgi+GpCXZLnhOflN7j/omuXZmCcamYmO4lk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682944740; x=1685536740;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ecmOgKj4rHuYIab/sfV0jN5x+nFDKq6SG67BJPIt7F0=;
        b=RF1neIjvRHTp5HRd8aoHunkbdv9z6/ciX147r/ZqYcj3tXnjDzn6NBWXy0uuBJ78dI
         4gVBysQJa+bpvALouzLF7JWB6EpqSQCYOsbLjEFoX9WsoShKbXl8OLIg4lT37OwrDQcy
         zzgfj2f3mMo4GZzaruQrKsoYUOGIbb+MTpsopXGt80BggOZbnwTkFQ53Ran5A5OGhhX1
         OFH3Pr5BlWq/TpPFDtn+56VUAST86KVxnK48vRPT82xSN5AotvCKzAUv8tGQsYRHEqmD
         LKQdNoIDj2dbsaeEt+FkaFLgpgGZzjMrPpi+2rM8Nf3pGuGhAC6YGTGNWDBjsnwRk8bf
         YexQ==
X-Gm-Message-State: AC+VfDzwW4DFeQlu8NDF/OxOey/YhTirKG3B7ankYbO+Y3B870ufiYiK
        xRtrJzJCkP6JcV76rHCIH792Ow==
X-Google-Smtp-Source: ACHHUZ61A+LRi+71XC3zKgGuQNso9mPlM0T8FY/poP6QaGXzZI8sTUhNY6Hk0v49L4lTBvUZBRM9uA==
X-Received: by 2002:aa7:dc0f:0:b0:506:c2b2:72fc with SMTP id b15-20020aa7dc0f000000b00506c2b272fcmr4483898edu.7.1682944740515;
        Mon, 01 May 2023 05:39:00 -0700 (PDT)
Received: from alco.roam.corp.google.com ([2620:0:1059:10:c573:159e:712e:688b])
        by smtp.gmail.com with ESMTPSA id c8-20020aa7c988000000b0050bcbb5708asm146772edt.35.2023.05.01.05.38.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 May 2023 05:39:00 -0700 (PDT)
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Mon, 01 May 2023 14:38:21 +0200
Subject: [PATCH v6 3/4] powerpc/purgatory: Remove profile optimization
 flags
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230321-kexec_clang16-v6-3-a2255e81ab45@chromium.org>
References: <20230321-kexec_clang16-v6-0-a2255e81ab45@chromium.org>
In-Reply-To: <20230321-kexec_clang16-v6-0-a2255e81ab45@chromium.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1087; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=5RExnAah9i9M9ThRE28+66klWLL9LdvzLPE8nTUxjoc=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBkT7La8ioS0FTBvHSBrwIzNc4yErEKxBXHSQt+x
 JiCAoPrehyJAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCZE+y2gAKCRDRN9E+zzrE
 iPSPD/9e9vGoy1sdkIvKVHZQw4XGt6HvaPue9LcoY39HNyZE8mZATbQBYoSI3SkVObACWx/jlGW
 hny9wRcxVSR2gX6ndlP3hfzmhcAG5m4snPNfr1/kVb1t204udn4JAMSu6uB0tOAaEJf0cly/tPX
 MgzKHTBxQ934jsr55N3AFr9IVNmsahHF4f3aSWjNkqG17UbtDgv8cTwplGTAcFmuEaR2z1RjZkA
 F/yFwnqe+z3MZ88H8P+DkXvYeZmVqaAlsGnmPR7qa/hdj36aRty/zFgPnKfHUSJeGyp2fH2NnXz
 Cd1SzviJIuk0zXGetJ0TVMwvd06uiL48vL15JIziDBIUBrXgwgsjgWjbJX9UyVQgnQxw2mlzHtT
 Z7CLSbHlZeWWNhhMRi8OdxxXy970/+OBiTXjIC3RdYBoC1cs9ICI2TwUw+oOGh+NTL0sqsgyWmN
 qXAI32vfKKHiJSW146dpoerqe2/aEC2FUfzHHni/4c6Xc897c8ScvQ1KbXuolWzL1VEjHrXofQx
 UTbe/svZ2wrRRbzYDaPi17SrFGFPMeTLs/8NtUxrR/huyW2SHpZatS4Q5VxStlZ8eC+qZ/c8S1X
 VmC7nztI9HXeDK9dTlsMYGuPnA7hQ52n2CrQPyQ+zyQMCydIlCzoTIuFwmucPvw8iUBDg/Qb8sn
 WvYecPgPSx57Nlw==
X-Developer-Key: i=ribalda@chromium.org; a=openpgp;
 fpr=9EC3BB66E2FC129A6F90B39556A0D81F9F782DA9
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If PGO is enabled, the purgatory ends up with multiple .text sections.
This is not supported by kexec and crashes the system.

Cc: stable@vger.kernel.org
Fixes: 930457057abe ("kernel/kexec_file.c: split up __kexec_load_puragory")
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 arch/powerpc/purgatory/Makefile | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/powerpc/purgatory/Makefile b/arch/powerpc/purgatory/Makefile
index 6f5e2727963c..5efb164330b2 100644
--- a/arch/powerpc/purgatory/Makefile
+++ b/arch/powerpc/purgatory/Makefile
@@ -5,6 +5,11 @@ KCSAN_SANITIZE := n
 
 targets += trampoline_$(BITS).o purgatory.ro
 
+# When profile optimization is enabled, llvm emits two different overlapping
+# text sections, which is not supported by kexec. Remove profile optimization
+# flags.
+KBUILD_CFLAGS := $(filter-out -fprofile-sample-use=% -fprofile-use=%,$(KBUILD_CFLAGS))
+
 LDFLAGS_purgatory.ro := -e purgatory_start -r --no-undefined
 
 $(obj)/purgatory.ro: $(obj)/trampoline_$(BITS).o FORCE

-- 
2.40.1.495.gc816e09b53d-goog

