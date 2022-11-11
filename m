Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6B6A626278
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 21:00:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234337AbiKKT74 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 14:59:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230043AbiKKT7x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 14:59:53 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E46C78339C
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 11:59:52 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id e7-20020a17090a77c700b00216928a3917so8621279pjs.4
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 11:59:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tiOSDnaJDiv/bd6hfVEdnOGaLX+kZWWhVL356AX2InA=;
        b=TkeO75onMN37rOHMxLyT5F2rMv2tOdJlZrq3BTAW7LyaUwnWA7XsEFvkuNxYWoquke
         7mkmYRz9zYKcuWbugrrJlnm7+iVDndnFJOOYHKLgvbRQKN5L+CViGDPlO2sucitqGLkU
         bNa2JUyPusiCwvZFd3vnQkniW0amRhAJIYJ3uOq1i7WBIIvmiqrGIWo0BDFxRInY6luB
         nU+jCGLaxXQTkuDtVxIWHUOc1rbJtyfWeHsHJFAnFA2bJvf1tBeBuLWZoiinbqYqKCCS
         nWRE+3+Byu2p5BZSp1y0IaGkU6Tg3FLIIzPrkMG5Zt/yNBDKwQxD5NN608POeObXdxFq
         tF0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tiOSDnaJDiv/bd6hfVEdnOGaLX+kZWWhVL356AX2InA=;
        b=FAEcax+KrwYPrtWaZog3fMRYcBmNR47XMFPI0sfdCmRGx5Wq4L72+Wo5B4Z4zJsjna
         xcl0s6/pYI/JXHl00jR2tKtjKq0bcKVAtlN5deoXzJCYaeMh/PTzFr7IB8WfUhKPJW+S
         WnEXB1BC9KQlqPrFW5GYMDOOndyJlv1eFmPu7jz9mjyq6WyWsB+rKf4uroxTnA9RA4At
         paT9TPMop/poTGLFdP7cupF7KxO1p1u/rKUosGAxvXKtJ2rK0eL0cqNeAMhKb66bPExs
         bxNNHySs4HJFttelNh7SylGVXOQYGFcdS8eUoKlcEmYWNvuWhNKwtaJvTfUambYHja/c
         vmsA==
X-Gm-Message-State: ANoB5plKtnFr/XQMF9y4CU+v5d5rXQfI26a8akmVpFB0cfGZdi45exrd
        GOwuoY9uaLQS0V21+IGu8g7yAA==
X-Google-Smtp-Source: AA0mqf6IZD60dm560FlolQXnq3OiNX/QLV4eHW8vxPqbGrcg1WXWRuX6WQ9ZzcGmcAwH+ANespCXCw==
X-Received: by 2002:a17:90a:5294:b0:20a:7c09:7993 with SMTP id w20-20020a17090a529400b0020a7c097993mr3635460pjh.149.1668196792427;
        Fri, 11 Nov 2022 11:59:52 -0800 (PST)
Received: from debug.ba.rivosinc.com ([66.220.2.162])
        by smtp.gmail.com with ESMTPSA id z1-20020aa79901000000b005360da6b26bsm1954866pff.159.2022.11.11.11.59.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Nov 2022 11:59:51 -0800 (PST)
From:   debug@rivosinc.com
To:     palmer@dabbelt.com
Cc:     jan.kiszka@siemens.com, kbingham@kernel.org,
        paul.walmsley@sifive.com, aou@eecs.berkeley.edu,
        debug@rivosinc.com, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux@rivosinc.com
Subject: [PATCH] gdb-script: updated lx_current for riscv
Date:   Fri, 11 Nov 2022 11:59:38 -0800
Message-Id: <20221111195938.1499148-2-debug@rivosinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221111195938.1499148-1-debug@rivosinc.com>
References: <20221111195938.1499148-1-debug@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Deepak Gupta <debug@rivosinc.com>

lx_current python gdb command defined in scripts/gdb/cpus.py updated
to support riscv architecture.

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
---
 scripts/gdb/linux/cpus.py | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/scripts/gdb/linux/cpus.py b/scripts/gdb/linux/cpus.py
index 15fc4626d236..ce6703f1e35a 100644
--- a/scripts/gdb/linux/cpus.py
+++ b/scripts/gdb/linux/cpus.py
@@ -173,6 +173,14 @@ def get_current_task(cpu):
          else:
              raise gdb.GdbError("Sorry, obtaining the current task is not allowed "
                                 "while running in userspace(EL0)")
+    elif utils.is_target_arch("riscv"):
+         current_task_addr = gdb.parse_and_eval("$tp")
+         if((current_task_addr.cast(utils.get_long_type()) >> 63) != 0):
+             current_task = current_task_addr.cast(task_ptr_type)
+             return current_task.dereference()
+         else:
+             raise gdb.GdbError("Sorry, obtaining the current task is not allowed "
+                                "while running in userspace")
     else:
         raise gdb.GdbError("Sorry, obtaining the current task is not yet "
                            "supported with this arch")
-- 
2.25.1

