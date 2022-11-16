Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B366162BF41
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 14:20:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238871AbiKPNTs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 08:19:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238294AbiKPNTm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 08:19:42 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B35262BB15;
        Wed, 16 Nov 2022 05:19:41 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id x102so11269244ede.0;
        Wed, 16 Nov 2022 05:19:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cu4Pj0/g3wVyHJOh6XAPI11RLacw08jC/qauyL0wdeU=;
        b=cetpZgc842pmN6uwgb0ABFm8EiYtQl9ogkQdutUrZ/sr3Uuluqt2l3XPLfgfocSZFK
         39BEg8DmghIoghB+7mmw77x0F1KEzT266S1ouXMRxCZ79tYTQFA0hefzNaBZguX14ynn
         xiNglk1uy+vxm0nVIovVKs00SxCL1cgCLgPKv2Q5SssS0fw8uEOvN1xgHnDGKgcpRs51
         FcS8EXqvfKnq1+fM4oq4/KUnngxyaoy+SMUo/4cbT1n5/6XxukAOfKwLuIYQk003Q5xx
         LYSmfd6t0CHoU2p0zccA7Yi4Ta68WZA63Q5aLg5PhOXETKjjRkACG0RHWs9RtpOjdI6F
         PJvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cu4Pj0/g3wVyHJOh6XAPI11RLacw08jC/qauyL0wdeU=;
        b=R/7Ums4xYkrsrwuiZIBjywzLzP9/N+E5ozkbv46FjB7wD31pk1v1IBgYJUUzdLO/Wc
         /Hv8j4SYkRqvVhBhgcB+OKMlI7r0DVGEuJRlXUDbBwbYOwK9YlIpRfFnjvQBjfbgdhpn
         qN7MM4ZgIve4Dndgx4AKYWhyi/h24au3DkCwrjKEzghMQcxEWzTYBUH91WYEGkQJ49VA
         pSTH9CnlgoHaR1bzSEJ/AqA50gruhv/cq+gOC5Z+co6iBKI+E7zv7sdGF7snmDyBQNHR
         mVoqyWTd9dwhVtROaGH/OIL3gzxkTb/OWnb82gX2nkdtBq1cy4ZbHCRZY5o4cv3ETqQZ
         i2UQ==
X-Gm-Message-State: ANoB5pmFccSX68BPwCz6lZCbrd45k6EbP5Vam04nqoRBZbU8VHhW1fN2
        kgkjz5SNKO+ub+7nlEVw3yY=
X-Google-Smtp-Source: AA0mqf49H2mM4LmigWtuW0lZRPV8K/bjrHWkfrhJ5zGrgfca0PZCw5vWAvPSS1BdgVMJfGcQ7MNWGg==
X-Received: by 2002:a05:6402:b63:b0:460:6194:d293 with SMTP id cb3-20020a0564020b6300b004606194d293mr19607886edb.331.1668604780144;
        Wed, 16 Nov 2022 05:19:40 -0800 (PST)
Received: from felia.fritz.box (200116b826c55000c59461cca0b9a159.dip.versatel-1u1.de. [2001:16b8:26c5:5000:c594:61cc:a0b9:a159])
        by smtp.gmail.com with ESMTPSA id z10-20020a170906714a00b00738795e7d9bsm6818276ejj.2.2022.11.16.05.19.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 05:19:39 -0800 (PST)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Cc:     Mike Rapoport <rppt@linux.ibm.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH RESEND] mm: Kconfig: make config SECRETMEM visible with EXPERT
Date:   Wed, 16 Nov 2022 14:19:22 +0100
Message-Id: <20221116131922.25533-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 6a108a14fa35 ("kconfig: rename CONFIG_EMBEDDED to CONFIG_EXPERT")
introduces CONFIG_EXPERT to carry the previous intent of CONFIG_EMBEDDED
and just gives that intent a much better name. That has been clearly a good
and long overdue renaming, and it is clearly an improvement to the kernel
build configuration that has shown to help managing the kernel build
configuration in the last decade.

However, rather than bravely and radically just deleting CONFIG_EMBEDDED,
this commit gives CONFIG_EMBEDDED a new intended semantics, but keeps it
open for future contributors to implement that intended semantics:

    A new CONFIG_EMBEDDED option is added that automatically selects
    CONFIG_EXPERT when enabled and can be used in the future to isolate
    options that should only be considered for embedded systems (RISC
    architectures, SLOB, etc).

Since then, this CONFIG_EMBEDDED implicitly had two purposes:

  - It can make even more options visible beyond what CONFIG_EXPERT makes
    visible. In other words, it may introduce another level of enabling the
    visibility of configuration options: always visible, visible with
    CONFIG_EXPERT and visible with CONFIG_EMBEDDED.

  - Set certain default values of some configurations differently,
    following the assumption that configuring a kernel build for an
    embedded system generally starts with a different set of default values
    compared to kernel builds for all other kind of systems.

Considering the second purpose, note that already probably arguing that a
kernel build for an embedded system would choose some values differently is
already tricky: the set of embedded systems with Linux kernels is already
quite diverse. Many embedded system have powerful CPUs and it would not be
clear that all embedded systems just optimize towards one specific aspect,
e.g., a smaller kernel image size. So, it is unclear if starting with "one
set of default configuration" that is induced by CONFIG_EMBEDDED is a good
offer for developers configuring their kernels.

Also, the differences of needed user-space features in an embedded system
compared to a non-embedded system are probably difficult or even impossible
to name in some generic way.

So it is not surprising that in the last decade hardly anyone has
contributed changes to make something default differently in case of
CONFIG_EMBEDDED=y.

Currently, in v6.0-rc4, SECRETMEM is the only config switched off if
CONFIG_EMBEDDED=y.

As long as that is actually the only option that currently is selected or
deselected, it is better to just make SECRETMEM configurable at build time
by experts using menuconfig instead.

Make SECRETMEM configurable when EXPERT is set and otherwise default to
yes. Further, SECRETMEM needs ARCH_HAS_SET_DIRECT_MAP.

This allows us to remove CONFIG_EMBEDDED in the close future.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
Acked-by: Mike Rapoport <rppt@linux.ibm.com>
Acked-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: Masahiro Yamada <masahiroy@kernel.org>
---
v1: https://lore.kernel.org/lkml/20220908104337.11940-6-lukas.bulwahn@gmail.com/ 

v1 -> resend:
  - no change of the commit itself
  - added tags from Mike, Arnd and Masahiro-san

Andrew, please pick this minor clean-up patch for mm.

 mm/Kconfig | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/mm/Kconfig b/mm/Kconfig
index c7e06b507965..6a9a7657b470 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -1074,7 +1074,13 @@ config IO_MAPPING
 	bool
 
 config SECRETMEM
-	def_bool ARCH_HAS_SET_DIRECT_MAP && !EMBEDDED
+	default y
+	bool "Enable memfd_secret() system call" if EXPERT
+	depends on ARCH_HAS_SET_DIRECT_MAP
+	help
+	  Enable the memfd_secret() system call with the ability to create
+	  memory areas visible only in the context of the owning process and
+	  not mapped to other processes and other kernel page tables.
 
 config ANON_VMA_NAME
 	bool "Anonymous VMA name support"
-- 
2.17.1

