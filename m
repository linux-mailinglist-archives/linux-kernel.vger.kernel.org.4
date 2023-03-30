Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 476166CFDEE
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 10:16:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230368AbjC3IQd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 04:16:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230304AbjC3IQN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 04:16:13 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 915096E90
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 01:16:12 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id mp3-20020a17090b190300b0023fcc8ce113so21178146pjb.4
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 01:16:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1680164172;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=L10x+gjZbBUxwXOMonAltHgEjn5J6xPItrkvXXLM++4=;
        b=UpYLB6W9l88El8IMNzJv2COxBro+vsxq+NdP4fzoPWmQxyXzgyqgJ9f3rF/FdgQQK7
         28132MZi6UY9VRUYcpc/96wjPXoQ0nKj0aJsMMByazZi4lidlKMRpIUHnkY2AUMPrQ0P
         DKepCpUgD/pndT3d8yTNrThsxGmbOEKAoY8jdP5erzCZuJBksBZGvjItsSm9RiRelIS+
         0vSLdtYTkXImNER0vutxlCxFv50yzgNhCo2hEuidPpakx7Dx/Z2n+KhgJd4+JtzddBGE
         yQ4S78s+MHku6GnjQzYcfrdWfjQUHDMh+VW98ldWi9o5D8/6ukqHs6XiFxcI1zLvgyKh
         uKIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680164172;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L10x+gjZbBUxwXOMonAltHgEjn5J6xPItrkvXXLM++4=;
        b=zve9ORgRoVxS+wSKnlibiyVMxwl6lm9BF6sCfUok+FkqwdGkNh10+xNMV3n7GKhcQr
         gPFyh2ax6Mrj6ptDHqKr76Py5Bk+P2nNhC/F6iWUNzZ3W/rlBdXel5ErCHPkFuozVpSL
         QLnN6GX60p58Ja/acJClHgIjQTfjA/N0aCrtnbKbrc+cIr9WbLlVYvQ5e12R/mMqsTVV
         UBBYHzWKn4pGNVrRKO+8pThx/h1H/OR+MrOsVV0OPjJWCF4V6+Jxy7dkARhqhJphfJLc
         7F9N27COxUujeH4mzsYUcvPxLu5hua9sR9xI8eOZ6JA5t86c4gujEuTg/HZJkQ8Z3mS3
         rFMg==
X-Gm-Message-State: AAQBX9f+Z0ssyAOs3LX8WMUmI8+r8AII3WA8eHfgKhkBJv487Rwc/jQ3
        rktgvKS9CUGGnau7BK9PYkr2pw==
X-Google-Smtp-Source: AKy350ahkSNwKWus/wT0n2FZM9Il4SdQimFgBWw+5oril1smind4xGMVDtIMs93dIUUGq31ArLJNSA==
X-Received: by 2002:a17:90a:fd81:b0:240:c0df:64fc with SMTP id cx1-20020a17090afd8100b00240c0df64fcmr1561442pjb.2.1680164171960;
        Thu, 30 Mar 2023 01:16:11 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([139.177.225.245])
        by smtp.gmail.com with ESMTPSA id i13-20020a17090a138d00b0023cd53e7706sm2630837pja.47.2023.03.30.01.16.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 01:16:09 -0700 (PDT)
From:   Qi Zheng <zhengqi.arch@bytedance.com>
To:     peterz@infradead.org, keescook@chromium.org, jpoimboe@kernel.org,
        dave.hansen@linux.intel.com, bp@alien8.de, mingo@redhat.com,
        tglx@linutronix.de, rostedt@goodmis.org
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH 0/2] some fixes and cleanups for x86
Date:   Thu, 30 Mar 2023 16:15:50 +0800
Message-Id: <20230330081552.54178-1-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This series uses arch_stack_walk() to fix false positives of KASAN and
avoid open-coding of unwind logic.

This series is based on next-20230330.

Comments and suggestions are welcome.

Thanks,
Qi

Qi Zheng (2):
  x86: make profile_pc() use arch_stack_walk()
  x86: make __get_wchan() use arch_stack_walk()

 arch/x86/kernel/process.c | 22 ++++++++++++----------
 arch/x86/kernel/time.c    | 36 +++++++++++++++++-------------------
 2 files changed, 29 insertions(+), 29 deletions(-)

-- 
2.20.1

