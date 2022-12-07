Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 193286456B7
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 10:40:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230172AbiLGJkN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 04:40:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbiLGJjz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 04:39:55 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FCEC3A7
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 01:39:54 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id d82so8295957pfd.11
        for <linux-kernel@vger.kernel.org>; Wed, 07 Dec 2022 01:39:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uU7abS1OTYc27NQr7ZVRm3zR4ABpJNSar2eydFTH12Y=;
        b=PTqXHd7Ks3woQUeuzU9Ay7/RFKKvJPVd7W3t1q4WIQzjxub0fx2FjtqByohwJUqAD3
         Ve0UqLXdFyfkjH2y6Nx8BdGxCcNFSoP3de79wpMO1Nstz3HMOmd3C9/5fh88Hjc57LIq
         kVzZ1278gcpj6ykXqrAQIcu7AIWOyd1MMWqPw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uU7abS1OTYc27NQr7ZVRm3zR4ABpJNSar2eydFTH12Y=;
        b=zDf7thwSVfQakr8tLAgeMYtTjqtbDWqTrhvMixFKBGTmRoKK8ulRe9XUVoE+fzn7nt
         yVCbdzmq+mCbPegfw/wSZT5UzK4Aowouk7sdwKOTh1EeHW8WqGOJJWjyoDaP8mAKotIl
         xBTmPjMenKmyr7vgZvUWwHHJ1g/jCp3fzccZnC2AUfmjvqS4iUVbDBTkSrGzuorYyaiD
         X1PHHi5NgjoAzDsip4R8hMTklOpUjtWjcs0TUQhs9BtIO8YoNwrJOLfvLTBR1bJKbgXS
         ZNnAtgEnXznXiS7twI2Jd2la/sdzsnAdhxBqmELLM1UGekZT5nFDNjqFgX1uFQ2OaQ8B
         oQzQ==
X-Gm-Message-State: ANoB5pkptOJ0OuiyH8ZFopezpc5xVrV2MHcQZtiFIBgokeaLMNZL8B0b
        LbcUAdWfzw5ZdD954AlMvB7sA2k5j73SuAB4r5owv5b3
X-Google-Smtp-Source: AA0mqf6EpBhqPA4rcDA4dGBczoJ4VvMCGAE5Zt75w50qqZX15NMTDur9hpcrJ20ACtyCAPcMRqgh0Q==
X-Received: by 2002:a63:fe16:0:b0:46b:8e9:7d5f with SMTP id p22-20020a63fe16000000b0046b08e97d5fmr65977999pgh.597.1670405993587;
        Wed, 07 Dec 2022 01:39:53 -0800 (PST)
Received: from localhost ([2401:fa00:9:14:bdb7:35b1:b44c:1926])
        by smtp.gmail.com with UTF8SMTPSA id i5-20020a17090332c500b001897de9bae3sm14232908plr.204.2022.12.07.01.39.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Dec 2022 01:39:53 -0800 (PST)
From:   Victor Ding <victording@chromium.org>
To:     linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev
Cc:     pmalani@chromium.org, groeck@chromium.org, dustin@howett.net,
        gustavoars@kernel.org, gregkh@linuxfoundation.org,
        sebastian.reichel@collabora.com, dnojiri@chromium.org,
        lee.jones@linaro.org, bleung@chromium.org,
        tinghan.shen@mediatek.com, tzungbi@kernel.org,
        Victor Ding <victording@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: [PATCH v2] platform/chrome: cros_ec_typec: zero out stale pointers
Date:   Wed,  7 Dec 2022 09:39:40 +0000
Message-Id: <20221207093924.v2.1.I1864b6a7ee98824118b93677868d22d3750f439b@changeid>
X-Mailer: git-send-email 2.39.0.rc0.267.gcb52ba06e7-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

`cros_typec_get_switch_handles` allocates four pointers when obtaining
type-c switch handles. These pointers are all freed if failing to obtain
any of them; therefore, pointers in `port` become stale. The stale
pointers eventually cause use-after-free or double free in later code
paths. Zeroing out all pointer fields after freeing to eliminate these
stale pointers.

Fixes: f28adb41dab4 ("platform/chrome: cros_ec_typec: Register Type C switches")
Fixes: 1a8912caba02 ("platform/chrome: cros_ec_typec: Get retimer handle")
Signed-off-by: Victor Ding <victording@chromium.org>
---

Changes in v2:
- Updated commit messages;
- No code changes.

 drivers/platform/chrome/cros_ec_typec.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
index 2a7ff14dc37e..59de4ce01fab 100644
--- a/drivers/platform/chrome/cros_ec_typec.c
+++ b/drivers/platform/chrome/cros_ec_typec.c
@@ -173,10 +173,13 @@ static int cros_typec_get_switch_handles(struct cros_typec_port *port,
 
 role_sw_err:
 	typec_switch_put(port->ori_sw);
+	port->ori_sw = NULL;
 ori_sw_err:
 	typec_retimer_put(port->retimer);
+	port->retimer = NULL;
 retimer_sw_err:
 	typec_mux_put(port->mux);
+	port->mux = NULL;
 mux_err:
 	return -ENODEV;
 }
-- 
2.39.0.rc0.267.gcb52ba06e7-goog

