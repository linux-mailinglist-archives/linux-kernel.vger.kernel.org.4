Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5472D62FDE2
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 20:19:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242008AbiKRTTd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 14:19:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235527AbiKRTT3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 14:19:29 -0500
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9E0A6457D
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 11:19:26 -0800 (PST)
Received: by mail-qk1-x735.google.com with SMTP id k4so4111329qkj.8
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 11:19:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8hJIDHLBXF0giuH5POYZYhMSuPEuGT60Uc/uAs3zlWI=;
        b=pshyycCa9K3066tR7yK8eyCk/6IKgxQcw8JtBoKV/FxCYuUPhkZia4zqJr7ZOQsnsH
         tiHH4G51c7+2xyWLJOSzUt5s5IsgPwglvg2P5o60nmoZWQeCT0XL6DeQBCZVQH9VAf/R
         hk3ORJwKdt+yY2896qFj/fpXzjZYA2dmIyPjc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8hJIDHLBXF0giuH5POYZYhMSuPEuGT60Uc/uAs3zlWI=;
        b=lF0Jx+qQhVaaUNR9ROEkCVOaStUjqMXsIzQ5Msg+i7zrcvXEaezm78zrRfkHnPTm/E
         IMrFXFTdZm+jqDev5o2rVwn3HrvQ5h+CwvLVS29WlP4SifKEJ/fsWU3WKxotAaOBU9sO
         xPvleGzDdwfsKdN8MqJSaJh6oXlmOyXvq5paaZGFY6TYbh5NigJtpg6NC7/Z2eQEd8aM
         PuCi9mWe02IkJL17Z8HAWGOJnfzDFwz9NuVSvILCL8VA7pWLWn/zqBtyreKeWs9WNG76
         pr3IQmLn+p9ZSKNMmQXPyZhh5Foik0U3M70Vj+hH6CU/uXhVFFgNG6twLTRuZI0qHfHU
         yXpw==
X-Gm-Message-State: ANoB5pnsePGs39oTxgNSn73SwvwcnndD6fhWSckBmhHbDc3e3W+XBAUj
        9HDRigdJlGQnMRx8G73d7MJdLAL7XBn4FQ==
X-Google-Smtp-Source: AA0mqf58VSjEf3FAcQabR+Xop4/j7v2952HvBQjGH8tmzs2eH3+2gemV+ZeRzoF1BoJ1dfrjJvMJcw==
X-Received: by 2002:ae9:e50d:0:b0:6f9:f247:88ca with SMTP id w13-20020ae9e50d000000b006f9f24788camr7209922qkf.59.1668799165793;
        Fri, 18 Nov 2022 11:19:25 -0800 (PST)
Received: from joelboxx.c.googlers.com.com (228.221.150.34.bc.googleusercontent.com. [34.150.221.228])
        by smtp.gmail.com with ESMTPSA id w9-20020a05620a424900b006ce2c3c48ebsm2958122qko.77.2022.11.18.11.19.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 11:19:25 -0800 (PST)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        David Ahern <dsahern@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
        Paolo Abeni <pabeni@redhat.com>, rcu@vger.kernel.org,
        rostedt@goodmis.org, paulmck@kernel.org, fweisbec@gmail.com
Subject: [PATCH v2 1/2] net: Use call_rcu_flush() for dst_destroy_rcu
Date:   Fri, 18 Nov 2022 19:19:08 +0000
Message-Id: <20221118191909.1756624-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.38.1.584.g0f3c55d4c2-goog
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

In a networking test on ChromeOS, we find that using the new
CONFIG_RCU_LAZY causes a networking test to fail in the teardown phase.

The failure happens during: ip netns del <name>

Using ftrace, I found the callbacks it was queuing which this series fixes.
Use call_rcu_flush() to revert to the old behavior. With that, the test
passes.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 net/core/dst.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/dst.c b/net/core/dst.c
index bc9c9be4e080..15b16322703f 100644
--- a/net/core/dst.c
+++ b/net/core/dst.c
@@ -174,7 +174,7 @@ void dst_release(struct dst_entry *dst)
 			net_warn_ratelimited("%s: dst:%p refcnt:%d\n",
 					     __func__, dst, newrefcnt);
 		if (!newrefcnt)
-			call_rcu(&dst->rcu_head, dst_destroy_rcu);
+			call_rcu_flush(&dst->rcu_head, dst_destroy_rcu);
 	}
 }
 EXPORT_SYMBOL(dst_release);
-- 
2.38.1.584.g0f3c55d4c2-goog

