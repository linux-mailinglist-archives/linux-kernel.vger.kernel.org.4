Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9E345B9AC6
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 14:28:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229894AbiIOM2w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 08:28:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbiIOM2r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 08:28:47 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BA5B9A944;
        Thu, 15 Sep 2022 05:28:44 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id w8so30093546lft.12;
        Thu, 15 Sep 2022 05:28:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=40DtW8ykLy6BtsPyzt0N0rx1HrOvNQG+mtHjb5a76vM=;
        b=S729pxPI2NNp+bMSsU08hhAxAKqO0WPbRila+RhVk/rmc2I5mFsvOjCRawITkIBdoC
         atHyVCt+0c9t4XGuvhmP8capU04CYD/zEkKQh62xi9ttT4PIiHJg4dDvyu/wPEk6g3hY
         1CWBsvZuqm2OCcEkyRzSgx88wH0oUWSDqUusl3SOVxgGJJYVCGyqdbj6HLE9lKVfE71p
         D3r7DXuPqrJanUuXt9xlmbKTxNeOWiZLBC0zyRQhApK/f1xXygZDkInNYV5h9lxCXbcm
         56MhEspNrbLREwgJdLZGQIZdecvPDB8upbJvPocTBOzZHjX5ym4MzQL6hD2pIlxUVRBq
         A6aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=40DtW8ykLy6BtsPyzt0N0rx1HrOvNQG+mtHjb5a76vM=;
        b=GWoX8DehfaPTVqM+8obpuWoVDw6v6/T2CJSy2KlQHhamvLEzPhiIAvc1/Eei53Kakp
         dgBJ73AQ4pUrVjB9QeBVb+sIiRmcnQ39B8PdzBt7jJQJOXdqg90L2+EkzD1px9ckPptb
         a3+xqgiH0fd3EcFWsgzazihOUE7qA1ORdANLGnJNI++NqCqVcwGAfmjRcl6IZ0ay6a0o
         XRLX7DcerQB2SdXPrcQLs0iEhbXUICPm2rhqlw1uIYCTzuR3nm5IyX4wpcJLGT7IKPz/
         UB/5Hdf27AAlVSt6PSg61ykP5/XB5MXn9gqDCGSO635q3f8Lzllc+Om4E2k8swGFMMVa
         2JZQ==
X-Gm-Message-State: ACgBeo1RDFOZItPIM1LUFHkvN1FvPb0X8yhLgW1S3yTRxXFkrmEIGHNp
        /YLT7mUWMCyEn/Sbh6g1rvvVfpjzRmo=
X-Google-Smtp-Source: AA6agR7mjb9UCxyEQx8o6xu96a6tC7oILCdaZHgUrKu1EuSFExzlaLnviCPWMxFKV0gwE6H4K8qqLw==
X-Received: by 2002:a05:6512:e9f:b0:498:f1e5:26e5 with SMTP id bi31-20020a0565120e9f00b00498f1e526e5mr12633819lfb.517.1663244922096;
        Thu, 15 Sep 2022 05:28:42 -0700 (PDT)
Received: from localhost.localdomain (82-209-154-112.cust.bredband2.com. [82.209.154.112])
        by smtp.gmail.com with ESMTPSA id v22-20020a2e9616000000b0026bfb6a2e6dsm2878340ljh.25.2022.09.15.05.28.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Sep 2022 05:28:41 -0700 (PDT)
From:   Marcus Folkesson <marcus.folkesson@gmail.com>
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Marcus Folkesson <marcus.folkesson@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Subject: [PATCH] HID: hid-elan: use default remove for hid device
Date:   Thu, 15 Sep 2022 14:34:32 +0200
Message-Id: <20220915123432.520760-1-marcus.folkesson@gmail.com>
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

hid_device_remove() will call hid_hw_stop() as default .remove function
if no function is specified.

Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
---
 drivers/hid/hid-elan.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/hid/hid-elan.c b/drivers/hid/hid-elan.c
index 8e4a5528e25d..76d93fc48f6a 100644
--- a/drivers/hid/hid-elan.c
+++ b/drivers/hid/hid-elan.c
@@ -507,11 +507,6 @@ static int elan_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	return ret;
 }
 
-static void elan_remove(struct hid_device *hdev)
-{
-	hid_hw_stop(hdev);
-}
-
 static const struct hid_device_id elan_devices[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ELAN, USB_DEVICE_ID_HP_X2),
 	  .driver_data = ELAN_HAS_LED },
@@ -529,7 +524,6 @@ static struct hid_driver elan_driver = {
 	.input_configured = elan_input_configured,
 	.raw_event = elan_raw_event,
 	.probe = elan_probe,
-	.remove = elan_remove,
 };
 
 module_hid_driver(elan_driver);
-- 
2.37.1

