Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4C8B5EB34F
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 23:41:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230142AbiIZVlI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 17:41:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbiIZVlE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 17:41:04 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F123257557;
        Mon, 26 Sep 2022 14:41:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 5A973CE13C2;
        Mon, 26 Sep 2022 21:41:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48BDCC433D6;
        Mon, 26 Sep 2022 21:40:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664228460;
        bh=nJA1vq18hGF5czX+YZ/5cu1/Q/04JTv3WsfWyuNLU98=;
        h=Date:From:To:Cc:Subject:From;
        b=LdO+D7fr3NTekOZ9TO67LzdnRndI0bSiPuk/vaSCbQnh5IexuusEDs2JQSzOQX/+h
         IhZ/2ymVHFA+S68q8XKpPhonAyPaKWHq7ufKKqioe9KIYMYHySV3B/v9jMfAOwBmp6
         Y95W2p68e7AzJBWJGNR4xZvU2FJ2UZZambRQ0pz101mm3piun/eEQGp/0AG6VahTll
         Y1dlozoUohWuLcC4s10H291NHlbNt+IyM1HgtlN6Mkv78emhcQCemBMXXbisPGW2pb
         qtmwVVJo9KRCKnyk7FpCgNt5bwYuZjPqfPw3gM6Il2YWx/hBp3Cf8dKQsg5RAUS89Q
         E5sMUgfSVkd3w==
Date:   Mon, 26 Sep 2022 16:40:55 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: [PATCH][next] ASoC: SOF: control.h: Replace zero-length array with
 DECLARE_FLEX_ARRAY() helper
Message-ID: <YzIcZ11k8RiQtS2T@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Zero-length arrays are deprecated and we are moving towards adopting
C99 flexible-array members, instead. So, replace zero-length arrays
declarations in anonymous union with the new DECLARE_FLEX_ARRAY()
helper macro.

This helper allows for flexible-array members in unions.

Link: https://github.com/KSPP/linux/issues/193
Link: https://github.com/KSPP/linux/issues/211
Link: https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 include/sound/sof/control.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/sound/sof/control.h b/include/sound/sof/control.h
index 7379a33d7247..983d374fe511 100644
--- a/include/sound/sof/control.h
+++ b/include/sound/sof/control.h
@@ -117,11 +117,11 @@ struct sof_ipc_ctrl_data {
 	/* control data - add new types if needed */
 	union {
 		/* channel values can be used by volume type controls */
-		struct sof_ipc_ctrl_value_chan chanv[0];
+		DECLARE_FLEX_ARRAY(struct sof_ipc_ctrl_value_chan, chanv);
 		/* component values used by routing controls like mux, mixer */
-		struct sof_ipc_ctrl_value_comp compv[0];
+		DECLARE_FLEX_ARRAY(struct sof_ipc_ctrl_value_comp, compv);
 		/* data can be used by binary controls */
-		struct sof_abi_hdr data[0];
+		DECLARE_FLEX_ARRAY(struct sof_abi_hdr, data);
 	};
 } __packed;
 
-- 
2.34.1

