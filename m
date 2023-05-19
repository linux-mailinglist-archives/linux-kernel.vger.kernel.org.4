Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8DD3709A60
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 16:48:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231331AbjESOsr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 10:48:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232098AbjESOsc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 10:48:32 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6572C1B5
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 07:48:31 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-96649b412easo532763666b.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 07:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1684507711; x=1687099711;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=osK35APNMHUOM/vspbNmY4dm4o7cSGGXI42PTW0uu8s=;
        b=ZYjh30K7khuwsHmxdTGgS+WoY9zJgx6/9/pcc1JbuvgcIEsldCdXXJbEp4NACjCKaD
         LMW1h53HHwQnKpmODQx7uXNQn0+JuBNgZS2Zh/7IejB20vSK2D1Unr6kMSuPVMXAFhiZ
         9ZeWiBl87aFZW9wBv1Nh3DLuN2movq9+fC554=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684507711; x=1687099711;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=osK35APNMHUOM/vspbNmY4dm4o7cSGGXI42PTW0uu8s=;
        b=UokvlmPWXs1gY0jEEhuTpAya1J18aYOAr2fyxevhbeOJByHS2sfsKQlrEyId4TTeRZ
         GVZ+i/rZo2vxv2pNhq/tpXcaXC/ajhlFmYEXxv+LaSqX/krAonV23GxgNOUB1Ae0SDEo
         W0G4L/L7eNp9NmFS/x3+AJpsXHShA/F1y4Cj9OX6Btv8pc6v3cTeJtNhrfinFYUFbG+o
         COYx10yuY+29xwgDipX2zN+3P4CoRfELDTaD/q3gx2XZrP3WY4xymTjRtB9TTPKHfEZ+
         MkUBRbKXdUGqjN8qFiuGceTomsOu4yvsWGmsjV5sujgrNCVKo/5snBIT8qIDnlI9geeI
         OVpA==
X-Gm-Message-State: AC+VfDyTiDo8dF+JvVX360tJxMl5Ox75uZNgETI5/wxCu2kGraaEevTo
        0jTb6NE/adZ+UiSXu4uP9EQGow==
X-Google-Smtp-Source: ACHHUZ4sIn6w3qgGaOnZt7gYsC2ndgI+MwJv4U/AftjTcUf/UQqUnAD4mNaTZk8Vvatu2vHjziPdfA==
X-Received: by 2002:a17:906:d54a:b0:94e:f738:514f with SMTP id cr10-20020a170906d54a00b0094ef738514fmr2090904ejc.13.1684507710607;
        Fri, 19 May 2023 07:48:30 -0700 (PDT)
Received: from alco.roam.corp.google.com ([2620:0:1059:10:62fd:274b:c2ab:69bb])
        by smtp.gmail.com with ESMTPSA id a2-20020a17090680c200b0096a68648329sm2349437ejx.214.2023.05.19.07.48.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 May 2023 07:48:30 -0700 (PDT)
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Fri, 19 May 2023 16:47:39 +0200
Subject: [PATCH v7 4/4] riscv/purgatory: Remove PGO flags
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230321-kexec_clang16-v7-4-b05c520b7296@chromium.org>
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
        Ricardo Ribalda <ribalda@chromium.org>, stable@vger.kernel.org,
        Palmer Dabbelt <palmer@rivosinc.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1298; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=wdnk6GxBa5T/HIlvuq8XoXYQQFQFk4mx9eVuJiQf83M=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBkZ4wzePFk89/IBhUZr9SWcIl2QkwFBFu2gEcYe
 /5y+YTRvGqJAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCZGeMMwAKCRDRN9E+zzrE
 iEJ9EACWgKvSdCRvRA4/lyxhvVHQgJQ0PCNnOhH3hpa3YJPoHyQLHQ8AWvcvBMla51KPtthYLTN
 RttNdzciI8SyWtWAc62LCy0wqaKDS+qbrbvVnUEYDgzqyCjq/gSxRky4clrjmFzUvY2wNCRfWMt
 yFLtWzm5iYd4N7d07L87XEKmPRitblqcy/VsPL9EMUutCQ5OQlaaSRto36SmkRf9nkrMPPzCH+2
 qNNS8PY2lNeGzUvTDAi7F00EDf/PLWQ7pXaKeJeU56IsYS8v1VUoNdkx04R/AIO8TBdqwsDZhhD
 UqPLLPRwecZmAks5n575AFj+ZFRtUPueG6J2aQ1ndVzS+8/OTyW1xxwogq6fkwr44uXalhe3YxJ
 aUOnvtCxh06L48mQLfdlx1JhUTlhZ1AtVysiezFN9EedPP27rIgxpSSgnEwsjDWJny3YJfbGJQN
 Zk7DDEwAQLAN3GaT+i/K2X8PEHG6+A5SkFE+wZe5WKERCdPLVGgWjIYwaqXDAvGK/5DfORHun85
 2qC2ReqZtGwpWhUfg6jJ4cFTsiNbkYy31b1T5/9BqXT5dBqfAuVU/QKYqg5qb4ciKtKesTLLV1H
 ZydnfO9MMJNG6tjvelUtgGQRPqf1ea9Lob19/0XoQrWh8oifHm8eWWisKYfQY/1ExftAFpZCeA5
 BmR9KbCqwO2lwOg==
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
Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 arch/riscv/purgatory/Makefile | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/riscv/purgatory/Makefile b/arch/riscv/purgatory/Makefile
index 5730797a6b40..bd2e27f82532 100644
--- a/arch/riscv/purgatory/Makefile
+++ b/arch/riscv/purgatory/Makefile
@@ -35,6 +35,11 @@ CFLAGS_sha256.o := -D__DISABLE_EXPORTS
 CFLAGS_string.o := -D__DISABLE_EXPORTS
 CFLAGS_ctype.o := -D__DISABLE_EXPORTS
 
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

