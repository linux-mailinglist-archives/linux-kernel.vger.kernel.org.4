Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E5026F3988
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 23:02:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232233AbjEAVCw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 17:02:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229937AbjEAVCs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 17:02:48 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7662B1999
        for <linux-kernel@vger.kernel.org>; Mon,  1 May 2023 14:02:46 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-63b60366047so2106531b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 May 2023 14:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1682974966; x=1685566966;
        h=to:content-transfer-encoding:mime-version:message-id:date:subject
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=u+f9STYpQ3MiLUuobcxB6NiQeu6oLquBuiEqTgiW7nU=;
        b=lBy1tIKVEJ2LC26woBFWq3aTbWu9kIByjssXjub4uONA5jL6a1YtTrEE7NjSLAMyWX
         MWamHpoRE3PUugO94uw7+1taB6gcVdcMcsQF/OHsuVU++5D7D/K+LrQeC0yXlNC38Kwr
         n0qRMYU9ccB4TSr3C+23XpODCmc3FSBgoXmiv+cDx6XG1CX1xqIZAuxHyWsVzGz4Jj84
         CMxaxxXWanxT+4Hs5UbwRF3TWfVKXCOVELJHMQFEogn4RuWLal8y/6UsS7sFrzyaW5jz
         djmjyfP09RL71AwOkUp3xQaAe92cuAnctDgB2F9/QIGcHy9CTQ1syZjVMCgtyqvkIPi0
         5xlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682974966; x=1685566966;
        h=to:content-transfer-encoding:mime-version:message-id:date:subject
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u+f9STYpQ3MiLUuobcxB6NiQeu6oLquBuiEqTgiW7nU=;
        b=lA9Ph7lMurrEsI7d8kyiYRnaQ5LBk7+lrOWw2zWHAdgaVRTcSIbr10jwHoK0aN50c/
         UL5gYmlN6Ojom+IMo2P4x7wL4NxpjYKPT9eNwHC60nMQ1eCMaUhTOiqBTH57Vg32rttU
         JtniyCWHh0W2mkBH6fdPgCptmnEo3mCu8Y2CfisamXWYFJYZQnF8ecuI0ghHGN4XQhaj
         k4gHU+bGVB0qdC96Nno9T18TdByu7jC/Hkqreu/5+3D9pFJVs5fMTM+cQsn2Ad6xWt7O
         y0h4qN628pYoPkZjz4DPOAH7BApwrLF/W+Gkbtbm3HMdqWE5uLkCIQaCScLPOULFmQx9
         /05A==
X-Gm-Message-State: AC+VfDyL/PNKaJ03c/+cBKJcWV8A88j8uAua4+wjXRN/tHZ8G3fY0cCn
        za0R+UADJPM0KjtYIMqUKrwxNSIotfZg18RJSmc=
X-Google-Smtp-Source: ACHHUZ59aSXoviFEB4FBnsHZun5uq6o104ZpmpZfLLV1mJcHU3VtnRTP2MBcZKMAvXC6UNuXFZGI0Q==
X-Received: by 2002:a05:6a00:1ac9:b0:641:558:8e2e with SMTP id f9-20020a056a001ac900b0064105588e2emr20397668pfv.15.1682974965937;
        Mon, 01 May 2023 14:02:45 -0700 (PDT)
Received: from [127.0.1.1] ([2601:1c2:1800:f680:1f1:1360:eb9b:387])
        by smtp.gmail.com with ESMTPSA id i12-20020a056a00224c00b0063d670ad850sm20899151pfu.92.2023.05.01.14.02.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 May 2023 14:02:45 -0700 (PDT)
From:   Drew Fustini <dfustini@baylibre.com>
Subject: [PATCH RFC v2 0/2] RISC-V: Detect Ssqosid extension and handle
 sqoscfg CSR
Date:   Mon, 01 May 2023 14:05:20 -0700
Message-Id: <20230430-riscv-cbqri-rfc-v2-v2-0-8e3725c4a473@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAJApUGQC/2XNQQrCQAyF4auUrA3EaUXqVvAAbsXFTJqx2Yyaw
 CCU3t2pW5c/vI+3gIupOJy6BUyquj5Li7DrgOdYHoI6tYZAoaehJzR1rsjpbYqWGWvARHTMPO3
 HwzBCgym6YLJYeN7ov9hGL5Osn9/zDa6XM9zX9QvLganljgAAAA==
To:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Ved Shanbhogue <ved@rivosinc.com>,
        Atish Patra <atishp@rivosinc.com>,
        =?utf-8?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn@rivosinc.com>,
        James Morse <james.morse@arm.com>,
        =?utf-8?q?Kornel_Dul=C4=99ba?= <mindal@semihalf.com>,
        Adrien Ricciardi <aricciardi@baylibre.com>,
        Drew Fustini <dfustini@baylibre.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1682975186; l=3338;
 i=dfustini@baylibre.com; s=20230430; h=from:subject:message-id;
 bh=WhoQqsgjJdsQj4ZRrkR5sEIpHcYxbO2QvzNxfqfpBDE=;
 b=V29DkhiYqj3tZMXMXV+LYuslsnRGNqE3QVtYjOow8qhlZo6SXlDkOy59pN1/OFwDeCnBwQJVC
 2aY2/Vwj6TzB6yADUhDwOdvof3XwUuQMEcIWhSQ7t/Dg++RQlhct9Fq
X-Developer-Key: i=dfustini@baylibre.com; a=ed25519;
 pk=p3GKE9XFmjhwAayAHG4U108yag7V8xQVd4zJLdW0g7g=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This RFC series adds initial support for the Ssqosid extension and the
sqoscfg CSR as specified in Chapter 2 of the RISC-V Capacity and
Bandwidth Controller QoS Register Interface (CBQRI) specification [1].

QoS (Quality of Service) in this context is concerned with shared
resources on an SoC such as cache capacity and memory bandwidth. Intel
and AMD already have QoS features on x86, and there is an existing user
interface in Linux: the resctrl virtual filesystem [2].

The sqoscfg CSR provides a mechanism by which a software workload (e.g.
a process or a set of processes) can be associated with a resource
control ID (RCID) and a monitoring counter ID (MCID) that accompanies
each request made by the hart to shared resources like cache. CBQRI
defines operations to configure resource usage limits, in the form of
capacity or bandwidth, for an RCID. CBQRI also defines operations to
configure counters to track the resource utilization of an MCID.

The CBQRI spec is still in draft state and is undergoing review [3]. It
is possible there will be changes to the Ssqosid extension and the CBQRI
spec. For example, the CSR address for sqoscfg is not yet finalized.

My goal for this RFC is to determine if the 2nd patch is an acceptable
approach to handling sqoscfg when switching tasks. This RFC was tested
against a QEMU branch that implements the Ssqosid extension [4]. A test
driver [5] was used to set sqoscfg for the current process. This allows
__switch_to_sqoscfg() to be tested without resctrl.

This series is based on riscv/for-next at:

 b09313dd2e72 ("RISC-V: hwprobe: Explicity check for -1 in vdso init")

Changes from v1:
 - change DEFINE_PER_CPU to DECLARE_PER_CPU for cpu_sqoscfg in qos.h to
   prevent linking error about multiple definition. Move DEFINE_PER_CPU
   for cpu_sqoscfg into qos.c
 - renamed qos prefix in function names to sqoscfg to be less generic
 - handle sqoscfg the same way has_vector and has_fpu are handled in the
   vector patch series [6]

[1] https://github.com/riscv-non-isa/riscv-cmqri/blob/main/riscv-cbqri.pdf
[2] https://docs.kernel.org/x86/resctrl.html
[3] https://lists.riscv.org/g/tech-cbqri/message/38
[4] https://gitlab.baylibre.com/baylibre/qemu/-/tree/riscv-cbqri-rfc-v2
[5] https://gitlab.baylibre.com/baylibre/linux/-/tree/riscv-sqoscfg-rfc-v2
[6] https://lore.kernel.org/linux-riscv/20230414155843.12963-1-andy.chiu@sifive.com/

---
Drew Fustini (1):
      RISC-V: Add support for sqoscfg CSR

Kornel Dulęba (1):
      RISC-V: Detect the Ssqosid extension

 arch/riscv/Kconfig                 | 19 +++++++++++++++++
 arch/riscv/include/asm/csr.h       |  8 +++++++
 arch/riscv/include/asm/hwcap.h     |  2 ++
 arch/riscv/include/asm/processor.h |  3 +++
 arch/riscv/include/asm/qos.h       | 43 ++++++++++++++++++++++++++++++++++++++
 arch/riscv/include/asm/switch_to.h |  3 +++
 arch/riscv/kernel/Makefile         |  1 +
 arch/riscv/kernel/cpu.c            |  1 +
 arch/riscv/kernel/cpufeature.c     |  1 +
 arch/riscv/kernel/qos/Makefile     |  2 ++
 arch/riscv/kernel/qos/qos.c        |  5 +++++
 11 files changed, 88 insertions(+)
---
base-commit: b09313dd2e726fe5e1fa574cd73f5e326c6030a4
change-id: 20230430-riscv-cbqri-rfc-v2-b007fcd19549

Best regards,
-- 
Drew Fustini <dfustini@baylibre.com>

