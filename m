Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B2DA74F37E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 17:32:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232383AbjGKPcT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 11:32:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232243AbjGKPcR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 11:32:17 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CD88ED;
        Tue, 11 Jul 2023 08:32:16 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 17BB722724;
        Tue, 11 Jul 2023 15:32:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1689089535; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=WhVOBmTkvX5Yn7jpRUVGFl+hIu6p2Hs/7XqxlXkfIA8=;
        b=MZjChiLgNZKvQmv0tVIAliYRwhstqe1f31P9kGY8cEew/jlNbN8HnnpLQHWoI4NdfC+UwC
        e+CdRjvv0zaDMQ1db94BfGFxdGiDDw+HpU43XGI+edaGkzvWaNhE8vrw6CuobRm2EaoiUu
        k1kqepReQsITyhpEj9gv4EmkCiqXikc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1689089535;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=WhVOBmTkvX5Yn7jpRUVGFl+hIu6p2Hs/7XqxlXkfIA8=;
        b=7GTOZt4Ni28BiPz+U5RqpkWF8v/p3k1Gq6bQhtzx6gsFk1MjJmd/XxXpV12PIG2JbICQ7f
        ZfT7YxEHFNz28ZAw==
Received: from kitsune.suse.cz (kitsune.suse.cz [10.100.12.127])
        by relay2.suse.de (Postfix) with ESMTP id AE0312C142;
        Tue, 11 Jul 2023 15:32:14 +0000 (UTC)
From:   Michal Suchanek <msuchanek@suse.de>
To:     linux-modules@vger.kernel.org
Cc:     Michal Suchanek <msuchanek@suse.de>, Takashi Iwai <tiwai@suse.com>,
        Lucas De Marchi <lucas.de.marchi@gmail.com>,
        =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
        Jiri Slaby <jslaby@suse.com>, Jan Engelhardt <jengelh@inai.de>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] kmod /usr support
Date:   Tue, 11 Jul 2023 17:31:15 +0200
Message-ID: <20230711153126.28876-1-msuchanek@suse.de>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

with these patches it is possible to install kernel modules under an
arbitrary prefix - eg. moving the /lib/modules to /usr/lib/modules with
/usr prefix.

While the modprobe.d and depmod.d search which already includes multiple
paths is expanded to also include $(prefix) the module directory still
supports only one location, only a different one under $(module_prefix).

Having kmod search multiple module locations while only one is supported
now might break some assumption about relative modulke path
corresponding to a specific file, would require more invasive changes to
implement, and is not supportive of the goal of moving the modules away
from /lib.

Both kmod and the kernel need to be patched to make use of this feature.
Patched kernel is backwards compatible with older kmod.  Patched kmod
with empty $(module_prefix) is equivalent to unpatched kmod.

Thanks

Michal

Link: https://lore.kernel.org/linux-modules/20210112160211.5614-1-msuchanek@suse.de/

Michal Suchanek (4):
  man/depmod.d: Fix incorrect /usr/lib search path
  libkmod, depmod: Load modprobe.d, depmod.d from $prefix/lib.
  kmod: Add config command to show compile time configuration as JSON
  libkmod, depmod, modprobe: Search for kernel modules under
    ${module_prefix}

 Makefile.am                          |   4 +-
 configure.ac                         |   7 ++
 libkmod/libkmod.c                    |   7 +-
 man/Makefile.am                      |  10 ++-
 man/depmod.d.xml                     |   9 ++-
 man/depmod.xml                       |   4 +-
 man/kmod.xml                         |   6 ++
 man/modinfo.xml                      |   2 +-
 man/modprobe.d.xml                   |   1 +
 man/modprobe.xml                     |   2 +-
 man/modules.dep.xml                  |   6 +-
 testsuite/module-playground/Makefile |   2 +-
 testsuite/setup-rootfs.sh            | 109 +++++++++++++++------------
 testsuite/test-depmod.c              |  16 ++--
 testsuite/test-testsuite.c           |   8 +-
 tools/depmod.c                       |   7 +-
 tools/kmod.c                         |  40 ++++++++++
 tools/modinfo.c                      |   4 +-
 tools/modprobe.c                     |   4 +-
 tools/static-nodes.c                 |   6 +-
 20 files changed, 166 insertions(+), 88 deletions(-)

-- 
2.41.0

