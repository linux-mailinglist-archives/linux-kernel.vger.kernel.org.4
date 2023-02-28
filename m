Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 309156A5C06
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 16:34:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230023AbjB1PeF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 10:34:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbjB1PeC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 10:34:02 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C9ED2BEFA
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 07:33:44 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id n2so13695006lfb.12
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 07:33:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1677598422;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8acnOAcWi9QAteiWt4LuCoceS68jTxeKv6KnqusOtHM=;
        b=RkLKpK4b8V+69XDlfUcEpWbHvr4Yx40sNSoxQhzcR5mjp8Ejq8xAxLgSNQuDMrUQ1+
         q7tVywLEAxxBqS4YZEjmRnFSDT71QZ/mrpN/PHSrmcw6m9ot7YupedwCAFSw3DeQ7Nt/
         ajgCPbzpPiBchj5J79h2Qgnjajkcp1jSipRsu7Vp32eThmqYriOteGtGLlsI9LBPPYfk
         fkTcN02x9kGN5T3/7u6Rn702ikP2jaeW1qGeY28PtTalZxXj4hMm7SaWEhfNzV0j6eyC
         1bIPGNXY+32yryCuNpGKeyzY4QrfutSxRnsdS3q7TesDo3IJPmePVLubA63h0HiwdK2c
         z9jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677598422;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8acnOAcWi9QAteiWt4LuCoceS68jTxeKv6KnqusOtHM=;
        b=mKOxk/Sl9eGeawMU7n8+ROfZJbd0Qzo2aCAf8d+QfJwjroEhp+zF34VuC9Qm21G8cE
         ivK/6WcsYdp4/mzqry9j0JgwhQ6COrfnLbYEhCgDXjwOLhtzXJl6SkkflkyB83IlXoFC
         FsfQH16mbg0xpZcCpAVYZ6mi4kiV/NXzZiH55zDtzbHW2ISQol3e3BwzWbKYTscPKKnW
         PQU7rv8ozvAYvdd/CRBMOnKaS4pbhqjlC1yfADXMCiPjL2k2x2g1XBH/ovn5p2lpBVf+
         FQOjA8d2rVf/sLJFuEQM6dMZY04SbNNrmClyjuUaOtD7f6ShaLoAHM2tlRECibdRckao
         tCyw==
X-Gm-Message-State: AO0yUKXK7Jz+oLpCvIjvZAC8zYfBMM/A5j2zz6o1EE7m1dQ3ALx/x89G
        nM559x7P5ozbLG3H4wY/MRZxNw==
X-Google-Smtp-Source: AK7set8C+oB7shl3CwVJJvoRc5QJ3tHikl2ZdBNYCCkSLYMZgO/UPofjbu6qjqFRvz3DbvrWfqhYYA==
X-Received: by 2002:ac2:559a:0:b0:4db:24f8:fabc with SMTP id v26-20020ac2559a000000b004db24f8fabcmr740324lfg.49.1677598422574;
        Tue, 28 Feb 2023 07:33:42 -0800 (PST)
Received: from localhost.localdomain (abym99.neoplus.adsl.tpnet.pl. [83.9.32.99])
        by smtp.gmail.com with ESMTPSA id e13-20020a056512090d00b004b58500383bsm1373308lft.272.2023.02.28.07.33.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Feb 2023 07:33:42 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org
Cc:     marijn.suijten@somainline.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Dikshita Agarwal <dikshita@qti.qualcomm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Qais Yousef <qyousef@layalina.io>,
        Vasily Averin <vasily.averin@linux.dev>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Colin Ian King <colin.i.king@gmail.com>,
        Kirill Tkhai <tkhai@ya.ru>, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] mailmap: map Dikshita Agarwal's old address to his current one
Date:   Tue, 28 Feb 2023 16:33:34 +0100
Message-Id: <20230228153335.907164-2-konrad.dybcio@linaro.org>
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

Dikshita's old email is still picked up by the likes of get_maintainer.pl
and keeps bouncing. Map it to his current one.

Cc: Dikshita Agarwal <dikshita@qti.qualcomm.com>
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 .mailmap | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.mailmap b/.mailmap
index fb65947d671d..3d5b6cf4409a 100644
--- a/.mailmap
+++ b/.mailmap
@@ -121,6 +121,7 @@ Dengcheng Zhu <dzhu@wavecomp.com> <dengcheng.zhu@gmail.com>
 Dengcheng Zhu <dzhu@wavecomp.com> <dengcheng.zhu@imgtec.com>
 Dengcheng Zhu <dzhu@wavecomp.com> <dengcheng.zhu@mips.com>
 <dev.kurt@vandijck-laurijssen.be> <kurt.van.dijck@eia.be>
+Dikshita Agarwal <dikshita@qti.qualcomm.com> <dikshita@codeaurora.org>
 Dmitry Baryshkov <dbaryshkov@gmail.com>
 Dmitry Baryshkov <dbaryshkov@gmail.com> <[dbaryshkov@gmail.com]>
 Dmitry Baryshkov <dbaryshkov@gmail.com> <dmitry_baryshkov@mentor.com>
-- 
2.39.2

