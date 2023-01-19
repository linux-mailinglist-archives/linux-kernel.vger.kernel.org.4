Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2AA1673394
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 09:23:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbjASIXh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 03:23:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230117AbjASIX0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 03:23:26 -0500
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA1F74F34C
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 00:23:23 -0800 (PST)
Received: from ubuntu.localdomain (unknown [46.146.89.18])
        by mail.ispras.ru (Postfix) with ESMTPSA id 582D3406BB55;
        Thu, 19 Jan 2023 08:23:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 582D3406BB55
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
        s=default; t=1674116601;
        bh=yplRY5vy0IwvvCxj1QobBKOGx3GZDSpgAOeKTO9wQuc=;
        h=From:To:Cc:Subject:Date:From;
        b=QK9sullmZm/qV9iOheODkQeV+m5raFyFrR4nOUQSwrqdGdpIS5MYkK9AflobwBeWO
         y4i3vcJVsgFiJJD7fb01uwmXELwkgw49WH+ADppBaIn7M2ZarlwH35llHN1m+at6sS
         Acy7njboJG67Ke917zMzBWkqP+39aL4fSk/BSb0I=
From:   Artemii Karasev <karasev@ispras.ru>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     Artemii Karasev <karasev@ispras.ru>,
        Xiang wangx <wangxiang@cdjrlc.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        lvc-project@linuxtesting.org
Subject: [PATCH] ALSA: hda/via: Avoid potential array out-of-bound in add_secret_dac_path()
Date:   Thu, 19 Jan 2023 00:22:59 -0800
Message-Id: <20230119082259.3634-1-karasev@ispras.ru>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

snd_hda_get_connections() can return a negative error code.
It may lead to accessing 'conn' array at a negative index.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Artemii Karasev <karasev@ispras.ru>
Fixes: 30b4503378c9 ("ALSA: hda - Expose secret DAC-AA connection of some VIA codecs")
---
 sound/pci/hda/patch_via.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/pci/hda/patch_via.c b/sound/pci/hda/patch_via.c
index aea7fae2ca4b..2994f85bc1b9 100644
--- a/sound/pci/hda/patch_via.c
+++ b/sound/pci/hda/patch_via.c
@@ -819,6 +819,9 @@ static int add_secret_dac_path(struct hda_codec *codec)
 		return 0;
 	nums = snd_hda_get_connections(codec, spec->gen.mixer_nid, conn,
 				       ARRAY_SIZE(conn) - 1);
+	if (nums < 0)
+		return nums;
+
 	for (i = 0; i < nums; i++) {
 		if (get_wcaps_type(get_wcaps(codec, conn[i])) == AC_WID_AUD_OUT)
 			return 0;
-- 
2.25.1

