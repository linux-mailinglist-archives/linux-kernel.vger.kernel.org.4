Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 314A7739DCA
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 11:53:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230504AbjFVJxc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 05:53:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230446AbjFVJxB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 05:53:01 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20BC32976
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 02:47:35 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1b4f9583404so52854965ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 02:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digitalocean.com; s=google; t=1687427254; x=1690019254;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1llRvBzUlI3UuMkgrwvvPQlC2U4WWp6vjfVefBOBT1I=;
        b=eRTPSMLSP5LabF3ZUzJImpbDG1LLPl8Tt/JbkbCl83Z0rMj4ZMaYp4ZvL9pzrouhb9
         VYV7/RdHTjYce3hJeebynonOiHIOlGZDutkIwAJPZbu0YsxGa6w9Z2/dkFH+Fcwdquf4
         fmGVBr3hE3guZwvOrcC+1kK6TNhPSAD5Ai6rQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687427254; x=1690019254;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1llRvBzUlI3UuMkgrwvvPQlC2U4WWp6vjfVefBOBT1I=;
        b=iJKroL1wtXKWUDPY6oK3CicTuvkP3H9zrLS3bjQWDfWn2dVqzChlYqO9uoYowsGgXq
         XriAVbKEL5CeX3i1Z74lZskGn7eqOUWkri/KAL+/cMhmBe1IpwpeqjNU8Cypain6wPjP
         Ay9lVClzmcABcofk25p+1NTjIeC5l/Jj+t4U4x3kaH2IjHHyf3icbXLEDxzDPMcnjRyO
         4CEqjWXMuaW5RvK9rHPyf29cJHwIV/d61CJmGPVbWmGJCt7hLL05ajgEKMJaeA1E3I0u
         o1Zl5PZrAr5mCGTHYsj+5fgv+nIrpzHhLXM3dEbstaK/rMguBPVna+SD8FvIlZJSOL+f
         Fs2g==
X-Gm-Message-State: AC+VfDz/zZgn/wox0lBhti/K12DNeEfSzZXqDuOdn5axNPYFbrT2gzCr
        rz++CR0lsbkLJnsXaCtXy2XavQ==
X-Google-Smtp-Source: ACHHUZ69KXukmyot872anEoUey3A/ripqRG6cW5zFnKfKVcFYWhE2nPM2gOakUW1M8OGWWqjk3tXDw==
X-Received: by 2002:a17:903:1103:b0:1b5:91:4693 with SMTP id n3-20020a170903110300b001b500914693mr22501319plh.1.1687427254608;
        Thu, 22 Jun 2023 02:47:34 -0700 (PDT)
Received: from ika.internal.digitalocean.com (ip-091-089-160-106.um28.pools.vodafone-ip.de. [91.89.160.106])
        by smtp.gmail.com with ESMTPSA id y10-20020a17090322ca00b001a6dc4f4a8csm4973456plg.73.2023.06.22.02.47.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 02:47:34 -0700 (PDT)
From:   Jan Glauber <jglauber@digitalocean.com>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Jan Glauber <jglauber@digitalocean.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        "Huang, Ying" <ying.huang@intel.com>
Subject: [PATCH v3] mm: Fix shmem THP counters on migration
Date:   Thu, 22 Jun 2023 11:47:20 +0200
Message-Id: <20230622094720.510540-1-jglauber@digitalocean.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The per node numa_stat values for shmem don't change on
page migration for THP:

  grep shmem /sys/fs/cgroup/machine.slice/.../memory.numa_stat:

    shmem N0=1092616192 N1=10485760
    shmem_thp N0=1092616192 N1=10485760

  migratepages 9181 0 1:

    shmem N0=0 N1=1103101952
    shmem_thp N0=1092616192 N1=10485760

Fix that by updating shmem_thp counters likewise to shmem counters
on page migration.

Signed-off-by: Jan Glauber <jglauber@digitalocean.com>
---
v3: Use folio_test_pmd_mappable instead of folio_test_transhuge
v2: Fix compile error
---
 mm/migrate.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/mm/migrate.c b/mm/migrate.c
index 01cac26a3127..6ef8b1dea2e6 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -492,6 +492,11 @@ int folio_migrate_mapping(struct address_space *mapping,
 		if (folio_test_swapbacked(folio) && !folio_test_swapcache(folio)) {
 			__mod_lruvec_state(old_lruvec, NR_SHMEM, -nr);
 			__mod_lruvec_state(new_lruvec, NR_SHMEM, nr);
+
+			if (folio_test_pmd_mappable(folio)) {
+				__mod_lruvec_state(old_lruvec, NR_SHMEM_THPS, -nr);
+				__mod_lruvec_state(new_lruvec, NR_SHMEM_THPS, nr);
+			}
 		}
 #ifdef CONFIG_SWAP
 		if (folio_test_swapcache(folio)) {
-- 
2.25.1

