Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 802D864689E
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 06:37:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbiLHFg6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 00:36:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbiLHFg5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 00:36:57 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 775916DCEA
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 21:36:56 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-3d0465d32deso3304047b3.20
        for <linux-kernel@vger.kernel.org>; Wed, 07 Dec 2022 21:36:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=aFPe+UaD50XmRyvV+9N8/5Pjm4UIlo/mfvRAp67LmRs=;
        b=b9vlBISV2U6xtyPqG6iizPpwZ1rCcvWaHUFLIXIpmxXBSmfaQm7mDS/yiuM2z9eDsf
         hgonrPVAZ+xEbAlFkOEwA7Ua7p6/SbxlAbQj7D5Ghco2U+pP6gS4NLI5MTnYjJg5D8es
         YMMZIi/ur4FRZyHVnYFbJKXlvaoF00TXZkvQLVRdwZViDRiLXlPRYDHc4ycf+KG8qLn3
         ubjrahAFyA3Q/mX6wwqqAEipM1BAwWzjagMBXyoVihDiVC9OGkBbi3EJCY4xKTOK130y
         WwqMy+l6Tl+eTbqHSS71GnF2YPnxmshdmVVccO0/oJYn7173JH7YVN2F8byrT86AlF7m
         EmEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aFPe+UaD50XmRyvV+9N8/5Pjm4UIlo/mfvRAp67LmRs=;
        b=RIG/Xk/XXXknfdF4hkwdln9BEULfcJfeTLbm3N1nnTocNNJQcpuYPg5wr34sw6Q2s0
         3Dxs8mI7+B60WRhEMKw4Q/nWm05uMhDhKdmOl0rwBMif5KrgDv9e+Sil4a3uYLPG2wB/
         68dzkMZGMWilZrwyF6y9eTCKhQ/TOT6oNI914UNJgI0suBsFCEHEFSkqFHlv4s8j5FWM
         KS7Ec4R+8Cc+y1tPBEd3IqvOlqsxYPGY7T3i79FAOXgt4l/uQVdF4zGTjR3s6Qicyv5Q
         H4yaXvmCEaWhKoBa6gvhnVFYn3JQFc4F1nzwrSoRUk9tIE47+o2RPZNDvpIK7rsYowW+
         JcLA==
X-Gm-Message-State: ANoB5pkEZYLLQO4jrSrCP1yxYk9BanRxGOLvlKT7XaAhCRWOQ41x9b0R
        51bEfSJMY27VfbJX+aAnvWm9Gsd1P73pQq861w==
X-Google-Smtp-Source: AA0mqf5vuaRpDMVUisiO7EdXWObW5xbPD+OIV/eZKRvS6jn5hLBCvVd5DdDyo4CEGmBBkGoGWRaYw9UBV2kklynOfg==
X-Received: from almasrymina.svl.corp.google.com ([2620:15c:2d4:203:3dc:88c1:734b:ca2e])
 (user=almasrymina job=sendgmr) by 2002:a25:ac8:0:b0:6fa:678a:7623 with SMTP
 id 191-20020a250ac8000000b006fa678a7623mr31338358ybk.577.1670477815589; Wed,
 07 Dec 2022 21:36:55 -0800 (PST)
Date:   Wed,  7 Dec 2022 21:36:48 -0800
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.0.rc0.267.gcb52ba06e7-goog
Message-ID: <20221208053649.540891-1-almasrymina@google.com>
Subject: [PATCH v1] arch: Enable function alignment for arm64
From:   Mina Almasry <almasrymina@google.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Mina Almasry <almasrymina@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
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

We recently ran into a double-digit percentage hackbench regression
when backporting commit 12df140f0bdf ("mm,hugetlb: take hugetlb_lock
before decrementing h->resv_huge_pages") to an older kernel. This was
surprising since hackbench does use hugetlb pages at all and the
modified code is not invoked. After some debugging we found that the
regression can be fixed by back-porting commit d49a0626216b ("arch:
Introduce CONFIG_FUNCTION_ALIGNMENT") and enabling function alignment
for arm64. I suggest enabling it by default for arm64 if possible.

Tested by examing function alignment on a compiled object file
before/after:

After this patch:

$ ~/is-aligned.sh mm/hugetlb.o 16
file=mm/hugetlb.o, alignment=16
total number of functions: 146
total number of unaligned: 0

Before this patch:

$ ~/is-aligned.sh mm/hugetlb.o 16
file=mm/hugetlb.o, alignment=16
total number of functions: 146
total number of unaligned: 94

Cc: Peter Zijlstra <peterz@infradead.org>
---
 arch/arm64/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index cf6d1cd8b6dc..bcc9e1578937 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -235,6 +235,7 @@ config ARM64
 	select TRACE_IRQFLAGS_SUPPORT
 	select TRACE_IRQFLAGS_NMI_SUPPORT
 	select HAVE_SOFTIRQ_ON_OWN_STACK
+	select FUNCTION_ALIGNMENT_16B
 	help
 	  ARM 64-bit (AArch64) Linux support.

--
2.39.0.rc0.267.gcb52ba06e7-goog
