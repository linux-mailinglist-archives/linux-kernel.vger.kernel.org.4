Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F71762DA67
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 13:12:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240043AbiKQMMX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 07:12:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240057AbiKQMMR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 07:12:17 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B84FF70A25;
        Thu, 17 Nov 2022 04:12:08 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id c1so2462225lfi.7;
        Thu, 17 Nov 2022 04:12:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QQBF037ir2neveiNV9S6vlyKu6iA0W4yp3JG1tCgnsw=;
        b=nqaE219F+qHantJ2wcuOZFpENWvGmMilEgyGcDx7+OT+HAA1VrtIQuvvPCxdENNXSg
         V6iZ9bMLJETYKbrcGDMdcaKN4XDaRbqnXK2HaqMkH5Q3HjO3LykFSpWdIqmn5UBz+zjg
         IYjt7kLYj0uzoFrnPzHfdIEIrJyfgF2muqtvIfm5OE7oJ02lRkRIuf84Mck1k5AdGfcP
         eIB8XU9JR5qf8WqU2wePk4Iii6kRZibVOc+127OSZwjcQp6SRF+Wg9o9qB+EGQ7LdPYa
         6P7d9U8pMD2MUlLLSXRQkYK1KlP9jFZChY7ufykp5SIMNBs+XC09d0kRYMYcKljT4d9O
         9dTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QQBF037ir2neveiNV9S6vlyKu6iA0W4yp3JG1tCgnsw=;
        b=tCBsFYK6p8bujaDeDjUFsTYGArNfxOUDUKw/Pr1MDyhefWgxHoYJUcsK+zDeIuB1tV
         l1msD8Bx1iH2SI8ibZFmyDQnqpMdneFR+NIqhaNHpqShOA1c+AdGr4SkG2rZonTKGzrN
         9vXOZKmhuQ6dA9ZqyGEWTIuabMWRmlg/ak2PtgzrDurIRKWe8eV/9cQ0fvR/VGWW2w6i
         u3JEm/6SdMLL25DrJnvGNMuX6Fj032fHnkivr2WhF+LxhCSleikMdfRMP27ldeImHXBb
         Vlgx3AIeuowoplLcdn3mV0jWgxdHJ4CRxDHIrmUOSzFoiPTglMXOUqYLC/u28DRxAfRi
         BTCg==
X-Gm-Message-State: ANoB5pkY+7txYX24C+2iklSnDR/MMdM772pI6TTVhR7q2D58Y+8HM59K
        eTRkHOw7QeXkt2yrQHPikfk=
X-Google-Smtp-Source: AA0mqf4/fz/K800a0L5v7/Eol2BK62BY1Fz4+97vDkmJ60jOyYh7jfpCi74lNDNbYWQmNB6paKFo7A==
X-Received: by 2002:a05:6512:2a8c:b0:4ac:102e:5ca5 with SMTP id dt12-20020a0565122a8c00b004ac102e5ca5mr895163lfb.236.1668687127135;
        Thu, 17 Nov 2022 04:12:07 -0800 (PST)
Received: from localhost.localdomain (82-209-154-112.cust.bredband2.com. [82.209.154.112])
        by smtp.gmail.com with ESMTPSA id a4-20020a056512200400b004a01105eea2sm120808lfb.150.2022.11.17.04.12.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 04:12:06 -0800 (PST)
From:   Marcus Folkesson <marcus.folkesson@gmail.com>
To:     Jiri Kosina <jikos@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     linux-input@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Marcus Folkesson <marcus.folkesson@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v2] HID: hid-sensor-custom: set fixed size for custom attributes
Date:   Thu, 17 Nov 2022 13:13:26 +0100
Message-Id: <20221117121326.5621-1-marcus.folkesson@gmail.com>
X-Mailer: git-send-email 2.38.1
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
Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
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
2.38.1

