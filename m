Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F14A462C957
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 20:56:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234314AbiKPT4c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 14:56:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231221AbiKPT4a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 14:56:30 -0500
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B085D64A23
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 11:56:28 -0800 (PST)
Received: by mail-qt1-x832.google.com with SMTP id w9so1592339qtv.13
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 11:56:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=unotCeI+jeIlE1s8Z495KMzeSar7HGNW9+QZlv24Mc0=;
        b=JLXjqnMarhoB443eFEIA54k6GJ0U0S4rNPJ+GyGzrlLZpjYobZRmXxOcntlkxNdK66
         AoE6GZqDSOLngKrVX+i5I2dmc7rroyWGTD0qxilI+Xy00RY4voMkQn3fR+OP74VVfdCb
         w2Wi2Q6Az3wxXFI4KnwCfAcHn9CGbzckViPKw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=unotCeI+jeIlE1s8Z495KMzeSar7HGNW9+QZlv24Mc0=;
        b=eKUwMP30vkbCdCu/TgulQS2hZimMfDIfjZqoX77TvN9xw0eHT8UT22kQoS7T04Zs04
         W8ewWTFrxz5yCryOkwBHVfTpAGYVlqLpqs62xGmwlzoroTEWHM//7BFSu7PJAz1795T4
         gyUTqyuhwB2qtqjpoQ0wWmopnSyxtcD/t8RzELPkHYah1L/15e/Y/9w8qF/Ls6jOXyxH
         ww3hTj1gLAxYrc4IUd80Ptbl1z0HT1rxl9zg8AYCJKkMn3Loh7Rz6YSBcKCPyR0cyedj
         PRufTQSFP+JuyPA2dQRXnNwBlCbO7RWcAghHbhpma8vc7NPdv2xZj5axBWVrfhW6KYKD
         GcvA==
X-Gm-Message-State: ANoB5pmTtXgxQ0Kx9K78f7tsX5hQ7xzonR68Kq5/WuBZZvAUe2zM7spV
        IZ9zDNy34ttsyyCdVG/WAhfrqs1zHDmzgA==
X-Google-Smtp-Source: AA0mqf5zbBn4zYWKsWWXd4ugdUWjcPVGndvzFtw4YUKhlueTCEBUHl4UpJ5zN1OhsT0rWKd51pNFQA==
X-Received: by 2002:ac8:100d:0:b0:3a5:2751:ce81 with SMTP id z13-20020ac8100d000000b003a52751ce81mr22369259qti.322.1668628587639;
        Wed, 16 Nov 2022 11:56:27 -0800 (PST)
Received: from joelboxx.c.googlers.com.com (228.221.150.34.bc.googleusercontent.com. [34.150.221.228])
        by smtp.gmail.com with ESMTPSA id 3-20020a05620a070300b006ce9e880c6fsm10345986qkc.111.2022.11.16.11.56.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 11:56:27 -0800 (PST)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        rostedt@goodmis.org, ribalda@google.com, zwisler@google.com,
        robdclark@gmail.com, Eric Biederman <ebiederm@xmission.com>,
        kexec@lists.infradead.org
Subject: [PATCH RFC] kexec: Freeze processes before kexec
Date:   Wed, 16 Nov 2022 19:56:24 +0000
Message-Id: <20221116195624.124092-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.38.1.584.g0f3c55d4c2-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During kexec, it is possible for userspace to race with
device_shutdown() causing accesses to GPU after pm_runtime suspend has
already happened. Fix by freezing userspace before device_shutdown().

Such freezing is already being done if kernel supports KEXEC_JUMP and
kexec_image->preserve_context is true. However, doing it if either of
these are not true prevents crashes/races.

This fixes the following crash during kexec reboot on an ARM64 device
with adreno GPU:

[  292.534314] Kernel panic - not syncing: Asynchronous SError Interrupt
[  292.534323] Hardware name: Google Lazor (rev3 - 8) with LTE (DT)
[  292.534326] Call trace:
[  292.534328]  dump_backtrace+0x0/0x1d4
[  292.534337]  show_stack+0x20/0x2c
[  292.534342]  dump_stack_lvl+0x60/0x78
[  292.534347]  dump_stack+0x18/0x38
[  292.534352]  panic+0x148/0x3b0
[  292.534357]  nmi_panic+0x80/0x94
[  292.534364]  arm64_serror_panic+0x70/0x7c
[  292.534369]  do_serror+0x0/0x7c
[  292.534372]  do_serror+0x54/0x7c
[  292.534377]  el1h_64_error_handler+0x34/0x4c
[  292.534381]  el1h_64_error+0x7c/0x80
[  292.534386]  el1_interrupt+0x20/0x58
[  292.534389]  el1h_64_irq_handler+0x18/0x24
[  292.534395]  el1h_64_irq+0x7c/0x80
[  292.534399]  local_daif_inherit+0x10/0x18
[  292.534405]  el1h_64_sync_handler+0x48/0xb4
[  292.534410]  el1h_64_sync+0x7c/0x80
[  292.534414]  a6xx_gmu_set_oob+0xbc/0x1fc
[  292.534422]  a6xx_get_timestamp+0x40/0xb4
[  292.534426]  adreno_get_param+0x12c/0x1e0
[  292.534433]  msm_ioctl_get_param+0x64/0x70
[  292.534440]  drm_ioctl_kernel+0xe8/0x158
[  292.534448]  drm_ioctl+0x208/0x320
[  292.534453]  __arm64_sys_ioctl+0x98/0xd0
[  292.534461]  invoke_syscall+0x4c/0x118
[  292.534467]  el0_svc_common+0x98/0x104
[  292.534473]  do_el0_svc+0x30/0x80
[  292.534478]  el0_svc+0x20/0x50
[  292.534481]  el0t_64_sync_handler+0x78/0x108
[  292.534485]  el0t_64_sync+0x1a4/0x1a8
[  292.534632] Kernel Offset: 0x1a5f800000 from 0xffffffc008000000
[  292.534635] PHYS_OFFSET: 0x80000000
[  292.534638] CPU features: 0x40018541,a3300e42
[  292.534644] Memory Limit: none

Cc: rostedt@goodmis.org
Cc: ribalda@google.com
Cc: zwisler@google.com
Cc: robdclark@gmail.com
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/kexec_core.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index ca2743f9c634..2614a7f1f8a6 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -1175,6 +1175,12 @@ int kernel_kexec(void)
 	} else
 #endif
 	{
+		error = freeze_processes();
+		if (error) {
+			error = -EBUSY;
+			goto Unlock;
+		}
+
 		kexec_in_progress = true;
 		kernel_restart_prepare("kexec reboot");
 		migrate_to_reboot_cpu();
-- 
2.38.1.584.g0f3c55d4c2-goog

