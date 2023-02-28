Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 971286A5C08
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 16:34:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230042AbjB1PeJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 10:34:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230004AbjB1PeD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 10:34:03 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 316DA305C4
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 07:33:46 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id k14so13712926lfj.7
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 07:33:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1677598424;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MhizWOHiUtEkjo5bcmFQJLgHV0F+78tvmlYC3OfT2LU=;
        b=QffycaR5jYSBq6X87uF2psRkJzKvMXDSfKpI9J2oNq0Gmz8bGVTnrM8L0RSQaLbtqn
         x1rO2Ud6+0hjpgs41QwriOtiL1j6mkFTdJImp15BZMwxdC5lpjHsHvj/I1htw80uch+8
         JEdQkyaaVJvEjAjZOtA/BiC+lPp08MNPwSlC6n6PuzxZfuxNns8hOZzv1WdPT+bdPy+o
         aWOSWcPtQ32OKDJIuWPSf9N03XzK25a/k2NObGmpDn+v42a3olLBtMnhYlmjx9cg4Dj8
         2fp8NLlYkcdTyKnziq86bMEueU3qfieT6DlzvTJ/j4okRPH5SqEugZQX0d+ND4/LmURl
         mh+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677598424;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MhizWOHiUtEkjo5bcmFQJLgHV0F+78tvmlYC3OfT2LU=;
        b=cT+GiaBRGdHL1V0L55L05dxcJo1+rS0T0tFcAvYIBkMot1iAqIIB5atTlCz5Q5Wleb
         6l7gQAavRUohZCfodxoJ/zP4r2oQJBHZyECp3qqxak/LqU1dERnjGFtCHDeAPloAulHW
         q8NHaM5aKqRgiS0LFCf0R4BZsy11DiHwuOdMLueX6YmHYW603fM+0H7Pss6yxp3NqquW
         8P0KCx6N6DDYQvXpC7G29d+E5ZSzB/gq+K2e7haxgNxLpyEvfT0tYkMLZ/YWCZxS8WcK
         RQpX5KSelDH5gsl1l+4cR5unaat9l8TuFcdc6KVocFK+byF5IjRGeQGYwi29u06kSDbJ
         GJaQ==
X-Gm-Message-State: AO0yUKVgzafoZ177zNl+nauYH3FFV+1UdQJOed9sOv+Cn79mOnksg5CL
        EzatKyBFImeUTwcTGRKAgsLS8Q==
X-Google-Smtp-Source: AK7set8wC4r9eTDM9JFM+1zVOzE39RVIkN5x339Mmb+Htr1nER9ga8wWGFHjYk9bkJEMYuSDnyrOQA==
X-Received: by 2002:ac2:533c:0:b0:4dd:9aec:e468 with SMTP id f28-20020ac2533c000000b004dd9aece468mr782902lfh.58.1677598424365;
        Tue, 28 Feb 2023 07:33:44 -0800 (PST)
Received: from localhost.localdomain (abym99.neoplus.adsl.tpnet.pl. [83.9.32.99])
        by smtp.gmail.com with ESMTPSA id e13-20020a056512090d00b004b58500383bsm1373308lft.272.2023.02.28.07.33.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Feb 2023 07:33:44 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org
Cc:     marijn.suijten@somainline.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Vikash Garodia <quic_vgarodia@quicinc.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Qais Yousef <qyousef@layalina.io>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Vasily Averin <vasily.averin@linux.dev>,
        Colin Ian King <colin.i.king@gmail.com>,
        Kirill Tkhai <tkhai@ya.ru>, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] mailmap: map Vikash Garodia's old address to his current one
Date:   Tue, 28 Feb 2023 16:33:35 +0100
Message-Id: <20230228153335.907164-3-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230228153335.907164-1-konrad.dybcio@linaro.org>
References: <20230228153335.907164-1-konrad.dybcio@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Vikash's old email is still picked up by the likes of get_maintainer.pl
and keeps bouncing. Map it to his current one.

Cc: Vikash Garodia <quic_vgarodia@quicinc.com>
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 .mailmap | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.mailmap b/.mailmap
index 3d5b6cf4409a..5367faaf7831 100644
--- a/.mailmap
+++ b/.mailmap
@@ -443,6 +443,7 @@ Vasily Averin <vasily.averin@linux.dev> <vvs@openvz.org>
 Vasily Averin <vasily.averin@linux.dev> <vvs@parallels.com>
 Vasily Averin <vasily.averin@linux.dev> <vvs@sw.ru>
 Valentin Schneider <vschneid@redhat.com> <valentin.schneider@arm.com>
+Vikash Garodia <quic_vgarodia@quicinc.com> <vgarodia@codeaurora.org>
 Vinod Koul <vkoul@kernel.org> <vinod.koul@intel.com>
 Vinod Koul <vkoul@kernel.org> <vinod.koul@linux.intel.com>
 Vinod Koul <vkoul@kernel.org> <vkoul@infradead.org>
-- 
2.39.2

