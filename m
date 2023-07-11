Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFB4874E3F2
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 04:11:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231177AbjGKCLW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 22:11:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229936AbjGKCLV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 22:11:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64035E1;
        Mon, 10 Jul 2023 19:11:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EEDB861143;
        Tue, 11 Jul 2023 02:11:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A14FC433C7;
        Tue, 11 Jul 2023 02:11:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689041479;
        bh=m5zH5mj7zoJ1f1B+N42bt19Cic4vyFBBXFpmA2ahLKY=;
        h=From:To:Cc:Subject:Date:From;
        b=tlYYHe4Rh8gRp18dK7OwlfbtZDz3o6//XRmKFGCilyOCEehKXK7sk1pSnNr9frOxX
         QDrlz0XK3OqbgBED3VESg+ZCpOPYW3H8h38zQwHHrLIP/9ynKKokYkcKHecsJnOjvT
         nWJRyiTmqHVuzNgzxsqpYQ9Fvaej/kukm7afFmiDg4RW+FT7HU3LaZtc7TxlFpMqpI
         tDdHA/y051j2xb5ACi/+7nbMvSU658nG0YNyjQujPVnBeH1/LQHnrd7mExEISQXrWB
         bT/DsaH4lmqJoJUSY0RwIlcmdnFfir8MLmYq/UtzG9KxAkQgivp7t/IHRsGydIoNmB
         iNTj7hp6cUC9w==
From:   "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Dan Carpenter <dan.carpenter@linaro.org>,
        linux-trace-kernel@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH v4 0/4] tracing/probes: Fix bugs in process_fetch_insn
Date:   Tue, 11 Jul 2023 11:11:15 +0900
Message-ID:  <168904147563.2908673.18054267804278861545.stgit@mhiramat.roam.corp.google.com>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here are the 4th version of fix bugs in process_fetch_insn_*().
The previous version is here;

https://lore.kernel.org/all/168878450334.2721251.3030778817503575503.stgit@mhiramat.roam.corp.google.com/

[4/4] is updated to simplify the code with set_data_loc().

Thank you,

---

Masami Hiramatsu (Google) (4):
      tracing/probes: Fix to avoid double count of the string length on the array
      tracing/probes: Fix not to count error code to total length
      Revert "tracing: Add "(fault)" name injection to kernel probes"
      tracing/probes: Fix to record 0-length data_loc in fetch_store_string*() if fails


 kernel/trace/trace.h              |    2 ++
 kernel/trace/trace_probe.c        |    2 +-
 kernel/trace/trace_probe_kernel.h |   30 ++++++++----------------------
 kernel/trace/trace_probe_tmpl.h   |   10 +++++-----
 kernel/trace/trace_uprobe.c       |    3 ++-
 5 files changed, 18 insertions(+), 29 deletions(-)

--
Masami Hiramatsu (Google) <mhiramat@kernel.org>
