Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01D646923BE
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 17:55:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232760AbjBJQzm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 11:55:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232937AbjBJQz1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 11:55:27 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB40579B02
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 08:55:26 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id y192-20020a2532c9000000b008ec2e7092d6so2511840yby.5
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 08:55:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=EO6j55oy/7Ai9ABZKCWhv0W9Kemf/0xaKUwrsinlv10=;
        b=pmg8YuVuutfwzk67a6fQ0thz/qO1HJ+AiUNB8ypdHPX3sPaYKhE+A4EISldV27ciY1
         Y7reHJNL+7uHbu35hXy/I9PemRIyodRKwdmcQEFKvankBQjwaBXw4VDHV+jQlSb5LafG
         rkx2BUzCminsA5HZQMxh7EMMoG3hPh20I3XxYVzKMcrjLB96sHySriCB54E3vU2+HuVS
         bMG5ycpz4mF7kuLAfLQTEgoTmEPIUx1RqTCd2Mmaygc6qTlvyO5VufPYiUKCFkzrjzgN
         r4MR++CUiNJiuqFFvkJQBjXqPNtRqMxoBswFpox3JuuHEfGvSBra5vH2tMOZf2z3+pNN
         zI+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EO6j55oy/7Ai9ABZKCWhv0W9Kemf/0xaKUwrsinlv10=;
        b=P8VEl1vPnwy1uxGeVXIJASJZQMx+k9CXVHW/01Dr3a8y4JVLHqV1cdiez+n00kPA7/
         v5hr1vNRX8LBioeOoS4Bl4n4Ee5DDpedkT5FN+hbWwaMSQX0EW+R5hD6G3zVc7LTLxMn
         OjEQPVlNIhr3q3SH9JQ9ZQthpPa98v4l1+AIZpBiX/NgTPSqN3G/zLenHEeMNdC/8PhK
         0t3FA3YGRR/Ps9d5nIADlLdXJMNaURRqzLSRXIhMwxNwsHHheyri7LPH9fyv6CWhs69k
         O+TCHCRzj7di+gM/+ISmqcMMSHYMJWxqhU3o4L71SPUgIn8FlNrN/GeYInIN+RxksilF
         0n5w==
X-Gm-Message-State: AO0yUKVutxup+jHs7GtNCdcRMqmDlzUAyF+nSJkIqs6mXnPA+GGm6i5p
        tNgEG5LVJvetCN96RDioCH63iYzR4zYzFTc=
X-Google-Smtp-Source: AK7set9S/i/zSZYwD8sZLxL0uhpI93QJizSijAGISTAM9LeCfv59AIMQxCXfhWUDZ04AgqxYON6CtRVYX0VEe0Q=
X-Received: from zaidcloud.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5325])
 (user=zalbassam job=sendgmr) by 2002:a5b:1c3:0:b0:80b:72cc:3967 with SMTP id
 f3-20020a5b01c3000000b0080b72cc3967mr1793786ybp.123.1676048125892; Fri, 10
 Feb 2023 08:55:25 -0800 (PST)
Date:   Fri, 10 Feb 2023 11:54:58 -0500
In-Reply-To: <20230210165500.2292608-1-zalbassam@google.com>
Mime-Version: 1.0
References: <20230210165500.2292608-1-zalbassam@google.com>
X-Mailer: git-send-email 2.39.1.581.gbfd45094c4-goog
Message-ID: <20230210165500.2292608-7-zalbassam@google.com>
Subject: [PATCH v2 6/8] ARM: Make CONFIG_CPU_V7 valid for 32bit ARMv8 implementations
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
        kvmarm@lists.cs.columbia.edu
Cc:     Marc Zyngier <marc.zyngier@arm.com>,
        Zaid Al-Bassam <zalbassam@google.com>
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

From: Marc Zyngier <marc.zyngier@arm.com>

ARMv8 is a superset of ARMv7, and all the ARMv8 features are
discoverable with a set of ID registers. It means that we can
use CPU_V7 to guard ARMv8 features at compile time.

This commit simply amends the CPU_V7 configuration symbol comment
to reflect that CPU_V7 also covers ARMv8.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Zaid Al-Bassam <zalbassam@google.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20230126204444.2204061-7-zalbassam@google.com
---
 arch/arm/mm/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
index e949e84a2decd..b77f4a0d9072e 100644
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
2.39.1.581.gbfd45094c4-goog

