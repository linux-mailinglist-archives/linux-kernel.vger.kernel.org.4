Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF1C268699A
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 16:10:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232697AbjBAPKf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 10:10:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232866AbjBAPJl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 10:09:41 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41FDE65EDE;
        Wed,  1 Feb 2023 07:08:20 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id ml19so28739296ejb.0;
        Wed, 01 Feb 2023 07:08:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FL6Oc4kZz3pEC+42YRGjUorvq4as+oQYBQ3Rk/f90Ak=;
        b=AR9ckEL0F6ZlprE/CI0uy/u3yv2fo+PiSDAmBvbENe1OfrVUEbQDzo787z9Qz2f98J
         KYsAwCWWlKRXvfc+isW1EQ4+JPh1HFDHb030whCmUfp2nvHij65eBd0h20MXAYMefaz7
         f4k/AH/xdVeiMmiCKZ3VfuABC+Q4fV8j7Og3nyrMa2uT2fCdjHlDUbCtaCD9O8T2eWDa
         jBLaHtRgA+mWDSWTAWrczod4M+9/U2XItsPOwNoq//gupzLKVZWkpYxV+76/U/1IvI9f
         SS9DBVc9Kx3ogTtVLloOSrU3Ok820OMZer0l3KY1TxiBhMuNJPXdt6soiX0BF1866IBV
         +XtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FL6Oc4kZz3pEC+42YRGjUorvq4as+oQYBQ3Rk/f90Ak=;
        b=LuPCSeVYCnJh87105yL8LGsPRUkv/NUtKjwzPGVylWGd72DmS3u3hCZj2uHRwqYLOP
         VofinvRz66QIQuP0VSmSFzWg0vyvZtAAhdPPjjPaHzOLX1+VggnDRyPkweAv7HtXWeZ2
         d+sjxvx/OaCTSKS8SBbfgS8KrpoWLPbRZc01bkMkAHV6FYK9sBIuE16nsI9Je0Q6GokK
         np71aFwU/Y4oJF5XajVV7SmYTgnjwFS0V9l0ziDHK7Un79K8mGJ1QDKAD5WMWXldq2pz
         bFlJvTv6vegARy1eL9bhaDT8NRqicbmsxrCGXNZmF1VEgaIfklX0b1sK7ogzeFVtlc1H
         chMw==
X-Gm-Message-State: AO0yUKVxkcYaDu09iddSXiCfylUOGcF6LWVsAT84t8tvq9wlUp/v2bLq
        bF1nlSs0aZ/jqr9OjAnWyC+b8LciDpsS0A==
X-Google-Smtp-Source: AK7set+2Emu/z31mFR+MiehqK9jtu3+IQrWJKpQxRS+pJMof8FaeXtDcXO5m2F+a/Yi+xnonfAwa3A==
X-Received: by 2002:a17:906:7050:b0:886:8cd4:ef9d with SMTP id r16-20020a170906705000b008868cd4ef9dmr2685887ejj.22.1675264098637;
        Wed, 01 Feb 2023 07:08:18 -0800 (PST)
Received: from pc638.lan ([155.137.26.201])
        by smtp.gmail.com with ESMTPSA id qc26-20020a170906d8ba00b008787e94c5ccsm9585774ejb.184.2023.02.01.07.08.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Feb 2023 07:08:18 -0800 (PST)
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
Subject: [PATCH 01/13] rcu/kvfree: Add kvfree_rcu_mightsleep() and kfree_rcu_mightsleep()
Date:   Wed,  1 Feb 2023 16:08:07 +0100
Message-Id: <20230201150815.409582-2-urezki@gmail.com>
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

These two macroses will replace single-argument k[v]free_rcu() ones.
By adding an extra _mightsleep prefix we can avoid of situations when
someone intended to give a second argument but forgot to do it in a
code where sleeping is illegal.

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 include/linux/rcupdate.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index 822ff7b4bb1e..094321c17e48 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -1013,6 +1013,9 @@ static inline notrace void rcu_read_unlock_sched_notrace(void)
 #define kvfree_rcu(...) KVFREE_GET_MACRO(__VA_ARGS__,		\
 	kvfree_rcu_arg_2, kvfree_rcu_arg_1)(__VA_ARGS__)
 
+#define kvfree_rcu_mightsleep(ptr) kvfree_rcu_arg_1(ptr)
+#define kfree_rcu_mightsleep(ptr) kvfree_rcu_mightsleep(ptr)
+
 #define KVFREE_GET_MACRO(_1, _2, NAME, ...) NAME
 #define kvfree_rcu_arg_2(ptr, rhf)					\
 do {									\
-- 
2.30.2

