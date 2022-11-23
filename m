Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85870634F5A
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 06:09:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235640AbiKWFJf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 00:09:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235594AbiKWFJd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 00:09:33 -0500
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CF99E677D
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 21:09:30 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id r8so9589170ljn.8
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 21:09:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=c6EZVPCQ9tYvPlxmBB/8m8JgKohGYoHP0VzzYsSGdlI=;
        b=S3Dabdu626OdzBwUkfqoYTqYhEoBtgm5x1FuSW6NTc4b2Q4ahc5Itud+7lRAd9JPTB
         lXG2Hv9jeWcgWkPP0PI0XWoUbPb8qPCUgOKw/sjsN6acTd2gtUedDc1ToeXsAyYg3ZBD
         aPlVW1UTxgMUpftDOt4caqI5mLdlTT2luq68qjCaQN+I+JBYn+sdelcc42Sojz8u1bk0
         s+Ydqwv7v5K+V9KkFh9lQIFW4oox3IFKEgY96eUKA8mXdjIqH659Nmi0GYW8faysq1IA
         1hpvkBwEriwIvo5IPxllybzYrfnbUIDczGprXlMDVFtLNfWdcXXOuZVhLxS8G3H5YhX5
         AH6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c6EZVPCQ9tYvPlxmBB/8m8JgKohGYoHP0VzzYsSGdlI=;
        b=nUJm4USm83i/68ASE3c04gFBi/ueytCJONx5+8ghXgaszD3ljOrbQdG6YPHDOOjbCR
         gYuVj6MV+coyl39KWnK2KHlhNXHRfhoEMbjOXfyjRoW+3/vDqGUONQ0/tLGMo4xreccq
         L5drDnlV9nBsvinFRZe8nO2B80ZkWxTT772+kQOhz8D2oZBZUtB6RjCY4Tcx1L1isY1u
         q1gjlR6iQqmjR/1BNnYLI61GmYas83PMmKoZNhLbOHWS6LMlJQhKs1Jth3NL+UAFbZXI
         tFISjv03yARuBGuL/Q08ooFACUovv3govcJK09TVQbbh7SnliE4vlMEcQmemscJprV1u
         C5Tg==
X-Gm-Message-State: ANoB5pnhFZ39M1qMTQQadWBDzsrYO+jSgnpjEHle75Rui9uaGJXxzAnu
        oIwx6eyGxWQ5e4exg7Xh/0s=
X-Google-Smtp-Source: AA0mqf6v15Z9YHPKylkspRS0gTHNHxtUVA6nL2db3RnaeACzrDh2ivO0e+tXmY3F0cHWqQdxucpzhQ==
X-Received: by 2002:a2e:9dcf:0:b0:279:70ee:571e with SMTP id x15-20020a2e9dcf000000b0027970ee571emr1834692ljj.249.1669180168295;
        Tue, 22 Nov 2022 21:09:28 -0800 (PST)
Received: from localhost.localdomain ([2.56.241.21])
        by smtp.gmail.com with ESMTPSA id z6-20020a05651c022600b00277045dcb5bsm2087065ljn.97.2022.11.22.21.09.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Nov 2022 21:09:27 -0800 (PST)
From:   Xiaolong Huang <butterflyhuangxx@gmail.com>
To:     perex@perex.cz, tiwai@suse.com, baolin.wang@linux.alibaba.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Xiaolong Huang <butterflyhuangxx@gmail.com>
Subject: [RESEND PATCH] ALSA: rawmidi: fix infoleak in snd_rawmidi_ioctl_status_compat64
Date:   Wed, 23 Nov 2022 13:09:11 +0800
Message-Id: <20221123050911.1045190-1-butterflyhuangxx@gmail.com>
X-Mailer: git-send-email 2.25.1
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

The compat_status is declared off of the stack, so it needs to
be zeroed out before copied back to userspace to prevent any
unintentional data leakage.

Fixes: d9e5582c4bb2 ("ALSA: Avoid using timespec for struct snd_rawmidi_status")
Signed-off-by: Xiaolong Huang <butterflyhuangxx@gmail.com>

---

Reason for resend:
1. add Fixes line.
---
 sound/core/rawmidi_compat.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/core/rawmidi_compat.c b/sound/core/rawmidi_compat.c
index 68a93443583c..6afa68165b17 100644
--- a/sound/core/rawmidi_compat.c
+++ b/sound/core/rawmidi_compat.c
@@ -80,6 +80,7 @@ static int snd_rawmidi_ioctl_status_compat64(struct snd_rawmidi_file *rfile,
 	if (err < 0)
 		return err;
 
+	memset(&compat_status, 0, sizeof(compat_status));
 	compat_status = (struct compat_snd_rawmidi_status64) {
 		.stream = status.stream,
 		.tstamp_sec = status.tstamp_sec,

base-commit: eb7081409f94a9a8608593d0fb63a1aa3d6f95d8
-- 
2.25.1

