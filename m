Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CC4374332C
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 05:27:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230455AbjF3D1Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 23:27:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbjF3D1G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 23:27:06 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55D1EEE;
        Thu, 29 Jun 2023 20:27:04 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id 41be03b00d2f7-55b22f82ac8so841772a12.1;
        Thu, 29 Jun 2023 20:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688095624; x=1690687624;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OwJdxtfFrP5LDWYvOjXG/8S5IIrimErpt5RB/JNheSE=;
        b=UrTWzEhAs+uDg/yjovT/P0+gJNzpklPq6m6cKjIR9AkFka1gxu6fSuoNLtS02ceZt5
         guvmJSGfqM+wli3R8srIWUDG/ULFMgjCXBhS6c2x2/9YdHZQXdprWL44spcBbfwwbCFH
         qGVytoTEluJAu7j8se2b4EYnT4WVNd161B3hozIsfJC0N7T2pZ1CvDkP4sHI5LshBLwo
         u4rHTdrhmFPDNRSIjQqMzuLG92GKAU8oz0nLBLlpJ4TFYshlkaA/D6B17JbANgJhpzbt
         qXYdwyQ9bU+iQqMOCTOypa3WRpJL8LzpClPSZfLxO/KkP41E2eQCfnh8arYosv6cc4m4
         lBww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688095624; x=1690687624;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OwJdxtfFrP5LDWYvOjXG/8S5IIrimErpt5RB/JNheSE=;
        b=UBjnKgpNTOPqsawAqOdfli9QbpesNrPg00z8qSmgUAfX8r3fEGMRhdmhyweeGi56Yy
         KsDTuiVqgmoN7EXRClYvaG/fRTIuZmYENo7EC0fXm7gePAeixBEKqTXzuIEEYsSzxkKl
         q6Cl9RJYrnLYb7mcWMF/08fOEdjL/cq/s8ufYN/CWywgvP6N9QInONia1hlDlvv//oeh
         5DCVeKrSRD9WCiWZo1VTaM+1KkibH9eXV5BO7uefGllkA+5vo1nG51884pUfQvoqNsPO
         FYTmU5OB4pGfvetSJ31b5PhkDGUCGa2RxiX4evw+cZnRDYd69YKXlw3VMJZyr5KjzOid
         mZeg==
X-Gm-Message-State: AC+VfDyCsV9c/4UuP0p3gs+LjvHt02YEKy0lg1zyL50CW6MWTDQ8Pa6N
        WLpNj/TzZZpYDH3B8TkDov0=
X-Google-Smtp-Source: ACHHUZ6kI7/WGYNJumGm8WA2cqr2+O5OQxu2/AzvugDGTDYOTHMC6HQfIRfY4baaYqRLpwQ9xWY1vQ==
X-Received: by 2002:a17:90b:1c04:b0:262:f550:6413 with SMTP id oc4-20020a17090b1c0400b00262f5506413mr7931207pjb.6.1688095623692;
        Thu, 29 Jun 2023 20:27:03 -0700 (PDT)
Received: from MSCND1355B05.fareast.nevint.com ([183.242.39.186])
        by smtp.gmail.com with ESMTPSA id x2-20020a17090a294200b00262ca945cecsm10311911pjf.54.2023.06.29.20.26.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jun 2023 20:27:03 -0700 (PDT)
From:   Zqiang <qiang.zhang1211@gmail.com>
To:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, qiang.zhang1211@gmail.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] net: Destroy previously created kthreads after failing to set napi threaded mode
Date:   Fri, 30 Jun 2023 11:26:53 +0800
Message-Id: <20230630032653.26426-1-qiang.zhang1211@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When setting 1 to enable napi threaded mode, will traverse dev->napi_list
and create kthread for napi->thread, if creation fails, the dev->threaded
will be set to false and we will clear NAPI_STATE_THREADED bit for all
napi->state in dev->napi_list, even if some napi that has successfully
created the kthread before. as a result, for successfully created napi
kthread, they will never be used.

This commit therefore destroy previously created napi->thread if setting
napi threaded mode fails.

Signed-off-by: Zqiang <qiang.zhang1211@gmail.com>
---
 net/core/dev.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 69a3e544676c..9929f0567150 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -6317,10 +6317,13 @@ int dev_set_threaded(struct net_device *dev, bool threaded)
 	 * This should not cause hiccups/stalls to the live traffic.
 	 */
 	list_for_each_entry(napi, &dev->napi_list, dev_list) {
-		if (threaded)
+		if (threaded) {
 			set_bit(NAPI_STATE_THREADED, &napi->state);
-		else
+		} else {
 			clear_bit(NAPI_STATE_THREADED, &napi->state);
+			if (napi->thread)
+				kthread_stop(napi->thread);
+		}
 	}
 
 	return err;
-- 
2.17.1

