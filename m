Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5E556BBD6A
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 20:39:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232641AbjCOTja (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 15:39:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232475AbjCOTjP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 15:39:15 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B33A95BD92
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 12:39:13 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id r5so17488804qtp.4
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 12:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1678909152;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gkIW82Jn8PaGpB7B+YMqBxYys/Ya8U+pTY1r1WqXQ8E=;
        b=WDyMAh8LBvLv8TcPocJTlQ9oUFNWyhm52mv3Oy3aloVLjA3GPz2f/kf8L3QTmisA+e
         vZgmipdZ/oNQKbH4mBAG642qB5ciV2dFTAwbxCn78S00oXbU2BV2vHJUJJN4nLcJXPcT
         yt/KduCRJHeohmdt8cRIjsM2rwQYsvJ1QusRs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678909152;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gkIW82Jn8PaGpB7B+YMqBxYys/Ya8U+pTY1r1WqXQ8E=;
        b=VMFDAxSFmXw+7PRoqinn3+6cUTYdiWV2iR+fSRwvGOKvCf+xwWPrLX4eyXm1O3QKR+
         EWv2wXllDmzbdXqpLpMhefJdhiDVUHUL6ZdkCBsKSlKw+obFlRMzcvXnDqERF7o2iLmM
         HxJEcry2Qbs3pSI1sfGK+VVICzDl5krb3mnYlI7wSW/jHk1NADRJ/sQLzy4Eu70+WpSE
         +MfHUgg1M/kzMG/U0YppP8HlDaucxwXs3KrRKFxuZa43MX2omdRHMPakTTi+yDO48inw
         M0UQZuCgewac4IibFJSut4rs/rql2V8rdu/R+0PU2EFcbh2M46OrvLw9Mv/jsEVgqXNX
         oZXA==
X-Gm-Message-State: AO0yUKXKw2re5XNqbIMAYl9QKr+aBD3oFsddvWR9UEUHXg+VvpWn2rcQ
        h3g+iWkkRE8Ce65lypqGUCPxkpffE0I2kzf3DTY=
X-Google-Smtp-Source: AK7set/lTZX4a5orBcEG4pZUqPqTc+JtcMojbfiFqsyvENbRhEu8ihMok00SZO1QIyKvQQxg2HMNhQ==
X-Received: by 2002:a05:622a:284:b0:3bd:140c:91ed with SMTP id z4-20020a05622a028400b003bd140c91edmr1637192qtw.52.1678909152452;
        Wed, 15 Mar 2023 12:39:12 -0700 (PDT)
Received: from joelboxx.c.googlers.com.com (129.239.188.35.bc.googleusercontent.com. [35.188.239.129])
        by smtp.gmail.com with ESMTPSA id s10-20020a05620a254a00b00745af48838bsm4347227qko.5.2023.03.15.12.39.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 12:39:11 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Qiuxu Zhuo <qiuxu.zhuo@intel.com>, rcu@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: [PATCH 2/6] Documentation/RCU: s/not/note/ in checklist.rst
Date:   Wed, 15 Mar 2023 19:38:47 +0000
Message-Id: <20230315193851.8598-2-joel@joelfernandes.org>
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
In-Reply-To: <20230315193851.8598-1-joel@joelfernandes.org>
References: <20230315193851.8598-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Qiuxu Zhuo <qiuxu.zhuo@intel.com>

"Please not that you *cannot* rely..." has a typo.
Fix it.

Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 Documentation/RCU/checklist.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/RCU/checklist.rst b/Documentation/RCU/checklist.rst
index cc361fb01ed4..bd3c58c44bef 100644
--- a/Documentation/RCU/checklist.rst
+++ b/Documentation/RCU/checklist.rst
@@ -70,7 +70,7 @@ over a rather long period of time, but improvements are always welcome!
 	can serve as rcu_read_lock_sched(), but is less readable and
 	prevents lockdep from detecting locking issues.
 
-	Please not that you *cannot* rely on code known to be built
+	Please note that you *cannot* rely on code known to be built
 	only in non-preemptible kernels.  Such code can and will break,
 	especially in kernels built with CONFIG_PREEMPT_COUNT=y.
 
-- 
2.40.0.rc1.284.g88254d51c5-goog

