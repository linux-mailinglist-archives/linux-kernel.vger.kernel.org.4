Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BFE9600144
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Oct 2022 18:24:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230028AbiJPQYp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Oct 2022 12:24:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229897AbiJPQXy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Oct 2022 12:23:54 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 972983B720
        for <linux-kernel@vger.kernel.org>; Sun, 16 Oct 2022 09:23:43 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id a5so5401155qkl.6
        for <linux-kernel@vger.kernel.org>; Sun, 16 Oct 2022 09:23:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jd4X4oYun9/nS5S7eG1Y6MJBlHQXAJ22sEc4uBevOrk=;
        b=mrEHqR75/ASzUJYL2Vr1FpBcCW1ogrf9oXsAim5CnXNXTSdkazxj+/9mKkDSVa01Rp
         A0I7JfTL5YB/qYLf3G92MvHWjYyk9MuBZB+Y288CC7uABNd34F84+s0jyORWJ80iWfzM
         mmPmsBik655Fuf0CGK0nq+Rn+D1GJYLHvEr0Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jd4X4oYun9/nS5S7eG1Y6MJBlHQXAJ22sEc4uBevOrk=;
        b=UeFMULegKz67i4IHeOVMs05fVSJahvXaBKMKKi1W7+3ZZDahgr+Y1ffS2cptYkbwWT
         yDJrGDSXZEOhuN3O51+VGKzgAaltEYdQ8cgbp1ano8m6QEk39ucTXb5c63HZnQSPr1ow
         QqZodSaWaE4LAMn4s+UiLmvhMO3JwsnqQDC0K4dKj1jaeFF6+lTlitahktbfu3aAlkIE
         2jm19W2H7BA4mAG4PWmerlEq4cvlDtd8AVVDKo4vmPRGHMVqDMi6QdvlnvdoIeo7YQBL
         Y1bxmVzpg1HLsC0ELmEpRSGPMyMxFbLZOn3Q9AUPe42lXPfJ9FDQXfekrrY+ccltE6qp
         LE5g==
X-Gm-Message-State: ACrzQf2aCe8G7MT1XbNerQkooNV8MFFTRGgjpBpkYQEcgc4LXG9BAsZG
        OoSFlu8YPDu1NdTAM4+VhgO70w==
X-Google-Smtp-Source: AMsMyM4uhEsICS3Fc3WVYe2ZiLXWLquTZxuLWKT4B9PHyo6xu5DhswcnF5IBnDaQcUYkcI2VpTkclQ==
X-Received: by 2002:a05:620a:2913:b0:6ee:d427:1c5c with SMTP id m19-20020a05620a291300b006eed4271c5cmr5142629qkp.484.1665937420846;
        Sun, 16 Oct 2022 09:23:40 -0700 (PDT)
Received: from joelboxx.c.googlers.com.com (228.221.150.34.bc.googleusercontent.com. [34.150.221.228])
        by smtp.gmail.com with ESMTPSA id x19-20020ac87ed3000000b003436103df40sm6001207qtj.8.2022.10.16.09.23.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Oct 2022 09:23:40 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, frederic@kernel.org,
        paulmck@kernel.org, Uladzislau Rezki <urezki@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: [PATCH v9 10/13] scsi/scsi_error: Use call_rcu_flush() instead of call_rcu()
Date:   Sun, 16 Oct 2022 16:23:02 +0000
Message-Id: <20221016162305.2489629-11-joel@joelfernandes.org>
X-Mailer: git-send-email 2.38.0.413.g74048e4d9e-goog
In-Reply-To: <20221016162305.2489629-1-joel@joelfernandes.org>
References: <20221016162305.2489629-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLACK autolearn=no autolearn_force=no
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
2.38.0.413.g74048e4d9e-goog

