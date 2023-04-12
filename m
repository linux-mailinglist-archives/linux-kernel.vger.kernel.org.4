Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32EEB6DECEC
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 09:49:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbjDLHti (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 03:49:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229897AbjDLHte (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 03:49:34 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99AA9E59
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 00:49:31 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id 98e67ed59e1d1-246f82a9ca2so72523a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 00:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1681285771; x=1683877771;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=m2IjbsVOhNCg3aQ00nTIOqWS5jRm5oFZnr9gH8yE6RM=;
        b=R+s3K1psh3gN3sXYzr1oH9VG6kMgY+PeltDNI8/szi0hQgmOEvEVlKrgBeCRcipKK/
         fxkLZUpPOG9cRHtGFsnlqHGB/IAYyeejeNH2meAj1zv0OX+tGex/pObb1PsnMK3C4t3m
         WbaEglsTPA/e5p4jiv1XNfyekmuVweQOW5l88V9A/zk+C4410fWDJaIOGMGfVasYzeiC
         vHUL+fmDBcIXNEbr0qfONAxhAt0uVU/yGbHwpP89hMi5InjzYhokaRecaAJi2eWJNFMU
         EzVYgeShkw8fuFA6nnwcBBy1SUKuSkgJIWe32vsPe74/ixHsnikEm3rTgHRoS71ZD72B
         0XsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681285771; x=1683877771;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m2IjbsVOhNCg3aQ00nTIOqWS5jRm5oFZnr9gH8yE6RM=;
        b=PanUSYkLgfpSjKJZp9FdR0ouRf44fhs7x7SO6qNPQb2QCwYmLddj1kfLC3BI+dTxLX
         pza3OyBMnTHTd8/97otaqyCNa7gTVNXLRthbE09kO3ALzWCPy2RecBhRX3Dk6996TlEP
         bRTLSH20h1kzPShS71gQahEjTWCO3eapr7bw6Ffcjlrr+WZP52Ps8XNkZvR5YJSBmJ0u
         BAEFWIKW8lQXevXIWp+nrjU4z6A1dDsBUURHjgvD8bXPOGbOJ5+UpFistqYox6BWm2QD
         Ls4bdKy+gTJtcNZJanocOei2rOuK1x1ITFfky/Dx5rOLwI+4WyQY15AIvSV63I0Bne1T
         apjA==
X-Gm-Message-State: AAQBX9ffTvzoQbnHgrxhrM4BqRoraFwA7hhnMnqYrT9jcBTe1g1rdEnr
        mIV2nnQjNGXyTk/cM7s10AvwnQ==
X-Google-Smtp-Source: AKy350bBLdKZ/XoTz4mv/hfBjhh6jVJEzf+qAn1A8imjGu0QJXoRZq85N1quPoelTIt2buROGw3cUw==
X-Received: by 2002:a62:4e06:0:b0:62e:43ce:e6ab with SMTP id c6-20020a624e06000000b0062e43cee6abmr14316778pfb.13.1681285771034;
        Wed, 12 Apr 2023 00:49:31 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.226])
        by smtp.gmail.com with ESMTPSA id r25-20020a62e419000000b0063949531089sm4517016pfh.220.2023.04.12.00.49.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Apr 2023 00:49:30 -0700 (PDT)
From:   Zhang Yuchen <zhangyuchen.lcr@bytedance.com>
To:     minyard@acm.org
Cc:     openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, zhangyuchen.lcr@bytedance.com
Subject: [PATCH] ipmi: fix SSIF not responding under certain cond.
Date:   Wed, 12 Apr 2023 15:49:07 +0800
Message-Id: <20230412074907.80046-1-zhangyuchen.lcr@bytedance.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ipmi communication is not restored after a specific version of BMC is
upgraded on our server.
The ipmi driver does not respond after printing the following log:

    ipmi_ssif: Invalid response getting flags: 1c 1

I found that after entering this branch, ssif_info->ssif_state always
holds SSIF_GETTING_FLAGS and never return to IDLE.

As a result, the driver cannot be loaded, because the driver status is
checked during the unload process and must be IDLE in shutdown_ssif():

        while (ssif_info->ssif_state != SSIF_IDLE)
                schedule_timeout(1);

The process trigger this problem is:

1. One msg timeout and next msg start send, and call
ssif_set_need_watch().

2. ssif_set_need_watch()->watch_timeout()->start_flag_fetch() change
ssif_state to SSIF_GETTING_FLAGS.

3. In msg_done_handler() ssif_state == SSIF_GETTING_FLAGS, if an error
message is received, the second branch does not modify the ssif_state.

4. All retry action need IS_SSIF_IDLE() == True. Include retry action in
watch_timeout(), msg_done_handler(). Sending msg does not work either.
SSIF_IDLE is also checked in start_next_msg().

5. The only thing that can be triggered in the SSIF driver is
watch_timeout(), after destory_user(), this timer will stop too.

So, if enter this branch, the ssif_state will remain SSIF_GETTING_FLAGS
and can't send msg, no timer started, can't unload.

We did a comparative test before and after adding this patch, and the
result is effective.

Fixes: 259307074bfc ("ipmi: Add SMBus interface driver (SSIF)")

Signed-off-by: Zhang Yuchen <zhangyuchen.lcr@bytedance.com>
---
 drivers/char/ipmi/ipmi_ssif.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/char/ipmi/ipmi_ssif.c b/drivers/char/ipmi/ipmi_ssif.c
index a5ddebb1edea..48be3694fa64 100644
--- a/drivers/char/ipmi/ipmi_ssif.c
+++ b/drivers/char/ipmi/ipmi_ssif.c
@@ -784,9 +784,9 @@ static void msg_done_handler(struct ssif_info *ssif_info, int result,
 		} else if (data[0] != (IPMI_NETFN_APP_REQUEST | 1) << 2
 			   || data[1] != IPMI_GET_MSG_FLAGS_CMD) {
 			/*
-			 * Don't abort here, maybe it was a queued
-			 * response to a previous command.
+			 * Recv error response, give up.
 			 */
+			ssif_info->ssif_state = SSIF_IDLE;
 			ipmi_ssif_unlock_cond(ssif_info, flags);
 			dev_warn(&ssif_info->client->dev,
 				 "Invalid response getting flags: %x %x\n",
-- 
2.20.1

