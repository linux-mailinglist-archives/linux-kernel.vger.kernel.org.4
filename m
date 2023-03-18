Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 530316BFA92
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Mar 2023 14:53:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbjCRNxZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Mar 2023 09:53:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjCRNxX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Mar 2023 09:53:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C90E28E52
        for <linux-kernel@vger.kernel.org>; Sat, 18 Mar 2023 06:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679147556;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=8JKKCoHtsIdOT+kL0un84AUvIlxjWeKq5FTVFUrPKc8=;
        b=a0IFvur6sWRRuA8BQGD60iuf1oNh6q5wOOpAAAQD2Hl5aBNIjnR4NqcpL1v1jKj2VQ314t
        RNi/PT548ugDYstD3R1YOnq9SFEzgnM7WO32Gn8YsqVPGyfD0i7GuV+LZQQCxicJAZC3VL
        gDPgMDx/LwKHI9qAL1o8m60G8HpcHPE=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-202-1UMNHBhFMR2Q3qgce83dkg-1; Sat, 18 Mar 2023 09:52:35 -0400
X-MC-Unique: 1UMNHBhFMR2Q3qgce83dkg-1
Received: by mail-qk1-f198.google.com with SMTP id d21-20020a05620a141500b00745e786ddd5so3694204qkj.19
        for <linux-kernel@vger.kernel.org>; Sat, 18 Mar 2023 06:52:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679147554;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8JKKCoHtsIdOT+kL0un84AUvIlxjWeKq5FTVFUrPKc8=;
        b=GkaCIzjLSd2mcZ22Vz394Ezm0CVnfbenq7pdW5bL6WoDPCy6OW4XGdffRfEyLUQoN6
         yfRqaYrxtPJU+QZdAhme+uaA0u7IQ0qU5E9CJy4f1LfQ0GmKk7/mz3cLsK9VwflIOOPE
         NrLArYUVsZMmhUJwQfIkwBBhlMyZzrUFVEXUQJ7gwmKcKverxfG+8O6A96rgSBBqjXIX
         ZCOR+d8GpRhqAdGU5njZgbn+zFe77OATeuCEUKlwBNt74sQX5acvy37KPMgGFOGrW0W/
         06tYTV1SUg2DVFLddqojWFxngOv8SWrwVk3MezcrrBZCZ3HQyAY+USXGOYjQMqqyc6pW
         4C8w==
X-Gm-Message-State: AO0yUKXoLQZFDkVvmqmy7bCzdnwAZ9ANoPFzX7Alqt47qkRHNkIittAR
        rzIDx5DY7AK2nprlscxcr3REnIzJbhkxh0H3+IHB0dvGD8dWhX3JGkGTYUlRnjBBiJoyCiKmllH
        NP0dC/apoTD3AnnVo2Ip69SWT
X-Received: by 2002:a05:622a:110a:b0:3bf:cd81:399f with SMTP id e10-20020a05622a110a00b003bfcd81399fmr18628189qty.3.1679147554689;
        Sat, 18 Mar 2023 06:52:34 -0700 (PDT)
X-Google-Smtp-Source: AK7set8IGPXW4iPtLnhcFdeE5DBfD6algKbXB9t7jslQwB7wD2STcpXKORYgPtCB7dq5QEEc6Kgcjw==
X-Received: by 2002:a05:622a:110a:b0:3bf:cd81:399f with SMTP id e10-20020a05622a110a00b003bfcd81399fmr18628176qty.3.1679147554463;
        Sat, 18 Mar 2023 06:52:34 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id t72-20020a37464b000000b00725d8d6983asm3626195qka.61.2023.03.18.06.52.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Mar 2023 06:52:34 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
To:     perex@perex.cz, tiwai@suse.com, nathan@kernel.org,
        ndesaulniers@google.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Tom Rix <trix@redhat.com>
Subject: [PATCH] ALSA: portman2x4: remove unused portman_read_command,data functions
Date:   Sat, 18 Mar 2023 09:52:29 -0400
Message-Id: <20230318135229.1685266-1-trix@redhat.com>
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
sound/drivers/portman2x4.c:185:18: error: unused function
  'portman_read_command' [-Werror,-Wunused-function]
static inline u8 portman_read_command(struct portman *pm)
                 ^
sound/drivers/portman2x4.c:195:18: error: unused function
  'portman_read_data' [-Werror,-Wunused-function]
static inline u8 portman_read_data(struct portman *pm)
                 ^
These static functions are not used, so remove them.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 sound/drivers/portman2x4.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/sound/drivers/portman2x4.c b/sound/drivers/portman2x4.c
index 52a656735365..4cdf56a0eb65 100644
--- a/sound/drivers/portman2x4.c
+++ b/sound/drivers/portman2x4.c
@@ -182,21 +182,11 @@ static inline void portman_write_command(struct portman *pm, u8 value)
 	parport_write_control(pm->pardev->port, value);
 }
 
-static inline u8 portman_read_command(struct portman *pm)
-{
-	return parport_read_control(pm->pardev->port);
-}
-
 static inline u8 portman_read_status(struct portman *pm)
 {
 	return parport_read_status(pm->pardev->port);
 }
 
-static inline u8 portman_read_data(struct portman *pm)
-{
-	return parport_read_data(pm->pardev->port);
-}
-
 static inline void portman_write_data(struct portman *pm, u8 value)
 {
 	parport_write_data(pm->pardev->port, value);
-- 
2.27.0

