Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AB0B60E82D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 21:03:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234700AbiJZTD1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 15:03:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234672AbiJZTC5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 15:02:57 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AFC710AC04;
        Wed, 26 Oct 2022 12:01:14 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id b2so24047627eja.6;
        Wed, 26 Oct 2022 12:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dxceK4h9km4GtO20VnsGtzfG02HWM3iZYATl3ehVRaM=;
        b=eHui6vyvmJL3NN+kpS1RZhq8hAbWvJ9JSsDODJnswnweEF5pbJUSuoNNMhU0+pFFm1
         /hyTTeE1jy92zw3e6fGCUsZKaN8/P3ni4Cp8yQhQnEP7/wKCrg9PF5RVeOyEKNAcItey
         tabPYYF9PyohE1+KvhpMdoCqkyEhHiHKqhtwIP2CXyMVCQQajnQcqw7zuSXw8lPwg3i7
         zcFmSIJJWWKBNmf7X4V5aN2q1HtQJQ712HtCgz3/Y0ajxcrsLKbMZlhC/ZJZKpKCeTaQ
         oMzu07uTr/fAV/v0L0rycmPgEabktu9Aig6E/d1U5Qp8zF9dFaG0QVrjEPR32VcetoyN
         W2fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dxceK4h9km4GtO20VnsGtzfG02HWM3iZYATl3ehVRaM=;
        b=Pn0+c0PK4bQvQp+4kJ0sXcDVrFJmLEjLO3JAp9ViwvLHXfnM/BLqwnbYvsY1Fw2SPb
         g6E8bi4uvcEdjlM6AZRlUo1MTC9jJfnDayoIhJChAolRCAQDbMws2VTdiWaGf6qvXjJw
         Ei5EQIDJvLJ/q6bdMD+hlE9Z5/o4u+3qEzKZ4ssq+JBuHsUdSvIe+qEfbQV7k2aawhQM
         kc4J0K57q4CupK6wsihoa++KwupNQLSY2uiA7J80N5VaXqTl1yRyHOQVwf0w+m7Qyggj
         pSa3odiYdf2m4Ihs/90iYR20CxJu/GCyt+wXL1EbSqxThCYDnLrJLIky8qGdoEvbzQxw
         lL9w==
X-Gm-Message-State: ACrzQf0hWGyelanmbc6no0oLRCTl2DVLpwPAQux2NXCPCQ/w0VnW2RyF
        4gcOFTH4bZwvV5pRUXL00Ncg6+qsSU3xag==
X-Google-Smtp-Source: AMsMyM41Dyf2CPfFMSWZRVy/qH34L8+rg5PZJpnxnGDSewlJ1FlMPnPwioCispne12+GopHHdc0wJA==
X-Received: by 2002:a17:906:7314:b0:791:a45a:bc84 with SMTP id di20-20020a170906731400b00791a45abc84mr37343231ejc.394.1666810872684;
        Wed, 26 Oct 2022 12:01:12 -0700 (PDT)
Received: from eray-Lenovo-Z50-70.. ([188.132.247.187])
        by smtp.googlemail.com with ESMTPSA id r18-20020a1709063d7200b0076ff600bf2csm3342945ejf.63.2022.10.26.12.01.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 12:01:12 -0700 (PDT)
From:   =?UTF-8?q?Eray=20Or=C3=A7unus?= <erayorcunus@gmail.com>
To:     platform-driver-x86@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        ike.pan@canonical.com, jikos@kernel.org,
        benjamin.tissoires@redhat.com, dmitry.torokhov@gmail.com,
        hdegoede@redhat.com, mgross@linux.intel.com,
        =?UTF-8?q?Eray=20Or=C3=A7unus?= <erayorcunus@gmail.com>
Subject: [PATCH 3/6] platform/x86: ideapad-laptop: Report KEY_CAMERA_ACCESS_TOGGLE instead of KEY_CAMERA
Date:   Wed, 26 Oct 2022 22:01:03 +0300
Message-Id: <20221026190106.28441-4-erayorcunus@gmail.com>
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

Reporting KEY_CAMERA when pressing camera switch key is wrong, since
KEY_CAMERA is supposed to be used for taking snapshot. Change it with
KEY_CAMERA_ACCESS_TOGGLE, so user-space can act correctly.

This patch needs KEY_CAMERA_ACCESS_TOGGLE to be defined, thus depends on
"HID: add mapping for camera access keys" patch.

Signed-off-by: Eray Orçunus <erayorcunus@gmail.com>
---
 drivers/platform/x86/ideapad-laptop.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/x86/ideapad-laptop.c b/drivers/platform/x86/ideapad-laptop.c
index b67bac457a7a..0ef40b88b240 100644
--- a/drivers/platform/x86/ideapad-laptop.c
+++ b/drivers/platform/x86/ideapad-laptop.c
@@ -1038,7 +1038,7 @@ static void ideapad_sysfs_exit(struct ideapad_private *priv)
  */
 static const struct key_entry ideapad_keymap[] = {
 	{ KE_KEY,   6, { KEY_SWITCHVIDEOMODE } },
-	{ KE_KEY,   7, { KEY_CAMERA } },
+	{ KE_KEY,   7, { KEY_CAMERA_ACCESS_TOGGLE } },
 	{ KE_KEY,   8, { KEY_MICMUTE } },
 	{ KE_KEY,  11, { KEY_F16 } },
 	{ KE_KEY,  13, { KEY_WLAN } },
-- 
2.34.1

