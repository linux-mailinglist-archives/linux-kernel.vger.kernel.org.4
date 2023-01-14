Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25C4866ACBF
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Jan 2023 18:01:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230249AbjANRBc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Jan 2023 12:01:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230095AbjANRBa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jan 2023 12:01:30 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A768D30DB
        for <linux-kernel@vger.kernel.org>; Sat, 14 Jan 2023 09:01:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673715688;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=UL5uNX54JKFtg06F7nCs9+yy2MAYTYW/oHNsNWT8Z7o=;
        b=iejMa8HidabRbSAncnqTMRTNRxauIgS8JN5nr6XRlXG13vzWS4+F5z/xiufi2tLvRbIStx
        kLHwNSaAEEwF2J4UAwlt5zIKPuLPAXROkxR/182inNjqNqcWPuSMkmN0/y3BeL6Ah5fbm9
        esXaFNSqJvVdtR7t5hLBSU9pwmKPkiQ=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-516-9SSuXnMHOqiOjYyKFc6c2A-1; Sat, 14 Jan 2023 12:01:17 -0500
X-MC-Unique: 9SSuXnMHOqiOjYyKFc6c2A-1
Received: by mail-yb1-f199.google.com with SMTP id z17-20020a25e311000000b00719e04e59e1so26463701ybd.10
        for <linux-kernel@vger.kernel.org>; Sat, 14 Jan 2023 09:01:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UL5uNX54JKFtg06F7nCs9+yy2MAYTYW/oHNsNWT8Z7o=;
        b=QJcEavvdkx2xXihKucp3kDImychXMbgnfsQUq1tYLtQKnQozrnN2awlmsmCrc2xYSl
         tJZjzZDMTrDlQ/BnC4VwdXFxA8dy4yS+w+8qtSM8bx+knLLRnWjG1YkWaQ3FfFUFjmF+
         wTHEnCaCmwvYsVUtGeoAZVoQ36qnT3jjVhhZwgmOKXawFKVmpeiOmnZqW1jJ1+Mxwk1B
         Ueb8kL9cMb85xATHjPXU614elaOW7cUtfCB1CpTo5F6hEggoXxOZnI2flb8dAs4Zo4TF
         05EbNpw8dqGNt+3P7Q+R76jbFSeos34RbyGLRa6HDoRmn75facKRgVekfJUPXjxnTAiS
         oUqw==
X-Gm-Message-State: AFqh2kpNLCf/Zu49dk8yeYmI8mwqS2EDwjOfyJUwqGuSOKFQrur/vsfb
        +mGN1G+V2KosAtcc/RufWLyurLWPULnmoaAto+0E3S/lcX5ZIUOIHHahHFm+lN0F6+dEtK6EEGu
        +EF7G0QMGGO6xAjmKnXoYNIHq
X-Received: by 2002:a25:e792:0:b0:7d1:d26b:7eaa with SMTP id e140-20020a25e792000000b007d1d26b7eaamr3683921ybh.39.1673715676743;
        Sat, 14 Jan 2023 09:01:16 -0800 (PST)
X-Google-Smtp-Source: AMrXdXtr8avWN03TzTzhlRuzCN6sYiu2T5Bek5rUhuA0So+cSWahDMdGma5psLhGPToohX8uBWTwcg==
X-Received: by 2002:a25:e792:0:b0:7d1:d26b:7eaa with SMTP id e140-20020a25e792000000b007d1d26b7eaamr3683890ybh.39.1673715676289;
        Sat, 14 Jan 2023 09:01:16 -0800 (PST)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id bl41-20020a05620a1aa900b007059c5929b8sm14637969qkb.21.2023.01.14.09.01.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Jan 2023 09:01:15 -0800 (PST)
From:   Tom Rix <trix@redhat.com>
To:     tim@cyberelk.net, axboe@kernel.dk, nathan@kernel.org,
        ndesaulniers@google.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Tom Rix <trix@redhat.com>
Subject: [PATCH] paride/pcd: return earlier when an error happens in pcd_atapi()
Date:   Sat, 14 Jan 2023 12:01:13 -0500
Message-Id: <20230114170113.3985630-1-trix@redhat.com>
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

clang static analysis reports
drivers/block/paride/pcd.c:856:36: warning: The left operand of '&'
  is a garbage value [core.UndefinedBinaryOperatorResult]
  tocentry->cdte_ctrl = buffer[5] & 0xf;
                        ~~~~~~~~~ ^

When the call to pcd_atapi() fails, buffer[] is in an unknown state,
so return early.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/block/paride/pcd.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/block/paride/pcd.c b/drivers/block/paride/pcd.c
index a5ab40784119..4524d8880463 100644
--- a/drivers/block/paride/pcd.c
+++ b/drivers/block/paride/pcd.c
@@ -827,12 +827,13 @@ static int pcd_audio_ioctl(struct cdrom_device_info *cdi, unsigned int cmd, void
 			char buffer[32];
 			int r;
 
-			r = pcd_atapi(cd, cmd, 12, buffer, "read toc header");
+			if (pcd_atapi(cd, cmd, 12, buffer, "read toc header"))
+				return -EIO;
 
 			tochdr->cdth_trk0 = buffer[2];
 			tochdr->cdth_trk1 = buffer[3];
 
-			return r ? -EIO : 0;
+			return 0;
 		}
 
 	case CDROMREADTOCENTRY:
@@ -845,13 +846,13 @@ static int pcd_audio_ioctl(struct cdrom_device_info *cdi, unsigned int cmd, void
 			struct cdrom_tocentry *tocentry =
 			    (struct cdrom_tocentry *) arg;
 			unsigned char buffer[32];
-			int r;
 
 			cmd[1] =
 			    (tocentry->cdte_format == CDROM_MSF ? 0x02 : 0);
 			cmd[6] = tocentry->cdte_track;
 
-			r = pcd_atapi(cd, cmd, 12, buffer, "read toc entry");
+			if (pcd_atapi(cd, cmd, 12, buffer, "read toc entry"))
+				return -EIO;
 
 			tocentry->cdte_ctrl = buffer[5] & 0xf;
 			tocentry->cdte_adr = buffer[5] >> 4;
@@ -866,7 +867,7 @@ static int pcd_audio_ioctl(struct cdrom_device_info *cdi, unsigned int cmd, void
 				    (((((buffer[8] << 8) + buffer[9]) << 8)
 				      + buffer[10]) << 8) + buffer[11];
 
-			return r ? -EIO : 0;
+			return 0;
 		}
 
 	default:
-- 
2.27.0

