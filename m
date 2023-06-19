Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C2E2735264
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 12:34:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231486AbjFSKeU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 06:34:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231455AbjFSKeP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 06:34:15 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C26D9102
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 03:34:14 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-6686a05bc66so885822b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 03:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digitalocean.com; s=google; t=1687170854; x=1689762854;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=heHJUn4iKTJWBTugyrbKjkbfR9J6JddpcED//kDefoo=;
        b=BLfZul72ZubCd1bVTnuTMDkkvnVOopE/JjTBvj0IonhU2MMIEEDOvBcOkUFRelOLtX
         o7uOZ5+5a1AOHhUCzyurcDpg9q8dfBwoTN47MmfIAQXFdM2yaZdRpUd3hvZvfFTpYgf2
         6qf+jDUF8Vb0c3fx+8BTZ+Ba6+sNnTt881iyA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687170854; x=1689762854;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=heHJUn4iKTJWBTugyrbKjkbfR9J6JddpcED//kDefoo=;
        b=W4PKt42c28bF4FSw8mKndNqamBMx48rb38EqvDK7bWqytMut91tv8aSPx3aI3zXT29
         Q8SHKZ14q3o5VgI1ISaNte3kvNQNuECZBy+bTEpvO+dQ3njc7O5xXzSCcgcPeX5w1K1M
         SlwoDFMaSwZFlZyvQG1J0BtzKvjCluV7yyCclI6aP0g8DZdIWs2THZ9c1Vg46e7iA45C
         fRhvZPcMFjeH/a9Qs0yc+GPMWY6T9LcEVh44kMJE6/xwk+GbsCNuUidWUVckX8Tkk2L4
         kr2Fj+86KONUG/YO8Dtd9mqJo+W94vsRW8eN5ADak8ee24wTFUrlhEwQS5nNKT2fbgFj
         OB8Q==
X-Gm-Message-State: AC+VfDxTXiztKtMIROBiQJ3xRZaDSWDYApHx5E1ACYmLJTFYRNoYCa6/
        Imzv69yBOnpF1jA/28LlIxxWug==
X-Google-Smtp-Source: ACHHUZ7wH+w2GaVwSuxTonZVh2X/ubMhbGd2L6gkQVrSDHS5jCns9CtbX3GUOtqZ0/aFmtuGCXxMFw==
X-Received: by 2002:a05:6a00:1343:b0:643:857d:87a3 with SMTP id k3-20020a056a00134300b00643857d87a3mr10102506pfu.11.1687170854324;
        Mon, 19 Jun 2023 03:34:14 -0700 (PDT)
Received: from ika.internal.digitalocean.com (ip-091-089-160-106.um28.pools.vodafone-ip.de. [91.89.160.106])
        by smtp.gmail.com with ESMTPSA id 11-20020aa7910b000000b0065434edd521sm17370756pfh.196.2023.06.19.03.34.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jun 2023 03:34:13 -0700 (PDT)
From:   Jan Glauber <jglauber@digitalocean.com>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Jan Glauber <jglauber@digitalocean.com>
Subject: [PATCH v2] mm: Fix shmem THP counters on migration
Date:   Mon, 19 Jun 2023 12:33:51 +0200
Message-Id: <20230619103351.234837-1-jglauber@digitalocean.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230619054955.140276-1-jglauber@digitalocean.com>
References: <20230619054955.140276-1-jglauber@digitalocean.com>
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
 mm/migrate.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/mm/migrate.c b/mm/migrate.c
index 01cac26a3127..d2ba786ea105 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -492,6 +492,11 @@ int folio_migrate_mapping(struct address_space *mapping,
 		if (folio_test_swapbacked(folio) && !folio_test_swapcache(folio)) {
 			__mod_lruvec_state(old_lruvec, NR_SHMEM, -nr);
 			__mod_lruvec_state(new_lruvec, NR_SHMEM, nr);
+
+			if (folio_test_transhuge(folio)) {
+				__mod_lruvec_state(old_lruvec, NR_SHMEM_THPS, -nr);
+				__mod_lruvec_state(new_lruvec, NR_SHMEM_THPS, nr);
+			}
 		}
 #ifdef CONFIG_SWAP
 		if (folio_test_swapcache(folio)) {
--
2.25.1

