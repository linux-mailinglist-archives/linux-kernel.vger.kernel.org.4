Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6315B66222E
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 10:53:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236276AbjAIJxW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 04:53:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236703AbjAIJv5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 04:51:57 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A300F13CC6;
        Mon,  9 Jan 2023 01:51:19 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id z4-20020a17090a170400b00226d331390cso8818623pjd.5;
        Mon, 09 Jan 2023 01:51:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mqJCH7hX4dILUHJmf3hsUMhsDu5qPCEp+u1n+kr7rxg=;
        b=iMD9gaWVVnDR5njGukGNImhoF87Ln9pekRZVKBgCi5H+o9ebrLASJQ9Pb2xx540g1b
         siUcwH+wbT4a+l1Cue1bsgU7jsA5qiKM3BbgRhL5ZfTLVAK41WaTCzcm4nHFh8+9ID1M
         q5N6wFjtyeQGX9HwBqsaLerLhmCLyNbyaevr5R3zYeI4RXH2SCbwekTA/tVPQh6oqR8C
         1SfKizOBJpvEPl8mcABpM3INLBv+CZNm2tbav7SVt4UHgaxDfIzzi0dFpHolD2Iw2h/S
         C68rkN+4SmXk1aDJz4WKFWrUuqkCMRK5AXGAXJ5GsukhBGcDJ30tdagtyaYAsPqsT4Xq
         CDfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mqJCH7hX4dILUHJmf3hsUMhsDu5qPCEp+u1n+kr7rxg=;
        b=Ww4AMHz0TNsRfApXpVgo9PVkpO7Ed2xqBs/BL2lgMXqFjPU4UMD5LN+TJo3b72sUmp
         WNRkI71NAbDYv7SuTlp6Q2B0G54dypJ7/Jv6CBsOsHbZW27Ee+fjB0sJn4yLMIkUT0Yq
         73ogXPNs3OvxdClGlBMXWy1Zv6+6M/60spc1KUqFP9KTRNtUC+adVFdDq1ME+cTSNe+f
         yAnPeeTEv3lNhnEgWcWe62zv0rVOfflzEz8wSZrtczgZBrt5gZ1bGUfMYYaRJUpuOBrU
         ygSoG6oE1zMeLuZDoi5OVZgPRP0oFvJWBRwlPgrGUffWPOp0F3HwM3EOOvq0dCnyh/4s
         LsQA==
X-Gm-Message-State: AFqh2kp+SrZExvseUC5PjxRtv858PRskyl530aPukN/K6pGgII5GZUwv
        EJ1/CltIv8pAMdctnfN1BoY=
X-Google-Smtp-Source: AMrXdXvxLMwwO7210xShAwXu60VO5zSYBPq3TMErKmIAVFxoEaev7iZZcvNbLW0WxAqP8M+IDQWZew==
X-Received: by 2002:a17:90b:485:b0:223:ffd0:b2a1 with SMTP id bh5-20020a17090b048500b00223ffd0b2a1mr68601087pjb.48.1673257879189;
        Mon, 09 Jan 2023 01:51:19 -0800 (PST)
Received: from debian.me (subs03-180-214-233-26.three.co.id. [180.214.233.26])
        by smtp.gmail.com with ESMTPSA id s88-20020a17090a69e100b002262ab43327sm3762001pjj.26.2023.01.09.01.51.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 01:51:18 -0800 (PST)
Received: by debian.me (Postfix, from userid 1000)
        id E2698105011; Mon,  9 Jan 2023 16:51:10 +0700 (WIB)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>,
        Yann Sionneau <ysionneau@kalray.eu>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Clement Leger <clement.leger@bootlin.com>,
        Guillaume Thouvenin <gthouvenin@kalray.eu>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH 7/8] Documentation: kvx: Use literal code block for command-line inputs
Date:   Mon,  9 Jan 2023 16:51:07 +0700
Message-Id: <20230109095108.21229-8-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230109095108.21229-1-bagasdotme@gmail.com>
References: <874jt7fqxt.fsf@meer.lwn.net>
 <20230109095108.21229-1-bagasdotme@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2492; i=bagasdotme@gmail.com; h=from:subject; bh=bMSMm0rWOWzEGbRrqmQsw/YZ3fZ91pfy18WO8XnzGNg=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDMm7H3dnLJ1tKiSrLXZpuXq/3KPEJ6803loUWJ8qfWBnOMlo Bc+yjlIWBjEuBlkxRZZJiXxNp3cZiVxoX+sIM4eVCWQIAxenAExEfRYjw92Vex8wV3+XeqDu88xx6v 6dpV8rZAraTbIupz8VCpPdq8HwP0pphXxbdPhRxVXZjWs/1eirsU3+1XxYJa667qng7ad/2QA=
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Command-line, like codes, looks ugly when default paragraph block is
used (since proportional font is used), where literal code blocks (which
render as monospace) do the job better.

Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/kvx/kvx-iommu.rst |  2 +-
 Documentation/kvx/kvx.rst       | 10 +++++-----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/kvx/kvx-iommu.rst b/Documentation/kvx/kvx-iommu.rst
index 5e84dc12adb437..c95d9231d5b665 100644
--- a/Documentation/kvx/kvx-iommu.rst
+++ b/Documentation/kvx/kvx-iommu.rst
@@ -144,7 +144,7 @@ Maintenance interface
 It is possible to have several "maintainers" for the same IOMMU. The driver is
 using two of them. One that writes the TLB and another interface reads TLB. For
 debug purpose it is possible to display the content of the tlb by using the
-following command in gdb:
+following command in gdb::
 
     gdb> p kvx_iommu_dump_tlb( <iommu addr>, 0)
 
diff --git a/Documentation/kvx/kvx.rst b/Documentation/kvx/kvx.rst
index 4aac7fce4e3d01..5385e1e3d30187 100644
--- a/Documentation/kvx/kvx.rst
+++ b/Documentation/kvx/kvx.rst
@@ -122,7 +122,7 @@ To be able to set breakpoints when MMU is enabled we added a label called
 gdb_mmu_enabled. If you try to set a breakpoint on a function that is in
 virtual memory before the activation of the MMU this address as no signification
 for GDB. So, for example, if you want to break on the function start_kernel()
-you will need to run:
+you will need to run::
 
 	kvx-gdb -silent path_to/vmlinux \
 		-ex 'tbreak gdb_mmu_enabled' -ex 'run' \
@@ -253,19 +253,19 @@ Building
 ========
 
 In order to build the kernel, you will need a complete kvx toolchain.
-First, setup the config using the following command line
+First, setup the config using the following command line::
 
 $ make ARCH=kvx O=your_directory default_defconfig
 
-Adjust any configuration option you may need and then, build the kernel:
+Adjust any configuration option you may need and then, build the kernel::
 
 $ make ARCH=kvx O=your_directory -j12
 
-You will finally have a vmlinux image ready to be run.
+You will finally have a vmlinux image ready to be run::
 
 $ kvx-mppa -- vmlinux
 
-Additionally, you may want to debug it. To do so, use kvx-gdb:
+Additionally, you may want to debug it. To do so, use kvx-gdb::
 
 $ kvx-gdb vmlinux
 
-- 
An old man doll... just what I always wanted! - Clara

