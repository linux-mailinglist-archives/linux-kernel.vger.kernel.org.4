Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E276D5EB4E8
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 00:58:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230247AbiIZW6a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 18:58:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230209AbiIZW60 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 18:58:26 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E06AA405D;
        Mon, 26 Sep 2022 15:58:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7B9C0B815A2;
        Mon, 26 Sep 2022 22:58:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8EBCC433D6;
        Mon, 26 Sep 2022 22:58:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664233103;
        bh=xDYjoFR+NtGG53i9TMTNgZOELVNnrshin7Kn4ONKlzY=;
        h=Date:From:To:Cc:Subject:From;
        b=nbj97LKUb6NIti9AtwZWlD4v8BVQ1Wh6mke62KVOELQdDAUJGJpOYxdkf129L43lR
         X+VkTgscuP4NlWdojyibYcOcW+ArKTQVhdI7RYhRXjVn8LJuMofZi4Ap/s5n67RUnj
         k8s+1IPYKS2BhVaM8EYtqhNyxVzuB4HtGWZmpkawV7FFLUA3gD3vsuHD0KT2aw0LFL
         byc2HwpWgw0agVPklgdpbbW0OXlaF4OsQgQxiPjkM84RSfyHSf55qtkXw9U84pSorN
         c2eJQIepC0mdx54aftNQowHrMLssVDKYI24NvkLOQfhmBhSc87iBkMOcAIp2/IsOA0
         yae3/wKpkKRSw==
Date:   Mon, 26 Sep 2022 17:58:17 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: [PATCH][next] ASoC: Intel: Skylake: Replace zero-length arrays with
 DECLARE_FLEX_ARRAY() helper
Message-ID: <YzIuiUul2CwPlkKh@work>
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
Link: https://github.com/KSPP/linux/issues/226
Link: https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 sound/soc/intel/skylake/skl-topology.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-topology.h b/sound/soc/intel/skylake/skl-topology.h
index a5bccf2fcd88..017ac0ef324d 100644
--- a/sound/soc/intel/skylake/skl-topology.h
+++ b/sound/soc/intel/skylake/skl-topology.h
@@ -233,8 +233,8 @@ struct skl_uuid_inst_map {
 struct skl_kpb_params {
 	u32 num_modules;
 	union {
-		struct skl_mod_inst_map map[0];
-		struct skl_uuid_inst_map map_uuid[0];
+		DECLARE_FLEX_ARRAY(struct skl_mod_inst_map, map);
+		DECLARE_FLEX_ARRAY(struct skl_uuid_inst_map, map_uuid);
 	} u;
 };
 
-- 
2.34.1

