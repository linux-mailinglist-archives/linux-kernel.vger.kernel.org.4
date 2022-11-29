Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9CC463C8E5
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 21:03:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237183AbiK2UC6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 15:02:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237139AbiK2UC4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 15:02:56 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08D2A1583E
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 12:02:55 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id q17-20020a17090aa01100b002194cba32e9so3535974pjp.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 12:02:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CfKH+xyksi0xqE5TmQ4tvVhOd3hsiKDk8OYhqlbjSB8=;
        b=G9+zn2FEpPhCOSPiRVwfFep3yaKrUlO9qHtLjX/mOFCCuvawco5S9WV228oZfGoYyo
         ovMkz5fdB3P6gSd1cV+HLfPn04TdA4/5w3uh3uSSM7F7jelQyAgegkX363bILmNKybJM
         5phgB8+85AUMnWiK124E1Sln0/WJ8HN46QYpSH7uDqaR9CRrf4oOvfhDQjMzjJuFnzp3
         21nlcWUXn1mT37PyWgiqJMcmC7zjK7A9DyML9GA3KX+Bwun8UDF/VGKu5tTO3KunIQhT
         tPwGUm+hS8zZ6DrD2POO1iaTOHcop3kG9A5Y7vD2VWvb06sQGrxeH+nfgBOQJSrQBDcV
         1A6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CfKH+xyksi0xqE5TmQ4tvVhOd3hsiKDk8OYhqlbjSB8=;
        b=0PkJmYHo1U+hlYv3vpRXa9cDaZN5Cdm3tODgahO9+5LnWm6mGXYQTitrUdc8Ve1M3+
         tNe7vABRc+L4Xu4Fw2QmBepwEV2N88HiE4+qwU40wTA+IhVn7JV/Ybpikqb+msQ919N+
         efbdMir0YGrm6KC+3rTg+BVveEuKlyeksvsF4rdyeqAuTaDmgEYPU7CY5Nj2E2MmctaT
         I5+tb2EmpEWqcDkaq2YBbw1S7NQllN3t8hYil+eVqGfQwsSyKQSzAIpKIvjQbmL1t4w0
         dJ2A6ZG6ymcHDz+Vk7QQb7D328Ud8zzqN97ufFTV+Hp4b6BR9SjxmLFOm4IK/qPzAa9w
         3TSg==
X-Gm-Message-State: ANoB5pm20P5r6VjUmf28ili/D0XgfLBEfWpWzcNYRI9eNWxslUh82QEu
        Ex79zCZIIJj0ga18xES7Q18=
X-Google-Smtp-Source: AA0mqf7Eh/KR1N7IVrXofAqsiaZC6asEN4rgWB6PMDEyDZWNbVTALIlvC19PK6Ng5TuwGqFxoExAeQ==
X-Received: by 2002:a17:902:dac6:b0:189:7105:59e8 with SMTP id q6-20020a170902dac600b00189710559e8mr19845751plx.50.1669752174436;
        Tue, 29 Nov 2022 12:02:54 -0800 (PST)
Received: from localhost ([2a00:79e1:abd:4a00:2703:3c72:eb1a:cffd])
        by smtp.gmail.com with ESMTPSA id d13-20020a170902cecd00b00177f25f8ab3sm11370262plg.89.2022.11.29.12.02.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Nov 2022 12:02:53 -0800 (PST)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Daniel Vetter <daniel@ffwll.ch>,
        Rob Clark <robdclark@chromium.org>,
        Eric Anholt <eric@anholt.net>,
        linux-kernel@vger.kernel.org (open list),
        =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH 0/2] drm/shmem-helper: Fix a couple of error path bugs
Date:   Tue, 29 Nov 2022 12:02:40 -0800
Message-Id: <20221129200242.298120-1-robdclark@gmail.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rob Clark <robdclark@chromium.org>

A couple fixes for error paths that userspace could manage to trigger.

Rob Clark (2):
  drm/shmem-helper: Remove errant put in error path
  drm/shmem-helper: Avoid vm_open error paths

 drivers/gpu/drm/drm_gem_shmem_helper.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

-- 
2.38.1

