Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06BC75EE96C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 00:34:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234663AbiI1WeQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 18:34:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234630AbiI1WeG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 18:34:06 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E76FF9629;
        Wed, 28 Sep 2022 15:33:56 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id w9so3199247qvn.11;
        Wed, 28 Sep 2022 15:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=Y1gY+TTTvQU628l9QGecp/PtNkThqCYkuVMTpcWzNvU=;
        b=BqYh+xbtP+MiEfognlviz93t2UYTYbdkBqOta6P6qz05hPu2VXyNpJC6ZPNULV48aV
         R7ix3iOWaCRHG86HGLxJOkOqX/k5tkF1yhFvp7trfzvr0tkFqw6il3mSg1zFJq9cGzrl
         o6my3cBgPsq0pFc3Ib7FFLp9Ce+8nvoZVzr+yWG/M+XojQe2YfkMiMH2x48UuO+Jq0kf
         LySWCGNlbEk6r/C2v8x/crAodPNpp4U5MuIaDgbMfYbRraHdNmJMNeg3sA9TnaNV5H6B
         3+tTIPJ7STDIM6FZsrlOKaKFPsGy72ghWhyrMA3E0+WLnlE1E5MXJip0lp+GLAdIqCIm
         yCkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=Y1gY+TTTvQU628l9QGecp/PtNkThqCYkuVMTpcWzNvU=;
        b=dg60HfXDrsqgb5WMcqI3cw0/yY/CBrzokHJCZjHi+eE2CbyXrGDjw+4Zul8C7Es+kv
         KtMVKG0ukN0uux2+Tsl7bL6LD7LAmp7zflOl6PLaIL7V4EQ86y7JV9eh/l9riOBFJy2N
         ud/Uhzevyoy4efJZk1mF0I2O0RgL+M/MO4+BUy1mfdv34Tlc964VXkgKI1QrJ/sj1WgD
         zxVr2zm31MkgfsXxRn5ULFPShMw+9OglTKWTe3wPc1uV5Yfu/DD7J/uErK/0V1xX1+VI
         HJxh/Oby2qJ0K2lUFkJpDaap5e2omsjx6EN/x605EihujMT0vwJMxxgODZdWqfNrQf//
         7ULA==
X-Gm-Message-State: ACrzQf2QdlBP+WdZ/yEtnnRFpU8kSX2KHYIfMHudhuX1rsE/a5svnCue
        Hb4sxLR9qstS07W75n/76Ts=
X-Google-Smtp-Source: AMsMyM7sRRj9qRUG7RZy9MMEt2bnHdiX8XuLyY5K1L0DMOgv9jkZopsYpvfjf6WZb2+cG3qtbuVi9w==
X-Received: by 2002:a0c:9a4c:0:b0:4a4:3ad8:3c28 with SMTP id q12-20020a0c9a4c000000b004a43ad83c28mr205895qvd.124.1664404435298;
        Wed, 28 Sep 2022 15:33:55 -0700 (PDT)
Received: from stbirv-lnx-3.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id j188-20020a37b9c5000000b006bb83c2be40sm3963481qkf.59.2022.09.28.15.33.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 15:33:54 -0700 (PDT)
From:   Doug Berger <opendmb@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Jonathan Corbet <corbet@lwn.net>, Mike Rapoport <rppt@kernel.org>,
        Borislav Petkov <bp@suse.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Muchun Song <songmuchun@bytedance.com>,
        KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>,
        Mel Gorman <mgorman@suse.de>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@suse.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Doug Berger <opendmb@gmail.com>
Subject: [PATCH v2 4/9] mm/page_alloc.c: allow oversized movablecore
Date:   Wed, 28 Sep 2022 15:32:56 -0700
Message-Id: <20220928223301.375229-5-opendmb@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220928223301.375229-1-opendmb@gmail.com>
References: <20220928223301.375229-1-opendmb@gmail.com>
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

Now that the error in computation of corepages has been corrected
by commit 9fd745d450e7 ("mm: fix overflow in
find_zone_movable_pfns_for_nodes()"), oversized specifications of
movablecore will result in a zero value for required_kernelcore if
it is not also specified.

It is unintuitive for such a request to lead to no ZONE_MOVABLE
memory when the kernel parameters are clearly requesting some.

The current behavior when requesting an oversized kernelcore is to
classify all of the pages in movable_zone as kernelcore. The new
behavior when requesting an oversized movablecore (when not also
specifying kernelcore) is to similarly classify all of the pages
in movable_zone as movablecore.

Signed-off-by: Doug Berger <opendmb@gmail.com>
---
 mm/page_alloc.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 3412d644c230..81f97c5ed080 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -8041,13 +8041,13 @@ static void __init find_zone_movable_pfns_for_nodes(void)
 		corepages = totalpages - required_movablecore;
 
 		required_kernelcore = max(required_kernelcore, corepages);
+	} else if (!required_kernelcore) {
+		/* If kernelcore was not specified, there is no ZONE_MOVABLE */
+		goto out;
 	}
 
-	/*
-	 * If kernelcore was not specified or kernelcore size is larger
-	 * than totalpages, there is no ZONE_MOVABLE.
-	 */
-	if (!required_kernelcore || required_kernelcore >= totalpages)
+	/* If kernelcore size exceeds totalpages, there is no ZONE_MOVABLE */
+	if (required_kernelcore >= totalpages)
 		goto out;
 
 	/* usable_startpfn is the lowest possible pfn ZONE_MOVABLE can be at */
-- 
2.25.1

