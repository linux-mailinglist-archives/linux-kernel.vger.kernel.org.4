Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77567658AC5
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 10:09:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232759AbiL2JJ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 04:09:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbiL2JJZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 04:09:25 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78C2D12D08;
        Thu, 29 Dec 2022 01:09:24 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id u4-20020a17090a518400b00223f7eba2c4so18385204pjh.5;
        Thu, 29 Dec 2022 01:09:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=sUCELAjzLAgQLyNWUnFXqm5TavnSZ9QT/V/+24DubtQ=;
        b=V/izTH55F5bQ7NezmIPSUuxY/ypaWDJei156ZGjl2299G/7wnf9W3SvP6DCy5t180c
         leAK2igc6IHpKxIrOm68akg8b/6GFpRzxTrxEX8cb91j1ED44fhb7S5qtduCRZMWF0q+
         2k80gdTCDpnU7Dq3TZ5K198jYQKfquCBDWm+DbtZQ8pgnZwk5HMHk5HOHFFnp5KANIgO
         HfUKwuMzfPWpeaGBH7AHm6Sf90DQ67WiYmJ65DIYNxNU3RHdi/3Ish90yi1iljXj3kUs
         JhUFeNKhOJ6nFK1la4KdE+ZLTcNFazjmnbFFonWZpMvI0Y6ZcDS4fO6nc+q6ttKlzNGc
         3sfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sUCELAjzLAgQLyNWUnFXqm5TavnSZ9QT/V/+24DubtQ=;
        b=6G7Up7hqyTGa4GPKb9BCC9D68YqAcV9Y5fgDl5emzCn6gaA6/oEo4fogr5+fyht2TO
         u2L0Y1OmTHo4xFOpOuxLjONgMvWU4tI5rzThlkvs2yv/RFsMY+Olv5yZck//g4Zd+CE1
         XbAP9EiJSXM/PvEiulQQd2OTd2EW9fLjzj/+Dc9WUefPI5wIlFjEq4j4zeBb+vxkJCqe
         SRVlVKotrkjXBkngn3jNc8M78P7R+mIO2kFJ0lASmxC4e1irUBqWmEnngOvPg+tSyXrH
         Ah31ZdlHuOJS+t1Ax80u4TKxomzZ1b6caj9SnFgEQxgP02XWwwKm/QP3drMJAkEDhEeT
         sR5A==
X-Gm-Message-State: AFqh2krSVWxJP4weU15arNywXhvkqa3CsHV/b6zra7koNW7BCgNgfscg
        WIz+UjUvEvQp9g5Dmf9MODc=
X-Google-Smtp-Source: AMrXdXsLwyo4d4l5SRjbvY+G4Sn/QHeRgYDhUTLGZvB065Lje2j0nXAK7y3ELqSb0o/Ydsv9lbzvCA==
X-Received: by 2002:a05:6a20:3d03:b0:ad:2abb:5a5e with SMTP id y3-20020a056a203d0300b000ad2abb5a5emr62802216pzi.61.1672304963990;
        Thu, 29 Dec 2022 01:09:23 -0800 (PST)
Received: from localhost.localdomain ([202.120.234.246])
        by smtp.googlemail.com with ESMTPSA id y4-20020a655b44000000b0047899d0d62csm10624971pgr.52.2022.12.29.01.09.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Dec 2022 01:09:22 -0800 (PST)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        Miaoqian Lin <linmq006@gmail.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] perf tools: Fix resources leak in perf_data__open_dir
Date:   Thu, 29 Dec 2022 13:09:00 +0400
Message-Id: <20221229090903.1402395-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In perf_data__open_dir(), opendir() opens the directory stream.
Add missing closedir() to release it after use.

Fixes: eb6176709b23 ("perf data: Add perf_data__open_dir_data function")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 tools/perf/util/data.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/perf/util/data.c b/tools/perf/util/data.c
index a7f68c309545..fc16299c915f 100644
--- a/tools/perf/util/data.c
+++ b/tools/perf/util/data.c
@@ -132,6 +132,7 @@ int perf_data__open_dir(struct perf_data *data)
 		file->size = st.st_size;
 	}
 
+	closedir(dir);
 	if (!files)
 		return -EINVAL;
 
@@ -140,6 +141,7 @@ int perf_data__open_dir(struct perf_data *data)
 	return 0;
 
 out_err:
+	closedir(dir);
 	close_dir(files, nr);
 	return ret;
 }
-- 
2.25.1

