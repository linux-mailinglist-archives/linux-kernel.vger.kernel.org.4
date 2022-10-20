Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17422606A94
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 23:55:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbiJTVzM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 17:55:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230116AbiJTVyw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 17:54:52 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D30A501A6;
        Thu, 20 Oct 2022 14:54:33 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id mx8so611407qvb.8;
        Thu, 20 Oct 2022 14:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3QVy7NAfSopf+Iij2pw0HKI71t//u6xehpjVOpbyUMY=;
        b=J+iDN/3M1v4SmMv54h7rTzpz0LCv5/XHzg8ewdpWRJK70RuAF16mbixTaMb/vBat51
         /mOQLg5Lg+eWwblMvbeXIjCw6c7NGBNFeD/y4PUno/X8AVsvp3cN9kuMppVqjdsN5kl6
         orFfq4ybTrc/U75TOFffbD2FHq/yB8TQdUCF4W5zgxsL4RtZssN3wgMFfKwcAq4UKdf8
         F8nDYyOYiinRzsKsyxRooF/HEUiIjI0N0PbTdoyDCvkE5xiCtErgJjWuKYBHcuAzQd0V
         2rntUIgntvNQWYugXRMQ7XaB2yU5azO8RSIVC6neC4mThi5qsxjgKAfWCPpzvk9W2R02
         HrBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3QVy7NAfSopf+Iij2pw0HKI71t//u6xehpjVOpbyUMY=;
        b=ocMfqTiz6oX3NxL7xt0SKGqssbXi0f1nZlSmdC/NmNavzkIN52JNTz85Uc27gx03AT
         gvHTxMdVcrdS4myKzlan3dVMc6uuDFW2gO35SXk1q8IpV21QxSL68duwfmZ92WeOHXMo
         ZvcRQwLvEDd0AVIHJ1bUongy1qV7YH7RplZilLYv6bcOrw+sorNDfIPbaXor0L2fx37Y
         eKEI8fQTdEdAZU9QMwy9rwODhGlQs8z1h4NH1VS/dazseBuhQV2DfgapSbav3gW6RreW
         5c1XzE1L1Id9rC+2p48sZPmUcfRSY1xWHetVJHYl+cNO7GzSMeKyJsF9VJQ4EXeJKDN0
         1G4g==
X-Gm-Message-State: ACrzQf05uB3vs+8tWhitFQj4qDFgmC0W/+7fbwhUD9t3Phdd2EKQeH1O
        qkbiD1txxL2Dekof2bdLTok=
X-Google-Smtp-Source: AMsMyM5aXseEnbCth+1erHFOC0l1o/oiEp9CjvS4tO2sP+AMndswz+RDyF7PQHIu1wmG8A/x1Oi+0g==
X-Received: by 2002:ad4:5949:0:b0:4b4:8535:97a4 with SMTP id eo9-20020ad45949000000b004b4853597a4mr13776300qvb.101.1666302872827;
        Thu, 20 Oct 2022 14:54:32 -0700 (PDT)
Received: from stbirv-lnx-3.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id bj41-20020a05620a192900b006bb29d932e1sm8121067qkb.105.2022.10.20.14.54.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 14:54:32 -0700 (PDT)
From:   Doug Berger <opendmb@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Jonathan Corbet <corbet@lwn.net>, Mike Rapoport <rppt@kernel.org>,
        Borislav Petkov <bp@suse.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>,
        KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>,
        Mel Gorman <mgorman@suse.de>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Doug Berger <opendmb@gmail.com>
Subject: [PATCH v3 4/9] mm/page_alloc.c: allow oversized movablecore
Date:   Thu, 20 Oct 2022 14:53:13 -0700
Message-Id: <20221020215318.4193269-5-opendmb@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221020215318.4193269-1-opendmb@gmail.com>
References: <20221020215318.4193269-1-opendmb@gmail.com>
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
index 2f7b88d78bc2..a4c2c157bacf 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -8121,13 +8121,13 @@ static void __init find_zone_movable_pfns_for_nodes(void)
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

