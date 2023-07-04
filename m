Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D1DE746BD0
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 10:26:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231341AbjGDI02 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 04:26:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230200AbjGDI00 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 04:26:26 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6785AE4F;
        Tue,  4 Jul 2023 01:26:25 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id 41be03b00d2f7-55bac17b442so1285237a12.3;
        Tue, 04 Jul 2023 01:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688459185; x=1691051185;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rnaNPjwtFpn4gloZKKRgwucu8ZcCmYCODm5Ceekydb4=;
        b=EHdc7aRT9XArgRM48tM2jVTxPdc5eLwVUjh+wRH2gQ4aEJCTpYAQMtDfq29n++y6Uu
         K2GVfTJpzF83Hin2I7Z2oC3SzNqQ6+xBw2D4v4u3tpNSE1KY/r1B4naCdr+S/09Hw1pP
         sv4RXUjhvKL7Vo8t4dVaSY8P7wDEzZsnjjtDuxQUVDKIN4h8BGLwukKFgDicdFWBLtNh
         hypVz1c+Ot2WVGP0l9bxKNx2ERDtWB2tbEsh3DjZpWbsZWx85p88pZg+aWSAj/+kyl1y
         VAqyeddyKqpWPtuqOChXTT9fi1OYiMTrsIteeJYN0kuGb10cOLxIZdIQvY5wC3/btFV3
         Gi6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688459185; x=1691051185;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rnaNPjwtFpn4gloZKKRgwucu8ZcCmYCODm5Ceekydb4=;
        b=e1eL0cEAeqfaxAeCyHKN9Ji5ySus0EEAeljYzChldOdg0x3dTe3exl3dHW4ni/xWZp
         buEdzsv+jipQ5M4CaHPVSdZJu03LCmRmCTSKb3ZBSKHBykf7QPkYA4nCG8vWpe1YwwyB
         3N5bE08cHHjHS8xRBSz8HtrMAsbwnRRsbgGvqI48YDS1s2tun/CJNI1ePZi334TyuyyH
         jS+TsSfLyRvJObIu6bZeE4aY16tppYfXBj9uxpdj1aA+xbMaBaFkRz7IHVXGkBT2Bdj9
         6IAsZAnjifqVyIc4ZpqSKtiD5NTasFavJkapsRMMUe/KCOVfjDA6JXxqmRQLc6DAHbjb
         4uqA==
X-Gm-Message-State: ABy/qLaenM0VN7lE1KRAViiAWGaWYGA3Hp8QpW3axzrqWOo6Dk1ncXW2
        2Ffs9bTmwMeK8ra4IV9YkgKjjRviOaI=
X-Google-Smtp-Source: APBJJlEYGuOtdXAXT2gPKunWPpseK0bJOi9btqDWLJRsj1p1UiHPiDRqyEDDND9BaGYkHLsnCquizQ==
X-Received: by 2002:a17:902:c10c:b0:1a5:150f:8558 with SMTP id 12-20020a170902c10c00b001a5150f8558mr12509689pli.17.1688459184860;
        Tue, 04 Jul 2023 01:26:24 -0700 (PDT)
Received: from MSCND1355B05.fareast.nevint.com ([183.242.39.186])
        by smtp.gmail.com with ESMTPSA id w18-20020a170902e89200b001a5fccab02dsm15781764plg.177.2023.07.04.01.26.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jul 2023 01:26:24 -0700 (PDT)
From:   Zqiang <qiang.zhang1211@gmail.com>
To:     paulmck@kernel.org, frederic@kernel.org, quic_neeraju@quicinc.com,
        joel@joelfernandes.org, qiang.zhang1211@gmail.com
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] srcu: Make srcu_might_be_idle() take early return if rcu_gp_is_normal() return true
Date:   Tue,  4 Jul 2023 16:26:15 +0800
Message-Id: <20230704082615.7415-1-qiang.zhang1211@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When invoke synchronize_srcu(), in the srcu_might_be_idle(), the current
CPU's sdp->lock will be acquired to check whether there are pending
callbacks in the sdp->srcu_cblist, if there are no pending callbacks,
probabilistically probe global state to decide whether to convert to
synchronize_srcu_expedited() call. however, for the rcupdate.rcu_normal=1
kernels and after the rcu_set_runtime_mode() is called, invoke the
rcu_gp_is_normal() is always return true, this mean that invoke the
synchronize_srcu_expedited() always fall back to synchronize_srcu(),
so there is no need to acquire sdp->lock to check sdp->srcu_cblist and
probe global state in srcu_might_be_idle().

This commit therefore make srcu_might_be_idle() return immediately if the
rcu_gp_is_normal() return true.

Signed-off-by: Zqiang <qiang.zhang1211@gmail.com>
---
 kernel/rcu/srcutree.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 20d7a238d675..aea49cb60a45 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -1172,6 +1172,8 @@ static bool srcu_might_be_idle(struct srcu_struct *ssp)
 	unsigned long tlast;
 
 	check_init_srcu_struct(ssp);
+	if (rcu_gp_is_normal())
+		return false;
 	/* If the local srcu_data structure has callbacks, not idle.  */
 	sdp = raw_cpu_ptr(ssp->sda);
 	spin_lock_irqsave_rcu_node(sdp, flags);
-- 
2.17.1

