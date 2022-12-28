Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20A42657187
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 02:03:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230347AbiL1BC7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 20:02:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiL1BC6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 20:02:58 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFB23DFD7
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 17:02:54 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id q68so2216513pgq.9
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 17:02:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CbjTsx7UG59fZ2gLebJbhfQe4ODmuLy0COLAvv8hKdk=;
        b=ah1j6uRlh40gT4KP48ZO4mCU9YtccnyURceyhbTIH6fORS0aZqEok97bfxUQai4LLP
         fYfTjCPLYz2bUl5qvzmk3xYNuq7JsoBJDZ0IRGvTHnNfo/qczH/Tk6I+fBJ6wApoZ6aF
         Z5Onv+nMh5Qji4XfGX+1tzunUoq33squgPVWc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CbjTsx7UG59fZ2gLebJbhfQe4ODmuLy0COLAvv8hKdk=;
        b=Ys4ArStEMVWwgqQRqHxSCPrOkNQ60Mhbiil1sA0qeZh0iw3JFTDYSfP1XXvOa8TaeX
         Or6M1Jh+3ab1BVTDPhclosa622loGuFsO/SbrXvT1v25A+K7rztMj4ZnvpRiFbFbj4Kk
         hzFTDtUJ61JhmAIDHxRa86qmTLwfwZ1YG/tsGyEmNGPk9hOXgkuc+1inP8+vZr2MlPM/
         UUpddx8DclwluzroWUGayb/2pu/CBsCxwt4G4SD88iypw/Mv/XVMtEy6eLGq3FOs2sLs
         YxeMEC1OYjmwnJzrCC2eNZ1kQl8Zu1lyYX3LuyNNSESLQf0bJYGm5vV/QipYPe7MsTMs
         CoUw==
X-Gm-Message-State: AFqh2krYdM3c3iNeDhQN4NjFfEShLzw5GIy+rFL5Pwk/Nnnxlj1iDNuL
        0PjzNrb6PuzP46tkuskrdLM+YD5p+GyBMB10
X-Google-Smtp-Source: AMrXdXtag5e98w+qZ8o8usxXV7igTWLFzCDC0XYCGCVJixhOsxrxWP+M/gdV7E5FHEBniz371pMBMw==
X-Received: by 2002:a05:6a00:1d91:b0:575:a4f5:7812 with SMTP id z17-20020a056a001d9100b00575a4f57812mr28189419pfw.4.1672189374332;
        Tue, 27 Dec 2022 17:02:54 -0800 (PST)
Received: from pmalani.c.googlers.com.com (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id 68-20020a621947000000b00580e679dcf2sm6045566pfz.157.2022.12.27.17.02.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Dec 2022 17:02:54 -0800 (PST)
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
Subject: [PATCH 04/10] platform/chrome: cros_ec_typec: Set port alt mode drvdata
Date:   Wed, 28 Dec 2022 00:45:07 +0000
Message-Id: <20221228004648.793339-5-pmalani@chromium.org>
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

Save the ChromeOS-specific Type-C port info in the port altmodes' driver
data. This makes communication with the ChromeOS EC (Embedded
Controller) easier when alt mode drivers need to send messages to
peripherals.

Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Signed-off-by: Prashant Malani <pmalani@chromium.org>
---
 drivers/platform/chrome/cros_ec_typec.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
index bc8dc8bd90b3..05dc5a63af53 100644
--- a/drivers/platform/chrome/cros_ec_typec.c
+++ b/drivers/platform/chrome/cros_ec_typec.c
@@ -345,6 +345,7 @@ static int cros_typec_register_port_altmodes(struct cros_typec_data *typec,
 	if (IS_ERR(amode))
 		return PTR_ERR(amode);
 	port->port_altmode[CROS_EC_ALTMODE_DP] = amode;
+	typec_altmode_set_drvdata(amode, port);
 
 	/*
 	 * Register TBT compatibility alt mode. The EC will not enter the mode
@@ -358,6 +359,7 @@ static int cros_typec_register_port_altmodes(struct cros_typec_data *typec,
 	if (IS_ERR(amode))
 		return PTR_ERR(amode);
 	port->port_altmode[CROS_EC_ALTMODE_TBT] = amode;
+	typec_altmode_set_drvdata(amode, port);
 
 	port->state.alt = NULL;
 	port->state.mode = TYPEC_STATE_USB;
-- 
2.39.0.314.g84b9a713c41-goog

