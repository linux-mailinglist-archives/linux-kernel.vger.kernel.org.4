Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2B6B672AFF
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 23:02:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbjARWCX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 17:02:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229935AbjARWBt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 17:01:49 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 699821042E
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 14:01:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0549061A30
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 22:01:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E739C433D2;
        Wed, 18 Jan 2023 22:01:47 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1pIGV8-002H8r-0y;
        Wed, 18 Jan 2023 17:01:46 -0500
Message-ID: <20230118215435.016435760@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 18 Jan 2023 16:54:35 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     "John Warthog9 Hawley" <warthog9@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [for-linus][PATCH 0/3] ktest.pl: Fix ssh hanging and reseting of console
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I've noticed that my ssh sessions would hang during test runs, which
is really frustrating when you kick off a 13 hour test before going to
bed, and the second test (1 hour into it) hangs, and you need to kick
it off again in the morning (wasting all that time over night).

I finally figured out the cause. There is a disconnect between
the run_command that executes the test, and the "wait_for_input" that
monitors the test. The wait_for_input has a default of 2 minute timeout
if it doesn't see any output it returns. The run_command takes the
empty string from wait_for_input as the test is finished, and then
stops monitoring it, and calls waitpid() waiting for the test to
exit.

The problem is that if the test has a lot of output, it will continue
writing into the pipe that was suppose to go to the monitor, which has
now exited the loop. When the pipe fills up, it will not finish.
When the test is over, it just hangs waiting for the pipe to flush
(which never happens).

To fix this, change the run_command to by default have an infinite
run (which can be overridden by the new RUN_TIMEOUT option), and
make the wait_for_input also wait indefinitely in this case. It now
Now the tests will have its content continuously read and will exit
normally.

While debugging this, I also found out why you can lose stdout on
the terminal sometimes. Especially if you hit Ctrl^C while the monitor
is running. It was due to missing "end_monitor" which gives back the
tty to the terminal. The first two patches fix that.



  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-ktest.git
devel

Head SHA1: aa9aba9382884554fe6a303744884866d137422d


Steven Rostedt (3):
      ktest.pl: Fix missing "end_monitor" when machine check fails
      ktest.pl: Give back console on Ctrt^C on monitor
      ktest.pl: Add RUN_TIMEOUT option with default unlimited

----
 tools/testing/ktest/ktest.pl    | 26 +++++++++++++++++++++-----
 tools/testing/ktest/sample.conf |  5 +++++
 2 files changed, 26 insertions(+), 5 deletions(-)
