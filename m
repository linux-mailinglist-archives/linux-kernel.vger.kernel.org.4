Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB02070E323
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 19:46:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238127AbjEWRYG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 13:24:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238126AbjEWRXy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 13:23:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 607D8E71;
        Tue, 23 May 2023 10:23:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 068656350A;
        Tue, 23 May 2023 17:22:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5083BC433EF;
        Tue, 23 May 2023 17:22:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684862575;
        bh=59Ee5xutk7/Hb+vfpH0Y/w5tXaQRPpZBjU1DCAPBef8=;
        h=From:To:Cc:Subject:Date:From;
        b=epnwLyy642Hn98YdXyGh07p3yiu6hiz99gJAfoPGe5zn3DsFsLs7sfUgVU7yONuwp
         /nzVg1ewMBKzWit535YK9fvmMaq2qhxtDIYwqMKjhnSSbTOS6ccsxblPCOMCC2f51e
         ZDtIDHAkM3VVTvMRyyr4kKAHOIk2h3gnTMKq2fT6LcYRzEnYqyGvXPUW/i1TWmxBxm
         ivvk5COkUHenMGdUJq2ji7jlhNKzzAEjo/iLs/5G1jlmzx0NJ1MtsRtuELRB9Gei+y
         aWg9fdp4zm8rhSdBx9IjGBuQ33Pfl5DPyCebNOAAXXpmObmAyy3F8FX1dSZZqdosL/
         NQcqd2H2aClzg==
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
To:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     Juri Lelli <juri.lelli@redhat.com>,
        William White <chwhite@redhat.com>,
        Daniel Bristot de Oliveira <bristot@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH V2 0/3] osnoise/timerlat improvements
Date:   Tue, 23 May 2023 19:22:45 +0200
Message-Id: <cover.1684860626.git.bristot@kernel.org>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These three patches are improvements for the osnoise/timerlat tracers,
mainly to support rtla. The first one is a dependency for the -C <cgroup>
command line option to be added to rtla. It is essential to allow
timerlat/osnoise to measure the latencies from the container/cgroup
point of view. The second improves rtla time for saving tracing after
a stop tracing condition on osnoise/hwnoise.

The third patch adds the osnoise/per_cpu/cpu$id/timerlat_fd file
where timerlat expects a pinned user thread to open and read from it.
When the thread reads it, it actually activates timerlat latency
measurement mechanism, so timerlat can be activated from an user-space
thread. Timerlat is also expanded to report the return from user-space
latency when read is called after the first call, so adding another
metric to timerlat, that can either represent the kernel-to-user and
user-to-kernel overhead, or to measure the execution time of any
workload. Details are added to the kernel documentation.

Changes from V1:
  - Added the user-space interface patch
  - Link: https://lore.kernel.org/lkml/cover.1683823114.git.bristot@kernel.org/

Daniel Bristot de Oliveira (3):
  tracing/osnoise: Switch from PF_NO_SETAFFINITY to migrate_disable
  tracing/osnoise: Skip running osnoise if all instances are off
  tracing/timerlat: Add user-space interface

 Documentation/trace/timerlat-tracer.rst |  78 +++++
 kernel/trace/trace_osnoise.c            | 411 +++++++++++++++++++++++-
 kernel/trace/trace_output.c             |   4 +-
 3 files changed, 487 insertions(+), 6 deletions(-)

-- 
2.38.1

