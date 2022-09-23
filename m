Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DED4C5E7334
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 07:01:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbiIWFBJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 01:01:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbiIWFBI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 01:01:08 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F17B12644D
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 22:01:05 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-3451e7b0234so97481817b3.23
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 22:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date;
        bh=daFDSoGJO9kSrGHqPw4bon34ioz/ecAvyFcmE63pSEk=;
        b=GYACt8ZMAo3l8WpXpwRvh1ZV/QgPMQY4sKUHU0FmzF5hMQbpqrQT1jVOFEoalBwZnF
         9cetOsNQnzSenFbG3crzsiSaU4RiXJPFhqI9x81/PvUIb/Qje5J0+H64d/UKtJQZZC5L
         uWvdWNNjfNi0383sWvHsxvlC6WjSOkXLEsX/KvzSyWrXErZNPSenGmJfprhTGNvD1TF6
         Q4C4bMzrmSAvb4BUSCEhn1KJrBgmdugy8IQ7ivckKcC9wix1q2l7DVYWGPZX8YqD+qLG
         yd90tAu5CI1VaqcFTI+c+JSY8GFCEMetTBWUiEUmtMp8d68iBjrUG+1ykUuubUeRnFrO
         9HmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date;
        bh=daFDSoGJO9kSrGHqPw4bon34ioz/ecAvyFcmE63pSEk=;
        b=FthyxhpGZIcs4fVTGSKiAY3k0wEtpoKWREa0wTR0wZTTx3TmOv3Gn2g4MggqrRb5x4
         UrwxkbGE2sAg1Dlg5o0EOjcR/NkAHJV3DQ5TMwcDbwp7KNdJg/HNhpFGtCk8TVFztWyA
         8NnbHyegcfIss0AIF1WSPnuSQPAgLNb207NGetcmEQNflvYqtDpO3Oebl+D165eXmvnF
         dc07wz1ZFRfOOea1kjaaKkiHtJTYVrB2Wh85GxCzqnLsL3yaNjoo2wsCVop0Jj64iCbJ
         f2dfaxzWK79blhRKJMSOJeVK/XAyiCQ0dBA9xVnjbZhHHS0jgvQbpmR69NXGFwfsi2u5
         45Xw==
X-Gm-Message-State: ACrzQf1dyWeMHWWmyDjAj9G7IjGbeH4w91W9DN7/FFq/u2jp4ehib1pp
        uHIJD3PdOEwaST71dpis/YFCCl/qmIYg1A==
X-Google-Smtp-Source: AMsMyM5E7B60nFf5LZb+hVSlJESQdtDQkBqmmnVWvuuMsiUjx0f7PPpvSbtGoMnw1NGy4nChmHeMev2peqehZg==
X-Received: from slicestar.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:20a1])
 (user=davidgow job=sendgmr) by 2002:a81:7905:0:b0:348:c973:d2c9 with SMTP id
 u5-20020a817905000000b00348c973d2c9mr6990823ywc.450.1663909264704; Thu, 22
 Sep 2022 22:01:04 -0700 (PDT)
Date:   Fri, 23 Sep 2022 13:00:39 +0800
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.3.998.g577e59143f-goog
Message-ID: <20220923050039.3371091-1-davidgow@google.com>
Subject: [PATCH] kunit: tool: Don't download risc-v opensbi firmware with wget
From:   David Gow <davidgow@google.com>
To:     Brendan Higgins <brendan.higgins@linux.dev>,
        Daniel Latypov <dlatypov@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Xu Panda <xu.panda@zte.com.cn>
Cc:     David Gow <davidgow@google.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, Zeal Robot <zealci@zte.com.cn>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When running a RISC-V test kernel under QEMU, we need an OpenSBI BIOS
file. In the original QEMU support patchset, kunit_tool would optionally
download this file from GitHub if it didn't exist, using wget.

These days, it can usually be found in the distro's qemu-system-riscv
package, and is located in /usr/share/qemu on all the distros I tried
(Debian, Arch, OpenSUSE). Use this file, and thereby don't do any
downloading in kunit_tool.

In addition, we used to shell out to whatever 'wget' was in the path,
which could have potentially been used to trick the developer into
running another binary. By not using wget at all, we nicely sidestep
this issue.

Cc: Xu Panda <xu.panda@zte.com.cn>
Fixes: 87c9c1631788 ("kunit: tool: add support for QEMU")
Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: David Gow <davidgow@google.com>
---

This is a replacement for "kunit: tool: use absolute path for wget":
https://lore.kernel.org/linux-kselftest/20220922083610.235936-1-xu.panda@zte.com.cn/

Instead of just changing the path to wget, it removes the download
option completely and grabs the opensbi-riscv64-generic-fw_dynamic.bin
from the /usr/share/qemu directory, where the distro package manager
should have put it.

I _think_ this should be okay to treat as a fix: we were always grabbing
this from the QEMU GitHub repository, so it should be widely available.
And if you want to treat the wget use as a security issue, getting rid
of it everywhere would be nice.

Thoughts?

-- David

---
 tools/testing/kunit/qemu_configs/riscv.py | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/tools/testing/kunit/qemu_configs/riscv.py b/tools/testing/kunit/qemu_configs/riscv.py
index 6207be146d26..12a1d525978a 100644
--- a/tools/testing/kunit/qemu_configs/riscv.py
+++ b/tools/testing/kunit/qemu_configs/riscv.py
@@ -3,17 +3,13 @@ import os
 import os.path
 import sys
 
-GITHUB_OPENSBI_URL = 'https://github.com/qemu/qemu/raw/master/pc-bios/opensbi-riscv64-generic-fw_dynamic.bin'
-OPENSBI_FILE = os.path.basename(GITHUB_OPENSBI_URL)
+OPENSBI_FILE = 'opensbi-riscv64-generic-fw_dynamic.bin'
+OPENSBI_PATH = '/usr/share/qemu/' + OPENSBI_FILE
 
-if not os.path.isfile(OPENSBI_FILE):
-	print('\n\nOpenSBI file is not in the current working directory.\n'
-	      'Would you like me to download it for you from:\n' + GITHUB_OPENSBI_URL + ' ?\n')
-	response = input('yes/[no]: ')
-	if response.strip() == 'yes':
-		os.system('wget ' + GITHUB_OPENSBI_URL)
-	else:
-		sys.exit()
+if not os.path.isfile(OPENSBI_PATH):
+	print('\n\nOpenSBI bios was not found in "' + OPENSBI_PATH + '".\n'
+	      'Please ensure that qemu-system-riscv is installed, or edit the path in "qemu_configs/riscv.py"\n')
+	sys.exit()
 
 QEMU_ARCH = QemuArchParams(linux_arch='riscv',
 			   kconfig='''
@@ -29,4 +25,4 @@ CONFIG_SERIAL_EARLYCON_RISCV_SBI=y''',
 			   extra_qemu_params=[
 					   '-machine', 'virt',
 					   '-cpu', 'rv64',
-					   '-bios', 'opensbi-riscv64-generic-fw_dynamic.bin'])
+					   '-bios', OPENSBI_PATH])
-- 
2.37.3.998.g577e59143f-goog

