Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 263746C97E8
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Mar 2023 22:58:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230212AbjCZU6I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Mar 2023 16:58:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjCZU6G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Mar 2023 16:58:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCBB53C12
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 13:57:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679864238;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=ufG0EzSJoZX2ZjEcM3na2tjubK9S5CNNR2tM4hGa6ao=;
        b=imCeriiRy6xpHj6BGV5Tnqe/9IJ7Ko3qV5d3vBr00qZDDkzx+qIOAWTGy/GuU4l4/eAW6q
        Gh+sPQyCNoptf1VRbTLYoiHkpN+NjMSg4pQTDMI8S0aEO8IaEBKrE8p8nEnk7DeLABCWK/
        KpMA1FG2dslzx7Sde5D8Rx6ij9VO32A=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-157-neb1imPEONa0eIHZAx2xQQ-1; Sun, 26 Mar 2023 16:57:16 -0400
X-MC-Unique: neb1imPEONa0eIHZAx2xQQ-1
Received: by mail-qt1-f197.google.com with SMTP id h6-20020ac85846000000b003e3c23d562aso4764517qth.1
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 13:57:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679864236;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ufG0EzSJoZX2ZjEcM3na2tjubK9S5CNNR2tM4hGa6ao=;
        b=cGuMv9n3JM3wXqmlnvtlahUGX8748k38fCJ6JZwjGJAV/5QDTN3uh9bJNfZJe233tU
         0ej8zssJ7ffowJBnkrJknaMSOqB8+E6i8Lv/+wW9AlgSS7Ioir5Jq2/Fyl3HytEtLihI
         V5aontkzTDiC0p6kG37kaWOmbGz2sqMClhfPNfH6Mv6VqgVKwhHneEwLVzazBddZdI43
         oPdoF6sVmV5cMFp1VEKLlShkORTL4i30PbvaBvK1IEtkg/G0BaNbNQh8hRmFT3jDAXHw
         es99hTa3duNCYTF0jkuSuGQv+P8n2XBHjiNDMed/zwzn+zD0rDT1SXHxcHTd9o+WhNGw
         FZDg==
X-Gm-Message-State: AAQBX9eXBT0MnJGfBZAJ2J3uOPguaxOmucYGDyzGCZh91utCn99YohON
        Lklg22oQz7COyM8iKsbHjW5bZDJ0IoRHzPYKOwUXsvCeU3V0tjOraccZMu5pXJ7zfAnh8V6ETvR
        AM3ms/QDOA3MC+rq3XxAS61tW
X-Received: by 2002:a05:6214:27c6:b0:5cd:f9fd:f66a with SMTP id ge6-20020a05621427c600b005cdf9fdf66amr17047954qvb.0.1679864235981;
        Sun, 26 Mar 2023 13:57:15 -0700 (PDT)
X-Google-Smtp-Source: AKy350bvbaW/HvmNUD1O5GI6KZgnKPbVGv3bPPwbsQ+CWQB5zxGNwM7H9VkAJkVX4CFGJxeRjvsYFQ==
X-Received: by 2002:a05:6214:27c6:b0:5cd:f9fd:f66a with SMTP id ge6-20020a05621427c600b005cdf9fdf66amr17047944qvb.0.1679864235774;
        Sun, 26 Mar 2023 13:57:15 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id l4-20020ad44244000000b005dd8b9345cesm2409267qvq.102.2023.03.26.13.57.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Mar 2023 13:57:15 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
To:     perex@perex.cz, tiwai@suse.com, nathan@kernel.org,
        ndesaulniers@google.com, wangjianli@cdjrlc.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Tom Rix <trix@redhat.com>
Subject: [PATCH] ALSA: remove unused loop_count variable
Date:   Sun, 26 Mar 2023 16:57:12 -0400
Message-Id: <20230326205712.1358918-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

clang with W=1 reports
sound/pci/asihpi/hpi6000.c:1256:6: error: variable
  'loop_count' set but not used [-Werror,-Wunused-but-set-variable]
        u32 loop_count = 0;
            ^
This variable is not used so remove it.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 sound/pci/asihpi/hpi6000.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/pci/asihpi/hpi6000.c b/sound/pci/asihpi/hpi6000.c
index 88d902997b74..72aa135d69f8 100644
--- a/sound/pci/asihpi/hpi6000.c
+++ b/sound/pci/asihpi/hpi6000.c
@@ -1253,7 +1253,6 @@ static u16 hpi6000_dsp_block_read32(struct hpi_adapter_obj *pao,
 	int local_count = count;
 	int xfer_size;
 	u32 *pdata = dest;
-	u32 loop_count = 0;
 
 	while (local_count) {
 		if (local_count > c6711_burst_size)
@@ -1273,7 +1272,6 @@ static u16 hpi6000_dsp_block_read32(struct hpi_adapter_obj *pao,
 		pdata += xfer_size;
 		local_hpi_address += sizeof(u32) * xfer_size;
 		local_count -= xfer_size;
-		loop_count++;
 	}
 
 	if (time_out)
-- 
2.27.0

