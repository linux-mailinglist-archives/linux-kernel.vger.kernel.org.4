Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E01365F717E
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 01:01:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232362AbiJFXBc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 19:01:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231858AbiJFXBS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 19:01:18 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E46E220ED
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 16:01:15 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id b2so3006389plc.7
        for <linux-kernel@vger.kernel.org>; Thu, 06 Oct 2022 16:01:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jGt/X8mSuzied0JB7HVQVACVCG4nPguuP5r+W5zyq8o=;
        b=EM0wy8gtE99AqkZ3qIL5oLs08njI8p0laCPFOB83/zz6JVWhO7vjr5QlF627E6fv8Q
         lz6m7Qg6rCrZuPVxrsNgxfsGBLzSKXqclrV7lixNZzVYOftWBA2PIg1UZYFO997U3NS5
         Yvgc6ExZ4+5GTtjz4xWwua8pIn6Jx9Csdc3gvTwo9b6zdM4D1i592xK2K3bbHX2mtp15
         6QRiB0BPpE5I68F15CSYp2Rj9ahU6g770iqwPRfwstbHYJF8HbtPiWI6soN5inqqbBmO
         BJ0NO6nFCP32LdV6edUSlCy1Sec4AgCYueZ95BwqPCVdWgbg9R+m6zQwmPUFpElepu7c
         Orxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jGt/X8mSuzied0JB7HVQVACVCG4nPguuP5r+W5zyq8o=;
        b=cjDQ/OfHC6PE+IqlDVyx5+hpMcFA5cfFx/gxULq6qZ30jBAzLqPpYnR9L1/oOXZbuN
         bg8LVLjsK3n7wGHV1feLYuBvSHCIwVzXjElWibPGtkWB0NWQnGCSM+SbT5F6Mb5CgYGj
         +mMlHSuYLVVMhoOqoMLC09JHnuVDQK6bc5Wq2DzAVJgCb01B15pz/SzF+L5Ay2GddtOO
         iSVosN+rXTebrHD4sSvt6mY7wkR6cHI/656QpCZHtEYU40CniIvVxpYhN7WSFWnhYniC
         RVt33U0hDJbmyq4wj/Ew/n/DgxQHg99Ntmowj9h4rzBSRaQ4l7g0ljBrAt5+CNSYIGfF
         srpQ==
X-Gm-Message-State: ACrzQf055FfQavvffU3ILJPltWDi2mGE12j+Sl02riJp350l7F4WyJnE
        l+dz+NJcI2035O22YTn5Z2V1eHRHWOLXog==
X-Google-Smtp-Source: AMsMyM6Hi4QgBTulEjD5cf32a+RSzxOUlYrF7GdbO5FP8z22ZYJt/3bwkpwxmjhwFP8rnanSFKqeEQ==
X-Received: by 2002:a17:90a:1785:b0:20a:6162:2b6a with SMTP id q5-20020a17090a178500b0020a61622b6amr1987900pja.180.1665097274361;
        Thu, 06 Oct 2022 16:01:14 -0700 (PDT)
Received: from atishp.ba.rivosinc.com ([66.220.2.162])
        by smtp.gmail.com with ESMTPSA id bc8-20020a656d88000000b0043a1c0a0ab1sm257309pgb.83.2022.10.06.16.01.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 16:01:14 -0700 (PDT)
From:   Atish Patra <atishp@rivosinc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atishp@rivosinc.com>,
        Daniel Kiper <daniel.kiper@oracle.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Fu Wei <tekkamanninja@gmail.com>,
        Leif Lindholm <quic_llindhol@quicinc.com>,
        Nikita Ermakov <arei@altlinux.org>,
        Atish Patra <atishp@atishpatra.org>,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
        Julian Andres Klode <julian.klode@canonical.com>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: [v4 PATCH 1/3] loader: Move arm64 linux loader to common code
Date:   Thu,  6 Oct 2022 16:00:49 -0700
Message-Id: <20221006230051.185850-2-atishp@rivosinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221006230051.185850-1-atishp@rivosinc.com>
References: <20221006230051.185850-1-atishp@rivosinc.com>
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

ARM64 linux loader code is written in such a way that it can be reused
across different architectures without much change. Move it to common
code so that RISC-V doesn't have to define a separate loader.

Reviewed-by: Daniel Kiper <daniel.kiper@oracle.com>
Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 grub-core/Makefile.core.def             | 4 ++--
 grub-core/loader/{arm64 => efi}/linux.c | 0
 2 files changed, 2 insertions(+), 2 deletions(-)
 rename grub-core/loader/{arm64 => efi}/linux.c (100%)

diff --git a/grub-core/Makefile.core.def b/grub-core/Makefile.core.def
index 5212dfab1369..ce95c76eaffa 100644
--- a/grub-core/Makefile.core.def
+++ b/grub-core/Makefile.core.def
@@ -1817,9 +1817,9 @@ module = {
   sparc64_ieee1275 = loader/sparc64/ieee1275/linux.c;
   ia64_efi = loader/ia64/efi/linux.c;
   arm_coreboot = loader/arm/linux.c;
-  arm_efi = loader/arm64/linux.c;
+  arm_efi = loader/efi/linux.c;
   arm_uboot = loader/arm/linux.c;
-  arm64 = loader/arm64/linux.c;
+  arm64 = loader/efi/linux.c;
   riscv32 = loader/riscv/linux.c;
   riscv64 = loader/riscv/linux.c;
   common = loader/linux.c;
diff --git a/grub-core/loader/arm64/linux.c b/grub-core/loader/efi/linux.c
similarity index 100%
rename from grub-core/loader/arm64/linux.c
rename to grub-core/loader/efi/linux.c
-- 
2.25.1

