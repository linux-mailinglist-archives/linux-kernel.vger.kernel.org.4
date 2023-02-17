Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF67769B588
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 23:32:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229475AbjBQWcp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 17:32:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229851AbjBQWcn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 17:32:43 -0500
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57C065FC40;
        Fri, 17 Feb 2023 14:32:41 -0800 (PST)
Received: by mail-ot1-f43.google.com with SMTP id f97-20020a9d2c6a000000b00690ee4a5febso544632otb.0;
        Fri, 17 Feb 2023 14:32:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SbC3ABHgFRUeSPinI56x4NwNJDxlP/+l8DvbcCpDuKU=;
        b=OOEdEd19z0jXI4jyYEBFjxlfoIyBQnlQNyDd9MSr8ASJpAmOFHFCn/fxSZPKHq3fAQ
         QF/Oexuvmtbr+b+Re1o7FMXS2pUvwuNcnc6IcGDmRce67ZdNVpKOHinCyTfvQ0yoWHHD
         JLwuTRoBe0NgEBAjQXcrKriLTAUEPT2Y6le1ZdaQMF1NRGddJ5A06lBOPZ9rLheid+On
         YvbGRLefzZp2l4e25hHmWDcylcZ5E2kt/lXeuTAt18odeSBcoTGt7k1QQn5E/H4PWzH1
         9s5UfnovR1toL/gm6YEdh5+QU4r60M7yjrPBNHHXVjsIw2deHGCD4TK9wNSJ1U0IyANm
         gGQA==
X-Gm-Message-State: AO0yUKWo1I45js8P3+cb/xpUpNgFJy2wbhqQs5g8fQS1Bx2N7UnwNhrc
        F+kxbVk1AwjTDikU/AJYwrq8iNAvZw==
X-Google-Smtp-Source: AK7set8iJIvBM7MPwjp2snCMYjeB8l4y8s3b5OwsvMWL+wNG+1Ge/KBkjThrDSUSMlHV+8ojJMYenQ==
X-Received: by 2002:a9d:7005:0:b0:68b:b06a:5b8b with SMTP id k5-20020a9d7005000000b0068bb06a5b8bmr677081otj.0.1676673160522;
        Fri, 17 Feb 2023 14:32:40 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id t4-20020a9d5904000000b0068d01839027sm2354861oth.30.2023.02.17.14.32.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Feb 2023 14:32:40 -0800 (PST)
Received: (nullmailer pid 1684708 invoked by uid 1000);
        Fri, 17 Feb 2023 22:32:38 -0000
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 17 Feb 2023 16:32:10 -0600
Subject: [PATCH v5 1/2] perf tools: Sync perf_event_attr::config3 addition
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20220914-arm-perf-tool-spe1-2-v2-v5-1-2cf5210b2f77@kernel.org>
References: <20220914-arm-perf-tool-spe1-2-v2-v5-0-2cf5210b2f77@kernel.org>
In-Reply-To: <20220914-arm-perf-tool-spe1-2-v2-v5-0-2cf5210b2f77@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
Cc:     Leo Yan <leo.yan@linaro.org>, James Clark <james.clark@arm.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
X-Mailer: b4 0.13-dev
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arm SPEv1.2 adds another 64-bits of event filtering control. As the
existing perf_event_attr::configN fields are all used up for SPE PMU, an
additional field is needed. Add a new 'config3' field.

Signed-off-by: Rob Herring <robh@kernel.org>
---
This matches commit 09519ec3b19e ("perf: Add perf_event_attr::config3")
for the kernel queued in linux-next.
---
 tools/include/uapi/linux/perf_event.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/include/uapi/linux/perf_event.h b/tools/include/uapi/linux/perf_event.h
index ea6defacc1a7..a38814ce9485 100644
--- a/tools/include/uapi/linux/perf_event.h
+++ b/tools/include/uapi/linux/perf_event.h
@@ -365,6 +365,7 @@ enum perf_event_read_format {
 #define PERF_ATTR_SIZE_VER5	112	/* add: aux_watermark */
 #define PERF_ATTR_SIZE_VER6	120	/* add: aux_sample_size */
 #define PERF_ATTR_SIZE_VER7	128	/* add: sig_data */
+#define PERF_ATTR_SIZE_VER8	136	/* add: config3 */
 
 /*
  * Hardware event_id to monitor via a performance monitoring event:
@@ -506,6 +507,8 @@ struct perf_event_attr {
 	 * truncated accordingly on 32 bit architectures.
 	 */
 	__u64	sig_data;
+
+	__u64	config3; /* extension of config2 */
 };
 
 /*

-- 
2.39.1

