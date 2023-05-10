Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 793E56FD799
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 08:57:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236259AbjEJG5i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 02:57:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236234AbjEJG5d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 02:57:33 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C23D9468B;
        Tue,  9 May 2023 23:57:23 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-94a342f7c4cso1206586866b.0;
        Tue, 09 May 2023 23:57:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683701842; x=1686293842;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vveK2ZwEVP6pIOwJJqSfnIDQO+L04gtFlGwkKv3HOX4=;
        b=WOnJQCV4C9rm1yHcjMg2k85HEGI2F5xrOSYAxeIgBWWP4Y24mRXF1hA0ZLHCs55ZUR
         kw5XSxZGgBIUIRqxyaLdgBsOqhaQk7AOnR/GODpwhZgWhAvpiZRcH0r5UD4DSbDuRPAz
         MyiBrP7Jv4NKKDL89iKncAKpXeV6LaeAbzWshewZb+ijOTSDXOEpIc7JR7gPvfcoGD5U
         ag2G/IyFBCSvgNY6AXT129B0vXhw0EiH6buG4GOvFkG6OvA+CN8UzzOVQVkITeYkaGzV
         fQZyvY52OCe4DOkzYN9VdpR5l11gmZnkbtjLorxmrQr/lzdFdWn+i7NPqtp6h9Ipgl8J
         OF8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683701842; x=1686293842;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vveK2ZwEVP6pIOwJJqSfnIDQO+L04gtFlGwkKv3HOX4=;
        b=YIlPbTvbdTbmCK3h+r3+L5WvBdtsmIrDD2Ucje9JENUqm0UNm2243WDwS38KRKPnmL
         YIA1rwMUpbF1FKIpEoh8dwjjvEx5ib6v2FWmNU3iYLe1Dki4XlIjQA466VEk9QR9wGcY
         xEoKKf53eX1Z+ZvDo92dY/nWckxQeyDr/ELrhH5diE5KlcUoeu3KMgTYdOfhokPBLpBt
         /FaCyJRXZGqJ/Pt15M/j7QBd89k+VuOhs9wTvOB6GTk3XlPQ9uxVNI5yIqX0dy9KZgLT
         6n1QPqtw1b1zqFzPOw9caUSQMmZKBIMQnONULgGdzsU14R+IiuAEY57NiD47NxKHxzKg
         h6qA==
X-Gm-Message-State: AC+VfDz2h+JrVFrYR1moK0KAiz/Zt3VWOYDmFCDUIzkcYBbtezHyortb
        23qdxb2AHcjdjFevTUb1mzM=
X-Google-Smtp-Source: ACHHUZ7VKBCNZs8J8BL8xMiNZv7WhsIIUlyHFodS6SFnLKpsQrDV6M/Jk8ReZwf+4TQsPTykPlmAKg==
X-Received: by 2002:a17:907:8a29:b0:965:f8b7:b0cd with SMTP id sc41-20020a1709078a2900b00965f8b7b0cdmr19409283ejc.25.1683701841954;
        Tue, 09 May 2023 23:57:21 -0700 (PDT)
Received: from felia.fritz.box ([2a02:810d:7e40:14b0:81b:847c:e4fd:f042])
        by smtp.gmail.com with ESMTPSA id ka11-20020a170907990b00b0096602a5ab25sm2274018ejc.92.2023.05.09.23.57.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 May 2023 23:57:21 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH 0/2] Reworking configurability of X86_FEATURE_NAMES
Date:   Wed, 10 May 2023 08:57:11 +0200
Message-Id: <20230510065713.10996-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Dave, dear Boris, dear x86 maintainers,


as follow-up to the discussion on my initial patch on changing the
visibility of X86_FEATURE_NAMES (see Link), here are two patches:

Patch 1 simply makes the minimal one-line change to make X86_FEATURE_NAMES
disappear from the prompt.

Patch 2 is the more radical change to remove the whole config and see which
code would generally be impacted; just as quick exploration.

The diffstat shows we are getting rid of a bit of code throughout arch/x86,
but the change and reduction is not too complex either:

 arch/x86/Kconfig                  | 12 ------------
 arch/x86/Kconfig.cpu              |  2 +-
 arch/x86/boot/Makefile            |  2 --
 arch/x86/boot/cpu.c               | 13 -------------
 arch/x86/include/asm/cpufeature.h |  5 -----
 arch/x86/kernel/cpu/Makefile      |  4 +---
 arch/x86/kernel/cpu/common.c      |  4 ----
 7 files changed, 2 insertions(+), 40 deletions(-)

Probably, you just want to pick patch 1 and wait for any complaints. Or if
you are confident the compliants will not show up, simply apply both.

Otherwise, I will put it on my list to come back in a year or two, and if
there were no complaints till then, provide the updated patch to remove the
X86_FEATURE_NAMES config then.

Link: https://lore.kernel.org/all/20230509084007.24373-1-lukas.bulwahn@gmail.com/

Best regards,

Lukas


Lukas Bulwahn (2):
  x86: make X86_FEATURE_NAMES non-configurable in prompt
  x86: always build with X86_FEATURE_NAMES functionality

 arch/x86/Kconfig                  | 12 ------------
 arch/x86/Kconfig.cpu              |  2 +-
 arch/x86/boot/Makefile            |  2 --
 arch/x86/boot/cpu.c               | 13 -------------
 arch/x86/include/asm/cpufeature.h |  5 -----
 arch/x86/kernel/cpu/Makefile      |  4 +---
 arch/x86/kernel/cpu/common.c      |  4 ----
 7 files changed, 2 insertions(+), 40 deletions(-)

-- 
2.17.1

