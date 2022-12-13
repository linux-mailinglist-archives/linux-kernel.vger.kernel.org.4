Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AF8B64BB2B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 18:36:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236313AbiLMRgE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 12:36:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbiLMRf7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 12:35:59 -0500
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com [IPv6:2607:f8b0:4864:20::e30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47446DF0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 09:35:58 -0800 (PST)
Received: by mail-vs1-xe30.google.com with SMTP id b189so15364171vsc.10
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 09:35:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CKlgFL8VmX9JU/WhcQ2Bam3+gwPcuhRUKzrP4zlGwcY=;
        b=JqciyDig5/9bWoEbDf2kfYwV6vpWLQFoCnA9TQD6L8FSCdasuDTSptDq0oxVMqBXln
         8kFKXh1J1HO9h3ZWkKE+5t19fjMaQhPnK4Om8sirZHDPWfyH6QYi/s4KbZW8/D39ccdh
         2PUzgPHk3zGfpeGZI0r5ZeY16XKICkmIR9PBN3Y7KivED5at/tAwWS3EKZ7n3+PDeVqC
         vEkkBacS/IJNuZ1chtagdQK5QEHy66dGXhTfxUzs09AruDvb812RH99QmTGok0T2yM/6
         m+WpoD74m3HJ8qc/5+Woo+p4wWLytQHUovkr52qb/m+Un263mmBmhF4sZikrjhujhGsM
         ZGxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CKlgFL8VmX9JU/WhcQ2Bam3+gwPcuhRUKzrP4zlGwcY=;
        b=zTFUl94c4EOlmChLRcdf7kvhJH2g3d1QE29I4PjesFX4vu4QFFRYgF+WsvKW3vulFF
         NEMroEH1K/xOVb0EK7ScLAJ2lM2X7s7x1gvNaHaYcj6hqqWOEvqIxiYiCvV9QxrPLMp0
         zIJwdSZVpWBi0yVaSu5JWcJDkAjseZRSChLDCSkOLf0G+Kxx/qyOQwpKVH2gKcW5NJu1
         WnWH84bENfoZcjCQ5p0M9XJEtj5VfPa5Y6QQerz3Bm+Lr6xE/ejOPH0H4MpNYzdxj3jG
         9s2tgJSng5fp14wsUS2VC/fhs8XkHByIA2XesJENpl8BcK2jyM2Lx9tewM/sJnN4QjBB
         FZWg==
X-Gm-Message-State: ANoB5plnGqWktYxaiwWFyko7xt3LD5rZYCN8I7qLzu4Ky88Nbszq5MSg
        2THGg5APG5N/Fh0sA07gqoc=
X-Google-Smtp-Source: AA0mqf6GlcbfjVLPiwxRf+22hI98LjXYpt+Dpgy/bR/hmXo7eqt25awp1CXRvLUPOtszhBD22lgA+g==
X-Received: by 2002:a05:6102:8d:b0:3b5:d3b:a82 with SMTP id t13-20020a056102008d00b003b50d3b0a82mr708804vsp.0.1670952957217;
        Tue, 13 Dec 2022 09:35:57 -0800 (PST)
Received: from lenovo-y720.. (097-101-018-014.res.spectrum.com. [97.101.18.14])
        by smtp.gmail.com with ESMTPSA id h21-20020ab02355000000b00418ccf714cfsm57550uao.10.2022.12.13.09.35.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Dec 2022 09:35:56 -0800 (PST)
From:   Moises Cardona <moisesmcardona@gmail.com>
To:     cezary.rojewski@intel.com
Cc:     pierre-louis.bossart@linux.intel.com,
        liam.r.girdwood@linux.intel.com, peter.ujfalusi@linux.intel.com,
        yung-chuan.liao@linux.intel.com, ranjani.sridharan@linux.intel.com,
        kai.vehmanen@linux.intel.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, hdegoede@redhat.com, oder_chiou@realtek.com,
        akihiko.odaki@gmail.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        Moises Cardona <moisesmcardona@gmail.com>
Subject: [PATCH] Add HP Stream 8 to bytcr_rt5640.c
Date:   Tue, 13 Dec 2022 12:35:50 -0500
Message-Id: <20221213173550.1567875-1-moisesmcardona@gmail.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The HP Stream 8 tablet is identical to the HP Stream 7 in terms of the PCB,
with the exception of the added SIM Card Slot. 
Therefore, I'm submitting this patch which properly initializes the audio 
and enables the headphone jack to work, just like it does in the 
HP Stream 7.

Signed-off-by: Moises Cardona <moisesmcardona@gmail.com>
---
 sound/soc/intel/boards/bytcr_rt5640.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/sound/soc/intel/boards/bytcr_rt5640.c b/sound/soc/intel/boards/bytcr_rt5640.c
index fb9d9e271845..1d964b1ceff4 100644
--- a/sound/soc/intel/boards/bytcr_rt5640.c
+++ b/sound/soc/intel/boards/bytcr_rt5640.c
@@ -796,6 +796,17 @@ static const struct dmi_system_id byt_rt5640_quirk_table[] = {
 					BYT_RT5640_SSP0_AIF1 |
 					BYT_RT5640_MCLK_EN),
 	},
+	{	/* HP Stream 8 */
+		.matches = {
+			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "Hewlett-Packard"),
+			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "HP Stream 8 Tablet"),
+		},
+		.driver_data = (void *)(BYTCR_INPUT_DEFAULTS |
+					BYT_RT5640_MONO_SPEAKER |
+					BYT_RT5640_JD_NOT_INV |
+					BYT_RT5640_SSP0_AIF1 |
+					BYT_RT5640_MCLK_EN),
+	},
 	{	/* I.T.Works TW891 */
 		.matches = {
 			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "To be filled by O.E.M."),
-- 
2.37.2

