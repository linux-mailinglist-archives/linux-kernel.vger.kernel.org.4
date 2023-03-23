Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8500C6C71A7
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 21:28:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231135AbjCWU2J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 16:28:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjCWU2H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 16:28:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAF2F1E9F1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 13:27:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679603238;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=OhYpZ8KzjW1wsLxHwkxEX6G5RCZGyESus86bamUc+qA=;
        b=UBnkhYoI4HUqSToUAltT2RId2D2ZDTAs9Q6bfMDA1SMeuce26FMS4yH+Udhq13FKk59iup
        /Sd+Il3eBo5h7AYXch9ZHw/W3iQpFj3qS8wYpBHHbUJqh2Iy2hrk8sFfr2GmbWNO2bGjzS
        yXclclZRXBWUmkpKcVi7UC/maVv9+pM=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-360-qUEb3Ay7Obm_LP1w_9XhAA-1; Thu, 23 Mar 2023 16:27:16 -0400
X-MC-Unique: qUEb3Ay7Obm_LP1w_9XhAA-1
Received: by mail-qt1-f197.google.com with SMTP id u1-20020a05622a198100b003e12a0467easo8554784qtc.11
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 13:27:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679603236;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OhYpZ8KzjW1wsLxHwkxEX6G5RCZGyESus86bamUc+qA=;
        b=wJMKXT/4MAxmzWiJuEdhs1u98c43JyD4ALPSeCLItvGdZp6AVnoVJJAPC6gJ+i+L6D
         IOnTKOSwqnQdccB00FQSMpZeTc60UB15/2lj0eXzR/rXDwYL/4DxeNzqScQ3WlT/3xar
         1vsUXwEcCgi8r6e+p+tpiw4N5QK7TMBmuo7y9ptJUXCOT1mFZEE68i8soI/Zn3f9kgna
         SHhf5Uf4X13NcVaLTe7WfNWeeSP68J2lopoIPIS8Bs7HBiEzL4mMIr9g/vViykHzToFl
         F4pkPnxqGV5AmnXXPWQqASGZZgVomsY46KTiTHJ1Eg5aQsAHPc+FLfHrlxVGdZmXaAUO
         3g0Q==
X-Gm-Message-State: AO0yUKWJ0wgN0LW6YlJ3WjhNxIbx9zrxjfSdu+dvifoRrMuwb0tRLbnU
        aUM0UK2YGVkcu85vcSGkJcDTOsVElTmT4ptBHuw3S6Vtv+Xi4lRWZvIxw7d0T7JUSKU+zBv3/hi
        lJICfimck5dwpa/09O8+mxIT7Mt043yc0
X-Received: by 2002:a05:622a:b:b0:3e3:87b8:8d44 with SMTP id x11-20020a05622a000b00b003e387b88d44mr1268779qtw.21.1679603236379;
        Thu, 23 Mar 2023 13:27:16 -0700 (PDT)
X-Google-Smtp-Source: AK7set9nfcaOOPG+v24oW8TGCbt1FFZkuvDD8XTlbtr5XxZmlwYWNwjdxerj/TRLmVhphIi/iVJv0A==
X-Received: by 2002:a05:622a:b:b0:3e3:87b8:8d44 with SMTP id x11-20020a05622a000b00b003e387b88d44mr1268751qtw.21.1679603236138;
        Thu, 23 Mar 2023 13:27:16 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id f9-20020ac84709000000b003e0c94a6af0sm7986298qtp.53.2023.03.23.13.27.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Mar 2023 13:27:15 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
To:     perex@perex.cz, tiwai@suse.com, nathan@kernel.org,
        ndesaulniers@google.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Tom Rix <trix@redhat.com>
Subject: [PATCH] ALSA: hdspm: remove unused copy_u32_le function
Date:   Thu, 23 Mar 2023 16:27:13 -0400
Message-Id: <20230323202713.2637150-1-trix@redhat.com>
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
sound/pci/rme9652/hdspm.c:6149:19: error: unused function
  'copy_u32_le' [-Werror,-Wunused-function]
static inline int copy_u32_le(void __user *dest, void __iomem *src)
                  ^
This function is not used so remove it.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 sound/pci/rme9652/hdspm.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/sound/pci/rme9652/hdspm.c b/sound/pci/rme9652/hdspm.c
index fa1812e7a49d..267c7848974a 100644
--- a/sound/pci/rme9652/hdspm.c
+++ b/sound/pci/rme9652/hdspm.c
@@ -6146,12 +6146,6 @@ static int snd_hdspm_hwdep_dummy_op(struct snd_hwdep *hw, struct file *file)
 	return 0;
 }
 
-static inline int copy_u32_le(void __user *dest, void __iomem *src)
-{
-	u32 val = readl(src);
-	return copy_to_user(dest, &val, 4);
-}
-
 static int snd_hdspm_hwdep_ioctl(struct snd_hwdep *hw, struct file *file,
 		unsigned int cmd, unsigned long arg)
 {
-- 
2.27.0

