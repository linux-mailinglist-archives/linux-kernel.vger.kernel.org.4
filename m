Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C78C05F038D
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 06:25:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229997AbiI3EZj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 00:25:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbiI3EZc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 00:25:32 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54966C34F9
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 21:25:30 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id l12so3003560pjh.2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 21:25:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paradetech-corp-partner-google-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=ua2CSrcc4+s+YVRSAUzNcpQVlpY+dzHINIhgN6gplb0=;
        b=4XlFTYMrZPfOIVs+cVbucYVJAWGt8s1yJrTDQB7kVJBlZTC5rqls1yCwJArMS8IdGr
         QZaraZv6ZqWcSiiBnF9jhrv1tKah7vAG3w8s+TrEuDHXlROO7Ew54gEgxO6cJZw0jYdI
         cDF76p3waGjAQlU6NgZoNV/vOTzpYpIRYCSQu5/uOK9n1yqDBYmSuvuCn7ULjdBdVw7O
         txO9yIXKIK72yJFB8OuyxYH87b8ZMzrXjPs12CckYec9H90oLtPLjKF789ms4ETQcScY
         Tm7kxdNeOwfn6e0zGIrq6ymoKYsL9+UwHLK+6KYWjusLzetJG+nfN6CxQTicyw3bmdik
         YRYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=ua2CSrcc4+s+YVRSAUzNcpQVlpY+dzHINIhgN6gplb0=;
        b=tdRX337kroypi16M/TtUoe9dLScQ/OM8O0isV8vTmCV3kdYbxfB3pel7pgki1FtEyy
         oKUdjyYh1tRVWV4RaCumI12ADoeNBOGExArDalLP/8ydCuN0/x0xMnkI+np6dFmJ7NpJ
         wuq6xu132ypb/V6yc3neJMKwKL6iYSZqgTb0mXnKlRM7739Kbrrc0+Hp2flHppIwNGOU
         hjYANJ1d5S8H4lmk+PtYJHKPHWCxm1rnBkN99s88KcQfoeZvo5jHUBQC79X1R4UE/hyt
         2LxOhqmPURx7g4weYMYC+ZWzBjhihpPyXsonV0WJn3dy7Emft4Nhl+L77wR8VFfUlhYA
         6q1g==
X-Gm-Message-State: ACrzQf0AJDrIJEH0U+uy00Ud2SU+lbeMPGbaqpZoKR1WsOfnpwcWL1MY
        CmFBS+8bwtu+2P13Xcg0V1fFSaJeNTsusQ2X
X-Google-Smtp-Source: AMsMyM6W0/5fgyQbbNfwZpW//Zplh6Np7NoxH0rNh0NvD6dM4daQr/NGbJiMtd4s8l8nsxzthnPDvw==
X-Received: by 2002:a17:902:6943:b0:178:4751:a76b with SMTP id k3-20020a170902694300b001784751a76bmr6717778plt.37.1664511929420;
        Thu, 29 Sep 2022 21:25:29 -0700 (PDT)
Received: from jason-ThinkPad-L15-Gen-2.. ([203.67.103.146])
        by smtp.gmail.com with ESMTPSA id o17-20020a639a11000000b0043ba3d6ea3fsm760638pge.54.2022.09.29.21.25.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Sep 2022 21:25:28 -0700 (PDT)
From:   Jason Yen <jason.yen@paradetech.corp-partner.google.com>
To:     LKML <linux-kernel@vger.kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <robert.foss@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org
Cc:     treapking@google.com,
        Jason Yen <jason.yen@paradetech.corp-partner.google.com>
Subject: [PATCH v2] drm/bridge: ps8640: Add software to support aux defer
Date:   Fri, 30 Sep 2022 12:25:06 +0800
Message-Id: <20220930042506.2529522-1-jason.yen@paradetech.corp-partner.google.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This chip can not handle aux defer if the host directly program
its aux registers to access edid/dpcd. So we need let software
to handle the aux defer situation.

Signed-off-by: Jason Yen <jason.yen@paradetech.corp-partner.google.com>
---

Changes in v2:
- Add aux defer handler
- Remove incorrect statements

 drivers/gpu/drm/bridge/parade-ps8640.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/parade-ps8640.c b/drivers/gpu/drm/bridge/parade-ps8640.c
index 31e88cb39f8a..76ada237096d 100644
--- a/drivers/gpu/drm/bridge/parade-ps8640.c
+++ b/drivers/gpu/drm/bridge/parade-ps8640.c
@@ -286,7 +286,6 @@ static ssize_t ps8640_aux_transfer_msg(struct drm_dp_aux *aux,
 	}
 
 	switch (data & SWAUX_STATUS_MASK) {
-	/* Ignore the DEFER cases as they are already handled in hardware */
 	case SWAUX_STATUS_NACK:
 	case SWAUX_STATUS_I2C_NACK:
 		/*
@@ -303,6 +302,14 @@ static ssize_t ps8640_aux_transfer_msg(struct drm_dp_aux *aux,
 	case SWAUX_STATUS_ACKM:
 		len = data & SWAUX_M_MASK;
 		break;
+	case SWAUX_STATUS_DEFER:
+	case SWAUX_STATUS_I2C_DEFER:
+		if (is_native_aux)
+			msg->reply |= DP_AUX_NATIVE_REPLY_DEFER;
+		else
+			msg->reply |= DP_AUX_I2C_REPLY_DEFER;
+		len = data & SWAUX_M_MASK;
+		break;
 	case SWAUX_STATUS_INVALID:
 		return -EOPNOTSUPP;
 	case SWAUX_STATUS_TIMEOUT:
-- 
2.34.1

