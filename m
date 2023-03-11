Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0575D6B5E6B
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 18:12:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229901AbjCKRMp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 12:12:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjCKRMo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 12:12:44 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8E6C43469;
        Sat, 11 Mar 2023 09:12:41 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id p4so1585969wre.11;
        Sat, 11 Mar 2023 09:12:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678554760;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UneVJauXqzJbqHiPtAbq37DezBUTdm8dXTrT8TwnGEk=;
        b=aBl9T/7YL8rOTDBaUVWaS+jtJiSbgQU+RKYkRi61JyQG6ZUJD3digqXrDQLnOhtW7b
         r6GOwbqUaHhzBpLY5VRHUeWowh1y7Ll07zHew6gdqxSfVut7yErUmvAL4p8L1f9ZDnco
         O5IGdSaJkksL+XAILFtIsoOrQs8/ByXvBTwublJA6c8y6/HOO7tYFmGGpnOWA81CmgRf
         SD5oQsGkUJqyp09awTtn/C6RlUuZJZdQgrwkA3DXdsRZT72PnmbMCVW21oAiIJV/f04+
         wJH+B2pEck2nGAx0TlReyuBDDMEHCcWnp7T++yeXW0D17g4tTkbjNmlxTVbqkU53jqYk
         DWbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678554760;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UneVJauXqzJbqHiPtAbq37DezBUTdm8dXTrT8TwnGEk=;
        b=8NXhICvIiu8uZi0vj7uzUod5p0LvwyBjfCQb/PDirIF71QNmiNRM59iVTNshmq2Ecq
         S9pvX36tKqyRwT9qHMCOV5sG9Su4eNYe0CPbnwfPOerC3DryjWg9puKefrYf5CWqF/HJ
         M9HX1gB0B81nrWr1KTbny4YaR3nmH7vyrrMCTktPC3KUUjNH69rABm5ir/woTQEb4X2B
         1rilI7/zXgVWZCpuzimJnq+hmrMNFXqQrv74CuUxt5c7vAe8Kdgok8bHbf39v2lfEU5v
         K/Z9G68xyog2HRDuMBw6T1S8/i3HMbzzFE7YQUq+xybUkFrlNzAdADe7TQho32A7SIu7
         /6zw==
X-Gm-Message-State: AO0yUKWiGqAPPhtrINt3cSBqlyddzGkRZhxVlX4ycDoxNlE2f1/egH70
        nfTL/YDdCWAYnaxLCASgugp2DednluILHxpv
X-Google-Smtp-Source: AK7set/UFMO1yGmeph2j+iJSmqnMlvGNTW7iPDbuOy/iuzfmb/WE7gdZr8xXfZpV+dWJdirnKuwY/Q==
X-Received: by 2002:adf:f5c9:0:b0:2c7:1210:fe42 with SMTP id k9-20020adff5c9000000b002c71210fe42mr18967094wrp.47.1678554759710;
        Sat, 11 Mar 2023 09:12:39 -0800 (PST)
Received: from localhost.localdomain ([84.32.202.14])
        by smtp.gmail.com with ESMTPSA id f11-20020adff44b000000b002c6e8cb612fsm2932354wrp.92.2023.03.11.09.12.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Mar 2023 09:12:38 -0800 (PST)
From:   Yaroslav Furman <yaro330@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     yaro330@gmail.com, Alan Stern <stern@rowland.harvard.edu>,
        linux-usb@vger.kernel.org, usb-storage@lists.one-eyed-alien.net,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] uas: Add US_FL_NO_REPORT_OPCODES for JMicron JMS583Gen 2
Date:   Sat, 11 Mar 2023 19:12:26 +0200
Message-Id: <20230311171226.20353-1-yaro330@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <7f670cac-aa36-4bb9-a2b1-4451e4e85fab@rowland.harvard.edu>
References: <7f670cac-aa36-4bb9-a2b1-4451e4e85fab@rowland.harvard.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just like other JMicron JMS5xx enclosures, it chokes on report-opcodes,
let's avoid them.

Signed-off-by: Yaroslav Furman <yaro330@gmail.com>
---
 drivers/usb/storage/unusual_uas.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/usb/storage/unusual_uas.h b/drivers/usb/storage/unusual_uas.h
index c7b763d6d102..1f8c9b16a0fb 100644
--- a/drivers/usb/storage/unusual_uas.h
+++ b/drivers/usb/storage/unusual_uas.h
@@ -111,6 +111,13 @@ UNUSUAL_DEV(0x152d, 0x0578, 0x0000, 0x9999,
 		USB_SC_DEVICE, USB_PR_DEVICE, NULL,
 		US_FL_BROKEN_FUA),
 
+/* Reported by: Yaroslav Furman <yaro330@gmail.com> */
+UNUSUAL_DEV(0x152d, 0x0583, 0x0000, 0x9999,
+		"JMicron",
+		"JMS583Gen 2",
+		USB_SC_DEVICE, USB_PR_DEVICE, NULL,
+		US_FL_NO_REPORT_OPCODES),
+
 /* Reported-by: Thinh Nguyen <thinhn@synopsys.com> */
 UNUSUAL_DEV(0x154b, 0xf00b, 0x0000, 0x9999,
 		"PNY",
-- 
2.39.2

