Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0531D6796AC
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 12:31:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234061AbjAXLb4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 06:31:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234054AbjAXLbz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 06:31:55 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5ED52BF1A
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 03:31:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674559864;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=W1Z3yo6YNn+U1mSRAjq+bBj48Ek+sNGL1L2Z6GAsWx4=;
        b=XBhasdmssoNKP52qFjRzBz1OF9DzGKiX/Z2yOj+XBlG19iKTBMr7kuoZ3FD9Fx2TEaN1i2
        TjO9319dWBV4LJFl149pjVWuAyL9P22nIG39QQHFqbQQrr/1vglD2mfIfjN/tevBajwoKA
        hIHEq3QLbPU2u2eMhrEhuezKO0y5Dyo=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-86-Z9AgDpyzP6q0ScrvQDmp1Q-1; Tue, 24 Jan 2023 06:31:02 -0500
X-MC-Unique: Z9AgDpyzP6q0ScrvQDmp1Q-1
Received: by mail-qt1-f199.google.com with SMTP id cn7-20020a05622a248700b003b7f2a89829so401754qtb.6
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 03:31:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W1Z3yo6YNn+U1mSRAjq+bBj48Ek+sNGL1L2Z6GAsWx4=;
        b=7Y1QXjpuWKxItl1/uKgEhxIu1Niqav0FJUAio0GCMXEieOuT0SZTKkNiLe8zZwFnaH
         9YanJePmWg5u53bmv58VMMm+LmWTVQO+rY2kjHpePNHnBMPQ9ZQUDR90QxfEsAVc2YDk
         x8Gakz4JpIchL+tmkBYzR6Ow08TJJ1quzt1+b1NtkgZPJN7SMKLTvfnMLxQw5Q00JlXx
         oBGbN43TJE3a3rncycvAh/+qCipfe9o+nAe/OM52NGmERDNApXCoV+bwGh5DB1hBgvhb
         kHm8E34zQqKmzI0hw7HV+TaQ0jZ4+27kYO35MY8p7QlnvOPVe6w5mRA+ri0D2r6WHesZ
         jRvQ==
X-Gm-Message-State: AFqh2kp1Q+9fcovsAO1SqYa/3K3XlNBqM+AVxsdbXvEpgm7X5sGmknn6
        lNHd9MH8M1ikdoBpkyZDxaeNj9fPYSiulgiCt5OKer5XtzRIVeozZyXWTqWAeN5uAR73YFpBE7l
        ZQPytDYlbPvvrMSP+2r6b2V4=
X-Received: by 2002:ac8:608:0:b0:3a8:dae:d985 with SMTP id d8-20020ac80608000000b003a80daed985mr60841463qth.14.1674559862306;
        Tue, 24 Jan 2023 03:31:02 -0800 (PST)
X-Google-Smtp-Source: AMrXdXvt2py71n2IPOqEwwEHXZpwF+QswBW5iGJotYPdAgToxylejDBwN1E0rtPWJk/mJNgfD7PvUw==
X-Received: by 2002:ac8:608:0:b0:3a8:dae:d985 with SMTP id d8-20020ac80608000000b003a80daed985mr60841438qth.14.1674559862014;
        Tue, 24 Jan 2023 03:31:02 -0800 (PST)
Received: from klayman.redhat.com (net-2-34-30-183.cust.vodafonedsl.it. [2.34.30.183])
        by smtp.gmail.com with ESMTPSA id 18-20020ac856f2000000b0039cd4d87aacsm1070142qtu.15.2023.01.24.03.30.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jan 2023 03:31:01 -0800 (PST)
From:   Marco Pagani <marpagan@redhat.com>
To:     Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>
Cc:     Marco Pagani <marpagan@redhat.com>, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH] fpga: bridge: return errors in the show() method of the "state" attribute
Date:   Tue, 24 Jan 2023 12:30:50 +0100
Message-Id: <20230124113050.117645-1-marpagan@redhat.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch changes the show() method of the "state" sysfs attribute to
return an error if the bridge's enable_show() op returns an error code.
In this way, the userspace can distinguish between when the bridge is
actually "enabled" (i.e., allowing signals to pass) or "disabled"
(i.e., gating signals), or when there is an error (e.g., the state of
the bridge cannot be determined).

Currently, enable_show() returns an integer representing the bridge's
state (enabled or disabled) or an error code. However, this integer
value is interpreted in state_show() as a bool, resulting in the method
printing "enabled" (i.e., the bridge allows signals to pass), without
propagating the error, even when enable_show() returns an error code.

Another possibility could be to change the signature of enable_show()
to return a bool for symmetry with the enable_set() "setter" method.
However, this would prevent enable_show() from returning error codes
and may break the HPS bridge driver (altera-hps2fpga.c +53).

Thanks

Signed-off-by: Marco Pagani <marpagan@redhat.com>
---
 drivers/fpga/fpga-bridge.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/fpga/fpga-bridge.c b/drivers/fpga/fpga-bridge.c
index 727704431f61..5cd40acab5bf 100644
--- a/drivers/fpga/fpga-bridge.c
+++ b/drivers/fpga/fpga-bridge.c
@@ -293,12 +293,15 @@ static ssize_t state_show(struct device *dev,
 			  struct device_attribute *attr, char *buf)
 {
 	struct fpga_bridge *bridge = to_fpga_bridge(dev);
-	int enable = 1;
+	int state = 1;
 
-	if (bridge->br_ops && bridge->br_ops->enable_show)
-		enable = bridge->br_ops->enable_show(bridge);
+	if (bridge->br_ops && bridge->br_ops->enable_show) {
+		state = bridge->br_ops->enable_show(bridge);
+		if (state < 0)
+			return state;
+	}
 
-	return sprintf(buf, "%s\n", enable ? "enabled" : "disabled");
+	return sysfs_emit(buf, "%s\n", state ? "enabled" : "disabled");
 }
 
 static DEVICE_ATTR_RO(name);
-- 
2.39.1

