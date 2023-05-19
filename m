Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F551709A5D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 16:48:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232087AbjESOsh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 10:48:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231937AbjESOs1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 10:48:27 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 283A818C
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 07:48:26 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-96f6e83e12fso99183266b.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 07:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1684507704; x=1687099704;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ELGoOCRLTJ4MHn8fGeUgbOupJ2+8dwbN21sm7VIhXso=;
        b=D4g+JOjETqBP2MNsVxzuMqgSzr8YRIXXqXUsFsUs+pP7Oau99Qe5QVR8UVcOTLFbYr
         2mBKTdNoSjWjKYbSfJFKKxoLxwL2nUiC9vdnjZqrfUxyhqBpQTfo92kIGosmAzfxZkc7
         /gFY2ugyiRu/EN9empIUDCr0miK+PQYdw14+w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684507704; x=1687099704;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ELGoOCRLTJ4MHn8fGeUgbOupJ2+8dwbN21sm7VIhXso=;
        b=VcxTrcRczfM9cdfmabUd9UMeKG6BnKkX6xE9dICN5BGWM0QSxJb/PgTD3IGpIj+Rc1
         OYT+Iz9Q1s5m1gpk1qmE2omcbsX1nS/xfITL8KqQcyyWFEBS81WU1J401OhyQuN6k5Bk
         /ljHMvC1VMYkacD4AxjVJwXgmxinM28tIKnVj4hpVgZzr8oymYukXHeU2+S2ipqLb+VS
         KpGGn3SDyqgnJR8GQkwuWE5a48NWYe/i1s+0MjdisCIbqFJY+IpS6KknLD+lOm8ZrrVn
         +ZxDLSGbP/wJ6qmLffzJ8UkXCrVYJESocK8RUoalog5UTlYYWv28e/45JfvtRhMetdOg
         XpVw==
X-Gm-Message-State: AC+VfDwvrb8yt2KsQovnSZ31uVy5JWuG54zaRtF7qqGQmieWWkmgoLKN
        TeJZe8RaEcTGMabc0A0iRGL9mWMwYu1GiNX7KqY=
X-Google-Smtp-Source: ACHHUZ5er3tu+nCtQ7Zlu5XgqUa9zkqU4VH2ledXN0dv2te/5cUHcPTgI8vJqOvGTakS7HmQprNDHw==
X-Received: by 2002:a17:906:da8d:b0:96a:2b4:eb65 with SMTP id xh13-20020a170906da8d00b0096a02b4eb65mr1967680ejb.9.1684507704586;
        Fri, 19 May 2023 07:48:24 -0700 (PDT)
Received: from alco.roam.corp.google.com ([2620:0:1059:10:62fd:274b:c2ab:69bb])
        by smtp.gmail.com with ESMTPSA id a2-20020a17090680c200b0096a68648329sm2349437ejx.214.2023.05.19.07.48.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 May 2023 07:48:24 -0700 (PDT)
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Fri, 19 May 2023 16:47:36 +0200
Subject: [PATCH v7 1/4] kexec: Support purgatories with .text.hot sections
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230321-kexec_clang16-v7-1-b05c520b7296@chromium.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2610; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=CXKb/XxwO+TeE2qMZ4maPIDzkElWqU54WhfDNIzg1OA=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBkZ4wvbWRlFkwwm7hPC34OsXUHzyGG/L3qcdTaQ
 ESqu7FBeJOJAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCZGeMLwAKCRDRN9E+zzrE
 iGRwD/0as+nZeAaB8OCCvreoh9SZpvQ6HI+sFQ8wcjwVDbNr4u/AX48ru5mvUvQkXZoW997MbsV
 a9jsKvwYE378RIjLevvwuaw7lXR+z1QCf0pDGsFS9/1Qkgpnm5MFRGtuEJjqfU4opKZZTyG3+52
 PULBlFYQ+CO3naQLwyzrl6R1wxhDznz9okZI+/eZEBjbTUPPG1JVqNbj+voFWFhrSME3gCGl0od
 tiMu8KOz8glAw78ATlp/ZyhTMvncR1OcGXRhZ5TVlundBnvi+XxEn0D9kMjn9D03/hpkGJ9w0ob
 O/BvrYhGpJ6tkMS0vW0L5KmvnKN0y+PjE4Knwzrpk5JmH2kLXI7N1H19wMT1ic8un9ioYq+TAQ0
 piiLFkEgR0PJ+TKJsP5MtYNhJUucIksvHaz0fso54li1MpHNPwGZeJ8ixj34l+G5L+mHfScdWJo
 aZ8306S/qymzgdbngVq2LU2kkf9t1A0MXbBoVeAwgk4K4Te2i1WCF1vE4A4dxLojWktksv2lEX9
 DT+Ht5dp0m/id7BEVxuTBt9RIAcbqNXxhc/mIOJ8nzGIz3M7y3uyX6epnnvRkQAE8xFIXdESvLF
 5xvWaykmWjyl+XRYp94K3OvPDAwVjfqWHtlSeHy2A2Bg6adMdcQO5tqfln3HOq48lkIrpqzg+F1
 2N3gY3Zhf2lxlRg==
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

Clang16 links the purgatory text in two sections when PGO is in use:

  [ 1] .text             PROGBITS         0000000000000000  00000040
       00000000000011a1  0000000000000000  AX       0     0     16
  [ 2] .rela.text        RELA             0000000000000000  00003498
       0000000000000648  0000000000000018   I      24     1     8
  ...
  [17] .text.hot.        PROGBITS         0000000000000000  00003220
       000000000000020b  0000000000000000  AX       0     0     1
  [18] .rela.text.hot.   RELA             0000000000000000  00004428
       0000000000000078  0000000000000018   I      24    17     8

And both of them have their range [sh_addr ... sh_addr+sh_size] on the
area pointed by `e_entry`.

This causes that image->start is calculated twice, once for .text and
another time for .text.hot. The second calculation leaves image->start
in a random location.

Because of this, the system crashes immediately after:

kexec_core: Starting new kernel

Cc: stable@vger.kernel.org
Fixes: 930457057abe ("kernel/kexec_file.c: split up __kexec_load_puragory")
Reviewed-by: Ross Zwisler <zwisler@google.com>
Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Reviewed-by: Philipp Rudo <prudo@redhat.com>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 kernel/kexec_file.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index f989f5f1933b..69ee4a29136f 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -901,10 +901,22 @@ static int kexec_purgatory_setup_sechdrs(struct purgatory_info *pi,
 		}
 
 		offset = ALIGN(offset, align);
+
+		/*
+		 * Check if the segment contains the entry point, if so,
+		 * calculate the value of image->start based on it.
+		 * If the compiler has produced more than one .text section
+		 * (Eg: .text.hot), they are generally after the main .text
+		 * section, and they shall not be used to calculate
+		 * image->start. So do not re-calculate image->start if it
+		 * is not set to the initial value, and warn the user so they
+		 * have a chance to fix their purgatory's linker script.
+		 */
 		if (sechdrs[i].sh_flags & SHF_EXECINSTR &&
 		    pi->ehdr->e_entry >= sechdrs[i].sh_addr &&
 		    pi->ehdr->e_entry < (sechdrs[i].sh_addr
-					 + sechdrs[i].sh_size)) {
+					 + sechdrs[i].sh_size) &&
+		    !WARN_ON(kbuf->image->start != pi->ehdr->e_entry)) {
 			kbuf->image->start -= sechdrs[i].sh_addr;
 			kbuf->image->start += kbuf->mem + offset;
 		}

-- 
2.40.1.698.g37aff9b760-goog

