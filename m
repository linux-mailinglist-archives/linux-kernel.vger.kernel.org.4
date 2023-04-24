Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64EE76EC95D
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 11:48:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231246AbjDXJsC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 05:48:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbjDXJry (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 05:47:54 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C16EB3C06;
        Mon, 24 Apr 2023 02:47:33 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-2fddb442d47so3843059f8f.2;
        Mon, 24 Apr 2023 02:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682329651; x=1684921651;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hZyWIeK34NmrQfsNJdgjh0DC7E3/9QF+r15VrIbQ35Y=;
        b=KJbIYqlsYfx76iqy2WImXzJfB72YvSYkFQK1MDqVouVbgj0fftLkRXI08nEQRHmvxI
         cRcb4SzfR/PgdfvRP0CAVuKSBurfDxrcK7zjy11c9ASPxJjmm/+xI5WhYfJGPhZ1i1lU
         tsdJzhQZFEtP/TXZWK1lIgE6A2qED43jBQNLiojmm0mfeytglmCwAdNHVQdqUycfDIvN
         5K/IekCFk8CHZtNHaWg0v2EUdr45ht22KvL5PkDC5njoxkI5RgeFp/Ufz1ap2gYINeJ1
         kaaWXFLzDdtjYyFRbXxZrDIAcaUp8RwAKS9qvhavS6e1D75KVceOGVmFl4Cc3sXFD0QA
         sDZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682329651; x=1684921651;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hZyWIeK34NmrQfsNJdgjh0DC7E3/9QF+r15VrIbQ35Y=;
        b=YUPaxG/yBDKkepamAt+fVJmXCqOvHyYsGyuFFgrFoQ6Lejn3hwnNanV/Uhwx1LG+Lc
         cSJA57PvJH3EneGnKMfAS15Kw/QTlW5vkLF+CKiceVK1w/7dpC7bOblFJnkUDol9UNNx
         //pZVKnMCpb6FZMrzQghjTigLU3hqlD3SPNXlmoU8+hRHCwf4BfQuu7ZmvNftVde6vbv
         CgGLuJsSWkrlVwEO/JR2RS0Hru9YCKEdCfIux4TpLAGa6ymsCoAIbIekGFJGBXeyKNL9
         JQlMmdLxrIoX/8T8tre++rgSitwioBUs5NSUGMc5gKN7DR1DJGtMvWc0jWd37+H9bU2X
         NpFQ==
X-Gm-Message-State: AAQBX9fiLyB/7YYMmdppXXlQdfubcQjmR1xD1/ipz2yuyMVL5NwaNm3b
        NHtX7Sv3w/Dva4H0KdcGjn8=
X-Google-Smtp-Source: AKy350YmPJrprooSLsRv+VV579NpsuRkKi9JaLoPey4tDdCVH42KcH7MUcYaRPwK0Q6T2i12/sApYw==
X-Received: by 2002:a05:6000:1209:b0:304:6b64:4f30 with SMTP id e9-20020a056000120900b003046b644f30mr4636169wrx.18.1682329651558;
        Mon, 24 Apr 2023 02:47:31 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id y4-20020adffa44000000b002f013fb708fsm10540320wrr.4.2023.04.24.02.47.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Apr 2023 02:47:31 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Daniel Bristot de Oliveira <bristot@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-trace-devel@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next][V3] rv: Fix addition on an uninitialized variable 'run'
Date:   Mon, 24 Apr 2023 10:47:30 +0100
Message-Id: <20230424094730.105313-1-colin.i.king@gmail.com>
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
initializing run to zero at the start of the function.

Fixes: 4bc4b131d44c ("rv: Add rv tool")

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

---
V2: Initialize run rather than assign it from return from ikm_run_monitor
V3: Add missing V3 and next in patch subject
---
 tools/verification/rv/src/rv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/verification/rv/src/rv.c b/tools/verification/rv/src/rv.c
index e601cd9c411e..1ddb85532816 100644
--- a/tools/verification/rv/src/rv.c
+++ b/tools/verification/rv/src/rv.c
@@ -74,7 +74,7 @@ static void rv_list(int argc, char **argv)
 static void rv_mon(int argc, char **argv)
 {
 	char *monitor_name;
-	int i, run;
+	int i, run = 0;
 
 	static const char *const usage[] = {
 		"",
-- 
2.30.2

