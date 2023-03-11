Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 926296B56CD
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 01:40:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229952AbjCKAjz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 19:39:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229852AbjCKAju (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 19:39:50 -0500
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BD33117231;
        Fri, 10 Mar 2023 16:39:48 -0800 (PST)
Received: by mail-qt1-x836.google.com with SMTP id l18so7765898qtp.1;
        Fri, 10 Mar 2023 16:39:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678495187;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rkrJtBKgdz9IacsmBdIB0+uEq5L3ahKPJNy4SS1btTU=;
        b=Nf4Q5bnoJ84mo6BVRKtM3OfYWI13uwKOw3uMc7wGcqg/YFrF0EDMb2Tc70a6r1fzZc
         Vir55wXtNRFzDTHoKksEBE1mT4Whc3rUCB6/a0qYsGVSTiZtZ1TEhI9YVuoSUTQOWpIZ
         wkyLW5TGMgj2c/+6vz/qhI3xMN7MdJyqYQkUUjkArXHvmslWI6L/Xb589+yt2NqJ62aO
         kbpLaP4c6yERZu1yQsMLtGpH/zEzYZeuNWWDxxsC3FvHSaQbKpvi5zFCrlyV+6tabjRH
         vcZbcVon48Fjz/56NthcczU09cWdHbhFtoufMuJ6CShKWnTHB9IBjP7QRZcPwiJtc50q
         dKRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678495187;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rkrJtBKgdz9IacsmBdIB0+uEq5L3ahKPJNy4SS1btTU=;
        b=y5cQzyzpAV1EQEau6I68uVvLSS0vdf4wVG4lpLxVfnJP3v1Auc7ler5dL0mUZFwQmC
         ApgPfzi4chvx8FV1kBtn9SNkAcw4KvnL91zHAG+6zkdum3XgA0lLwU7Qwtvmf01ZYQHK
         PyqYJGy5yQtBOhmx3c8CP5j8yzb86MMM2ejGlAwwHIgnwIy23vJ7IIYpEH15NOl93FEu
         HB8RPKBgMfk0EEHhGaU0k9v2PsljQyRqqHUOKA465IJXj9unN0zr6Pr0Wvsul56nP2Zl
         I92o4MC0rq95WLnoKByAbIjmb8OUQkeSVNN/aXjeYnQ4Zu/kAtR/6WqLLoys2HdHMgO2
         EcxA==
X-Gm-Message-State: AO0yUKUwI32qxvpqvfx/vTaaicphH9vqRm1Goi+yB0xy8cQVjjSerT2U
        2vb4bzH7kf9vdozGpdG5syE=
X-Google-Smtp-Source: AK7set/Bpp6yGdrFeMDx50dFU90Wr4xltqSMpKJQRscRiht85efTCEQ33g7uJ6Dpxtrzuwm9BJqBkA==
X-Received: by 2002:a05:622a:244:b0:3bd:1bbc:8d8e with SMTP id c4-20020a05622a024400b003bd1bbc8d8emr10459853qtx.0.1678495187484;
        Fri, 10 Mar 2023 16:39:47 -0800 (PST)
Received: from stbirv-lnx-1.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id a5-20020ac84345000000b003bfaff2a6b9sm868874qtn.10.2023.03.10.16.39.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 16:39:47 -0800 (PST)
From:   Doug Berger <opendmb@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Jonathan Corbet <corbet@lwn.net>, Mike Rapoport <rppt@kernel.org>,
        Borislav Petkov <bp@suse.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Kim Phillips <kim.phillips@amd.com>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>,
        Mel Gorman <mgorman@suse.de>,
        Muchun Song <songmuchun@bytedance.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Sukadev Bhattiprolu <quic_sukadev@quicinc.com>,
        Rik van Riel <riel@surriel.com>,
        Roman Gushchin <guro@fb.com>, Minchan Kim <minchan@kernel.org>,
        Chris Goldsworthy <quic_cgoldswo@quicinc.com>,
        "Georgi Djakov" <quic_c_gdjako@quicinc.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Doug Berger <opendmb@gmail.com>
Subject: [PATCH v4 1/9] lib/show_mem.c: display MovableOnly
Date:   Fri, 10 Mar 2023 16:38:47 -0800
Message-Id: <20230311003855.645684-2-opendmb@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230311003855.645684-1-opendmb@gmail.com>
References: <20230311003855.645684-1-opendmb@gmail.com>
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

The comment for commit c78e93630d15 ("mm: do not walk all of
system memory during show_mem") indicates it "also corrects the
reporting of HighMem as HighMem/MovableOnly as ZONE_MOVABLE has
similar problems to HighMem with respect to lowmem/highmem
exhaustion."

Presuming the similar problems are with regard to the general
exclusion of kernel allocations from either zone, I believe it
makes sense to include all ZONE_MOVABLE memory even on systems
without HighMem.

To the extent that this was the intent of the original commit I
have included a "Fixes" tag, but it seems unnecessary to submit
to linux-stable.

Fixes: c78e93630d15 ("mm: do not walk all of system memory during show_mem")
Signed-off-by: Doug Berger <opendmb@gmail.com>
---
 lib/show_mem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/show_mem.c b/lib/show_mem.c
index 0d7585cde2a6..6a632b0c35c5 100644
--- a/lib/show_mem.c
+++ b/lib/show_mem.c
@@ -27,7 +27,7 @@ void __show_mem(unsigned int filter, nodemask_t *nodemask, int max_zone_idx)
 			total += zone->present_pages;
 			reserved += zone->present_pages - zone_managed_pages(zone);
 
-			if (is_highmem_idx(zoneid))
+			if (zoneid == ZONE_MOVABLE || is_highmem_idx(zoneid))
 				highmem += zone->present_pages;
 		}
 	}
-- 
2.34.1

