Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AB085B4171
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 23:27:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231355AbiIIV1m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 17:27:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230101AbiIIV1i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 17:27:38 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC1E6121692
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 14:27:37 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id r20so1605443qtn.12
        for <linux-kernel@vger.kernel.org>; Fri, 09 Sep 2022 14:27:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=XCqFILlORIl73ysqc0Ul7pNfGlGrUGGUodvmYmFWBzU=;
        b=lQ8xgvfOqQ4TnJL7QZEv/D17SJFXVYCbEbAHGn5JXmt0kRtMdbJu5H6PYqaMZKwXN3
         3SNhslYduiyRqOjjI5jwxyFvWh6It7bHfFqoG5fV8Lqv6TLyDwYZtGuOlZGNo1atkkvS
         dJ8nBFev0T+PPQlQDPiDIXjitTQNXQSW/Jj46ndMAN6k4S5WF4w5Kk2uBTFUC7sVRnZn
         f4S7zUaf1s/6xwZo5ioY8rmG//9E6HY1NDg7gxbRuZv8sbbYxmykU/r9Aao1GvOEBfte
         81kN3EjYob5F4B6/OjArtpYQJfVzT/ipxrczpw4o6SfeQAB+Aps8BE8CFYTt/5p4SYRU
         AhOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=XCqFILlORIl73ysqc0Ul7pNfGlGrUGGUodvmYmFWBzU=;
        b=pBmgEr8CLfvPkhUsXV73xQFQ+X2TJDhOpYfo3e59mDakw+b5q7HuIEtTCwiMb2tuH5
         Sq4ThnP+HYtuafpe++1QSGscRJJ7633Qab5oTJgVg+2n9UjYp3gTmZ7Wn2Z1Ui52vej1
         oY6vhJOt5H7FJeIbLk0/jEzw080LcJxCWynEibnJCeG7NMKbLPjPndGGsVOnj99vV4Na
         1CSScJLR+xCqmov++zCeJWymCLR4IqEM0bUU3q0/NXyHL1Nq9LLvQ5Sf6BPzFZ2PN5M9
         w5Ob3mWLJy4Ao5siW1jElf4GXKSSKse3y2ro9aesh3okXflYW273camkJNe7ybygh9Uf
         ewhA==
X-Gm-Message-State: ACgBeo0yaiyhFR2lG+LCbPT9L098nIvFMzoRlWcmWEbZWCuGuvsg/Ede
        vu4HNdNMR/RyT2EaMI3/NniWrw==
X-Google-Smtp-Source: AA6agR5iBUieo1I964FBEtcDnsH45WXOoVqFhxQhvwNg7+f3V95B56mPBysZmvQjXi9vUg+gS4t8/Q==
X-Received: by 2002:ac8:5710:0:b0:343:5fa9:b707 with SMTP id 16-20020ac85710000000b003435fa9b707mr13796746qtw.192.1662758856892;
        Fri, 09 Sep 2022 14:27:36 -0700 (PDT)
Received: from abrestic-xps.ba.rivosinc.com (pool-71-105-112-35.nycmny.fios.verizon.net. [71.105.112.35])
        by smtp.gmail.com with ESMTPSA id o22-20020ac872d6000000b0034359fc348fsm1085138qtp.73.2022.09.09.14.27.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Sep 2022 14:27:36 -0700 (PDT)
From:   Andrew Bresticker <abrestic@rivosinc.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Celeste Liu <coelacanthus@outlook.com>,
        dram <dramforever@live.com>, Ruizhe Pan <c141028@gmail.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Andrew Bresticker <abrestic@rivosinc.com>,
        Atish Patra <atishp@rivosinc.com>
Subject: [PATCH v3 1/2] riscv: Make VM_WRITE imply VM_READ
Date:   Fri,  9 Sep 2022 17:27:30 -0400
Message-Id: <20220909212731.1373355-1-abrestic@rivosinc.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RISC-V does not presently have write-only mappings as that PTE bit pattern
is considered reserved in the privileged spec, so allow handling of read
faults in VMAs that have VM_WRITE without VM_READ in order to be consistent
with other architectures that have similar limitations.

Reviewed-by: Atish Patra <atishp@rivosinc.com>
Signed-off-by: Andrew Bresticker <abrestic@rivosinc.com>
---
 arch/riscv/mm/fault.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/mm/fault.c b/arch/riscv/mm/fault.c
index f2fbd1400b7c..d86f7cebd4a7 100644
--- a/arch/riscv/mm/fault.c
+++ b/arch/riscv/mm/fault.c
@@ -184,7 +184,8 @@ static inline bool access_error(unsigned long cause, struct vm_area_struct *vma)
 		}
 		break;
 	case EXC_LOAD_PAGE_FAULT:
-		if (!(vma->vm_flags & VM_READ)) {
+		/* Write implies read */
+		if (!(vma->vm_flags & (VM_READ | VM_WRITE))) {
 			return true;
 		}
 		break;
-- 
2.25.1

