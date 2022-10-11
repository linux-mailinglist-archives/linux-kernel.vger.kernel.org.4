Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76BAA5FBA12
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 20:02:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230206AbiJKSCx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 14:02:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229997AbiJKSCX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 14:02:23 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0B686CF50
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 11:02:17 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id t25so1930601qkm.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 11:02:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iGj5k/DwJhJPXcGunz0g9sDYK6vlgcelG7wytJgmcF0=;
        b=KUpS3o1sZJqLAW9IafevA0PVB44FfYK2aZOqGdn9y/rpm0BZ4d0cLGyMogYsalkdSJ
         N1oDguKqPTxhwA/NiXi8ijdAtRYa/0xEBcHmPQO/m3mNh+Dxq0zRy8+k3bcKZcsty7+/
         7opHuCcB5BDa5yBRxosIIYkcIrN75sAb2L24Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iGj5k/DwJhJPXcGunz0g9sDYK6vlgcelG7wytJgmcF0=;
        b=EPUiq7VIWFYpjmwZXgTM+qYa221155Y/7wMDn8+xwzHcpUPwy0hds1X+d/zNoMBd6m
         uucaAmgkVKm59P99YqZG9APeHOFT2+5+oW3CXVvGiQjp8+6+X8Rn0ylTNqjnoHdJNCYw
         +Bdm8zfH2FmksNRV9hMk9SjOtZy35+qvaVTyTNI7D1MLaLkvLpS45U9x9Jihd4IkL1uc
         GTiMUw55DlloyUPWALulduzTOvRkJmTzyUPd4VqOknxICxdOYNLOq7pFdh6aoN7dv8Dx
         61KxFD2MtGmyF9FMJhgx8EZSPBFP47/LVMa659roBMsYecleiSPI6BlzNXBaWPB/LuDR
         cbzA==
X-Gm-Message-State: ACrzQf3GRMHPP1MPTGjtwn4x4NWGOJRYMxVYZFQ4Xc6hdTBP1Y5964ci
        gOkjIQNjXwc1EVzYGCZHPLlvGA==
X-Google-Smtp-Source: AMsMyM7+GZHvi1fZos/roBbQAPTwMhcU7LhnvwDeTi6oBEvU78l4wd2V8rQViKh5Og/oOAElnlxm/Q==
X-Received: by 2002:a05:620a:150b:b0:6ee:8d04:f70 with SMTP id i11-20020a05620a150b00b006ee8d040f70mr1887175qkk.101.1665511336568;
        Tue, 11 Oct 2022 11:02:16 -0700 (PDT)
Received: from joelboxx.c.googlers.com.com (228.221.150.34.bc.googleusercontent.com. [34.150.221.228])
        by smtp.gmail.com with ESMTPSA id w22-20020a05620a425600b006cbc00db595sm13464375qko.23.2022.10.11.11.02.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Oct 2022 11:02:16 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, rushikesh.s.kadam@intel.com,
        urezki@gmail.com, neeraj.iitr10@gmail.com, frederic@kernel.org,
        paulmck@kernel.org, rostedt@goodmis.org, youssefesmat@google.com,
        surenb@google.com, Joel Fernandes <joel@joelfernandes.org>
Subject: [PATCH v8 10/13] scsi/scsi_error: Use call_rcu_flush() instead of call_rcu()
Date:   Tue, 11 Oct 2022 18:01:39 +0000
Message-Id: <20221011180142.2742289-11-joel@joelfernandes.org>
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
In-Reply-To: <20221011180142.2742289-1-joel@joelfernandes.org>
References: <20221011180142.2742289-1-joel@joelfernandes.org>
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

From: Uladzislau Rezki <urezki@gmail.com>

Slow boot time is seen on KVM running typical Linux distributions due to
SCSI layer calling call_rcu(). Recent changes to save power may be
causing this slowness. Using call_rcu_flush() fixes the issue and brings
the boot time back to what it originally was. Convert it.

Tested-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Uladzislau Rezki <urezki@gmail.com>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 drivers/scsi/scsi_error.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/scsi_error.c b/drivers/scsi/scsi_error.c
index 448748e3fba5..a56cfd612e3a 100644
--- a/drivers/scsi/scsi_error.c
+++ b/drivers/scsi/scsi_error.c
@@ -312,7 +312,7 @@ void scsi_eh_scmd_add(struct scsi_cmnd *scmd)
 	 * Ensure that all tasks observe the host state change before the
 	 * host_failed change.
 	 */
-	call_rcu(&scmd->rcu, scsi_eh_inc_host_failed);
+	call_rcu_flush(&scmd->rcu, scsi_eh_inc_host_failed);
 }
 
 /**
-- 
2.38.0.rc1.362.ged0d419d3c-goog

