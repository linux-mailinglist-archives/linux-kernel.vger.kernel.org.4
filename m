Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3942B693D9E
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 05:55:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229942AbjBMEz1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Feb 2023 23:55:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229959AbjBMEy4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Feb 2023 23:54:56 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44847113F1
        for <linux-kernel@vger.kernel.org>; Sun, 12 Feb 2023 20:54:30 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id i18so3870699pli.3
        for <linux-kernel@vger.kernel.org>; Sun, 12 Feb 2023 20:54:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H5RDh/4h33AXRCvzLgyL6r/ZYBcOU/v7pv8PufXaHhU=;
        b=wq1vjGt5Dk5GTt2uM2o1fsU4IewccIkdZiTiZ7Q6QROKj7XotzLnQnbGMt7mkKvcxn
         Uxr0y6xeaOCw0m3jmFx4LdilZxIzFkNBZUysklHVUGRQgJUL2fG/YYfw9ujVUppzfGLO
         K2+9aqLeM3PSle+L5sFQoNf3ArhkOzkMUImcbHjhQmj01b4KtjSLsZc0o27pdRVwgFoD
         gmJsi6NkemAEVMiZjtqLPqgGgv2Z5vh743ofDqsf+8HUhJwOQVi30lbfExMhXxuLElj8
         xHOnKu08Ovp/uV/YddPhlNoEHhLPdW6MlLGLla9JQ4zUjud10AC/I0X8tPdayr8dpskh
         va1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H5RDh/4h33AXRCvzLgyL6r/ZYBcOU/v7pv8PufXaHhU=;
        b=XxC0CuBi5aO/iMmC2jTvZnmp0blR9hG6B3krn1lUuMgL4xRn14Sf9U9ri97sI2Dtmc
         SVGDcgL1f4xcTgM96tFECSCL4XzCw8uFcfA4k1DOFaCOkFymOZOXcVpfjq/MxZ+sPsz/
         ByOeFf6xN0NN4n9/ozkFBeO7gq+bTVd/YxVBVzVJiOjU2VtZhKJibxE6pexXZegSiVcz
         4o8c+dpXdNtWBhVetUQjgvgSHL1EYZb9PqYLx3u1u/Zq+pHPETjjlwqzM6y1LmTGM3Ef
         BiR5RNFwRGuhewgk4nw80FF2NQbBbfOC2HQjNmjZAVs2649AFATMnnk2VWDrtVhWQZqM
         Uxzg==
X-Gm-Message-State: AO0yUKWaDeJfZb5YCEbRmS2PhKe524tlA6F4m3WHxJHVoP6BYlPgAgVR
        QYlTeZa01wF3f4ZAA9Z7yjG88x3d1TWTnf47
X-Google-Smtp-Source: AK7set/buAEv0Dcf3oki/D1OsCxjOnHbCXwSRzLrgXj1477fOT32uLPajUBPeIjkACO2s7SI5kT0TA==
X-Received: by 2002:a17:902:f20b:b0:199:aae:7569 with SMTP id m11-20020a170902f20b00b001990aae7569mr17492690plc.28.1676264069586;
        Sun, 12 Feb 2023 20:54:29 -0800 (PST)
Received: from debug.ba.rivosinc.com ([66.220.2.162])
        by smtp.gmail.com with ESMTPSA id e5-20020a170902784500b00189e7cb8b89sm7078303pln.127.2023.02.12.20.54.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Feb 2023 20:54:29 -0800 (PST)
From:   Deepak Gupta <debug@rivosinc.com>
To:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     Deepak Gupta <debug@rivosinc.com>
Subject: [PATCH v1 RFC Zisslpcfi 19/20] config: adding two new config for control flow integrity
Date:   Sun, 12 Feb 2023 20:53:48 -0800
Message-Id: <20230213045351.3945824-20-debug@rivosinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230213045351.3945824-1-debug@rivosinc.com>
References: <20230213045351.3945824-1-debug@rivosinc.com>
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

To maintain control flow integrity of a program, integrity of indirect
control transfers has to be maintained. Almost in all architectures there
are two mechanisms for indirect control transfer
 - Indirect call relying on a memory operand.
 - Returns which pop an address from stack and return to caller.

Control transfers relying on memory operands are inherently susceptible to
memory corruption bugs and thus allowing attackers to perform code re-use
attacks which eventually is used to inject attacker's payload.

All major architectures (x86, aarch64 and riscv) have introduced hardware
assistance in form of architectural extensions to protect returns (using
alternate shadow/control stack) and forward control flow (by enforcing
all indirect control transfers land on a landing pad instruction)

This patch introduces two new CONFIGs

  - CONFIG_USER_SHADOW_STACK
    Config to enable kernel support for user mode shadow stacks

  - CONFIG_USER_INDIRECT_BR_LP
    Config to enable kernel support for enforcing landing pad instruction
    on target of an indirect control transfer.

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
---
 init/Kconfig | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/init/Kconfig b/init/Kconfig
index 44e90b28a30f..8867ea4b074f 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -121,6 +121,25 @@ config THREAD_INFO_IN_TASK
 	  One subtle change that will be needed is to use try_get_task_stack()
 	  and put_task_stack() in save_thread_stack_tsk() and get_wchan().
 
+config USER_SHADOW_STACK
+	bool
+	help
+	  Select this to enable kernel to support user mode shadow stack. Most
+	  major architectures now support hardware assisted shadow stack. This
+	  allows to enable non-arch specifics related to shadow stack in kernel.
+	  Arch specific configuration options may also need to be enabled.
+
+config USER_INDIRECT_BR_LP
+	bool
+	help
+	  Select this to allow user mode apps to opt-in to force requirement for
+	  a landing pad instruction on indirect jumps or indirect calls in user mode.
+	  Most major architectures now support hardware assistance for landing pad
+	  instruction on indirect call or a jump. This config option allows non-arch
+	  specifics related to landing pad instruction to be enabled separately from
+	  arch specific implementations. Arch specific configuration options may also
+	  need to be enabled.
+
 menu "General setup"
 
 config BROKEN
-- 
2.25.1

