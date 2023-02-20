Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1410169D404
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 20:18:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232489AbjBTTSo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 14:18:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232968AbjBTTSl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 14:18:41 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 709122D43
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 11:18:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E4D7AB80ACE
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 18:57:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1465FC433EF;
        Mon, 20 Feb 2023 18:57:56 +0000 (UTC)
Date:   Mon, 20 Feb 2023 13:57:55 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Andreas Ziegler <br015@umbiko.net>,
        Daniel Bristot de Oliveira <bristot@kernel.org>,
        zhang songyi <zhang.songyi@zte.com.cn>
Subject: [GIT PULL] tracing/tools: Updates for 6.3
Message-ID: <20230220135755.0fff5d29@gandalf.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Linus,

Tracing tools updates for 6.3:

- Use total duration to calculate average in rtla osnoise_hist

- Use 2 digit precision for displaying average

- Print an intuitive auto analysis of timerlat results

- Add auto analysis to timerlat top

- Add hwnoise, which is the same as osnoise but focuses on hardware

- Small clean ups


Please pull the latest trace-tools-v6.3 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
trace-tools-v6.3

Tag SHA1: 82adfaeb36c268c3e988c7c5a106e45be68e9778
Head SHA1: 5dc3750e747f93f9bb7987da3d47a8ab4a5a181e


Andreas Ziegler (2):
      tools/tracing/rtla: osnoise_hist: use total duration for average calculation
      tools/tracing/rtla: osnoise_hist: display average with two-digit precision

Daniel Bristot de Oliveira (5):
      rtla/timerlat: Add auto-analysis core
      rtla/timerlat: Add auto-analysis support to timerlat top
      Documentation/rtla: Add timerlat-top auto-analysis options
      rtla: Add hwnoise tool
      Documentation/rtla: Add hwnoise man page

zhang songyi (1):
      tools/rv: Remove unneeded semicolon

----
 Documentation/tools/rtla/common_timerlat_aa.rst |   7 +
 Documentation/tools/rtla/index.rst              |   1 +
 Documentation/tools/rtla/rtla-hwnoise.rst       | 107 +++
 Documentation/tools/rtla/rtla-timerlat-top.rst  | 164 ++--
 tools/tracing/rtla/Makefile                     |   2 +
 tools/tracing/rtla/src/osnoise.c                | 117 +++
 tools/tracing/rtla/src/osnoise.h                |   7 +
 tools/tracing/rtla/src/osnoise_hist.c           |   9 +-
 tools/tracing/rtla/src/osnoise_top.c            |  84 +-
 tools/tracing/rtla/src/rtla.c                   |   4 +
 tools/tracing/rtla/src/timerlat_aa.c            | 990 ++++++++++++++++++++++++
 tools/tracing/rtla/src/timerlat_aa.h            |  12 +
 tools/tracing/rtla/src/timerlat_top.c           |  46 +-
 tools/tracing/rtla/src/utils.h                  |   3 +
 tools/verification/rv/src/in_kernel.c           |   2 +-
 15 files changed, 1442 insertions(+), 113 deletions(-)
 create mode 100644 Documentation/tools/rtla/common_timerlat_aa.rst
 create mode 100644 Documentation/tools/rtla/rtla-hwnoise.rst
 create mode 100644 tools/tracing/rtla/src/timerlat_aa.c
 create mode 100644 tools/tracing/rtla/src/timerlat_aa.h
---------------------------
