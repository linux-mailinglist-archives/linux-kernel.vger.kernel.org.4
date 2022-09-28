Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D04D05EE968
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 00:34:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234622AbiI1Wd7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 18:33:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234479AbiI1Wdv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 18:33:51 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8770F9617;
        Wed, 28 Sep 2022 15:33:50 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id w2so8855194qtv.9;
        Wed, 28 Sep 2022 15:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=6/+RylwAUS1L6kGkdbzNevLkV7SCUovxqo9fjOaS6JU=;
        b=kC/0LNb9bktbL+TEwR3l+o6fUDutxrrSeCaNe1//+eoGCAW+xNZO4DlmQHy9VcTyfS
         NwAIyqoskQm/m5kv6XZ4r7B1ACZBqZis8V/cQNWWyzM9pA3Is409pWX7+mJZ+/N2vvBI
         YozbOIh7aY5FgIxfp56OJu1Gme5MA8TIs7VrQ4zlIKfuDoRx/M7tAtjTXSP7dzFQ50dF
         x6WJ/l4IoBT3rvV++v7Beym46s0QSrWDIFgJllEiXfwCqYwnQOCcV3XO4+cbD8UDzrDC
         Fgpv0bDTnfoI7cOl7Bdut11t3RGz5K9z2orfa9hNqZxWTfMH5f4yEJcCefUWQ9e0L4rd
         pWOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=6/+RylwAUS1L6kGkdbzNevLkV7SCUovxqo9fjOaS6JU=;
        b=T459pcZ7buM1cuU/Nt9RP4nnxyl0pU9W/4+nlQkTGdVzPcYKrPll+5ZFtj0JAZIAsD
         JiD53QLOQQHH9+OYAxcsCTBTI3JI88267YOG+3+TFalKSMNO55mlDVon0m3TWGhB7Xqx
         VE4UIeoahloZ1VYIEQvefHlLKZQcdOA2Hed3Vb1URyyOPJDzVTuyd3hjkOVVTPrFu4z4
         v26Xm0nvwWpurOTlgbV2ne+TG9n9KaoDIYR8gf6WNhq/ud6PtB0eemlOmc/4fSyJbilx
         WD7MfsVMxYN4bsOuwA+vUgFjZqPWnajqa7blCHI5X7zPHkf2CtmLqf3yPXM9PXhYW8P2
         pDNg==
X-Gm-Message-State: ACrzQf07ZbxpDokL55Ej5tQsQCMfEvYcL5MEv/c8zvhd5PU9PZasFOJM
        hXgd42QAesnkRYkEeGY47n4=
X-Google-Smtp-Source: AMsMyM6j7B74qZOjrMnDAmps4FdyuXPteigyZvK3BDi31VGk6vlpVOIX8YjcSQSYPDGzBZGstAm8RA==
X-Received: by 2002:a05:622a:138f:b0:35b:bb7b:743c with SMTP id o15-20020a05622a138f00b0035bbb7b743cmr33120qtk.361.1664404429867;
        Wed, 28 Sep 2022 15:33:49 -0700 (PDT)
Received: from stbirv-lnx-3.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id j188-20020a37b9c5000000b006bb83c2be40sm3963481qkf.59.2022.09.28.15.33.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 15:33:49 -0700 (PDT)
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
Subject: [PATCH v2 2/9] mm/vmstat: show start_pfn when zone spans pages
Date:   Wed, 28 Sep 2022 15:32:54 -0700
Message-Id: <20220928223301.375229-3-opendmb@gmail.com>
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

A zone that overlaps with another zone may span a range of pages
that are not present. In this case, displaying the start_pfn of
the zone allows the zone page range to be identified.

Signed-off-by: Doug Berger <opendmb@gmail.com>
---
 mm/vmstat.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/mm/vmstat.c b/mm/vmstat.c
index 90af9a8572f5..e2f19f2b7615 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1717,6 +1717,11 @@ static void zoneinfo_show_print(struct seq_file *m, pg_data_t *pgdat,
 
 	/* If unpopulated, no other information is useful */
 	if (!populated_zone(zone)) {
+		/* Show start_pfn for empty overlapped zones */
+		if (zone->spanned_pages)
+			seq_printf(m,
+				   "\n  start_pfn:           %lu",
+				   zone->zone_start_pfn);
 		seq_putc(m, '\n');
 		return;
 	}
-- 
2.25.1

