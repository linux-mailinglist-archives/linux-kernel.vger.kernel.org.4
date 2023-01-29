Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3B606802ED
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 00:22:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235075AbjA2XWZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 18:22:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjA2XWX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 18:22:23 -0500
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED9F84694;
        Sun, 29 Jan 2023 15:22:22 -0800 (PST)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-163bd802238so984077fac.1;
        Sun, 29 Jan 2023 15:22:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W4L5oF4E54T/sh4LaFYmdvNz2cLzUuuYr8m0fx4ixMA=;
        b=JIrwuUtS/Idza+dRQa/+IyTnhax182YCJ1TFCztNSEvGkDqwkBPP1QlTaJpZrUjBZy
         rFgBw8LRkLhtQJoiuFnXqcIPqPFsB6bEhpDmwCmuJwhocvfjMrq5xKigsdawfHp/L1pI
         YaX5YiRgniv3UQQIsl1ql+nl02AKCu2GeEoRD3q4oRn/Y7FuV/x1VuagbGGZS7P6h6ec
         AH7o6aB/F/0VMTwrUMRvR9VbeprX5fGgAWKpLyrmc93No8VLNmFTplVMRCF5Pab7+Pfj
         a56JvuV9wzPFHyEXjci8CAdrzniJxEI1hfVkDOBqpaeHVZwTd8REhPhBIwxl5pv7WceU
         9bKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W4L5oF4E54T/sh4LaFYmdvNz2cLzUuuYr8m0fx4ixMA=;
        b=Cy78Q5k527tPJw6CNMOz2RrbpWjIOoIK9cvtX8XZNqKqI5Plf5MRX7XkND4c21TM+p
         8xI06AgHKD0omJs2xQWV7dvmaOQzRoqA3H6/oABGnBq9pc2gVmj1rcaHcL/0YwRv0ajB
         gvHFC3h08DfoooV3/ZW3Qp3XTfA6ZlwZI0KmyW1roQURp3FZ3gH50BW4OnHhoaZ8IUrz
         tmcxZLmKXWhEmNQGX0TVe2DdExoSKx3u3NUZPIKn3ZxQEfXsbvzo6vT20QpDcsOxeeaW
         6rbwmU5WdsGvw2+w0bFJfxziA2GGK0n1pmCWJypMcUcvvUVmEllRYg2kbmlEROCOZmzm
         MioA==
X-Gm-Message-State: AO0yUKVBgWRmoqq93dqUsPzzKYpowqC4QeMadRmy52jlqG1p75Dd5g1M
        JHjyT6wpJf2DRGFuGiKB4nw=
X-Google-Smtp-Source: AK7set9UEj5PxWHE4ApzrEdiggKij2Gsh4W983FKpcBTPPw6zlpGDROopIXKxuisMhp3EvrbyCxShg==
X-Received: by 2002:a05:6870:c6a2:b0:163:6f42:bb93 with SMTP id cv34-20020a056870c6a200b001636f42bb93mr5249612oab.59.1675034542261;
        Sun, 29 Jan 2023 15:22:22 -0800 (PST)
Received: from localhost.localdomain ([190.186.4.124])
        by smtp.googlemail.com with ESMTPSA id o22-20020a4ae596000000b004f269f9b8f3sm4328165oov.25.2023.01.29.15.22.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Jan 2023 15:22:21 -0800 (PST)
From:   Henry Castro <hcvcastro@gmail.com>
To:     namhyung@kernel.org
Cc:     Henry Castro <hcvcastro@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3] perf: fix the probe finder location (.dwo files)
Date:   Sun, 29 Jan 2023 19:21:28 -0400
Message-Id: <20230129232145.31307-1-hcvcastro@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <Y01Mof9qMpFToRWY@kernel.org>
References: <Y01Mof9qMpFToRWY@kernel.org>
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

Hi,

Polite ping?  Any feedback?

Regards
Henry

 tools/perf/util/probe-finder.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/tools/perf/util/probe-finder.c b/tools/perf/util/probe-finder.c
index 50d861a80f57..5f6781e712db 100644
--- a/tools/perf/util/probe-finder.c
+++ b/tools/perf/util/probe-finder.c
@@ -1200,6 +1200,20 @@ static int debuginfo__find_probe_location(struct debuginfo *dbg,
 			continue;
 		}

+#if _ELFUTILS_PREREQ(0, 171)
+		{
+			uint8_t unit_type;
+			Dwarf_Die cudie, subdie;
+
+			/* Check separate debug information file. */
+			if (dwarf_cu_info(pf->cu_die.cu, NULL,
+					  &unit_type, &cudie,
+					  &subdie, NULL,
+					  NULL, NULL) == 0
+			    && unit_type == DW_UT_skeleton)
+				pf->cu_die = subdie;
+		}
+#endif
 		/* Check if target file is included. */
 		if (pp->file)
 			pf->fname = cu_find_realpath(&pf->cu_die, pp->file);
--
2.20.1

