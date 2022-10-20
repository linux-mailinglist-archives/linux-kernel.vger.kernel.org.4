Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFC7B605AB7
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 11:13:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230328AbiJTJNU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 05:13:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbiJTJNS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 05:13:18 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F92119E002
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 02:13:17 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id p6-20020a17090a748600b002103d1ef63aso2476392pjk.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 02:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QIkOjdfRRSw8uTKf7w3SgpX1a+ci3tK/XI45o7Lmcd0=;
        b=Ha7y9Yf2v2Xtk+Fi5cUhvaW1VbOaRYCHgR5mdJNzBz4od55HuB8WGDQQ7KL7mnyDSd
         i4n6AQRIKRNeMK3BD5xnOENddtz2o843F98D6IQlSQ/wZefRbh7TuDVNA5m/lsI8Buzv
         XrnZdAMWKWQgQKe6IUWCMv3S3EkdTNudoDYmM6ZLXL/GDNROnsdztuNvrIzwgM3FDAY6
         omXL5e9Fw/Hj6Zx0XiHhKFSo8pxuJpi5HOgDJFOPUR2q6nMRQrYtkapZp2l9aLcqyfx0
         ezBtHSCejQ7kAOu3lV8S2uAdd7o9G/vv8xjQiCnk9YvtQGPfQsqJNvX91vY+cehxBNBz
         s44A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QIkOjdfRRSw8uTKf7w3SgpX1a+ci3tK/XI45o7Lmcd0=;
        b=k1zJxJhcA/n1wQKJgBPnFkVil1T4NvVkukTHYqzKMb08iSO+/Qcm0r0STbGe5HAJ3g
         LFgdy8JfEyJx9fyUPFZQnlN+VadCfNKMNoHeA4P+T7+BxbeeaEHuoJBbugdPE21SxsJc
         /GGCiQMGyA2NjJ8OqThC6UFQpsZ2qEaxN4SNsw9QvvtOaqJ3n0e4DGsid3masuxgVq3K
         4J0ERvbe878XGfL77lzQ4m06W26Np+AhbtRu8dNFzzS+hgN1GM01/p9ub11qK9h8hxbM
         GZePYL39OgdZ/GXigJggZYvFkuRa6lTpexsoKirwwtYJYlDw9AqGR0j3FmeCdxtKdr1X
         SI1w==
X-Gm-Message-State: ACrzQf1LgdVObQPU9WQuv1dnDYhgq9zaNv2IbFfUHhS0ZVx8FBLElPHv
        LG0tQz9rXt9bZKN1qWkkUNc=
X-Google-Smtp-Source: AMsMyM767urcvtPYvNKlyK/+HvrCf6k1OoaqzO5WYd7IC9+VjELPrZWb3ULWmLwUS9/tGhTHOKjGFA==
X-Received: by 2002:a17:90b:1bd2:b0:20d:dcb0:c788 with SMTP id oa18-20020a17090b1bd200b0020ddcb0c788mr15221042pjb.67.1666257197205;
        Thu, 20 Oct 2022 02:13:17 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id p65-20020a625b44000000b0053e4296e1d3sm12751049pfb.198.2022.10.20.02.13.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 02:13:16 -0700 (PDT)
From:   cuijinpeng666@gmail.com
X-Google-Original-From: cui.jinpeng2@zte.com.cn
To:     jstultz@google.com, tglx@linutronix.de
Cc:     sboyd@kernel.org, linux-kernel@vger.kernel.org,
        Jinpeng Cui <cui.jinpeng2@zte.com.cn>,
        Zeal Robot <zaelci@zte.com.cn>
Subject: [PATCH linux-next] clocksource: Use strscpy() instead of strlcpy()
Date:   Thu, 20 Oct 2022 09:13:12 +0000
Message-Id: <20221020091312.398909-1-cui.jinpeng2@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jinpeng Cui <cui.jinpeng2@zte.com.cn>

The implementation of strscpy() is more robust and safer.

Reported-by: Zeal Robot <zaelci@zte.com.cn>
Signed-off-by: Jinpeng Cui <cui.jinpeng2@zte.com.cn>
---
 kernel/time/clocksource.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
index dcaf38c06216..a3e7edfbb3c2 100644
--- a/kernel/time/clocksource.c
+++ b/kernel/time/clocksource.c
@@ -1461,7 +1461,7 @@ static int __init boot_override_clocksource(char* str)
 {
 	mutex_lock(&clocksource_mutex);
 	if (str)
-		strlcpy(override_name, str, sizeof(override_name));
+		strscpy(override_name, str, sizeof(override_name));
 	mutex_unlock(&clocksource_mutex);
 	return 1;
 }
-- 
2.25.1

