Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5F7B62DA64
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 13:12:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240006AbiKQMMI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 07:12:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239980AbiKQMMC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 07:12:02 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 911AB697EA;
        Thu, 17 Nov 2022 04:12:01 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id d6so2449239lfs.10;
        Thu, 17 Nov 2022 04:12:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PtY5ZHyipRkNysoYODyaeuM4ZjBIG8HLKq2Vwyap5Sc=;
        b=dw4xecz+2wm8mqWsURpJtD0A0icS94F7IHTtHVSAWyR3LIulvpBoCE55JZBWB36f+P
         vjV7EQSGgAcUrQW4m9KrhktQKdAjRzAIHrccIKzESSRt1rd0b7Bis3WovGifFNt/VFcd
         Pjvu2InuvgqvupCW1g4PG/HDBNNZa7xvws2n13RxV24fW1Fl25slBn33VcapZ05KuwSX
         bcea+Z5J5YeVDGEAo5hJ28EpqUC1oxdRlPPFekbBAfugfWsZFsbmliGJihYA22z2G8fR
         /ByGY+o8rjrOFvrbKIMotXyRllykI7nzZVJ/eYaRWWjOYubq82sxUO5dC1ZVFBkjPy//
         0GXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PtY5ZHyipRkNysoYODyaeuM4ZjBIG8HLKq2Vwyap5Sc=;
        b=6k9Pw9pv8JcouNaaHC/87nTSmmvcM7nvEeqvMkK7tdj4TFUV4leYkeQKl2k8hEyemO
         9xJFuXgjG5OvOwLES6OXkh6rrp8crUF10Eg0c6JfQgyONCjSeYIURTTJmaMx0lld0dDK
         iSbuwMGo9qW1DjayEpiP3kXRVZfn5lVbx4kAWU2F5BR0AKXnm94dxFbinVrgW+b2O9Bu
         F5li0trj/EyHMmJVmD/dPGdTQ3LB2xlXpvR6hUvTzRoDjlOfx5Wkto89KKOiQ0BBlweF
         fPZkA5WPgpGtEx7U+W7fbhdPNoF4WJQQVtQEdfeuzbtiBmq7/4E9muCOktTDmDXddh12
         PRPw==
X-Gm-Message-State: ANoB5plc9oflUWUYTFXojGdBXaTkvZ7HYJiJArDc10F+vrIbceLjh918
        PVghhLGrU8p81nCVqMt56OU=
X-Google-Smtp-Source: AA0mqf5/F0iDfpEr8uTBwOyhEheq8GDT0AOnJHS6Ikkp8qWEXxQbPb1IGa9fZDnK1qTMa0ocy43qzQ==
X-Received: by 2002:a19:6755:0:b0:4ac:3f87:151f with SMTP id e21-20020a196755000000b004ac3f87151fmr847400lfj.398.1668687121029;
        Thu, 17 Nov 2022 04:12:01 -0800 (PST)
Received: from localhost.localdomain (82-209-154-112.cust.bredband2.com. [82.209.154.112])
        by smtp.gmail.com with ESMTPSA id h11-20020a2ea48b000000b0027713ef5360sm167671lji.71.2022.11.17.04.12.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 04:12:00 -0800 (PST)
From:   Marcus Folkesson <marcus.folkesson@gmail.com>
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Marcus Folkesson <marcus.folkesson@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Subject: [PATCH RESEND] HID: hid-alps: use default remove for hid device
Date:   Thu, 17 Nov 2022 13:13:22 +0100
Message-Id: <20221117121322.5608-1-marcus.folkesson@gmail.com>
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
 drivers/hid/hid-alps.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/hid/hid-alps.c b/drivers/hid/hid-alps.c
index 2b986d0dbde4..9abaff6f3afb 100644
--- a/drivers/hid/hid-alps.c
+++ b/drivers/hid/hid-alps.c
@@ -820,11 +820,6 @@ static int alps_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	return 0;
 }
 
-static void alps_remove(struct hid_device *hdev)
-{
-	hid_hw_stop(hdev);
-}
-
 static const struct hid_device_id alps_id[] = {
 	{ HID_DEVICE(HID_BUS_ANY, HID_GROUP_ANY,
 		USB_VENDOR_ID_ALPS_JP, HID_DEVICE_ID_ALPS_U1_DUAL) },
@@ -840,7 +835,6 @@ static struct hid_driver alps_driver = {
 	.name = "hid-alps",
 	.id_table		= alps_id,
 	.probe			= alps_probe,
-	.remove			= alps_remove,
 	.raw_event		= alps_raw_event,
 	.input_mapping		= alps_input_mapping,
 	.input_configured	= alps_input_configured,
-- 
2.38.1

