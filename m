Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6940639030
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 20:10:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229969AbiKYTKZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 14:10:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbiKYTKP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 14:10:15 -0500
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C95D55C9D;
        Fri, 25 Nov 2022 11:10:12 -0800 (PST)
From:   =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=weissschuh.net;
        s=mail; t=1669403409;
        bh=g/SxQQpcICtujmdjN+34deYm/7mbOuynAwNDgxwnZRI=;
        h=From:To:Cc:Subject:Date:From;
        b=Bq/Y7NRturTvjRkhWN5xLm7MCA+plFgO7mBnfnJEPJqytptvWZS4NpKEGtEeb8L5+
         r8xCRXvbU6Nu5ZWOlx2tS47vqY8egIroPDXME/m8Z/T7PXtN6kBpN9+IKnrZYZTIeA
         Z/7P3wObBzTderaOTTi5RUATuLPaFHAXUaY1AOmA=
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        linux-pm@vger.kernel.org, Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andy Whitcroft <apw@canonical.com>,
        Joe Perches <joe@perches.com>
Cc:     =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH v2 0/3] printk: introduce new macros pr_<level>_cont()
Date:   Fri, 25 Nov 2022 20:09:45 +0100
Message-Id: <20221125190948.2062-1-linux@weissschuh.net>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=ed25519-sha256; t=1669403373; l=1346; i=linux@weissschuh.net; s=20211113; h=from:subject; bh=g/SxQQpcICtujmdjN+34deYm/7mbOuynAwNDgxwnZRI=; b=cJBM5DFWiGF9QnAVkNtozi6pqByCpuEASnEYQnyrCxmVjHyA1kV5rp0QeDjmRHHqmQ3N1OgkRmMt ipaSdfSSCfm0BDAhn8ROkPjNvwylA/wZdinAiayUOOKci5E9L3nQ
X-Developer-Key: i=linux@weissschuh.net; a=ed25519; pk=9LP6KM4vD/8CwHW7nouRBhWLyQLcK1MkP6aTZbzUlj4=
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds new printk wrapper macros pr_<level>_cont().
These create continuation messages with an explicit level.

Explicit levels are useful when a continuation message is split from its main
message. Without the explicit level KERN_DEFAULT ("warn" by default) is used
which can lead to stray partial log messages when filtering by level.

Also checkpatch is modified to recommend the new macros over plain pr_cont().

Lastly the new macros are used in kernel/power/process.c as this file uses
continuation messages during system suspend-resume which creates a high
likelyhood of interspersed messages.

Changelog:

This was original a single patch but was expanded into a series.

v1: https://lore.kernel.org/lkml/20221121050946.3540-1-linux@weissschuh.net/
v1 -> v2:
  * Introduce new pr_<level>_cont() macros in printk.h
  * Add checkpatch.pl validation

Thomas Weißschuh (3):
  printk: introduce new macros pr_<level>_cont()
  checkpatch: handle new pr_<level>_cont macros
  power: process: use explicit levels for printk continuations

 include/linux/printk.h | 23 +++++++++++++++++++++++
 kernel/power/process.c | 18 +++++++++---------
 scripts/checkpatch.pl  | 10 ++++++++--
 3 files changed, 40 insertions(+), 11 deletions(-)


base-commit: 0b1dcc2cf55ae6523c6fbd0d741b3ac28c9f4536
-- 
2.38.1

