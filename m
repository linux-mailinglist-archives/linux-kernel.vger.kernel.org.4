Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E75EB6869A2
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 16:11:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231512AbjBAPK5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 10:10:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232018AbjBAPJl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 10:09:41 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EC6966FA3;
        Wed,  1 Feb 2023 07:08:23 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id hx15so32759982ejc.11;
        Wed, 01 Feb 2023 07:08:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bT+cSsz2JrZskcNzFL2BkroViG0oFNVaYfW1YmvtVLg=;
        b=MbTXjK1aKcldZ1ocYRQ8KR3IhAxYTzuOdQl734t9wmuLuz1vNvm2N6voBZm3Rdi4B2
         modsjehD8rJK6TB3IicMeihhuJckxR9bFA+BOSDy/UeP3Xy2PGtavZFn4pga6QbEAnVI
         l5/jvA3fOO98TNL/u81nzHFyhZNrcXg8KYKQaxXqbkae2jX5OOoZEWNv4gOWS4VHv1Yd
         DJgnIHELt9l04IUvxl15YRvHxPqCfn8vLPeIOVe9yAzc/18J+EIP5+HGHYRulTtrstxH
         PHAwkLCbDtqhgzyUc6F8k0cFPZKgOaSUJQxQ3p2XzNKxEOFP9ZacBMtthZGZYvXOjM+P
         uJHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bT+cSsz2JrZskcNzFL2BkroViG0oFNVaYfW1YmvtVLg=;
        b=hW6HRpoQMSd1wtmRerwRLGMmyqKQL3UYLG6AW01bgf9GgJJ/ZW88aqDsvuqWAgZDuN
         8lSeUW08LvXqY3Ggo4LMxJ1FBI8tfxNkzjRVeSC3tAbgjjwz7kCXJ4fl4JlnWzkW4Dm1
         KqoKkFcd1Mei5eAq453UtW98nbJy+YsJa2i9SYztEYFopsxftJ+T9EiHRPnXzlDYfFm1
         t4IL4FaI+ZGNLDwdqbIAk6qC+R/VU8qECUkvsUE3fKE65DdroyaQ88OUg/SrIxBChbli
         K2DLvXpk6U2ZjHuTiK4Geg4QbmmU+riZRWP6q2mg+pkFHOQWb9n+RHs8EjQORC+wdywe
         3RDA==
X-Gm-Message-State: AO0yUKUMvCo+SuV7vvqJWqJKiQOLkPGCgSQFQ3Bg3OrLSoktbHonkSUo
        LiHCRj5XnFiasX6fp2iwHonei/oXYJW3KA==
X-Google-Smtp-Source: AK7set9ffcrAEyHawqVjHlsonanOonFJEAXupajZTTKpre/ichXrJUx8ThkcdOWWc/uLkyLkIscf2w==
X-Received: by 2002:a17:907:c20c:b0:883:3661:97e5 with SMTP id ti12-20020a170907c20c00b00883366197e5mr2107344ejc.50.1675264101634;
        Wed, 01 Feb 2023 07:08:21 -0800 (PST)
Received: from pc638.lan ([155.137.26.201])
        by smtp.gmail.com with ESMTPSA id qc26-20020a170906d8ba00b008787e94c5ccsm9585774ejb.184.2023.02.01.07.08.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Feb 2023 07:08:21 -0800 (PST)
From:   "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
        Jens Axboe <axboe@kernel.dk>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        Bryan Tan <bryantan@vmware.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Eric Dumazet <edumazet@google.com>,
        Bob Pearson <rpearsonhpe@gmail.com>,
        Ariel Levkovich <lariel@nvidia.com>,
        Theodore Ts'o <tytso@mit.edu>, Julian Anastasov <ja@ssi.bg>
Subject: [PATCH 04/13] tracing: Rename kvfree_rcu() to kvfree_rcu_mightsleep()
Date:   Wed,  1 Feb 2023 16:08:10 +0100
Message-Id: <20230201150815.409582-5-urezki@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230201150815.409582-1-urezki@gmail.com>
References: <20230201150815.409582-1-urezki@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kvfree_rcu()'s single argument name is deprecated therefore
rename it to kvfree_rcu_mightsleep() variant. The goal is explicitly
underline that it is for sleepable contexts.

Cc: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 kernel/trace/trace_osnoise.c | 2 +-
 kernel/trace/trace_probe.c   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
index 94c1b5eb1dc0..67392d872b67 100644
--- a/kernel/trace/trace_osnoise.c
+++ b/kernel/trace/trace_osnoise.c
@@ -160,7 +160,7 @@ static void osnoise_unregister_instance(struct trace_array *tr)
 	if (!found)
 		return;
 
-	kvfree_rcu(inst);
+	kvfree_rcu_mightsleep(inst);
 }
 
 /*
diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index 01ebabbbe8c9..32a7741dc731 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -1170,7 +1170,7 @@ int trace_probe_remove_file(struct trace_probe *tp,
 		return -ENOENT;
 
 	list_del_rcu(&link->list);
-	kvfree_rcu(link);
+	kvfree_rcu_mightsleep(link);
 
 	if (list_empty(&tp->event->files))
 		trace_probe_clear_flag(tp, TP_FLAG_TRACE);
-- 
2.30.2

