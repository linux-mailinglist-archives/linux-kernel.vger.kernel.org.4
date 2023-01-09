Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0B01663049
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 20:27:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237504AbjAIT0z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 14:26:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237306AbjAIT0k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 14:26:40 -0500
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92CCB61463;
        Mon,  9 Jan 2023 11:26:39 -0800 (PST)
Received: by mail-ot1-f41.google.com with SMTP id k7-20020a056830168700b0067832816190so5742960otr.1;
        Mon, 09 Jan 2023 11:26:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PhyORF2P/3DyAeuNip+D3UZxHZqFcutPSwK+nSe9q5A=;
        b=JxKB8FpTCFEXBi12kepmWUjaIOrxOeOBEI4eiQFAWaVc9zGOjGoH1oI/bPc1UR/dSb
         xqxP73KEZ/RIhLJejWHCh/L80KVc39se93LissDlGwIeDfFmOHo9vFzxBmqH7a9JCtem
         xdtJNfKFNUfGZgLsDNOwzMyaGXl4+oq9tvqfISliI7fRoesmlGTqALtjQuuq7EfiOF/o
         F2aBzgGMuPFR36OEmQjH6WXkJSS6N7OTRRivdEFV6bBWb76ZhDWQr3VLYVZ6u/L4ztAy
         7BbF4ygElQAQh/V+/FuWdUxnfNAYg97PRuaikIiVddh7DDXczmmIfNo5zOoSRoJKYUdb
         XV2w==
X-Gm-Message-State: AFqh2kp3JRzY+3uPmt/P9oUXqrV/WamoBJLIvei6UTk39sm+l6gwZ4cw
        mNKQ30lAWkrqj0q4ol4mWvfABl3pIw==
X-Google-Smtp-Source: AMrXdXtQakXq+GiEhNJNrTLT/Kt4j9QDhHq5mQPoYNysZKYYdW2im1ldV7iPGFymXGTMKxSydH+yWw==
X-Received: by 2002:a9d:68c1:0:b0:66b:cae2:3a3f with SMTP id i1-20020a9d68c1000000b0066bcae23a3fmr32983649oto.17.1673292398563;
        Mon, 09 Jan 2023 11:26:38 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id b19-20020a9d6b93000000b0066ca61230casm4989496otq.8.2023.01.09.11.26.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 11:26:38 -0800 (PST)
Received: (nullmailer pid 1483618 invoked by uid 1000);
        Mon, 09 Jan 2023 19:26:31 -0000
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 09 Jan 2023 13:26:23 -0600
Subject: [PATCH v4 7/8] perf: Add perf_event_attr::config3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20220825-arm-spe-v8-7-v4-7-327f860daf28@kernel.org>
References: <20220825-arm-spe-v8-7-v4-0-327f860daf28@kernel.org>
In-Reply-To: <20220825-arm-spe-v8-7-v4-0-327f860daf28@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Oliver Upton <oliver.upton@linux.dev>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
Cc:     Mark Brown <broonie@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kvmarm@lists.linux.dev, linux-perf-users@vger.kernel.org,
        James Clark <james.clark@arm.com>
X-Mailer: b4 0.12-dev
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,
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

Tested-by: James Clark <james.clark@arm.com>
Signed-off-by: Rob Herring <robh@kernel.org>
---
There's still an unresolved discussion about validating 'config3' with
the options laid out here[1].

v4:
 - Rebase on v6.2-rc1
v3:
 - No change
v2:
 - Drop tools/ side update

[1] https://lore.kernel.org/all/Y49ttrv6W5k3ZNYw@FVFF77S0Q05N.cambridge.arm.com/
---
 include/uapi/linux/perf_event.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
index ccb7f5dad59b..37675437b768 100644
--- a/include/uapi/linux/perf_event.h
+++ b/include/uapi/linux/perf_event.h
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
2.39.0
