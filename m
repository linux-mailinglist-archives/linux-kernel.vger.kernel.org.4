Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A8536457BC
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 11:26:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229462AbiLGK0T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 05:26:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbiLGKZt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 05:25:49 -0500
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B749C45EE9
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 02:24:57 -0800 (PST)
X-QQ-mid: bizesmtp85t1670408559tp98jp1j
Received: from localhost.localdomain ( [58.240.82.166])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 07 Dec 2022 18:22:32 +0800 (CST)
X-QQ-SSF: 01400000000000C0M000000A0000000
X-QQ-FEAT: 3M0okmaRx3hQ3ejzzir6kxAEdcpGlwVKZV2ObtT+XuxHIegLx4pKfS/rgI+AD
        LmHVc9VOhAi9DI76w+Pqjz8EpAo0vSYrVcaixSn7er9JkG4dzLW/Ap2Gk06OTMILIY9Xnes
        /EONVPHo0LuLNNwnmxyr1Fy1UJjCwqdhfpkIafCdq2KE+ZsanKLQw3myFDcyFWvCs6yQ0sS
        hFyt2rLBvFvNeAsnzfH2e/oAY92UFxXWR2jg/DV284U7FYyhJQQyNDO9qN+nPV9crYkp7Ck
        JPmPAKeNd5yuHJCp3sOJyWoLfyHB9Z+K5epkJp2mcrwqQg1PMDRx+VVA4oys2F7fweqzynt
        deD0Jf5whHKUDvolwyLW5UOcHQE7gapk5rsK9emMLkzZjL+TZRFjAjGS57o1Rz3wuni3P97
X-QQ-GoodBg: 1
From:   Zhen Ni <nizhen@uniontech.com>
To:     perex@perex.cz, tiwai@suse.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Zhen Ni <nizhen@uniontech.com>
Subject: [PATCH] ASoc: SOF: Fix sof-audio-pci-intel-tgl shutdown timeout during hibernation
Date:   Wed,  7 Dec 2022 18:22:29 +0800
Message-Id: <20221207102229.25962-1-nizhen@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybglogicsvr:qybglogicsvr5
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Dell Latitude 3420 Notebook, sof-audio-pci-intel-tgl may fail to shutdown
sporadically during hibernation as following log:

[   43.281110] PM: Image saving done
[   43.281699] PM: hibernation: Wrote 2828852 kbytes in 2.78 seconds(1017.57 MB/s)
[   43.282359] PM: SI
[   43.345156] kvm: exiting hardware virtualization
[   43.345865] auxiliary snd_sof.hda-probes.0: shutdown
[   43.346359] skl_hda_dsp_generic skl_hda_dsp_generic: shutdown
[   43.346849] skl_hda_codec hdmi ehdaudio0D2: shutdown
[   43.398204] snd_hda_codec_realtek ehdaudio0DO: shutdown
[   43.419621] dmic-codec dmic-codec: shutdown
[   43.420194] sof-audio-pci-intel-tgl 0000:00:1f.3: shutdown

Call wait_xxx_timeout() to process the timeout.

Signed-off-by: Zhen Ni <nizhen@uniontech.com>
---
 sound/core/init.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/sound/core/init.c b/sound/core/init.c
index 5377f94eb211..9bd674d7a0fd 100644
--- a/sound/core/init.c
+++ b/sound/core/init.c
@@ -574,9 +574,10 @@ void snd_card_disconnect_sync(struct snd_card *card)
 	}
 
 	spin_lock_irq(&card->files_lock);
-	wait_event_lock_irq(card->remove_sleep,
+	wait_event_lock_irq_timeout(card->remove_sleep,
 			    list_empty(&card->files_list),
-			    card->files_lock);
+			    card->files_lock,
+			    msecs_to_jiffies(2000));
 	spin_unlock_irq(&card->files_lock);
 }
 EXPORT_SYMBOL_GPL(snd_card_disconnect_sync);
@@ -659,7 +660,7 @@ int snd_card_free(struct snd_card *card)
 	if (ret)
 		return ret;
 	/* wait, until all devices are ready for the free operation */
-	wait_for_completion(&released);
+	wait_for_completion_timeout(&released, msecs_to_jiffies(2000))
 
 	return 0;
 }
-- 
2.20.1


