Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1B976F30F4
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 14:39:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232568AbjEAMjH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 08:39:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232548AbjEAMjB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 08:39:01 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F43510FA
        for <linux-kernel@vger.kernel.org>; Mon,  1 May 2023 05:39:00 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-50bc070c557so3012503a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 May 2023 05:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1682944739; x=1685536739;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pyZE1O+cxDpMOUxQLEUk9VsIXQThIAsknzXOkfD+xSE=;
        b=Bor1yKK2atDVckaaacFDlLhe35dHV7MGl0KzzPQwtr6gc2yZ7rj62HkvMqa1gUrZCF
         De56iZ8j2RFUvdlBla1sV1FWLxwDCZPvJ/m3sydSXsDv3Mn60uKR1Q5coVx2BhYFR66n
         b1tqCnbj9wOx7TSJUVYjTeEUdEVeqCyLaMoog=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682944739; x=1685536739;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pyZE1O+cxDpMOUxQLEUk9VsIXQThIAsknzXOkfD+xSE=;
        b=hBKOBhsdvQT4TXhmmaQXyyAdl7gLN2pKW32WxrUl4NtyrAYIMXJA64Lq+qz7abLzkD
         TnpTnnYTHzOdh3S+kXWTGUyEZIdoKNixC99ph2cZMaOpMvpo/GcUAED5geAgHcEK/DK7
         R9WcxNmKJKHlnlZYaFMd3Rh09C5w5YQrkhn8B6mFpLsWeHFXn7bV5nd3++M45qwor6co
         TYyDKODwrVOrNCF7N66lnPTu2rNKQClz7yDazRmvy+bu9zu4r6/guElG6VV6ghVEncYK
         nHAhrpABymFMMpBFSfBedMb8rwGNO4TEjZih07nH97rAxFV+LZFUJxm05o2cOPT4o9Ie
         YfnA==
X-Gm-Message-State: AC+VfDzVvFgokOvd1/zHXeykHv/zy9tVsJR4o9DRf6szd4IXwTUjGibU
        7+lc6pv4/jz5l9Ga+YK88HM6dQ==
X-Google-Smtp-Source: ACHHUZ5W8pX/mlnkgDZDwQqd6X0QzsG4R/YF4KsuDrDWMgjJPrF9qf6XFE9TQ1s5FGzbbsIYHoflOg==
X-Received: by 2002:a05:6402:1017:b0:504:ae37:77d0 with SMTP id c23-20020a056402101700b00504ae3777d0mr5215516edu.10.1682944738849;
        Mon, 01 May 2023 05:38:58 -0700 (PDT)
Received: from alco.roam.corp.google.com ([2620:0:1059:10:c573:159e:712e:688b])
        by smtp.gmail.com with ESMTPSA id c8-20020aa7c988000000b0050bcbb5708asm146772edt.35.2023.05.01.05.38.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 May 2023 05:38:58 -0700 (PDT)
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Mon, 01 May 2023 14:38:20 +0200
Subject: [PATCH v6 2/4] x86/purgatory: Remove profile optimization flags
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230321-kexec_clang16-v6-2-a2255e81ab45@chromium.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1187; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=IIFsucnr6ARsGWNiLz4pZTsRxLveIe3HXXJvtbCwLyQ=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBkT7LYnFaWGIKBUoEDbI1Rl1OZD+N1VfYBBA8K+
 Cbk2bC/+xiJAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCZE+y2AAKCRDRN9E+zzrE
 iL1pD/96xL2PRv+b9c7ULiPFv8LkyB4WqI/RqOYMHi4+V20nXkJNCl6THZaw46/PXI/ahEyqbtV
 aINfUi019U0CyjpAbSooeKs0kYmoILtUBcV+0muqaF2FSOLayMDme2oWP94AoGFc9DpK4yF2gc5
 piDu93s5rsKR/7UN9swT4exK5JuK5+1K4cRxXRDCk6cT4oDu9VaxWu3jpwJ9N1yZJJaFd9ozcBD
 tiBzCs9QZ+d8Rk3oo8twJIHoh0jz0VWeHaG6YiiaOuHgmmMmkMn0zafEIdbDZF/ssNRo6NmqhSE
 1ut2XoCk4RYoTYZ9D7PimkELbpvJDFePmQAnTXBkBRFIGJjPmn6uXKENW1XxAWV+ZKkY8EjjPiA
 7cyOsfuYzGYAKL1B8nlX9IqUkf1xyZvHIhcU0Ekyj9usjx91kt5YQzBHOjlIVMQR3GeOaHiH/I8
 qEEESlRHhE+X0b8NCKCUNOlnRvRMDqx7hVLoBich9HqrKbEXRAFcIsigOIOsyrRZ0PsD0mYfSBK
 NtuPU6Hdo3+JtSls9wVkvPngnrCvKBu7ntG9SyL/5RYHMzf4cs2YMwSzTP9xGgcVCZcgslRbcT2
 DQ2SxSadihHzYdn+eTWojbcD6m8KMroml7R3GT3eai+zzKi+LGRymBIYHJ29ghn9S636na8PXcW
 An9ssGUe6z7KqUQ==
X-Developer-Key: i=ribalda@chromium.org; a=openpgp;
 fpr=9EC3BB66E2FC129A6F90B39556A0D81F9F782DA9
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
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
 arch/x86/purgatory/Makefile | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/x86/purgatory/Makefile b/arch/x86/purgatory/Makefile
index 82fec66d46d2..7a7a4901ed41 100644
--- a/arch/x86/purgatory/Makefile
+++ b/arch/x86/purgatory/Makefile
@@ -14,6 +14,11 @@ $(obj)/sha256.o: $(srctree)/lib/crypto/sha256.c FORCE
 
 CFLAGS_sha256.o := -D__DISABLE_EXPORTS
 
+# When profile optimization is enabled, llvm emits two different overlapping
+# text sections, which is not supported by kexec. Remove profile optimization
+# flags.
+KBUILD_CFLAGS := $(filter-out -fprofile-sample-use=% -fprofile-use=%,$(KBUILD_CFLAGS))
+
 # When linking purgatory.ro with -r unresolved symbols are not checked,
 # also link a purgatory.chk binary without -r to check for unresolved symbols.
 PURGATORY_LDFLAGS := -e purgatory_start -z nodefaultlib

-- 
2.40.1.495.gc816e09b53d-goog

