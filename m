Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 716E2657181
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 01:56:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230168AbiL1A4p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 19:56:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiL1A4m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 19:56:42 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 940FCDFFD
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 16:56:41 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id m7-20020a17090a730700b00225ebb9cd01so6749049pjk.3
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 16:56:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6pBNYJdKXzam2nXK0e/4rLZrKFDWqDasg6cE5ctCeLs=;
        b=RKvg/T3PMBvEQZilUPnU4QNnnFWl3WaUHN9Rf/hXYh6bzT9+tVGKtuqYOuFUFKL/xt
         tCiKyp2lUBydu+rR22CjAkhiw0oiIpA4oD8BVbALOVLcusx2KyR1ob1G8hQ/CiiitCzn
         bomGAoN0aZ4RLZl3gzDrce6rFlcaf3O69q7/o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6pBNYJdKXzam2nXK0e/4rLZrKFDWqDasg6cE5ctCeLs=;
        b=JoKtnna/0seKf6sMZE/Im/FHXyS8u6aZGAg5o2kCxvIFJXIKeXqk0ad9f19l7fr8Ug
         IYfoOG7RW/TcuLgpLuM7F05GigTJ45hceEAGpgzVcl8JvFkBwgCq4Lpi+8eYD/giwjC0
         caaXnYFXXAc/tmiBMwhAQQyrarUQ00U2wP44qTmqey4bNMaWnSrT+2Arzsv+fxPCXLca
         WWJ8KSa4Ip9jhfK/dteVlExTx1xwQyPFi96c+quk11yAlfz+N5ZZACP2LxbmqRoz1BYr
         LvlCioAkOqACuwYZZCMq56OZwkGEqod8vK2TGvDmnz2tqc6IUBjmPgFPE3dS/tVoe/fQ
         5ASA==
X-Gm-Message-State: AFqh2kptKugesJdDrPh90ncrHsd1LqmLt2gYhbUDhEx3nyWmya6YFlOk
        4SBdlww05XKiOqM9zyQMmnREj/43uF83q8uf
X-Google-Smtp-Source: AMrXdXtlGD1iF9qDlfibxWqFvtJyFneuKzXuyKtopGLMCo88wsQSvk2xYDuqTAiHjx1yO48ULlMsFw==
X-Received: by 2002:a05:6a20:1bd9:b0:ad:efda:5e5d with SMTP id cv25-20020a056a201bd900b000adefda5e5dmr24969506pzb.61.1672189000941;
        Tue, 27 Dec 2022 16:56:40 -0800 (PST)
Received: from pmalani.c.googlers.com.com (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id 68-20020a621947000000b00580e679dcf2sm6045566pfz.157.2022.12.27.16.56.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Dec 2022 16:56:40 -0800 (PST)
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
        Kees Cook <keescook@chromium.org>,
        Lee Jones <lee.jones@linaro.org>, Lee Jones <lee@kernel.org>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Tinghan Shen <tinghan.shen@mediatek.com>,
        Tzung-Bi Shih <tzungbi@kernel.org>,
        Xiang wangx <wangxiang@cdjrlc.com>
Subject: [PATCH 01/10] Revert "mfd: cros_ec: Add SCP Core-1 as a new CrOS EC MCU"
Date:   Wed, 28 Dec 2022 00:45:04 +0000
Message-Id: <20221228004648.793339-2-pmalani@chromium.org>
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

This reverts commit 66ee379d743c69c726b61d078119a34d5be96a35.

The feature flag introduced by Commit 66ee379d743c ("mfd: cros_ec: Add
SCP Core-1 as a new CrOS EC MCU") was not first added in the source EC
code base[1]. This can lead to the possible misinterpration of an EC's
supported feature set, as well as causes issues with all future feature
flag updates.

[1] https://source.chromium.org/chromium/chromiumos/platform/ec/+/main:include/ec_commands.h

Signed-off-by: Prashant Malani <pmalani@chromium.org>
---

While this patch modifies drivers/mfd, it would be preferable to submit
it through the chrome-platform tree, since that eliminates cross-tree
dependencies for the series of which this patch is a part.


 drivers/mfd/cros_ec_dev.c                      | 5 -----
 include/linux/platform_data/cros_ec_commands.h | 2 --
 include/linux/platform_data/cros_ec_proto.h    | 1 -
 3 files changed, 8 deletions(-)

diff --git a/drivers/mfd/cros_ec_dev.c b/drivers/mfd/cros_ec_dev.c
index 344ad03bdc42..02d4271dfe06 100644
--- a/drivers/mfd/cros_ec_dev.c
+++ b/drivers/mfd/cros_ec_dev.c
@@ -64,11 +64,6 @@ static const struct cros_feature_to_name cros_mcu_devices[] = {
 		.name	= CROS_EC_DEV_SCP_NAME,
 		.desc	= "System Control Processor",
 	},
-	{
-		.id	= EC_FEATURE_SCP_C1,
-		.name	= CROS_EC_DEV_SCP_C1_NAME,
-		.desc	= "System Control Processor 2nd Core",
-	},
 	{
 		.id	= EC_FEATURE_TOUCHPAD,
 		.name	= CROS_EC_DEV_TP_NAME,
diff --git a/include/linux/platform_data/cros_ec_commands.h b/include/linux/platform_data/cros_ec_commands.h
index 5744a2d746aa..7c94bf5c8f05 100644
--- a/include/linux/platform_data/cros_ec_commands.h
+++ b/include/linux/platform_data/cros_ec_commands.h
@@ -1300,8 +1300,6 @@ enum ec_feature_code {
 	 * mux.
 	 */
 	EC_FEATURE_TYPEC_MUX_REQUIRE_AP_ACK = 43,
-	/* The MCU is a System Companion Processor (SCP) 2nd Core. */
-	EC_FEATURE_SCP_C1 = 45,
 };
 
 #define EC_FEATURE_MASK_0(event_code) BIT(event_code % 32)
diff --git a/include/linux/platform_data/cros_ec_proto.h b/include/linux/platform_data/cros_ec_proto.h
index e43107e0bee1..a1f5b6d6db3a 100644
--- a/include/linux/platform_data/cros_ec_proto.h
+++ b/include/linux/platform_data/cros_ec_proto.h
@@ -19,7 +19,6 @@
 #define CROS_EC_DEV_ISH_NAME	"cros_ish"
 #define CROS_EC_DEV_PD_NAME	"cros_pd"
 #define CROS_EC_DEV_SCP_NAME	"cros_scp"
-#define CROS_EC_DEV_SCP_C1_NAME	"cros_scp_c1"
 #define CROS_EC_DEV_TP_NAME	"cros_tp"
 
 #define CROS_EC_DEV_EC_INDEX 0
-- 
2.39.0.314.g84b9a713c41-goog

