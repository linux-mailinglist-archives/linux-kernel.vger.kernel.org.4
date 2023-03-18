Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61D3D6BFA43
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Mar 2023 14:32:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229765AbjCRNcl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Mar 2023 09:32:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbjCRNcg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Mar 2023 09:32:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E152D303FE
        for <linux-kernel@vger.kernel.org>; Sat, 18 Mar 2023 06:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679146311;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=UUlLexOxTlL2rJRhRjOGMCzDKj9OAhc0E+V/p5S5fiE=;
        b=jArS4nr6mhEG8F7rxxXf7N1prgjFCwNzldcUHAhikbwg3aXjU128BVy8BfEFTchwBHUrcF
        84EaoBzFPmocNILireQnOtMxAWqCFL1HKG0kyB1UlE2Mzd7aNSfdwxOwXQ41YIt7KHCpOi
        DFnXEziTkcgWwMLPiVKV/u8wg/8K/wA=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-631-8m6LSvLHOcaw01M2B7QReA-1; Sat, 18 Mar 2023 09:31:49 -0400
X-MC-Unique: 8m6LSvLHOcaw01M2B7QReA-1
Received: by mail-qk1-f197.google.com with SMTP id o9-20020a05620a228900b0074585d47b77so3732145qkh.0
        for <linux-kernel@vger.kernel.org>; Sat, 18 Mar 2023 06:31:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679146309;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UUlLexOxTlL2rJRhRjOGMCzDKj9OAhc0E+V/p5S5fiE=;
        b=7WMOkGI4/6hKU/s5fxbE5Wnc27M3IRk+EgGDu2IJwpewa0NREjwlSfnmc0PMeYXb5r
         k+6acUHZZwUj7bQWmONzV33JM3HQwI0tNaL60a3+vYiysMBC8giMp+8BAPMgCjTAgkZx
         JlbFMR9Go//h52T8qHA/VF3+/zcIP8ov3Lb/RRMbdUG4WsAprFaBua1zYcMEYrVkXu4F
         IIMB82AE6+w6jHeYhrEchc3YIi6bD9mUMniNrg2QrbgLS1lcqjJ0lGoNKiUq/SLguu55
         sKwkXhOzoUIGrC4L9bHDSpphu1DweaMWEc7fvMmhQ1Sp99NqKuONMjiTAHtEAS4Sv7zd
         cwQg==
X-Gm-Message-State: AO0yUKXGbOMkhwUxzt0qKAmvzmB3+KNZwX90C3COfrYNQvgDhm1vzvJ+
        7oBwsJ55bb1raGjAqC5ppvrPlpxJTbQQDlNu7q9ImAq6uyj8RF/nCTxENYyw2fSGnXdpMFqEElE
        OO5RDoRml6jiviwQgnZgCtUWV
X-Received: by 2002:a05:6214:5281:b0:56e:bc62:e151 with SMTP id kj1-20020a056214528100b0056ebc62e151mr46569157qvb.7.1679146309201;
        Sat, 18 Mar 2023 06:31:49 -0700 (PDT)
X-Google-Smtp-Source: AK7set+PZFX2mVoz7k+s6UMIaLaX9bdTOGY4ZLkhjSi2vKRtz+hqyRNo8gymhk+SaWflKTunQ1zwDg==
X-Received: by 2002:a05:6214:5281:b0:56e:bc62:e151 with SMTP id kj1-20020a056214528100b0056ebc62e151mr46569138qvb.7.1679146309006;
        Sat, 18 Mar 2023 06:31:49 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id p16-20020a05620a057000b00746476405bbsm3566936qkp.122.2023.03.18.06.31.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Mar 2023 06:31:48 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
To:     perex@perex.cz, tiwai@suse.com, nathan@kernel.org,
        ndesaulniers@google.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Tom Rix <trix@redhat.com>
Subject: [PATCH] ALSA: ymfpci: remove unused snd_ymfpci_readb function
Date:   Sat, 18 Mar 2023 09:27:08 -0400
Message-Id: <20230318132708.1684504-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

clang with W=1 reports
sound/pci/ymfpci/ymfpci_main.c:34:18: error:
  unused function 'snd_ymfpci_readb' [-Werror,-Wunused-function]
static inline u8 snd_ymfpci_readb(struct snd_ymfpci *chip, u32 offset)
                 ^
This static function is not used, so remove it.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 sound/pci/ymfpci/ymfpci_main.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/sound/pci/ymfpci/ymfpci_main.c b/sound/pci/ymfpci/ymfpci_main.c
index c80114c0ad7b..2858736ed20a 100644
--- a/sound/pci/ymfpci/ymfpci_main.c
+++ b/sound/pci/ymfpci/ymfpci_main.c
@@ -31,11 +31,6 @@
 
 static void snd_ymfpci_irq_wait(struct snd_ymfpci *chip);
 
-static inline u8 snd_ymfpci_readb(struct snd_ymfpci *chip, u32 offset)
-{
-	return readb(chip->reg_area_virt + offset);
-}
-
 static inline void snd_ymfpci_writeb(struct snd_ymfpci *chip, u32 offset, u8 val)
 {
 	writeb(val, chip->reg_area_virt + offset);
-- 
2.27.0

