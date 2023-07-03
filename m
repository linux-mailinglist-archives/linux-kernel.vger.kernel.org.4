Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B12D745C80
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 14:48:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230500AbjGCMsB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 08:48:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230429AbjGCMrx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 08:47:53 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E8ADFD
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 05:47:52 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-31438512cafso862144f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jul 2023 05:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1688388470; x=1690980470;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YVY/yta8MPWmg9iGDhd2QZ8qAlvFNnDO2cXvkrgJQ+E=;
        b=QlE2Iqus6AP6Te3dv3Y5Sx4aMQ+r5SKgwVSpZ0lVhlvFOkGw0WYXtGXIyYV13AdXyg
         BF50w/diT8Np6DqNMws/6d/47CDoirkmcKusK6cN3dPFI2VGnUd9hAmyNYSlA4poktO+
         eBlIbLnt08K37EodkyVat6+liUHZWpeoQatiE5O/3ceBUMebG7p6wzso8g68vqx48QeP
         Q50WOmsmdac9sn01EhF2WYiEkGFTwOTVO9QCJi6lJY9lnNqqXeQk/4wQoS1+c5EPLsLm
         ycCf9vXUK/7Q3fhEEM4/FDM3oJBppGTNdLj8CelDbYB3NzmZu/AEwfXT3hZ6/haUCtRa
         EgeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688388470; x=1690980470;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YVY/yta8MPWmg9iGDhd2QZ8qAlvFNnDO2cXvkrgJQ+E=;
        b=G0LtnkXgZAJtcpJDQsEDynJmbRw7J3Vl6I9MQHpJlzFMSw0kDGN15QiKnwVSLCfh1B
         LbamLziNAMe5Rc/5zZVtx1WUFsxoG3dqtnc+uDSIpMR+ibkJ9hUXFTYiVNACxvCb0Q5H
         F9m5AyrvuaqYyKF2xvbdxSXF92Rxa9hqtaB0kbxB66AZo8b/8FQ+/krZzfW5hj2tOMh5
         W3X6I5xju8pWCf4BA6ayKVNpbmUuQEtB/i8RImp2LlUoyRphTixCNH0Ls6rO45QiY/KX
         PdYbrMu5vRHNb4PgBp5KELxosr8Q8cS/KU8SuuCjHhK/pYVwgmKZ1SNHIC1kYzI9rdWD
         U5Wg==
X-Gm-Message-State: ABy/qLYoaNpRMoBvg1+j9M6FFG55wYFbIrsLq31hnF9vKQ94828ScRjM
        Iwvmv0Pzka32IxHhtCHiRHZ9GA==
X-Google-Smtp-Source: APBJJlGkvS0VBTA5uxFkpZhC1EeXtotxBOQUfL8gsoFO3JwjxcRP9zPFqdv6CO7IZsrTAyG8/+JKUQ==
X-Received: by 2002:a05:6000:124f:b0:314:3746:d44b with SMTP id j15-20020a056000124f00b003143746d44bmr2701847wrx.41.1688388470517;
        Mon, 03 Jul 2023 05:47:50 -0700 (PDT)
Received: from alex-rivos.home (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id v2-20020a5d6782000000b00313f5babb18sm19568022wru.9.2023.07.03.05.47.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jul 2023 05:47:50 -0700 (PDT)
From:   Alexandre Ghiti <alexghiti@rivosinc.com>
To:     Jonathan Corbet <corbet@lwn.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atishp@atishpatra.org>,
        Anup Patel <anup@brainfault.org>,
        Will Deacon <will@kernel.org>, Rob Herring <robh@kernel.org>,
        Andrew Jones <ajones@ventanamicro.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Alexandre Ghiti <alexghiti@rivosinc.com>,
        Atish Patra <atishp@rivosinc.com>
Subject: [PATCH v4 01/10] perf: Fix wrong comment about default event_idx
Date:   Mon,  3 Jul 2023 14:46:38 +0200
Message-Id: <20230703124647.215952-2-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230703124647.215952-1-alexghiti@rivosinc.com>
References: <20230703124647.215952-1-alexghiti@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit c719f56092ad ("perf: Fix and clean up initialization of
pmu::event_idx"), event_idx default implementation has returned 0, not
idx + 1, so fix the comment that can be misleading.

Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Reviewed-by: Atish Patra <atishp@rivosinc.com>
---
 include/linux/perf_event.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index d5628a7b5eaa..56fe43b20966 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -442,7 +442,8 @@ struct pmu {
 
 	/*
 	 * Will return the value for perf_event_mmap_page::index for this event,
-	 * if no implementation is provided it will default to: event->hw.idx + 1.
+	 * if no implementation is provided it will default to 0 (see
+	 * perf_event_idx_default).
 	 */
 	int (*event_idx)		(struct perf_event *event); /*optional */
 
-- 
2.39.2

