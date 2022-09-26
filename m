Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AF415EB579
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 01:19:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231276AbiIZXTl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 19:19:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230455AbiIZXSw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 19:18:52 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7060CA8324;
        Mon, 26 Sep 2022 16:18:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id AD45ECE13E6;
        Mon, 26 Sep 2022 23:18:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFEB4C433C1;
        Mon, 26 Sep 2022 23:18:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664234327;
        bh=Ve1292BFbx4M8vgKxaCxSGexhyBekTzktp5oNYWPKb8=;
        h=Date:From:To:Cc:Subject:From;
        b=Nz6cDimDIowy15ehXN7S8a3ttyMPzFNiN/Trx+4htJdmpst2LKfRaOuZiOvoEfnyb
         cptyIcVD6GrNIzuXUxowzxse3keIKNENcQ5fd64EzwRLHj41l45nuzTG6k+Yaqg/pf
         szCn1dm5yfeEAowiX0ThMouuWEKoGioh/TG/KGTEUgfIGydYARzBDutyzdQCJ1v8SN
         jWMyrbIy6tX03qaJYSEg2Ff3/huri6qMKVIe/V5AeZJW/Yd4M2cyyZyssN/HV4d4Py
         n2tiozKXEuZTTbyx6k0j4/8WusKNYvSmX2QQwulMMmyTdKOqazAsI1AHKlivOIYuoE
         xWRURrAPjchdQ==
Date:   Mon, 26 Sep 2022 18:18:42 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: [PATCH][next] ASoC: uapi: Replace zero-length arrays with
 __DECLARE_FLEX_ARRAY() helper
Message-ID: <YzIzUjUuJKf0mkKg@work>
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
declarations in anonymous union with the new __DECLARE_FLEX_ARRAY()
helper macro.

This helper allows for flexible-array members in unions.

Link: https://github.com/KSPP/linux/issues/193
Link: https://github.com/KSPP/linux/issues/227
Link: https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 include/uapi/sound/asoc.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/uapi/sound/asoc.h b/include/uapi/sound/asoc.h
index 053949287ce8..dd8ad790fc15 100644
--- a/include/uapi/sound/asoc.h
+++ b/include/uapi/sound/asoc.h
@@ -226,9 +226,9 @@ struct snd_soc_tplg_vendor_array {
 	__le32 type;	/* SND_SOC_TPLG_TUPLE_TYPE_ */
 	__le32 num_elems;	/* number of elements in array */
 	union {
-		struct snd_soc_tplg_vendor_uuid_elem uuid[0];
-		struct snd_soc_tplg_vendor_value_elem value[0];
-		struct snd_soc_tplg_vendor_string_elem string[0];
+		__DECLARE_FLEX_ARRAY(struct snd_soc_tplg_vendor_uuid_elem, uuid);
+		__DECLARE_FLEX_ARRAY(struct snd_soc_tplg_vendor_value_elem, value);
+		__DECLARE_FLEX_ARRAY(struct snd_soc_tplg_vendor_string_elem, string);
 	};
 } __attribute__((packed));
 
-- 
2.34.1

