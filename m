Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C24BC5BB97D
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Sep 2022 18:42:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbiIQQmm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Sep 2022 12:42:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbiIQQmg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Sep 2022 12:42:36 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AEB82E685
        for <linux-kernel@vger.kernel.org>; Sat, 17 Sep 2022 09:42:33 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id i15so18942024qvp.5
        for <linux-kernel@vger.kernel.org>; Sat, 17 Sep 2022 09:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=YtXTLA3M+nWqodgxztJaMgLvSRyU03TOMEk16miDVSg=;
        b=ShOLZGx75Ii8OwDydiUuECJDaVrzXu7dm1LvXWu1uMAHXy8OWxy3+sY1KgJKUVy9sc
         lJGUEgu7gVKBhWs0Wz0ZhBtUO3JLjqMoq0kpgajDLoDILUKTL2HipbaT+ktS1fFKI787
         zPzc24o/oNUffNEGEUH9lEkxMlvjJIA+zFR6g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=YtXTLA3M+nWqodgxztJaMgLvSRyU03TOMEk16miDVSg=;
        b=RI4etayul/Fe+e0dZef6Cb9+Luujiv46tedd1dcMSE+fwzPNf0NwQyzjk3/e+9DEGD
         3MTv85yJlF5yjHV1gYu5UVtwiUmnmJXICqgB9i4zu4YfEfwPhWhiV9PoAAWPvxwtJxrR
         Jat55L27fZg3joJgUSlLJSH84wQtfLXY6cvm3u6LZRlSQ3wpwTL/95FcanWq/Igq8KcF
         Bcewf2dxVHYBfKJO+M2AgWF6Jn5WWwVa+f6AGFzc39sDxUfnERFxYjM4gZ0cnFk2IOgk
         QNdrZWbX/Lzbm6aSOEp9mZvlCdwltTEb+FXRK2KZhjsIh8TNQkjGVgmOfG9rJHcBdlzQ
         Rnwg==
X-Gm-Message-State: ACrzQf3riaLD3Qx7gGxwZerJGlLH8LNUeXd2UXXCZnZ96su5lzObFY85
        AELkHZO2qOaT6eqCdTb8p+f5Nw==
X-Google-Smtp-Source: AMsMyM4IYHlTU6MQt7EpgMPbONgN5h3lvYXkOHlxQ4yG2OYh9ORFH9JAXc2T1IMbliGqy+f9+mm10Q==
X-Received: by 2002:a05:6214:1d21:b0:4ad:1361:befa with SMTP id f1-20020a0562141d2100b004ad1361befamr6419573qvd.111.1663432952613;
        Sat, 17 Sep 2022 09:42:32 -0700 (PDT)
Received: from joelboxx.c.googlers.com.com (228.221.150.34.bc.googleusercontent.com. [34.150.221.228])
        by smtp.gmail.com with ESMTPSA id q31-20020a05620a2a5f00b006bb0e5ca4bbsm9479239qkp.85.2022.09.17.09.42.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Sep 2022 09:42:32 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, rushikesh.s.kadam@intel.com,
        urezki@gmail.com, neeraj.iitr10@gmail.com, frederic@kernel.org,
        paulmck@kernel.org, rostedt@goodmis.org,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>
Subject: [PATCH rcu/next 1/3] rcu/tree: Use READ_ONCE() for lockless read of rnp->qsmask
Date:   Sat, 17 Sep 2022 16:41:58 +0000
Message-Id: <20220917164200.511783-2-joel@joelfernandes.org>
X-Mailer: git-send-email 2.37.3.968.ga6b4b080e4-goog
In-Reply-To: <20220917164200.511783-1-joel@joelfernandes.org>
References: <20220917164200.511783-1-joel@joelfernandes.org>
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

The rnp->qsmask is locklessly accessed from rcutree_dying_cpu(). This
may help avoid load tearing due to concurrent access, KCSAN
issues, and preserve sanity of people reading the mask in tracing.

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/rcu/tree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 0ca21ac0f064..5ec97e3f7468 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2106,7 +2106,7 @@ int rcutree_dying_cpu(unsigned int cpu)
 	if (!IS_ENABLED(CONFIG_HOTPLUG_CPU))
 		return 0;
 
-	blkd = !!(rnp->qsmask & rdp->grpmask);
+	blkd = !!(READ_ONCE(rnp->qsmask) & rdp->grpmask);
 	trace_rcu_grace_period(rcu_state.name, READ_ONCE(rnp->gp_seq),
 			       blkd ? TPS("cpuofl-bgp") : TPS("cpuofl"));
 	return 0;
-- 
2.37.3.968.ga6b4b080e4-goog

