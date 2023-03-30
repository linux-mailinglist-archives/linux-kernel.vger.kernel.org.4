Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCF286D10D9
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 23:28:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230088AbjC3V2u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 17:28:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbjC3V2t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 17:28:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 603B1C17F
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 14:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680211684;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=rt6EJ3ZeV4qq0asIu+DFVmM346d+zHCFno0fyrsIV8Y=;
        b=cwV52hb7p/KMn+wVpqNYDJLUvurHhr10jButSBWJteuHCPdXqSGPRnDRvaSjS9VMzf6Gkw
        8ueARUtTTtw2CPWJQPD+ghCoTg1ER1UcanJF2/gFg+KCE+19da3/A8OLGQK52uQWSS/264
        hA3rIlckzX5X4cwzcWHbcvn90yo4kRs=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-650-r3kBRERzMCmZ-p6nAIAPRQ-1; Thu, 30 Mar 2023 17:28:03 -0400
X-MC-Unique: r3kBRERzMCmZ-p6nAIAPRQ-1
Received: by mail-qt1-f199.google.com with SMTP id v7-20020a05622a188700b003e0e27bbc2eso13292938qtc.8
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 14:28:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680211682;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rt6EJ3ZeV4qq0asIu+DFVmM346d+zHCFno0fyrsIV8Y=;
        b=k+LVetN/xSQrYwPbRxu83leVMGQkZrai/I9xhAxmiXj4WfKHJ45zRPZh1FLWlpXP2+
         6FtQehojVjj1r73CNIvSmGb7ilPbf3xDI763gcynUWZxru+MriDEiLXL015+7iVKPBS7
         ObcBafFBfhLjqwFvsU+cuREflvffBU1liYKB+mUifW6syY11HcovnebRHGsGB41gxcMg
         PKo0+9UoxEW3V5fJ9mrKgiIjJi/5CGPLQCXyM8uNFv51xqiSFwyaYb/WVFnUf05x2W6M
         11wd+YBEtCn24tBo7Z6vE1BC3vE1x7m7onyr+ZrCuTNtiZ3Wp8z1j+Z8ZpYnhNnbETgt
         DbFw==
X-Gm-Message-State: AAQBX9dp15ej67Di0UBAuUuskhcaavYDjLxeNmZD42ejQ1fxGmbdlBhb
        pgBhnhjV0QmvTkNwONZiFp8nebaAOca+pU7MXTUfV8XkbzCXF2rSpMgpeXCHcO6fsxyrMMHcYiH
        FjcqHIhRS454pSHx7QEY0FoUX
X-Received: by 2002:ad4:4eaf:0:b0:570:bf43:48c with SMTP id ed15-20020ad44eaf000000b00570bf43048cmr43188298qvb.17.1680211682480;
        Thu, 30 Mar 2023 14:28:02 -0700 (PDT)
X-Google-Smtp-Source: AKy350bukr0FcRQMc2nG5KrRM/m8w5YgIIaWjKzHx1vTOdwbnYGxASPxDm2TVeIoaQM48y1CP6Db1g==
X-Received: by 2002:ad4:4eaf:0:b0:570:bf43:48c with SMTP id ed15-20020ad44eaf000000b00570bf43048cmr43188280qvb.17.1680211682193;
        Thu, 30 Mar 2023 14:28:02 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id 18-20020a05620a041200b00746059d9c3fsm172156qkp.35.2023.03.30.14.28.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 14:28:01 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
To:     agk@redhat.com, snitzer@kernel.org, nathan@kernel.org,
        ndesaulniers@google.com
Cc:     dm-devel@redhat.com, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Tom Rix <trix@redhat.com>
Subject: [PATCH] dm raid: remove unused d variable
Date:   Thu, 30 Mar 2023 17:27:53 -0400
Message-Id: <20230330212753.1843266-1-trix@redhat.com>
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
drivers/md/dm-raid.c:2212:15: error: variable
  'd' set but not used [-Werror,-Wunused-but-set-variable]
        unsigned int d;
                     ^
This variable is not used so remove it.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/md/dm-raid.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/md/dm-raid.c b/drivers/md/dm-raid.c
index 60632b409b80..2dfd51509647 100644
--- a/drivers/md/dm-raid.c
+++ b/drivers/md/dm-raid.c
@@ -2209,7 +2209,6 @@ static int super_load(struct md_rdev *rdev, struct md_rdev *refdev)
 static int super_init_validation(struct raid_set *rs, struct md_rdev *rdev)
 {
 	int role;
-	unsigned int d;
 	struct mddev *mddev = &rs->md;
 	uint64_t events_sb;
 	uint64_t failed_devices[DISKS_ARRAY_ELEMS];
@@ -2324,7 +2323,6 @@ static int super_init_validation(struct raid_set *rs, struct md_rdev *rdev)
 	 *    to provide capacity for redundancy or during reshape
 	 *    to add capacity to grow the raid set.
 	 */
-	d = 0;
 	rdev_for_each(r, mddev) {
 		if (test_bit(Journal, &rdev->flags))
 			continue;
@@ -2340,8 +2338,6 @@ static int super_init_validation(struct raid_set *rs, struct md_rdev *rdev)
 			if (test_bit(FirstUse, &r->flags))
 				rebuild_and_new++;
 		}
-
-		d++;
 	}
 
 	if (new_devs == rs->raid_disks || !rebuilds) {
-- 
2.27.0

