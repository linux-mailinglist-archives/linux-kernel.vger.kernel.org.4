Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F9BE6A1EC0
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 16:42:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbjBXPmn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 10:42:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjBXPml (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 10:42:41 -0500
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A424A66946
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 07:42:40 -0800 (PST)
Received: by mail-qv1-xf2f.google.com with SMTP id nv15so13883676qvb.7
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 07:42:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=H+Vrj8ZblYvvhQ+wd7+MTSBP9bwzX0lugYTvMLGSUfA=;
        b=h8exywIB9dPYm1p0mdDdfd1NHDPTazJ0wNRUhEr0bqEtb6hkH6efnTNR9FS7IE5ap0
         iNbpYbWAA1QqC9BCZYdlw8eulWazdOr63n/uN8mgC0iZCx+gaX+Snxf6Mudd3k5B3xsI
         Tr8cMLYCz0LIkdZtJX7+GuafBz8wmgXgC+WnOZuVnLnv8SBSf/6Dup5znASvp6A2maHt
         HdnR+iB68NBCBlnSVTicvgGAA3nw5mHRvtCpIV7G1BCOE4WYr7I89stu5jCqLam/GqT8
         btayZ4WWA/tj3lSsDkmEDvI8z8z8svJG5E3K4kxUh+juKCyjn1KEslDOK8d0BHXY92Ys
         +j7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H+Vrj8ZblYvvhQ+wd7+MTSBP9bwzX0lugYTvMLGSUfA=;
        b=5QiaMFCFSJe7uIphNRCqOqcs7NcIgQEW5e6jEuqk9ZEsWACHRmLnAD7nPSAHNKliGJ
         73OoIMbtevMDyIiHZcBoaS36bToplfshPZc+H/yYwKWqc5UO3x0ASyZoWjmmxNm+wODe
         Mnt+DYp6YyIB9ugZkel+25qcO6uWg+ZqlgO0AYoqfl6hQRPggOU0rmP1heJ6ag58ktFu
         pWEywgzgBKZPUjV77uu60uWWUgqB6KrcP8U/we3FbaJT7e9pYxkFlzuRlzgjIqVkBfMd
         IkLEsYSnF9JzS7vcPjhNUWaZm3Z/BE418N14ZEdX6YFk7AZFIgKoKZcz70d+DInobZs3
         WVog==
X-Gm-Message-State: AO0yUKVkta723v1I4XrDmEW8ViFEH7u6Hs+kVNnB3XJv2HLht5cdxvdq
        4RhjsUx1mHYOCVXYayF8Dxb2WO3RGQ==
X-Google-Smtp-Source: AK7set/xkCYznXKxqmdca73YBD5vtiZh4kqB2PK0rq01pqrPXvnzpSsjr9LohIqKhMmPGVqG/L17FQ==
X-Received: by 2002:a05:6214:2426:b0:56e:b4e0:1bf3 with SMTP id gy6-20020a056214242600b0056eb4e01bf3mr30765599qvb.18.1677253359155;
        Fri, 24 Feb 2023 07:42:39 -0800 (PST)
Received: from citadel.. (075-129-116-198.res.spectrum.com. [75.129.116.198])
        by smtp.gmail.com with ESMTPSA id e26-20020a05620a015a00b0073b399700adsm1276131qkn.3.2023.02.24.07.42.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Feb 2023 07:42:38 -0800 (PST)
From:   Brian Gerst <brgerst@gmail.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Usama Arif <usama.arif@bytedance.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Brian Gerst <brgerst@gmail.com>
Subject: [PATCH v2 0/5] x86-64: Remove global variables from boot
Date:   Fri, 24 Feb 2023 10:42:30 -0500
Message-Id: <20230224154235.277350-1-brgerst@gmail.com>
X-Mailer: git-send-email 2.39.2
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

This is based on the parallel boot v11 series.

Remove the global variables initial_gs, initial_stack, and
early_gdt_descr from the 64-bit boot code.  The stack, GDT, and GSBASE
can be determined from the CPU number.

v2: - Dropped first two patches which were merged into another patch in
      the parallel boot series.
    - Fixed a compile error in patch 1 found by the kernel test robot.
    - Split out the removal of STARTUP_SECONDARY into a separate patch
      and renumber the remaining flags.

Brian Gerst (5):
  x86/smpboot: Remove initial_stack on 64-bit
  x86/smpboot: Remove early_gdt_descr on 64-bit
  x86/smpboot: Remove initial_gs
  x86/smpboot: Simplify boot CPU setup
  x86/smpboot: Remove STARTUP_SECONDARY

 arch/x86/include/asm/processor.h |  6 +-
 arch/x86/include/asm/realmode.h  |  1 -
 arch/x86/include/asm/smp.h       |  5 +-
 arch/x86/kernel/acpi/sleep.c     |  5 +-
 arch/x86/kernel/head_64.S        | 99 ++++++++++++--------------------
 arch/x86/kernel/smpboot.c        |  6 +-
 arch/x86/xen/xen-head.S          |  2 +-
 7 files changed, 49 insertions(+), 75 deletions(-)

-- 
2.39.2

