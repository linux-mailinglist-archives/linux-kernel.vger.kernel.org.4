Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA05173A089
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 14:08:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230050AbjFVMIN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 08:08:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229718AbjFVMIL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 08:08:11 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF57A1731
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 05:08:09 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id 46e09a7af769-6b5d5e6b086so376157a34.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 05:08:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687435688; x=1690027688;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LWa68tYrGcCIa4PH1f5HyDq5yUUyzbHX4FuidyoLLdg=;
        b=Wj9biUC6F3xIauOs/udENeVtN3ReOt/xlt75pp1FHoixHWi4TIn2Tf5X9Pcig6xtdK
         lDgyofZaZ30tSAVxg1yMe1Cv+telZoZjyvJV2EhPDXUt4/4ekX0+Xqa7Mc65DVT1SuQJ
         9AQbCgEa/TriCWs/cvBTA04hBj8rxEZwBHxTC8mpafV/ljnhbgjqfuilA4cbK+y/f4C8
         jaS/EyYEmTSObK3emoQzhESKgQjW0YnkwrdY0iCSliDk6YO5d3QGG2U43eEnKyZoWKrw
         9Et26iTN2zzyylmi3rrm8kJB+juF+noYx11PnvoLKWED1LyX81XLn1i4P2GBWu7yRmIc
         xiaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687435688; x=1690027688;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LWa68tYrGcCIa4PH1f5HyDq5yUUyzbHX4FuidyoLLdg=;
        b=Yi6p6G5vbFTpL6zSvTeiv8tijJQi34ZDVPjv6zQ7bPCND3U8xFYqVqvPmm+hlcs+Ia
         A6IMLmmNCw9OLpJ8nIS1umocsBIHjkvivxweG/HjgxqGLLlndhZxqIBnU5TmPLzFOkdu
         JMA2d9eLdA4QYWgk3zIxRjJXRoTkPVNDa+df0QuxyhmG4d2N0nl35TstZ9YOEAT0SFfR
         Fy9dXOoFJS0HYzY+qUA0SBa/rE2/KJMjA5rzeBYCfFGdILD5TMvjAPHO/beBoyLsB7NB
         FI6usw2A1Cu5e/Y47gVHdXTavAEJOJmfGgRXFiMy2WE850PalNEzaPFYQ2Bud+Vr0ddj
         uQjg==
X-Gm-Message-State: AC+VfDw4/tjT0SKerGPF3KTsHhdJHSk6bHqNW2ZyRIVgY8tOvMAX6z3u
        PFI2FhEZ7amGvvIEmWcWTKrio6HRAw==
X-Google-Smtp-Source: ACHHUZ7FiqBHDu9aDCmXeIOoeyZAZAbGO+lae4KwIvqrCJ/O56jrbmfR4N9Vukffrut+6vWxEcr6SA==
X-Received: by 2002:a05:6830:4623:b0:6b7:1240:4511 with SMTP id ba35-20020a056830462300b006b712404511mr411060otb.0.1687435688054;
        Thu, 22 Jun 2023 05:08:08 -0700 (PDT)
Received: from citadel.. (047-026-243-217.res.spectrum.com. [47.26.243.217])
        by smtp.gmail.com with ESMTPSA id m2-20020a4ae842000000b0054f85f67f31sm2705773oom.46.2023.06.22.05.08.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 05:08:07 -0700 (PDT)
From:   Brian Gerst <brgerst@gmail.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        alyssa.milburn@linux.intel.com, keescook@chromium.org,
        jpoimboe@kernel.org, joao@overdrivepizza.com,
        tim.c.chen@linux.intel.com, Brian Gerst <brgerst@gmail.com>
Subject: [PATCH 0/2] x86: Rewrite ret_from_fork() in C
Date:   Thu, 22 Jun 2023 08:07:48 -0400
Message-ID: <20230622120750.5549-1-brgerst@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When kCFI is enabled, special handling is needed for the indirect call
to the kernel thread function.  Handling this in pure assembly is not
simple, so moving it to C is more appropriate.  Instead of moving just
the indirect call to C as Peter Zijlstra has proposed, this patchset
rewrites the whole ret_from_fork() function in C (other than some
necessary asm glue remaning).

Brian Gerst (2):
  x86/32: Remove schedule_tail_wrapper()
  x86: Rewrite ret_from_fork() in C

 arch/x86/entry/entry_32.S        | 54 ++++++++------------------------
 arch/x86/entry/entry_64.S        | 35 ++++++---------------
 arch/x86/include/asm/switch_to.h |  4 ++-
 arch/x86/kernel/process.c        | 22 ++++++++++++-
 4 files changed, 47 insertions(+), 68 deletions(-)

-- 
2.41.0

