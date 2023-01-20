Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 358D66758D8
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 16:38:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231126AbjATPiD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 10:38:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230403AbjATPiA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 10:38:00 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6772BC79EB
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 07:37:11 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id b7so5205442wrt.3
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 07:37:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cftWnAmLp1SAzK+LEC+VkfIJXP3yn4XV5OF+VxxmSEI=;
        b=kehQTJmy06GF73Jk4gupKe+iWEBSAOLIlh+im1CqYyRHgwYZcbshJUPBfo72NL2LAd
         SLtSL0YWsl7BzjCrReChO3QJdVuU+6VCQP2yXD+UC2XIgu4L2cfaSb00D4h26H7FjZ1R
         ShBO5E9s4ISWQZzZYOx93qA1eVZPYMQTfLrMk3WozQqhIO0ZwTZiBsKePs9hL6qWo5LD
         WsaOhLeRTc2YqX6diZLb59zkH3S+py+QjDuizqXsGKvCv9cFAQyf1l9tQMJmlHCtTzNu
         ienzRpqA5wUeZ/1B2roxwgRvvX8PZrY/fWWZ01bC4YdTC9stVMa7pZ+uZhVPAnc15d8j
         J95Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cftWnAmLp1SAzK+LEC+VkfIJXP3yn4XV5OF+VxxmSEI=;
        b=hVpm3yyr8m4MgSlkRaVIuPNsDU2+/b6sGJr8UgRN1QtuSyxkE4J+FFcozsD+DiYdT7
         zLiG27tlsL1MGdu/BVpADV11mGd8ozRm0npO0FMXCcMo04fVWo/pFJga8gnzGwNmGf54
         fecHTLwwQl1LI1KpFGRGLKUj23mbGmZWZ+np7a1n+BOXF8rLaCcUm526uWcNJOE1whLf
         Q+DUe0SQq4FjpaFUdkYqmvp6mGJWjaR1gqwZtCiQB+nC2MsChcHV1OUxGa1IsKYub4dz
         /oI7giR6r0Hbq9pwwQmxiWAcnWdM5YuXoQAa3Fyt7xvyDXISpSbifycTT/Ew6IDcHOov
         tyqA==
X-Gm-Message-State: AFqh2kobmI8D70acPMXZ7k9iFhfxbRzk/yQyX5AQ63mrmI+6aLdU3hdK
        miRTPCc67dGO0bcfL1imIBUUnArmtN/VYT63
X-Google-Smtp-Source: AMrXdXt5CVI6en+fALH4TA94NWNVBKOXDQkJFNKnLrn1CAOecTTxtMpPgS5gk3DiOQ5A4gVDQE6s4Q==
X-Received: by 2002:adf:a485:0:b0:2bf:81eb:dc26 with SMTP id g5-20020adfa485000000b002bf81ebdc26mr1311316wrb.37.1674229029690;
        Fri, 20 Jan 2023 07:37:09 -0800 (PST)
Received: from linaro.org ([2a00:23c5:6809:2201:a9b1:8068:4297:73be])
        by smtp.gmail.com with ESMTPSA id b16-20020adff910000000b002bdf8dd6a8bsm14212460wrr.80.2023.01.20.07.37.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jan 2023 07:37:08 -0800 (PST)
From:   Mike Leach <mike.leach@linaro.org>
To:     linux-perf-users@vger.kernel.org
Cc:     acme@kernel.org, linux-arm-kernel@lists.infradead.org,
        coresight@lists.linaro.org, leo.yan@linaro.org,
        mathieu.poirier@linaro.org, suzuki.poulose@arm.com,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, Mike Leach <mike.leach@linaro.org>
Subject: [PATCH] perf: cs-etm: Update decoder code for OpenCSD version 1.4
Date:   Fri, 20 Jan 2023 15:37:06 +0000
Message-Id: <20230120153706.20388-1-mike.leach@linaro.org>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

OpenCSD version 1.4 is released with support for FEAT_ITE.
This adds a new packet type, with associated output element ID in
the packet type enum - OCSD_GEN_TRC_ELEM_INSTRUMENTATION.

As we just ignore this packet in perf, add to the switch statement
to avoid the "enum not handled in switch error", but conditionally
so as not to break the perf build for older OpenCSD installations.

Signed-off-by: Mike Leach <mike.leach@linaro.org>
---
 tools/perf/util/cs-etm-decoder/cs-etm-decoder.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
index fa3aa9c0fb2e..48e7121880a9 100644
--- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
+++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
@@ -604,6 +604,9 @@ static ocsd_datapath_resp_t cs_etm_decoder__gen_trace_elem_printer(
 	case OCSD_GEN_TRC_ELEM_CUSTOM:
 	case OCSD_GEN_TRC_ELEM_SYNC_MARKER:
 	case OCSD_GEN_TRC_ELEM_MEMTRANS:
+#if (OCSD_VER_NUM >= 0x010400)
+	case OCSD_GEN_TRC_ELEM_INSTRUMENTATION:
+#endif
 	default:
 		break;
 	}
-- 
2.17.1

