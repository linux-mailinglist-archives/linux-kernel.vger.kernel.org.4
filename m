Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 940306697A9
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 13:47:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241803AbjAMMqP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 07:46:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242017AbjAMMoU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 07:44:20 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3577F1C13F
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 04:36:30 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id az20so32929547ejc.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 04:36:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T5KT6Auu94HJGq65sn5VmhXW8yJRnWzEtldTHa29AT0=;
        b=iEvtkhCXslE72xJ4rRq1o4dPaZjuX9JLsa7ypmZFDHZvO1spA7qgOqdlMIgNqmOd4Q
         BmnYm1AreZ0f08H6qA5zzq1vhit1vtTePd21UHj1cHFD1HjWkkgvd6vUd0NYq3Flo4tW
         PU4z44ieH6GRE99WOpB7LDRHJPfdP/JK0iDdurBhlgpJdztFtfu1wNuJqycRTt4DfmwJ
         DKQGPJsW0QdNBPlwzpGCReJQBTQGz5fJbIzvrcijgWMbeBy62bZDqSBq0eYILOugbfBK
         POQt3cU00BEvXOTS6Px7H7/seYT2YAjrwmY0BkAOAChZsa+VBCMGVy2V6DjUXPacBhb7
         5YvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T5KT6Auu94HJGq65sn5VmhXW8yJRnWzEtldTHa29AT0=;
        b=U+vaQtoFLsOBcgZvVSV+xkVhzPpp5gz3ZxZecd95K6ELuBL71r3dFsh+Nde5aEE/5l
         idt3ERKGxaxae32+iJ9HCqb0bIyCksTKuZ1rhspiImOWaCb3OdmS9FMGACSFgXTP5liu
         fZswv5+cPJVJi/e7T0kA+7NZGf7Q/McoyhaxRQtkpWf9pW9KWivPnhxaR5PNOvoM0QIX
         Wmeul1gPB+xf2HJ+iZ55+CEGznEoeOXGKUZU3ektcBBz7OAPUf+Ld/FPBga9dtfnh+rA
         w6co/xAOrP5Xo5lU6r2ZZGhOy9kBenRQC3RHXdfZfRLFu+LOstGDUGrI2x/2mKGtckHI
         Ju8Q==
X-Gm-Message-State: AFqh2koyWEUb+FOwk90tu7DdJ27lWxsZep3pQoTCMyoQxafbjovlzFCI
        JbHGkz5BdT3Qjkp+14qY+0llTw==
X-Google-Smtp-Source: AMrXdXv2f3WJ7TxaCpga5NoHE+9yIqEbHRcFtx8jGKJkLWIR0zf6tV2L+T7DlJE4PxvQYKOiiXMw5A==
X-Received: by 2002:a17:907:7f12:b0:7c1:9eb:845b with SMTP id qf18-20020a1709077f1200b007c109eb845bmr3841305ejc.16.1673613348224;
        Fri, 13 Jan 2023 04:35:48 -0800 (PST)
Received: from localhost.localdomain (h082218028181.host.wavenet.at. [82.218.28.181])
        by smtp.gmail.com with ESMTPSA id 17-20020a170906329100b007c0bb571da5sm8402496ejw.41.2023.01.13.04.35.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 04:35:47 -0800 (PST)
From:   =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= 
        <christoph.boehmwalder@linbit.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     drbd-dev@lists.linbit.com, linux-kernel@vger.kernel.org,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        linux-block@vger.kernel.org,
        =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= 
        <christoph.boehmwalder@linbit.com>
Subject: [PATCH 7/8] drbd: interval tree: make removing an "empty" interval a no-op
Date:   Fri, 13 Jan 2023 13:35:37 +0100
Message-Id: <20230113123538.144276-8-christoph.boehmwalder@linbit.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230113123538.144276-1-christoph.boehmwalder@linbit.com>
References: <20230113123538.144276-1-christoph.boehmwalder@linbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lars Ellenberg <lars.ellenberg@linbit.com>

Trying to remove an "empty" (just initialized, or "cleared") interval
from the tree, this results in an endless loop.

As we typically protect the tree with a spinlock_irq,
the result is a hung system.

Be nice to error cleanup code paths, ignore removal of empty intervals.

Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>
Signed-off-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>
---
 drivers/block/drbd/drbd_interval.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/block/drbd/drbd_interval.c b/drivers/block/drbd/drbd_interval.c
index 5024ffd6143d..b6aaf0d4d85b 100644
--- a/drivers/block/drbd/drbd_interval.c
+++ b/drivers/block/drbd/drbd_interval.c
@@ -95,6 +95,10 @@ drbd_contains_interval(struct rb_root *root, sector_t sector,
 void
 drbd_remove_interval(struct rb_root *root, struct drbd_interval *this)
 {
+	/* avoid endless loop */
+	if (drbd_interval_empty(this))
+		return;
+
 	rb_erase_augmented(&this->rb, root, &augment_callbacks);
 }
 
-- 
2.38.1

