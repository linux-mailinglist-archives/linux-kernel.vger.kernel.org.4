Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67FE76917B8
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 05:50:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230477AbjBJEue (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 23:50:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231255AbjBJEuV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 23:50:21 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A544E70976;
        Thu,  9 Feb 2023 20:50:19 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id v18-20020a17090ae99200b00230f079dcd9so7292512pjy.1;
        Thu, 09 Feb 2023 20:50:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y8Z+rw3Lo4ZI53HBYFrES/rZyYmIcMPWeV9Tjc6GjJE=;
        b=dfjrwZCUTXg0++zE/wVkz4Z96Dke9cdiJGPWOJx+bSbwOuQzxzamUP7h08RKQKxmci
         TJuBqsc+PY+NgKeBk1dK5ehjoB56e05oCGCVdL0fCqIdQhc0VEGhFat0cmuxanHzAMg0
         PkBLd+8yttsFpd3mZCaA1SzojWL4FcQ3HiMdQp77gFhOpZsKqeYz/jeR1LyHxN4YyLTb
         3ZMp1vTJystxqoDQUey6c9p8i3s2QjUBsSsvBZ5rfq9WUIORdJzIDSR0QALHgrjXZ77j
         ScTwjw3ohujsiuZkCI2r2hTPzZp/mGapCXYydIZhMspEsgiXfPGfK8D+y5YVUcqfbqEh
         3VYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y8Z+rw3Lo4ZI53HBYFrES/rZyYmIcMPWeV9Tjc6GjJE=;
        b=jzyqCXMdfqqldbbMaDXjAbBclEuq+Q2GFfGHnlNRWZmxZOvUV9UVGmHNrJ9rw4A0lO
         P0pzklApw8nOnwZNF3X1qQ95SFBTHj9nfG2zs75JYFVUYJ+uIM0GL0Qht7xkzBAdlqKR
         zvs0t/5g7ee/SIfs1csKFHCE4Uw0tIN1wnGCEE7TcS2vGOomh5z5TjzR511G1Ed/+agf
         qyu8exxrr0Hxt9A2tHXLqj3f/xrMHtd0z7OM6r+D9LdHha3cLop+4GMY26Ht9m36L2fh
         R5bZagYpdzrk3grulg2derfmEutmlfNfPawZCe/5KzyUrtSpspqpS64csSn6EQJzLLGl
         147w==
X-Gm-Message-State: AO0yUKX9xiCS9323PD74vqS4BA+ISIAdsl/XNU4jH3Hyqw9GtcgA8RqV
        JItGEcFJijPy+IOAOtLB9mkMwYASs6kVsw==
X-Google-Smtp-Source: AK7set/7KSbVgE9qkN7uNWue+wzw+pXkSmt+auWpnDKP9/ad63Y3Jn6uOO0PkG79K7jm7BGnaA7Ihg==
X-Received: by 2002:a05:6a21:339a:b0:bf:22ca:ef55 with SMTP id yy26-20020a056a21339a00b000bf22caef55mr17822193pzb.37.1676004618944;
        Thu, 09 Feb 2023 20:50:18 -0800 (PST)
Received: from localhost.localdomain ([202.53.32.211])
        by smtp.gmail.com with ESMTPSA id t13-20020a62ea0d000000b0057fec210d33sm2269218pfh.152.2023.02.09.20.50.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Feb 2023 20:50:18 -0800 (PST)
From:   Orlando Chamberlain <orlandoch.dev@gmail.com>
To:     platform-driver-x86@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Hawking Zhang <Hawking.Zhang@amd.com>,
        Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
        Lijo Lazar <lijo.lazar@amd.com>,
        YiPeng Chai <YiPeng.Chai@amd.com>,
        Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Bokun Zhang <Bokun.Zhang@amd.com>,
        Jack Xiao <Jack.Xiao@amd.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Rander Wang <rander.wang@intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>,
        Yong Zhi <yong.zhi@intel.com>, Evan Quan <evan.quan@amd.com>,
        Kerem Karabay <kekrby@gmail.com>,
        Aditya Garg <gargaditya08@live.com>,
        Aun-Ali Zaidi <admin@kodeit.net>,
        Orlando Chamberlain <orlandoch.dev@gmail.com>
Subject: [RFC PATCH 2/9] apple-gmux: consolidate version reading
Date:   Fri, 10 Feb 2023 15:48:19 +1100
Message-Id: <20230210044826.9834-3-orlandoch.dev@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230210044826.9834-1-orlandoch.dev@gmail.com>
References: <20230210044826.9834-1-orlandoch.dev@gmail.com>
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

Read gmux version in one go as 32 bits on both indexed and classic
gmux's.

Classic gmux's used to read the version as

major = inb(base + 0x4);
minor = inb(base + 0x5);
release = inb(base + 0x6);

but this can instead be done the same way as indexed gmux's with
gmux_read32(), so the same version reading code is used for classic
and indexed gmux's (as well as mmio gmux's that will be added to this
driver).

Signed-off-by: Orlando Chamberlain <orlandoch.dev@gmail.com>
---
 drivers/platform/x86/apple-gmux.c | 14 ++++++--------
 include/linux/apple-gmux.h        |  6 +-----
 2 files changed, 7 insertions(+), 13 deletions(-)

diff --git a/drivers/platform/x86/apple-gmux.c b/drivers/platform/x86/apple-gmux.c
index e8cb084cb81f..67628104f31a 100644
--- a/drivers/platform/x86/apple-gmux.c
+++ b/drivers/platform/x86/apple-gmux.c
@@ -580,15 +580,13 @@ static int gmux_probe(struct pnp_dev *pnp, const struct pnp_device_id *id)
 	if (indexed) {
 		mutex_init(&gmux_data->index_lock);
 		gmux_data->indexed = true;
-		version = gmux_read32(gmux_data, GMUX_PORT_VERSION_MAJOR);
-		ver_major = (version >> 24) & 0xff;
-		ver_minor = (version >> 16) & 0xff;
-		ver_release = (version >> 8) & 0xff;
-	} else {
-		ver_major = gmux_read8(gmux_data, GMUX_PORT_VERSION_MAJOR);
-		ver_minor = gmux_read8(gmux_data, GMUX_PORT_VERSION_MINOR);
-		ver_release = gmux_read8(gmux_data, GMUX_PORT_VERSION_RELEASE);
 	}
+
+	version = gmux_read32(gmux_data, GMUX_PORT_VERSION_MAJOR);
+	ver_major = (version >> 24) & 0xff;
+	ver_minor = (version >> 16) & 0xff;
+	ver_release = (version >> 8) & 0xff;
+
 	pr_info("Found gmux version %d.%d.%d [%s]\n", ver_major, ver_minor,
 		ver_release, (gmux_data->indexed ? "indexed" : "classic"));
 
diff --git a/include/linux/apple-gmux.h b/include/linux/apple-gmux.h
index 1f68b49bcd68..eb2caee04abd 100644
--- a/include/linux/apple-gmux.h
+++ b/include/linux/apple-gmux.h
@@ -67,7 +67,6 @@ static inline bool apple_gmux_is_indexed(unsigned long iostart)
  */
 static inline bool apple_gmux_detect(struct pnp_dev *pnp_dev, bool *indexed_ret)
 {
-	u8 ver_major, ver_minor, ver_release;
 	struct device *dev = NULL;
 	struct acpi_device *adev;
 	struct resource *res;
@@ -95,10 +94,7 @@ static inline bool apple_gmux_detect(struct pnp_dev *pnp_dev, bool *indexed_ret)
 	 * Invalid version information may indicate either that the gmux
 	 * device isn't present or that it's a new one that uses indexed io.
 	 */
-	ver_major = inb(res->start + GMUX_PORT_VERSION_MAJOR);
-	ver_minor = inb(res->start + GMUX_PORT_VERSION_MINOR);
-	ver_release = inb(res->start + GMUX_PORT_VERSION_RELEASE);
-	if (ver_major == 0xff && ver_minor == 0xff && ver_release == 0xff) {
+	if (!(~inl(res->start + GMUX_PORT_VERSION_MAJOR))) {
 		indexed = apple_gmux_is_indexed(res->start);
 		if (!indexed)
 			goto out;
-- 
2.39.1

