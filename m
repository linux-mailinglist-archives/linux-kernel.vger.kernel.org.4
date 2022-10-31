Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73B71613557
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 13:08:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231246AbiJaMID (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 08:08:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231249AbiJaMHz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 08:07:55 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3866AE0AA;
        Mon, 31 Oct 2022 05:07:54 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id p21so6677159plr.7;
        Mon, 31 Oct 2022 05:07:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1zed+8ilXn6MGIJcL2z90P1TobfWQ+njImejMWMmf58=;
        b=VBJYqllwLFKjjSog/J2zrGa1E0jj6lPzM1Ul9Z7cCsRz8OTNshgJ2ToIavollcnHLt
         3Xh0awyDJZ+YLP1fO/40IlMN/ZwdoBVWWA7qOMRW2GjrY3h/PvN5a0KcCKfcMSzGIW10
         2S+wm31G2aDkYuffcnTHjN3SnfuTN7VvJNmPpHJ93uK1NYPOeADA+cZefMhs73PR+sOo
         TSnoO7bwOPE3ThPzfvkY4EPsR3Exf5qS48DKXjV/V5IqgHufQmzgGB7T+Wed/ZIX8AXC
         AsUkncP/ob33JkaFN+r3IsiYeqp8Br6SNYftE8LGqsLFD8C83+O5bRsNxT0bUEcR/sbl
         aCkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1zed+8ilXn6MGIJcL2z90P1TobfWQ+njImejMWMmf58=;
        b=Sp8yI/EW7H/T2NDQa+9ey0SNekrpH+zZ1inEWwcjTSkQrLWYK/aZpadpJCW4vuCO1n
         XFSmTo1cM2rHH3dkBzA0ZvzjI/m1Fb+NWLhGejNSRJDYP7Y9PkDrfs5UXNKnOTDyBdM9
         ld3fCbcK1/zVAIzPmNGbk7g1zSTFkWTa6gN0/2Sblcmgq/6tAj84zb8MDNjHZQE7ADAW
         NCXI0cUW4f5sjPbJUQAiYZh1ifqYSmssy/kzbG3AMOd5SzxMN9zqB+kbDKC02XzBTK0k
         9Kq4fkZzp+hjy7oH7XDX2sQC8Ae+Fo74emFatdHW+0w8MVDsEo/ZwSs9+TSnTq9I+F5k
         GVyg==
X-Gm-Message-State: ACrzQf1IoKxPGWVWal8yMI1mkNppVkeyqyL4WmE4jx3bdP+dFv6Q4jwl
        0Dq6aRWcNyFOloPfiPfpgNRIf+iR2+Q=
X-Google-Smtp-Source: AMsMyM6XhgTq1aU0IovI+tOfx0sloE3/zK0Q6l/El5DFFIfDlPvfv+ImgWi15cABY0LrTsEWLwRPBg==
X-Received: by 2002:a17:90a:fe5:b0:212:cae0:7482 with SMTP id 92-20020a17090a0fe500b00212cae07482mr14516891pjz.108.1667218073416;
        Mon, 31 Oct 2022 05:07:53 -0700 (PDT)
Received: from bobo.ozlabs.ibm.com (193-116-106-251.tpgi.com.au. [193.116.106.251])
        by smtp.gmail.com with ESMTPSA id p17-20020a170902e75100b0017e64da44c5sm1595134plf.203.2022.10.31.05.07.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 05:07:52 -0700 (PDT)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     linux-modules@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc:     Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Jessica Yu <jeyu@kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH v5 2/2] powerpc/64: Add module check for ELF ABI version
Date:   Mon, 31 Oct 2022 22:07:33 +1000
Message-Id: <20221031120733.3956781-3-npiggin@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221031120733.3956781-1-npiggin@gmail.com>
References: <20221031120733.3956781-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Override the generic module ELF check to provide a check for the ELF ABI
version. This becomes important if we allow big-endian ELF ABI V2 builds
but it doesn't hurt to check now.

Cc: Jessica Yu <jeyu@kernel.org>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
[np: split patch, added changelog, adjust to Jessica's proposal]
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/kernel/module.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/powerpc/kernel/module.c b/arch/powerpc/kernel/module.c
index f6d6ae0a1692..d46bf9bfda26 100644
--- a/arch/powerpc/kernel/module.c
+++ b/arch/powerpc/kernel/module.c
@@ -19,6 +19,23 @@
 
 static LIST_HEAD(module_bug_list);
 
+#ifdef CONFIG_PPC64
+bool module_elf_check_arch(Elf_Ehdr *hdr)
+{
+	unsigned long abi_level = hdr->e_flags & 0x3;
+
+	if (IS_ENABLED(CONFIG_PPC64_ELF_ABI_V2)) {
+		if (abi_level != 2)
+			return false;
+	} else {
+		if (abi_level >= 2)
+			return false;
+	}
+
+	return true;
+}
+#endif
+
 static const Elf_Shdr *find_section(const Elf_Ehdr *hdr,
 				    const Elf_Shdr *sechdrs,
 				    const char *name)
-- 
2.37.2

