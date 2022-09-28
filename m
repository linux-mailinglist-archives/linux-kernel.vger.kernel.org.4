Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89E965ED6DD
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 09:54:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233734AbiI1HyO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 03:54:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233642AbiI1Hxr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 03:53:47 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67CEE5F54;
        Wed, 28 Sep 2022 00:53:16 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id z4so1337273lft.2;
        Wed, 28 Sep 2022 00:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=ou1RRtL4ikO+kz8JCQFnSDz9O1nEB+TVYO09/IQr4n4=;
        b=W1feMDsUUM8heBYa4vtXawt72yC6wQyMdspOlzS9HApmaYel+dw/cCTks64aiZ0/FB
         +6HaMDEdCvL7XPWJo9d/WAG97ds1/sNVKE0WlyTUN8iNppFrsOalOmFqNr3RZ0mCN72B
         D/K7xf5y2C2jjskfDtiTRDV9y/KkuKLStrwUlF5OHGCoC8LvlDfcmN2Jf0H/YngQxNSY
         OhbqHzxhexu6QkbepGW1gwdf7aAdoSOleG8TI+xIg9AMFpj06gBofrfaT60VvqRhtNL3
         BvHkPmGWcUh1OXa45Y2seJQKA4mq3NMAZiXa3oWA2J9ADJUjrMSGFD8+ldovA/19mv/e
         tMsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=ou1RRtL4ikO+kz8JCQFnSDz9O1nEB+TVYO09/IQr4n4=;
        b=U7didk73MATUnkJFhGSyn3AyerhPp+PQNYac9DpdbcR0DnsYwXHBCVFZNx6iCdkQWR
         XyUS5Aozr0XCAXYhXlvTqzyztvN/FQtQXFY10z8VP/GDBkKmb/KVKLg/tjLE52YsQmu+
         ZORAHM2Yx1e3Jlh8ElA74vT6kSw1lCSSbdh0nSOZWt5SKC6dKT+zons5OaDBoEvIVCUF
         LqWhw30SnfOcvaWu3H60lGviDt7MH2SF57I/QxSh+b1q9eMxVR0LPxwdOwHps02IVGBC
         N5a+7370+IG607wk5I7KbF9oSsgUW8pzu6P0VwH66Ky166wolcG54giiDmUDdYI1pESv
         bl2w==
X-Gm-Message-State: ACrzQf1cH49mCm+9O+kmRff5ss148zE8k8Xwoj+1lSI4IbxdNPAYcUiS
        VuuqTret+1BcxYYsOsIuft3kLxJcWa6NdQ==
X-Google-Smtp-Source: AMsMyM6SlgLcDWDW36KcWjnBSwnvB9diErjfL5vDaJZ0xj0SmsduFAf+ILDa+2jAC2TVk4RlKzUHSA==
X-Received: by 2002:a05:6512:3d09:b0:497:ab35:fd12 with SMTP id d9-20020a0565123d0900b00497ab35fd12mr13234719lfv.539.1664351594690;
        Wed, 28 Sep 2022 00:53:14 -0700 (PDT)
Received: from localhost.localdomain (82-209-154-112.cust.bredband2.com. [82.209.154.112])
        by smtp.gmail.com with ESMTPSA id b28-20020a05651c033c00b00261ccf566e3sm357770ljp.65.2022.09.28.00.53.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 00:53:13 -0700 (PDT)
From:   Marcus Folkesson <marcus.folkesson@gmail.com>
To:     Jiri Kosina <jikos@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     linux-input@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Marcus Folkesson <marcus.folkesson@gmail.com>
Subject: [PATCH] HID: hid-sensor-custom: set fixed size for custom attributes
Date:   Wed, 28 Sep 2022 09:59:13 +0200
Message-Id: <20220928075913.64125-1-marcus.folkesson@gmail.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is no bugfix (so no Fixes: tag is necessary) as it is
taken care of in hid_sensor_custom_add_attributes().

The motivation for this patch is that:
hid_sensor_custom_field.attr_name and
hid_sensor_custom_field.attrs
has the size of HID_CUSTOM_TOTAL_ATTRS and used in same context.

We compare against HID_CUSTOM_TOTAL_ATTRS when
looping through hid_custom_attrs.

We will silent the smatch error:
hid_sensor_custom_add_attributes() error: buffer overflow
'hid_custom_attrs' 8 <= 10

Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
---
 drivers/hid/hid-sensor-custom.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/hid-sensor-custom.c b/drivers/hid/hid-sensor-custom.c
index 32c2306e240d..602465ad2745 100644
--- a/drivers/hid/hid-sensor-custom.c
+++ b/drivers/hid/hid-sensor-custom.c
@@ -62,7 +62,7 @@ struct hid_sensor_sample {
 	u32 raw_len;
 } __packed;
 
-static struct attribute hid_custom_attrs[] = {
+static struct attribute hid_custom_attrs[HID_CUSTOM_TOTAL_ATTRS] = {
 	{.name = "name", .mode = S_IRUGO},
 	{.name = "units", .mode = S_IRUGO},
 	{.name = "unit-expo", .mode = S_IRUGO},
-- 
2.37.1

