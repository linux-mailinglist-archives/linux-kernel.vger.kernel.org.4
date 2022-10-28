Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5B4D61076F
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 03:49:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236016AbiJ1BtG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 21:49:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235783AbiJ1Bsr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 21:48:47 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F33B3ACA2D
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 18:48:45 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id ml12so3221739qvb.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 18:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ABM6Qj3NxZjFFbqew+a/nfxO7MCA2/sBgc75TPhkyfM=;
        b=le7KQwhYNdT4o/G8faZuKZXaCQiXbXPzBmn798kEV24s0tzqVbeGPRvNyLryj9dAlj
         pPuid4IZ28NwSfPeNRpfKwtRBYyChRs9krVINrXT6P425p7iKXtZg9SnSs9yUfb0xxsu
         fFMJFPz1jG+sZ5c2m2SBaxXwFDX50BiR4FQOnT7Yriyl9sJNKS5ajPzcryjcyWZSJosn
         eg4mlVdL2i7njhKs/KZoF//9ih8iepdsjOb2p65+PKgjFUZKRI75wel6G8JladusSbk7
         tI6tJ1E2VbPB1b5MRRj0FzEQbivYfo07HZ0onwLeZQTL+4odD9kPgJhJ/M/e0AudE6FS
         Wzxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ABM6Qj3NxZjFFbqew+a/nfxO7MCA2/sBgc75TPhkyfM=;
        b=lrj7OxhgMrRRVdEOXbY+LgwL9z04udhy7DNjeH0IDjTLyci3RQIV7JH09Qj+c7gd/I
         FdOMlzK4fbkbSr2fdtzhDP9o2TcQkPnFT3D7JksH06A6KzEmPuLOybWb8ypzaP5Oh2NC
         sVqkcak8rJsubxPgcgEzZE1S3rvlVeUuof1V+tYyRV3o+9jiaRykoT0SPKT4lxLYxLmx
         HErm36xafjXpB5LR5G95IJmojCHsxhhTt/7GMCG0SOcRtcHNDtJStqrkwEpKXUQ25grx
         m6WWwFN4Xrf2RFLiZyeKWp+hMgzWgFgLzG/3k6UNy7SyoKOPEe1C14xsHzXiYXTwrIwF
         XvBA==
X-Gm-Message-State: ACrzQf2+YmLW1X9kvFdNFMB502PhHxd6D/FMRPZ4YSuehYUZSexnwyGY
        TBo2MMkDw0SRzkTXq4HdgWP07yQhu1g=
X-Google-Smtp-Source: AMsMyM6y5o2f6DKZDjf+gGHOkL8khewfMCHI7Y6dO4VQSwBoYqHYaZTUeck/sHhN2PpD0WPVsCCtlw==
X-Received: by 2002:a0c:b256:0:b0:4b1:9f77:91da with SMTP id k22-20020a0cb256000000b004b19f7791damr44783109qve.84.1666921724552;
        Thu, 27 Oct 2022 18:48:44 -0700 (PDT)
Received: from localhost ([2601:589:4102:4c7c:d8d0:78d7:ad97:2651])
        by smtp.gmail.com with ESMTPSA id o18-20020a05620a2a1200b006cddf59a600sm2086846qkp.34.2022.10.27.18.48.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Oct 2022 18:48:44 -0700 (PDT)
From:   Yury Norov <yury.norov@gmail.com>
To:     linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Yury Norov <yury.norov@gmail.com>
Subject: [PATCH 6/6] bitmap: drop _reg_op()
Date:   Thu, 27 Oct 2022 18:48:34 -0700
Message-Id: <20221028014834.572819-7-yury.norov@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221028014834.572819-1-yury.norov@gmail.com>
References: <20221028014834.572819-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that all _reg_op() users are switched to alternative functions,
_reg_op() is not needed anymore.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 lib/bitmap.c | 76 ----------------------------------------------------
 1 file changed, 76 deletions(-)

diff --git a/lib/bitmap.c b/lib/bitmap.c
index 2a85fe16f3fa..4aa4e871c95d 100644
--- a/lib/bitmap.c
+++ b/lib/bitmap.c
@@ -1220,82 +1220,6 @@ void bitmap_fold(unsigned long *dst, const unsigned long *orig,
 }
 #endif /* CONFIG_NUMA */
 
-/*
- * Common code for bitmap_*_region() routines.
- *	bitmap: array of unsigned longs corresponding to the bitmap
- *	pos: the beginning of the region
- *	order: region size (log base 2 of number of bits)
- *	reg_op: operation(s) to perform on that region of bitmap
- *
- * Can set, verify and/or release a region of bits in a bitmap,
- * depending on which combination of REG_OP_* flag bits is set.
- *
- * A region of a bitmap is a sequence of bits in the bitmap, of
- * some size '1 << order' (a power of two), aligned to that same
- * '1 << order' power of two.
- *
- * Returns 1 if REG_OP_ISFREE succeeds (region is all zero bits).
- * Returns 0 in all other cases and reg_ops.
- */
-
-enum {
-	REG_OP_ISFREE,		/* true if region is all zero bits */
-	REG_OP_ALLOC,		/* set all bits in region */
-	REG_OP_RELEASE,		/* clear all bits in region */
-};
-
-static int __reg_op(unsigned long *bitmap, unsigned int pos, int order, int reg_op)
-{
-	int nbits_reg;		/* number of bits in region */
-	int index;		/* index first long of region in bitmap */
-	int offset;		/* bit offset region in bitmap[index] */
-	int nlongs_reg;		/* num longs spanned by region in bitmap */
-	int nbitsinlong;	/* num bits of region in each spanned long */
-	unsigned long mask;	/* bitmask for one long of region */
-	int i;			/* scans bitmap by longs */
-	int ret = 0;		/* return value */
-
-	/*
-	 * Either nlongs_reg == 1 (for small orders that fit in one long)
-	 * or (offset == 0 && mask == ~0UL) (for larger multiword orders.)
-	 */
-	nbits_reg = 1 << order;
-	index = pos / BITS_PER_LONG;
-	offset = pos - (index * BITS_PER_LONG);
-	nlongs_reg = BITS_TO_LONGS(nbits_reg);
-	nbitsinlong = min(nbits_reg,  BITS_PER_LONG);
-
-	/*
-	 * Can't do "mask = (1UL << nbitsinlong) - 1", as that
-	 * overflows if nbitsinlong == BITS_PER_LONG.
-	 */
-	mask = (1UL << (nbitsinlong - 1));
-	mask += mask - 1;
-	mask <<= offset;
-
-	switch (reg_op) {
-	case REG_OP_ISFREE:
-		for (i = 0; i < nlongs_reg; i++) {
-			if (bitmap[index + i] & mask)
-				goto done;
-		}
-		ret = 1;	/* all bits in region free (zero) */
-		break;
-
-	case REG_OP_ALLOC:
-		for (i = 0; i < nlongs_reg; i++)
-			bitmap[index + i] |= mask;
-		break;
-
-	case REG_OP_RELEASE:
-		for (i = 0; i < nlongs_reg; i++)
-			bitmap[index + i] &= ~mask;
-		break;
-	}
-done:
-	return ret;
-}
-
 /**
  * bitmap_find_free_region - find a contiguous aligned mem region
  *	@bitmap: array of unsigned longs corresponding to the bitmap
-- 
2.34.1

