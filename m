Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C7066869A6
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 16:11:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231862AbjBAPLZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 10:11:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231910AbjBAPK2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 10:10:28 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 373595BA3;
        Wed,  1 Feb 2023 07:09:59 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id qw12so36384652ejc.2;
        Wed, 01 Feb 2023 07:09:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w+s0R1N5QaJjHALhKlJSDlz82DJDrm00TxCc4cLTynw=;
        b=Qy9VJITeqinyGIT2g5k9PON9xuMsEZT32GMlDTA7zKIvzrlg5Z211EN1RzNeTX/mNx
         nB5CLyJHh3Jki7YQ3/feplUozmCCzwX1ABJbBEk2RbAJxdV8EcftopU3SZwc3oXTvymF
         k6VS/x2dgKnZDlwFr4kbgcolrs3bANv222/mQeCp/UpBMsRydfmSh4USN4/KodAA5dCM
         o23R5/YrTratVJXjGVfe8Eeq3+LaMjQKspQXMG6ZS4KqDWY2ip5IdBJJj4j3VPheGkwI
         8xeu6PT8TkD1oT+v3cdyuB4fH8botO5lAi08pY5ZdqYTdMxfETjNiF/QcxXgYqymXO3S
         ZxxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w+s0R1N5QaJjHALhKlJSDlz82DJDrm00TxCc4cLTynw=;
        b=FZlRI6RK/Sc5gg0MCcZ7p6deM5MSt1xxfJg9rVWr24clyU+pHbVWTFayO50FeVLsye
         y5FA366yOzJCXp+QvZCa94GTH5NDVc57c2XjZaGRXEUg64YZjm0Qrd7XQ2pJo6Wfzzxk
         iGHb/7AxPj4OnC67j0c5cPD2d1ArWzZX0dZjXdceoEKz76R4pM+qJfRjvFe/D3wbDuKO
         MpRSDMq5YU7thONKuGn0bIHNrj7ICB/PKLGNASSukaXhfEby0TrmR8XkCpaFMBftLpmm
         CqcbwCu3gAgH5iU81XobYlkNFpnDXt8+M8smQpM96bRpgBGIZEQL3fIvCz4aPjnFQlYl
         4QCg==
X-Gm-Message-State: AO0yUKXkUYljtJt/UYHnQFDkT/cxvxpohkYx0Kh/KOmPVu8UGxKFD6VJ
        /bp9gnC9iLnhwhN2niPhRoz0/B5xJNtCbg==
X-Google-Smtp-Source: AK7set8ZyNUoXKvFo6xr0GrDAZKFdBPmefZVr+mqOJR23Id/PYszl3ggYPzgMQme0vYI5wfLbPhxHQ==
X-Received: by 2002:a17:906:688b:b0:87b:7c1d:e02b with SMTP id n11-20020a170906688b00b0087b7c1de02bmr2263849ejr.36.1675264197595;
        Wed, 01 Feb 2023 07:09:57 -0800 (PST)
Received: from pc638.lan ([155.137.26.201])
        by smtp.gmail.com with ESMTPSA id fe15-20020a1709072a4f00b008845c668408sm6627147ejc.169.2023.02.01.07.09.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Feb 2023 07:09:57 -0800 (PST)
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
Subject: [PATCH 11/13] rcuscale: Rename kfree_rcu() to kfree_rcu_mightsleep()
Date:   Wed,  1 Feb 2023 16:09:52 +0100
Message-Id: <20230201150954.409693-2-urezki@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230201150954.409693-1-urezki@gmail.com>
References: <20230201150954.409693-1-urezki@gmail.com>
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

The kfree_rcu()'s single argument name is deprecated therefore
rename it to kfree_rcu_mightsleep() variant. The goal is explicitly
underline that it is for sleepable contexts.

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 kernel/rcu/rcuscale.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/rcuscale.c b/kernel/rcu/rcuscale.c
index 4120f94030c3..e82ec9f9a5d8 100644
--- a/kernel/rcu/rcuscale.c
+++ b/kernel/rcu/rcuscale.c
@@ -715,7 +715,7 @@ kfree_scale_thread(void *arg)
 			// is tested.
 			if ((kfree_rcu_test_single && !kfree_rcu_test_double) ||
 					(kfree_rcu_test_both && torture_random(&tr) & 0x800))
-				kfree_rcu(alloc_ptr);
+				kfree_rcu_mightsleep(alloc_ptr);
 			else
 				kfree_rcu(alloc_ptr, rh);
 		}
-- 
2.30.2

