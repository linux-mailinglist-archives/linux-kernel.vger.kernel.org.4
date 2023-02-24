Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7946E6A1F73
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 17:16:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229697AbjBXQQl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 11:16:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbjBXQQj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 11:16:39 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49D44662A7
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 08:16:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CF0BE61931
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 16:16:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7EB3C433EF;
        Fri, 24 Feb 2023 16:16:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677255395;
        bh=8kFvvwmGdcovrRpFteebWcbCfvFm1+UVCsUXEm+MzcE=;
        h=Date:From:To:Cc:Subject:From;
        b=Gi3tbYpxORtHTY/3RrSVJ/Jj+9k9Pdim/gjCtMzQKOx3VtZZwPjNsmuSlv8BCFEGR
         hlviccj2B6CPInU6ePKbvniY7wZtV51WQ8g5puS8pz+7Ah87OpHFSGpCXaPQlgX/do
         plk4ISLDym7m6cB9bRk1H3GqTHuCgEyW2tcnRjcURUWMYuNf6en3z0TvMMMGQORDkz
         QEgRJsnCLsDDtx1qHBZAwehanynQqoOrc0Ei3yZ5+n0DL7ExYLgcXl/aRChGD88INO
         Gi2gXr/5SO5N/XdD1Fu0g2j4hVf50FVn6qd1kS+6qd7cBVVe/MAdVZpcJeN4vpw9Ti
         KKGOn8wKgTy9g==
Date:   Sat, 25 Feb 2023 01:16:31 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Song Chen <chensong_2000@189.cn>
Subject: [GIT PULL]: probes: Cleanup updates for v6.3
Message-Id: <20230225011631.4ab2a1f82b888845285eedf8@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Sorry, I missed 3 cleanups in the previous PR. Here is the additional
one I made.

probes cleanup updates for v6.3:

These are the probe events cleanup patches, no new features but improve
readability.

- Rename print_probe_args() to trace_probe_print_args() and un-inlined.

- Introduce a set of default data fetch functions for dynamic probe
  events.

- Extract common code of data fetch process of dynamic probe events.


Please pull the latest probes-v6.3-2 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
probes-v6.3-2

Tag SHA1: 698cb027e2e06f52b23c5107e0bda683aca38e77
Head SHA1: bd78acc89d4147aa4897a4c43e2a74c7df999b12


Song Chen (3):
      kernel/trace: Introduce trace_probe_print_args and use it in *probes
      kernel/trace: Provide default impelentations defined in trace_probe_tmpl.h
      kernel/trace: extract common part in process_fetch_insn

----
 kernel/trace/trace_eprobe.c       | 83 +++++----------------------------------
 kernel/trace/trace_events_synth.c |  6 +--
 kernel/trace/trace_kprobe.c       | 72 +++------------------------------
 kernel/trace/trace_probe.c        | 27 +++++++++++++
 kernel/trace/trace_probe.h        |  2 +
 kernel/trace/trace_probe_kernel.h | 30 +++++++++++---
 kernel/trace/trace_probe_tmpl.h   | 48 ++++++++++------------
 kernel/trace/trace_uprobe.c       | 13 +++---
 8 files changed, 96 insertions(+), 185 deletions(-)
---------------------------

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
