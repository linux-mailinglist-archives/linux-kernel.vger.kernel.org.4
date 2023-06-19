Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84EDB734B76
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 07:58:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbjFSF6L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 01:58:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjFSF6K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 01:58:10 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 583CC1B8
        for <linux-kernel@vger.kernel.org>; Sun, 18 Jun 2023 22:58:09 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1b5465a79cdso7091065ad.3
        for <linux-kernel@vger.kernel.org>; Sun, 18 Jun 2023 22:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digitalocean.com; s=google; t=1687154289; x=1689746289;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HrlL+BdDDMCHPlpiqgd7BagbHF5+QnXLM/eoRrhffjw=;
        b=JQQfI02E/0uIDKwMsgUWVgb8+jY6IwmniqxVhT9/IhAsUk9U3lQ+O2pXnr7+SmTLCp
         Tp5/BoExKS0X2z3j60E9sjkRLFdBd0R1Gpu1uIHnSs4vBNl1gV7xzqkTAeaE99yl1h34
         oGAB/cSTCRtO2vt/SI+fJKsST3OTU+DyErM0A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687154289; x=1689746289;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HrlL+BdDDMCHPlpiqgd7BagbHF5+QnXLM/eoRrhffjw=;
        b=jnKwDjBCafRGjxFLoER+Af9DiRmk/MGm4TXyoonoTdsL51uE69DLsYIxXt1YKRj9PQ
         jT5f9bvHCJKk1e3pdaQ+OJdArfpMydjD4dIPSEWtP96RelRzWNE0qzyXIb4gI4j9ptB1
         r6maVoDFJl+ctS+uqU3y0JYIJVSY4Prdy8MFCgBnxZ1Ja6kkCCnMaD4kXMDnwT/ipfID
         yKl2UVeB6sIlJWwMBUB/R0O0rST9PEHaHhaEqUBJpsaXhzvbQHm21Kua3h+Nx/lf7Ovc
         A+WGMUZuiev0DMJR+lMgMuc0Q5qmfe2WUekFSuKaEJQPSfWfNRzEEsY8gxwMvD5h8KKT
         N5DA==
X-Gm-Message-State: AC+VfDxSUFkLqcjmokTNbdNnGuhNLe0mJBYZDn+YA2SLE35op3s9/NBF
        lcvMF8xzc6nXpVYd2y6zl1WH5w==
X-Google-Smtp-Source: ACHHUZ430EgqLN8QRZoHICne/+B0YkTFuQ/CtdV3NfVaoGyRY6Kil5C6+PvIELt9JIWPwYqL0r1APQ==
X-Received: by 2002:a17:902:c942:b0:1b0:7c3c:31f7 with SMTP id i2-20020a170902c94200b001b07c3c31f7mr8566821pla.28.1687154288719;
        Sun, 18 Jun 2023 22:58:08 -0700 (PDT)
Received: from ika.internal.digitalocean.com ([2a02:8070:8e85:8a0:6016:eca3:bea:a7da])
        by smtp.gmail.com with ESMTPSA id f13-20020a170902ce8d00b001b0358848b0sm12936489plg.161.2023.06.18.22.58.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jun 2023 22:58:08 -0700 (PDT)
From:   Jan Glauber <jglauber@digitalocean.com>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Jan Glauber <jglauber@digitalocean.com>
Subject: [PATCH] mm: Fix shmem THP counters on migration
Date:   Mon, 19 Jun 2023 07:57:35 +0200
Message-Id: <20230619055735.141740-1-jglauber@digitalocean.com>
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
+				__mod_lruvec_state(old_lruvec, NR_SHMEM_THP, -nr);
+				__mod_lruvec_state(new_lruvec, NR_SHMEM_THP, nr);
+			}
 		}
 #ifdef CONFIG_SWAP
 		if (folio_test_swapcache(folio)) {
-- 
2.25.1

