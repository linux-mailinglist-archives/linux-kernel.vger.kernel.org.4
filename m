Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72EA6659B22
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 18:54:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235411AbiL3Ryl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Dec 2022 12:54:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235389AbiL3Ryi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Dec 2022 12:54:38 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25C6E1C13A
        for <linux-kernel@vger.kernel.org>; Fri, 30 Dec 2022 09:53:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1672422832;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=zS+ReCHhGkT7QFOC9TzYb6JxbQDrW1Wtluedpd2unG0=;
        b=Vpvbx2bQT5y6No3u5bhDJsVS17VWFQ7OfrZ96riCTOgIDEVyM4CX0EB7kyjRGA56jG0I3L
        r1gSENRk1eME8Z4D2N8O6VQ7ZjfCdiKjAv4DiFPl4BkfHGJmT27MXP+tlGLoUceUNAdNrr
        wx5QhKQ50CaFBKY64rzTg7m9oAjfpuk=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-593-hJu_48QIP8Od4EDSm3HT6Q-1; Fri, 30 Dec 2022 12:53:50 -0500
X-MC-Unique: hJu_48QIP8Od4EDSm3HT6Q-1
Received: by mail-qk1-f198.google.com with SMTP id bl3-20020a05620a1a8300b0070240ff36a0so15057122qkb.19
        for <linux-kernel@vger.kernel.org>; Fri, 30 Dec 2022 09:53:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zS+ReCHhGkT7QFOC9TzYb6JxbQDrW1Wtluedpd2unG0=;
        b=0xzqS/LfqvIlUQNOOtCiI01k6JxRhGkffCXVe1psRGzD+O/1YZ8Y0C8TKoRTPtwjfL
         29cAVTWMA5e4sDBOYFaXYR096S+SbZUVZwPjGsixWy0ARfxmuKxa7dGeSSXfcDwBesQK
         nnHXj5tJzHVNf/e8HLIbBSMzHe34uVekOu/0j781JSDiQA9rx1RkKSa5gYNUiMSTPB2f
         278f++O2LdwR9S55r3syYfzHcxIP1WkNXH5Qwr2/Dsld5nG8w0Z2WIezp+dVocXQsLv2
         cnk0eWRTI+Agnu1w3JxD3hXclQ5QXSpT6QfynozE3w5IjGTz1+VOSvGOQxZEP3wi69DN
         dtGA==
X-Gm-Message-State: AFqh2korTrKLRFdn+jQhqLLDbI0c2u320UKi2lglc4A9e5Ptf7L9yleC
        MOP+RKeR9Xb39KSrXjmolm0e+Q7DreGKYnloqueY6FIXeQpojzB0ykzWbB/YIXz+ud0oa2+155g
        zoxdB6/C6tonWeD5YSAPFWI2P
X-Received: by 2002:a05:6214:2c06:b0:4e3:6a82:82ba with SMTP id lc6-20020a0562142c0600b004e36a8282bamr52843354qvb.33.1672422830300;
        Fri, 30 Dec 2022 09:53:50 -0800 (PST)
X-Google-Smtp-Source: AMrXdXswfUPFOUWp5uj7+1onFko68tLORHS1oNTFHjSp5SlL0aRkvPDcNnc+hUanoY6Xqlx2KsRGIA==
X-Received: by 2002:a05:6214:2c06:b0:4e3:6a82:82ba with SMTP id lc6-20020a0562142c0600b004e36a8282bamr52843333qvb.33.1672422830083;
        Fri, 30 Dec 2022 09:53:50 -0800 (PST)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id t1-20020a37ea01000000b006fefa5f7fcesm15621878qkj.10.2022.12.30.09.53.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Dec 2022 09:53:49 -0800 (PST)
From:   Tom Rix <trix@redhat.com>
To:     jack@suse.com, nathan@kernel.org, ndesaulniers@google.com
Cc:     linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] udf: initialize newblock to 0
Date:   Fri, 30 Dec 2022 12:53:41 -0500
Message-Id: <20221230175341.1629734-1-trix@redhat.com>
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

The clang build reports this error
fs/udf/inode.c:805:6: error: variable 'newblock' is used uninitialized whenever 'if' condition is true [-Werror,-Wsometimes-uninitialized]
        if (*err < 0)
            ^~~~~~~~
newblock is never set before error handling jump.
Initialize newblock to 0 and remove redundant settings.

Fixes: d8b39db5fab8 ("udf: Handle error when adding extent to a file")
Signed-off-by: Tom Rix <trix@redhat.com>
---
 fs/udf/inode.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/udf/inode.c b/fs/udf/inode.c
index 4a912e2edcec..31965c3798f2 100644
--- a/fs/udf/inode.c
+++ b/fs/udf/inode.c
@@ -604,7 +604,7 @@ static sector_t inode_getblk(struct inode *inode, sector_t block,
 	struct kernel_lb_addr eloc, tmpeloc;
 	int c = 1;
 	loff_t lbcount = 0, b_off = 0;
-	udf_pblk_t newblocknum, newblock;
+	udf_pblk_t newblocknum, newblock = 0;
 	sector_t offset = 0;
 	int8_t etype;
 	struct udf_inode_info *iinfo = UDF_I(inode);
@@ -710,7 +710,6 @@ static sector_t inode_getblk(struct inode *inode, sector_t block,
 		ret = udf_do_extend_file(inode, &prev_epos, laarr, hole_len);
 		if (ret < 0) {
 			*err = ret;
-			newblock = 0;
 			goto out_free;
 		}
 		c = 0;
@@ -775,7 +774,6 @@ static sector_t inode_getblk(struct inode *inode, sector_t block,
 				goal, err);
 		if (!newblocknum) {
 			*err = -ENOSPC;
-			newblock = 0;
 			goto out_free;
 		}
 		if (isBeyondEOF)
-- 
2.27.0

