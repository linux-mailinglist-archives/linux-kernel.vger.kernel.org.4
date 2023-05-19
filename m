Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 854B570975A
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 14:40:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231288AbjESMkQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 08:40:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230516AbjESMkL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 08:40:11 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F290F4
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 05:40:08 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-510d6e1f1abso5430856a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 05:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20221208.gappssmtp.com; s=20221208; t=1684500007; x=1687092007;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1VSn6O9dGnsUidQ3Wuo34DwvHlJIF3gPCLvKg2mvcJk=;
        b=LLmls+aHWju+njqqOMHyx3fU5SFdNmFhb4tgDdLoo4mChRkLnFBR78wajLQl3VXJLm
         Yj5ewiYCkPX7iXTm8MDOhRExxEc2A+ZDmUBlZUFBEI2aIOywM4ZUejzMaOmsymL3Wsve
         RkFTrYudP27KFIWhu8ZNY4BNrwY2s4DBJIBc2KO1nNztY5UHozKqo1NuwR6r5gF7P5P5
         keDxW6WwhpRCBz9RlLpXH2+wSyumRV2pqoE2FBxheE1BK1w9TgDgFJ5ubFlbfpRlnNeB
         fHGPYnA6facRU9th7QCsF4gxGURb3idDz2l0CE1AUFVOTsmvl2OoMDjksUf7AWg/1xHM
         bZSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684500007; x=1687092007;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1VSn6O9dGnsUidQ3Wuo34DwvHlJIF3gPCLvKg2mvcJk=;
        b=C3bypQOJybeWISexpynP9q2wIOFiXrmReazKYNNPK3+7mA6ufTawuklf78oMTP4XZQ
         WjOqha03z2q2yg3O1LzViczY0GReO79gfBLBIE6LOaP12T0/pDVBMRBsLVjs3/UGdsqu
         znQN/9BAoduZNc78oMlifF+EO+h2OQgN90Zznv0nMY2WYdrEbADiKMOpe/O/v9MbQ/ZI
         bTRJ8YlmCtUpglrbRxb5T7K1FxFq3nQ5BN999r2OK7zqNyzMgcttzCGhoJl8/5UI3t0i
         ruZlami4WtTt8CvLjAyv1oDrW8pdjcrPUOkGgYdBTipZ+B3LqsZG3ZcNxIqpB+iqCssW
         8eeA==
X-Gm-Message-State: AC+VfDytg5cexVELZqwEGzZ7eZGwtW05MbiHg/k6XVxRJ8XiwwSIafoL
        FPViMZ+5DbXlkgRKzoQEKgGfAg==
X-Google-Smtp-Source: ACHHUZ6ioONCjugzdv338fbw98Vbwa9MN8B7f8tAyWbzJy9rkNZajByuKWx5auxegVru3hs9T99w6Q==
X-Received: by 2002:a17:907:7f0e:b0:966:484a:3350 with SMTP id qf14-20020a1709077f0e00b00966484a3350mr1821664ejc.35.1684500007074;
        Fri, 19 May 2023 05:40:07 -0700 (PDT)
Received: from localhost ([2a02:8070:6389:7d40:e266:3092:9afb:a7b1])
        by smtp.gmail.com with ESMTPSA id ju11-20020a17090798ab00b009661cf921b4sm2202417ejc.202.2023.05.19.05.40.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 May 2023 05:40:06 -0700 (PDT)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Mel Gorman <mgorman@techsingularity.net>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 0/5] mm: compaction: cleanups & simplifications
Date:   Fri, 19 May 2023 14:39:54 +0200
Message-Id: <20230519123959.77335-1-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These compaction cleanups are split out from the huge page allocator
series[1], as requested by reviewer feedback.

Against current mm-stable.

[1] https://lore.kernel.org/linux-mm/20230418191313.268131-1-hannes@cmpxchg.org/

 include/linux/compaction.h     | 96 ++----------------------------------------------------------------------------------------------
 include/trace/events/mmflags.h |  4 ++--
 mm/compaction.c                | 62 ++++++++++++++++++++++++++++++++++----------------------------
 mm/page_alloc.c                | 57 ++++++++++++++++++++-------------------------------------
 mm/vmscan.c                    | 27 ++++++++++++++-------------
 5 files changed, 72 insertions(+), 174 deletions(-)


