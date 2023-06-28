Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24761740C0B
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 10:58:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235470AbjF1I6G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 04:58:06 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:56580
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233854AbjF1IxZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 04:53:25 -0400
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 4CF733F22B
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 08:53:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1687942381;
        bh=g+Vzq7623MxsGxq8ObiiEY8MrsR0kmj8nphAIedVAvI=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=FK9mE27w9cUcFe8e1tsKbuMGoMu8x+9i/crZp265HcliX9JMYh2f6xceHisGAHV9d
         i3jNEIbTGY/jimO9iYfLWO0AJ6b1aqyhwlnosCyewrnhRrB3fNRZLhEZhMkHtKtyYN
         BD87HkN4MNKSUooCapB2VAn5s+7uns/j4A3cSNb+XcaASfxCv1KjkHLP8wHQNHynsz
         XZeBiOGnfZuy7Lr84Q4m8uYRfv3C9UHme5xYkf6jvxfGpgvq7iKkMxJxpOMHh/zmUs
         bYcP4umb7FjC356OJToTI22oNmXWWmmupjwn+NvrtjXOifot9st1pkdivnwh0m2IcY
         CEjxWS/O7Vzcg==
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-668728bb904so4616146b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 01:53:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687942378; x=1690534378;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g+Vzq7623MxsGxq8ObiiEY8MrsR0kmj8nphAIedVAvI=;
        b=Ag0a/7kU7dF+xJqGQqljU6lG30vDpUyqqbYOkf6KHeJIKuf3SLu959F36pcwtAnpT/
         u6DmKssHTU1pxGMggfmO1nAbhkoYRlVW31DCkYJyZcXbztOL6LFy6FnphbUev5V9Eg20
         BIYKGjIIkGjYijma3vTb9qEQLj+iWZodgVc6+V6p6TItIqI3IL1R3uUeqIjBU1sqcd1x
         kIvzRzcYhcGLXdyWMkTe12CcMlvBWBXnATqyvZBagwO7BR8ZDMNOA/Mem5Fw7tujBO4s
         a198q/vgO8AHFHIoitL6fgcNUG9/L39Z5MaYodEfvFd3EqdRgzV/Yiyz/i2y/7oedS9r
         IqVg==
X-Gm-Message-State: AC+VfDwrskQ1MXwkV7sS+X5dnZRfdwuPi7n08YdKzkAdV+exoU7/hxWD
        AEtzTN7TahWgm8MBLeyD/ryhc4oDnTJm5owTZyoBx882mdJkhszvNSjerzjwEFopjH5eCExYtjO
        u+JLkph7Z3A6RBg/bklAnTgMtx7Sr1WLOTebebAXUjqGu98Ml4OgR
X-Received: by 2002:a05:6a00:841:b0:680:98c:c5a5 with SMTP id q1-20020a056a00084100b00680098cc5a5mr2938765pfk.32.1687942377894;
        Wed, 28 Jun 2023 01:52:57 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6/Hz7/NrJVz/DhdYrrAKlsklzx7nk+HlL2OxoEz1r6nU5Lo1EjYDj7MUsFbVB6Bcy7ec5wuA==
X-Received: by 2002:a05:6a00:841:b0:680:98c:c5a5 with SMTP id q1-20020a056a00084100b00680098cc5a5mr2938754pfk.32.1687942377527;
        Wed, 28 Jun 2023 01:52:57 -0700 (PDT)
Received: from canonical.com (211-75-139-218.hinet-ip.hinet.net. [211.75.139.218])
        by smtp.gmail.com with ESMTPSA id b26-20020aa7811a000000b00666b3706be6sm6632178pfi.107.2023.06.28.01.52.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 01:52:56 -0700 (PDT)
From:   Koba Ko <koba.ko@canonical.com>
To:     Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Richter <rric@kernel.org>, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] EDAC/i10nm: shift exponent is negative
Date:   Wed, 28 Jun 2023 16:52:53 +0800
Message-Id: <20230628085253.1013799-1-koba.ko@canonical.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UBSAN complains this error
~~~
 UBSAN: shift-out-of-bounds in drivers/edac/skx_common.c:369:16
 shift exponent -66 is negative
 Call Trace:
  <TASK>
  dump_stack_lvl+0x48/0x70
  dump_stack+0x10/0x20
  __ubsan_handle_shift_out_of_bounds+0x1ac/0x360
  skx_get_dimm_info.cold+0x91/0x175 [i10nm_edac]
  ? kvasprintf_const+0x2a/0xb0
  i10nm_get_dimm_config+0x23c/0x340 [i10nm_edac]
  skx_register_mci+0x139/0x1e0 [i10nm_edac]
  ? __pfx_i10nm_get_dimm_config+0x10/0x10 [i10nm_edac]
  i10nm_init+0x403/0xd10 [i10nm_edac]
  ? __pfx_i10nm_init+0x10/0x10 [i10nm_edac]
  do_one_initcall+0x5b/0x250
  do_init_module+0x68/0x260
  load_module+0xb45/0xcd0
  ? kernel_read_file+0x2a4/0x320
  __do_sys_finit_module+0xc4/0x140
  ? __do_sys_finit_module+0xc4/0x140
  __x64_sys_finit_module+0x18/0x30
  do_syscall_64+0x58/0x90
  ? syscall_exit_to_user_mode+0x29/0x50
  ? do_syscall_64+0x67/0x90
  ? syscall_exit_to_user_mode+0x29/0x50
  ? do_syscall_64+0x67/0x90
  ? do_syscall_64+0x67/0x90
  ? __flush_smp_call_function_queue+0x122/0x1f0
  ? exit_to_user_mode_prepare+0x30/0xb0
  ? irqentry_exit_to_user_mode+0x9/0x20
  ? irqentry_exit+0x43/0x50
  ? sysvec_call_function+0x4b/0xd0
  entry_SYSCALL_64_after_hwframe+0x72/0xdc
~~~

when get rows, cols and ranks, the returned error value doesn't be
handled.

check the return value is EINVAL, if yes, directly return 0.

Signed-off-by: Koba Ko <koba.ko@canonical.com>
---
 drivers/edac/skx_common.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/edac/skx_common.c b/drivers/edac/skx_common.c
index 2a00e0503f0d5..98baed1617c9f 100644
--- a/drivers/edac/skx_common.c
+++ b/drivers/edac/skx_common.c
@@ -351,6 +351,8 @@ int skx_get_dimm_info(u32 mtr, u32 mcmtr, u32 amap, struct dimm_info *dimm,
 	ranks = numrank(mtr);
 	rows = numrow(mtr);
 	cols = imc->hbm_mc ? 6 : numcol(mtr);
+	if (ranks == -EINVAL || rows == -EINVAL || cols == -EINVAL)
+		return 0;
 
 	if (imc->hbm_mc) {
 		banks = 32;
-- 
2.34.1

