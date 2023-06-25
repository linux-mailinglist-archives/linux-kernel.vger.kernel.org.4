Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0E2F73D1EC
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 18:00:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230329AbjFYQAq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 12:00:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230309AbjFYQAl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 12:00:41 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6029E5B
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jun 2023 09:00:28 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-51d805cb33aso2062201a12.3
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jun 2023 09:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1687708827; x=1690300827;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hG/25rXMoqPrP3Tjboz29CAT2Eb1EYcAQYXNo5YWZvc=;
        b=c9c38HB37VE/iwHwIt39e3BuInPDZopPtT7zqLzHHbIQnx335cBnNyaT9m3NsTwNcZ
         MU79NtMPe7WFrfy+2hE+ta1x+hPS/q9nn9vBFNtC6DiXwolyGaAgAqhg9jpfr836i4Yg
         67TFssyE5XP/vplY5q3a/wjeqhMvv6lATVxgg2bGkOEebLfPYIlirO/kkHtx5fAaykTE
         TF4k/prSrRhYw5UBxPBaNDfR4toIj1n8cNzPcyVlwEe8Y+MY4SrXJnkyYkwPBfOTVQch
         Vc+4rlvL0l5QtSQwQIC6rGJW0QausMtJAYZb3XJkPT13gDOsnQW0XOBIf3slBY4pHc5d
         SWsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687708827; x=1690300827;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hG/25rXMoqPrP3Tjboz29CAT2Eb1EYcAQYXNo5YWZvc=;
        b=R4/PIx892B3nfFQvHawIkkvmCpPGk3EEea5ESlcJs9TkxzVhmKTJvCXKA35lUSGm5u
         vfALdIOLv/9sWWOWExzPpYI7xwsfMOiOPX9YXv6ho6s2XdFEU8dVZPNeeGabeD3XCYmD
         d2hvTBGj36uvgSGG6jW0PKYo0z38gR0xUl3DDn2z4k7oHhD439zhSrfUOK9Q4Xr6yS2U
         XQvxDsEQcKvaJMSJkmF4cL2sn3fvSdK4CSjqQjxQsjswYWtgCUvU5SxD8tcW/ZKdDPIP
         /PvQoWVNyjo82Ms4Cs+mLF+lWmaw03+uuVGkdZRLvYyOBCLu1QR3MCI7FGBBiKoSG5uz
         N8RQ==
X-Gm-Message-State: AC+VfDxKpPfg4ilhvV/elUYhFtlPVkyyVVHn7w9ZnYoodOxhEym6oRoH
        WjheXZcofVKkvLCC+yHiYGY=
X-Google-Smtp-Source: ACHHUZ4tqpEJiYvZaeySsYlQSPef9pgtu5Yo46eD4zRvjEU7iFJYhXw9Lo81nZmvXhjgHqCb+H3Sig==
X-Received: by 2002:aa7:c2d7:0:b0:51d:9362:5060 with SMTP id m23-20020aa7c2d7000000b0051d93625060mr1679703edp.1.1687708826863;
        Sun, 25 Jun 2023 09:00:26 -0700 (PDT)
Received: from localhost.localdomain ([2a02:810a:9640:26a8:484f:5091:3ba0:ecc])
        by smtp.gmail.com with ESMTPSA id r16-20020aa7da10000000b0051d2968b26asm1895469eds.77.2023.06.25.09.00.26
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 25 Jun 2023 09:00:26 -0700 (PDT)
From:   Franziska Naepelt <franziska.naepelt@googlemail.com>
X-Google-Original-From: Franziska Naepelt <franziska.naepelt@gmail.com>
To:     franziska.naepelt@googlemail.com
Cc:     eperi1024@gmail.com, franziska.naepelt@gmail.com,
        gregkh@linuxfoundation.org, hdegoede@redhat.com,
        johannes.berg@intel.com, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev, quic_vjakkam@quicinc.com,
        tegongkang@gmail.com
Subject: [PATCH v3 3/3] staging: rtl8723bs: Fix remaining blank line issue
Date:   Sun, 25 Jun 2023 18:00:24 +0200
Message-Id: <20230625160024.32530-1-franziska.naepelt@gmail.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20230625155632.32403-1-franziska.naepelt@gmail.com>
References: <20230625155632.32403-1-franziska.naepelt@gmail.com>
MIME-Version: 1.0
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

Fix the following checkpatch blank line issue:
- CHECK: Please don't use multiple blank lines

Signed-off-by: Franziska Naepelt <franziska.naepelt@gmail.com>
---
v3: This fix was accidentially part of the fix spaces issue, moved to This
    separate patch now.
---
 drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
index 8f30098168f1..292cba045023 100644
--- a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
+++ b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
@@ -266,7 +266,6 @@ struct cfg80211_bss *rtw_cfg80211_inform_bss(struct adapter *padapter, struct wl
 	}
 	/* spin_unlock_bh(&pwdev_priv->scan_req_lock); */

-
 	channel = pnetwork->network.configuration.ds_config;
 	freq = rtw_ieee80211_channel_to_frequency(channel, NL80211_BAND_2GHZ);

--
2.39.2 (Apple Git-143)

