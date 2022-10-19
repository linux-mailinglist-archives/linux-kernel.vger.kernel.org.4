Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D496605031
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 21:11:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230141AbiJSTLx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 15:11:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229920AbiJSTLd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 15:11:33 -0400
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85D8A1C3E63;
        Wed, 19 Oct 2022 12:11:29 -0700 (PDT)
Received: by mail-oi1-f175.google.com with SMTP id w196so20341022oiw.8;
        Wed, 19 Oct 2022 12:11:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4nOSzjJQMiiQFtQCXOfHoj5W8uYrP30fMIHaTAT/kCc=;
        b=hCTgCrWjB6kwLLIxgXdluNmaFm5dNrHBkl1urJB1KgTnr9Wt7IZLPhCgQM5pjgD0jO
         gX8pWu2GQM2koFnT5KbPk+DoM2B4JcPVerBc+iOSSu8THL00TnxLgyw+/V6Jxen89zr7
         zCkYWt3OWshzgTTa/34AV5eXrXbvmUUp67av57JXG0nPahAXg8FhkoBKpM7DUpM61Hou
         mLmfIJ+L9JXkuQKrkJIUfcRecTGW9e1qeYRAIPv7upenEk6qDk+layRNbMBHoJZQw/g+
         2w+QDw6D6YhTe1nFmI7VDxYYOWLkyk6zeoyRy6i2Ta1yUoUoFYE0UuQlM+4Rky6iDKbs
         K7Rg==
X-Gm-Message-State: ACrzQf0A1RdBUKwCtyhHZhI6S5Xxn248LGwGgWcN5uwtCIORi2I1MHHu
        iRTs8YMhPHArXIJvCvfu/A==
X-Google-Smtp-Source: AMsMyM6hBFo6lc3QPPJZLi2rdtLDIwN0Hv6MsBsjwIii7y66xrRf5EteOTh2AxrGHMhQuml0B0j83w==
X-Received: by 2002:a05:6808:3090:b0:354:e8e2:6512 with SMTP id bl16-20020a056808309000b00354e8e26512mr18775295oib.118.1666206688760;
        Wed, 19 Oct 2022 12:11:28 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id z9-20020a056870460900b0013191b00f72sm7878011oao.17.2022.10.19.12.11.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Oct 2022 12:11:28 -0700 (PDT)
Received: (nullmailer pid 3420908 invoked by uid 1000);
        Wed, 19 Oct 2022 19:11:25 -0000
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 19 Oct 2022 14:11:29 -0500
Subject: [PATCH v2 6/7] perf: Add perf_event_attr::config3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20220825-arm-spe-v8-7-v2-6-e37322d68ac0@kernel.org>
References: <20220825-arm-spe-v8-7-v2-0-e37322d68ac0@kernel.org>
In-Reply-To: <20220825-arm-spe-v8-7-v2-0-e37322d68ac0@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>,
        James Morse <james.morse@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Will Deacon <will@kernel.org>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Oliver Upton <oliver.upton@linux.dev>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     kvmarm@lists.cs.columbia.edu, kvmarm@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.11.0-dev
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
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
v2:
 - Drop tools/ side update
---
 include/uapi/linux/perf_event.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
index 85be78e0e7f6..b2b1d7b54097 100644
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
b4 0.11.0-dev
