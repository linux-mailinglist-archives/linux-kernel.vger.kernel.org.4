Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9EE7709A5F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 16:48:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232182AbjESOsp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 10:48:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232086AbjESOsc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 10:48:32 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 426B91B4
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 07:48:29 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-94a342f7c4cso636589966b.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 07:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1684507708; x=1687099708;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tXwbVblZO4SjZiyR2RJlU+1lPwt65C7sEIHn8p960bg=;
        b=VaD18pvaYOrPW92cQcoX/NEFyAia0fIgR3ptOsuxx7KqL2m3/Fogz3ohdrjtw8jIAf
         /EDDCPYx2T0p21USc97DaVoXS6yaR7TsMgEpNMeajTXb8D6rWvFbDapW+nC79TBs8v+N
         rMi14ZDfRFVBtp/DNGdIPfZ3+MAQ50UYsHPYQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684507708; x=1687099708;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tXwbVblZO4SjZiyR2RJlU+1lPwt65C7sEIHn8p960bg=;
        b=jKWHiTri4FYvKaUdsK2Yun5LzVMq0hR5qdiz2n7Tp0ed+WQpXWXu7X/WCPQ+QMjdUR
         kaUh8ljQgwpZGj91GOBTQs3kCZNgsxd4KjKHTxjkRnVTbwZExlUtGxq3mTbvtV6NgHRB
         pAUj8IEpUda/Ok4kpWQMOVjEvTz/RdSNjEKCwCVpku+ke8XNQId2JJshk1QMqxrGspOQ
         xwYDABIFWCTdYlZpFx99a07cmUZp4nXOul+8f3zE3Em+aeP3c+cgrr2meGFopfOBQnwq
         RDow317G15ebnowMY7TcjN7UWy6ymllKiA3nuXNAQa0S1FKWxOjoiWFtlhTLSFU4OWAT
         jxvw==
X-Gm-Message-State: AC+VfDxLSxE8esDhhqe0rpQq+YGk578BZTPMh+viM2bkgoiCM5/QSD50
        v9eL/WoZFEmZh/Wqr+WygyQcUg==
X-Google-Smtp-Source: ACHHUZ6IJYry1zbpAYrsb/Nt01gDEwYVyd3RcsdkRiDkcM4NVXli57Wi75rvrU+p/H5SVbhZnecZhA==
X-Received: by 2002:a17:906:5d09:b0:948:a1ae:b2c4 with SMTP id g9-20020a1709065d0900b00948a1aeb2c4mr2454616ejt.6.1684507708255;
        Fri, 19 May 2023 07:48:28 -0700 (PDT)
Received: from alco.roam.corp.google.com ([2620:0:1059:10:62fd:274b:c2ab:69bb])
        by smtp.gmail.com with ESMTPSA id a2-20020a17090680c200b0096a68648329sm2349437ejx.214.2023.05.19.07.48.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 May 2023 07:48:27 -0700 (PDT)
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Fri, 19 May 2023 16:47:38 +0200
Subject: [PATCH v7 3/4] powerpc/purgatory: Remove PGO flags
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230321-kexec_clang16-v7-3-b05c520b7296@chromium.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1118; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=nWZ2BYP6i2Y8oRo+uF2PHambNY95ZiGn4TiaTAGbKto=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBkZ4wyHkNCHhezyfivzJzrNGMs0K4vUNQRc3pJJ
 kWHuaNU3qOJAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCZGeMMgAKCRDRN9E+zzrE
 iP+cEACcWHC3j1LmIzpKx/SEOuyu+T8juc3Qsp240gztvu/viz42y8/iBia84BlsRwErLK2OL0F
 3ajW94BvdF+hTyHozZEgIagItfSauWAbew6wVa0Qzfv2fr5mU42KfHptzq1l42en7K2rPbcBmLI
 I2P1/oqo/f6jOgRfm+rkNph26o3SqzcGwOrNJxLkICIjOt2ryabXBD6m79TkrzdPaB9SoChGJac
 O79LnGL81Pw+Yncu0mYsV4I5Rjw5ZeyFHdpQ7Fz5EA8wvSDDG6odoFxcqf4yE6+bmUv/49AELSz
 4dxJdTvbEKZro9lHA0iSPkRPv/S0GQJu/n8ilKFXAYPfqAfDYAN86mjt4xRWsDrK/m2U5bJyQDO
 y1Bsea8Nuec1BFMA7YRXUDVC9wxgK6i5U1QYeDdEOWjG8KsrN7aDk6FT7Vs5HVZVFlpaYzxI1Qy
 OuCwULJN4OB++Blq1pndCgv3Enk4iWEnD3tV8M5ZGZEkwnZmi1PxTzTAUZrdHBuiBcGUJURHEal
 /D5/1Q6A+bUxW980Yzwcu1tPuxwKe1lCW0boDcrNi3inwoNG0wyymcZvtfl/+IKzenjCXxuZ8c4
 54evV8xE1nlppSTiE5EscgwFuFxb6elq+Frz99s4912olrL9bjc84OFEQ1brCORAnz/ZbTuENqO
 ZuH2pEvCDHPT0rw==
X-Developer-Key: i=ribalda@chromium.org; a=openpgp;
 fpr=9EC3BB66E2FC129A6F90B39556A0D81F9F782DA9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
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
 arch/powerpc/purgatory/Makefile | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/powerpc/purgatory/Makefile b/arch/powerpc/purgatory/Makefile
index 6f5e2727963c..78473d69cd2b 100644
--- a/arch/powerpc/purgatory/Makefile
+++ b/arch/powerpc/purgatory/Makefile
@@ -5,6 +5,11 @@ KCSAN_SANITIZE := n
 
 targets += trampoline_$(BITS).o purgatory.ro
 
+# When profile-guided optimization is enabled, llvm emits two different
+# overlapping text sections, which is not supported by kexec. Remove profile
+# optimization flags.
+KBUILD_CFLAGS := $(filter-out -fprofile-sample-use=% -fprofile-use=%,$(KBUILD_CFLAGS))
+
 LDFLAGS_purgatory.ro := -e purgatory_start -r --no-undefined
 
 $(obj)/purgatory.ro: $(obj)/trampoline_$(BITS).o FORCE

-- 
2.40.1.698.g37aff9b760-goog

