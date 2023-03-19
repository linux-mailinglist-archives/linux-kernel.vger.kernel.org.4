Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 781796C035D
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Mar 2023 18:05:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229895AbjCSRFq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 13:05:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjCSRFn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 13:05:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A679D7AAB
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 10:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679245494;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=5hGGrSeYkeZSTlJKXjJeoxK62+EdXw5xS8spAiPT4N8=;
        b=DOkgt/BgOaI6pkLOX6QBtsbsDPsiSmTpFdaRF9fVdNVj2ZWUIeDJRAm2OI99LUpgJazVKl
        ZMA9tZ9mE9v6hGIGWOP8CkDia9UDUzP6JhXUsrAyw/Jbk5AdN8NjJzyW6fma1VQcnf48fQ
        M8UcHnhNBf/qK5mxC+NYLj8TY9tLORA=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-70-2cdseVL-NcSaLUs6_d_dBg-1; Sun, 19 Mar 2023 13:04:53 -0400
X-MC-Unique: 2cdseVL-NcSaLUs6_d_dBg-1
Received: by mail-qk1-f200.google.com with SMTP id o7-20020a05620a130700b00745fa7586a0so4563583qkj.20
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 10:04:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679245493;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5hGGrSeYkeZSTlJKXjJeoxK62+EdXw5xS8spAiPT4N8=;
        b=Xx4wVBnRTl4b7AHc+r9ivI2vCW4OYyVr1l0oWQO4KCBl0a5AfWLZi1Zqdd6eMFwjNG
         svAl4FxiyuvI/L5VIkzX0fnvo5cf1v4VrP4HnwYi+eScpbQK4QBQYg/OwUcEYJ1Y+x0p
         bJW7R+5C+YVyzKd/4saqqSx4k8jTIpYqjo6eaG0HEMViZRkvH6UjDqdfSgjVMgnyDdKX
         OkDJkAPTGKVkZ0UCDvwpEqZf3IB/nsr0VlO0bcgFgoTt5YmmUlu2re21U3t0B+XuCM4R
         eMQmgCGYpDi/w6Pc7kV6ItKeN6YSeL8kBsQ8Xyc7/xtXfnJltauCzodSfVO36KNCTiFZ
         SKtA==
X-Gm-Message-State: AO0yUKVBhGgnmCg5muOtBRazIfYjxJ6JAlVHfbOFTw/0HJ1sR43TTrBW
        1fVqM0oUhhLfYjEm3p2ZdzCAwRDX1RHEnsY/w6QuFJLH6q9ZvRD7p4CgjYWJXZxUJ6lhsx5tbAL
        FQ2UaAqcZGB6QzgPh6FfjssB5
X-Received: by 2002:ac8:5841:0:b0:3bf:bbd3:1f11 with SMTP id h1-20020ac85841000000b003bfbbd31f11mr24021871qth.21.1679245492838;
        Sun, 19 Mar 2023 10:04:52 -0700 (PDT)
X-Google-Smtp-Source: AK7set/H4vADgftD8rf5YWTGqtn/mKRl2Y1/a6dCKsWGV9D8uNc3r11rwxbJZBxO/iJ8/yMZTeNSog==
X-Received: by 2002:ac8:5841:0:b0:3bf:bbd3:1f11 with SMTP id h1-20020ac85841000000b003bfbbd31f11mr24021833qth.21.1679245492452;
        Sun, 19 Mar 2023 10:04:52 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id t197-20020a3746ce000000b0074280fc7bd8sm5735681qka.60.2023.03.19.10.04.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Mar 2023 10:04:52 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
To:     matt.hsiao@hpe.com, arnd@arndb.de, gregkh@linuxfoundation.org,
        nathan@kernel.org, ndesaulniers@google.com
Cc:     linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] misc: hpilo: remove unused is_device_reset function
Date:   Sun, 19 Mar 2023 13:04:47 -0400
Message-Id: <20230319170447.1707655-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

clang with W=1 reports
drivers/misc/hpilo.c:395:19: error: unused function
  'is_device_reset' [-Werror,-Wunused-function]
static inline int is_device_reset(struct ilo_hwinfo *hw)
                  ^
This function is not used, so remove it.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/misc/hpilo.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/misc/hpilo.c b/drivers/misc/hpilo.c
index 8d00df9243c4..ba4b00b8bea1 100644
--- a/drivers/misc/hpilo.c
+++ b/drivers/misc/hpilo.c
@@ -392,12 +392,6 @@ static inline int is_db_reset(int db_out)
 	return db_out & (1 << DB_RESET);
 }
 
-static inline int is_device_reset(struct ilo_hwinfo *hw)
-{
-	/* check for global reset condition */
-	return is_db_reset(get_device_outbound(hw));
-}
-
 static inline void clear_pending_db(struct ilo_hwinfo *hw, int clr)
 {
 	iowrite32(clr, &hw->mmio_vaddr[DB_OUT]);
-- 
2.27.0

