Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E015677056
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Jan 2023 16:50:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231468AbjAVPt6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Jan 2023 10:49:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229879AbjAVPt4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jan 2023 10:49:56 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 829001ABF4
        for <linux-kernel@vger.kernel.org>; Sun, 22 Jan 2023 07:49:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674402548;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=DFbyoejAIdnfrNzW5cK4QSeXywphc6GIMI0C0e0eVJM=;
        b=CbU8lL3TaKYuXqAw40foTB/pCjJw694idVIJbmX6YnzRkLLbCJcQQZIWmi95C7nDObjCdv
        0PjpSqltHZsmaOLAidL3Ir25ML5p4jtUYO3wGE8J33PsZX5fRCYUZZkU9eGCgI4UzResmr
        xP+ktaJDz+tMQ0YAecsG1M8pQNShLCw=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-97-RFalcc1lMAu235Yc8whtlA-1; Sun, 22 Jan 2023 10:49:07 -0500
X-MC-Unique: RFalcc1lMAu235Yc8whtlA-1
Received: by mail-qk1-f198.google.com with SMTP id bp33-20020a05620a45a100b007090e2e1b0cso5634072qkb.16
        for <linux-kernel@vger.kernel.org>; Sun, 22 Jan 2023 07:49:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DFbyoejAIdnfrNzW5cK4QSeXywphc6GIMI0C0e0eVJM=;
        b=mvhHan8SQoyMn2+EH7jrMx4A2AEo/HVPxOWL9XdDQvfNV8u/4cHeQ7cWu//6HIZ+fq
         hy+kIgVHzKLE/BzmvvQbim6GGTltUsyRCo6UwpKphxqsybcruYe/RFuv9lSoucTiX4KN
         bC7zAn5bKAu6JCT2nlpj9IQIVWBdFZ3HVxxDHHGW7/Mw8i2KKrjLm9KCJhmRx3Zp/nK0
         bLWjvAC4Jx2n7uXNdGkP9r1O8DRAr1cv4oLhDltYON8eIa02a18dn93y/CQhr6VYW/Xv
         OPh52g+fDUnuvHKS4hMgLYYoWDFrs6Mu3FajtneHkKyWrXsEG98vpkQy2jbJZC+0Kg+V
         7plg==
X-Gm-Message-State: AFqh2krgawGemfK+UMxQ24R3cCkXJqOJkMtgzN5CL2xh7BOZOcxmh5/f
        qw7oZISX4vuRgwln8e2Glvxm6jZyE09xqas7lXs3S6zM+5NXcVTPVsqlGM15GqFQ4qqo6GHMtKb
        Mti8OIkZff2vcw7xiCT/UdCYp
X-Received: by 2002:a05:622a:5d86:b0:3b6:301f:7b3d with SMTP id fu6-20020a05622a5d8600b003b6301f7b3dmr30207700qtb.65.1674402546791;
        Sun, 22 Jan 2023 07:49:06 -0800 (PST)
X-Google-Smtp-Source: AMrXdXtNrJUlEZmoEfpchm9hSMxWlPveAw9LrPSEM9CMrsFLIBcI3fydh1ltFEimuIOjLGnPmhMnKg==
X-Received: by 2002:a05:622a:5d86:b0:3b6:301f:7b3d with SMTP id fu6-20020a05622a5d8600b003b6301f7b3dmr30207677qtb.65.1674402546486;
        Sun, 22 Jan 2023 07:49:06 -0800 (PST)
Received: from localhost.localdomain.com (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id h8-20020a05620a284800b006fa7b5ea2d1sm29932207qkp.125.2023.01.22.07.49.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Jan 2023 07:49:06 -0800 (PST)
From:   Tom Rix <trix@redhat.com>
To:     tim@cyberelk.net, axboe@kernel.dk, nathan@kernel.org,
        ndesaulniers@google.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Tom Rix <trix@redhat.com>
Subject: [PATCH v2] paride/pcd: return earlier when an error happens in pcd_atapi()
Date:   Sun, 22 Jan 2023 07:49:01 -0800
Message-Id: <20230122154901.505142-1-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
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
v2: remove unused 'r' variable
---
 drivers/block/paride/pcd.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/block/paride/pcd.c b/drivers/block/paride/pcd.c
index a5ab40784119..47757ba1a09f 100644
--- a/drivers/block/paride/pcd.c
+++ b/drivers/block/paride/pcd.c
@@ -825,14 +825,14 @@ static int pcd_audio_ioctl(struct cdrom_device_info *cdi, unsigned int cmd, void
 			struct cdrom_tochdr *tochdr =
 			    (struct cdrom_tochdr *) arg;
 			char buffer[32];
-			int r;
 
-			r = pcd_atapi(cd, cmd, 12, buffer, "read toc header");
+			if (pcd_atapi(cd, cmd, 12, buffer, "read toc header"))
+				return -EIO;
 
 			tochdr->cdth_trk0 = buffer[2];
 			tochdr->cdth_trk1 = buffer[3];
 
-			return r ? -EIO : 0;
+			return 0;
 		}
 
 	case CDROMREADTOCENTRY:
@@ -845,13 +845,13 @@ static int pcd_audio_ioctl(struct cdrom_device_info *cdi, unsigned int cmd, void
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
@@ -866,7 +866,7 @@ static int pcd_audio_ioctl(struct cdrom_device_info *cdi, unsigned int cmd, void
 				    (((((buffer[8] << 8) + buffer[9]) << 8)
 				      + buffer[10]) << 8) + buffer[11];
 
-			return r ? -EIO : 0;
+			return 0;
 		}
 
 	default:
-- 
2.26.3

