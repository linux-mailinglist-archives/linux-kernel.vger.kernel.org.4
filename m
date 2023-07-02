Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C98E2744E27
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jul 2023 16:47:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229825AbjGBOrU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jul 2023 10:47:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229820AbjGBOrR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jul 2023 10:47:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CE2BE69;
        Sun,  2 Jul 2023 07:47:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B4BE360C24;
        Sun,  2 Jul 2023 14:47:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2FEBC433C7;
        Sun,  2 Jul 2023 14:47:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688309232;
        bh=NE8PEQN12084oUP0Abj3l7PmrEJhGLdJ3PPpfuZyPXQ=;
        h=From:To:Cc:Subject:Date:From;
        b=o7VJaVVP+yFrou3rGDgyKtZxqDlIzMNgeodlGTQarzx4hfQ71NjwId+IwqTtbEeby
         HfMeo6fEYVQKTFRVPIgoH1A30tmPBNelCKM550c/DokC/ZnEP8JPdSX6P2gms27xvO
         t4ba2XQNPm6aggM1TdY8LhMx31h0YA8/nZ6jtbC9RUdVOrIwT+P+pWUpELphl2GkOH
         6e58i7SlZdbvB/qJRwu+3zh+H+0wPumsCJe5yGhz/MTen/Yndvi1rwHAuRnbejhQcf
         JefvG9uUZVMde7PrMyXsX46bSPh6DA4QfeqpUbKD00zJY+eCAdin7nm5a77PKsDKUy
         bqz8lQ9p5ZLXA==
From:   "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Dan Carpenter <dan.carpenter@linaro.org>,
        linux-trace-kernel@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH 0/3] tracing/probes: Fix bugs in process_fetch_insn
Date:   Sun,  2 Jul 2023 23:47:08 +0900
Message-ID:  <168830922841.2278819.9165254236027770818.stgit@mhiramat.roam.corp.google.com>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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

Hi,

Here are some patches to fix bugs in process_fetch_insn_*(). 
First 2 fixes are already reviewed and updated the description.
I added 1 new patch which I found while fixing previous one.

Thank you,

---

Masami Hiramatsu (Google) (3):
      tracing/probes: Fix to avoid double count of the string length on the array
      tracing/probes: Fix to exit fetching if an error is detected
      tracing/probes: Fix return value when "(fault)" is injected


 kernel/trace/trace_probe_kernel.h                  |   17 +++++++----------
 kernel/trace/trace_probe_tmpl.h                    |    6 ++++--
 .../ftrace/test.d/kprobe/kprobe_args_user.tc       |    2 +-
 3 files changed, 12 insertions(+), 13 deletions(-)

--
Masami Hiramatsu (Google) <mhiramat@kernel.org>
