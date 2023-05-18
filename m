Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9C5F708171
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 14:39:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230170AbjERMjV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 08:39:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbjERMjT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 08:39:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A882C10D0
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 05:38:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684413511;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=iXttdsHRrBGhxoXcQIavREPe5niy9TzGkhXZVV3/EiI=;
        b=MCZJcd9MjngkglQ/JAliLZGT3VPn4zZFZRfgIeKsVimij7Xst7/HNwSEVaZrjR9F9ZTeGa
        3KiCyiEwqQMdJpyXnmFNgmGL88MGrr1DkKZ/ZJ6/QcfVME33IOXeAAV9tRIUJScXyPPhSH
        TgFJCnbhnl8lCFdKQZ18DH038v/0JHs=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-353-5GhDtE6lPMCc-9wwGUNinw-1; Thu, 18 May 2023 08:38:30 -0400
X-MC-Unique: 5GhDtE6lPMCc-9wwGUNinw-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-5eee6742285so22612186d6.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 05:38:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684413510; x=1687005510;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iXttdsHRrBGhxoXcQIavREPe5niy9TzGkhXZVV3/EiI=;
        b=H28j5oBCF+nRaYb/ePBIlbQISm2mS2OgokYMwnB+ga9m4aYeJmo6hVt0qc185mAYei
         qSj5TzqpHA0SFtA+cQ5Tk9GKMGifi+Rc+NGbjJWpeFhnDD2CU44iPRCd1lsTF2PYXrAg
         P+NqLJb7bbLZn1tREZoazkQijQBS5Ls3DctzOS//FHVf8yvEL9awMiYJBuGUu7yffoVc
         DS4NzO3lM/bvZQPZRsWuriVp5Nnw6YUB6lUN5vwF30/4hY+6NWlEwymoXP2dxoE7tlXJ
         Ybna4CdxtUha7Ye4Q4V7D9X7/Lr3lOqsWxvNLUto2GuT0MrAftChMg2oD2UPG+UbMbJP
         bDzQ==
X-Gm-Message-State: AC+VfDxfmec4MsIMyYG4itcLp4/ziU/EcuyyGSzqJ5De8V/VYzJZ4kTd
        VuaaMeEj+28Yh82IYej4BwtrUD2oD/mHFJ+culOPRViz+MymwfdZ8lClvk56SSSyE0HSIt237B6
        BJp4B6WFdZQ1tMkNSwDFyUTpj
X-Received: by 2002:a05:6214:202b:b0:61b:6e43:b20 with SMTP id 11-20020a056214202b00b0061b6e430b20mr5362266qvf.42.1684413509948;
        Thu, 18 May 2023 05:38:29 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5yU7z5+Y8txA5JcquWFfOHmX3HJcabkENvEp12Ss0OfnIsUQ1AwMea69zuwfEISdq/mtjwyw==
X-Received: by 2002:a05:6214:202b:b0:61b:6e43:b20 with SMTP id 11-20020a056214202b00b0061b6e430b20mr5362245qvf.42.1684413509712;
        Thu, 18 May 2023 05:38:29 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id m10-20020ae9e00a000000b0074e21136a77sm358162qkk.127.2023.05.18.05.38.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 May 2023 05:38:29 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
To:     perex@perex.cz, tiwai@suse.com, oswald.buddenhagen@gmx.de
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] ALSA: emu10k1: set variables emu1010_routing_info and emu1010_pads_info storage-class-specifier to static
Date:   Thu, 18 May 2023 08:38:26 -0400
Message-Id: <20230518123826.925752-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

smatch reports
sound/pci/emu10k1/emumixer.c:519:39: warning: symbol
  'emu1010_routing_info' was not declared. Should it be static?
sound/pci/emu10k1/emumixer.c:859:36: warning: symbol
  'emu1010_pads_info' was not declared. Should it be static?

These variables are only used in their defining file, so it should be static

Signed-off-by: Tom Rix <trix@redhat.com>
---
 sound/pci/emu10k1/emumixer.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/pci/emu10k1/emumixer.c b/sound/pci/emu10k1/emumixer.c
index 3a7f25f81504..26ed7e2fe053 100644
--- a/sound/pci/emu10k1/emumixer.c
+++ b/sound/pci/emu10k1/emumixer.c
@@ -516,7 +516,7 @@ struct snd_emu1010_routing_info {
 	unsigned n_ins;
 };
 
-const struct snd_emu1010_routing_info emu1010_routing_info[] = {
+static const struct snd_emu1010_routing_info emu1010_routing_info[] = {
 	{
 		/* rev1 1010 */
 		.src_regs = emu1010_src_regs,
@@ -856,7 +856,7 @@ struct snd_emu1010_pads_info {
 	unsigned n_adc_ctls, n_dac_ctls;
 };
 
-const struct snd_emu1010_pads_info emu1010_pads_info[] = {
+static const struct snd_emu1010_pads_info emu1010_pads_info[] = {
 	{
 		/* rev1 1010 */
 		.adc_ctls = snd_emu1010_adc_pads,
-- 
2.27.0

