Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83EB87375F6
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 22:19:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230144AbjFTUTN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 16:19:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230269AbjFTUSo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 16:18:44 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2742C1BE2;
        Tue, 20 Jun 2023 13:18:24 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id 98e67ed59e1d1-25e8545ea28so3967855a91.0;
        Tue, 20 Jun 2023 13:18:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687292303; x=1689884303;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7i2JmSY9J3aXJvNYPDUup2Ul0DqDLcLtP/gbsQnodQE=;
        b=W8W+BdRt47e/1zKvDQJQnbDBHt7693qHLovnUIQ4uE5CXmd9dMCfnD2MGkzow/fKZB
         oX826Ny5CGbeXF7gc3uzhRp6pX+oi6bdQV+8+Tc67ZQIXRHBunU+rxV9uf7n7rdGnoi3
         pine2IzdUCi28NsDa+D1A0HeMv5EtmmGzCcdrH69IiyU58mOGhQntPVmOFuV4Dwh082I
         XXEoNlyXPNrIfs/d842vRHoCEMeoLhbJaPAUciK+hIZF3ZcihjdrswIHe/QKSihZzVvJ
         3MAxxBrr66S3SmDW3ifM25R53thQ4Y+Zhhjbe3x7ftfBIN3loCKIEYC080Fd0+Vz9v/a
         NnWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687292303; x=1689884303;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7i2JmSY9J3aXJvNYPDUup2Ul0DqDLcLtP/gbsQnodQE=;
        b=Bt8B27D5PoUsSNaBZzBklVXUP30kVfoMesUHXiOIUo8Ninb+oxRgP2SxqAfUe7gxkV
         2vnNTt4sBx+hHYISoDsJ9491bL4dZSjDSZtEb7UNQ7TY5U9Wt47yIbqSYrj0SuHnyA6o
         d1WsGmgSB67vM2jjMOHdCmqgoK3JDIwUz7OeveEgUKeiNihcBcFSDuMc83oGAc49Enal
         uPTh+HgsVbtw+0x5/AsHtzlNWqkAVAwGIuQ0YrOG7bTiCoe3u9Wg80Vtf8T9f3Pnkkf7
         8JW0HXL8G+gdOd5lrjAe8OSEHFwlecw9LHQevpjUD+4DiKU5dOeTXW8CiI1Q1CnlJ0qL
         xunA==
X-Gm-Message-State: AC+VfDzSjnwCBz1S/fmMcQDCGfZP8gUN2zI6DIbFRXeuguesND24idLr
        xACXaUDKSjB8XkFxgrVWfrO3d7Z6bSg=
X-Google-Smtp-Source: ACHHUZ4ZhJTLvcJ3h8h4oNTVB5V4MUma8P4fNHtwJNoPl0Mu/nkXDWfVFvNfLys/9A92/L8b89D22A==
X-Received: by 2002:a17:90a:35b:b0:259:bf40:b571 with SMTP id 27-20020a17090a035b00b00259bf40b571mr13450471pjf.45.1687292303485;
        Tue, 20 Jun 2023 13:18:23 -0700 (PDT)
Received: from bangji.hsd1.ca.comcast.net ([2601:647:6700:7f00:2824:dc1c:af73:dbd8])
        by smtp.gmail.com with ESMTPSA id 27-20020a17090a01db00b0025c23bb7fdasm8191774pjd.16.2023.06.20.13.18.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 13:18:23 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org
Subject: [PATCH 3/3] perf machine: Include data symbols in the kernel map
Date:   Tue, 20 Jun 2023 13:18:18 -0700
Message-ID: <20230620201818.1670753-3-namhyung@kernel.org>
X-Mailer: git-send-email 2.41.0.185.g7c58973941-goog
In-Reply-To: <20230620201818.1670753-1-namhyung@kernel.org>
References: <20230620201818.1670753-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When perf record -d is used, it needs data mmaps to symbolize global data.
But it missed to collect kernel data maps so it cannot symbolize them.
Instead of having a separate map, just increase the kernel map size to
include the data section.

Probably we can have a separate kernel map for data, but the current
code assumes a single kernel map.  So it'd require more changes in other
places and looks error-prone.  I decided not to go that way for now.

Also it seems the kernel module size already includes the data section.

For example, my system has the following.

  $ grep -e _stext -e _etext -e _edata /proc/kallsyms
  ffffffff99800000 T _stext
  ffffffff9a601ac8 T _etext
  ffffffff9b446a00 D _edata

Size of the text section is (0x9a601ac8 - 0x99800000 = 0xe01ac8) and
size of the data section is (0x9b446a00 - 0x99800000 = 0x1c46a00).

Before:
  $ perf record -d true

  $ perf report -D | grep MMAP | head -1
  0 0 0x460 [0x60]: PERF_RECORD_MMAP -1/0: [0xffffffff99800000(0xe01ac8) @ 0xffffffff99800000]: x [kernel.kallsyms]_text
                                                               ^^^^^^^^
                                                                 here
After:
  $ perf report -D | grep MMAP | head -1
  0 0 0x460 [0x60]: PERF_RECORD_MMAP -1/0: [0xffffffff99800000(0x1c46a00) @ 0xffffffff99800000]: x [kernel.kallsyms]_text
                                                               ^^^^^^^^^

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/machine.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index ddc0a2130caf..e93a66f6e0b3 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -1218,7 +1218,10 @@ static int machine__get_running_kernel_start(struct machine *machine,
 
 	*start = addr;
 
-	err = kallsyms__get_function_start(filename, "_etext", &addr);
+	if (machine->has_data_mmap)
+		err = kallsyms__get_symbol_start(filename, "_edata", &addr);
+	else
+		err = kallsyms__get_function_start(filename, "_etext", &addr);
 	if (!err)
 		*end = addr;
 
-- 
2.41.0.185.g7c58973941-goog

