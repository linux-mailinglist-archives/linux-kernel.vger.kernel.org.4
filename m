Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CE2D5F3B89
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 04:43:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229847AbiJDCnG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 22:43:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229867AbiJDCm1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 22:42:27 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A14EE22BDA
        for <linux-kernel@vger.kernel.org>; Mon,  3 Oct 2022 19:42:26 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id z12so119207qtn.11
        for <linux-kernel@vger.kernel.org>; Mon, 03 Oct 2022 19:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=B/BzB/7t/zinmDkfHiX1ubMpJVCYgc+DxJaULzkgt9Q=;
        b=TqxqIekDJP7tMHpsM1y2nF6521dmq/uKSZA99tbjnhvAFP8ffOS3P8Se+TvjOQf4hc
         CZc66NJHADCpJu1Lhzf64asoYeGOmfneZ/rD5XjA0RhZX2a7c5Kp37QD1PJaFFTgWKtH
         8XGaepdWvrReLBEJJrKMddxKHghzH1XMnv/No=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=B/BzB/7t/zinmDkfHiX1ubMpJVCYgc+DxJaULzkgt9Q=;
        b=aGJQV0hfYsMaO4zh6xxw7FuJheLM0YNelQr5lT480cN+7lcleqeXZRynQV3rEwM+O1
         Vk/icP/0AM/iuE0BZQWiT8kE4YEpeMIC9Sl25ma7x0VPOH2R3ITvAKOw7V9/i2nqkiie
         EmsjNZBTkzFI29qqo+2OBxxgfrI3eoE1phXSlp7n5LbwhgiZ5HrXreCzk7/qhRr94A+4
         eAdRD20P3x4i1krvnfmUKq5P2+v93WnIPuNRH76kQOn4Zc2TqtygebHjU08wL0EMdlMG
         sGaeCasBzCKG6xxmxWxbRO1cNB3SEjKPvQKfrMgOaUuOp0hJ1WqWmEft1QuA1x9fjQkz
         ZKVA==
X-Gm-Message-State: ACrzQf0aDlZVCme1vnO1IrFW4whSI5V70TOyqZMi5Z8sCH4RBaad4H4Z
        4ZyTa3syASB2ZRDsh9dtct+iVg==
X-Google-Smtp-Source: AMsMyM7YdJ+JXyCoIRK/AJcvzHRX/I3y1eRLizNmEhZtRP6RR1lZvBWy810YZeBDwTpa7OGf8oc+2w==
X-Received: by 2002:a05:622a:451:b0:35d:5b19:b8f with SMTP id o17-20020a05622a045100b0035d5b190b8fmr18392640qtx.620.1664851345604;
        Mon, 03 Oct 2022 19:42:25 -0700 (PDT)
Received: from joelboxx.c.googlers.com.com (228.221.150.34.bc.googleusercontent.com. [34.150.221.228])
        by smtp.gmail.com with ESMTPSA id 1-20020ac85901000000b0035cf5edefa6sm11793875qty.56.2022.10.03.19.42.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Oct 2022 19:42:25 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, rushikesh.s.kadam@intel.com,
        urezki@gmail.com, neeraj.iitr10@gmail.com, frederic@kernel.org,
        paulmck@kernel.org, rostedt@goodmis.org, youssefesmat@google.com,
        surenb@google.com,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>
Subject: [PATCH v7 08/11] rcu/rcuscale: Use call_rcu_flush() for async reader test
Date:   Tue,  4 Oct 2022 02:41:54 +0000
Message-Id: <20221004024157.2470238-9-joel@joelfernandes.org>
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
In-Reply-To: <20221004024157.2470238-1-joel@joelfernandes.org>
References: <20221004024157.2470238-1-joel@joelfernandes.org>
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

rcuscale uses call_rcu() to queue async readers. With recent changes to
save power, the test will have fewer async readers in flight. Use the
call_rcu_flush() API instead to revert to the old behavior.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/rcu/rcuscale.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/rcuscale.c b/kernel/rcu/rcuscale.c
index 027b7c1e7613..21453a919c31 100644
--- a/kernel/rcu/rcuscale.c
+++ b/kernel/rcu/rcuscale.c
@@ -176,7 +176,7 @@ static struct rcu_scale_ops rcu_ops = {
 	.get_gp_seq	= rcu_get_gp_seq,
 	.gp_diff	= rcu_seq_diff,
 	.exp_completed	= rcu_exp_batches_completed,
-	.async		= call_rcu,
+	.async		= call_rcu_flush,
 	.gp_barrier	= rcu_barrier,
 	.sync		= synchronize_rcu,
 	.exp_sync	= synchronize_rcu_expedited,
-- 
2.38.0.rc1.362.ged0d419d3c-goog

