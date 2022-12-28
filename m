Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0BE6657190
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 02:11:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232276AbiL1BL3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 20:11:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbiL1BL1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 20:11:27 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18708E2A
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 17:11:23 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id c7so9804642pfc.12
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 17:11:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BNxB8uMl8S+cIx13svZb0f8mLMHIEoe8sZA5V2z0kk4=;
        b=WE2qgyx2SI+0tgX6FHwbAgRVNSwZkLvp+BZysQ1edZOmVv9pJnG8YXnN/8Lclrb0Vl
         XqC3/gtQRm5xycVhdAzhZ2ri8e4ZOz/ULgJ34r+L9pGkwzarzraFHYwWE0QOPWSFzM2e
         teYVgdNUSBYpY+M3rIq1RMbt8q9twyzRCBpVc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BNxB8uMl8S+cIx13svZb0f8mLMHIEoe8sZA5V2z0kk4=;
        b=x0IzbXANOA4smyJWPf6k5K+LHE/i6odBcmTrvB/EUa6Z9R2hEAn2A+QQv/CcRLp1xo
         0+6FOem7IhGFaKAYkqBB2Wp6VsmTuRNjfwbRliyxVtSzNk/b2ysi7SElGOVyKud7UBML
         pt2CjhMoHKi1icmwhtqBNTxLWCSdnI/FtRJiK5LWdGjUbMQfiXY8H33vUJmHvBijhH+m
         yqap8zrtJCYpXL0uw+7PSYDq648/PjgyQ/+HgWlXlLBDiKKOIm2xDgkbZt4uGjdlkil7
         NfWDPMZhaBRuAhZpARMP4cGmwDlOSH2a5eZANlGh9AAf5giGAzk29JsqxTISf90vc8Xo
         5owA==
X-Gm-Message-State: AFqh2kqN7sHIfsccav6SxEi86mL0me2/t3Cme5Un1IG5+EB6LkraMYcI
        6Q/6BJ/uDqR+ITnHHVf964gNMy3vnyWcyehA
X-Google-Smtp-Source: AMrXdXuRniPa+kdLE35R+lvAK/KHSDtSV/UXu7eXSGc2mSHOFloadStPHn4NrOnaiT9YsDCTJDnekw==
X-Received: by 2002:aa7:9e11:0:b0:576:c2f0:d6a1 with SMTP id y17-20020aa79e11000000b00576c2f0d6a1mr27063164pfq.8.1672189882439;
        Tue, 27 Dec 2022 17:11:22 -0800 (PST)
Received: from pmalani.c.googlers.com.com (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id 68-20020a621947000000b00580e679dcf2sm6045566pfz.157.2022.12.27.17.11.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Dec 2022 17:11:22 -0800 (PST)
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
        Stephen Boyd <swboyd@chromium.org>,
        Tinghan Shen <tinghan.shen@mediatek.com>,
        Tzung-Bi Shih <tzungbi@kernel.org>,
        Xiang wangx <wangxiang@cdjrlc.com>
Subject: [PATCH 09/10] platform/chrome: cros_typec_vdm: Add VDM reply support
Date:   Wed, 28 Dec 2022 00:45:12 +0000
Message-Id: <20221228004648.793339-10-pmalani@chromium.org>
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

Handle response VDMs which are sent by the partner (replying to VDMs
sent by the host system itself). These get forwarded to the altmode
driver.

Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Signed-off-by: Prashant Malani <pmalani@chromium.org>
---
 drivers/platform/chrome/cros_ec_typec.c  |  7 +++++
 drivers/platform/chrome/cros_typec_vdm.c | 39 ++++++++++++++++++++++++
 drivers/platform/chrome/cros_typec_vdm.h |  2 ++
 3 files changed, 48 insertions(+)

diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
index 1e28d56b094d..e02107a6870a 100644
--- a/drivers/platform/chrome/cros_ec_typec.c
+++ b/drivers/platform/chrome/cros_ec_typec.c
@@ -1000,6 +1000,13 @@ static void cros_typec_handle_status(struct cros_typec_data *typec, int port_num
 					 "Failed SOP Disc event clear, port: %d\n", port_num);
 		}
 	}
+
+	if (resp.events & PD_STATUS_EVENT_VDM_REQ_REPLY) {
+		cros_typec_handle_vdm_response(typec, port_num);
+		ret = cros_typec_send_clear_event(typec, port_num, PD_STATUS_EVENT_VDM_REQ_REPLY);
+		if (ret < 0)
+			dev_warn(typec->dev, "Failed VDM Reply event clear, port: %d\n", port_num);
+	}
 }
 
 static int cros_typec_port_update(struct cros_typec_data *typec, int port_num)
diff --git a/drivers/platform/chrome/cros_typec_vdm.c b/drivers/platform/chrome/cros_typec_vdm.c
index df0102ca3a18..fc7b602ceb37 100644
--- a/drivers/platform/chrome/cros_typec_vdm.c
+++ b/drivers/platform/chrome/cros_typec_vdm.c
@@ -13,6 +13,45 @@
 #include "cros_ec_typec.h"
 #include "cros_typec_vdm.h"
 
+/*
+ * Retrieves a VDM response from the EC and forwards it to the altmode driver based on SVID.
+ */
+void cros_typec_handle_vdm_response(struct cros_typec_data *typec, int port_num)
+{
+	struct ec_response_typec_vdm_response resp;
+	struct ec_params_typec_vdm_response req = {
+		.port = port_num,
+	};
+	struct typec_altmode *amode;
+	u16 svid;
+	u32 hdr;
+	int ret;
+
+	ret = cros_ec_cmd(typec->ec, 0, EC_CMD_TYPEC_VDM_RESPONSE, &req,
+			  sizeof(req), &resp, sizeof(resp));
+	if (ret < 0) {
+		dev_warn(typec->dev, "Failed VDM response fetch, port: %d\n", port_num);
+		return;
+	}
+
+	hdr = resp.vdm_response[0];
+	svid = PD_VDO_VID(hdr);
+	dev_dbg(typec->dev, "Received VDM header: %x, port: %d\n", hdr, port_num);
+
+	amode = typec_match_altmode(typec->ports[port_num]->port_altmode, CROS_EC_ALTMODE_MAX,
+				    svid, PD_VDO_OPOS(hdr));
+	if (!amode) {
+		dev_err(typec->dev, "Received VDM for unregistered altmode (SVID:%x), port: %d\n",
+			svid, port_num);
+		return;
+	}
+
+	ret = typec_altmode_vdm(amode, hdr, &resp.vdm_response[1], resp.vdm_data_objects);
+	if (ret)
+		dev_err(typec->dev, "Failed to forward VDM to altmode (SVID:%x), port: %d\n",
+			svid, port_num);
+}
+
 static int cros_typec_port_amode_enter(struct typec_altmode *amode, u32 *vdo)
 {
 	struct cros_typec_port *port = typec_altmode_get_drvdata(amode);
diff --git a/drivers/platform/chrome/cros_typec_vdm.h b/drivers/platform/chrome/cros_typec_vdm.h
index 7e282d168a98..003587525554 100644
--- a/drivers/platform/chrome/cros_typec_vdm.h
+++ b/drivers/platform/chrome/cros_typec_vdm.h
@@ -7,4 +7,6 @@
 
 extern struct typec_altmode_ops port_amode_ops;
 
+void cros_typec_handle_vdm_response(struct cros_typec_data *typec, int port_num);
+
 #endif /*  __CROS_TYPEC_VDM__ */
-- 
2.39.0.314.g84b9a713c41-goog

