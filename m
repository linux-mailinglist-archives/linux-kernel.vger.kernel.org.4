Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EA7B60C649
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 10:20:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232160AbiJYIUq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 04:20:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232102AbiJYIUk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 04:20:40 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D82EDD2CFE
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 01:20:38 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id o64so13308488oib.12
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 01:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hvpi/0hv5kwOhSpI6auXNn4+exWXdyR8pJzRSsgKkfY=;
        b=SldVfq6UtUw8/E8uuD2Mv2nV74ZmTFj1gsPKITkVZY9Nny096pqIdCIDaZHvkvaHWB
         ila45Io6vb1LMjxDOP/K8zeIpPHQK1j716DNAdkkdmOhkQtej0hgW+YTExbLFCEroavx
         WcFvpgwU8/iNYALOa5sNqRndSqHB97ptGdbDoAgjyqSvLze/2U96HgSAB/UNKNiUQgVR
         jcFHwri1clWWl2qvpCDZ3OJIRdzvROQC66XFpJELNepSiaSrNgibfKqCH26T6RjlbfeV
         /Turt4TaWN9fntByk9k4LThOWfYGX9tE8wNmXyPuzKfVdLrLxhKKL3pjvFS7BWRwc6A2
         Gx7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hvpi/0hv5kwOhSpI6auXNn4+exWXdyR8pJzRSsgKkfY=;
        b=aVBxKnboG+b3xNPbcFfd1JxGUoSnwnddOrlS4SnLWUIW4j+4INbvO749I3pOD/aMi+
         Gxs5yo0Eilcvd92oh2HJpslBBfqr2sUtZ5imn476qkTkcomv1slDQhLtldTNtk4IwwLH
         EoCLbk0YHRwXPypeOdZHdMy6/Pl1unFcrDyjx0fvmTGwAXEvk5yG1rRHHEzRfQB8z9KJ
         g0uA3YvHc988KDZeF4aD27uqqTGbwR/IhMlYV+xiXZ7sMAd/OAkmdT51aS4nP2M2lrV/
         FCQPcPGCBqwckXk06HIQxmDbmwJUrMKDSW/+kxfC451UYxnW7Xh18YSlFGWow6VwPvci
         sxdQ==
X-Gm-Message-State: ACrzQf2YReipF9ct0RVcTYh9jaD0KI8jJAZ/19Cg8PHf68s3+JHEcR5u
        XtopGS8tjXyvJ3lylMDwMC5vUIoUYoFyiu1S
X-Google-Smtp-Source: AMsMyM7N+qbk17bd86+vllWY1SC8PlOgZfEHTrcXMbf7VBSb7zi4qP1+z4oVr2S6VeXjNygOKCKVeg==
X-Received: by 2002:a17:90a:7805:b0:20d:4fd9:9a0e with SMTP id w5-20020a17090a780500b0020d4fd99a0emr43652081pjk.169.1666686027363;
        Tue, 25 Oct 2022 01:20:27 -0700 (PDT)
Received: from mail.google.com (122-58-209-93-fibre.sparkbb.co.nz. [122.58.209.93])
        by smtp.gmail.com with ESMTPSA id b10-20020a170902650a00b0017f756563bcsm812496plk.47.2022.10.25.01.20.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Oct 2022 01:20:26 -0700 (PDT)
Date:   Tue, 25 Oct 2022 21:20:19 +1300
From:   Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
To:     Felix Kuehling <Felix.Kuehling@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Cc:     linux-kernel@vger.kernel.org,
        paulo.miguel.almeida.rodenas@gmail.com
Subject: [PATCH] [next] amdkfd: remove unused struct cdit_header
Message-ID: <Y1ecQ/cyIpun6eY8@mail.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

struct cdit_header was never used across any of the amd drivers nor
this is exposed to UAPI so it can be removed.

This patch removes struct cdit_header and refactor code accordingly

Signed-off-by: Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
---

At some point, removing this structure was suggested during a review for
a different patch but the clean up patch was never sent.

https://lore.kernel.org/lkml/0eeaa0b7-7ae6-c244-cfcd-86333d8f9b8b@amd.com/
---
 drivers/gpu/drm/amd/amdkfd/kfd_crat.h | 24 +-----------------------
 1 file changed, 1 insertion(+), 23 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.h b/drivers/gpu/drm/amd/amdkfd/kfd_crat.h
index 482ba84a728d..22893ff7b9a1 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.h
@@ -29,11 +29,10 @@
 #pragma pack(1)
 
 /*
- * 4CC signature values for the CRAT and CDIT ACPI tables
+ * 4CC signature value for the CRAT ACPI table
  */
 
 #define CRAT_SIGNATURE	"CRAT"
-#define CDIT_SIGNATURE	"CDIT"
 
 /*
  * Component Resource Association Table (CRAT)
@@ -292,27 +291,6 @@ struct crat_subtype_generic {
 	uint32_t	flags;
 };
 
-/*
- * Component Locality Distance Information Table (CDIT)
- */
-#define CDIT_OEMID_LENGTH	6
-#define CDIT_OEMTABLEID_LENGTH	8
-
-struct cdit_header {
-	uint32_t	signature;
-	uint32_t	length;
-	uint8_t		revision;
-	uint8_t		checksum;
-	uint8_t		oem_id[CDIT_OEMID_LENGTH];
-	uint8_t		oem_table_id[CDIT_OEMTABLEID_LENGTH];
-	uint32_t	oem_revision;
-	uint32_t	creator_id;
-	uint32_t	creator_revision;
-	uint32_t	total_entries;
-	uint16_t	num_domains;
-	uint8_t		entry[1];
-};
-
 #pragma pack()
 
 struct kfd_dev;
-- 
2.37.3

