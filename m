Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB9585F7B19
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 17:57:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbiJGP5w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 11:57:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229831AbiJGP5r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 11:57:47 -0400
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [IPv6:2001:67c:2050:0:465::101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 142DD10C4E4;
        Fri,  7 Oct 2022 08:57:43 -0700 (PDT)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4MkXy85zXBz9sRG;
        Fri,  7 Oct 2022 17:57:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dylanvanassche.be;
        s=MBO0001; t=1665158256;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=k35lImm5f5L+QWNkc7HMTUrpu9Bmr/eFTnLYAfMsySo=;
        b=xNNjmk0wETjtFc8+yEGHj7biMko3UcZa68E1WWTBLCDslNz0iGtwm8BccG+ys+nhveoLoK
        LKDPO9PhD72itXKG4qZTLOxKk2wRy9ipB2DPiUS1u3aLHirm79s+nhwhzJH3CplYSCCYJP
        W7Sn/N7apRRnwvBlF4e6EobfDAeOyPJcQAH2ab/RCl+KrJ+M1iv0SquBgiFzPimbadYOsy
        myKknYM8fgjYYLP8OU4TOxrtofOWpewyISyVPMS/gCYawnoC92FsrCC68TmjXe781zdz5l
        otRNXAELmKW5KBzcEZeT3TED78pdwcEiQCEOzYSISH1TTi7ReW7YuiaK+lqYOA==
From:   Dylan Van Assche <me@dylanvanassche.be>
To:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        linux-arm-msm@vger.kernel.org, phone-devel@vger.kernel.org,
        Dylan Van Assche <me@dylanvanassche.be>
Subject: [PATCH v2] sound: soc: codecs: wcd-mbhc-v2: expose ALSA control for jack
Date:   Fri,  7 Oct 2022 17:57:16 +0200
Message-Id: <20221007155716.10594-1-me@dylanvanassche.be>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jack detection is currently fully functional via the input
interface together with multimedia buttons, but is not exposed
as an ALSA control. Therefore, ALSA clients such as PulseAudio
do not pick up the jack detection events as they only support
one of the possible interface (ALSA control or input interface,
but not both). Expose the jack events as an ALSA control and input
interface to provide ALSA clients both interfaces.

Signed-off-by: Dylan Van Assche <me@dylanvanassche.be>
---
 sound/soc/codecs/wcd-mbhc-v2.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/soc/codecs/wcd-mbhc-v2.c b/sound/soc/codecs/wcd-mbhc-v2.c
index 1911750f7445..1b75f49b2858 100644
--- a/sound/soc/codecs/wcd-mbhc-v2.c
+++ b/sound/soc/codecs/wcd-mbhc-v2.c
@@ -725,6 +725,10 @@ static int wcd_mbhc_initialise(struct wcd_mbhc *mbhc)
 
 	mutex_lock(&mbhc->lock);
 
+	ret = snd_jack_add_new_kctl(mbhc->jack->jack, "Headset Jack", WCD_MBHC_JACK_MASK);
+	if (ret)
+		dev_warn(component->dev, "failed creating Headset Jack kctl with err: %d\n", ret);
+
 	/* enable HS detection */
 	if (mbhc->mbhc_cb->hph_pull_up_control_v2)
 		mbhc->mbhc_cb->hph_pull_up_control_v2(component,
-- 
2.37.3

