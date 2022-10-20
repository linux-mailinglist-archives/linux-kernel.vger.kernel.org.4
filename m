Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3BDF605A50
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 10:54:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbiJTIya (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 04:54:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiJTIy1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 04:54:27 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4230018C976;
        Thu, 20 Oct 2022 01:54:18 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d10so19681989pfh.6;
        Thu, 20 Oct 2022 01:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NiLYN93U8S13XfLcXOgHc8FUAWbV+3e6ZIb50KAygfM=;
        b=H9dvlsEWbqnAq8BgOovWeNH6M9d7j8pLbOvrISyaNZCBkzu1VFT85kasJfH5M4ZhE4
         4ynAMRwyJTpUO+SRcvaY6pQJ5ak47G/Q+T2PF6w+Ea/UfRh47iS3GkH7EyYvhjNeDZqh
         AmpydE3chYZ9zKueeO2ys8r/WxqdJ2j3UUuE2c7Zk/41uwOyMMPqzx2nIK2yo3eUtht5
         9f3yL15t8kdJuYdeSWuLhc2zn6DlzeTfhDr0Z95c415ZVfnAL5FDxA/tGrk5PIid+iHL
         1WYCo+VVC4oydlbaG+IBOGgTZD0ulFDU9rz71yFzYiIZeTSlJosNUuzIOW+h2LJfUgxd
         XLdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NiLYN93U8S13XfLcXOgHc8FUAWbV+3e6ZIb50KAygfM=;
        b=ZDWk2hSudmZgeNRij0SZjN/PtX54EAYKAJx5Fd6ysTOWujhRnXBEI3+og6gIxEVPCU
         nkMpIuJxCKYMqOG3vix9/LKONCGD3xxEYM8x82vHYPhd2smQjHkkqDsb182SjE02cNEN
         mi8A10o2I201kO80nVwxNCDJzpGhDT8a/52xre8vfbZPwcoJobwmsnQaZSEfQAPMnzcZ
         qUOdNUaUisKI4K5g1reBACHxPVgikQWwDYeTkkJr1NZ5afgoOAOEZIqpS7Fyrec2N1kT
         qL3BX4uWKO+r68kPo7ZTdw97TRFL9INIMIZYY6RQePHCEtj4yhnA1Mb5bVvIsdxqgvZT
         f/Rw==
X-Gm-Message-State: ACrzQf3MlElTa5NcegBaFwrnHb0M25BI6EtKuiDq323ZYXru0/YzZAnI
        HGfl0wYo/8g1LlJARmJ1btFesJhoMZjDVQ==
X-Google-Smtp-Source: AMsMyM4IZ8N1NVXQZbG71/Cr20n8KhJ7ZYc1VICUq0+Pll6dFamqkZyTPI67uX4OBtp/fNsiWoUb9g==
X-Received: by 2002:a63:2c90:0:b0:439:ee2c:ab2f with SMTP id s138-20020a632c90000000b00439ee2cab2fmr11418433pgs.2.1666256057430;
        Thu, 20 Oct 2022 01:54:17 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id b3-20020a170903228300b0017f205d91d9sm12401860plh.118.2022.10.20.01.54.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 01:54:16 -0700 (PDT)
From:   cuijinpeng666@gmail.com
X-Google-Original-From: cui.jinpeng2@zte.com.cn
To:     peterz@infradead.org, mingo@redhat.com
Cc:     acme@kernel.org, mark.rutland@arm.com, namhyung@kernel.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jinpeng Cui <cui.jinpeng2@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linux-next] perf: Use strscpy() instead of strlcpy()
Date:   Thu, 20 Oct 2022 08:54:11 +0000
Message-Id: <20221020085411.398450-1-cui.jinpeng2@zte.com.cn>
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

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Jinpeng Cui <cui.jinpeng2@zte.com.cn>
---
 kernel/events/core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 01933db7629c..5adf68cbd173 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -8053,7 +8053,7 @@ static void perf_event_comm_event(struct perf_comm_event *comm_event)
 	unsigned int size;
 
 	memset(comm, 0, sizeof(comm));
-	strlcpy(comm, comm_event->task->comm, sizeof(comm));
+	strscpy(comm, comm_event->task->comm, sizeof(comm));
 	size = ALIGN(strlen(comm)+1, sizeof(u64));
 
 	comm_event->comm = comm;
@@ -8508,7 +8508,7 @@ static void perf_event_mmap_event(struct perf_mmap_event *mmap_event)
 	}
 
 cpy_name:
-	strlcpy(tmp, name, sizeof(tmp));
+	strscpy(tmp, name, sizeof(tmp));
 	name = tmp;
 got_name:
 	/*
@@ -8937,7 +8937,7 @@ void perf_event_ksymbol(u16 ksym_type, u64 addr, u32 len, bool unregister,
 	    ksym_type == PERF_RECORD_KSYMBOL_TYPE_UNKNOWN)
 		goto err;
 
-	strlcpy(name, sym, KSYM_NAME_LEN);
+	strscpy(name, sym, KSYM_NAME_LEN);
 	name_len = strlen(name) + 1;
 	while (!IS_ALIGNED(name_len, sizeof(u64)))
 		name[name_len++] = '\0';
-- 
2.25.1

