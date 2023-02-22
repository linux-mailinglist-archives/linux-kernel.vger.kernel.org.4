Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C413069F6FE
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 15:47:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232183AbjBVOrZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 09:47:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231174AbjBVOrT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 09:47:19 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D869A3B65C
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 06:46:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E4CBE61480
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 14:46:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 394E9C433EF;
        Wed, 22 Feb 2023 14:46:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677077216;
        bh=ZfJtndrFWcZCScshDBOMweySQa8G/TRdKVrKnsxi7mE=;
        h=From:To:Cc:Subject:Date:From;
        b=A/l1QU7asZery8BgIzMySL+Y+ue3oCTe2bQWVfG6Jgxp8DxbM4JKBmYYkCyMKITUu
         j5YtM1PCJb+JMbXpMcQHoxXFXYI5EhByvrx/0NBFi4lWgxLItg/IQAONlNS1ekgEe+
         FoRxmVYPzLQEji9Ij33zM7Hen4TSUMJrPqIioA6RQUVc49J4GC0Uis5VEAx85Tn9le
         fJxtQznb8uNVafgBljCv6kRl2OHSY0Z30Kd7y3AyieQonfrg/GSrlBio+bpt/Bte5u
         94+n1rQQUxyYETJifcoSrReSQND9l2ymlar429hmxl8TJqcAhfhLnrpd8m7CW1ZEyb
         n27iMcty6enSA==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Wei Li <liwei391@huawei.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>,
        Yu Liao <liaoyu15@huawei.com>, Hillf Danton <hdanton@sina.com>,
        Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 0/8] timers/nohz: Fixes and cleanups v3
Date:   Wed, 22 Feb 2023 15:46:41 +0100
Message-Id: <20230222144649.624380-1-frederic@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Try to (partially) fix the issue reported in https://lore.kernel.org/lkml/20230128020051.2328465-1-liaoyu15@huawei.com/

Changes since v2:

* Keep the monotonicity check against /proc/uptime first field
* Add monotonicity test between clock_gettime(CLOCK_BOOTTIME) and
  /proc/uptime

git://git.kernel.org/pub/scm/linux/kernel/git/frederic/linux-dynticks.git
	timers/core-v2

HEAD: 45034144d493f62516285d7ec8bcd6408653d056

Thanks,
	Frederic
---

Frederic Weisbecker (8):
      timers/nohz: Restructure and reshuffle struct tick_sched
      timers/nohz: Only ever update sleeptime from idle exit
      timers/nohz: Protect idle/iowait sleep time under seqcount
      timers/nohz: Add a comment about broken iowait counter update race
      timers/nohz: Remove middle-function __tick_nohz_idle_stop_tick()
      MAINTAINERS: Remove stale email address
      selftests/proc: Remove idle time monotonicity assertions
      selftests/proc: Assert clock_gettime(CLOCK_BOOTTIME) VS /proc/uptime monotonicity


 MAINTAINERS                                    |   2 +-
 kernel/time/tick-sched.c                       | 135 ++++++++++++-------------
 kernel/time/tick-sched.h                       |  67 +++++++-----
 tools/testing/selftests/proc/proc-uptime-001.c |  25 +++--
 tools/testing/selftests/proc/proc-uptime-002.c |  27 +++--
 tools/testing/selftests/proc/proc-uptime.h     |  28 ++---
 6 files changed, 159 insertions(+), 125 deletions(-)
