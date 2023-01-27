Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1080367EAF4
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 17:30:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234921AbjA0Qad (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 11:30:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234149AbjA0Qa1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 11:30:27 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D277D84F9F
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 08:29:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674836961;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=ofwRew2DOV3Mw1UeLOQ6Q9TuhNax0SYEuuABf3JrtUw=;
        b=B9/a7tmdMOlPpP+i1ln4n1YKrNLCDr/r4zEImlFn6wNg3A2Uz+JeMO+CSzj40oC8DRElRa
        R33C/cRFL6q5eDkj9Bj5rFgo692KASfVksTo5QGkcIiCjmUNj+S6ruJ/q5MKo2c1TT3lFF
        5eGN6ZsnQYKLpVtRM3Y6S5TcWhnutMI=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-507-AZTPiJl-M7GZ1A5VCtbEBg-1; Fri, 27 Jan 2023 11:29:19 -0500
X-MC-Unique: AZTPiJl-M7GZ1A5VCtbEBg-1
Received: by mail-qt1-f198.google.com with SMTP id br26-20020a05622a1e1a00b003b62dc86831so2325678qtb.8
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 08:29:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ofwRew2DOV3Mw1UeLOQ6Q9TuhNax0SYEuuABf3JrtUw=;
        b=t8DmMyioiRcf/fhCbQ51NHhITsVD++Mp8t8EPUfl0af7vhSqq5wbNhmIaDS/VEj/b8
         6/10pz8SRtago8qLnbUxNn8+mnq7ZyyUIQNuyXazrFu/AJjkLaEYWs5OZsgUlxdXUl8Z
         sV3xmaD3J2Wpvhbp5mQoiWr/FdcAglxR2C/hrRhWcuEWmNj5l68376UJZAUEn9mnZU/L
         9G6i0+xqDMLwQr4G3pgY53GBLFgCqKwxErPtgenMZCCSsjjZ9VLVhtUcIZ1W4NJkEzqP
         Kfg+CUP0mssbeqINIVXRo3tAMu5Bkzht89KvfZM5/DlB6Tf+h+Ol+MlsLqAzHhUKswaC
         Ttwg==
X-Gm-Message-State: AFqh2kry3hFYnlVrjE26hx0FFt4SUdeS7eFhYfuiqhYYudPk2vVplY4F
        w+vAKwm2WHcs6+Cun5EZcbhHKa7i20aTdgi7iG7sudNzaMs1Ng4YkvJm50rGxuoaJuICWmFMMqz
        KOd8wgMxKMsN6AgIYs6OjwI6r
X-Received: by 2002:a05:622a:1dc4:b0:3b6:3b60:e0 with SMTP id bn4-20020a05622a1dc400b003b63b6000e0mr53812676qtb.31.1674836959130;
        Fri, 27 Jan 2023 08:29:19 -0800 (PST)
X-Google-Smtp-Source: AMrXdXtSLiyiygJZmi9ZkzaLEmBS5d2N0ilOPyqt8mtEc3xpMVZWdQMbtMS/3H1lhJAlOqqr0nPJ2g==
X-Received: by 2002:a05:622a:1dc4:b0:3b6:3b60:e0 with SMTP id bn4-20020a05622a1dc400b003b63b6000e0mr53812657qtb.31.1674836958905;
        Fri, 27 Jan 2023 08:29:18 -0800 (PST)
Received: from localhost.localdomain.com (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id y4-20020ac85244000000b003b6302f2580sm2917033qtn.22.2023.01.27.08.29.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 08:29:18 -0800 (PST)
From:   Tom Rix <trix@redhat.com>
To:     jack@suse.com, nathan@kernel.org, ndesaulniers@google.com
Cc:     linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] udf: remove reporting loc in debug output
Date:   Fri, 27 Jan 2023 08:29:06 -0800
Message-Id: <20230127162906.872395-1-trix@redhat.com>
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

clang build fails with
fs/udf/partition.c:86:28: error: variable 'loc' is uninitialized when used here [-Werror,-Wuninitialized]
                          sb, block, partition, loc, index);
                                                ^~~

loc is now only know when bh is valid.  So remove reporting loc in debug output.

Fixes: 4215db46d538 ("udf: Use udf_bread() in udf_get_pblock_virt15()")
Signed-off-by: Tom Rix <trix@redhat.com>
---
 fs/udf/partition.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/udf/partition.c b/fs/udf/partition.c
index 92765d2f6958..5bcfe78d5cab 100644
--- a/fs/udf/partition.c
+++ b/fs/udf/partition.c
@@ -82,8 +82,8 @@ uint32_t udf_get_pblock_virt15(struct super_block *sb, uint32_t block,
 
 	bh = udf_bread(sbi->s_vat_inode, newblock, 0, &err);
 	if (!bh) {
-		udf_debug("get_pblock(UDF_VIRTUAL_MAP:%p,%u,%u) VAT: %u[%u]\n",
-			  sb, block, partition, loc, index);
+		udf_debug("get_pblock(UDF_VIRTUAL_MAP:%p,%u,%u)\n",
+			  sb, block, partition);
 		return 0xFFFFFFFF;
 	}
 
-- 
2.26.3

