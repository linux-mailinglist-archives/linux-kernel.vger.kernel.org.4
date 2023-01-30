Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD18D6818E2
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 19:25:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237814AbjA3SZN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 13:25:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235633AbjA3SYA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 13:24:00 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE91445BF8
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 10:23:29 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id c10-20020a17090a1d0a00b0022e63a94799so1469835pjd.2
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 10:23:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2V4bEO8aGCUnvICkvYFTtflr32JlbC6lkp0g+wowtbM=;
        b=lk2FS4bi5tXkC1KwlB7IR9frYJNCQB46zRuLBebN5lBJ8cN3scRheCqCzNq02LquDZ
         T7s0yo1+o/et+QSWknYJCYgYVrAhIpx0Q9RFeIJULyKKzgmtGBS8BkeM/vl6wKvrBMjp
         mUvQzp6EXvFNRLO9+5Kiu1elg30zaPMBmDpWZO2NqlSDLjfGA8M/9cZI0DQaxiOgClDj
         0kOWsS7nvZZg3rIfS/7ZgCLiyEXy42cw6D20wqCpo9xvkn4YN9s2Y8p41QXLbbX33pYG
         yt0yEkzirf4so3ujS3owGMIcP4HQ2+eRccoCcxPRQaOr8cvUU/UP8Tzs1QvpGKrSAhji
         ekYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2V4bEO8aGCUnvICkvYFTtflr32JlbC6lkp0g+wowtbM=;
        b=hLcMwO1k3/5kJn+d6f9XY3tfD6OCJ0nY2UdbA+9ajH7wGryRC4Tp0DEB0v9KnoOzTT
         ppV41DGg52EUC2TGj25UZKhbx/sGRLTTTD+SbE/9Cq4Odv8yMamS0M9W08ciPtmf1+ST
         f+/IOgf7Md0I7WLKU6mtl+o7o/1ClgMHeLHVF5lIIW5MbYATfuuTk29+izm3BeCkiLtk
         KtHPT+i4MCgdCqo7Fm0jY+cJeFU9I4SzboXUY2LVXF6W9zQPsWWqOk9LYaYAD4ZF+XDJ
         AHSnpa4fJ7jteU3m92uPlTr6jdp/TVyAU7D9+Fgb0h8ExBze6mwB+7B6XxluCTAYAU8m
         XCLA==
X-Gm-Message-State: AO0yUKWzzfZVCNrWLSbLITIYUw0SCI8rxf1B5gz8yLGSz3oyaozaxurp
        gJkwCk/pmMYW3ABob/40WW4J5g==
X-Google-Smtp-Source: AK7set/tX5Xt8agYBu/KLyJy+OnSgmLrgEYtXB6QpcbJp9X24yqEp94vp4kVKhN3pU5/ZWvnJCibGA==
X-Received: by 2002:a05:6a20:8e19:b0:bc:db54:27d7 with SMTP id y25-20020a056a208e1900b000bcdb5427d7mr5597928pzj.59.1675103009111;
        Mon, 30 Jan 2023 10:23:29 -0800 (PST)
Received: from kerodipc.Dlink ([49.206.9.96])
        by smtp.gmail.com with ESMTPSA id j193-20020a638bca000000b00478162d9923sm7000291pge.13.2023.01.30.10.23.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 10:23:28 -0800 (PST)
From:   Sunil V L <sunilvl@ventanamicro.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     linux-riscv@lists.infradead.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Anup Patel <apatel@ventanamicro.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Atish Patra <atishp@rivosinc.com>,
        Sunil V L <sunilvl@ventanamicro.com>
Subject: [PATCH 12/24] RISC-V: ACPI: smpboot: Create wrapper smp_setup()
Date:   Mon, 30 Jan 2023 23:52:13 +0530
Message-Id: <20230130182225.2471414-13-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20230130182225.2471414-1-sunilvl@ventanamicro.com>
References: <20230130182225.2471414-1-sunilvl@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

smp_setup() currently assumes DT based platforms. To enable ACPI,
first make this as a wrapper function and move existing code to
a separate DT specific function.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
---
 arch/riscv/kernel/smpboot.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/kernel/smpboot.c b/arch/riscv/kernel/smpboot.c
index 00b53913d4c6..26214ddefaa4 100644
--- a/arch/riscv/kernel/smpboot.c
+++ b/arch/riscv/kernel/smpboot.c
@@ -70,7 +70,7 @@ void __init smp_prepare_cpus(unsigned int max_cpus)
 	}
 }
 
-void __init setup_smp(void)
+static void __init of_parse_and_init_cpus(void)
 {
 	struct device_node *dn;
 	unsigned long hart;
@@ -116,6 +116,11 @@ void __init setup_smp(void)
 	}
 }
 
+void __init setup_smp(void)
+{
+	of_parse_and_init_cpus();
+}
+
 static int start_secondary_cpu(int cpu, struct task_struct *tidle)
 {
 	if (cpu_ops[cpu]->cpu_start)
-- 
2.38.0

