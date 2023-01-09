Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC17B6633FB
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 23:32:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235148AbjAIWbm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 17:31:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237597AbjAIWbg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 17:31:36 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B4C86388;
        Mon,  9 Jan 2023 14:31:35 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id vm8so23949040ejc.2;
        Mon, 09 Jan 2023 14:31:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OZe8VJu/fGCCz+Eb3NiW7mLJBs19t4YWlgg0ulzutFw=;
        b=GSLrukwN25auhR2Y9tG2IvbfkBqYNzBDfNQWqdjB7K51f6ZiksEJtgxejWerw/vsf2
         HNWduMWWXpqKrNtgR6PFRro4ZZuKOB98gyrC/XFdBUmrPVrcv2jCc5s8rehfL+LPZnU8
         MhNevobZTxfeKXIkbrB9LqAJhC1d31Q9hYmQa0UajkdpAndEzKp9/kk+VJPF37zNwxK9
         7CIpcKX9PdMjk/cq6i4TfyNgl+KglhAwRLcAZ5vKtBOfHjgaes3vVDty0R4aPtkYxq41
         5ccz1Ju28ipPWVxiOHMN+CyD54l+blvQ2kfCJ0seUSKRkZAfOP58voelxFXZBm6Oy9XM
         jb3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OZe8VJu/fGCCz+Eb3NiW7mLJBs19t4YWlgg0ulzutFw=;
        b=Es1DLcczHNrBl2tL8WO+1OD/xxGHMqPMO9kUFJ/NvvLibKue+wiEn7eOnIOo5PdVZv
         SdUA+B4uSnzNhE0GHBIDOpOjGT5NRZpHhlC/myFMZxfwWVrKwbkQzaA2/yY7IkUm16uf
         pyWJmB3lCTiTzvDJ7N9iPB6hRZWvLnSy2Lnctq23NSkKK1NqQzWTQXk0CFZCdpfVNCbm
         hXsFhbVNJXArf6DHufxRgIbuIcHBf43/4o1Y/PvpMYhP4Sh7McmNN0QJzR2TDQ67xAdu
         lRYoOSUanTmuVZxXU9mSBCX9g9b03s03ef/2E4bvk1UKEx3tKXBxGcQs6l7suiBEbMuc
         VJ6g==
X-Gm-Message-State: AFqh2krc7u9UrN7p9Tjq3l53X1N8a6Clj9s+/7S6iwsgK6BXVwFRZ2Hy
        ttLhFm/Q/JKry3qETdMxVt329kWwLxQ=
X-Google-Smtp-Source: AMrXdXvpiCc8i3vWtwCmmEDeA46pFWN6Dz27By5UAtP+wRO7CW2CRYa8a71xhMAms7AZC6iBTAbe0Q==
X-Received: by 2002:a17:906:b043:b0:7c0:d23c:ead3 with SMTP id bj3-20020a170906b04300b007c0d23cead3mr58284154ejb.27.1673303493935;
        Mon, 09 Jan 2023 14:31:33 -0800 (PST)
Received: from localhost.localdomain (dynamic-2a01-0c23-bcd2-ed00-0000-0000-0000-0e63.c23.pool.telefonica.de. [2a01:c23:bcd2:ed00::e63])
        by smtp.googlemail.com with ESMTPSA id k8-20020a17090632c800b00780982d77d1sm4228235ejk.154.2023.01.09.14.31.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 14:31:33 -0800 (PST)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Helge Deller <deller@gmx.de>, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Hans Verkuil <hans.verkuil@cisco.com>,
        ville.syrjala@linux.intel.com,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Bernard Zhao <bernard@vivo.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v1 RFC] video/hdmi: Fix HDMI_VENDOR_INFOFRAME_SIZE
Date:   Mon,  9 Jan 2023 23:31:10 +0100
Message-Id: <20230109223110.1165433-1-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.39.0
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

When support for the HDMI vendor infoframe was introduced back with
commit 7d27becb3532 ("video/hdmi: Introduce helpers for the HDMI vendor
specific infoframe") it's payload size was either 5 or 6 bytes,
depending on:
  if (frame->s3d_struct >= HDMI_3D_STRUCTURE_SIDE_BY_SIDE_HALF)
When true the size was 6 bytes, otherwise 5 bytes.

Drivers that are using hdmi_infoframe_pack() are reserving 10 bytes (4
bytes for the header and up to 6 bytes for the infoframe payload data)
or more (exynos_hdmi reserves 25 bytes).

Over time the frame payload length was reduced to 4 bytes. This however
does not match the code from hdmi_hdmi_infoframe_pack() where ptr[8] and
ptr[9] are written, which means the infoframe has to allow up to 6 bytes
of payload data (considering that the header takes 4 bytes).

Change HDMI_VENDOR_INFOFRAME_SIZE to 6 bytes so
hdmi_vendor_infoframe_pack_only() can properly check the passed buffer
size and avoid an out of bounds write to ptr[8] or ptr[9].

Fixes: c5e69ab35c0d ("video/hdmi: Constify infoframe passed to the pack functions")
Fixes: d43be2554b58 ("drivers: video: hdmi: cleanup coding style in video a bit")
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
I'm not an expert on this topic and I'm not sure if the size still
depends on that if condition from long time ago. So please share your
thoughts.


 include/linux/hdmi.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/hdmi.h b/include/linux/hdmi.h
index 2f4dcc8d060e..026c5ef5a1a5 100644
--- a/include/linux/hdmi.h
+++ b/include/linux/hdmi.h
@@ -57,7 +57,7 @@ enum hdmi_infoframe_type {
 #define HDMI_SPD_INFOFRAME_SIZE    25
 #define HDMI_AUDIO_INFOFRAME_SIZE  10
 #define HDMI_DRM_INFOFRAME_SIZE    26
-#define HDMI_VENDOR_INFOFRAME_SIZE  4
+#define HDMI_VENDOR_INFOFRAME_SIZE  6
 
 #define HDMI_INFOFRAME_SIZE(type)	\
 	(HDMI_INFOFRAME_HEADER_SIZE + HDMI_ ## type ## _INFOFRAME_SIZE)
-- 
2.39.0

