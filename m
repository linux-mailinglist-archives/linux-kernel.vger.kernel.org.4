Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD2BC653C38
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 07:40:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234727AbiLVGkM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 01:40:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbiLVGkJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 01:40:09 -0500
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD68A30B
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 22:40:07 -0800 (PST)
Received: by mail-pf1-x442.google.com with SMTP id 130so578064pfu.8
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 22:40:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=msi-corp-partner-google-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ogjfcvh43nFxWJnnPvXd6MYBOFhDNuD7/XbMbc0+9WA=;
        b=OqJZAB59ID/EzzKS9/X9ntb8J7R7YMFxMetxuTncgZUdrwhQvJLh4p5Sav2sFoi8mt
         2a1c6MqnDvI+ivAsreUmGbzRrEWS6Ne7xJG1d4A53UebPLmzd1Pa8tDe7GjG8TiezO/6
         RX3ets/SdfR+vVv2p7Q5vty8/r7r0CyOtXGjBMIZ/wAoexF8E+vfKQZBJMeJz1fzC1wf
         kGvBj6KGPPJYgXCpjevDUyjKxYTs3HV1KpbqFkrDI3V52seVMREMtFaYB/or/SXpERhp
         HZV3EIwmeltNCGNYIqRw5p23c4NqBCTzhpornJPeDZrL4xG/buHQYF0X56VXvRUd1/z9
         Z4TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ogjfcvh43nFxWJnnPvXd6MYBOFhDNuD7/XbMbc0+9WA=;
        b=6MnLwpS8jnfWUHLxrGNLxTEIeqhmI4vzVE/RM2jbQCNrbg6Obhno7l/BmqefUqjdJM
         NRXpKlxNB4C4sBijli5zPF1YAWwj+yyPJzScA719JFdtRmE3uDOZ5fyXNiYzwuF9wxTG
         xDWevIYLJzKFrlkNVebnLqzz2tXItnbjRZhRK2JjkarThkOfoIRS8jMlZfsQdEZ+OJyC
         zf3WXdVCxqW2CLa7uEOHNNe+veICz1UasW02gDH/nQttKbI0R+8B3AbbmyqN2quEva7H
         6MULeTn4gqLWfYVojfD4w2r+UiS49f3f7m1tkMwiBkoaI93NZezDWlNT/28l5xHgX0ZO
         NRJg==
X-Gm-Message-State: AFqh2kqDjbph3dHvOM6pd9dkPuByEekeqYJmfp/wgLhR+fWV9I3TQ+wa
        7k0Cu4gwYshorvOnIAqH+rE2RzLZb4HhfMhw
X-Google-Smtp-Source: AMrXdXtmMLjak80VM38E7Wd9D1fLmvnMYfL4vab5F34++EowJdAgClZfDHjQ/eCnN7G61+SsEnuk5Q==
X-Received: by 2002:a05:6a00:1485:b0:575:b783:b6b3 with SMTP id v5-20020a056a00148500b00575b783b6b3mr6658062pfu.28.1671691207118;
        Wed, 21 Dec 2022 22:40:07 -0800 (PST)
Received: from localhost.localdomain (211-20-230-25.hinet-ip.hinet.net. [211.20.230.25])
        by smtp.gmail.com with ESMTPSA id q15-20020aa7982f000000b00576f9773c80sm11684539pfl.206.2022.12.21.22.40.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Dec 2022 22:40:06 -0800 (PST)
From:   Joe Wu <joewu@msi.corp-partner.google.com>
X-Google-Original-From: Joe Wu <joewu@msi.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Xiang wangx <wangxiang@cdjrlc.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Prashant Malani <pmalani@chromium.org>,
        linux-input@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        chrome-platform@lists.linux.dev,
        Benson Leung <bleung@chromium.org>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Guenter Roeck <groeck@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daisuke Nojiri <dnojiri@chromium.org>,
        Derek Huang <derekhuang@google.com>,
        "Dustin L . Howett" <dustin@howett.net>, Joe Wu <joewu@msi.com>,
        Furquan Shaikh <furquan@chromium.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lee Jones <lee.jones@linaro.org>,
        Tzung-Bi Shih <tzungbi@kernel.org>
Subject: [PATCH] cros_ec_keyb: Add 3 buttons for monitor function
Date:   Thu, 22 Dec 2022 14:39:50 +0800
Message-Id: <20221222063950.26018-1-joewu@msi.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
index 5744a2d746aa..a2073ed43972 100644
--- a/include/linux/platform_data/cros_ec_commands.h
+++ b/include/linux/platform_data/cros_ec_commands.h
@@ -3471,6 +3471,9 @@ struct ec_response_get_next_event_v1 {
 #define EC_MKBP_VOL_UP		1
 #define EC_MKBP_VOL_DOWN	2
 #define EC_MKBP_RECOVERY	3
+#define EC_MKBP_BRI_UP		4
+#define EC_MKBP_BRI_DOWN	5
+#define EC_MKBP_SCREEN_LOCK	6
 
 /* Switches */
 #define EC_MKBP_LID_OPEN	0
-- 
2.17.1

