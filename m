Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F34863668A
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 18:06:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238812AbiKWRGg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 12:06:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238690AbiKWRGc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 12:06:32 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42044BF5B4;
        Wed, 23 Nov 2022 09:06:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CCC3D61DEF;
        Wed, 23 Nov 2022 17:06:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BBC0C433C1;
        Wed, 23 Nov 2022 17:06:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669223190;
        bh=raX6akcTkcf94fDBWr2weUqJN699PklrJUOtVV4UPsg=;
        h=From:To:Cc:Subject:Date:From;
        b=FyBzlHOtAqIryiVDYDdALpZCsmCQMjHFa+Yo8TPGNOLMfJYZTDdtpO0J6vdIZwpRx
         0sejUyHuKc5FQmK13fIXompgybi8O+jRJ8wXdqGi1Ig1igEuks5L/uTa9cTUW3d1e6
         Wu3vL3qMLyCVdnpgGyWp/PGMe0JmqMYQYjLO5SBqtKyyvRyINZRbc9XbU2kuNw03u4
         ajq33AoxWS8sgUAnBwCPLFnyovBMqQwFAaJxGxXnW3xa5zncHW9JJYDM9N76UoncOd
         ///9jk93Tj+abpKGJrQ1NQDfFiiFhL+HKLgvqBE7gBi/U4WlNEZ31pkreNo08j8upw
         fZuYjUiQwoNug==
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
To:     Daniel Bristot de Oliveira <bristot@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Juri Lelli <juri.lelli@redhat.com>,
        Clark Williams <williams@redhat.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V2 0/6] Add osnoise/options file
Date:   Wed, 23 Nov 2022 18:06:18 +0100
Message-Id: <cover.1669115208.git.bristot@kernel.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Was: Allow osnoise tracer to run without workload [1]

After adding the osnoise/options file, a set of on/off options
came to my mind, most based on discussions while debugging problems
with Juri and Clark.

So, this series now goes beyond running osnoise without a workload
by adding a set of practical options using the new osnoise/options file.

The [NO_]OSNOISE_WORKLOAD option allows the tracer to be dispatched
without workload, making the osnoise: tracepoints to become
generic events to measure the execution time of *any* task on Linux.

The PANIC_ON_STOP option facilitates the vmcore generation to aid
in the latency analysis using a crash dump.

The OSNOISE_PREEMPT_DISABLE and OSNOISE_IRQ_DISABLE options refine
the type of noise that the osnoise tracer detects, allowing the
tool to measure only IRQ-related noise, or NMI/HW-related noise,
respectively.

Each patch has a description of the options and the last patch
documents them in the osnoise documentation file.

[1] https://lore.kernel.org/r/cover.1668692096.git.bristot@kernel.org/

Changes from v1:
  - Changed the cover letter topic
  - Add Acked-by Masami to the first patch
  - Add the PANIC_ON_STOP option
  - Add the OSNOISE_PREEMPT_DISABLE and OSNOISE_IRQ_DISABLE options
  - Improved the documentationa

Daniel Bristot de Oliveira (6):
  tracing/osnoise: Fix duration type
  tracing/osnoise: Add osnoise/options file
  tracing/osnoise: Add OSNOISE_WORKLOAD option
  tracing/osnoise: Add PANIC_ON_STOP option
  tracing/osnoise: Add preempt and/or irq disabled options
  Documentation/osnoise: Add osnoise/options documentation

 Documentation/trace/osnoise-tracer.rst |  32 +++-
 kernel/trace/trace_osnoise.c           | 242 +++++++++++++++++++++++--
 2 files changed, 261 insertions(+), 13 deletions(-)

-- 
2.32.0

