Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CE2F600140
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Oct 2022 18:24:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbiJPQYX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Oct 2022 12:24:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbiJPQXo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Oct 2022 12:23:44 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 131153D58F
        for <linux-kernel@vger.kernel.org>; Sun, 16 Oct 2022 09:23:42 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id m6so5404748qkm.4
        for <linux-kernel@vger.kernel.org>; Sun, 16 Oct 2022 09:23:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IEECeHAL+4jB0ct1Miev7aIBczUJQZG4eKLvCmwiPRs=;
        b=vycGQD6tA80I0QDKMFJTpotcypYOCSzuyXbA3dDGZ+CQ3qQXHGtK09Uyu/ySS6wEgz
         R1JZoCZzhHxNamY1N5+s+ejOngl986X9jX9JUINf4V7BiHU5I2RKenhW+E7rJP5jWT0i
         Uq4tY4W2tzoj5+A+DEuaoGo1/Ikue+EBnX/nE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IEECeHAL+4jB0ct1Miev7aIBczUJQZG4eKLvCmwiPRs=;
        b=H0/PhJFWjWTTXq++noav93GpTuduGkSFMYlBLjXBXWAJ9KVUSwgb0YFd6+h9yP4alg
         +3+jO8YksdPdX6FTgSe6QczyvPwmpFLbRix59GNICtVq7c4B2VPKJuVzf9hQnsVsgbEX
         N6TwWpqsIHXi6jeK2sFMKDzISnuY9ZGDlcl32NXIZ0q53wEdFBjQXusVeC43A28MHmD6
         f45efxqPby5mt7rJQgFLWy+4q56dRsAtYg7yhFvVD2k8XFYXdSVlfquL7/goyf/yAeeY
         becNFsDEVElg4HPLXs7eRaKtD5ephPlTX5Ke4XS6WRrn8ULeJaovJsctslXwVp9E6zx/
         2kCg==
X-Gm-Message-State: ACrzQf2ZeYtMy0WgdvRJnWplOxgoYcsbGONqYRGI5eE1so4RwiQ2a7Tj
        4vGUm1lT3JEMggE50LP5oc9J8Q==
X-Google-Smtp-Source: AMsMyM6MJvpR4qN9Qf8W9sEmrAa31zNShOitpR3AR8H6469FrfXoVDD9kmtONXlTehG2QxLw02YKcA==
X-Received: by 2002:a05:620a:e:b0:6ee:86e5:66f8 with SMTP id j14-20020a05620a000e00b006ee86e566f8mr5013762qki.163.1665937419752;
        Sun, 16 Oct 2022 09:23:39 -0700 (PDT)
Received: from joelboxx.c.googlers.com.com (228.221.150.34.bc.googleusercontent.com. [34.150.221.228])
        by smtp.gmail.com with ESMTPSA id x19-20020ac87ed3000000b003436103df40sm6001207qtj.8.2022.10.16.09.23.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Oct 2022 09:23:39 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, frederic@kernel.org,
        paulmck@kernel.org,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>
Subject: [PATCH v9 08/13] rcu/rcuscale: Use call_rcu_flush() for async reader test
Date:   Sun, 16 Oct 2022 16:23:00 +0000
Message-Id: <20221016162305.2489629-9-joel@joelfernandes.org>
X-Mailer: git-send-email 2.38.0.413.g74048e4d9e-goog
In-Reply-To: <20221016162305.2489629-1-joel@joelfernandes.org>
References: <20221016162305.2489629-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLACK autolearn=no autolearn_force=no
        version=3.4.6
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
index bbdcac1804ec..0385e9b12399 100644
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
2.38.0.413.g74048e4d9e-goog

