Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A23B4738406
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 14:43:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231629AbjFUMnd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 08:43:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbjFUMnb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 08:43:31 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D937107;
        Wed, 21 Jun 2023 05:43:30 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-666e916b880so2682883b3a.2;
        Wed, 21 Jun 2023 05:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687351410; x=1689943410;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=w/6gXIWTqPYU9mM1Gisj5YbdRDJVns+HyZGDjaiUXfk=;
        b=HEt5pAKbTU1mylVa5+rX7MBvxfEN3Xgz/fUBg77onXqSK9cJiM5IdrvBfVWm3tKdtt
         lEl74g2RCrPl4gE0+BSx/m0m+6qFdXupaGWuvdu+HWcQeHzbTo91Z5WeHaf/vWlWfWn7
         V8uBkQOxQ6MUfF9pyZ8/MYqyNlqId4muSPxtBylYR2KR/Kwec0u17Nn5m7FsLINSVBnP
         c0qoQ6epe/FLNLsV7vxT9YKPv6hRV33cb4v+6tF3ZwZobm7x+X2uYyK7GEdRSzsEypVb
         rWBGkosmlgmRUJxzyqOxGu6xLvZSPSRUsVeNCnOxT6Q/+AEDCJMo5DxN/ntJVEEHhpqr
         OqTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687351410; x=1689943410;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w/6gXIWTqPYU9mM1Gisj5YbdRDJVns+HyZGDjaiUXfk=;
        b=CO3KD/7esEZ2OT2rAajFtHBS2jPhcV4wjIhPsghbyYRI2CeD1D9Y9EjLw6DUi3WX3y
         vLqS+duFWOKUlq0SVijxG9kUd25YxAYqOcvVRymkshe5V4M4ag1iL/vgguhy+xeWBXhy
         nL+LToDyitfHbohp7okLScvTnge1CfRSOxmSymm1elcmVxb0xOoHEdMCDp3HHPpdobZL
         WQlxIEVBtjKOEXZg8d9DhqUk+98VcFUkJEzOQiixLmMAlhZyc8GtwbvGXfrt4K6yEZUT
         AQsnE7XZ7Ni50fWnVqoIFJnvwHTCUdpi9fnOkZaW3vYv2+DcWUXBHfhsPJdcxJ+S/t1r
         wpxw==
X-Gm-Message-State: AC+VfDyoaea+IzuqUejH2yAiqeoPOV0US37pFIKokDcmGCYz7h5DGzvB
        dqq1Damzkklu/W0hR/1MVQbgYZb7CZk=
X-Google-Smtp-Source: ACHHUZ52rHQfd3JpZ8EYEsh4BuJqL2mHG3qWxhcqU8yd7QN2yaU+yCKzEFc9B2Q3R4IiyWPLLtSNKw==
X-Received: by 2002:a05:6a20:a10b:b0:10a:ef63:4c33 with SMTP id q11-20020a056a20a10b00b0010aef634c33mr6553903pzk.47.1687351409661;
        Wed, 21 Jun 2023 05:43:29 -0700 (PDT)
Received: from chcpu13.cse.ust.hk (191host119.mobilenet.cse.ust.hk. [143.89.191.119])
        by smtp.gmail.com with ESMTPSA id q9-20020a170902bd8900b001b53d3d8f3dsm3377691pls.299.2023.06.21.05.43.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 05:43:29 -0700 (PDT)
From:   Wei Chen <harperchen1110@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Wei Chen <harperchen1110@gmail.com>
Subject: [PATCH] usb: gadget: legacy: fix error return code in gfs_bind
Date:   Wed, 21 Jun 2023 12:43:23 +0000
Message-Id: <20230621124323.47183-1-harperchen1110@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We must return negative error code -ENOMEM if function
'usb_otg_descriptor_alloc()' fails.

Signed-off-by: Wei Chen <harperchen1110@gmail.com>
---
 drivers/usb/gadget/legacy/g_ffs.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/legacy/g_ffs.c b/drivers/usb/gadget/legacy/g_ffs.c
index ae6d8f7092b8..4592df5e2ea1 100644
--- a/drivers/usb/gadget/legacy/g_ffs.c
+++ b/drivers/usb/gadget/legacy/g_ffs.c
@@ -395,8 +395,10 @@ static int gfs_bind(struct usb_composite_dev *cdev)
 		struct usb_descriptor_header *usb_desc;
 
 		usb_desc = usb_otg_descriptor_alloc(cdev->gadget);
-		if (!usb_desc)
+		if (!usb_desc) {
+			ret = -ENOMEM;
 			goto error_rndis;
+		}
 		usb_otg_descriptor_init(cdev->gadget, usb_desc);
 		gfs_otg_desc[0] = usb_desc;
 		gfs_otg_desc[1] = NULL;
-- 
2.25.1

