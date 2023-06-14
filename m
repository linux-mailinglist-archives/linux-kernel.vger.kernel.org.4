Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42B2072FD22
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 13:41:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243670AbjFNLlR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 07:41:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236253AbjFNLlM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 07:41:12 -0400
X-Greylist: delayed 399 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 14 Jun 2023 04:41:04 PDT
Received: from cloudserver3200665-3200696.home.pl (cloudserver3200665-3200696.home.pl [46.242.240.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C65A21FD7
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 04:41:04 -0700 (PDT)
Received: from localhost (127.0.0.1) (HELO sv086.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.2.0)
 id 99d28c93892c5d81; Wed, 14 Jun 2023 13:34:23 +0200
Received: from HEM05L.admytek.local (unknown [213.108.156.244])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by sv086.home.net.pl (Postfix) with ESMTPSA id B71E94211F;
        Wed, 14 Jun 2023 13:34:22 +0200 (CEST)
From:   Lukasz Tyl <ltyl@hem-e.com>
To:     perex@perex.cz
Cc:     tiwai@suse.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, pgorgon@hem-e.com,
        Lukasz Tyl <ltyl@hem-e.com>
Subject: [PATCH] sound: usb: quirks: add flag for HEM devices to enable native DSD playback
Date:   Wed, 14 Jun 2023 13:33:50 +0200
Message-Id: <20230614113350.25607-1-ltyl@hem-e.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CLIENT-IP: 213.108.156.244
X-CLIENT-HOSTNAME: 213.108.156.244
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvhedrgedvtddggedvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecunecujfgurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomhepnfhukhgrshiiucfvhihluceolhhthihlsehhvghmqdgvrdgtohhmqeenucggtffrrghtthgvrhhnpeeghfeuhedvvefhhefghfdtjeekudevudelheekgeegjeduueefgeetfeelueehudenucfkphepvddufedruddtkedrudehiedrvdeggeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvudefrddutdekrdduheeirddvgeegpdhhvghlohepjffgofdthefnrdgrughmhihtvghkrdhlohgtrghlpdhmrghilhhfrhhomhepnfhukhgrshiiucfvhihluceolhhthihlsehhvghmqdgvrdgtohhmqedpnhgspghrtghpthhtohepiedprhgtphhtthhopehpvghrvgigsehpvghrvgigrdgtiidprhgtphhtthhopehtihifrghisehsuhhsvgdrtghomhdprhgtphhtthhopegrlhhsrgdquggvvhgvlhesrghlshgrqdhprhhojhgvtghtrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphhgohhrghhonheshhgvmhdqvgdrtghomhdprhgtphhtthhopehlthihlheshhgvmhdqvgdrtghomh
X-DCC--Metrics: sv086.home.net.pl 1024; Body=9 Fuz1=9 Fuz2=9
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit adds new DEVICE_FLG with QUIRK_FLAG_DSD_RAW and Vendor Id for
HEM devices which supports native DSD. Prior to this change Linux kernel
was not enabling native DSD playback for HEM devices, and as a result,
DSD audio was being converted to PCM "on the fly". HEM devices,
when connected to the system, would only play audio in PCM format,
even if the source material was in DSD format. With the addition of new
VENDOR_FLG in the quircks.c file, the devices are now correctly
recognized, and raw DSD data is transmitted to the device,
allowing for native DSD playback.

Signed-off-by: Lukasz Tyl <ltyl@hem-e.com>
---
 sound/usb/quirks.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index 3ecd1ba7fd4b..1414bf15ac21 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -2197,6 +2197,8 @@ static const struct usb_audio_quirk_flags_table quirk_flags_table[] = {
 		   QUIRK_FLAG_DSD_RAW),
 	VENDOR_FLG(0xc502, /* HiBy devices */
 		   QUIRK_FLAG_DSD_RAW),
+	VENDOR_FLG(0x3336, /* HEM devices */
+		   QUIRK_FLAG_DSD_RAW),
 
 	{} /* terminator */
 };
-- 
2.34.1

