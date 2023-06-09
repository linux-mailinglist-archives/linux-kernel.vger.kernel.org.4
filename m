Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EDB972A55C
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 23:29:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232383AbjFIV3y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 17:29:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232491AbjFIV3v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 17:29:51 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67A063A80
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 14:29:50 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id 3f1490d57ef6-bc40d4145feso64930276.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jun 2023 14:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686346189; x=1688938189;
        h=mime-version:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=oQDHQv5QQ7F49jvnNaX5O624EPUVQF/yKUfjfHQuFnc=;
        b=LePNwit0ABp1ENxorce8Sa7Bd4LjKtNLwa/pG6o1QxykmRLbH0P/yLOw/MmeYRuxBU
         q6Jrud4gYRsmAksqaqXcQmg5APEXk5xOkWEcVkUt+7+I+m9sjJ/lfi3LTs2oaDj9qGtq
         FqAAM5W7r38V/bKGdhcIRGRwyQYNBQJrUKdVY+GeNDUQUcUrQqxa+0OHKBldHawIOPw7
         5UVSaZlkQwYT5bOtcT9zG3ykVFoXtoJMwxzBJABVSh98ICXyKXC30TEVoan1/9xKPduX
         MeEUqzMSUINxKI7NBNQ1qRWak6K2y3wGJJpJOugPT1YrBnuhxTy/dMD/BQ0o3MPkCm45
         NNIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686346189; x=1688938189;
        h=mime-version:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oQDHQv5QQ7F49jvnNaX5O624EPUVQF/yKUfjfHQuFnc=;
        b=TphduHqcz2sbbJyqDP4OpI9fU44v4TobUzxpGKK6opXkIJUr+fK0/igb7RmOSZvlLT
         YZKhLWZ60GseMm4OovgQs3l+AHABo7Jk2pFViq+Hf8yNhsoCTXYYipJ4ySfIJibSy+eF
         ptJ6eWwQrnvKZMubgXAPcSVrSH2Eh3bVWXiOBL4ACoARsaXKXHkQ6UYl/I2+zRbmwkMp
         tkO/ChknBvjz9JWShCyzVvo19RnIflX6rUtmOOWUNlMRwfm4SmLJfrVJVYGD7Vp1FS3M
         QbwEIL+Pw/GLocBM3IOb7Fz05fhNIqUPhqNZd2dQwLXMryAIdBM0gHTPX/F88Utz6G80
         tI0A==
X-Gm-Message-State: AC+VfDwQ5F2JxGL2p2hpyWxLz66hVSLycNwjsTBiVgx4ouaZiZO2OH0a
        MM3O37paFEwwnztOfYxETQVhdg==
X-Google-Smtp-Source: ACHHUZ6zVT6zy2xPQU6h6zNxSgG3a9+hAx3/LLoy1GtDkJTTgoju5XlmXUOBA28ACU3lez+R9dzHTA==
X-Received: by 2002:a25:c78b:0:b0:ba8:f70:1eb9 with SMTP id w133-20020a25c78b000000b00ba80f701eb9mr2046657ybe.57.1686346189501;
        Fri, 09 Jun 2023 14:29:49 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id f6-20020a5b0d46000000b00bc41075297fsm7249ybr.23.2023.06.09.14.29.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 14:29:49 -0700 (PDT)
Date:   Fri, 9 Jun 2023 14:29:39 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Gregory Greenman <gregory.greenman@intel.com>
cc:     Ariel Malamud <ariel.malamud@intel.com>,
        Johannes Berg <johannes.berg@intel.com>,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        regressions@lists.linux.dev
Subject: [PATCH] wifi: iwlwifi: mvm: spin_lock_bh() to fix lockdep
 regression
Message-ID: <79ffcc22-9775-cb6d-3ffd-1a517c40beef@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lockdep on 6.4-rc on ThinkPad X1 Carbon 5th says
=====================================================
WARNING: SOFTIRQ-safe -> SOFTIRQ-unsafe lock order detected
6.4.0-rc5 #1 Not tainted
-----------------------------------------------------
kworker/3:1/49 [HC0[0]:SC0[4]:HE1:SE0] is trying to acquire:
ffff8881066fa368 (&mvm_sta->deflink.lq_sta.rs_drv.pers.lock){+.+.}-{2:2}, at: rs_drv_get_rate+0x46/0xe7

and this task is already holding:
ffff8881066f80a8 (&sta->rate_ctrl_lock){+.-.}-{2:2}, at: rate_control_get_rate+0xbd/0x126
which would create a new lock dependency:
 (&sta->rate_ctrl_lock){+.-.}-{2:2} -> (&mvm_sta->deflink.lq_sta.rs_drv.pers.lock){+.+.}-{2:2}

but this new dependency connects a SOFTIRQ-irq-safe lock:
 (&sta->rate_ctrl_lock){+.-.}-{2:2}
etc. etc. etc.

Changing the spin_lock() in rs_drv_get_rate() to spin_lock_bh() was not
enough to pacify lockdep, but changing them all on pers.lock has worked.

Fixes: a8938bc881d2 ("wifi: iwlwifi: mvm: Add locking to the rate read flow")
Signed-off-by: Hugh Dickins <hughd@google.com>
---

 drivers/net/wireless/intel/iwlwifi/mvm/rs.c |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

--- 6.4-rc5/drivers/net/wireless/intel/iwlwifi/mvm/rs.c
+++ linux/drivers/net/wireless/intel/iwlwifi/mvm/rs.c
@@ -2692,7 +2692,7 @@ static void rs_drv_get_rate(void *mvm_r,
 
 	lq_sta = mvm_sta;
 
-	spin_lock(&lq_sta->pers.lock);
+	spin_lock_bh(&lq_sta->pers.lock);
 	iwl_mvm_hwrate_to_tx_rate_v1(lq_sta->last_rate_n_flags,
 				     info->band, &info->control.rates[0]);
 	info->control.rates[0].count = 1;
@@ -2707,7 +2707,7 @@ static void rs_drv_get_rate(void *mvm_r,
 		iwl_mvm_hwrate_to_tx_rate_v1(last_ucode_rate, info->band,
 					     &txrc->reported_rate);
 	}
-	spin_unlock(&lq_sta->pers.lock);
+	spin_unlock_bh(&lq_sta->pers.lock);
 }
 
 static void *rs_drv_alloc_sta(void *mvm_rate, struct ieee80211_sta *sta,
@@ -3264,11 +3264,11 @@ void iwl_mvm_rs_tx_status(struct iwl_mvm
 	/* If it's locked we are in middle of init flow
 	 * just wait for next tx status to update the lq_sta data
 	 */
-	if (!spin_trylock(&mvmsta->deflink.lq_sta.rs_drv.pers.lock))
+	if (!spin_trylock_bh(&mvmsta->deflink.lq_sta.rs_drv.pers.lock))
 		return;
 
 	__iwl_mvm_rs_tx_status(mvm, sta, tid, info, ndp);
-	spin_unlock(&mvmsta->deflink.lq_sta.rs_drv.pers.lock);
+	spin_unlock_bh(&mvmsta->deflink.lq_sta.rs_drv.pers.lock);
 }
 
 #ifdef CONFIG_MAC80211_DEBUGFS
@@ -4117,9 +4117,9 @@ void iwl_mvm_rs_rate_init(struct iwl_mvm
 	} else {
 		struct iwl_mvm_sta *mvmsta = iwl_mvm_sta_from_mac80211(sta);
 
-		spin_lock(&mvmsta->deflink.lq_sta.rs_drv.pers.lock);
+		spin_lock_bh(&mvmsta->deflink.lq_sta.rs_drv.pers.lock);
 		rs_drv_rate_init(mvm, sta, band);
-		spin_unlock(&mvmsta->deflink.lq_sta.rs_drv.pers.lock);
+		spin_unlock_bh(&mvmsta->deflink.lq_sta.rs_drv.pers.lock);
 	}
 }
 
