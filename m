Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12CD3634531
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 21:09:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234585AbiKVUJP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 15:09:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234718AbiKVUJC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 15:09:02 -0500
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7A5EAFE73
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 12:08:55 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id x21so19127860ljg.10
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 12:08:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sXUW0a6Ff8psj/R6aZYguKr5STKCT04i6o2Czkyr1nI=;
        b=cl6HAHsy3tjvvd4e4yK9SmzUE3tr+Gk6oNXpZw1qroE9OvLHrPAkJ7i2yJ+gyYrynr
         3nX7GZat+e7v8Oj4Vj5/OxigiF2xNhYpwoB+U5NNn6egDKIc+cDavlJAOsqJirmlSJEa
         nVIVPLrOE00b08L3kFOA5w2X1R8VJ1YNfdJlvEzThE9ofWGO8evDtb9tN7+pK5o/qBYu
         Kj+VbqfXpOdWcrsoELjgX75ZRqLsxHvx/bcIjL7YNio+fE6TubHnAZa4g41q3X66KGO1
         QM7EW+XeC2wdPzk5axmFu5e1KNzER+wDJcPqEz9RNjVlMDLBChG0M8HeYiugMbbUqklA
         CAWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sXUW0a6Ff8psj/R6aZYguKr5STKCT04i6o2Czkyr1nI=;
        b=p72AbCs3okB7HpNaWnA8c29oOkeJIrlit/u6JE/v59ob8U9D9y3eneQbhn1nyMQReW
         QkpLkaVjO6xFCxUMtTzdYAsh7fXWPJ6woaD9t5de5hrKDSHhUpeHTKdMey1b2aM0i5Kx
         t7bCNLvSPp2Qouh5m2WmxvM00/hyTdQa3ti2gdLEEIHdbgOevdjI1rUNOjqc3Fq2LRAb
         7IH/u1gB3l6lC1GKux2PoFMQMEcEdprrVHoqqmVk48YV6asMWeiRUTbE92lxQ4zHSJ8L
         AC0L+5LrH78iY1Ad6ZFj9ibPm2MI3srA6ImyLv/rwHL/8CGzgVtiNZGdY/BkpiWGTWXT
         /vqg==
X-Gm-Message-State: ANoB5pk2ucz9I51cwT7l/NZsXXHlWH55In3MNpBqMhYsNCJ5b8HxMbuz
        amXFvE16yVno3TUvp4PbmNLOvsl2Y8DOXWdy
X-Google-Smtp-Source: AA0mqf7+Auws5Fe5VM1larsYdpz+GpM8nruuKW0Ba5lB/mRlJZvW4hmmdtILhMBj0v/rBA9j/qikLQ==
X-Received: by 2002:a2e:be04:0:b0:267:9d30:5ba with SMTP id z4-20020a2ebe04000000b002679d3005bamr7874525ljq.284.1669147734075;
        Tue, 22 Nov 2022 12:08:54 -0800 (PST)
Received: from localhost.localdomain ([2.56.241.21])
        by smtp.gmail.com with ESMTPSA id z19-20020a056512371300b004b4e6dab30esm59977lfr.222.2022.11.22.12.08.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Nov 2022 12:08:53 -0800 (PST)
From:   Xiaolong Huang <butterflyhuangxx@gmail.com>
To:     perex@perex.cz, tiwai@suse.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Xiaolong Huang <butterflyhuangxx@gmail.com>
Subject: [PATCH] ALSA: rawmidi: fix infoleak in snd_rawmidi_ioctl_status_compat64
Date:   Wed, 23 Nov 2022 04:08:41 +0800
Message-Id: <20221122200841.1026335-1-butterflyhuangxx@gmail.com>
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

Signed-off-by: Xiaolong Huang <butterflyhuangxx@gmail.com>
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

