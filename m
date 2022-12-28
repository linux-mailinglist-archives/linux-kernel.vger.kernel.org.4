Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E917657191
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 02:13:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232336AbiL1BNG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 20:13:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbiL1BNB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 20:13:01 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2706B4B
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 17:12:57 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id d10so9698743pgm.13
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 17:12:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=19FACrxzZLvGXvd0qASwod3BuDfjZjR6MyHlKQ4qp7g=;
        b=iEVqWLpKFWneA1CaDK1kR7cs5OO3qwDqFvdU2t4jNQZOYZuUah0u5S9U6d6kBS9K5P
         4GynIc5CjpScZRoFcv7w4txy1LtJyF1SiMm8Mapgj32y6w1cX9VXL6lcpELZYg4G3ohN
         YRRTb4EG9LMCE47SXDsUxXt8KElbfN1f9MgKQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=19FACrxzZLvGXvd0qASwod3BuDfjZjR6MyHlKQ4qp7g=;
        b=znZTzoMVJf+N7o2aWM8cYcw0G/jHf5hXX4+PG7k4DRDP1eUhgkdmJoxfWof2G1E2se
         uVZILR4TW0bADhN8F/o4MGqeWzWJ2eGx/Oz9IkFjqgjzB5CpVrFeRP671A0P8sQW3mji
         R1AJf0JtFXe9nxSshDHppyL4QnDD1Tl1bTBatrZOwnTI4ByPKt9jIVOnw95lolEOmqzq
         7a7KlY6WhrAawfH9xUBBdkxcSy3ef4eZvFtBC01wjat+PFVkwtyIvAhDeaFrhKGnX75K
         Ji7sMMymyTxb1kS39dI1kBumvCTobRV2sLQsNZ/0jvq4g7CqjNe5rCYuY+z2nsH08eqR
         mlrQ==
X-Gm-Message-State: AFqh2kq/OJSiJbwAilMsPhV48axXssJkkfwpi7z/1l7DIhB7DFiXJ6Mp
        FyJ3okCGJU5+1PscusC94TbTlh3jhpRFUQg5
X-Google-Smtp-Source: AMrXdXtE+Iu61LxC8/oG9wiX3A5IaH1P+cVPyJUa2fQ6FKLIm8WQohl8bsbs8zl8o9Nxf1TwkKt2rA==
X-Received: by 2002:a05:6a00:1f06:b0:581:366b:ca63 with SMTP id be6-20020a056a001f0600b00581366bca63mr7058629pfb.34.1672189977038;
        Tue, 27 Dec 2022 17:12:57 -0800 (PST)
Received: from pmalani.c.googlers.com.com (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id 68-20020a621947000000b00580e679dcf2sm6045566pfz.157.2022.12.27.17.12.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Dec 2022 17:12:56 -0800 (PST)
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
Subject: [PATCH 10/10] platform/chrome: cros_typec_vdm: Add VDM send support
Date:   Wed, 28 Dec 2022 00:45:13 +0000
Message-Id: <20221228004648.793339-11-pmalani@chromium.org>
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

Add support to send generic VDM messages from the alt mode driver to the
partner (via the ChromeOS EC). The function introduced here is intended
to be called by the alt mode driver (via the Type-C bus logic).

Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Signed-off-by: Prashant Malani <pmalani@chromium.org>
---
 drivers/platform/chrome/cros_typec_vdm.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/platform/chrome/cros_typec_vdm.c b/drivers/platform/chrome/cros_typec_vdm.c
index fc7b602ceb37..aca9d337118e 100644
--- a/drivers/platform/chrome/cros_typec_vdm.c
+++ b/drivers/platform/chrome/cros_typec_vdm.c
@@ -77,6 +77,30 @@ static int cros_typec_port_amode_enter(struct typec_altmode *amode, u32 *vdo)
 			   sizeof(req), NULL, 0);
 }
 
+static int cros_typec_port_amode_vdm(struct typec_altmode *amode, const u32 hdr,
+				     const u32 *vdo, int cnt)
+{
+	struct cros_typec_port *port = typec_altmode_get_drvdata(amode);
+	struct ec_params_typec_control req = {
+		.port = port->port_num,
+		.command = TYPEC_CONTROL_COMMAND_SEND_VDM_REQ,
+	};
+	struct typec_vdm_req vdm_req = {};
+
+	vdm_req.vdm_data[0] = hdr;
+	vdm_req.vdm_data_objects = cnt;
+	memcpy(&vdm_req.vdm_data[1], vdo, cnt - 1);
+	vdm_req.partner_type = TYPEC_PARTNER_SOP;
+	req.vdm_req_params = vdm_req;
+
+	dev_dbg(port->typec_data->dev, "Sending VDM, hdr: %x, num_objects: %d, port: %d\n",
+		hdr, cnt, port->port_num);
+
+	return cros_ec_cmd(port->typec_data->ec, 0, EC_CMD_TYPEC_CONTROL, &req,
+			   sizeof(req), NULL, 0);
+}
+
 struct typec_altmode_ops port_amode_ops = {
 	.enter = cros_typec_port_amode_enter,
+	.vdm = cros_typec_port_amode_vdm,
 };
-- 
2.39.0.314.g84b9a713c41-goog

