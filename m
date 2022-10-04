Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BF355F3B88
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 04:43:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230014AbiJDCnD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 22:43:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbiJDCm1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 22:42:27 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D551240BF
        for <linux-kernel@vger.kernel.org>; Mon,  3 Oct 2022 19:42:25 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id s18so7476216qtx.6
        for <linux-kernel@vger.kernel.org>; Mon, 03 Oct 2022 19:42:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=WO1zLatTGk7w49T3dw38/yevK8lFIMN7WGO9rdhO2q0=;
        b=LTfgasgQcTjFsGz+V8WCIdkb4lS/q3wgkeVWhhyK3Zn8lRgOBurVMCqxo905f/y1LB
         ZTnC11ZQ1e42UXbBBaTKpudvzk/Bbk1lwFXKP0iGpIeQV8dzYc85xmyqbN6dCx6qrJJZ
         gS98L/7H8bGqZeilTYaYhzc8309phRVnsm0qo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=WO1zLatTGk7w49T3dw38/yevK8lFIMN7WGO9rdhO2q0=;
        b=yBm72SvKirp2KmZhzERXVadt5v2icdeX6VoBVwlbC2e2zfWncnRh6pE01c+c25c7wU
         OuK4J+eRYeMY3rQTg/Ot0CXpLA+qCZxOl/ml1Cy23BWstx73VYB8nlrf8gJmaPcos/sh
         jcn5We9yFX4ZTjuxZ6pfkV3H5QkAi+szu7719ytjSTcp/U7BrjTvHVI0BXWHxTk1Brt8
         6Le+71CMRgXyOpwKCAo8XKHeo6ylN6SHEO8Ht+g7uEhLVfYzi3Mn7Kc2KkbIl30uCDpf
         90q0yNyrmETlsF0AH9v4f2SHXlQZp1ucjwtLjq/dP0rdEyCTrnSfuGH+JbS02Pn3fqDC
         42pg==
X-Gm-Message-State: ACrzQf0lBXsaVEO+d1aMdqVDmOKhZBIihpC2hDPk8HjmQHvZM4mZyRDN
        NzUH+jrSKcdKZ8zSu3jKHYwIjZPr5f2CbA==
X-Google-Smtp-Source: AMsMyM5Q7a7JmASuMY9pParoCfdqJdNS8Z+rq2KnBsVAFf04LpYyy2lX7qbKr1crKFTr+0BmPTWioQ==
X-Received: by 2002:a05:622a:304:b0:35d:4825:f812 with SMTP id q4-20020a05622a030400b0035d4825f812mr18214493qtw.467.1664851344183;
        Mon, 03 Oct 2022 19:42:24 -0700 (PDT)
Received: from joelboxx.c.googlers.com.com (228.221.150.34.bc.googleusercontent.com. [34.150.221.228])
        by smtp.gmail.com with ESMTPSA id 1-20020ac85901000000b0035cf5edefa6sm11793875qty.56.2022.10.03.19.42.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Oct 2022 19:42:23 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, rushikesh.s.kadam@intel.com,
        urezki@gmail.com, neeraj.iitr10@gmail.com, frederic@kernel.org,
        paulmck@kernel.org, rostedt@goodmis.org, youssefesmat@google.com,
        surenb@google.com,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>
Subject: [PATCH v7 06/11] percpu-refcount: Use call_rcu_flush() for atomic switch
Date:   Tue,  4 Oct 2022 02:41:52 +0000
Message-Id: <20221004024157.2470238-7-joel@joelfernandes.org>
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
In-Reply-To: <20221004024157.2470238-1-joel@joelfernandes.org>
References: <20221004024157.2470238-1-joel@joelfernandes.org>
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

call_rcu() changes to save power will slow down the percpu refcounter's
"per-CPU to atomic switch" path. The primitive uses RCU when switching to
atomic mode. The enqueued async callback wakes up waiters waiting in the
percpu_ref_switch_waitq. Due to this, per-CPU refcount users will slow down,
such as blk_pre_runtime_suspend().

Use the call_rcu_flush() API instead which reverts to the old behavior.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 lib/percpu-refcount.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/percpu-refcount.c b/lib/percpu-refcount.c
index e5c5315da274..65c58a029297 100644
--- a/lib/percpu-refcount.c
+++ b/lib/percpu-refcount.c
@@ -230,7 +230,8 @@ static void __percpu_ref_switch_to_atomic(struct percpu_ref *ref,
 		percpu_ref_noop_confirm_switch;
 
 	percpu_ref_get(ref);	/* put after confirmation */
-	call_rcu(&ref->data->rcu, percpu_ref_switch_to_atomic_rcu);
+	call_rcu_flush(&ref->data->rcu,
+		       percpu_ref_switch_to_atomic_rcu);
 }
 
 static void __percpu_ref_switch_to_percpu(struct percpu_ref *ref)
-- 
2.38.0.rc1.362.ged0d419d3c-goog

