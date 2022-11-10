Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 507686242EB
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 14:09:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230315AbiKJNJs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 08:09:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229836AbiKJNJj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 08:09:39 -0500
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 009A2303
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 05:09:37 -0800 (PST)
Received: from localhost.localdomain (unknown [83.149.199.65])
        by mail.ispras.ru (Postfix) with ESMTPSA id 61F0C419E9C7;
        Thu, 10 Nov 2022 13:09:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 61F0C419E9C7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
        s=default; t=1668085775;
        bh=QKRldkNPYPt/lxrJmQHe3NOj7qGdMmBSfUtKl9GPzw0=;
        h=From:To:Cc:Subject:Date:From;
        b=iT+2QmtCgDQ1V/+kmlqRxiafacUM+NOZ+OEApljYS0R24EJrHu7IgAD1LebefH/RR
         kFQGsVPF38EyRh6+ZMLeekY7m5BIqqV9hXvkMlvuJzsLFyvY+q2irSOCH//lECcFoD
         FGCpKgkUqLNI2KO718Xe7oICZTMyn4qFdrAPqANk=
From:   Evgeniy Baskov <baskov@ispras.ru>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Evgeniy Baskov <baskov@ispras.ru>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Alexey Khoroshilov <khoroshilov@ispras.ru>
Subject: [PATCH v8 0/5] Parse CONFIG_CMDLINE in compressed kernel
Date:   Thu, 10 Nov 2022 16:09:28 +0300
Message-Id: <cover.1668082601.git.baskov@ispras.ru>
X-Mailer: git-send-email 2.37.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CONFIG_CMDLINE_BOOL and CONFIG_CMDLINE_OVERRIDE were ignored during
options lookup in compressed kernel, including earlyprintk option,
so it was impossible to get earlyprintk messages from that stage
of boot process via command line provided at compile time.
Being able to enable earlyprintk via compile-time option might
be desirable for booting on systems with broken UEFI command line
arguments via EFISTUB.

Changes in v2:

* Compute resulting cmdline string once if needed and then reuse it.
  Store concatenation result in a static buffer.
* Add strlcat() to compressed kernel to simplify the code.

Changes in v3:

v2 had a bug: cmd_line_ptr was set to a pointer to a buffer inside
a kernel before kernel relocation, that makes this pointer invalid.

* Replace the pointer by a boolean variable to avoid storing a pointer,
  since it becomes invalid during kernel relocation.

Changes in v4:

* Use better wording for commit messages.
* Add buffer overflow check to strlcat().
* Factor out common logic of cmdline resolving into helper function.

Changes in v5:

* Use strscpy() instead of strlcpy().

Changes in v6:

* Remove superfluous new line.
* Rename resolve_cmdline() to cmdline_prepare().
* Move shared/setup-cmdline.h to shared/cmdline.h

Changes in v7:

* Replace #ifdef with IS_ENABLED() in cmdline_prepare()
  for consistency.

Changes in v8:

* Remove the need to use special initial value for command line result
  variable and put all logic in one function to improve the clarity
  of the code.

One #ifdef is still required for the initial value of builtin cmdline
in case iti is not defined to enable the use of IS_ENABLED in
cmdline_prapare(), since it is more readable.

Evgeniy Baskov (5):
  x86/boot: Add strlcat() and strscpy() to compressed kernel
  x86: Add cmdline_prepare() helper
  x86/setup: Use cmdline_prepare() in setup.c
  x86/boot: Use cmdline_prapare() in compressed kernel
  x86/boot: Remove no longer needed includes

 arch/x86/boot/compressed/cmdline.c      | 24 +++++++++++-
 arch/x86/boot/compressed/ident_map_64.c |  4 --
 arch/x86/boot/compressed/kaslr.c        |  4 --
 arch/x86/boot/compressed/misc.h         |  1 +
 arch/x86/boot/compressed/string.c       | 50 +++++++++++++++++++++++++
 arch/x86/include/asm/shared/cmdline.h   | 35 +++++++++++++++++
 arch/x86/kernel/setup.c                 | 20 ++--------
 arch/x86/purgatory/purgatory.c          |  1 +
 8 files changed, 112 insertions(+), 27 deletions(-)
 create mode 100644 arch/x86/include/asm/shared/cmdline.h

-- 
2.37.4

