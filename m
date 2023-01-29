Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68904680028
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Jan 2023 17:15:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230135AbjA2QO7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 11:14:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbjA2QO6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 11:14:58 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D66D1E288
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jan 2023 08:14:56 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id q8so6509563wmo.5
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jan 2023 08:14:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SXZcddO8tdtsfO8jHlz3HxqJdTXFLPWTXEo3DbCWGAk=;
        b=gkCiLnEaAayVhsfgyB/usqPT6AC3X8uWCu+B0UBeyqX80B1bDr2/r+ZtAvcE0cZn3h
         HhWtJYuqFDZSU6JtMZOZIB/oLeaOPRtnHbL2dONebPt40PAmch/TcbblhTophVSPn5l6
         xr3FgacLcfHMKX4tP9a3tLmIEvI8eDg17IyR8r/cosux6jbBRpJM9ai+s+eZCKgbyjev
         21f/lZUsI3e13Bc/NRlMZ5mKzN5VXuERodyiiV4OwWzCeriGRYhGGYtxnsCzj42W3rvk
         yw/54dIw1aMqpzNyXyZhV0vqgGvm0smhid040sWcCo+1E+bVpFaID+RwF2+bOuTT1Pod
         BCxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SXZcddO8tdtsfO8jHlz3HxqJdTXFLPWTXEo3DbCWGAk=;
        b=iStsheidhnjyl3jtZv35j93uHG4bQ5JueYi/8ATRaYEHMh+IoGAwsazix8fnoA0xoD
         qqxyc4pXvcRkH1oeXMKK5EsThcSXcRop6g3GSZGrOaAwOIJakkJOoYY1Y1BAx4AbKu9p
         JcfhREi+oKl7Edm5JCPMy23SW+sTv+Zj3ZZpDtQtW4VJVqoV5qRNsejrMS6NQVupG2Dm
         H5Ad48X8YAFiogcuUSii2BtwDIXbzA9gplhBoJUCJDXCkI2ffQHO6TJxAPPMBX2QBHJC
         GFVyyoX3G3WTCHeUOMVjezGqW7cE47UmkrbSP3Yf4s2VFDsqlFasTIUr3TwtvfSndDoX
         RPnw==
X-Gm-Message-State: AO0yUKWasoJLqydfEVjX21UZbO66vloVxZcF+s9LcuxflFBL+nOq23Wm
        qK3Q+LcnWsgB1janjZYDeB3wRw==
X-Google-Smtp-Source: AK7set83kbgHJCXQO1fd1kxn1EtUnbWqGbKHm2gEuRpQ7Btchmi7SDdwrRowSfCWuZ7FKVOmr+XctQ==
X-Received: by 2002:a05:600c:1d2a:b0:3dc:443e:4212 with SMTP id l42-20020a05600c1d2a00b003dc443e4212mr6201748wms.1.1675008894865;
        Sun, 29 Jan 2023 08:14:54 -0800 (PST)
Received: from localhost.localdomain (host86-163-35-10.range86-163.btcentralplus.com. [86.163.35.10])
        by smtp.gmail.com with ESMTPSA id e5-20020a05600c254500b003dc47fb33dasm5324783wma.18.2023.01.29.08.14.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Jan 2023 08:14:54 -0800 (PST)
From:   Qais Yousef <qyousef@layalina.io>
To:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     linux-kernel@vger.kernel.org, Lukasz Luba <lukasz.luba@arm.com>,
        Wei Wang <wvw@google.com>, Xuewen Yan <xuewen.yan94@gmail.com>,
        Hank <han.lin@mediatek.com>,
        Jonathan JMChen <Jonathan.JMChen@mediatek.com>,
        Qais Yousef <qyousef@layalina.io>
Subject: [PATCH 0/3] Fix a couple of corner cases in feec() when using uclamp_max
Date:   Sun, 29 Jan 2023 16:14:41 +0000
Message-Id: <20230129161444.1674958-1-qyousef@layalina.io>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch 1 addresses a bug because forcing a task on a small CPU to honour
uclamp_max hint means we can end up with spare_capacity = 0; but the logic is
constructed such that spare_capacity = 0 leads to ignoring this CPU as
a candidate to compute_energy().

Patch 2 addresses a bug due to an optimization in feec() that could lead to
ignoring tasks whose uclamp_max = 0 but task_util(0) != 0.

Patch 3 adds a new tracepoint in compute_energy() as it was helpful in
debugging these two problems.

This is based on tip/sched/core + Vincent's v4 of
Unlink util_fits_cpu()... patch [1]

[1] https://lore.kernel.org/lkml/20230119174244.2059628-1-vincent.guittot@linaro.org/

Qais Yousef (3):
  sched/uclamp: Set max_spare_cap_cpu even if max_spare_cap is 0
  sched/uclamp: Ignore (util == 0) optimization in feec() when
    p_util_max = 0
  sched/tp: Add new tracepoint to track compute energy computation

 include/trace/events/sched.h |  4 ++++
 kernel/sched/core.c          |  1 +
 kernel/sched/fair.c          | 23 +++++++++++++++--------
 3 files changed, 20 insertions(+), 8 deletions(-)

-- 
2.25.1

