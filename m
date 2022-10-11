Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5426A5FBA13
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 20:03:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230091AbiJKSC5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 14:02:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230017AbiJKSCX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 14:02:23 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EA466D559
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 11:02:18 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id cj27so8749524qtb.7
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 11:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qdhlIj+6HcqRKTVWPc10GaEiGeAKWAIvBWIoYXYLCMk=;
        b=qYmNR34LcxDkzJOEnT6+PNcqkE2xLNpaeiJaJT3FbtB76+Ta7EtjclA6vXTHrJidA/
         cromdLzJq0zsPrm/wiEInQW3QlK+lbEbviw9g2HON841vdJ6w+bMRTCpV0Vrxq8F2gNk
         5cdcOUi0pxXmuNreBTbfb+GLR49WYoSR/l5h0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qdhlIj+6HcqRKTVWPc10GaEiGeAKWAIvBWIoYXYLCMk=;
        b=OyHHhtIuXz03P8gOobyjHjp957uOzNOMIVpAUWLQSj1gLZnjLZAejNPddiSRKn9Rmi
         ps/uN16rZd1qJPMNN2cYaxmwJb5CdJ+mFjPrt1YijO5Dp3mZBlkifbSRFvRvb/xSzIh5
         RjSTUzAJepdFXS2d6YLhOjje0BW9COXVdtIj2Um5JYzLCbuNxA7ZGRu7TfIhjN69EgoG
         qTS5njs4D8kYqIHgGb1MREK6QQeLJoytYqwi2nru6wZ0e2A8/57B3FhFflTKm/AavEnf
         iviME7G4A1QilrlBgc2fwXX5UuKZvGb2Z9x76g2N30ExhYZ/WuI9cFZQjxIzZPPqInVE
         LGWg==
X-Gm-Message-State: ACrzQf3uqAOmxcKcmkWMzJGPlOshl1n0cal16vB0hjf3f+5Ty9CBmBhg
        r1aAKRqlE5X/aVCjrNT9UwMk1Q==
X-Google-Smtp-Source: AMsMyM7iHDTOAo/am5jyfXTS3XqJquXNhZYTGraRR62aZTYIM5rBX/5GH98UEa4LuEFOd1dzvITjSg==
X-Received: by 2002:a05:622a:1904:b0:35c:c657:14e4 with SMTP id w4-20020a05622a190400b0035cc65714e4mr20308128qtc.65.1665511337402;
        Tue, 11 Oct 2022 11:02:17 -0700 (PDT)
Received: from joelboxx.c.googlers.com.com (228.221.150.34.bc.googleusercontent.com. [34.150.221.228])
        by smtp.gmail.com with ESMTPSA id w22-20020a05620a425600b006cbc00db595sm13464375qko.23.2022.10.11.11.02.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Oct 2022 11:02:16 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, rushikesh.s.kadam@intel.com,
        urezki@gmail.com, neeraj.iitr10@gmail.com, frederic@kernel.org,
        paulmck@kernel.org, rostedt@goodmis.org, youssefesmat@google.com,
        surenb@google.com, Joel Fernandes <joel@joelfernandes.org>
Subject: [PATCH v8 11/13] workqueue: Make queue_rcu_work() use call_rcu_flush()
Date:   Tue, 11 Oct 2022 18:01:40 +0000
Message-Id: <20221011180142.2742289-12-joel@joelfernandes.org>
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
In-Reply-To: <20221011180142.2742289-1-joel@joelfernandes.org>
References: <20221011180142.2742289-1-joel@joelfernandes.org>
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

From: Uladzislau Rezki <urezki@gmail.com>

call_rcu() changes to save power will slow down RCU workqueue items
queued via queue_rcu_work(). This may not be an issue, however we cannot
assume that workqueue users are OK with long delays. Use
call_rcu_flush() API instead which reverts to the old behavior.

Signed-off-by: Uladzislau Rezki <urezki@gmail.com>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/workqueue.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index aeea9731ef80..fe1146d97f1a 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -1771,7 +1771,7 @@ bool queue_rcu_work(struct workqueue_struct *wq, struct rcu_work *rwork)
 
 	if (!test_and_set_bit(WORK_STRUCT_PENDING_BIT, work_data_bits(work))) {
 		rwork->wq = wq;
-		call_rcu(&rwork->rcu, rcu_work_rcufn);
+		call_rcu_flush(&rwork->rcu, rcu_work_rcufn);
 		return true;
 	}
 
-- 
2.38.0.rc1.362.ged0d419d3c-goog

