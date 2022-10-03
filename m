Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 065AD5F356D
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 20:17:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbiJCSRV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 14:17:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229906AbiJCSRJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 14:17:09 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AE343FEE5;
        Mon,  3 Oct 2022 11:17:08 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id y2so6833484qtv.5;
        Mon, 03 Oct 2022 11:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=6GSBpywsjKwPYr9hvx5GHTfSyCn4GlAqxJaWR8Wo4kE=;
        b=JtsL+Dx2PwQ4GX+EXm7wwyPP9y3dsNdyX+7nmSLX0Cq3G90w4rRJxpltmEa7rXfjY+
         OG2G8tLT0KaWnHBuJJ0ZoLBnyxjGA8YsgB4mJ3P0JEEdZz4vjzubMImn7cH6XxJAQDrP
         Byhg2serWd9IAnUHYDgWWR4P6SxsVi/5fclUPNvBxaMwSGiD1BxXDGvquNvcdSLtqZ+D
         bpcOJdi8C0cg20hy7dZWHUEghtfmBmQLpO+eG/1ghM84O/vZuI5sQ0PVErqlVV39C7R+
         qQMajXJrdbBAnkYcXwpMk5fiRB/NZs239qFJ8TxE1DZpDkK6jEBkNz110mFy4OFhXAj+
         zcdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=6GSBpywsjKwPYr9hvx5GHTfSyCn4GlAqxJaWR8Wo4kE=;
        b=v3b+TJZbXHTa+XuAjFjaza2PjHKnCBt3FlYGZDe1enwBt4bhLfJsPNkEKUGsruiSNP
         4qiBqilCen8HsdH27Mz/KBDrjapufE+3bssAkgBK/6E0t61+Y4eH4gm/xg264HMr2LUb
         I2uh7yg53013+puOJCG30K+ZHsDTzBp5z956/kQuGgG4p9ziii+Dlp9frg1G79UKqOgX
         kasx+gTclUV+nutah4sJFG5OInJ6eNnJlx2m/V+xZt0Q+ziQCfWfsjrYEcTh/u5IBekC
         m9yv8Y6/a+eslfwXzAeQRKSxmgJRchfcbWh1XxLsW0sdzMrvmseqjhUXXRZHElrEe5lA
         /WPg==
X-Gm-Message-State: ACrzQf3jCv0Ky/XIUsGhJCjWjFtfNHoI90cezui1g2XH/LaUN1QsAxar
        BlCNB6NwJAobGC5p906X/jifWMiJbVQUSg==
X-Google-Smtp-Source: AMsMyM4BKoUjUPYb0Jf1H5r7RchuXC609kJb0q+UHascuGJ+E6dNUcVxyxxPp+1CfrIKyYwhhRfH/Q==
X-Received: by 2002:ac8:7f4c:0:b0:35c:ceb3:4409 with SMTP id g12-20020ac87f4c000000b0035cceb34409mr16687207qtk.138.1664821027245;
        Mon, 03 Oct 2022 11:17:07 -0700 (PDT)
Received: from localhost.localdomain ([177.222.37.214])
        by smtp.googlemail.com with ESMTPSA id k6-20020ac86046000000b0035ba3cae6basm9992329qtm.34.2022.10.03.11.17.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Oct 2022 11:17:07 -0700 (PDT)
From:   Henry Castro <hcvcastro@gmail.com>
To:     namhyung@kernel.org
Cc:     Henry Castro <hcvcastro@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] perf: fix the probe finder location (.dwo files)
Date:   Mon,  3 Oct 2022 14:16:56 -0400
Message-Id: <20221003181657.4890-1-hcvcastro@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <CAM9d7ciaMJuG-LgOGoT-u2qwXp8Tk=Zb3ZJPCzA1oQN9hk5ENA@mail.gmail.com>
References: <CAM9d7ciaMJuG-LgOGoT-u2qwXp8Tk=Zb3ZJPCzA1oQN9hk5ENA@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the file object is compiled using -gsplit-dwarf,
the probe finder location will fail.

Signed-off-by: Henry Castro <hcvcastro@gmail.com>
---

> Anyway I think it'd be safer to do
>
>    if (dwarf_cu_info() == 0 && unit_type == skeleton)
>        pf->cu_die = subdie;

Thank you, I have modifed the patch :)


 tools/perf/util/probe-finder.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/probe-finder.c b/tools/perf/util/probe-finder.c
index 50d861a80f57..b27039f5f04b 100644
--- a/tools/perf/util/probe-finder.c
+++ b/tools/perf/util/probe-finder.c
@@ -1161,7 +1161,8 @@ static int debuginfo__find_probe_location(struct debuginfo *dbg,
 	struct perf_probe_point *pp = &pf->pev->point;
 	Dwarf_Off off, noff;
 	size_t cuhl;
-	Dwarf_Die *diep;
+	Dwarf_Die *diep, cudie, subdie;
+	uint8_t unit_type;
 	int ret = 0;

 	off = 0;
@@ -1200,6 +1201,14 @@ static int debuginfo__find_probe_location(struct debuginfo *dbg,
 			continue;
 		}

+#if _ELFUTILS_VERSION >= 171
+		/* Check separate debug information file. */
+		if (dwarf_cu_info(pf->cu_die.cu, NULL, &unit_type,
+				  &cudie, &subdie, NULL, NULL, NULL) == 0
+		    && unit_type == DW_UT_skeleton)
+			pf->cu_die = subdie;
+#endif
+
 		/* Check if target file is included. */
 		if (pp->file)
 			pf->fname = cu_find_realpath(&pf->cu_die, pp->file);
--
2.20.1

