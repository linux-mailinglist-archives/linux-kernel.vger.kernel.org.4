Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB31D6E456E
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 12:41:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231196AbjDQKlP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 06:41:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230270AbjDQKlJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 06:41:09 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 115F85FD8;
        Mon, 17 Apr 2023 03:40:15 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3f173af6712so5392655e9.1;
        Mon, 17 Apr 2023 03:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681727988; x=1684319988;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HVv7DQKmipBRsAlvjF/Xgt2k292ApUl27jLAieToJD4=;
        b=N2l7o0i/qr38pvN84zrzRmAVqphwalgLltPICajVbq3kBSm9Tp8tQPeGgj3gjH2JGB
         GZB2pIhqNHGwVwRrznQTWJK0S2F1je3qU1SioBp3gw9d+yeARYYVMb5bEy2PATha9TB3
         RpL+tfh7PDIObTykwpMwBw8zRypbjeMogmKLJhERbHU/wSlMEpH4PlQoXIXOF8AnT1Bh
         nZ/LooqF/DU1YDodkwwO/KTeOMY2WL+CJLByGEakl2odWGfBQ2qYJQ9D0WE5DyurplLn
         g16KOXuutH4S+M85pDPMNtomiozeo0vPjrnZQ4q70J/kHK4hVWxxS+W5x+A6fwAKSrsK
         nMrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681727988; x=1684319988;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HVv7DQKmipBRsAlvjF/Xgt2k292ApUl27jLAieToJD4=;
        b=dIDAAyeLUlEPrKpeAVya6EV5FNuacCmEbC4Jnobow97apgIHsITk2L5DSaEW+p8/eL
         DPwMOlqJrtknkFrPkv2ooDHmRj6q3tDFYWcDz6E8sZBAgNBD6f5wDcpeCPsGT84ZK2Q5
         yEMqIstav/qxhaO3sc7uVub2aOln0tDGm9QSO3hD6Y1HLRXUx3f8UGZgs1/21xjKbf1t
         BbLaVZOxdyqpW/cUuthlrwz36QxiIlYScjrIq1g67V1fdi5y7OeJbrrNG0E1eX+ghrmL
         w0i7+OMOWv7FlfC0HGRrfNade/xGw/uyUDolo9nvExoMx4tx5UJ23PYh7vGAmuBggnAS
         GYLw==
X-Gm-Message-State: AAQBX9fZ7/a2AM3a2906hMV0cUsGksPdhrtpS1KwYcty0nEfAP2d7oQ7
        xxIOWS+kXc10RdNVaOZU+EEU9Gv9gZU=
X-Google-Smtp-Source: AKy350Z5lAyV3pnznwWuZtRfw18LONrxC/g5uyKRxLw3mrLdNXhB50AMHcfjs+a8+G0oCSt8q6V3Qw==
X-Received: by 2002:a05:6000:1049:b0:2f5:ae53:f558 with SMTP id c9-20020a056000104900b002f5ae53f558mr5899380wrx.31.1681727988398;
        Mon, 17 Apr 2023 03:39:48 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id z18-20020adfd0d2000000b002da75c5e143sm10225757wrh.29.2023.04.17.03.39.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 03:39:47 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Daniel Bristot de Oliveira <bristot@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-trace-devel@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] rv: Fix addition on an uninitialized variable 'run'
Date:   Mon, 17 Apr 2023 11:39:46 +0100
Message-Id: <20230417103946.29594-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The variable run is not initialized however it is being accumulated
by the return value from the call to ikm_run_monitor.  Fix this by
replacing the += with an assignment since this is the first point
where run is being assigned.

Fixes: 4bc4b131d44c ("rv: Add rv tool")

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 tools/verification/rv/src/rv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/verification/rv/src/rv.c b/tools/verification/rv/src/rv.c
index e601cd9c411e..da647ad4e733 100644
--- a/tools/verification/rv/src/rv.c
+++ b/tools/verification/rv/src/rv.c
@@ -111,7 +111,7 @@ static void rv_mon(int argc, char **argv)
 	 * Call all possible monitor implementations, looking
 	 * for the [monitor].
 	 */
-	run += ikm_run_monitor(monitor_name, argc-1, &argv[1]);
+	run = ikm_run_monitor(monitor_name, argc-1, &argv[1]);
 
 	if (!run)
 		err_msg("rv: monitor %s does not exist\n", monitor_name);
-- 
2.30.2

