Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C656644752
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 16:01:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235163AbiLFPBF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 10:01:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234414AbiLFPAo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 10:00:44 -0500
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F240831213
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 06:53:42 -0800 (PST)
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4NRNhN3NNkz9sR3;
        Tue,  6 Dec 2022 15:53:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
        t=1670338404;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=4NLTs1EBMlQbCcgVeNihmV7lwEP6dQdXCJdw5AJKbsc=;
        b=ub64oIL02hDbOUKdpEWA3zx3VHi90Q5ttNOH0GJAnCq5ePEGdQ9pKTBByPbx7pmoo2toBS
        FnFIi65KBbE55L0L9x+w+qdkgZviA+MlR8SwQp6Qth1DkkbidGjvdrWCNsyotO+k34Q33m
        e3jKhgeaXuELhxO5SZUAN6AaQZGI7bgSwEI/o+88WGS3opMfmGRQYaFJbVIIEbQqlP8Jmj
        GP43cbCUOYDe0meD+SW5XAnd1cg5PLvOuzbDZs4vCaG1LMS/g8cZJHWysP7S3f1IEKO4xQ
        Evm1uBf/WHxB/JZGXDFSRSAssh8UC9aF9QR5JPjS+FfCxCb++DK/HHFfQpYYvA==
From:   Carlos Rafael Giani <crg7475@mailbox.org>
To:     Vinod Koul <vkoul@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ALSA: compress: Add AC3, EAC3, TrueHD, DTS, MPEG-H 3D Audio Stream (MHAS)
Date:   Tue,  6 Dec 2022 15:53:17 +0100
Message-Id: <20221206145317.99934-1-crg7475@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 52f4f053256e4590c5a
X-MBO-RS-META: nboczzk1n7697gwjxge8w453m4nnrn8e
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These audio codecs are used in sound bars and digital TVs, and benefit
from off-loading to a DSP. In particular, Dolby Atmos and MPEG-H 3D audio
spatialization is done in dedicated DSPs. Thus, adding these codecs  to
the Compress-Offload API makes sense.

Signed-off-by: Carlos Rafael Giani <crg7475@mailbox.org>
---
 include/uapi/sound/compress_params.h | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/include/uapi/sound/compress_params.h b/include/uapi/sound/compress_params.h
index ddc77322d571..7a58e2026be3 100644
--- a/include/uapi/sound/compress_params.h
+++ b/include/uapi/sound/compress_params.h
@@ -43,7 +43,13 @@
 #define SND_AUDIOCODEC_BESPOKE               ((__u32) 0x0000000E)
 #define SND_AUDIOCODEC_ALAC                  ((__u32) 0x0000000F)
 #define SND_AUDIOCODEC_APE                   ((__u32) 0x00000010)
-#define SND_AUDIOCODEC_MAX                   SND_AUDIOCODEC_APE
+#define SND_AUDIOCODEC_AC3                   ((__u32) 0x00000011)
+#define SND_AUDIOCODEC_EAC3                  ((__u32) 0x00000012)
+#define SND_AUDIOCODEC_TRUEHD                ((__u32) 0x00000013)
+#define SND_AUDIOCODEC_DTS                   ((__u32) 0x00000014)
+/* MPEG-H 3D Audio Stream (MHAS) as defined in ISO/IEC 23008-3 */
+#define SND_AUDIOCODEC_MHAS                  ((__u32) 0x00000015)
+#define SND_AUDIOCODEC_MAX                   SND_AUDIOCODEC_MHAS
 
 /*
  * Profile and modes are listed with bit masks. This allows for a
-- 
2.34.1

