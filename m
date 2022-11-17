Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CC9462DA61
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 13:12:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240021AbiKQMMD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 07:12:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239972AbiKQML7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 07:11:59 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4077C47330;
        Thu, 17 Nov 2022 04:11:58 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id d6so2448946lfs.10;
        Thu, 17 Nov 2022 04:11:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2ZQ6+hOFaKk/5UeozWSpWsKewGAgOXsoqvkqyl7Kn/s=;
        b=gd0JLH35qEWIjmLmCtR4y/iAm4+gwaDbDFYCCtYxgF+WPz0Ke/3cofKm/TqUTFc6Jt
         K1VRk8lhx5uhhXSN0vjRU8GGheQv2Cnmgb5hdHhcU4UKKKvUzYqqGlmstI3JG3yov5ft
         pT94l/csTjImx5XWffKwAshz7rPQoO/+Y4Hy7yd+jQCm81tLfufVgtovNIOw9nvCnKf7
         N5If/F8jptlniIVIKz2q0i6P1jl7++hS2KgoRVhLnY/E8DQfSTaLGatr3VnrBwFJfzGj
         fDeKu6zS5F0o9xw0MX3BLD7IzD7LaGKQrqlvhCScI5fD0/v1DXeswUBbcU+ebPSTKa0j
         l4RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2ZQ6+hOFaKk/5UeozWSpWsKewGAgOXsoqvkqyl7Kn/s=;
        b=xT5Q0NzgXdvMOaJVgGIAWQ7YEeIWfNX6Tml5NvC1ZmEvyQ6xNypoilVnGMugA11emD
         /D/CsTDrvp/GbP2BhF/DbTjFY8CV2V/5m4OgWiDuCTk2x2GjVnt1mRHdrGgkbW3HNUON
         Xim3MNgED6KT2nbkWIsgojkEvTe6d4IeFIuJCvBybL45/UsHougdGN9tLJdVTQGW4GpI
         DX876fF/nU42mKiYmubkT6knBApjoeALq1fz5jS5k+FiL5/2/dHwQq1L5F8OqdfbQ4/9
         9wZmZ/TRmj2FtmCzrmYq/hek3rAxF+72CVFh4sjF0Fr0NR8er0nS43HgfwWPr7BespOq
         shCw==
X-Gm-Message-State: ANoB5pnpIcVtOGrGH4mjJtwyyF31wrWSB8GP9DJTuaYr6bpK6KIYG5L4
        hSIocANag7a0jhyUOZwHSzw=
X-Google-Smtp-Source: AA0mqf7Rc2ueYUbuwnhyiwp0b8rJSF699J5T7hNwZlH/8ZMpcClsIUNQzVKCZjx+ujp+id57lDWuZA==
X-Received: by 2002:a05:6512:376c:b0:4ad:70c1:de61 with SMTP id z12-20020a056512376c00b004ad70c1de61mr745657lft.509.1668687116549;
        Thu, 17 Nov 2022 04:11:56 -0800 (PST)
Received: from localhost.localdomain (82-209-154-112.cust.bredband2.com. [82.209.154.112])
        by smtp.gmail.com with ESMTPSA id be40-20020a056512252800b00497a61453a9sm117565lfb.243.2022.11.17.04.11.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 04:11:55 -0800 (PST)
From:   Marcus Folkesson <marcus.folkesson@gmail.com>
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Marcus Folkesson <marcus.folkesson@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Subject: [PATCH RESEND] HID: hid-elan: use default remove for hid device
Date:   Thu, 17 Nov 2022 13:13:14 +0100
Message-Id: <20221117121314.5577-1-marcus.folkesson@gmail.com>
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
2.38.1

