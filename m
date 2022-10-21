Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB3D7606FE6
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 08:16:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbiJUGQN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 02:16:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229763AbiJUGQL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 02:16:11 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 895D01FB7A3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 23:16:10 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id t10-20020a17090a4e4a00b0020af4bcae10so1887900pjl.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 23:16:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/sA7QGSj6y75rxa2eYsPXnOjdBFHP2KYfkI6B1PEkNY=;
        b=OJyo1zRz85apeGrCFU7BrmskmNKBczykdQdx109JVIjlDJ8cMbC7Bw1kFSkDyg/Rtv
         Bc2MG4sRen5OGVF00eL/nP6X4zbA1Dhhgt1yRp3UI3XRBt6hH3T51ujOT94zcBYJojkC
         NQh7oCVgSzNYCm+4Aen0lY1nXP8pUzXEg8ogZOepaP0IFbznBZI2f6dCylF5bE9fSn3k
         StX80XhSnPJG2m0BbIhcWXYBBPZhh3xqib54iJDPpX/7zF6NZB5OAYUr8uROYUoYtvV0
         Gngsm8qemFFCN1+Euhdq4GLjWEOYaLx3T4JhL9MplwRfChb/0Ta7G6YzWMQJ+Rk5/oxD
         IELw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/sA7QGSj6y75rxa2eYsPXnOjdBFHP2KYfkI6B1PEkNY=;
        b=PxWiyLLiiOU0A5+xCs8/D6ZKxEC8/KZqUKgnDeR68YUuhSc2kJuOpJk41AvWwgidjH
         E/FJtMWhPprLKkdOmzHDnbraFzLhLWQe099FS9NTA6CCfhUFvZXH5OU9lkPCJ6f206ND
         vVscsGSKJi8cyr9PSU6KCzLLX7o/+I9yq79zKzKorvsjzVOgH0xZ4r0WZ1IkEFqx1/GR
         lSLBiuhvthQSSglmOkzEih7DH5fTBydzaxFU2BVO9VbFyBM1CSu8yuRjGqSocDjwLNqB
         T/fcswWmxr+Iz+89OkHkS/tlIcSqvKwSWGTTpCGYcWl4fFHOYD8M+vSt921zVu+lf4ju
         FT/Q==
X-Gm-Message-State: ACrzQf2XnGtygSOqwzdYVpYBiwrhG1Z3VyJ4MeiXNf0AlrU1HU/QBBO+
        qBX69ahDSJLhgFcU9xuPxLVPyQ==
X-Google-Smtp-Source: AMsMyM6LA9GCvFGR6gVG2aVxQbH4df3s5v0buFqsnKVoY7/yD7PDJM+QxFs4Fp2hWKY5LpCmGnqfnQ==
X-Received: by 2002:a17:90b:1e4d:b0:212:c6f4:2cff with SMTP id pi13-20020a17090b1e4d00b00212c6f42cffmr4406899pjb.240.1666332970138;
        Thu, 20 Oct 2022 23:16:10 -0700 (PDT)
Received: from C02G87K0MD6R.bytedance.net ([139.177.225.244])
        by smtp.gmail.com with ESMTPSA id o11-20020a17090a4b4b00b0020d45a155d9sm327532pjl.35.2022.10.20.23.16.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 23:16:09 -0700 (PDT)
From:   Hao Jia <jiahao.os@bytedance.com>
To:     mingo@redhat.com, peterz@infradead.org, mingo@kernel.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        mgorman@techsingularity.net
Cc:     linux-kernel@vger.kernel.org, Hao Jia <jiahao.os@bytedance.com>
Subject: [PATCH 0/2] Optimize the process of scanning CPU for some functions
Date:   Fri, 21 Oct 2022 14:15:56 +0800
Message-Id: <20221021061558.34767-1-jiahao.os@bytedance.com>
X-Mailer: git-send-email 2.37.0 (Apple Git-136)
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

These two patches optimize the process of scanning the CPU by
adjusting the search order or breaking the loop.

Hao Jia (2):
  sched/numa: Stop an exhastive search if an idle core is found
  sched/core: Optimize the order of scanning CPU

 kernel/sched/core.c |  2 +-
 kernel/sched/fair.c | 12 ++++++------
 2 files changed, 7 insertions(+), 7 deletions(-)

-- 
2.37.0

