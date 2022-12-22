Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 510A1653A82
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 03:15:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234730AbiLVCP4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 21:15:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230134AbiLVCPw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 21:15:52 -0500
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CC5D175B4
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 18:15:51 -0800 (PST)
Received: by mail-pj1-x1042.google.com with SMTP id t11-20020a17090a024b00b0021932afece4so4283540pje.5
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 18:15:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=msi-corp-partner-google-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5pMtoNjAwIQUvGwTR7JCUzDt1hzSa3SUyDledqQ1II4=;
        b=Q6MhEJDaep967D5w2qUF36srj3NDACk7BOk56l1MYh1GvdlnNF8ZEglDBfiEzHfcD+
         POvoaIeId8WV/9ge5PV43ewLIj0fHWx3ad3skDC0iKsfKNExhusKpkVxg1D517njaxGC
         QZenOz+ynDr1WivFV+t+y+/qvvOMQwC/7Mt83tTD/0sgscL/gvI4YsFwRnsqGSkPavPX
         jeszAW+J2ZJT0xdVMCTYS4my5C424Ro5bKj/hC+ybDGcjr4TMNTQeFz1GK1jWZsxL2zn
         tGAyZ/Flili5R2hR6n29S8f3+YbZ5GQvGMDpElIxLGI2nNKnufAIyAg2XyzNKxqVs1al
         n/qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5pMtoNjAwIQUvGwTR7JCUzDt1hzSa3SUyDledqQ1II4=;
        b=hBnZp8h2FuQTE3DM1L95WmMJ5vqeCRCiYCqw/bBATRliJNfOlCsSWvyj8TAyhBpJzu
         LUkioEMx5wphs+Nv4qid/4VORrYI/cTjhxlqZyL1NKvXZsWaqJSmTj2OfFOQSOzdBF27
         5r0nIOT3fOOga85N6Zj6EfefNBLmdciX4zJg3cnd73Eft1Eie8fttVJppVq3UQygem7w
         vzZqieJF2vdp9nUqFvPJocPz80S3CqhFXIfXHPH5q/SVu02V9MGWonx0acIjCWB951Kc
         o0+YSz6RniTvD4NzGol6N2nFqZSawHBqIrJ/YsgGjt7BDLvR9XkN3hp1r86L9UFlONk9
         00NQ==
X-Gm-Message-State: AFqh2kq5su2S3ZcGSsrzd5YnCoHvL9Ypv0Pw9AOqg+JDFi8L/faUeHbv
        lUQAyIYl8GkfNnLSvcp6veUKzzD0QBJXQwzO
X-Google-Smtp-Source: AMrXdXsJGC5V725RQYKSvnHp/eZhEhgA5pWxuQtOYcAI4IF4DfDmZZZWuVchRgxyd5FYIcWCw2DFTA==
X-Received: by 2002:a17:902:7d89:b0:190:fe60:48c4 with SMTP id a9-20020a1709027d8900b00190fe6048c4mr19406377plm.21.1671675350984;
        Wed, 21 Dec 2022 18:15:50 -0800 (PST)
Received: from localhost.localdomain (211-20-230-25.hinet-ip.hinet.net. [211.20.230.25])
        by smtp.gmail.com with ESMTPSA id q18-20020a17090311d200b00188f07c9eedsm12127824plh.176.2022.12.21.18.15.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Dec 2022 18:15:50 -0800 (PST)
From:   Joe Wu <joewu@msi.corp-partner.google.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Furquan Shaikh <furquan@chromium.org>,
        Daisuke Nojiri <dnojiri@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Benson Leung <bleung@chromium.org>,
        Derek Huang <derekhuang@google.com>,
        "Dustin L . Howett" <dustin@howett.net>, Joe Wu <joewu@msi.com>,
        Guenter Roeck <groeck@chromium.org>,
        linux-input@vger.kernel.org, Xiang wangx <wangxiang@cdjrlc.com>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Prashant Malani <pmalani@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Tzung-Bi Shih <tzungbi@kernel.org>,
        chrome-platform@lists.linux.dev,
        Stephen Boyd <swboyd@chromium.org>,
        Joe Wu <joewu@msi.corp-partner.google.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Tinghan Shen <tinghan.shen@mediatek.com>
Subject: [PATCH] cros_ec_keyb: Add 3 buttons for monitor function
Date:   Thu, 22 Dec 2022 10:15:42 +0800
Message-Id: <20221222021542.11706-1-joewu@msi.corp-partner.google.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joe Wu <joewu@msi.com>

Add 3 extra buttons: 'brightness up', 'brightness down'
and 'screen lock' to support monitor manipulating function.

Signed-off-by: Joe Wu <joewu@msi.com>
---

 drivers/input/keyboard/cros_ec_keyb.c          | 15 +++++++++++++++
 include/linux/platform_data/cros_ec_commands.h |  3 +++
 2 files changed, 18 insertions(+)

diff --git a/drivers/input/keyboard/cros_ec_keyb.c b/drivers/input/keyboard/cros_ec_keyb.c
index 6f435125ec03..e7ecfca838df 100644
--- a/drivers/input/keyboard/cros_ec_keyb.c
+++ b/drivers/input/keyboard/cros_ec_keyb.c
@@ -100,6 +100,21 @@ static const struct cros_ec_bs_map cros_ec_keyb_bs[] = {
 		.code		= KEY_VOLUMEDOWN,
 		.bit		= EC_MKBP_VOL_DOWN,
 	},
+	{
+		.ev_type        = EV_KEY,
+		.code           = KEY_BRIGHTNESSUP,
+		.bit            = EC_MKBP_BRI_UP,
+	},
+	{
+		.ev_type        = EV_KEY,
+		.code           = KEY_BRIGHTNESSDOWN,
+		.bit            = EC_MKBP_BRI_DOWN,
+	},
+	{
+		.ev_type        = EV_KEY,
+		.code           = KEY_SCREENLOCK,
+		.bit            = EC_MKBP_SCREEN_LOCK,
+	},
 
 	/* Switches */
 	{
diff --git a/include/linux/platform_data/cros_ec_commands.h b/include/linux/platform_data/cros_ec_commands.h
index 5744a2d746aa..502f0397a402 100644
--- a/include/linux/platform_data/cros_ec_commands.h
+++ b/include/linux/platform_data/cros_ec_commands.h
@@ -3471,6 +3471,9 @@ struct ec_response_get_next_event_v1 {
 #define EC_MKBP_VOL_UP		1
 #define EC_MKBP_VOL_DOWN	2
 #define EC_MKBP_RECOVERY	3
+#define EC_MKBP_BRI_UP          4
+#define EC_MKBP_BRI_DOWN        5
+#define EC_MKBP_SCREEN_LOCK     6
 
 /* Switches */
 #define EC_MKBP_LID_OPEN	0
-- 
2.17.1

