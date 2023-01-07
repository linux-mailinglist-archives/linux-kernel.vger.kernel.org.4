Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 510B2661129
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Jan 2023 19:50:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232754AbjAGStj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Jan 2023 13:49:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232804AbjAGSt0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jan 2023 13:49:26 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3F321114E
        for <linux-kernel@vger.kernel.org>; Sat,  7 Jan 2023 10:48:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673117319;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=NEY3gLZEXX4WZYkSBG8Y3BNi/aeS/CuZ7LY05TbsVxs=;
        b=A5M+X/hKnsf0KTnxn2tJqyr5SsZI8XLuYaJlT7KXcB7rDu3/y7CHOe9cjBWbojO2t823Ob
        ZEGgjeIIhHLdHKue0ATFemEJtb5z/GmCJtpquYgkD5PyXdYumI74e4KwyoPGcoVj87ELEA
        NfQacyhzutsP5t5uJCyXYVZXPNK+wxc=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-630-siy2TH3XNtmurAFkMuGr7Q-1; Sat, 07 Jan 2023 13:48:37 -0500
X-MC-Unique: siy2TH3XNtmurAFkMuGr7Q-1
Received: by mail-qv1-f69.google.com with SMTP id nt2-20020a0562143c0200b004c74f7ec3afso2714155qvb.2
        for <linux-kernel@vger.kernel.org>; Sat, 07 Jan 2023 10:48:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NEY3gLZEXX4WZYkSBG8Y3BNi/aeS/CuZ7LY05TbsVxs=;
        b=lGEJjtuBhh/DIv9uYbmi5fiuHjrtXrX/8GmoiBO5FrW7u+VRBI8v2/qnz+RxP4AdYU
         1u/RI1tM/kDI/0g73X+FgE3FSALvhAJR2+hRJghocAx4OqHvHRHV3loPQW1t4BJkzKmg
         tL8DsGRHckpskzsX+ZOwwjBLPK1+wfOHY8mlwnFm84F21eM8IJ/gIcZb4zoxtASX23ET
         /3QzPhSeLSMA2aVkHuBjEpMMqYldUs6IRZI4DwIMUN39UhMnt7Lphq3j3esvlytuH4he
         ct5RryxqQ2CyE/Ti/UhLxiAepGwq+NudX0XYYBMA9PsRe2txE53hwzrXMNimsBh8Vxvg
         jUow==
X-Gm-Message-State: AFqh2kqZolmD4a70LLt3fUwtdxAN3ETBziiyeAFILGv4bCr8NccScMKx
        Q2xNo8DRJHGH4johi1TLs7S25znKJGF9MDk0gRRmXiF5Xuy+HgFSZgN/1mA6n70/ACv7goU3byt
        JpVNRd2rgzXQ4UMu1PLhBUh6g
X-Received: by 2002:ac8:65da:0:b0:3a9:7789:7d1a with SMTP id t26-20020ac865da000000b003a977897d1amr78611122qto.25.1673117316949;
        Sat, 07 Jan 2023 10:48:36 -0800 (PST)
X-Google-Smtp-Source: AMrXdXtved5EwV17svAb1rAH+JvbXZPZmitIXIKm2hTk2L21vpZxb/fRiD3RJLuAtBw+P8ujndGoZQ==
X-Received: by 2002:ac8:65da:0:b0:3a9:7789:7d1a with SMTP id t26-20020ac865da000000b003a977897d1amr78611111qto.25.1673117316729;
        Sat, 07 Jan 2023 10:48:36 -0800 (PST)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id az31-20020a05620a171f00b006fbbdc6c68fsm2535696qkb.68.2023.01.07.10.48.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Jan 2023 10:48:36 -0800 (PST)
From:   Tom Rix <trix@redhat.com>
To:     ogabbay@kernel.org, gregkh@linuxfoundation.org,
        dliberman@habana.ai, osharabi@habana.ai, obitton@habana.ai,
        talcohen@habana.ai
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] habanalabs: remove redundant memset
Date:   Sat,  7 Jan 2023 13:48:27 -0500
Message-Id: <20230107184827.2837347-1-trix@redhat.com>
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

From reviewing the code, the line
  memset(kdata, 0, usize);
is not needed because kdata is either zeroed by
  kdata = kzalloc(asize, GFP_KERNEL);
when allocated at runtime or by
  char stack_kdata[128] = {0};
at compile time.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/accel/habanalabs/common/habanalabs_ioctl.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/accel/habanalabs/common/habanalabs_ioctl.c b/drivers/accel/habanalabs/common/habanalabs_ioctl.c
index 619d56c40b30..949d38527160 100644
--- a/drivers/accel/habanalabs/common/habanalabs_ioctl.c
+++ b/drivers/accel/habanalabs/common/habanalabs_ioctl.c
@@ -1123,8 +1123,6 @@ static long _hl_ioctl(struct file *filep, unsigned int cmd, unsigned long arg,
 			retcode = -EFAULT;
 			goto out_err;
 		}
-	} else if (cmd & IOC_OUT) {
-		memset(kdata, 0, usize);
 	}
 
 	retcode = func(hpriv, kdata);
-- 
2.27.0

