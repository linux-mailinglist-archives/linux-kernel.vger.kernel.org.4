Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 708A6624899
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 18:49:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230258AbiKJRtb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 12:49:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231268AbiKJRt0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 12:49:26 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F06E2303D1;
        Thu, 10 Nov 2022 09:49:22 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id z14so3352984wrn.7;
        Thu, 10 Nov 2022 09:49:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=thGe8bZx3s7qyOvNmBFIp26dCpE+t2vRJmjbPbSwWv0=;
        b=ONWFwgQtbmGHXBn7m4CDmFUN8u4iYggFrjuIAlbFOjpj9pX4+79TmwMN2eKg8UdiCK
         ZXlfmQgGh0kEVLd7LkfPivlGNcY+JMflMpXi76UbNuyyXOKbBjAWQWa79psuAnkZZM2r
         bJ4lDirw7RSEe8J6otLMxkYPdadH/P2Vf/59UGVOOwBuL2b914/n9bSeSkl/lxggFlYO
         N9ktFPDAqFXnEsGPSNUfDQfU2mONd9JSnBG0/Yfd3jSWSMRZRESpbwALySPnYjOqRL9X
         BEfnlrIWJx0RJePuWL+k8SOtJGvQQcNnqojPV0oAlLrgkzbKn6sIa4zKZzIrHYAeGOSd
         mnww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=thGe8bZx3s7qyOvNmBFIp26dCpE+t2vRJmjbPbSwWv0=;
        b=QsfP1lbCp/M2mczOry+b826vyyG+AsEjDuPm2pDGIWjgNIHfvHiQuvKZyz5LyGG5Su
         sctNLrGBHd+RQ/82gPIW17rqBZsLe4tRVQYUUt5UvZ7C1FL9Vx65lr2I1rEDxlMU3P5j
         2ttqbHj3Bj2BDW0OkpRpiXgUP2JXMhdrnN1LVZ8uybBhhnFW1XlP+Qjj8xOvYzTkFXdv
         9IaokHUyeKjRIPrEAi6+ikkMF/acWYVHv/8F/jxUsBqkDowPYCsEFae8aiKzbzCmSI8W
         lvMpv8MwfdD+KmLWN6zIdVntebt471XrfpQ94XNhYxX8b/+j1vrd9gTcuquD+jVzv1mJ
         57WA==
X-Gm-Message-State: ACrzQf04e4ZoXsMIx4aauY1X1dhswe25x9aCsZPBY20CpR3sz3L1vWkn
        RH0U09EUCjXmafCBubwkahU=
X-Google-Smtp-Source: AMsMyM7GOFqvbSex/OjoybeLzzYGUl8kDvi3szHgtgktjtIQunMzp0PmBnsxDKIvxRCGQ7kwzouBpw==
X-Received: by 2002:adf:f78f:0:b0:236:992b:1f62 with SMTP id q15-20020adff78f000000b00236992b1f62mr40767234wrp.605.1668102561570;
        Thu, 10 Nov 2022 09:49:21 -0800 (PST)
Received: from localhost.localdomain ([94.73.35.109])
        by smtp.gmail.com with ESMTPSA id z9-20020a5d6409000000b00228d67db06esm16438611wru.21.2022.11.10.09.49.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 09:49:21 -0800 (PST)
From:   =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To:     jikos@kernel.org
Cc:     benjamin.tissoires@redhat.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Subject: [PATCH] HID: uclogic: Fix frame templates for big endian architectures
Date:   Thu, 10 Nov 2022 18:49:18 +0100
Message-Id: <20221110174918.398567-1-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

When parsing a frame template with a placeholder indicating the number
of buttons present on the frame its value was incorrectly set on big
endian architectures due to double little endian conversion.

In order to reproduce the issue and verify the fix, run the HID KUnit
tests on the PowerPC architecture:

  $ ./tools/testing/kunit/kunit.py run --kunitconfig=drivers/hid \
    --arch=powerpc --cross_compile=powerpc64-linux-gnu-

Fixes: 867c89254425 ("HID: uclogic: Allow to generate frame templates")
Signed-off-by: José Expósito <jose.exposito89@gmail.com>
---
 drivers/hid/hid-uclogic-rdesc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/hid-uclogic-rdesc.c b/drivers/hid/hid-uclogic-rdesc.c
index 4bd54c4fb5b0..6b73eb0df6bd 100644
--- a/drivers/hid/hid-uclogic-rdesc.c
+++ b/drivers/hid/hid-uclogic-rdesc.c
@@ -1193,7 +1193,7 @@ __u8 *uclogic_rdesc_template_apply(const __u8 *template_ptr,
 			   p[sizeof(btn_head)] < param_num) {
 			v = param_list[p[sizeof(btn_head)]];
 			put_unaligned((__u8)0x2A, p); /* Usage Maximum */
-			put_unaligned_le16((__force u16)cpu_to_le16(v), p + 1);
+			put_unaligned((__force u16)cpu_to_le16(v), (s16 *)(p + 1));
 			p += sizeof(btn_head) + 1;
 		} else {
 			p++;
-- 
2.25.1

