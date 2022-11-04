Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72691619FFC
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 19:32:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232124AbiKDScz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 14:32:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231822AbiKDScx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 14:32:53 -0400
Received: from mail-oo1-xc4a.google.com (mail-oo1-xc4a.google.com [IPv6:2607:f8b0:4864:20::c4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A40FE40918
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 11:32:52 -0700 (PDT)
Received: by mail-oo1-xc4a.google.com with SMTP id y19-20020a4a9c13000000b0049dd7ad41c4so1258042ooj.3
        for <linux-kernel@vger.kernel.org>; Fri, 04 Nov 2022 11:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HaGpOzKbqb+MuEAD+NCm71AWMMP+r3ojA1jZHAjkZAM=;
        b=o6dvlt8i0byEkpboksOpR2b168TjLpsrF20fK9SM2inJFKsrbs4NIgCVGfYW48JQB/
         3lBFuxmREbXs4iW0OrQzd11yZRFVyGPKJ8qj/P61Ek2nlDL632CFOZWgCNvPYMqEiwPc
         KQQBW2apdAw6MRmfDBr3WEe4mk0hyAkZ4NvLRndyxKhNnPdm1YpVV0TTJu4of9Jfy5y7
         7BcymffwrqaiNizcvlHHFMlPnlZ7i9H5YOC/Diu3uk7LCCh6P17HsiOWrCo8cxRTUdlk
         L2SXchCf6qggfBHOyomgviqQziB6mznPvl8JXRccb6+g4IAsskLjgJSmJdtKdw2pqLFi
         tW5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HaGpOzKbqb+MuEAD+NCm71AWMMP+r3ojA1jZHAjkZAM=;
        b=XntKfsdAJPcJQu5qNx7DBIlJk4dfoUNpHQdDGuRQGvw2VQA8Nl4zmBDK0m4SdIHxyy
         AZyzUYmtuaZRe19Auu9bNLSGH5Zcw/27dK8oV4/4KpaLlA4rwPKUIkXQnZrjZFG3fEIr
         LKO3fYmzVJcvpziYl9PEdEapRxd/em6n9tjlfrb8x4c6bU/20lMNGAxghSMCYKzfxa8n
         dnbnjP7DrL8No7d8zYAMxxTFNTwRRv7SOkqpS1llBfHHvDusfX9YKfY6o6ShF8KHkCmh
         UETsZ8Qol4ilpsLCiTXlgpqlGYowQb4bLfo7PTeiA0zR+VIg2eyVLroI9MNqEbkNSl4h
         +I/g==
X-Gm-Message-State: ACrzQf3hpgncgFrr6huPQRA8sxduS4d5VqyFwkp/Z6HXePZs27cJxWj/
        ndsEOkeaGviT4eg7NhEiNaQZm/enpxs=
X-Google-Smtp-Source: AMsMyM73XAD3GoKhDyeNLpACwSfvZVkTD2+2X8nTy38nBCtx8xZfFhEfHlAIBszqsNwcbBKTD1hCJti8k9c=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a54:4388:0:b0:35a:3a9a:cf1 with SMTP id
 u8-20020a544388000000b0035a3a9a0cf1mr8905979oiv.158.1667586772072; Fri, 04
 Nov 2022 11:32:52 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri,  4 Nov 2022 18:32:44 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
Message-ID: <20221104183247.834988-1-seanjc@google.com>
Subject: [PATCH 0/3] x86/kasan: Populate shadow for read-only IDT mapping
From:   Sean Christopherson <seanjc@google.com>
To:     Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org
Cc:     Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        "H. Peter Anvin" <hpa@zytor.com>, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org,
        Sean Christopherson <seanjc@google.com>,
        syzbot+8cdd16fd5a6c0565e227@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix a regression introduced by mapping shadows for the per-cpu portions of
the CPU entry area on-demand.  The read-only IDT mapping is also shoved
into the CPU entry area, but since it's shared, no CPU creates a shadow
for it.  KVM on Intel does an IDT lookup in software when handling host
IRQs that arrived in the guest, which results in KASAN dereferencing an
unmapped shadow.

The first two patches are cleanups to make the fix (and code in general)
less ugly.

Side topic, KASAN should really decide whether it wants to use "void *"
or "unsigned long", e.g. kasan_populate_shadow() takes "unsigned long" but
kasan_populate_early_shadow() takes "void *".  And the amount of casting
throughout the code is bonkers.

Sean Christopherson (3):
  x86/kasan: Rename local CPU_ENTRY_AREA variables to shorten names
  x86/kasan: Add helpers to align shadow addresses up and down
  x86/kasan: Populate shadow for shared chunk of the CPU entry area

 arch/x86/mm/kasan_init_64.c | 50 ++++++++++++++++++++++++-------------
 1 file changed, 32 insertions(+), 18 deletions(-)


base-commit: 3301badde43dee7c2a013fbd6479c258366519da
-- 
2.38.1.431.g37b22c650d-goog

