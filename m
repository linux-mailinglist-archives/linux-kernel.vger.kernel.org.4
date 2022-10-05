Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97DCC5F54BA
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 14:47:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230004AbiJEMrc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 08:47:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229993AbiJEMr1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 08:47:27 -0400
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0FFB6AEAD;
        Wed,  5 Oct 2022 05:47:24 -0700 (PDT)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-1326637be6eso10021715fac.13;
        Wed, 05 Oct 2022 05:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QQwVjfadNqZW8ikL3wi9R3vG+Nc3CEgj6ovjb2hCVtU=;
        b=fo16wAqq2hy/DhK2W/CRuW3tjyWARX5sJyYBlhNTKSRVo1KqiaBRXFnATX3rGwSdDO
         BOuLqi6jWC16tS1ZJknhTbXvqVKaQ7UUnw8mv5GEXalDhde+rJBVPEhg0mjaPVT996Zm
         XUMyOBQCr3WSugwOUOuhZoP/BPKLf2f25CHsQPKey9t3yNjuWcmpISJTGgOdvlmVB3Wd
         OuKLIjzv/Ai2i8yNfGjDIha9YmyNoAUIEMzT4VPM6DdqgIUCpYLrfh4bnvGR65prqEUX
         9pCVH2XlFWwHyPUhP/CLghtILOgdSZNVbTBezScpLST2ONb+dKMNnCdEo/GtGfbV0xji
         HlGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QQwVjfadNqZW8ikL3wi9R3vG+Nc3CEgj6ovjb2hCVtU=;
        b=50GawyQC+AS2dIxSkadEQOyl/rGWEXAWEEj7kv44DvdkWpW9dHtyvRrKzVjysVtSPJ
         RiQUdfsQ+CmtrAQIn3Kbk/nvD0IRE9Fmb7HfGpazJzLuhfrb4P/EV/OBSZmvAJPP4vDs
         Lkqm0JUpe0H/OGVwvVTC9W0dTxE0aY8S5FXjfVtQhHAHBRC9L/pPg8C6nzNdJPWUY8eE
         nHf8wsBJ3x10yezJNgv0DZiNWzPSz/fmLDVW7Et2WpIY7X2c+eaoQNVPWh2nMQxUbRvX
         2DW58CaY+7cVcaWlg/jDrjWmRkz7JVKtqK0/dVr7kgLNdzQAnEGJ23J1bdZzX6RKtNA1
         Iu6g==
X-Gm-Message-State: ACrzQf2jgXl1UULjPmKj9BOCZ+WZ1DEeohNEy9wUdfdq+ZEhOvaUgG3s
        DNsXd/LX1HdkRSbUflmhQ7g=
X-Google-Smtp-Source: AMsMyM6KFer6Ik+jAAU3lQ1mgaudElUCRCqCnxgx+YG6dwCfw/ha4tA5vfBQgEF5HrwwL1V4+4AjDA==
X-Received: by 2002:a05:6870:c689:b0:132:f58f:60d7 with SMTP id cv9-20020a056870c68900b00132f58f60d7mr29517oab.166.1664974044079;
        Wed, 05 Oct 2022 05:47:24 -0700 (PDT)
Received: from localhost.localdomain ([177.222.37.214])
        by smtp.googlemail.com with ESMTPSA id p189-20020acabfc6000000b00350f17527fesm4139824oif.28.2022.10.05.05.47.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Oct 2022 05:47:23 -0700 (PDT)
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
Subject: [PATCH v3] perf: fix the probe finder location (.dwo files)
Date:   Wed,  5 Oct 2022 08:47:02 -0400
Message-Id: <20221005124710.30296-1-hcvcastro@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <CAM9d7cgMjZPa9qwuzpG3usGJvKiAQCOvN8_W0RuakNqcZ2t8-g@mail.gmail.com>
References: <CAM9d7cgMjZPa9qwuzpG3usGJvKiAQCOvN8_W0RuakNqcZ2t8-g@mail.gmail.com>
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

> Nit, I think we use _ELFUTILS_PREREQ(0, 171).
Thank you

> How about making it a separate function with 2 versions
> depending on the elfutils?  Then you can have the variables
> only if they are used.

> Something like get_source_from_debuginfod() in the same
> file.

Sounds good, but I prefer simplicity in the patch =),
what do you think about
{
	Dwarf_Die cudie, subdie;
	if (dwarf_cu_info() ..)
	..
}

to resolve unused variable?
}


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

