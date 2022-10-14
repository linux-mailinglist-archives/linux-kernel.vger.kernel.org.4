Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 278595FF1E6
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 17:59:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230291AbiJNP7F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 11:59:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230251AbiJNP6x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 11:58:53 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A30FB155DB2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 08:58:51 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id l22so7455003edj.5
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 08:58:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XBIOqGjmdzThiZsnnbTdUiYSPQXS/qp/QRUJHndogxY=;
        b=de2qcklml8jKYdhJlyXqmJXoz8FYGzMVRLfN9JcOUqf4UOLuKCrWZr59qwP/CI15i8
         9ZEYt9iqHJUORqeLDasCpf2TvKXJ2eNiOMML8Fk+bz7YKFJbV57Ez3yS2OMYxbifi8aU
         80V2z5mOPzJ5j+SPiaK/ExtA7pvzSXkVFgQy9BgPDzmgfE18Klp1ebv/IKnNb6TVl3x7
         K0gO3P8T9E6LTR2oS1WZnI3pbS2vkD6iCSFlqd/rinFyB9u6Ftb/GsYDL097UX4vn1na
         X5w9kGup7pabQp9pwZ84Krxhofd+fyywuWkx0d61FPGLmHqmWuc2PbVNpdjodZPMfLJV
         6NYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XBIOqGjmdzThiZsnnbTdUiYSPQXS/qp/QRUJHndogxY=;
        b=JeavNpwsiLzHRwV0PhhxsUWzZ1bIwGkV0HS9+eeBvvFJz65xNH2k2HkgUiW3AiBovD
         NjFNk7VFgv9hlmHc2h+tmlOGeStYxyxK86fttydyYwQfpQO/AMCf96Ur47YxdcwFse8q
         iQVZUSb9gfqVrvtp2wwGnBay+9YimzADvXBy7ha++4URS4WZy7trnqyami70gDaJgw7z
         kw0cBDfOruLtqKwpzeyoNBkfJg7ldKcoWnRWetAfbx28nV/4DdGK/CAmU5wwUTw53hzu
         x1zqVHFD1qozmHW5ZTG/bzeTzEHIp/F9L5xYiEXCQl+jONwUV66OMzrSOzjGxcdJby5a
         yleQ==
X-Gm-Message-State: ACrzQf04gd8vECZ8P+h2HrA+g6ysJ21ITVRDCakqzcbSEWFgo0U9M/PZ
        bx+qKF5ckjtkwNZwhY7+/5Ixkw==
X-Google-Smtp-Source: AMsMyM7AeOygOXkM1z/GTKaGU+3a1Uh1fQyGWBmDx0oj1luEK/7mcX83iQG4d2XLgbn9xXhJP10WDg==
X-Received: by 2002:a05:6402:3485:b0:45c:d688:6848 with SMTP id v5-20020a056402348500b0045cd6886848mr4672473edc.279.1665763129826;
        Fri, 14 Oct 2022 08:58:49 -0700 (PDT)
Received: from localhost (cst2-173-61.cust.vodafone.cz. [31.30.173.61])
        by smtp.gmail.com with ESMTPSA id 12-20020a170906300c00b0077a1dd3e7b7sm1746796ejz.102.2022.10.14.08.58.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Oct 2022 08:58:49 -0700 (PDT)
From:   Andrew Jones <ajones@ventanamicro.com>
To:     x86@kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Yury Norov <yury.norov@gmail.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Stafford Horne <shorne@gmail.com>,
        openrisc@lists.librecores.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        linux-s390@vger.kernel.org
Subject: [PATCH v3 2/2] x86: Fix /proc/cpuinfo cpumask warning
Date:   Fri, 14 Oct 2022 17:58:45 +0200
Message-Id: <20221014155845.1986223-3-ajones@ventanamicro.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221014155845.1986223-1-ajones@ventanamicro.com>
References: <20221014155845.1986223-1-ajones@ventanamicro.com>
MIME-Version: 1.0
Content-type: text/plain
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

Commit 78e5a3399421 ("cpumask: fix checking valid cpu range") has
started issuing warnings[*] when cpu indices equal to nr_cpu_ids - 1
are passed to cpumask_next* functions. seq_read_iter() and cpuinfo's
start and next seq operations implement a pattern like

  n = cpumask_next(n - 1, mask);
  show(n);
  while (1) {
      ++n;
      n = cpumask_next(n - 1, mask);
      if (n >= nr_cpu_ids)
          break;
      show(n);
  }

which will issue the warning when reading /proc/cpuinfo. Ensure no
warning is generated by validating the cpu index before calling
cpumask_next().

[*] Warnings will only appear with DEBUG_PER_CPU_MAPS enabled.

Signed-off-by: Andrew Jones <ajones@ventanamicro.com>
Cc: Yury Norov <yury.norov@gmail.com>
---
 arch/x86/kernel/cpu/proc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/kernel/cpu/proc.c b/arch/x86/kernel/cpu/proc.c
index 099b6f0d96bd..de3f93ac6e49 100644
--- a/arch/x86/kernel/cpu/proc.c
+++ b/arch/x86/kernel/cpu/proc.c
@@ -153,6 +153,9 @@ static int show_cpuinfo(struct seq_file *m, void *v)
 
 static void *c_start(struct seq_file *m, loff_t *pos)
 {
+	if (*pos == nr_cpu_ids)
+		return NULL;
+
 	*pos = cpumask_next(*pos - 1, cpu_online_mask);
 	if ((*pos) < nr_cpu_ids)
 		return &cpu_data(*pos);
-- 
2.37.3

