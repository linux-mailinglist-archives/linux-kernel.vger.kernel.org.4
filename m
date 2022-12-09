Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65F4B648A8D
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 23:07:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230181AbiLIWHA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 17:07:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229897AbiLIWG3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 17:06:29 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5804A5DE3;
        Fri,  9 Dec 2022 14:06:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6905BB82939;
        Fri,  9 Dec 2022 22:06:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19DBCC433EF;
        Fri,  9 Dec 2022 22:05:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670623562;
        bh=xhGA8QOjljLpEDGY+74NnEPLPXQ6/MDsLE1V+TwRSe8=;
        h=From:To:Cc:Subject:Date:From;
        b=NGeEu4h2Y1MVWU4BWOQxmqfv2h7Q8r8v8gTd9KD2Q36leUgDTC07dNWqj4ttEXKw5
         DQQb7Dlbme3iIr7rdkAsOV+g2k50nQgrefzyb3UaUN2yZVj+STDNCgNEzbmjX16+82
         +Z854OJlLNnp8XPhKizSEOIKzZ0fxir4hKSJF4A99mbrSya+JMOlI8nhPhT+WsCT51
         nKDXbIkEurHeB09Zn2Dda454f8JAcmieoNtDpZo7kaYI9dLlX3c5BCyC06zYFM+Ttj
         OkP4GKIB9wkfU58gh+a6KrbBWZYmXnUAtvEuo+oVmFFS/lUxmEXRgdb05Bo6brcNAU
         kjm8W7GtkP/6w==
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
To:     Daniel Bristot de Oliveira <bristot@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Juri Lelli <juri.lelli@redhat.com>,
        Clark Williams <williams@redhat.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V5 0/3] Add osnoise/options options
Date:   Fri,  9 Dec 2022 23:05:51 +0100
Message-Id: <cover.1670623111.git.bristot@kernel.org>
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

After adding the osnoise/options file, a set of on/off options
came to my mind, most based on discussions while debugging problems
with Juri and Clark.

The PANIC_ON_STOP option facilitates the vmcore generation to aid
in the latency analysis using a crash dump.

The OSNOISE_PREEMPT_DISABLE and OSNOISE_IRQ_DISABLE options refine
the type of noise that the osnoise tracer detects, allowing the
tool to measure only IRQ-related noise, or NMI/HW-related noise,
respectively.

Each patch has a description of the options and the last patch
documents them in the osnoise documentation file.

[1] https://lore.kernel.org/r/cover.1668692096.git.bristot@kernel.org/

Changes from V4:
  - rename preempt_disable/irq_disable variables to
    disable_preemption/disable_irq (Steven Rostedt)
Changes from V3:
  - Fix documentation (Bagas Sanjaya)
  - Optmize the preempt disable option (Steven Rostedt)
Changes from v2:
  - rebased on top of linux-trace.git/ftrace/core
  - removed the patches already added to the ftrace/core
Changes from v1:
  - Changed the cover letter topic
  - Add Acked-by Masami to the first patch
  - Add the PANIC_ON_STOP option
  - Add the OSNOISE_PREEMPT_DISABLE and OSNOISE_IRQ_DISABLE options
  - Improved the documentation

Daniel Bristot de Oliveira (3):
  tracing/osnoise: Add PANIC_ON_STOP option
  tracing/osnoise: Add preempt and/or irq disabled options
  Documentation/osnoise: Add osnoise/options documentation

 Documentation/trace/osnoise-tracer.rst | 20 +++++++++-
 kernel/trace/trace_osnoise.c           | 52 +++++++++++++++++++++++---
 2 files changed, 65 insertions(+), 7 deletions(-)

-- 
2.32.0

