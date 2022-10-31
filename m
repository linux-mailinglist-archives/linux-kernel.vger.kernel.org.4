Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B768E613A9F
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 16:46:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232073AbiJaPqs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 11:46:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232111AbiJaPq0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 11:46:26 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CBC412622;
        Mon, 31 Oct 2022 08:45:41 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id g12so16541784wrs.10;
        Mon, 31 Oct 2022 08:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jW9IKMkrwnv8caV3EediNMrHaLVLZBieoUiYwGCU4PE=;
        b=KKmB0DGcZWtPLN1qqTvlJ82KQk+VFukr6lTzvoP8dBu62ijXeqQ0SRZ3DryazJEOqV
         a3EyuQ6jwnlfCRaX/NXf0amyH4mrIvqetF5ake1u1cAO7GIa1J2mpvt9WKiIALGI3+bf
         xkJo00sJ2ZlQm5MhaNKaeuvR2RJtedV05ZcitXiIFgZck7T1COnRrRk+BwmDzPPFauu0
         EPvUsXJnM7Vq6FeDuzCEjK+fZQkSaNSMPbuVnwWBg0IiCueWSUJRaRxu4jz8s0wPRamO
         aXp9CAa9qO1o83/yfzDHYbXMRLFeJJ+vbUG+5GwHHudl+yeszHWKqOG/nMADEKc6gHGb
         19Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jW9IKMkrwnv8caV3EediNMrHaLVLZBieoUiYwGCU4PE=;
        b=A19ADbhIiKA6IZAZ7Z0v2A7sRa4rUvIZJ3mtZMqRmaz8+JQuaz1gkpxwFosB4gfPWx
         YJWtZSbSSFIn3AE8kfJhUu1ew6UKfQ090uEyI0Qj0byz+LownDPTOoRs6NEwD3OLhB2H
         GLCVrUgBwby+KSqYcMJpbwAQ21ot8c0wisV2NiITGBwQ6F9iUe/y+EE+Cy7AR0QPwhP9
         Cxx0+Ob+8c6nUHN6hDWqCLQTh56AsuldwUJ7VYKlFshbM87xNgVfJ604Yyg+vIs552Y9
         pgLz16f15Gy6a6SJjr2jIPGU3JAlFr/PcVZZMVk/xx8dR08V476yFeQKTehhS45SFYJt
         9RCg==
X-Gm-Message-State: ACrzQf2ZE9jYu5WnphVKwYDKosqXUZQ1sSkjnhuu32dIH51BXNI0zIua
        zzU5Eoqmi3Po3vF44P0E9mU=
X-Google-Smtp-Source: AMsMyM7BxLgxeYDm8Qnj64xFHPvDELJnxRgCP4L09ApkN5KIkVPuyWWJ6CM7zaZrHDcZlUtN4rLHjQ==
X-Received: by 2002:adf:f386:0:b0:236:6e8c:f5bb with SMTP id m6-20020adff386000000b002366e8cf5bbmr8279240wro.587.1667231139606;
        Mon, 31 Oct 2022 08:45:39 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id p11-20020a05600c468b00b003cf75213bb9sm2183194wmo.8.2022.10.31.08.45.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 08:45:39 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Sathya Prakash <sathya.prakash@broadcom.com>,
        Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
        Suganath Prabu Subramani 
        <suganath-prabu.subramani@broadcom.com>,
        MPT-FusionLinux.pdl@broadcom.com, linux-scsi@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] scsi: message: fusion: remove variable 'where'
Date:   Mon, 31 Oct 2022 15:45:38 +0000
Message-Id: <20221031154538.870223-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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

Variable where is just being incremented and it's never used
anywhere else. The variable and the increment are redundant so
remove it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/message/fusion/mptctl.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/message/fusion/mptctl.c b/drivers/message/fusion/mptctl.c
index 52c7020c9d19..1decd09a08d8 100644
--- a/drivers/message/fusion/mptctl.c
+++ b/drivers/message/fusion/mptctl.c
@@ -2879,7 +2879,6 @@ static struct mpt_pci_driver mptctl_driver = {
 static int __init mptctl_init(void)
 {
 	int err;
-	int where = 1;
 
 	show_mptmod_ver(my_NAME, my_VERSION);
 
@@ -2898,7 +2897,6 @@ static int __init mptctl_init(void)
 	/*
 	 *  Install our handler
 	 */
-	++where;
 	mptctl_id = mpt_register(mptctl_reply, MPTCTL_DRIVER,
 	    "mptctl_reply");
 	if (!mptctl_id || mptctl_id >= MPT_MAX_PROTOCOL_DRIVERS) {
-- 
2.37.3

