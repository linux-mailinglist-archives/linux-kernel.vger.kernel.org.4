Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9107F617F69
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 15:25:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231431AbiKCOZO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 10:25:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231312AbiKCOZJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 10:25:09 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97D0415A25
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 07:25:08 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id bk15so2975895wrb.13
        for <linux-kernel@vger.kernel.org>; Thu, 03 Nov 2022 07:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fj/ZFbn3Zm8rxzcKsJGd6yFucy8YocyT0mV+oXpe7Do=;
        b=jMtJfzvsVyM2XNkO7dOnrzsj5bFsNMWPr9qRIuRvfNs1tOIvR8I1IP8JVx8tLG7Dep
         v7Un2NZW58xBtWmwuCjYH772AaiwgcpVC21xqkhn0o/tmaNi7buIljvNSAt6F+cUJUMm
         ty0TFwUWGldw91R8cET10BSTY/z5J4prX7tkwNyHo6zddMYQimrfEvNM/sLXJ4IbkhDZ
         m9cFvv72Li0sU8oIZulB0WLbKf4nulNrh7pWjefMCTf4HMlXuiYiEY3FH49w0tZgWXlu
         BN1Vbu6K5RGrqIIVUiu2VYCjwuaaGz/52VTavOGbRx053ikoFEVXHhj2bCgUlI2OBbQL
         U+mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fj/ZFbn3Zm8rxzcKsJGd6yFucy8YocyT0mV+oXpe7Do=;
        b=KIQasUEjboue3/+fAgEZdOZKh7WQH4f2eGkd3uviJXLJcn22aCQCAChClFmc+AiSRW
         9Q7R7A/CBfcaVBUBlBoptL34evKi2YUf4JCoXFtc7LXx4i5JnaBDpRH+5HJ0mzVCrbj9
         vedCISS4CGuCJ7hAwgnn5HDppyXPrrLwTz4bMKxkJlvr1T/XhB9YHrlfrZJzvkOp2fFv
         xIPERHpb1IhLPcIH23V93eoLnt7auNNzx2De42KmNxW2JBlQo5Qof+h1QnSjXS1P8lMj
         AMAHcD53E1qUF0RoDBfE/QJH5OXHnI8EZmrBlydA6ChGIxsT+rh5QuavptQgCaBRAxF0
         g+Sg==
X-Gm-Message-State: ACrzQf39Za01vA0zzgBSeFDoVgitJIpje/tBbtARBoP94VLNACLowDlR
        T0GdvMhAJoywmaScTu5U57D9Sg==
X-Google-Smtp-Source: AMsMyM7Fd10uROzTNx7lsAW66oPjI1uph9DNvAe559a3qkiRN8acm3Iyt5ChbLPnm5wfe14jlQcTjQ==
X-Received: by 2002:a05:6000:170d:b0:236:6aa1:8a56 with SMTP id n13-20020a056000170d00b002366aa18a56mr18858226wrc.302.1667485507181;
        Thu, 03 Nov 2022 07:25:07 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-748-2a9a-a2a6-1362.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:748:2a9a:a2a6:1362])
        by smtp.gmail.com with ESMTPSA id c19-20020a05600c0a5300b003c21ba7d7d6sm1348138wmq.44.2022.11.03.07.25.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 07:25:06 -0700 (PDT)
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
Subject: [PATCH v4 1/1] x86: cpuinfo: Ensure inputs to cpumask_next are valid
Date:   Thu,  3 Nov 2022 15:25:04 +0100
Message-Id: <20221103142504.278543-2-ajones@ventanamicro.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221103142504.278543-1-ajones@ventanamicro.com>
References: <20221103142504.278543-1-ajones@ventanamicro.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The valid cpumask range is [0, nr_cpu_ids) and cpumask_next()
currently calls find_next_bit() with its input CPU ID number plus one
for the bit number, giving cpumask_next() the range [-1, nr_cpu_ids - 1).
seq_read_iter() and cpuinfo's start and next seq operations implement a
pattern like

  n = cpumask_next(n - 1, mask);
  show(n);
  while (1) {
      ++n;
      n = cpumask_next(n - 1, mask);
      if (n >= nr_cpu_ids)
          break;
      show(n);
  }

which will eventually result in cpumask_next() being called with
nr_cpu_ids - 1. A kernel compiled with commit 78e5a3399421 ("cpumask:
fix checking valid cpu range"), but not its revert, commit
80493877d7d0 ("Revert "cpumask: fix checking valid cpu range"."),
will generate a warning when DEBUG_PER_CPU_MAPS is enabled each time
/proc/cpuinfo is read. Future-proof cpuinfo by checking its input to
cpumask_next() is valid.

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

