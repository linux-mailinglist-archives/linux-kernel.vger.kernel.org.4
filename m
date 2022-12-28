Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E713657188
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 02:04:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230410AbiL1BEo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 20:04:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiL1BEm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 20:04:42 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1492FE013
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 17:04:40 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id c9so4920333pfj.5
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 17:04:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r5mZF+HqNi7oJNQi66SgCofHZHC1n4UI9rtyVYM/8No=;
        b=KiXQtSzK6SfREKzd9svD1tT0Hd3tIGm6pdGm+RbC+q7dG/Y5Uk/MXDB4H+UwxH8CSF
         MF2snD+BFILP1wBx1EcIXbKnt+5YWVABswwFJ4OTWq1fYcIG1rqA1yK/0vCLyrc5do1I
         lFveHNrmGfJ1u01ZL+qgFDsqDoeqGy22tbUpY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r5mZF+HqNi7oJNQi66SgCofHZHC1n4UI9rtyVYM/8No=;
        b=hY9YjvgLN/5qIzZpnodK7GegD1idEmcOtPBZ9aD3ZnWI+j0ZyzgxbiLVNXnhSrznLP
         FlBvJJo6VeUCDYCiOt9V0iOkjpthfNjf8rMlMuuOVpk398RP80aMjuv6N/oeN5rcor1c
         PRqv1lVJI34GfA0FRySdor9AiXjZVhK+9uCrJT/zu/1OU/KNih094IE++4z+95ni4hC5
         sQO5gMy+wDbsYxEsE+UVVItT82K+SoGPKsmjmRGS4hLVXpYu98Ccx/b3b9z8iEo6xTga
         m+TazhbnKWYxh3WcZmrrv93BJFc+yj2RNNCVp00ECtUkgaw7hsK/RofWdigljGVmwuRR
         Ux0g==
X-Gm-Message-State: AFqh2ko27IRXI1/7/VxmOSq5NxsbdfD12RMp43oLFZ5KuEpYH6qO5nfc
        nNyko04KNmjj+1Cz/h7it2R2A/RpOXdAMvBT
X-Google-Smtp-Source: AMrXdXveagOKrg0TX75B+ykXkGP1Pv+3qW3ri++W2sqEuWcUZoMLj6WCEAJPZTVuQO0zRoCzG7eoBw==
X-Received: by 2002:a62:ae13:0:b0:577:9182:19a7 with SMTP id q19-20020a62ae13000000b00577918219a7mr27292800pff.29.1672189479431;
        Tue, 27 Dec 2022 17:04:39 -0800 (PST)
Received: from pmalani.c.googlers.com.com (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id 68-20020a621947000000b00580e679dcf2sm6045566pfz.157.2022.12.27.17.04.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Dec 2022 17:04:39 -0800 (PST)
From:   Prashant Malani <pmalani@chromium.org>
To:     linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev
Cc:     heikki.krogerus@linux.intel.com,
        Prashant Malani <pmalani@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Daisuke Nojiri <dnojiri@chromium.org>,
        "Dustin L. Howett" <dustin@howett.net>,
        Evan Green <evgreen@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <groeck@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Lee Jones <lee.jones@linaro.org>, Lee Jones <lee@kernel.org>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Tinghan Shen <tinghan.shen@mediatek.com>,
        Tzung-Bi Shih <tzungbi@kernel.org>,
        Xiang wangx <wangxiang@cdjrlc.com>
Subject: [PATCH 05/10] platform/chrome: cros_ec_typec: Update port DP VDO
Date:   Wed, 28 Dec 2022 00:45:08 +0000
Message-Id: <20221228004648.793339-6-pmalani@chromium.org>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
In-Reply-To: <20221228004648.793339-1-pmalani@chromium.org>
References: <20221228004648.793339-1-pmalani@chromium.org>
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

The port advertising DP support is a Type-C receptacle. Fix the port's
DisplayPort VDO to reflect this.

Fixes: 1903adae0464 ("platform/chrome: cros_ec_typec: Add bit offset for DP VDO")
Signed-off-by: Prashant Malani <pmalani@chromium.org>
---
 drivers/platform/chrome/cros_ec_typec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
index 05dc5a63af53..665fa76e2416 100644
--- a/drivers/platform/chrome/cros_ec_typec.c
+++ b/drivers/platform/chrome/cros_ec_typec.c
@@ -27,7 +27,7 @@
 #define DRV_NAME "cros-ec-typec"
 
 #define DP_PORT_VDO	(DP_CONF_SET_PIN_ASSIGN(BIT(DP_PIN_ASSIGN_C) | BIT(DP_PIN_ASSIGN_D)) | \
-				DP_CAP_DFP_D)
+				DP_CAP_DFP_D | DP_CAP_RECEPTACLE)
 
 /* Supported alt modes. */
 enum {
-- 
2.39.0.314.g84b9a713c41-goog

