Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B522746C01
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 10:34:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231461AbjGDIeF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 04:34:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231302AbjGDId0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 04:33:26 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6009103
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 01:33:25 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-bd69bb4507eso5862900276.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jul 2023 01:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688459605; x=1691051605;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XVkd4cyQLWDf2E362B18316LtEkn6UqXDQHGouC2YB8=;
        b=ggAW5pd+r5/XYrv/C/TzGKdzuALknUAAPHMinCALJV29T3YWjgym/PJ6LxIA0jBH+6
         I2K25PBl1KbaATpZ/yPhCehWZ+L9CwATVfX1FAZbi73PrEFMrFZ57LxdoWYJaHv/jZpu
         Nw/6yhxKYPKfGbMmEfgzUF2WLfkMUi6Y/2ZKOidVmpLiMQpZX0bi5jANB6Is1WckLBjR
         7LgsAnKp00SK8YeWhz0KpV2F2y1MTvapNzN+ge7bUHznWhBi/5HQCNXmKJ+AkSWe55x0
         h92kkXR1WthMhkFZnS71fM/aRjKuzIWPMrZ3KDYIh4qu5kByOMjWyHQ7HmgUfuaZk+vs
         OMZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688459605; x=1691051605;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XVkd4cyQLWDf2E362B18316LtEkn6UqXDQHGouC2YB8=;
        b=XbJQODQHenrGFDHcuOliNzEu99HZRiZ/UAOrrZegJsKdMETmR9nPNLrHkh8xdMl0b+
         BZNkQuFCJW4yiKWspqdJvYM9/6BKHij9oPgou0h+eb2VF8JlXIH+a/lQokVCUUvaKRgA
         NGc5lUDJM8EFjApZMTo8aPHNw/7VxezgUuxNnj7MRVIFc4mXGUI3OThGK0Qts5tkhqDs
         z0w3FvfDS71A9OL2848vRKNs2pLYuTidpe/sJCjmbbflnidpOe07gX7OGlQLZHY5Z5Js
         3A8SVZGz2Tjf9r9JMZSYD71/n21KdO0vVdlOlexQ9jUQW9qj7bY882dNOs5fvubMFqbO
         NffA==
X-Gm-Message-State: ABy/qLZSWZ9nTW+MsxJVm7SbWPmcuIDyTbADmMhNH1dPS+j68f1BZXXC
        oylbx1U7PUCurz+W6w2/SzT7GDIzMB4i2w==
X-Google-Smtp-Source: APBJJlF6P+ZdofyEPFyyqmKk/LKUK7OK7HJoHWrUEs8FIwrcXzjDRUPe2+jF9uyubtP87elUnizqFZtfEXbc0g==
X-Received: from slicestar.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:20a1])
 (user=davidgow job=sendgmr) by 2002:a25:ab54:0:b0:c00:3434:f639 with SMTP id
 u78-20020a25ab54000000b00c003434f639mr93671ybi.1.1688459604952; Tue, 04 Jul
 2023 01:33:24 -0700 (PDT)
Date:   Tue,  4 Jul 2023 16:32:07 +0800
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
Message-ID: <20230704083206.693155-2-davidgow@google.com>
Subject: [PATCH] x86: checksum: Fix unaligned checksums on < i686
From:   David Gow <davidgow@google.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Noah Goldstein <goldstein.w.n@gmail.com>
Cc:     x86@kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Gow <davidgow@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The checksum_32 code was originally written to only handle 2-byte
aligned buffers, but was later extended to support arbitrary alignment.
However, the non-PPro variant doesn't apply the carry before jumping to
the 2- or 4-byte aligned versions, which clear CF.

This causes the new checksum_kunit test to fail, as it runs with a large
number of different possible alignments and both with and without
carries.

For example:
./tools/testing/kunit/kunit.py run --arch i386 --kconfig_add CONFIG_M486=y checksum
Gives:
    KTAP version 1
    # Subtest: checksum
    1..3
    ok 1 test_csum_fixed_random_inputs
    # test_csum_all_carry_inputs: ASSERTION FAILED at lib/checksum_kunit.c:267
    Expected result == expec, but
        result == 65281 (0xff01)
        expec == 65280 (0xff00)
    not ok 2 test_csum_all_carry_inputs
    # test_csum_no_carry_inputs: ASSERTION FAILED at lib/checksum_kunit.c:314
    Expected result == expec, but
        result == 65535 (0xffff)
        expec == 65534 (0xfffe)
    not ok 3 test_csum_no_carry_inputs

With this patch, it passes.
    KTAP version 1
    # Subtest: checksum
    1..3
    ok 1 test_csum_fixed_random_inputs
    ok 2 test_csum_all_carry_inputs
    ok 3 test_csum_no_carry_inputs

I also tested it on a real 486DX2, with the same results.

Signed-off-by: David Gow <davidgow@google.com>
---

This is a follow-up to the UML patch to use the common 32-bit x86
checksum implementations:
https://lore.kernel.org/linux-um/20230704083022.692368-2-davidgow@google.com/

---
 arch/x86/lib/checksum_32.S | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/lib/checksum_32.S b/arch/x86/lib/checksum_32.S
index 23318c338db0..128287cea42d 100644
--- a/arch/x86/lib/checksum_32.S
+++ b/arch/x86/lib/checksum_32.S
@@ -62,6 +62,7 @@ SYM_FUNC_START(csum_partial)
 	jl 8f
 	movzbl (%esi), %ebx
 	adcl %ebx, %eax
+	adcl $0, %eax
 	roll $8, %eax
 	inc %esi
 	testl $2, %esi
-- 
2.41.0.255.g8b1d071c50-goog

