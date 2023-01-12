Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 474336685DC
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 22:49:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233136AbjALVtA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 16:49:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240753AbjALVrg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 16:47:36 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C14C01B9E1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 13:40:27 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id 78so13695745pgb.8
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 13:40:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N4u1T86SPW7EoRBLC3mtnjrxg1wEFO/gvDqxCBagRGw=;
        b=g2boBC2BF//Gt7s5eM0DpLOOf9GKDmw9dCXbKCVxn3Rc4ySTwhTOPDbYgzES96s/Ag
         Qy3QsA6+/d8B2HP2JNt5KCQK2yQAZXlbfIukJvdVSauX7qTxSWhtJSOD2dq+DmNy3ozc
         QVxY2k4m41lsnwWK6L3iwKL/50X1rA5WaGeDcKqWWb2gDtaMzdTaLnT7E3IGoCVQET6d
         i4fa6U+w93EnCxuIVWLPwfjzt0z62OJzRAyPEoghDGA90o5P6k9x4hXSmtXL37H13DZI
         2+f0862alHk4m6hq0TaVdDma7By0OZr8vRac1Au8SEMUqJ6DyEPuQSo9TGATh1IbvcgN
         andA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=N4u1T86SPW7EoRBLC3mtnjrxg1wEFO/gvDqxCBagRGw=;
        b=nbOtx0/izdqL8J+U+8KknUOUOfFLcb4BZqZ/om5nOuaYZB/cwpCBic5GjvBO63u5i9
         QU22P3v5vA9dZw6uyZeAuAcKeRYugFwG38/WAX86iMncaBbIyUWoZ+GRGTzEsOzkuvcH
         mAcBn2Q9DbgSjRBlkraJk1Jcljp8//5O+SSbYYUa6E1QZpojoWJPxiAeTB5Euq99mskA
         flOPze+iv/LYizMQXu6undUfcnOmiymr0TaGuloB6heVMQ/PRlpg1ai236Xwd2Sapxr6
         czr6m0jV65OOpU0QIaGwS0iHZpT0OgG+sA7DFhTOQz6zX63Bgb5megXQfayT1hToAagt
         D3/g==
X-Gm-Message-State: AFqh2kqk/0tHn1GtyiprZzN6muTnh+pupbBq0SlTueE363bQNPwEPSD4
        2o5aTZj7g+uhqUOQKoajtSg=
X-Google-Smtp-Source: AMrXdXsCM9xzUjJHGBhTX/7QX/FV0cUuHTocxkxl8saiLITQx82TI72ktLk5oNPSoU9fy9d5OPARdw==
X-Received: by 2002:aa7:8649:0:b0:583:219a:670e with SMTP id a9-20020aa78649000000b00583219a670emr25677667pfo.30.1673559627191;
        Thu, 12 Jan 2023 13:40:27 -0800 (PST)
Received: from youngsil.svl.corp.google.com ([2620:15c:2d4:203:b71e:23d4:aa6a:47c0])
        by smtp.gmail.com with ESMTPSA id q20-20020aa79834000000b0058134d2df41sm11344605pfl.146.2023.01.12.13.40.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jan 2023 13:40:26 -0800 (PST)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, Song Liu <song@kernel.org>
Subject: [PATCH 6/8] perf/core: Do not pass header for sample id init
Date:   Thu, 12 Jan 2023 13:40:13 -0800
Message-Id: <20230112214015.1014857-7-namhyung@kernel.org>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
In-Reply-To: <20230112214015.1014857-1-namhyung@kernel.org>
References: <20230112214015.1014857-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The only thing it does for header in __perf_event_header__init_id() is
to update the header size with event->id_header_size.  We can do this
outside and get rid of the argument for the later change.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 kernel/events/core.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 7c5555051662..127dddd20f93 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -7061,13 +7061,11 @@ static void perf_aux_sample_output(struct perf_event *event,
 			     PERF_SAMPLE_CPU | PERF_SAMPLE_ID |		\
 			     PERF_SAMPLE_IDENTIFIER | PERF_SAMPLE_STREAM_ID)
 
-static void __perf_event_header__init_id(struct perf_event_header *header,
-					 struct perf_sample_data *data,
+static void __perf_event_header__init_id(struct perf_sample_data *data,
 					 struct perf_event *event,
 					 u64 sample_type)
 {
 	data->type = event->attr.sample_type;
-	header->size += event->id_header_size;
 
 	if (sample_type & PERF_SAMPLE_TID) {
 		/* namespace issues */
@@ -7094,8 +7092,10 @@ void perf_event_header__init_id(struct perf_event_header *header,
 				struct perf_sample_data *data,
 				struct perf_event *event)
 {
-	if (event->attr.sample_id_all)
-		__perf_event_header__init_id(header, data, event, event->attr.sample_type);
+	if (event->attr.sample_id_all) {
+		header->size += event->id_header_size;
+		__perf_event_header__init_id(data, event, event->attr.sample_type);
+	}
 }
 
 static void __perf_event__output_id_sample(struct perf_output_handle *handle,
@@ -7583,7 +7583,7 @@ void perf_prepare_sample(struct perf_event_header *header,
 	u64 filtered_sample_type;
 
 	header->type = PERF_RECORD_SAMPLE;
-	header->size = sizeof(*header) + event->header_size;
+	header->size = sizeof(*header) + event->header_size + event->id_header_size;
 
 	header->misc = 0;
 	header->misc |= perf_misc_flags(regs);
@@ -7601,7 +7601,7 @@ void perf_prepare_sample(struct perf_event_header *header,
 					   PERF_SAMPLE_REGS_USER);
 	filtered_sample_type &= ~data->sample_flags;
 
-	__perf_event_header__init_id(header, data, event, filtered_sample_type);
+	__perf_event_header__init_id(data, event, filtered_sample_type);
 	data->sample_flags |= sample_type & PERF_SAMPLE_ID_ALL;
 
 	if (filtered_sample_type & PERF_SAMPLE_IP) {
-- 
2.39.0.314.g84b9a713c41-goog

