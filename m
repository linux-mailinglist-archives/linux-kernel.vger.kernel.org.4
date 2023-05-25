Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BDC2710EB5
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 16:55:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241698AbjEYOzL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 10:55:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241656AbjEYOy6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 10:54:58 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BF9E191;
        Thu, 25 May 2023 07:54:57 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-30957dd7640so1529671f8f.3;
        Thu, 25 May 2023 07:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685026495; x=1687618495;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v7RZChTfO9Ux9viKPzKi7S1xLwMfKhuE6t9va88Kj50=;
        b=H34FDSVCIspH1Do577D6zCt7FtKHMAv2UsgzeDJKAdeZAyyNF9t1/NLIf8QQOgyKVP
         b1dOlR5RxVdICgHMYXHy20Xbr9goCUK5hdHKZvZhu5n1AJuzV4HzAKtUoinCUX9cWTWE
         jdCm9hcEmurRBxgQSQszcXvsB3iYn0K7H5ZETBFz5Dp6MMW++g5YdrJ0216qY7eRa+ik
         RvoX3gmcz8RBSMgb/PsKOWKW5iprEtIEwZJo/epYDS1P0U4ManTd4iwQYc2NfUg4Uzl5
         yMijsKe+1xHlb7UyIYD/1ovq9zqgd/BYz9aHem7adqs5jNB1Jd+sCQOWlCKugQho9XcS
         Dyzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685026495; x=1687618495;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v7RZChTfO9Ux9viKPzKi7S1xLwMfKhuE6t9va88Kj50=;
        b=J7ghjT6G7UqrACyy6mTk2+/0FeNRpgnfmXHkSVaS6ygFfFsemq/MFPRk5iYHsrdQYM
         +Im3tEHFSYPJosM0dxEqgCgcbRYb+WxCCcw5X3F3bL5gpcvWJ4bMm8fAzJFYAE8SNfpV
         DsUqkYRisYTkM92N+1+eryZa8x7nm/g7EhJtrvNcp4fyJVTDrMdh0KM3UcIZ+cvdMbmw
         1EDS8cMKTt2dgQBg/iUhiSNdKRgY45bMyBEKhCsH5hLKta7dLEQPbddEYBSvmpKVPxPI
         Yy8rLe6jP8tpyL+jLuXkG6y+qKGwManIWdk4JeOfk2szKWcQSzzzR+M7ad0Oj2MxtdfO
         i5Bw==
X-Gm-Message-State: AC+VfDyM0FVeBX4z07TZW7sVF2yrbvPdB21ZsRU3fiV8F8ALpILA5wTS
        ynRwJucCyvzmjjZgGWDiVSU=
X-Google-Smtp-Source: ACHHUZ6SWRun1ObfcRGxN6jIRjnc3y61W8wJm7tifqFEKq1XQAGGqenFcqMzMjD4FHiXWhs54gboMg==
X-Received: by 2002:adf:f1c7:0:b0:306:2c39:5d52 with SMTP id z7-20020adff1c7000000b003062c395d52mr2560573wro.57.1685026495381;
        Thu, 25 May 2023 07:54:55 -0700 (PDT)
Received: from localhost.localdomain (93-34-93-173.ip49.fastwebnet.it. [93.34.93.173])
        by smtp.googlemail.com with ESMTPSA id t11-20020a5d49cb000000b0030732d6e104sm2048043wrs.105.2023.05.25.07.54.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 May 2023 07:54:55 -0700 (PDT)
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Christian Marangi <ansuelsmth@gmail.com>,
        linux-leds@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: [net-next PATCH v2 04/13] leds: trigger: netdev: refactor code setting device name
Date:   Thu, 25 May 2023 16:53:52 +0200
Message-Id: <20230525145401.27007-5-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230525145401.27007-1-ansuelsmth@gmail.com>
References: <20230525145401.27007-1-ansuelsmth@gmail.com>
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

From: Andrew Lunn <andrew@lunn.ch>

Move the code into a helper, ready for it to be called at
other times. No intended behaviour change.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/leds/trigger/ledtrig-netdev.c | 29 ++++++++++++++++++---------
 1 file changed, 20 insertions(+), 9 deletions(-)

diff --git a/drivers/leds/trigger/ledtrig-netdev.c b/drivers/leds/trigger/ledtrig-netdev.c
index 305eb543ba84..c93ac3bc85a6 100644
--- a/drivers/leds/trigger/ledtrig-netdev.c
+++ b/drivers/leds/trigger/ledtrig-netdev.c
@@ -104,15 +104,9 @@ static ssize_t device_name_show(struct device *dev,
 	return len;
 }
 
-static ssize_t device_name_store(struct device *dev,
-				 struct device_attribute *attr, const char *buf,
-				 size_t size)
+static int set_device_name(struct led_netdev_data *trigger_data,
+			   const char *name, size_t size)
 {
-	struct led_netdev_data *trigger_data = led_trigger_get_drvdata(dev);
-
-	if (size >= IFNAMSIZ)
-		return -EINVAL;
-
 	cancel_delayed_work_sync(&trigger_data->work);
 
 	mutex_lock(&trigger_data->lock);
@@ -122,7 +116,7 @@ static ssize_t device_name_store(struct device *dev,
 		trigger_data->net_dev = NULL;
 	}
 
-	memcpy(trigger_data->device_name, buf, size);
+	memcpy(trigger_data->device_name, name, size);
 	trigger_data->device_name[size] = 0;
 	if (size > 0 && trigger_data->device_name[size - 1] == '\n')
 		trigger_data->device_name[size - 1] = 0;
@@ -140,6 +134,23 @@ static ssize_t device_name_store(struct device *dev,
 	set_baseline_state(trigger_data);
 	mutex_unlock(&trigger_data->lock);
 
+	return 0;
+}
+
+static ssize_t device_name_store(struct device *dev,
+				 struct device_attribute *attr, const char *buf,
+				 size_t size)
+{
+	struct led_netdev_data *trigger_data = led_trigger_get_drvdata(dev);
+	int ret;
+
+	if (size >= IFNAMSIZ)
+		return -EINVAL;
+
+	ret = set_device_name(trigger_data, buf, size);
+
+	if (ret < 0)
+		return ret;
 	return size;
 }
 
-- 
2.39.2

