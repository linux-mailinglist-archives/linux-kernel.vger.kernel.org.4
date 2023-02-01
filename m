Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DA196869A0
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 16:10:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232585AbjBAPKv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 10:10:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232905AbjBAPJo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 10:09:44 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBACC66FA4;
        Wed,  1 Feb 2023 07:08:24 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id m2so51835654ejb.8;
        Wed, 01 Feb 2023 07:08:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fO35H2/wXICWhJ+cuarq0XINTUHDojZ1200QGctnX2s=;
        b=SUl+ss9v5UYWv8NVc+1bIneBIoOFhC93EyGiZTsCfA+JgqnMTLsUJhloNmitcDPyah
         zhSiml1PTBGgW/R81AmM8CTk6Sj107GDnZP+DAs2hC79RVmKywEOAQw+7F97t87n5cb/
         3SNTvvcC2eb61GOiCXqztxc82x8jzbFrDdEn2F+X6XmhlCMNavxIn5Jx3//Xss8BFX9y
         8IZv9wIxrUFj4shJIPlq8ONgV0y93Ww0E/IRPe+0kwCfnhC/ue90egwnnvkSpBl36z6T
         ggsXtcw+ss/53rVrtqvTPDTvvwDTGVjAShKJ752MLUXrcN0ksnOd9hhHEYWgFG4uUZE1
         1+pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fO35H2/wXICWhJ+cuarq0XINTUHDojZ1200QGctnX2s=;
        b=ALDzzQQQ65gEdIM+Irwb5UmVjK/wpoBAIUnZmJIkcb+wT7tVTxCaVvQCG28ztJzsFj
         1W/KSJRcgaMwbcvEReY9liyzdDVZTnXgQEVRQreGhai8/84rSrDRSGHoBkHghG60lx0h
         2RluuGjMZl5x9FKN7zD6KLd7/BeqOvTBvdyW8BTG5bMt5s7EhRmJOHZHiDs+aAi/aIY7
         IzPPQK0X8cc6iJGNSUGQ3tTjdOdg/N70rTvMPeSZjREm/6w+Rl7nbaT57ssaXuft92rM
         6uPqglyViXId0GOsHZa8+wAqFRYKRfGRB9w4A9rOGB+znkh9LwZx7Mgg+IbOEUtv8BcC
         MoFw==
X-Gm-Message-State: AO0yUKUIlHv7De7aM5Td+kfcC7d+wizvaIDcYZUzNRU7RtIqBCaBp9Ff
        uMiVjyu9LfrHZeLbbGVxAx2rhj4/B5d+KQ==
X-Google-Smtp-Source: AK7set9aFDpwzIr/zYc4RTSpyE0YXhwfxTDiMJwKhIebZokzv2cysN23I5YVLaBbRST0AMkJPPC5WA==
X-Received: by 2002:a17:907:e8e:b0:878:7ba6:b69 with SMTP id ho14-20020a1709070e8e00b008787ba60b69mr8224743ejc.51.1675264102547;
        Wed, 01 Feb 2023 07:08:22 -0800 (PST)
Received: from pc638.lan ([155.137.26.201])
        by smtp.gmail.com with ESMTPSA id qc26-20020a170906d8ba00b008787e94c5ccsm9585774ejb.184.2023.02.01.07.08.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Feb 2023 07:08:22 -0800 (PST)
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
Subject: [PATCH 05/13] lib/test_vmalloc.c: Rename kvfree_rcu() to kvfree_rcu_mightsleep()
Date:   Wed,  1 Feb 2023 16:08:11 +0100
Message-Id: <20230201150815.409582-6-urezki@gmail.com>
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

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 lib/test_vmalloc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/test_vmalloc.c b/lib/test_vmalloc.c
index f90d2c27675b..6d8c5c0afd53 100644
--- a/lib/test_vmalloc.c
+++ b/lib/test_vmalloc.c
@@ -328,7 +328,7 @@ kvfree_rcu_1_arg_vmalloc_test(void)
 			return -1;
 
 		p->array[0] = 'a';
-		kvfree_rcu(p);
+		kvfree_rcu_mightsleep(p);
 	}
 
 	return 0;
-- 
2.30.2

