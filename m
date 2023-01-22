Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7970B6771B3
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Jan 2023 20:05:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230352AbjAVTEw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Jan 2023 14:04:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229973AbjAVTEv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jan 2023 14:04:51 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8775F14232
        for <linux-kernel@vger.kernel.org>; Sun, 22 Jan 2023 11:04:49 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id q8so7518016wmo.5
        for <linux-kernel@vger.kernel.org>; Sun, 22 Jan 2023 11:04:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vjX43rGiHTLLu1gNJKLjMGmXXpo9MixBIEws6KA48Zk=;
        b=KwknTp9fBd/1S8b1HAtKxyj0kvD3asDcJpnR41aJ0eXqEYm/avrN7x+MHjWyM0pyFe
         NMn47cpaGrgLZYbKy963i4pFVeiH6v4RFMyq18G/HtlD0CwTiOHN9pTwIIIxFRXU1Wv0
         D8MOWzDzXehfDJfWo7n6MipVLw8YvbphJe7UvYG6f9bJm8HKfK95VwEwrcfaDiwOo6R3
         2OlLxQyk3zgvgkbqUkZ29MCTx4GmCm9oCxG75lxQRELIWeI5qii7xyBRsGndF6Sqdf5Q
         NEhkrGLOQHEi8YGVm9qde4ffTCuz/U13rSEbTNyeU1fFKtI8ExP1UEg8nFDXfCGK3upq
         k7kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vjX43rGiHTLLu1gNJKLjMGmXXpo9MixBIEws6KA48Zk=;
        b=zginAtJBiZ//G2pG35AWHH3XAjub9dbNKzgmtS+m2bocHOHgJKGOtMzsE3tqzAaub2
         UmiEOxawuQvOPKqzx1LeTtuZlAvDW3JQiZ3roWhJKc+DUrOoa4cnorSJw8RSD3AGFwo+
         fuatgqXKp3YkiDySX0Lkp4PqQ0WEah+/eXHaMCnWCLMxYG5d0qklFDlW8PMgkAEKrz5G
         yHoHHQpyhGjLsqWfO0Kbupu0+Ur6M/pwKrkhh6Da5Qdo4t0geVJoorKonQEUctxqElVj
         3JEfEEn0V9COwuuRB9+ARXs4PDrjhC0EHcTqr+/ZBt+KljITjqUUa1F9eJeN8M53/qMO
         hwKA==
X-Gm-Message-State: AFqh2koExKnKGdhbETqr3vI9fzEK8XIitfrk2o2NCukwvQ9RqhIYsM5d
        td4LpbIQpT370nu4aocjy4ni4BO9ggw=
X-Google-Smtp-Source: AMrXdXtUfJvHKpVzjnsfHSk/A/aUHlKkKHnXzjO8pPTd1vnjt3QYjaf0OsjUXcMl9MVbrhq1McRLPA==
X-Received: by 2002:a05:600c:4395:b0:3da:2829:2935 with SMTP id e21-20020a05600c439500b003da28292935mr21344940wmn.11.1674414287643;
        Sun, 22 Jan 2023 11:04:47 -0800 (PST)
Received: from ALPER-C340.. ([178.233.178.185])
        by smtp.gmail.com with ESMTPSA id f23-20020a7bc8d7000000b003d1f3e9df3csm8718123wml.7.2023.01.22.11.04.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Jan 2023 11:04:47 -0800 (PST)
From:   Alper Nebi Yasak <alpernebiyasak@gmail.com>
To:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Brian Norris <briannorris@chromium.org>,
        Wei-Ning Huang <wnhuang@chromium.org>,
        Samuel Holland <samuel@sholland.org>,
        Julius Werner <jwerner@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Alper Nebi Yasak <alpernebiyasak@gmail.com>
Subject: [PATCH] firmware: coreboot: framebuffer: Ignore reserved pixel color bits
Date:   Sun, 22 Jan 2023 22:04:31 +0300
Message-Id: <20230122190433.195941-1-alpernebiyasak@gmail.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The coreboot framebuffer doesn't support transparency, its 'reserved'
bit field is merely padding for byte/word alignment of pixel colors [1].
When trying to match the framebuffer to a simplefb format, the kernel
driver unnecessarily requires the format's transparency bit field to
exactly match this padding, even if the former is zero-width.

Due to a coreboot bug [2] (fixed upstream), some boards misreport the
reserved field's size as equal to its position (0x18 for both on a
'Lick' Chromebook), and the driver fails to probe where it would have
otherwise worked fine with e.g. the a8r8g8b8 or x8r8g8b8 formats.

Remove the transparency comparison with reserved bits. When the
bits-per-pixel and other color components match, transparency will
already be in a subset of the reserved field. Not forcing it to match
reserved bits allows the driver to work on the boards which misreport
the reserved field. It also enables using simplefb formats that don't
have transparency bits, although this doesn't currently happen due to
format support and ordering in linux/platform_data/simplefb.h.

[1] https://review.coreboot.org/plugins/gitiles/coreboot/+/4.19/src/commonlib/include/commonlib/coreboot_tables.h#255
[2] https://review.coreboot.org/plugins/gitiles/coreboot/+/4.13/src/drivers/intel/fsp2_0/graphics.c#82

Signed-off-by: Alper Nebi Yasak <alpernebiyasak@gmail.com>
---

 drivers/firmware/google/framebuffer-coreboot.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/firmware/google/framebuffer-coreboot.c b/drivers/firmware/google/framebuffer-coreboot.c
index c6dcc1ef93ac..c323a818805c 100644
--- a/drivers/firmware/google/framebuffer-coreboot.c
+++ b/drivers/firmware/google/framebuffer-coreboot.c
@@ -43,9 +43,7 @@ static int framebuffer_probe(struct coreboot_device *dev)
 		    fb->green_mask_pos     == formats[i].green.offset &&
 		    fb->green_mask_size    == formats[i].green.length &&
 		    fb->blue_mask_pos      == formats[i].blue.offset &&
-		    fb->blue_mask_size     == formats[i].blue.length &&
-		    fb->reserved_mask_pos  == formats[i].transp.offset &&
-		    fb->reserved_mask_size == formats[i].transp.length)
+		    fb->blue_mask_size     == formats[i].blue.length)
 			pdata.format = formats[i].name;
 	}
 	if (!pdata.format)
-- 
2.39.0

