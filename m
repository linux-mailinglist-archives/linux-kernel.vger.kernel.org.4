Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0E7A60E4FE
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 17:48:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230090AbiJZPs1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 11:48:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbiJZPsY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 11:48:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 056D0B44B5;
        Wed, 26 Oct 2022 08:48:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A287561F58;
        Wed, 26 Oct 2022 15:48:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09066C433C1;
        Wed, 26 Oct 2022 15:48:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666799303;
        bh=1HSFtAPGOzdvwrfNsDe8arVdzJ63E2LnDE/GDXS52kk=;
        h=From:To:Cc:Subject:Date:From;
        b=gikfRXG+ErmX9Ajb3d95lQ6+XgRKuMazJOmyy6CEN9O49/iwymebWv/hpVSJBrNdU
         lXMhOQh8RcwRyRJDMIUManzgGfmCpNVa7/BH5jHZyrEfq8lzr4DrAS6hj0RK1QrnLM
         AkIabh3Iqt1Zmp+RwXGWRn07M6kPooL3IGvgeQWb+XzA4+ANwH9aGw2oZQpE3VVzcA
         +1M2VCmdrMljNa0eShh73hfKlMhWHZk37DnawseyQxa7unUX9DXadMGFZ4/NSUy60X
         DGPMLFgDrL6KyLWSPR4Ch1Ek4Kb2Z5JXx/mzKnL2++QFN8C9+z7lC+9PLn2z1fdHxC
         I254KJHHBQyAA==
From:   "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Primiano Tucci <primiano@google.com>
Subject: [PATCH v2 0/2] tracing/probes: Add 'symstr' type for probes
Date:   Thu, 27 Oct 2022 00:48:19 +0900
Message-Id: <166679929981.1528100.11309260111368557859.stgit@devnote3>
X-Mailer: git-send-email 2.38.0.135.g90850a2211-goog
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here is the 2nd version of the patches to add the 'symstr' type for
kprobe/eprobe events.
This version removes redundant strlen()[1/2] and fixes indentation
[2/2].

This type converts given value into kernel symbol string and stores
it as a dymanic symbol in the trace ring buffer entry. Thus, user who
reads the raw ring buffer data doesn't need to resolve the symbol
name afterwards.

This is similar to the existing 'symbol' type. The 'symbol' type
stores the address value itself to the entry, it only *shows* the
symbol name when it is printed.

Thank you,

---

Masami Hiramatsu (Google) (2):
      tracing/probes: Add symstr type for dynamic events
      tracing/probes: Reject symbol/symstr type for uprobe


 Documentation/trace/kprobetrace.rst                |    8 ++
 kernel/trace/trace.c                               |    2 -
 kernel/trace/trace_probe.c                         |   65 +++++++++++++-------
 kernel/trace/trace_probe.h                         |   19 ++++--
 kernel/trace/trace_probe_tmpl.h                    |   47 ++++++++++++++
 kernel/trace/trace_uprobe.c                        |    3 +
 .../ftrace/test.d/kprobe/uprobe_syntax_errors.tc   |    5 ++
 7 files changed, 113 insertions(+), 36 deletions(-)

--
Masami Hiramatsu (Google) <mhiramat@kernel.org>
