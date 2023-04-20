Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA9956E94B9
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 14:40:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232560AbjDTMjn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 08:39:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232657AbjDTMjg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 08:39:36 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06AA96A4B
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 05:39:27 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3f173af665fso4173675e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 05:39:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google; t=1681994365; x=1684586365;
        h=user-agent:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dYfVS08kxs8OVYC1ESyMcBXOaimmmrC9jvQr/qzMgk8=;
        b=PzR6A+qJwzOHwbO/ndc6BCDxt1YCgfwxoBqIX9FyPYw/PffXIftTq85+tWAOdo8AFe
         dPELGqjWron5vvqTZQJYSRohzqQvFVjYEDHjJFEPsbwJnGpcuxDrOERpLx2iaNNDEHmb
         8mVrXjMxsxNNYoKHFw3zOtDqTk/mwkDxiySCE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681994365; x=1684586365;
        h=user-agent:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dYfVS08kxs8OVYC1ESyMcBXOaimmmrC9jvQr/qzMgk8=;
        b=AO9Wt2Cznq2hFp/U9HzDeRmTwXKQaSBsRLklu0qKb0zyN3vbk8oEUEWiNYeobt1poZ
         YktNISFWe4s3ab+18y7FuZ18CMAq2lL5pFb1J8LM3mykt3Dfhc7kYQFdPCEXowRRQCyn
         ap4opmrVxa9VK9qJURP9tmPBbVkKt8kTamkinxbk74ABzpNiEWrEGHL7PgaFQ4RPri7A
         e001BnzcvNAp3rEamipGcLrbFL5J5a6v09E+bQlyxLqfkuco54K2DBsMT+a5OaQfLq7O
         MfJhE4nylVIDCKTRIORaDfxxZte0MnDZ2nzDDfrMV49jPuhAQsCg6E5iAcRKQjDP9nBm
         xtPQ==
X-Gm-Message-State: AAQBX9fHCR847m+GAOB8ArCdsWZENzrSxByM50MaNqFx7uGNJCMLszNw
        R0lvfyCAcEJpmP6ybRM4ZIhR4LN47phflU2hE4s=
X-Google-Smtp-Source: AKy350bx/ZtlYgyoOQMwj1P+53wFjA/u+HwJcSrxovcJbghEiCi0mC5XhMUWQ5A8uUIgDq9neQe0DQ==
X-Received: by 2002:adf:e381:0:b0:2f9:a75:b854 with SMTP id e1-20020adfe381000000b002f90a75b854mr1331572wrm.59.1681994364998;
        Thu, 20 Apr 2023 05:39:24 -0700 (PDT)
Received: from localhost ([2a01:4b00:8432:8600:5ee4:2aff:fe50:f48d])
        by smtp.gmail.com with ESMTPSA id z17-20020adfdf91000000b002d97529b3bbsm1840877wrl.96.2023.04.20.05.39.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Apr 2023 05:39:24 -0700 (PDT)
Date:   Thu, 20 Apr 2023 13:39:23 +0100
From:   Chris Down <chris@chrisdown.name>
To:     linux-kernel@vger.kernel.org
Cc:     Petr Mladek <pmladek@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>, kernel-team@fb.com
Subject: [PATCH v4 0/2] printk: console: Per-console loglevels
Message-ID: <cover.1681994220.git.chris@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v4:

- Change base to Linus' master
- Use SRCU iterators for console walks
- Override per-console loglevels on magic sysrq
- Fix htmldocs
- Fix mistaken __user annotation in sysctl callbacks
- Consistently use indexed names (eg. ttyS0 instead of ttyS)
- Remove "The loglevel for a console can be set in many places" comment
- Remove CON_LOGLEVEL flag and infer based on >0
- Open code our dev_get_drvdata console stashing
- Split out console_effective_loglevel functions per Petr's suggestion
- Make boot_delay_msec/printk_delay check if it would be emitted
- Simplify warning on SYSLOG_ACTION_CONSOLE_LEVEL
- Save/restore ignore_per_console_loglevel on SYSLOG_ACTION_CONSOLE_{ON,OFF}
- Unify min/max level checks across sysfs/proc/syslog
- Add find_and_remove_console_option to avoid affecting io/mmio options

v3:

- Update to work with John's kthread patches
- Remove force_console_loglevel, now we only have global and local levels
- Remove minimum_console_loglevel control and document how to change it
- The minimum loglevel is now only honoured on setting global/local level
- Add ignore_per_console_loglevel
- Return -EINVAL if trying to set below minimum console level
- Add parser for named console= options
- Fix docs around ignore_loglevel: it can be changed at runtime
- Fix ordering in "in order of authority" docs
- Remove duplicated default_console_loglevel doc
- Only warn once on syslog() use

v2:

- Dynamically allocate struct device*
- Document sysfs attributes in Documentation/ABI/
- Use sysfs_emit() instead of sprintf() in dev sysfs files
- Remove WARN_ON() for device_add/IS_ERR(console_class)
- Remove "soon" comment for kernel.printk
- Fix !CONFIG_PRINTK build
- Fix device_unregister() NULL dereference if called before class setup
- Add new documentation to MAINTAINERS

Chris Down (2):
  printk: Do not delay messages which aren't solicited by any console
  printk: console: Support console-specific loglevels

 Documentation/ABI/testing/sysfs-class-console |  47 ++
 Documentation/admin-guide/index.rst           |   1 +
 .../admin-guide/kernel-parameters.txt         |  28 +-
 .../admin-guide/per-console-loglevel.rst      |  92 ++++
 Documentation/admin-guide/serial-console.rst  |  17 +-
 Documentation/core-api/printk-basics.rst      |  35 +-
 Documentation/networking/netconsole.rst       |  17 +
 MAINTAINERS                                   |   3 +
 drivers/tty/sysrq.c                           |  15 +
 include/linux/console.h                       |   3 +
 include/linux/printk.h                        |   9 +
 kernel/printk/console_cmdline.h               |   2 +
 kernel/printk/printk.c                        | 415 +++++++++++++++++-
 kernel/printk/sysctl.c                        |  57 ++-
 14 files changed, 691 insertions(+), 50 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-class-console
 create mode 100644 Documentation/admin-guide/per-console-loglevel.rst


base-commit: cb0856346a60fe3eb837ba5e73588a41f81ac05f
-- 
2.40.0

