Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FC83668747
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 23:51:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240596AbjALWuJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 17:50:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240157AbjALWtw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 17:49:52 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3758E5C92D
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 14:49:52 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-4b34cf67fb6so207825017b3.6
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 14:49:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=k1JPjbOQ3twwCwVlAFBMY3qVvPpY8UbYSrJ/ZH6BzqQ=;
        b=C+6arahpXofsQ4/5TXoa5s3dPh2/+h8+T6vNr8Xm5Jzn0MJecvYKer2be4zi2BsNve
         JNselWBnbBC2Yu/KP5VtuxgjMhAKTon4iLNvFm1eT394OkJVIk1JADYH4isIkJJQp/8T
         2zd0rr+pPM4ZkdrjTEEqcR3XhFVlLAnQrpHO8lHul3nEVnyINw44zayX3Si6aU4UGNg9
         l04lOd8ptfdISM/pmHbTFbGnTM2UGvY8qQBcUo98YoSt7MdmGRHknYOGUhtnsbKKSw9m
         rpWntd0bbcM6dihybhM9aDSCiXv5ulT3gjPJvSKpwqa8aCs3J3ZBVTojp2FCBoomNZgL
         IRkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=k1JPjbOQ3twwCwVlAFBMY3qVvPpY8UbYSrJ/ZH6BzqQ=;
        b=XgxewQGWk7ki+FGCVgjoqXtL4Bfsr5As6KlWmupetuBsTKASUtnRp+o60bOCfnGYXP
         GWEWFpGSZEy/ja/lh+RkpuvFxm6Y4Blc7gHqF+c8Fba1ssyp+GlGUwYP/5xKunANpWqW
         qZn/gqR1QuX/wg7sHlTgWl2YITt9D1yOoZjpy6C0ncyd5PrqzApkTjXnsRw7LL8+g+lD
         Xk6LP9DhaDtAD9AViPp76VgbR2e6jdZWrxO5Zu1tQ8aUv9iD7iRfdUMXcQ3h7xizsEvG
         EUpu9yN0mjc7VZRr6WP5dqA1GVMwwu2IFmb6nItH4PYHV8KNHyIdwnUUoizFupbOvJSc
         /wmw==
X-Gm-Message-State: AFqh2kq6NvBTjlrnxGP3pWit+hVLZRiSxGwQOLf1gzEw+OmumVh3varr
        4s6eJb51pzChDnmAZJrcLPwOWExe/+Q22JxRbTA=
X-Google-Smtp-Source: AMrXdXuAS6TrhA/thn+Y88sZDTak+5v33qq9KMGKa2v/rKCpkx1Gac8Y4xEDv2MpYAI/XqvE328cUwFnFiyqV12HiaY=
X-Received: from samitolvanen.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:4f92])
 (user=samitolvanen job=sendgmr) by 2002:a05:690c:291:b0:498:693d:c342 with
 SMTP id bf17-20020a05690c029100b00498693dc342mr5155044ywb.468.1673563791533;
 Thu, 12 Jan 2023 14:49:51 -0800 (PST)
Date:   Thu, 12 Jan 2023 22:49:47 +0000
Mime-Version: 1.0
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=759; i=samitolvanen@google.com;
 h=from:subject; bh=FjTRhLA9CePRZYIdtY20ypwiouGtoz1QdaFB6TOg7Dk=;
 b=owEB7QES/pANAwAKAUy19oSLvFbuAcsmYgBjwI6MpoLvqaH1V7mD24emzCXHeOJafLjsjoDYdvtk
 w53TaaCJAbMEAAEKAB0WIQQ1zPtjsoPW0663g5RMtfaEi7xW7gUCY8COjAAKCRBMtfaEi7xW7j6mDA
 CpsD+W/2uCHxg43p5GFPtc6hB7gf2sNnjbX2olMo/N1oymT0eWYLML9jzn/VYWqCKq5EgkFErYf2cJ
 kjcO5VHj8yDo0bmAbyRJTbkkxP1zJNSRk98PeKc/ZkxFrVRYNuFODO3VXj1qPP8zSNeheAkgh2z2+I
 od+5+9Zl2dYE9QJZNb50qmsrGMUFjkmo2xXw/xp/4I/5h1QUIcupcspXeIbgRQAuRjx+lQXatiAKcA
 WZoMscSUh7J4ZzMlF/kFjS5RTHgc7atL++s1AyCTo4/6dD8GgOKpwKJQ66cA7LnPDJP98uRNuCZDxG
 qjuWdF3l+PPSVqDsRQjW71TZy8EWOXA7Td8Zz3fR2voTPwi2MFd+dksta3smkfsnZKepdnbZOL6QpB
 Bq5GXapBR/RDT9PRHan5wSAUi/h8xvbf+flIPBwBTAmISxC6zMo/WRNO86IrFjiTMkwipFcDrVxGhC
 Tfm0sg22++c5k0aBWdP+8uheSiAG1Wxo6KKZD80bSd+3A=
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20230112224948.1479453-1-samitolvanen@google.com>
Subject: [PATCH 0/1] Fix CFI hash randomization with KASAN
From:   Sami Tolvanen <samitolvanen@google.com>
To:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Masahiro Yamada <masahiroy@kernel.org>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kees Cook <keescook@chromium.org>,
        linux-kbuild@vger.kernel.org, llvm@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Sami Tolvanen <samitolvanen@google.com>
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

Peter, Masahiro,

I noticed that KASAN+CFI fails to boot on x86_64 without
cfi=norand. The randomization code is missing a couple of KASAN
constructors in object files that are not part of vmlinux.o. This
happens because we don't run objtool for the files, which means
the type hashes are not included in the .cfi_sites section.

This patch simply disables KASAN for these files, which seems
reasonable to me and fixes the boot issue, but perhaps you have
better ideas?

Sami


Sami Tolvanen (1):
  kbuild: Fix CFI hash randomization with KASAN

 init/Makefile            | 1 +
 scripts/Makefile.vmlinux | 1 +
 2 files changed, 2 insertions(+)


base-commit: c757fc92a3f73734872c7793b97f06434773d65d
-- 
2.39.0.314.g84b9a713c41-goog

