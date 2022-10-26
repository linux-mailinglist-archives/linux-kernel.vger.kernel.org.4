Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 335E760E831
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 21:03:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233775AbiJZTDa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 15:03:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234765AbiJZTC5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 15:02:57 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A6C510A7E1;
        Wed, 26 Oct 2022 12:01:11 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id v27so20888966eda.1;
        Wed, 26 Oct 2022 12:01:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gzOvAyGDXhsFFUVp58xr8wzl/ct2UtB9GMmORTrIQvw=;
        b=VkszwJfpdTdcR/n7PA9ZaP+Z9XiOgGjMiVywP7tgwz3e0LJH/kgHgSMI5Jb176mnNG
         8mlUJ/2mfq3cyFl+C/t0bqrEceaVwiatUL7boJoIgoWZ+VlA29ETng448qZo0bAquAf5
         /GC4uGJCxDYaaND6YKkcd2l6+e+kd0O6A19PbMHRz1mZZmiKDZmJhTKHr0tJbO7BRMw4
         VTuQrwgE886CRH6/3kZUDlC1lKgQJ5zSJ6Dzuc88j8yBS1vu2dkwiqu8RNQT5WgGOXd9
         ypjFVyHF556cwvIBresZq6zqg+3GgGrH37RHgmcfjuY3UJ250M+ZoT/6HFkZwxV1nV1m
         KLVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gzOvAyGDXhsFFUVp58xr8wzl/ct2UtB9GMmORTrIQvw=;
        b=iLqL9JkQcOQFi0skoBQesU+8zXXKSoqtDJq3p1bvvot3ICXnhYMsp7Fqp/7WfV9ie/
         zjbADyoKIiLxNoqaD5Ai/xz5tzmNipDqQIavaSPT3LZ4dvvLN8keiRvD0am8qCc2NLtk
         aFSp5WniNcmHK5WO6gQjyNQIWxNWtewjhHl+U4aPh58gT5lMFQMlM0QBenrKTVutbTR7
         t1q9R5LQ8fiBICIsehNZK0kSGdGE9xJ2woa4S5tHDEPl6+dIqQSPjd6DLtd/itKFgpT4
         yaR1jqKhOyf0LzaE2x2JeebwdOEzNuFeNmesa5QGPZt+dVW/67IPJWaEPTOSD5TkRFTd
         iXqw==
X-Gm-Message-State: ACrzQf01ySQOGdNAhpuJnwgqOfSaxuBffPU2pSm4XXzqXS4S8JI60Zua
        p4Ck6dix4QeSCpqgPUH1+pyf6OFl6DbCSQ==
X-Google-Smtp-Source: AMsMyM6EuM6YxynAN8LS5QzMDwp4kotTWyTmirX+o+DKZyJIyjimUefjZ/V2u4x5jN2NVS2PyrdYDQ==
X-Received: by 2002:aa7:cb59:0:b0:461:7378:7be0 with SMTP id w25-20020aa7cb59000000b0046173787be0mr23230343edt.60.1666810870072;
        Wed, 26 Oct 2022 12:01:10 -0700 (PDT)
Received: from eray-Lenovo-Z50-70.. ([188.132.247.187])
        by smtp.googlemail.com with ESMTPSA id r18-20020a1709063d7200b0076ff600bf2csm3342945ejf.63.2022.10.26.12.01.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 12:01:09 -0700 (PDT)
From:   =?UTF-8?q?Eray=20Or=C3=A7unus?= <erayorcunus@gmail.com>
To:     platform-driver-x86@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        ike.pan@canonical.com, jikos@kernel.org,
        benjamin.tissoires@redhat.com, dmitry.torokhov@gmail.com,
        hdegoede@redhat.com, mgross@linux.intel.com,
        =?UTF-8?q?Eray=20Or=C3=A7unus?= <erayorcunus@gmail.com>
Subject: [PATCH 1/6] Revert "platform/x86: ideapad-laptop: check for touchpad support in _CFG"
Date:   Wed, 26 Oct 2022 22:01:01 +0300
Message-Id: <20221026190106.28441-2-erayorcunus@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221026190106.28441-1-erayorcunus@gmail.com>
References: <20221026190106.28441-1-erayorcunus@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Last 8 bit of _CFG started being used in later IdeaPads, thus 30th bit
doesn't always show whether device supports touchpad or touchpad switch.
Remove checking bit 30 of _CFG, so older IdeaPads like S10-3 can switch
touchpad again via touchpad attribute.

This reverts commit b3ed1b7fe3786c8fe795c16ca07cf3bda67b652f.

Signed-off-by: Eray Orçunus <erayorcunus@gmail.com>
---
 drivers/platform/x86/ideapad-laptop.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/platform/x86/ideapad-laptop.c b/drivers/platform/x86/ideapad-laptop.c
index e7a1299e3776..b67bac457a7a 100644
--- a/drivers/platform/x86/ideapad-laptop.c
+++ b/drivers/platform/x86/ideapad-laptop.c
@@ -46,11 +46,10 @@ static const char *const ideapad_wmi_fnesc_events[] = {
 #endif
 
 enum {
-	CFG_CAP_BT_BIT       = 16,
-	CFG_CAP_3G_BIT       = 17,
-	CFG_CAP_WIFI_BIT     = 18,
-	CFG_CAP_CAM_BIT      = 19,
-	CFG_CAP_TOUCHPAD_BIT = 30,
+	CFG_CAP_BT_BIT   = 16,
+	CFG_CAP_3G_BIT   = 17,
+	CFG_CAP_WIFI_BIT = 18,
+	CFG_CAP_CAM_BIT  = 19,
 };
 
 enum {
@@ -367,8 +366,6 @@ static int debugfs_cfg_show(struct seq_file *s, void *data)
 		seq_puts(s, " wifi");
 	if (test_bit(CFG_CAP_CAM_BIT, &priv->cfg))
 		seq_puts(s, " camera");
-	if (test_bit(CFG_CAP_TOUCHPAD_BIT, &priv->cfg))
-		seq_puts(s, " touchpad");
 	seq_puts(s, "\n");
 
 	seq_puts(s, "Graphics: ");
@@ -661,8 +658,7 @@ static umode_t ideapad_is_visible(struct kobject *kobj,
 	else if (attr == &dev_attr_fn_lock.attr)
 		supported = priv->features.fn_lock;
 	else if (attr == &dev_attr_touchpad.attr)
-		supported = priv->features.touchpad_ctrl_via_ec &&
-			    test_bit(CFG_CAP_TOUCHPAD_BIT, &priv->cfg);
+		supported = priv->features.touchpad_ctrl_via_ec;
 	else if (attr == &dev_attr_usb_charging.attr)
 		supported = priv->features.usb_charging;
 
-- 
2.34.1

