Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46371668B01
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 05:49:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229643AbjAMEt1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 23:49:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229912AbjAMEtR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 23:49:17 -0500
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40CD65B141
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 20:49:16 -0800 (PST)
Received: by mail-qt1-x831.google.com with SMTP id x7so8186348qtv.13
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 20:49:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pefoley.com; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lVbqtFvEqcEY6PTmCOfzPzIYvqXqj8MQaEjPBYbJAVg=;
        b=oSg0uTIKfexVL+8ythAlt7gKQD/HGKHc+xpRHILJIbXc/Q6TtTwAm9x3UWR9dlzThP
         PjoCNQjMofO/IuVqMEF74cp1PkNogOp+PcpAFL2pivlh//Mz+FnEt/Zc80N/JXgNln/A
         8mcDcquFzM7ANPNCVQiN/Bsv6C2yDAJnlJf6o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lVbqtFvEqcEY6PTmCOfzPzIYvqXqj8MQaEjPBYbJAVg=;
        b=A/FzzmS5Iq81QHsirM7+LyKeg5gLl/4W98KhaM4wYGDg4J5b5ccwz0ALEKGkIqA8Jn
         UJWW0tbYrQT64mrh65aueIeohcw1ui+3Ju3cMJU0sx6uXgeTy6kJvhKOuQjPzI1aI9sN
         BbH8tREbBTR5Z3+L7V3N5l2ngafMtShmQuYU1AOAWvDuGcsD0cCQvge+n0DIVYNT/CXZ
         8Q5obQI2w59DSZA3uNxIiJVgxjQvCAngiQBaMLeMDD7TLpdkBdRokCJV+qqh6YpR/il+
         078lCeFV4Rv70DLmxVU/ANqIOzskdth8m7mmKO2DMKZrsQ3yEPkHU93IXHKFzLOuwIbN
         6uCQ==
X-Gm-Message-State: AFqh2kpwy4GEvWUa0w5yxQ2GOfZe1rKBX6JANwG3T7FR6yyTYLxqVD4c
        DH9vY8RFnAaa68A3V/MsWh7rYw==
X-Google-Smtp-Source: AMrXdXs+4Q/0riaBJeBu43Ip9QqbHlVe2IR4rPwv7GEQW2g23YhJETxm7QMFvfo07vTpZzy0lcWyfA==
X-Received: by 2002:a05:622a:1750:b0:3ad:d7a6:76d8 with SMTP id l16-20020a05622a175000b003add7a676d8mr30209523qtk.38.1673585355266;
        Thu, 12 Jan 2023 20:49:15 -0800 (PST)
Received: from [192.168.1.3] ([2600:4040:29fb:d300:887b:7eff:fe74:68b2])
        by smtp.gmail.com with ESMTPSA id s11-20020a05620a0bcb00b00704a9942708sm12099472qki.73.2023.01.12.20.49.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jan 2023 20:49:14 -0800 (PST)
From:   Peter Foley <pefoley2@pefoley.com>
Date:   Thu, 12 Jan 2023 23:49:07 -0500
Subject: [PATCH 1/4] um: Make the definition of cpu_data more compatible
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Message-Id: <20230112-um-v1-1-6bec9e97ad13@pefoley.com>
References: <20230112-um-v1-0-6bec9e97ad13@pefoley.com>
In-Reply-To: <20230112-um-v1-0-6bec9e97ad13@pefoley.com>
To:     Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-um@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peter Foley <pefoley2@pefoley.com>
X-Mailer: b4 0.11.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1673585354; l=1683;
 i=pefoley2@pefoley.com; s=20230111; h=from:subject:message-id;
 bh=aGrL0ysPMYznOqdL0cA76sdMuDBI2JGj/mTkJStMEDk=;
 b=N2azVPGy0zYLU0iU3/UHyqtpzJsGGCVO2bIRlbOLxNGtGUyvZZ/Jdj31qhwLcIqfA33a965MpYY5
 tv/1TV+mARDuKlsafc554to1VTS6vsw1ltMTV8PZOe4nzSx4GHum
X-Developer-Key: i=pefoley2@pefoley.com; a=ed25519;
 pk=DCQqIdN6rHnvfQH58WQiQzJFfGUo1HyWSvdYG8vnO5o=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Match the x86 implementation to improve build errors.
Noticed when building allyesconfig.

e.g.
../arch/um/include/asm/processor-generic.h:94:19: error: called object is not a function or function pointer
   94 | #define cpu_data (&boot_cpu_data)
      |                  ~^~~~~~~~~~~~~~~
../drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_topology.c:2157:16: note: in expansion of macro ‘cpu_data’
 2157 |         return cpu_data(first_cpu_of_numa_node).apicid;

Signed-off-by: Peter Foley <pefoley2@pefoley.com>
---
 arch/um/include/asm/processor-generic.h | 2 +-
 arch/um/kernel/um_arch.c                | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/um/include/asm/processor-generic.h b/arch/um/include/asm/processor-generic.h
index bb5f06480da9..7414154b8e9a 100644
--- a/arch/um/include/asm/processor-generic.h
+++ b/arch/um/include/asm/processor-generic.h
@@ -91,7 +91,7 @@ struct cpuinfo_um {
 
 extern struct cpuinfo_um boot_cpu_data;
 
-#define cpu_data (&boot_cpu_data)
+#define cpu_data(cpu)    boot_cpu_data
 #define current_cpu_data boot_cpu_data
 #define cache_line_size()	(boot_cpu_data.cache_alignment)
 
diff --git a/arch/um/kernel/um_arch.c b/arch/um/kernel/um_arch.c
index 786b44dc20c9..8dcda617b8bf 100644
--- a/arch/um/kernel/um_arch.c
+++ b/arch/um/kernel/um_arch.c
@@ -96,7 +96,7 @@ static int show_cpuinfo(struct seq_file *m, void *v)
 
 static void *c_start(struct seq_file *m, loff_t *pos)
 {
-	return *pos < nr_cpu_ids ? cpu_data + *pos : NULL;
+	return *pos < nr_cpu_ids ? &boot_cpu_data + *pos : NULL;
 }
 
 static void *c_next(struct seq_file *m, void *v, loff_t *pos)

-- 
2.39.0
