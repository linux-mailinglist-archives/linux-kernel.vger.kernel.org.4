Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC4F26EE276
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 15:06:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233685AbjDYNG0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 09:06:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbjDYNGY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 09:06:24 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2233610C
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 06:06:22 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-508418b6d59so10577349a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 06:06:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google; t=1682427980; x=1685019980;
        h=user-agent:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=f4JUO4YXA0ma7919A++Kq/CnoiX6aejq3rVfiMJYAPE=;
        b=k+V1dAuYJtRQmXzzYwXOGWcKJxHf7YFbQy/kvJA5BLUAHxbnonVk0BednrBNc17sut
         hQq8inKO3JogWNEVXNm0Ynw3RzNMVDw0H34r0vJRkP5Z87VwVXQFZ6cC5io8AFy3XJZf
         qeOsBjfVKorCY/UbV8MrTyimOiztmpzMqYCxA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682427980; x=1685019980;
        h=user-agent:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f4JUO4YXA0ma7919A++Kq/CnoiX6aejq3rVfiMJYAPE=;
        b=aI2sJxKMdqrw+MYGmX4WtaXmH6WpEUtS0CAnX1bjplFC+UoyCYUAYJhlF+d5YAwFYy
         k/EM1b5Y+sv53yM+hdSNGONVuJeZtlw2AalTqtmeqIo1HoI7znB6HVVg9e3Pg2wdizu8
         NDy59m427eZgIz1Tfh9ZJhELVSVCSJQrvSLaTxCRI8XBWm+crw2JgiEl7K5Qp/p2xIyI
         42dHTMX+01wFux27aZP6Sf4OODtdLJJ2umZcnr3UFE3sSFfsC0hOHHTQASy5ydRR79xd
         +LA0EM/oLbEpFNhyD5pnEFOtKfKu1utQr09QvDef3wxuRDKOdG2Cn8QVVNmo5m7raYlw
         ZBGg==
X-Gm-Message-State: AAQBX9e2ePrulujhIIpEFXeS+tcdxV+0PLM+calRb9wl7+MEthLREP2U
        Lqt9LFBwDQgQL+iWu5RN2FsAH1EcaLP1f+oUVTw=
X-Google-Smtp-Source: AKy350ZgnZZuKQx/ex23GOosF27XEEH5Ogz2xQgs/S/TTOKKZnDdY1xEJcVkKGVcWjf7gJyLCqQgTg==
X-Received: by 2002:aa7:d88c:0:b0:506:be07:3473 with SMTP id u12-20020aa7d88c000000b00506be073473mr15901744edq.4.1682427979973;
        Tue, 25 Apr 2023 06:06:19 -0700 (PDT)
Received: from localhost ([2620:10d:c092:500::5:530d])
        by smtp.gmail.com with ESMTPSA id k2-20020a056402048200b00501c96564b5sm5425186edv.93.2023.04.25.06.06.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Apr 2023 06:06:19 -0700 (PDT)
Date:   Tue, 25 Apr 2023 14:06:19 +0100
From:   Chris Down <chris@chrisdown.name>
To:     linux-kernel@vger.kernel.org
Cc:     Petr Mladek <pmladek@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>, kernel-team@fb.com
Subject: [PATCH v5 0/2] printk: console: Per-console loglevels
Message-ID: <cover.1682427812.git.chris@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v5:

- Fix syntax in boot_delay

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
 kernel/printk/printk.c                        | 417 +++++++++++++++++-
 kernel/printk/sysctl.c                        |  57 ++-
 14 files changed, 692 insertions(+), 51 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-class-console
 create mode 100644 Documentation/admin-guide/per-console-loglevel.rst


base-commit: 61d325dcbc05d8fef88110d35ef7776f3ac3f68b
-- 
2.40.0

