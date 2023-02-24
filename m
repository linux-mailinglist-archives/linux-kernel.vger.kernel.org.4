Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6C706A1591
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 04:42:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbjBXDmn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 22:42:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjBXDmj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 22:42:39 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AF9D15151;
        Thu, 23 Feb 2023 19:42:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1738DB81B2F;
        Fri, 24 Feb 2023 03:42:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37274C433EF;
        Fri, 24 Feb 2023 03:42:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677210121;
        bh=1+iTjI8144LQifhA5jGdDFhZRv+AUNRCi/0OKx4iOfA=;
        h=Date:From:To:Cc:Subject:From;
        b=gVdn/Kr6HlfAF4N4sGLeETDSym4W2TYS6eQ9fS9Y2TWtyJgMvii4tT2z9zqsl9toP
         AHoUlgZ3KsGIFLoAMkIfyHdv5cdtBK83uYoQFZA4GMZ/FfrIOCiuOxrxDega6mHW36
         PFA36m0IlQUPmxeaxIUPcU/aIWKOCSdaZOSITiq7sWZ8fhc8FGp/ZB3gw5uTijKclA
         gwVoB69VTh6wpIaF4l9wM6BzuRGF/Z0FMAfBN8TYRjdSUh/jWyeG1pnaOkphfq1Kr5
         bnMf0FqURXn1SIsiQFUrJv0OTpbAWIuOhufuiMuu4DxEgGUPERQQbF4zAmSBfnbD8n
         Ud86u32tRXzVw==
Date:   Thu, 23 Feb 2023 21:42:26 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     sound-open-firmware@alsa-project.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: [PATCH][next] ASoC: SOF: ipc4-topology: Replace fake flexible arrays
 with flexible-array member
Message-ID: <Y/gyIg1qZduhigPi@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Zero-length arrays as fake flexible arrays are deprecated and we are
moving towards adopting C99 flexible-array members, instead.

Use the DECLARE_FLEX_ARRAY() helper macro to transform zero-length
arrays in unions with flexible-array members.

Address the following warnings found with GCC-13 and
-fstrict-flex-arrays=3 enabled:
sound/soc/sof/ipc4-control.c:176:77: warning: array subscript i is outside array bounds of ‘struct sof_ipc4_ctrl_value_chan[0]’ [-Warray-bounds=]
sound/soc/sof/ipc4-control.c:78:29: warning: array subscript 0 is outside array bounds of ‘struct sof_ipc4_ctrl_value_chan[0]’ [-Warray-bounds=]
sound/soc/sof/ipc4-control.c:80:33: warning: array subscript i is outside array bounds of ‘struct sof_ipc4_ctrl_value_chan[0]’ [-Warray-bounds=]
sound/soc/sof/ipc4-control.c:95:53: warning: array subscript i is outside array bounds of ‘struct sof_ipc4_ctrl_value_chan[0]’ [-Warray-bounds=]
sound/soc/sof/ipc4-control.c:96:53: warning: array subscript i is outside array bounds of ‘struct sof_ipc4_ctrl_value_chan[0]’ [-Warray-bounds=]
sound/soc/sof/ipc4-control.c:93:53: warning: array subscript 0 is outside array bounds of ‘struct sof_ipc4_ctrl_value_chan[0]’ [-Warray-bounds=]
sound/soc/sof/ipc4-control.c:140:58: warning: array subscript i is outside array bounds of ‘struct sof_ipc4_ctrl_value_chan[0]’ [-Warray-bounds=]
sound/soc/sof/ipc4-control.c:141:29: warning: array subscript i is outside array bounds of ‘struct sof_ipc4_ctrl_value_chan[0]’ [-Warray-bounds=]
sound/soc/sof/ipc4-control.c:142:29: warning: array subscript i is outside array bounds of ‘struct sof_ipc4_ctrl_value_chan[0]’ [-Warray-bounds=]
sound/soc/sof/ipc4-topology.c:1475:36: warning: array subscript i is outside array bounds of ‘struct sof_ipc4_ctrl_value_chan[0]’ [-Warray-bounds=]
sound/soc/sof/ipc4-topology.c:1476:36: warning: array subscript i is outside array bounds of ‘struct sof_ipc4_ctrl_value_chan[0]’ [-Warray-bounds=]

This helps with the ongoing efforts to tighten the FORTIFY_SOURCE
routines on memcpy() and help us make progress towards globally
enabling -fstrict-flex-arrays=3 [1].

Link: https://github.com/KSPP/linux/issues/21
Link: https://github.com/KSPP/linux/issues/193
Link: https://github.com/KSPP/linux/issues/258
Link: https://gcc.gnu.org/pipermail/gcc-patches/2022-October/602902.html [1]
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 sound/soc/sof/ipc4-topology.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/sof/ipc4-topology.h b/sound/soc/sof/ipc4-topology.h
index 72529179ac22..8507171a6e4d 100644
--- a/sound/soc/sof/ipc4-topology.h
+++ b/sound/soc/sof/ipc4-topology.h
@@ -266,8 +266,8 @@ struct sof_ipc4_control_data {
 	int index;
 
 	union {
-		struct sof_ipc4_ctrl_value_chan chanv[0];
-		struct sof_abi_hdr data[0];
+		DECLARE_FLEX_ARRAY(struct sof_ipc4_ctrl_value_chan, chanv);
+		DECLARE_FLEX_ARRAY(struct sof_abi_hdr, data);
 	};
 };
 
-- 
2.34.1

