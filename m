Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E8B46D983E
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 15:30:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237316AbjDFNaz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 09:30:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237551AbjDFNay (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 09:30:54 -0400
Received: from hust.edu.cn (unknown [202.114.0.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C715F5B83
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 06:30:52 -0700 (PDT)
Received: from ubuntu.localdomain ([120.202.201.62])
        (user=xubiang@hust.edu.cn mech=LOGIN bits=0)
        by mx1.hust.edu.cn  with ESMTP id 336DSdf0008114-336DSdf1008114
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Thu, 6 Apr 2023 21:28:44 +0800
From:   Xu Biang <xubiang@hust.edu.cn>
To:     Clemens Ladisch <clemens@ladisch.de>,
        Takashi Sakamoto <o-takashi@sakamocchi.jp>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     dzm91@hust.edu.cn, error27@gmail.com,
        hust-os-kernel-patches@googlegroups.com,
        Xu Biang <xubiang@hust.edu.cn>, Takashi Iwai <tiwai@suse.de>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ALSA: firewire-tascam: add missing unwind goto in snd_tscm_stream_start_duplex()
Date:   Thu,  6 Apr 2023 06:28:01 -0700
Message-Id: <20230406132801.105108-1-xubiang@hust.edu.cn>
X-Mailer: git-send-email 2.17.1
X-FEAS-AUTH-USER: xubiang@hust.edu.cn
X-Spam-Status: No, score=-0.0 required=5.0 tests=SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Smatch Warns:
sound/firewire/tascam/tascam-stream.c:493 snd_tscm_stream_start_duplex()
warn: missing unwind goto?

The direct return will cause the stream list of "&tscm->domain" unemptied
and the session in "tscm" unfinished if amdtp_domain_start() returns with
an error.

Fix this by changing the direct return to a goto which will empty the
stream list of "&tscm->domain" and finish the session in "tscm".

The snd_tscm_stream_start_duplex() function is called in the prepare
callback of PCM. According to "ALSA Kernel API Documentation", the prepare
callback of PCM will be called many times at each setup. So, if the
"&d->streams" list is not emptied, when the prepare callback is called
next time, snd_tscm_stream_start_duplex() will receive -EBUSY from
amdtp_domain_add_stream() that tries to add an existing stream to the
domain. The error handling code after the "error" label will be executed
in this case, and the "&d->streams" list will be emptied. So not emptying
the "&d->streams" list will not cause an issue. But it is more efficient
and readable to empty it on the first error by changing the direct return
to a goto statement.

The session in "tscm" has been begun before amdtp_domain_start(), so it
needs to be finished when amdtp_domain_start() fails.

Fixes: c281d46a51e3 ("ALSA: firewire-tascam: support AMDTP domain")
Signed-off-by: Xu Biang <xubiang@hust.edu.cn>
Reviewed-by: Dan Carpenter <error27@gmail.com>
---
Note that this finding is from static analysis and not tested.

 sound/firewire/tascam/tascam-stream.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/firewire/tascam/tascam-stream.c b/sound/firewire/tascam/tascam-stream.c
index 53e094cc411f..dfe783d01d7d 100644
--- a/sound/firewire/tascam/tascam-stream.c
+++ b/sound/firewire/tascam/tascam-stream.c
@@ -490,7 +490,7 @@ int snd_tscm_stream_start_duplex(struct snd_tscm *tscm, unsigned int rate)
 		// packet is important for media clock recovery.
 		err = amdtp_domain_start(&tscm->domain, tx_init_skip_cycles, true, true);
 		if (err < 0)
-			return err;
+			goto error;
 
 		if (!amdtp_domain_wait_ready(&tscm->domain, READY_TIMEOUT_MS)) {
 			err = -ETIMEDOUT;
-- 
2.17.1

