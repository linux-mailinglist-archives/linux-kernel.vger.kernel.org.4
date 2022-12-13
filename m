Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A885E64AC3C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 01:18:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233747AbiLMASU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 19:18:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234138AbiLMARb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 19:17:31 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2DBE1CB2C
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 16:17:21 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id x79-20020a633152000000b004785d1cf6bbso8490449pgx.6
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 16:17:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=sNSL8jiUwkIgQF+f7LKM6ExXdf/VymBG2POuUwuNLgE=;
        b=X3XOty/l01/xeN/hKkn1EpgJ33YKq3U2qtH9GiJ5/B0nOJ0DB+hLmj4UfSSjeoJtZB
         r3WCB8nZwf1VlN7+893cXq/5kUvyTwTDCZxL2nIPUKLALlzRPBZMfeoH0Ua0SHFxAPI3
         /Uv3ZxCaECDcW2eeqyV8ZVWd1hAjmNuzXaMV7oaRBjF3tNInWHVE7czGbwWdAPA4Hukj
         Vcsk24frgaF7Oql5xOx7BPdx2Nha0adydl6KmebMs/wKPMnAOgI3pEI6XB3jQLbLNFR9
         iwyZylWx8ZK0kgB1K5whCjACIx96wIRJdQeYwYX5foAv7IbCJ4PHaibz2NHGhj7JHDYg
         U68w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sNSL8jiUwkIgQF+f7LKM6ExXdf/VymBG2POuUwuNLgE=;
        b=3wlVJkBeoFNp5/c8TaOBeJKFjd1sUYrDM5R1qWKraU3L6TM56tdKUTesF/nexx7Xe1
         m3MlTfMuuGdDZnFDbbYfrDMuyua4C0ogSTTiGkATwAFsqcOP04Yi3UR1tOw+o27t/0eR
         IhiJuxnlY70kX/eSgSYNOEvmDZB9fRPjPEwnqbh/636XuqyVyIiJSEBnDDCncG8ehTXS
         qfkaS2I/hNqS9Hiqqk3ylBQN/4mREIyIjRj6/ULIXD9jRXuiM3xo3kLh9eXN56IwNYwY
         ajR0lVeVgOA5b+lgUmBP5Fsws7eSO/h3EGsxyanLa7/bvrXqgFngM4VjCxMai9Tnj4qG
         DWmw==
X-Gm-Message-State: ANoB5pmnWoza4++o75WeddvpOYfHxBhJt+HK+ZMokZnWpaq2/pa2+qrt
        qyOwtECJ4mdauHW6B8xB6lh62O9XJzg=
X-Google-Smtp-Source: AA0mqf6O/+6Xz33uYXNagfPhZfGdLb4gsoDNpenMWb9N8M3Pf/4lwZ6k3UWvF8FLs6w60jREU9TzRW9INS4=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:1d98:b0:578:2fb3:b373 with SMTP id
 z24-20020a056a001d9800b005782fb3b373mr577725pfw.33.1670890641355; Mon, 12 Dec
 2022 16:17:21 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Tue, 13 Dec 2022 00:16:53 +0000
In-Reply-To: <20221213001653.3852042-1-seanjc@google.com>
Mime-Version: 1.0
References: <20221213001653.3852042-1-seanjc@google.com>
X-Mailer: git-send-email 2.39.0.rc1.256.g54fd8350bd-goog
Message-ID: <20221213001653.3852042-15-seanjc@google.com>
Subject: [PATCH 14/14] KVM: selftests: Enable RSEQ test for RISC-V
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>, Marc Zyngier <maz@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Cc:     James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Oliver Upton <oliver.upton@linux.dev>,
        Tom Rix <trix@redhat.com>, kvm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        kvmarm@lists.cs.columbia.edu, linux-riscv@lists.infradead.org,
        llvm@lists.linux.dev, linux-kernel@vger.kernel.org,
        Ricardo Koller <ricarkol@google.com>,
        Sean Christopherson <seanjc@google.com>,
        Aaron Lewis <aaronlewis@google.com>,
        Raghavendra Rao Ananta <rananta@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable the RSEQ test for RISC-V, which according to HAVE_RSEQ is supported
by the kernel and thus should be tested.  The RSEQ test was added shortly
before RISC-V selftests support landed, i.e. was likely overlooked during
merging.

Note, the RSEQ test currently doesn't compile with clang due to an issue
in the base RSEQ test code.  Given that clang is constantly broken for KVM
selftests, enable the RSEQ test and deal with its broken clang state in a
separate commit/series.

  In file included from rseq_test.c:23:
  In file included from ./../rseq/rseq.c:33:
  In file included from ../rseq/rseq.h:97:
  ../rseq/rseq-riscv.h:657:17: error: invalid input constraint 'er' in asm
                                      [off]                       "er" (off),
                                                                ^

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/rseq_test.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/testing/selftests/kvm/rseq_test.c b/tools/testing/selftests/kvm/rseq_test.c
index 34c3df9b4e81..3045fdf9bdf5 100644
--- a/tools/testing/selftests/kvm/rseq_test.c
+++ b/tools/testing/selftests/kvm/rseq_test.c
@@ -22,8 +22,6 @@
 
 #include "../rseq/rseq.c"
 
-TEST_UNSUPPORTED(riscv);
-
 /*
  * Any bug related to task migration is likely to be timing-dependent; perform
  * a large number of migrations to reduce the odds of a false negative.
-- 
2.39.0.rc1.256.g54fd8350bd-goog

