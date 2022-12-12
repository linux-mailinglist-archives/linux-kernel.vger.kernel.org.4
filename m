Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8272764ABBC
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 00:47:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233632AbiLLXra (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 18:47:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234159AbiLLXq5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 18:46:57 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 112BD1CFE0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 15:46:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BCE03B8101B
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 23:46:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8AA2C433D2;
        Mon, 12 Dec 2022 23:46:28 +0000 (UTC)
Date:   Mon, 12 Dec 2022 18:46:27 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Daniel Bristot de Oliveira <bristot@kernel.org>,
        John Kacur <jkacur@redhat.com>
Subject: [GIT PULL] tracing/tools: Updates for 6.2
Message-ID: <20221212184627.3ce2d748@gandalf.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Linus,

tracing tools for 6.2

- New tool "rv" for starting and stopping runtime verification:

   example: ./rv mon wip -r printk -v

   Enables the wake-in-preempt monitor and the printk reactor in verbose mode

- Fix exit status of rtla usage() calls


Please pull the latest trace-tools-6.2 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
trace-tools-6.2

Tag SHA1: 6ce4c3327f4a4d41d299c8ffac95a3013ab0da8b
Head SHA1: afc70ccb962861e068e04c6089827493f5160a0a


Daniel Bristot de Oliveira (3):
      rv: Add rv tool
      tools/rv: Add in-kernel monitor interface
      Documentation/rv: Add verification/rv man pages

John Kacur (1):
      rtla: Fix exit status when returning from calls to usage()

----
 Documentation/tools/index.rst              |   1 +
 Documentation/tools/rv/Makefile            |  52 +++
 Documentation/tools/rv/common_appendix.rst |  16 +
 Documentation/tools/rv/common_ikm.rst      |  21 +
 Documentation/tools/rv/index.rst           |  24 +
 Documentation/tools/rv/rv-list.rst         |  43 ++
 Documentation/tools/rv/rv-mon-wip.rst      |  44 ++
 Documentation/tools/rv/rv-mon-wwnr.rst     |  43 ++
 Documentation/tools/rv/rv-mon.rst          |  55 +++
 Documentation/tools/rv/rv.rst              |  63 +++
 tools/tracing/rtla/src/osnoise.c           |   9 +-
 tools/tracing/rtla/src/rtla.c              |  12 +-
 tools/tracing/rtla/src/timerlat.c          |   9 +-
 tools/verification/rv/Makefile             | 141 ++++++
 tools/verification/rv/README.txt           |  38 ++
 tools/verification/rv/include/in_kernel.h  |   3 +
 tools/verification/rv/include/rv.h         |  12 +
 tools/verification/rv/include/trace.h      |  16 +
 tools/verification/rv/include/utils.h      |   8 +
 tools/verification/rv/src/in_kernel.c      | 698 +++++++++++++++++++++++++++++
 tools/verification/rv/src/rv.c             | 188 ++++++++
 tools/verification/rv/src/trace.c          | 133 ++++++
 tools/verification/rv/src/utils.c          |  47 ++
 23 files changed, 1659 insertions(+), 17 deletions(-)
 create mode 100644 Documentation/tools/rv/Makefile
 create mode 100644 Documentation/tools/rv/common_appendix.rst
 create mode 100644 Documentation/tools/rv/common_ikm.rst
 create mode 100644 Documentation/tools/rv/index.rst
 create mode 100644 Documentation/tools/rv/rv-list.rst
 create mode 100644 Documentation/tools/rv/rv-mon-wip.rst
 create mode 100644 Documentation/tools/rv/rv-mon-wwnr.rst
 create mode 100644 Documentation/tools/rv/rv-mon.rst
 create mode 100644 Documentation/tools/rv/rv.rst
 create mode 100644 tools/verification/rv/Makefile
 create mode 100644 tools/verification/rv/README.txt
 create mode 100644 tools/verification/rv/include/in_kernel.h
 create mode 100644 tools/verification/rv/include/rv.h
 create mode 100644 tools/verification/rv/include/trace.h
 create mode 100644 tools/verification/rv/include/utils.h
 create mode 100644 tools/verification/rv/src/in_kernel.c
 create mode 100644 tools/verification/rv/src/rv.c
 create mode 100644 tools/verification/rv/src/trace.c
 create mode 100644 tools/verification/rv/src/utils.c
---------------------------
