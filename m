Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7983D70A109
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 22:54:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230096AbjESUx7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 16:53:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229871AbjESUx6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 16:53:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FEA0132;
        Fri, 19 May 2023 13:53:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 20FD4615FF;
        Fri, 19 May 2023 20:53:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE0E7C433D2;
        Fri, 19 May 2023 20:53:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684529636;
        bh=XMfD+fHTTCvtfUV7h2YoT8hriPxayi7IPm7YdA35a9s=;
        h=Date:From:To:Cc:Subject:From;
        b=sBinAhr5gyilwc61wdhuktUwh92ixozkWmdVaCSMyCebtMWVvmdYuyWVPTV8gIDMK
         o9IQGwO8DD5G0a00xR5wFUnOoMhq16LAhNwTENB5pFTdkyuyouivAMcMV65KDYqUV/
         D34aHq1VRxT2angV5Ea99jtXFwMHR8AMi9/dyDFVAMosZRAoaavRQIKJGtgkY1GLRp
         bvlB+slkUym0LGY4ATTGL1YYaQrVrIojTicPFth27D3C8CVNyVdCqjdECWwCUxwDuD
         E/aDoFGHHCQTt3Pb7Uq4fc5R5KO4vLGWi+H67WVF0PlZSxJg34zVzX1tFLJxPPW4u0
         Bdd5IHnVaQpNg==
Date:   Fri, 19 May 2023 14:54:46 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: [PATCH v2][next] ALSA: mixart: Replace one-element arrays with
 simple object declarations
Message-ID: <ZGfiFjcL8+r3mayq@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

One-element arrays are deprecated, and we are replacing them with flexible
array members instead. However, in this case it seems those one-element
arrays have never actually been used as fake flexible arrays.

See this code that dates from Linux-2.6.12-rc2 initial git repository build
(commit 1da177e4c3f4 ("Linux-2.6.12-rc2")):

sound/pci/mixart/mixart_core.h:
 215 struct mixart_stream_state_req
 216 {
 217         u32                 delayed;
 218         u64                 scheduler;
 219         u32                 reserved4np[3];
 220         u32                 stream_count;  /* set to 1 for instance */
 221         struct mixart_flow_info  stream_info;   /* could be an array[stream_count] */
 222 } __attribute__((packed));

sound/pci/mixart/mixart.c:
 388
 389         memset(&stream_state_req, 0, sizeof(stream_state_req));
 390         stream_state_req.stream_count = 1;
 391         stream_state_req.stream_info.stream_desc.uid_pipe = stream->pipe->group_uid;
 392         stream_state_req.stream_info.stream_desc.stream_idx = stream->substream->number;
 393

So, taking the code above as example, replace multiple one-element
arrays with simple object declarations, and refactor the rest of the
code, accordingly.

This helps with the ongoing efforts to tighten the FORTIFY_SOURCE
routines on memcpy() and help us make progress towards globally
enabling -fstrict-flex-arrays=3 [1].

This results in no differences in binary output.

Link: https://github.com/KSPP/linux/issues/79
Link: https://github.com/KSPP/linux/issues/296
Link: https://gcc.gnu.org/pipermail/gcc-patches/2022-October/602902.html [1]
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
Changes in v2:
 - Keep the code comments (by Takashi Iwai) and explicitly mention that
   the objects could be arrays, in theory.

v1:
 - Link: https://lore.kernel.org/linux-hardening/ZGVlcpuvx1rSOMP8@work/

 sound/pci/mixart/mixart.c      | 8 ++++----
 sound/pci/mixart/mixart_core.h | 7 +++----
 2 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/sound/pci/mixart/mixart.c b/sound/pci/mixart/mixart.c
index 1b078b789604..7ceaf6a7a77e 100644
--- a/sound/pci/mixart/mixart.c
+++ b/sound/pci/mixart/mixart.c
@@ -98,7 +98,7 @@ static int mixart_set_pipe_state(struct mixart_mgr *mgr,
 
 	memset(&group_state, 0, sizeof(group_state));
 	group_state.pipe_count = 1;
-	group_state.pipe_uid[0] = pipe->group_uid;
+	group_state.pipe_uid = pipe->group_uid;
 
 	if(start)
 		request.message_id = MSG_STREAM_START_STREAM_GRP_PACKET;
@@ -185,7 +185,7 @@ static int mixart_set_clock(struct mixart_mgr *mgr,
 	clock_properties.clock_mode = CM_STANDALONE;
 	clock_properties.frequency = rate;
 	clock_properties.nb_callers = 1; /* only one entry in uid_caller ! */
-	clock_properties.uid_caller[0] = pipe->group_uid;
+	clock_properties.uid_caller = pipe->group_uid;
 
 	dev_dbg(&mgr->pci->dev, "mixart_set_clock to %d kHz\n", rate);
 
@@ -565,8 +565,8 @@ static int mixart_set_format(struct mixart_stream *stream, snd_pcm_format_t form
 
 	stream_param.pipe_count = 1;      /* set to 1 */
 	stream_param.stream_count = 1;    /* set to 1 */
-	stream_param.stream_desc[0].uid_pipe = stream->pipe->group_uid;
-	stream_param.stream_desc[0].stream_idx = stream->substream->number;
+	stream_param.stream_desc.uid_pipe = stream->pipe->group_uid;
+	stream_param.stream_desc.stream_idx = stream->substream->number;
 
 	request.message_id = MSG_STREAM_SET_INPUT_STAGE_PARAM;
 	request.uid = (struct mixart_uid){0,0};
diff --git a/sound/pci/mixart/mixart_core.h b/sound/pci/mixart/mixart_core.h
index 2f0e29ed5d63..d39233e0e070 100644
--- a/sound/pci/mixart/mixart_core.h
+++ b/sound/pci/mixart/mixart_core.h
@@ -231,7 +231,7 @@ struct mixart_group_state_req
 	u64           scheduler;
 	u32           reserved4np[2];
 	u32           pipe_count;    /* set to 1 for instance */
-	struct mixart_uid  pipe_uid[1];   /* could be an array[pipe_count] */
+	struct mixart_uid  pipe_uid; /* could be an array[pipe_count], in theory */
 } __attribute__((packed));
 
 struct mixart_group_state_resp
@@ -314,7 +314,7 @@ struct mixart_clock_properties
 	u32 format;
 	u32 board_mask;
 	u32 nb_callers; /* set to 1 (see below) */
-	struct mixart_uid uid_caller[1];
+	struct mixart_uid uid_caller;
 } __attribute__((packed));
 
 struct mixart_clock_properties_resp
@@ -401,8 +401,7 @@ struct mixart_stream_param_desc
 	u32 reserved4np[3];
 	u32 pipe_count;                           /* set to 1 (array size !) */
 	u32 stream_count;                         /* set to 1 (array size !) */
-	struct mixart_txx_stream_desc stream_desc[1];  /* only one stream per command, but this could be an array */
-
+	struct mixart_txx_stream_desc stream_desc; /* only one stream per command, but this could be an array, in theory */
 } __attribute__((packed));
 
 
-- 
2.34.1

