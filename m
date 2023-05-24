Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E74FA70F8CB
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 16:33:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235727AbjEXOc5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 10:32:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235926AbjEXOcx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 10:32:53 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAEE71A2
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 07:32:50 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-64d3578c25bso1103336b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 07:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684938770; x=1687530770;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ffm6CBux51RZ39pEUG6TfSDYKiUVe0NKbuN3Xfx4bFc=;
        b=fvkLg0Wka5U7/IQKH++O8WpxVRQrMzWlAopI/9GeMgy4cq9nA/P8Vmtj0SKhpr//M/
         uMoQ2JTjDlske3UQ69Affo2LmgJAfYGBv40LWJeyVrLkWignXI4t10udlL49JqUpkqnz
         /cNKP2no29tTLaadDQU7z74ZUwQGAkAzXh6eXWXUI7w+bz9Anvuz59czjEbawIyEakr1
         X0IQFxlZRYVRf9hIRFo6c59sB8Q9T9kSZakZiA9p65aRbovX+akFzuRtzc0+1Uv5pOpg
         dx+M/F1UFvjE2XXe7Jg5XApFhj5S4fdJJxt3vU/TXTJFjhONHVuQgZ0BaWlc26KiU+MR
         0r6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684938770; x=1687530770;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ffm6CBux51RZ39pEUG6TfSDYKiUVe0NKbuN3Xfx4bFc=;
        b=TSm5Vid35S/ndTG9FQEv4eiD6xHIRMa46YpHuX7SfwoZr7//FUXx69LXdF9j0ExNsP
         wJ3JgXOaWghrOQ2IWSGfwyL8JGiUtjEB/xZZmGqutAu5yq9u6lONy9NJZXeIlsCuBics
         VAIbpVlT1Nsn91P/1HdfqYhoZpRpw+yy2ebqKpz64acrN+WvCwL9NYUkKI68wcL7gn4T
         XyWlP1s1vjP4dVRhAyn+5WmmPCYuPMij6zim96nVxuNIm3zP/Y2deZLhnBlxwLVoxBpV
         Ez4C0hK4C6Oe16GsxKYhnZutdMMi8W60B8bRIIMhCryot5F2bwbLmGuy8EACAb+zztJw
         qdQw==
X-Gm-Message-State: AC+VfDwuWBL1pqB0jTLjbhZe5qfb0OAIEJVYB9EnoCXxXt/fnixC/VLm
        d5vOPjC4HQqdkIZfSUVcdGc=
X-Google-Smtp-Source: ACHHUZ6TCzvVtkbhhWbUc9Kbq6iOx3fF4+3Xdi43g2N++ayxhfmv5fmBp27OCxgtpzjsyE8XwqekhQ==
X-Received: by 2002:a05:6a00:a22:b0:642:fbed:2808 with SMTP id p34-20020a056a000a2200b00642fbed2808mr3637018pfh.25.1684938770121;
        Wed, 24 May 2023 07:32:50 -0700 (PDT)
Received: from home-X450JB.hitronhub.home (114-38-33-71.dynamic-ip.hinet.net. [114.38.33.71])
        by smtp.gmail.com with ESMTPSA id t11-20020a63460b000000b004ff6b744248sm7897469pga.48.2023.05.24.07.32.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 May 2023 07:32:49 -0700 (PDT)
From:   Chia Chuan Yu <yujuan476@gmail.com>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org
Cc:     dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, Chia Chuan Yu <yujuan476@gmail.com>
Subject: [PATCH] sched: fix sched_thermal_decay_shift kernel-doc comment
Date:   Wed, 24 May 2023 22:32:41 +0800
Message-Id: <20230524143241.146399-1-yujuan476@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The comment for fix sched_thermal_decay_shift is not in kernel-doc format.
This patch will fix it.

Signed-off-by: Chia Chuan Yu <yujuan476@gmail.com>
---
 kernel/sched/sched.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 678446251c35..b05861f14543 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1512,7 +1512,7 @@ static inline u64 rq_clock_task(struct rq *rq)
 	return rq->clock_task;
 }
 
-/**
+/*
  * By default the decay is the default pelt decay period.
  * The decay shift can change the decay period in
  * multiples of 32.
-- 
2.25.1

