Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5528D6F30F8
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 14:39:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232588AbjEAMjP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 08:39:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232556AbjEAMjE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 08:39:04 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3452E58
        for <linux-kernel@vger.kernel.org>; Mon,  1 May 2023 05:39:02 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-50bc4d96e14so8630207a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 May 2023 05:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1682944742; x=1685536742;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vsOOlRTCOjL3abNi/3ZUSQqB4+vgvV69cdyU9ee1C48=;
        b=hODYeDeYg6APhZAviVEDv24zkkV5PSyD9YF80bCIKMgiHcDDsd8y08C3drl6nvnGJD
         IlJxYRT/wEBGX7nbEciydDBBtR5sxWJSS+Q1JOTL+EYkrNHQvWMsz4+2JhTAsCU5cMFe
         Ea+MOxsYngr/dEQhvm3KkMoPZiJyiwADd2JrY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682944742; x=1685536742;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vsOOlRTCOjL3abNi/3ZUSQqB4+vgvV69cdyU9ee1C48=;
        b=cbvArH7xDGKhcS4k09RJUxv+BJTrExTjlxy5kT3W3uG3t1FcA1+eJe3CuRmeImImcp
         bIj9pc9VMVv2m6HCmjuMlhnfBE1L7JbFfLFkATCzi+9oS7eLYzPdCYnek5o+TT6+ZsML
         EzSM0iXP8Q9MN0ZKi5IR3R8hv0vMqp0o+GWdrLi51Mw6Q48m/rS81HB6cYn42Vxhsv15
         t02vuUhf5s43gCuyVJzuzX75ii5Yl9ZCA3PPjwRYE1rBbBfS7+RLDh+VQsxhlj5SwxEN
         QkdqktPGBv9KrF8csIakzmM83hPuwVw4Nb14bKlHuvtHWgaKouplEV3/npntPGB3yxJ0
         Vbbg==
X-Gm-Message-State: AC+VfDzx6cMSNXL/c1U62x4ggOE3K31hTyPZMnLa1zG+i8Tt/LZpb2GA
        hKu+WFW8ABqSR7RslJimJob/2w==
X-Google-Smtp-Source: ACHHUZ4EUorB+1FZYBv1RP6+ov+r8A+Pc1H1dxULnrAhwBqWHXQ9LjOP3Ez/dznJWtTpBeBKUxYLqg==
X-Received: by 2002:a05:6402:27c8:b0:504:77ed:5a33 with SMTP id c8-20020a05640227c800b0050477ed5a33mr5864584ede.8.1682944742259;
        Mon, 01 May 2023 05:39:02 -0700 (PDT)
Received: from alco.roam.corp.google.com ([2620:0:1059:10:c573:159e:712e:688b])
        by smtp.gmail.com with ESMTPSA id c8-20020aa7c988000000b0050bcbb5708asm146772edt.35.2023.05.01.05.39.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 May 2023 05:39:02 -0700 (PDT)
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Mon, 01 May 2023 14:38:22 +0200
Subject: [PATCH v6 4/4] risc/purgatory: Add linker script
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230321-kexec_clang16-v6-4-a2255e81ab45@chromium.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1219; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=ECbK3ORJb/ox8qpp2VcGabf7Ou2PzFFDokGI84nq/PQ=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBkT7Lc5MTx2hMC4Re9phVjZPNed9BIxos1Pxii0
 61fGiCxDbqJAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCZE+y3AAKCRDRN9E+zzrE
 iJuYD/9j2b1eDvjy+uQCumtGC2Jn+H/Md0JWPsxPb46aNyMDJJYtpnBOkQyLCIR1Ro6iTpnQQLM
 +8uN/ou0X4CF9cfN+g6f5JwkPoQfQcP+jYNP8HE3vvJyaw+gY8gFKrsolGYojIu5+7EZscjeM+x
 7hCRkxslbxzkKo8bCXJPNM5bL+TS+8voKLtJw5vxmDtH71krf0z6Gp38OUM1qbruri9kSi75MmP
 pPIc503fFiicjySfDDJ804XtSoK2FjXUVn96C+XtJdu8JE5WpzayNi5G1CCxtOHmymMyPL11Nyb
 +Y3kXDpLRgX+07NcFuZOiO/0ThN8bGM98On1cBYfS5PV2bqYo2Cv6+KOCjnObJd8T8zLrIWY31E
 dkIZGehfJGieHtPMQYd0Up0Q7UFloD9EOCUk3YXQjbVL5YW62U0ajBT0UqSNiyO8Fk5AdOGQnDv
 M1oDH7eB6zhw04nOc8MvRcEL1vb70bgueckn6cp6u0ViYD7VRwHLkKiDx9y2wl93EfhhVpu9EpQ
 108x63OJbcTsVjOEtHREb8lzuERyPHJsPH5o49C5N+yZd7HKY8dMY7vi4/kdo4rqsrCdLSOYIRN
 nVm4G0/Z6eWsohGrZwA5weUUpMcYwEHd+mCMobjyQ8WPRg/nBapyYtxdaEgYMK3As9R4j0j3G0s
 Q5pwBDSsFyR/N1Q==
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
 arch/riscv/purgatory/Makefile | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/riscv/purgatory/Makefile b/arch/riscv/purgatory/Makefile
index 5730797a6b40..cf3a44121a90 100644
--- a/arch/riscv/purgatory/Makefile
+++ b/arch/riscv/purgatory/Makefile
@@ -35,6 +35,11 @@ CFLAGS_sha256.o := -D__DISABLE_EXPORTS
 CFLAGS_string.o := -D__DISABLE_EXPORTS
 CFLAGS_ctype.o := -D__DISABLE_EXPORTS
 
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

