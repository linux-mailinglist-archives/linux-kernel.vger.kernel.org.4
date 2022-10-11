Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EC075FBA11
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 20:02:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230177AbiJKSCr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 14:02:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229991AbiJKSCW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 14:02:22 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46EF36C745
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 11:02:16 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id s3so450480qtn.12
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 11:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PEx0Z5TIM2F2t5dMUAE02+m0LGqCzjjr824tDz7I8rM=;
        b=aAQ/wImN5a5eFkWNQhhb1e6PwIGgl0pg+TRYnNz8W44MzVvZKfI9jiBk3N7D76g/Ab
         vtW44Xe52iYFufqhhnSexThVROJGzrEn9unUSRLj2jsvu+jvCuShwoAK8G3mQVZyo9aj
         LOYtrIwHEccWgL7padCaEVyIuzRXGjj+XP2+c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PEx0Z5TIM2F2t5dMUAE02+m0LGqCzjjr824tDz7I8rM=;
        b=YfuR3/3oSNaTFJCAWSTJJ4tUWnw5n4+y0n9kIYNB5Xo/5cGJaPPnet34X3K3MiADkQ
         OoRS3eDHjMc1DsmpAUE6w6t1ob4/V2zdPE+Q109/ouA1uSUFo1HWHYxQZQzKiQzyq8ig
         U6uy1KrnODnJomdXuMXylxzjwnhveeWMlDvT6Va1bs7yfJQ9vSyvoPTPkXO0xp3ywzSi
         Z4PdCLh3N4ep4+0XYxwW9xbSqvHRrIPaVG3VBfZOiWtjKYbc1Nyh1zBgfFgjYAWf37Cz
         sbu5Xw+NS8TlpZ+pUxr/2KsNUz2CDXglHMnTBDh17wyxiQ+iuexta7t2peCy3vAHAXfN
         4B/w==
X-Gm-Message-State: ACrzQf2a+wJe5T7WG6cQGHbylMnnIkT+DWaDlpWMm+cpCqGOEFWj7d73
        /yVUNEsjYoe0UJ9Rgkr+UJnsHg==
X-Google-Smtp-Source: AMsMyM62If1AXgC+j1iYuwPbjOsRZfRgwYhOXNjAAFoeHoNsWQ0qBd6VMoE3Ir+ePKZzSPZG4ubApw==
X-Received: by 2002:ac8:7d92:0:b0:35c:be77:5e2b with SMTP id c18-20020ac87d92000000b0035cbe775e2bmr19891370qtd.505.1665511335035;
        Tue, 11 Oct 2022 11:02:15 -0700 (PDT)
Received: from joelboxx.c.googlers.com.com (228.221.150.34.bc.googleusercontent.com. [34.150.221.228])
        by smtp.gmail.com with ESMTPSA id w22-20020a05620a425600b006cbc00db595sm13464375qko.23.2022.10.11.11.02.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Oct 2022 11:02:14 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, rushikesh.s.kadam@intel.com,
        urezki@gmail.com, neeraj.iitr10@gmail.com, frederic@kernel.org,
        paulmck@kernel.org, rostedt@goodmis.org, youssefesmat@google.com,
        surenb@google.com,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>
Subject: [PATCH v8 08/13] rcu/rcuscale: Use call_rcu_flush() for async reader test
Date:   Tue, 11 Oct 2022 18:01:37 +0000
Message-Id: <20221011180142.2742289-9-joel@joelfernandes.org>
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
In-Reply-To: <20221011180142.2742289-1-joel@joelfernandes.org>
References: <20221011180142.2742289-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
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
2.38.0.rc1.362.ged0d419d3c-goog

