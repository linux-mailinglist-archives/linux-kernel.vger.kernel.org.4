Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1905737920
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 04:30:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbjFUCam (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 22:30:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229870AbjFUCai (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 22:30:38 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCE69F1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 19:30:37 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-be47a3b3a01so5330128276.2
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 19:30:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687314637; x=1689906637;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VSoisqprkMitd+xVsai6RZ6ObdS1Rg95P89VE+p+UtY=;
        b=HoGEDJNuH1S6XZ7O1VHvt+thQ09ho4OWJgXvwTchJRKY8pdO2VwgrKK/bXrEJR50PN
         4s16ZdlWm8G3esFAcOwVQZqwkkWCxMFjADbgSs8g98QnnNHnKpQ4Vxo2b0L1N0G7WNoe
         OJeBdwjB5/npVOnfsPb+8Ip1JwUYinUU5GtR1RL2ZRAu0MN8xasKrhp4GJqdMYRXdLx2
         3rdeoKs4khijAS3tQD4J6p/aHYc0UloSf5seAik+XSu4Y7uO5gN3rMwZqn2jZOquL6fS
         2QxcReI2cuDOeg9/7Qd4DYGRCXNOv5CTpK/6fFg9u95mXx4uCq/pD3Sd2GhQV2dElxRp
         ngfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687314637; x=1689906637;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VSoisqprkMitd+xVsai6RZ6ObdS1Rg95P89VE+p+UtY=;
        b=LFnApmKHZDQ9Xuls3Vh98X4NmaJdzH5348Z8/lZmn776D4F2NEZ6w9lwWym/SDDlCE
         3InmTsoljqDng+lyCTECALlF2hXHki4D/890sE0C995iGY/7MA2nVUM8TdWqs1x4MjrB
         vcTGPUZSxBZkVyso1FvobRH1B38ORITx4pqLstSQzHA2qZlSmpIN9NEsXbVjUDUXapuQ
         Q6k+J669kbkkI2xF/dxYxAAITp6LxIElSfR8gjUejnXVoMxH3nbZR5qb4bAtzoJJ8ThU
         fAn6HTxj5OaFvJiB4pAfUl1W6FfLmMf4ykaC89nbhhrdT0KChJZIdrTMo2OJ2W1NVBg3
         zTjQ==
X-Gm-Message-State: AC+VfDxJr0j0/pLPXbXlpHSn8/OD7xBu6/DTaaJvm0wrsQD0C8k210LO
        U1Bdyb2m0LmNvN6+saS3mGuxtaHjqAZUUu9L
X-Google-Smtp-Source: ACHHUZ4cGtZIWGCSOfqk64IUkQ1VaAR+gAvtNKd+7LexG8Vxe6vkohlCKB7/9eKUj2PwgRW/GfUVsN56uHKH5gHP
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2327])
 (user=yosryahmed job=sendgmr) by 2002:a05:6902:1363:b0:bea:918f:2ef6 with
 SMTP id bt3-20020a056902136300b00bea918f2ef6mr1472872ybb.0.1687314637032;
 Tue, 20 Jun 2023 19:30:37 -0700 (PDT)
Date:   Wed, 21 Jun 2023 02:30:34 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Message-ID: <20230621023034.431962-1-yosryahmed@google.com>
Subject: [PATCH 0/2] memory.reclaim fixes for root cgroup
From:   Yosry Ahmed <yosryahmed@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Yu Zhao <yuzhao@google.com>, Johannes Weiner <hannes@cmpxchg.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Yosry Ahmed <yosryahmed@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This mini series includes fixes to the semantics of memory.reclaim on
the root memcg, as reported by Johannes Weiner in [1].

[1]https://lore.kernel.org/lkml/20230405200150.GA35884@cmpxchg.org/

Yosry Ahmed (2):
  mm: memcg: rename and document global_reclaim()
  mm/vmscan: fix root proactive reclaim unthrottling unbalanced node

 include/linux/mmzone.h | 18 +++++++++++++++---
 mm/vmscan.c            | 40 +++++++++++++++++++++++++---------------
 2 files changed, 40 insertions(+), 18 deletions(-)

-- 
2.41.0.162.gfafddb0af9-goog

