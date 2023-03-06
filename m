Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4678B6ACF10
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 21:22:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229922AbjCFUWE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 15:22:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbjCFUWD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 15:22:03 -0500
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79AAE41085
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 12:21:59 -0800 (PST)
Received: by mail-oi1-x22f.google.com with SMTP id bj30so8043296oib.6
        for <linux-kernel@vger.kernel.org>; Mon, 06 Mar 2023 12:21:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678134119;
        h=content-disposition:mime-version:message-id:subject:cc:to:date:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rjh5313+lNLNBn9qtKrg0K3oWlUG9WFggauLgoLDzwY=;
        b=otU1NypzZXkcqKgdOxkjnx3sLsho10l81OF7MDg6n++slA0SUt5EOiNyxFNBw6FAoB
         DO+Yc0q/bY24zlde5NGfD+rHoT86myEKj8+TOSK5EWAam181sQ8mJTNTtyVIHag+ooLY
         VIh0OyFICZ8gN16vHqTEixbT7vxQqjWMckFxGKPw/LYirB10K4RTS/wVv/bO1lvqwAf4
         27vLiqM8JymbuXFwy1bpa++uvmikz6dg7prV06f3QMADgN3WLMvAy2dlIB8JpFZOv91W
         3RGI+Etkct0ztJT08guy7Z3cifF8qJVEW2KgzLYF5mcTPxMte3IwTHyHKSDAADK2JqFY
         jhrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678134119;
        h=content-disposition:mime-version:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rjh5313+lNLNBn9qtKrg0K3oWlUG9WFggauLgoLDzwY=;
        b=EJcsxadcp8mrRwsawmBVy1fXiCTou+7ahlGd03lHH/pICM23MZQwTicEQS7oDxyGNc
         HNA2sjyfJaxvMaOn506SsIKjmlVu2MYZAU8Bdtnlk+jvxEXWkxgJ/8ntC6mkEoINk8KF
         JM7PCmxz+yrPh2Wyzk12W7GqaXF8ZSK1lOxgyUIXwNyxJ1TTflp3tr23JMC3LeqGr+Qv
         zgK/fbahSD2oenEFG8f3nrmtYlaw2LJgWVQB+hH0vFyz2yEdJNQ5DImmm988OZssnEAd
         rNsV7rAjYdN0FPsWu+TIILtv8oK4uY387FH3OA0A2VQRpxQppXSo5ODbmg/jUaQATQe2
         7zXw==
X-Gm-Message-State: AO0yUKUyMN9mx/ZLFbxWdY5Qoskkbk4bGlAmaABH6OFDQIlntCAgB7Ty
        FZJsq1oGdZJ3OhgLekHWPrgnzfDh2Ec=
X-Google-Smtp-Source: AK7set+WhVPDAUagR83iid419kBUurbajemebIZfNnB+BAOu+37ZWkbqjkwMAw8YElKnmwOT6D71NA==
X-Received: by 2002:aca:91a:0:b0:384:4e2d:81e5 with SMTP id 26-20020aca091a000000b003844e2d81e5mr5487900oij.29.1678134117319;
        Mon, 06 Mar 2023 12:21:57 -0800 (PST)
Received: from quaco.ghostprotocols.net ([187.19.237.165])
        by smtp.gmail.com with ESMTPSA id t39-20020a05680815a700b003848dbe505fsm4297437oiw.57.2023.03.06.12.21.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Mar 2023 12:21:56 -0800 (PST)
From:   arnaldo.melo@gmail.com
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 37C9D4049F; Mon,  6 Mar 2023 17:21:54 -0300 (-03)
Date:   Mon, 6 Mar 2023 17:21:54 -0300
To:     linux-kernel@vger.kernel.org
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Rob Herring <robh@kernel.org>, Will Deacon <will@kernel.org>
Subject: [PATCH 1/1 fyi] tools headers UAPI: Sync linux/perf_event.h with the
 kernel sources
Message-ID: <ZAZLYmDjWjSItWOq@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tldr; Just FYI, I'm carrying this on the perf tools tree.

- Arnaldo

Full explanation:

There used to be no copies, with tools/ code using kernel headers
directly. From time to time tools/perf/ broke due to legitimate kernel
hacking. At some point Linus complained about such direct usage. Then we
adopted the current model.

The way these headers are used in perf are not restricted to just
including them to compile something.

There are sometimes used in scripts that convert defines into string
tables, etc, so some change may break one of these scripts, or new MSRs
may use some different #define pattern, etc.

E.g.:

  $ ls -1 tools/perf/trace/beauty/*.sh | head -5
  tools/perf/trace/beauty/arch_errno_names.sh
  tools/perf/trace/beauty/drm_ioctl.sh
  tools/perf/trace/beauty/fadvise.sh
  tools/perf/trace/beauty/fsconfig.sh
  tools/perf/trace/beauty/fsmount.sh
  $
  $ tools/perf/trace/beauty/fadvise.sh
  static const char *fadvise_advices[] = {
  	[0] = "NORMAL",
  	[1] = "RANDOM",
  	[2] = "SEQUENTIAL",
  	[3] = "WILLNEED",
  	[4] = "DONTNEED",
  	[5] = "NOREUSE",
  };
  $

The tools/perf/check-headers.sh script, part of the tools/ build
process, points out changes in the original files.

So its important not to touch the copies in tools/ when doing changes in
the original kernel headers, that will be done later, when
check-headers.sh inform about the change to the perf tools hackers.

---

To pick up the changes in:

  09519ec3b19e4144 ("perf: Add perf_event_attr::config3")

The patches for the tooling side will come later.

This addresses this perf build warning:

  Warning: Kernel ABI header at 'tools/include/uapi/linux/perf_event.h' differs from latest version at 'include/uapi/linux/perf_event.h'
  diff -u tools/include/uapi/linux/perf_event.h include/uapi/linux/perf_event.h

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Rob Herring <robh@kernel.org>
Cc: Will Deacon <will@kernel.org>
Link: https://lore.kernel.org/lkml/
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/uapi/linux/perf_event.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/include/uapi/linux/perf_event.h b/tools/include/uapi/linux/perf_event.h
index ccb7f5dad59be96b..37675437b76860ae 100644
--- a/tools/include/uapi/linux/perf_event.h
+++ b/tools/include/uapi/linux/perf_event.h
@@ -374,6 +374,7 @@ enum perf_event_read_format {
 #define PERF_ATTR_SIZE_VER5	112	/* add: aux_watermark */
 #define PERF_ATTR_SIZE_VER6	120	/* add: aux_sample_size */
 #define PERF_ATTR_SIZE_VER7	128	/* add: sig_data */
+#define PERF_ATTR_SIZE_VER8	136	/* add: config3 */
 
 /*
  * Hardware event_id to monitor via a performance monitoring event:
@@ -515,6 +516,8 @@ struct perf_event_attr {
 	 * truncated accordingly on 32 bit architectures.
 	 */
 	__u64	sig_data;
+
+	__u64	config3; /* extension of config2 */
 };
 
 /*
-- 
2.39.2

