Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B34386BF1EF
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 20:51:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229916AbjCQTvM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 15:51:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230045AbjCQTu6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 15:50:58 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FD904B80A
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 12:50:45 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id s11-20020a056a00194b00b0062586c7a2acso3154925pfk.23
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 12:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679082644;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Hs46drbFrMe/QjYAPPlOzCkDHxFYlL70DArAIx1RmJc=;
        b=NbzXEFw7Mlj4bG6afQF+3r0dWbsMFiy0FIWCXmT4PWOrbAaBFs4dSOoiGx4G2/QmUp
         6LK+WOIw3Oj3qJ/98P0/CktYE42M0MRV7u0l8S5im0o2dTJpUnAzPoIMnygTlLehC4Og
         lnaQvmJweJQ0anq79VVIRDTsyAQF+DqCNkcqI7Q7SH9/Kc6a/RikoLzEkebzV5HAwwED
         7eQllCYhwnjFI1FAuf8UNhgIYi6aYXzVdiVlyxkBustcQRlId1nEmHxCDqQz5TajuCpv
         dC6QH/+odHeEsVw2npt9bKOzTsOIRjtqmuprpIHmFltZXuePIr1qxpy1cpnNxg6BYDd8
         EfTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679082644;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Hs46drbFrMe/QjYAPPlOzCkDHxFYlL70DArAIx1RmJc=;
        b=EFHaFUWUmRKu/ONjhf9DZ+x292EaQs13B5/3LTCYVnMHdQ+0bg2HSHkcxGLOnSUnHX
         DbmKwddf7KktlrJYfXWqstIVzXUaCPOEqLYSyQO90XS9k9JRJ5q2MHzAgVGYFbvwZbj0
         A9qmWxP4zPFKuVJSE/mZ7Irru1f0yWs8/+HpvmK56rhfrL8aVQjaS5Fu2PmLyyhyzmqI
         NPgybcuYUDX1ihZqpLeQChWg1YpX2TRYAjT2TmlszL0qRI+tgO04Klqg3EZ3OmtCSqn6
         wD0+dAVgzAPuRFheeT5ncHD9V22rOxk3VEIdbhxNPlLxwow53eP5BVN7JgSqB87348Nl
         wv6Q==
X-Gm-Message-State: AO0yUKXV3ip7xHUGepE1sayIddT+w8N9dyPdom7w0r3NEH7SH4pCtweo
        vORJpdN9WfVFiPzwvJZE0pVRSAEL6yHBI3o=
X-Google-Smtp-Source: AK7set9trPZL48JvdiXaWxIDMEmwX0ed0iVpM51psO3L38jpxsm3EzslpiM67yKf/3yQSmT+4ZY7JoFNyLb5gsk=
X-Received: from zaidcloud.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5325])
 (user=zalbassam job=sendgmr) by 2002:a17:902:d50b:b0:19f:1dfc:9fd4 with SMTP
 id b11-20020a170902d50b00b0019f1dfc9fd4mr3483383plg.1.1679082644710; Fri, 17
 Mar 2023 12:50:44 -0700 (PDT)
Date:   Fri, 17 Mar 2023 15:50:25 -0400
In-Reply-To: <20230317195027.3746949-1-zalbassam@google.com>
Mime-Version: 1.0
References: <20230317195027.3746949-1-zalbassam@google.com>
X-Mailer: git-send-email 2.40.0.rc2.332.ga46443480c-goog
Message-ID: <20230317195027.3746949-7-zalbassam@google.com>
Subject: [PATCH v4 6/8] ARM: Make CONFIG_CPU_V7 valid for 32bit ARMv8 implementations
From:   Zaid Al-Bassam <zalbassam@google.com>
To:     Jesus Sanchez-Palencia <jesussanp@google.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Oliver Upton <oliver.upton@linux.dev>,
        Zenghui Yu <yuzenghui@huawei.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, kvmarm@lists.linux.dev,
        kvmarm@lists.cs.columbia.edu, f.fainelli@gmail.com
Cc:     Marc Zyngier <marc.zyngier@arm.com>,
        Zaid Al-Bassam <zalbassam@google.com>
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

From: Marc Zyngier <marc.zyngier@arm.com>

ARMv8 is a superset of ARMv7, and all the ARMv8 features are
discoverable with a set of ID registers. It means that we can
use CPU_V7 to guard ARMv8 features at compile time.

This commit simply amends the CPU_V7 configuration symbol comment
to reflect that CPU_V7 also covers ARMv8.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Zaid Al-Bassam <zalbassam@google.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 arch/arm/mm/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
index 8e2d75624f5c..dda78a69efba 100644
--- a/arch/arm/mm/Kconfig
+++ b/arch/arm/mm/Kconfig
@@ -403,7 +403,7 @@ config CPU_V6K
 	select CPU_THUMB_CAPABLE
 	select CPU_TLB_V6 if MMU
 
-# ARMv7
+# ARMv7 and ARMv8 architectures
 config CPU_V7
 	bool
 	select CPU_32v6K
-- 
2.40.0.rc2.332.ga46443480c-goog

