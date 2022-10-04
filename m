Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6B9A5F3CBE
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 08:26:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbiJDG0U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 02:26:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbiJDG0Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 02:26:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 377833FA0C
        for <linux-kernel@vger.kernel.org>; Mon,  3 Oct 2022 23:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664864769;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=ATSwXcQokmwIH/YgclkGZO8BhI6NMe9jQwAsKeX4mSE=;
        b=LVpIe1lrF0/LLRTLHXa+LmUNgXzpTuovxxPWJ9zL+DXG01jsKeQNIzJu2ut+wWfTiajNhN
        JSKKO29Fst8gkFCUnCA98jVMxeWuO9lFj0cZn9ME8iTmzozhWzKrw5DnA3H11nYVbtSU8b
        ANiWPHg7tZL1Sf8XbF9hVxBWwefqVTs=
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com
 [209.85.221.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-656-6X5n_271Ndu2JG0GdX4uVg-1; Tue, 04 Oct 2022 02:26:00 -0400
X-MC-Unique: 6X5n_271Ndu2JG0GdX4uVg-1
Received: by mail-vk1-f197.google.com with SMTP id v67-20020a1fac46000000b003a2699aa42fso2812886vke.8
        for <linux-kernel@vger.kernel.org>; Mon, 03 Oct 2022 23:26:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=ATSwXcQokmwIH/YgclkGZO8BhI6NMe9jQwAsKeX4mSE=;
        b=FLQ7aLs9MUHakWSWrL0e3OOlEN964A2jwi/XY2SiXvGoFToJwSG5RU/AI1KpalZBEg
         qLZAUdPbi5IyxKwatej/ecyCZzxkUYDCURbZcXs7FUWoMQZ0Gn5sYKRJ01XLaWHZALuT
         QZMqcz7oTTKdjgZS6yAEaA+3H+tmt+n9o7Xx3TzlX91KATNcgzVb9r/AkI1b+bH3Vwnl
         OeCLa748+JMNz+KoFnqIi5Wao3U3diGTE7G6Bidcz5VLTx5F/wKCl8JxOIGqrdmSogmr
         iGDNn4QDXuuRqHcTMbZmsPT8swD45nRsl48W+N88zYsD66Bzqjmz+wQpBV81fhL6aNiK
         RztA==
X-Gm-Message-State: ACrzQf1m0PBBLOar/tAMvsUWNl2y6ym55Bl/G1Idy7k7SHZmhbUKcktk
        Mp0oryW0WZEMKolTYHy2OadYhppNQApEIWxskJAOgn0ae2uH84RoN3zk6Dqz6sXEgIABpCMKKOL
        Vny4anTCuuBuYR0RRTH5Sydyb
X-Received: by 2002:a1f:ac16:0:b0:3a3:258:3442 with SMTP id v22-20020a1fac16000000b003a302583442mr10220611vke.2.1664864759823;
        Mon, 03 Oct 2022 23:25:59 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4XbdLYaoQUUg8Mgb6U0GIeBHnweooSVWMg0hl/x+bHpaNodSp5SoFkdNa6MKUGg9K0/GQYpA==
X-Received: by 2002:a1f:ac16:0:b0:3a3:258:3442 with SMTP id v22-20020a1fac16000000b003a302583442mr10220605vke.2.1664864759648;
        Mon, 03 Oct 2022 23:25:59 -0700 (PDT)
Received: from localhost.localdomain ([2804:1b3:a801:6b4a:8652:f462:a76a:cc3a])
        by smtp.gmail.com with ESMTPSA id r196-20020a1fc1cd000000b003aa8c4ebfb8sm2521168vkf.50.2022.10.03.23.25.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Oct 2022 23:25:58 -0700 (PDT)
From:   Leonardo Bras <leobras@redhat.com>
To:     Steffen Klassert <steffen.klassert@secunet.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>, mtosatti@redhat.com
Cc:     Leonardo Bras <leobras@redhat.com>, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/1] crypto/pcrypt: Do not use isolated CPUs for callback
Date:   Tue,  4 Oct 2022 03:25:37 -0300
Message-Id: <20221004062536.280712-1-leobras@redhat.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently pcrypt_aead_init_tfm() will pick callback cpus (ctx->cb_cpu)
from any online cpus. Later padata_reorder() will queue_work_on() the
chosen cb_cpu.

This is undesired if the chosen cb_cpu is listed as isolated (i.e. using
isolcpus=... kernel parameter), since the work queued will interfere with
the workload on the isolated cpu.

Make sure isolated cpus are not used for pcrypt.

Signed-off-by: Leonardo Bras <leobras@redhat.com>
---
 crypto/pcrypt.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/crypto/pcrypt.c b/crypto/pcrypt.c
index 9d10b846ccf73..9017d08c91a8d 100644
--- a/crypto/pcrypt.c
+++ b/crypto/pcrypt.c
@@ -16,6 +16,7 @@
 #include <linux/kobject.h>
 #include <linux/cpu.h>
 #include <crypto/pcrypt.h>
+#include <linux/sched/isolation.h>
 
 static struct padata_instance *pencrypt;
 static struct padata_instance *pdecrypt;
@@ -175,13 +176,16 @@ static int pcrypt_aead_init_tfm(struct crypto_aead *tfm)
 	struct pcrypt_instance_ctx *ictx = aead_instance_ctx(inst);
 	struct pcrypt_aead_ctx *ctx = crypto_aead_ctx(tfm);
 	struct crypto_aead *cipher;
+	struct cpumask non_isolated;
+
+	cpumask_and(&non_isolated, cpu_online_mask, housekeeping_cpumask(HK_TYPE_DOMAIN));
 
 	cpu_index = (unsigned int)atomic_inc_return(&ictx->tfm_count) %
-		    cpumask_weight(cpu_online_mask);
+		    cpumask_weight(&non_isolated);
 
-	ctx->cb_cpu = cpumask_first(cpu_online_mask);
+	ctx->cb_cpu = cpumask_first(&non_isolated);
 	for (cpu = 0; cpu < cpu_index; cpu++)
-		ctx->cb_cpu = cpumask_next(ctx->cb_cpu, cpu_online_mask);
+		ctx->cb_cpu = cpumask_next(ctx->cb_cpu, &non_isolated);
 
 	cipher = crypto_spawn_aead(&ictx->spawn);
 
-- 
2.37.3

