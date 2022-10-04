Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7B355F3C9D
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 08:00:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbiJDGAl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 02:00:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbiJDGAj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 02:00:39 -0400
Received: from sender4-of-o54.zoho.com (sender4-of-o54.zoho.com [136.143.188.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 064281F9E9
        for <linux-kernel@vger.kernel.org>; Mon,  3 Oct 2022 23:00:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1664863234; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=ZEbQBIhqnx6r26zkgBtrW6CmK1qvawHHsqhGYGP2RTRXkMhr3DZaInv6A5glgbgxxWYN0wAxX5R6zj69LZqp7L4TGqF90Gk9uY1B5H2gAN2eHN7WmPGMseGPn9ctOF788geo2QLT/a6RrLi7rak1fw6nqxZ2grjDQCxBrjVzuyI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1664863234; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:MIME-Version:Message-ID:Subject:To; 
        bh=1I+MEjV1sb13VcayWxjCGLKdhMDssAr2EziDW10zAXk=; 
        b=cPO7EFJfzNuYxJQr6azTH7TOEVs5vK/uB61B6cdTHneR+FxOVMWP7Vbp2Dz1cfbf6mLA/VVpiJC+qBhAihkRAN4AIsxF+xZ2mwm31T5TKCnAJkp9/AfTmsbBTRy/KDVc5iBMP/1UXzcrdfD/8ni736xIwTbfZEj5gBsY33ErfR8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        spf=pass  smtp.mailfrom=business@elijahpepe.com;
        dmarc=pass header.from=<business@elijahpepe.com>
Received: from mail.zoho.com by mx.zohomail.com
        with SMTP id 1664863233471920.7248626356222; Mon, 3 Oct 2022 23:00:33 -0700 (PDT)
Date:   Mon, 03 Oct 2022 23:00:33 -0700
From:   Elijah Conners <business@elijahpepe.com>
To:     "linux-kernel" <linux-kernel@vger.kernel.org>
Cc:     "torvalds" <torvalds@linux-foundation.org>,
        "akpm" <akpm@linux-foundation.org>
Message-ID: <183a194e5b2.b4c21f801465428.4840337107644927802@elijahpepe.com>
In-Reply-To: 
Subject: [PATCH] lib/zlib: define rc
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The __gunzip() and zlib_inflate_blob() functions refer to the
zlib_inflateEnd() function, although this function has no side effects.
In the former's case, it's likely that rc (the result of the function)
was meant to be set to the the result of zlib_inflateEnd(), while
zlib_inflate_blob() has no use for this function in rc.

Signed-off-by: Elijah Conners <business@elijahpepe.com>
---
 lib/decompress_inflate.c   | 2 +-
 lib/zlib_inflate/infutil.c | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/lib/decompress_inflate.c b/lib/decompress_inflate.c
index 6130c42b8e59..df03d1919925 100644
--- a/lib/decompress_inflate.c
+++ b/lib/decompress_inflate.c
@@ -177,7 +177,7 @@ STATIC int INIT __gunzip(unsigned char *buf, long len,
 		}
 	}
 
-	zlib_inflateEnd(strm);
+	rc = zlib_inflateEnd(strm);
 	if (pos)
 		/* add + 8 to skip over trailer */
 		*pos = strm->next_in - zbuf+8;
diff --git a/lib/zlib_inflate/infutil.c b/lib/zlib_inflate/infutil.c
index 4824c2cc7a09..588839fff01d 100644
--- a/lib/zlib_inflate/infutil.c
+++ b/lib/zlib_inflate/infutil.c
@@ -37,7 +37,6 @@ int zlib_inflate_blob(void *gunzip_buf, unsigned int sz,
 			rc = sz - strm->avail_out;
 		else
 			rc = -EINVAL;
-		zlib_inflateEnd(strm);
 	} else
 		rc = -EINVAL;
 
-- 
2.29.2.windows.2
