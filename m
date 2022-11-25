Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DF37639101
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 22:20:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230001AbiKYVUh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 16:20:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiKYVUg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 16:20:36 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D27E2F3A3;
        Fri, 25 Nov 2022 13:20:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4A599B82AEF;
        Fri, 25 Nov 2022 21:20:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6352C433D6;
        Fri, 25 Nov 2022 21:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669411232;
        bh=b1KDjzdBxZ5ZP4MTzrX/vz5Qwe5SW+/B/zXMrOEAQRM=;
        h=From:To:Cc:Subject:Date:From;
        b=sqZJcWvIO1ktGavI5TdEpsnAt1tct+5WL+8rpdcnZ2secZ1RZyPH1ZLEnYL5WBBE9
         dixKel+U9OnnaRCHUqB//R+I+0EMYY7h3RoUt481+tgmTCKYdNiFgoxd/00TI6bnAe
         ENuS2LZRPBl46eQ8b/FmZG64x3+WaZL3x75WlKL9whrOl4PNO8T+z3vagJWkvUaD5A
         tksmJqssmS6Gef9SLuk5hgSsj/mPx8kI0kqFuZorJy9x3OFYn48U0CiKik3XA/S1dL
         AmbzsRsdsr9UOc31sTZ+qwFY6rdFn6nx7tTszV1xQhx30wCIAskQO3QvcLJkYFXlpj
         OI+gyPyhYCPCw==
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
To:     Daniel Bristot de Oliveira <bristot@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Juri Lelli <juri.lelli@redhat.com>,
        Clark Williams <williams@redhat.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V3 0/3] Add osnoise/options options
Date:   Fri, 25 Nov 2022 22:20:21 +0100
Message-Id: <cover.1669409262.git.bristot@kernel.org>
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

The PANIC_ON_STOP option facilitates the vmcore generation to aid
in the latency analysis using a crash dump.

The OSNOISE_PREEMPT_DISABLE and OSNOISE_IRQ_DISABLE options refine
the type of noise that the osnoise tracer detects, allowing the
tool to measure only IRQ-related noise, or NMI/HW-related noise,
respectively.

Each patch has a description of the options and the last patch
documents them in the osnoise documentation file.

[1] https://lore.kernel.org/r/cover.1668692096.git.bristot@kernel.org/

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

 Documentation/trace/osnoise-tracer.rst | 20 ++++++++++--
 kernel/trace/trace_osnoise.c           | 44 +++++++++++++++++++++++---
 2 files changed, 57 insertions(+), 7 deletions(-)

-- 
2.32.0

