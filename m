Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD1346B958D
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 14:08:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231281AbjCNNIp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 09:08:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231146AbjCNNIW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 09:08:22 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C8D4A403D
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 06:05:02 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id ay8so4996706wmb.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 06:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678799093;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3hMvSC+BwObtW4Q8mntRdXujCz2/mPi6i3Y7x4GRtLU=;
        b=fcptwIf8D1lcL18fjrZ1cm7XmwCEGvxlW5VJzJu1vkK5DNxmblN6XuLxY+2BS128vn
         OoyBn4PZku/XOh8avlzJ+I5KjjbHelh4J7D5zvKWePBHTBjyA7gNTfIoD9ilOrCQHNlH
         2k/QcX7FgeS/JjKQDmGwQ9fWCUfIHjr8KY8k9Ti2hucPz0NPF4Rppri3QTvrhmgzuS5B
         Iz9jEysBBmRI4NwD+KA/fP3ovTgWhQvyoioJcJJbYoS4oM5ONgIH6jpemyBaArwy7Drd
         fbrG8sIiWYncwgHhWlQIiA7EE2L6QoiY72OELe7OwkvP9HvbQ2t1S8y/Q0G9cFIrDzXs
         h0wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678799093;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3hMvSC+BwObtW4Q8mntRdXujCz2/mPi6i3Y7x4GRtLU=;
        b=2sPH6qbwL/6zMdaudZ5x2JZuYaypKUTVNtc/xSoeeTfuGhjXdmT+LcHQ6uPVbgYsTr
         250V2QgMym4uetH8FlvkVU8uEpa/C19Fwjpk6ehupdHeXuDhok8USxj1Q4Wy+Ejx2EGA
         YmcEzREPiWXOtdgS4+/iJM3N9dNmnHvbWC66SxjD7cZ3rE1CZK4Pk1pErUmVmSkjCmbA
         balR7bsyptT6xaW4NUIolYZBR1QPiGN3mkhJVNtWmKfayyv2IUqmiLNg+4T/GYvoeCES
         AMaz6hpl0nM2hcTNxZ1+Zq1YcBZfjTjPRHe0veWjYaEAZb4OqUHSz/u1dy9h7swdMT1k
         rXhw==
X-Gm-Message-State: AO0yUKVAAa77PZxzqXTOFeDK9rhGbbFE3zOvbCT5ZVd5sOPnioXSF2gc
        c0ouMataQ25ILgHMQDjuU4eI9jcdZ3zZITLYhYA=
X-Google-Smtp-Source: AK7set8/DJoCwgP0J+uo3ZeC5Z0xvLjgMcq+y3wtuX2Fh5hnwrqDAasTBg1ziDk3I3Lx1nmwfuB68w==
X-Received: by 2002:ac2:485c:0:b0:4b3:d6e1:26bb with SMTP id 28-20020ac2485c000000b004b3d6e126bbmr641299lfy.29.1678798572659;
        Tue, 14 Mar 2023 05:56:12 -0700 (PDT)
Received: from localhost.localdomain (abyj16.neoplus.adsl.tpnet.pl. [83.9.29.16])
        by smtp.gmail.com with ESMTPSA id y24-20020ac255b8000000b004e670ce364bsm389031lfg.277.2023.03.14.05.56.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Mar 2023 05:56:12 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org
Cc:     marijn.suijten@somainline.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Sai Prakash Ranjan <quic_saipraka@quicinc.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Qais Yousef <qyousef@layalina.io>,
        Stephen Hemminger <stephen@networkplumber.org>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Tobias Klauser <tklauser@distanz.ch>,
        Vasily Averin <vasily.averin@linux.dev>,
        Colin Ian King <colin.i.king@gmail.com>,
        Kirill Tkhai <tkhai@ya.ru>, linux-kernel@vger.kernel.org
Subject: [PATCH] mailmap: map Sai Prakash Ranjan's old address to his current one
Date:   Tue, 14 Mar 2023 13:56:03 +0100
Message-Id: <20230314125604.2734146-1-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_HTTP,RCVD_IN_SORBS_SOCKS,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sai's old email is still picked up by the likes of get_maintainer.pl
and keeps bouncing like all other @codeaurora.org addresses. Map it to
his current one.

Cc: Sai Prakash Ranjan <quic_saipraka@quicinc.com>
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 .mailmap | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.mailmap b/.mailmap
index bc213f9eaf6f..3c7f00496072 100644
--- a/.mailmap
+++ b/.mailmap
@@ -398,6 +398,7 @@ Ross Zwisler <zwisler@kernel.org> <ross.zwisler@linux.intel.com>
 Rudolf Marek <R.Marek@sh.cvut.cz>
 Rui Saraiva <rmps@joel.ist.utl.pt>
 Sachin P Sant <ssant@in.ibm.com>
+Sai Prakash Ranjan <quic_saipraka@quicinc.com> <saiprakash.ranjan@codeaurora.org>
 Sakari Ailus <sakari.ailus@linux.intel.com> <sakari.ailus@iki.fi>
 Sam Ravnborg <sam@mars.ravnborg.org>
 Sankeerth Billakanti <quic_sbillaka@quicinc.com> <sbillaka@codeaurora.org>
-- 
2.39.2

