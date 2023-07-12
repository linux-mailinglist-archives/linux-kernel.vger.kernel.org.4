Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFBDF7501AE
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 10:35:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232769AbjGLIfi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 04:35:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231532AbjGLIfR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 04:35:17 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65D962715
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 01:31:58 -0700 (PDT)
Received: from localhost.localdomain (unknown [IPv6:2a0c:5a83:9102:2a00:4fba:f865:7723:12b6])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: rcn)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 71F4B6606F62;
        Wed, 12 Jul 2023 09:31:56 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1689150716;
        bh=w8dG4/d9Voy998I9Q/zGS29Dk0j8gptoUYrIF4ruqmk=;
        h=From:To:Cc:Subject:Date:From;
        b=elX287UmMenXTl44/Ltl/EjHIC4j2KB439LX5HmUxO+ffJD4LOxqeKFeiL5qnZUGA
         0FUhs85S1vDhmj5JwlxcDH1H1Zf8wuu/A1EnShTSH/rDIjTkSQyrTjZdIZwNJ97FRe
         mCFT2aaO4RsQ8zeJ1rjEJTCe5B/UWzOgZVgCxXJbZsetLMaG3eTiAjfpgaexH9hcHa
         zE8nzzRdvI2xihfhlwhUyVHaY7M5MzQr4VqtvWp1NKMdIUMxSigc4YrVBGKftU+kTx
         oLQmC/VuxYwp5rvTnaQexE8fV3wdlvmVILwlHkl1yWvKsx6Ju9vCshrJk9R04Fiyid
         lXJBAFbmWIE1Q==
From:   =?UTF-8?q?Ricardo=20Ca=C3=B1uelo?= <ricardo.canuelo@collabora.com>
To:     alexander.deucher@amd.com
Cc:     kernel@collabora.com, amd-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/amdgpu: replace 1-element arrays with flexible arrays
Date:   Wed, 12 Jul 2023 10:31:37 +0200
Message-Id: <20230712083137.1080883-1-ricardo.canuelo@collabora.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UBSAN complains about out-of-bounds array indexes on all 1-element
arrays defined on this driver:

UBSAN: array-index-out-of-bounds in /home/rcn/work/repos/kernelci/kernelci-core/linux_kernel_mainline/drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/processpptables.c:1249:61

Substitute them with proper flexible arrays.

Tested on an Acer R721T (grunt) Chromebook.

Signed-off-by: Ricardo Cañuelo <ricardo.canuelo@collabora.com>
---
 drivers/gpu/drm/amd/include/pptable.h | 36 +++++++++++++++------------
 1 file changed, 20 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/include/pptable.h b/drivers/gpu/drm/amd/include/pptable.h
index 0b6a057e0a4c..a65e2807dc06 100644
--- a/drivers/gpu/drm/amd/include/pptable.h
+++ b/drivers/gpu/drm/amd/include/pptable.h
@@ -473,14 +473,14 @@ typedef struct _ATOM_PPLIB_STATE_V2
       /**
       * Driver will read the first ucNumDPMLevels in this array
       */
-      UCHAR clockInfoIndex[1];
+      __DECLARE_FLEX_ARRAY(UCHAR, clockInfoIndex);
 } ATOM_PPLIB_STATE_V2;
 
 typedef struct _StateArray{
     //how many states we have 
     UCHAR ucNumEntries;
     
-    ATOM_PPLIB_STATE_V2 states[1];
+    __DECLARE_FLEX_ARRAY(ATOM_PPLIB_STATE_V2, states);
 }StateArray;
 
 
@@ -491,7 +491,7 @@ typedef struct _ClockInfoArray{
     //sizeof(ATOM_PPLIB_CLOCK_INFO)
     UCHAR ucEntrySize;
     
-    UCHAR clockInfo[1];
+    __DECLARE_FLEX_ARRAY(UCHAR, clockInfo);
 }ClockInfoArray;
 
 typedef struct _NonClockInfoArray{
@@ -501,7 +501,7 @@ typedef struct _NonClockInfoArray{
     //sizeof(ATOM_PPLIB_NONCLOCK_INFO)
     UCHAR ucEntrySize;
     
-    ATOM_PPLIB_NONCLOCK_INFO nonClockInfo[1];
+    __DECLARE_FLEX_ARRAY(ATOM_PPLIB_NONCLOCK_INFO, nonClockInfo);
 }NonClockInfoArray;
 
 typedef struct _ATOM_PPLIB_Clock_Voltage_Dependency_Record
@@ -514,7 +514,8 @@ typedef struct _ATOM_PPLIB_Clock_Voltage_Dependency_Record
 typedef struct _ATOM_PPLIB_Clock_Voltage_Dependency_Table
 {
     UCHAR ucNumEntries;                                                // Number of entries.
-    ATOM_PPLIB_Clock_Voltage_Dependency_Record entries[1];             // Dynamically allocate entries.
+    /* Dynamically allocate entries. */
+    __DECLARE_FLEX_ARRAY(ATOM_PPLIB_Clock_Voltage_Dependency_Record, entries);
 }ATOM_PPLIB_Clock_Voltage_Dependency_Table;
 
 typedef struct _ATOM_PPLIB_Clock_Voltage_Limit_Record
@@ -530,7 +531,8 @@ typedef struct _ATOM_PPLIB_Clock_Voltage_Limit_Record
 typedef struct _ATOM_PPLIB_Clock_Voltage_Limit_Table
 {
     UCHAR ucNumEntries;                                                // Number of entries.
-    ATOM_PPLIB_Clock_Voltage_Limit_Record entries[1];                  // Dynamically allocate entries.
+    /* Dynamically allocate entries. */
+    __DECLARE_FLEX_ARRAY(ATOM_PPLIB_Clock_Voltage_Limit_Record, entries);
 }ATOM_PPLIB_Clock_Voltage_Limit_Table;
 
 union _ATOM_PPLIB_CAC_Leakage_Record
@@ -554,7 +556,8 @@ typedef union _ATOM_PPLIB_CAC_Leakage_Record ATOM_PPLIB_CAC_Leakage_Record;
 typedef struct _ATOM_PPLIB_CAC_Leakage_Table
 {
     UCHAR ucNumEntries;                                                 // Number of entries.
-    ATOM_PPLIB_CAC_Leakage_Record entries[1];                           // Dynamically allocate entries.
+    /* Dynamically allocate entries. */
+    __DECLARE_FLEX_ARRAY(ATOM_PPLIB_CAC_Leakage_Record, entries);
 }ATOM_PPLIB_CAC_Leakage_Table;
 
 typedef struct _ATOM_PPLIB_PhaseSheddingLimits_Record
@@ -569,7 +572,8 @@ typedef struct _ATOM_PPLIB_PhaseSheddingLimits_Record
 typedef struct _ATOM_PPLIB_PhaseSheddingLimits_Table
 {
     UCHAR ucNumEntries;                                                 // Number of entries.
-    ATOM_PPLIB_PhaseSheddingLimits_Record entries[1];                   // Dynamically allocate entries.
+    /* Dynamically allocate entries. */
+    __DECLARE_FLEX_ARRAY(ATOM_PPLIB_PhaseSheddingLimits_Record, entries);
 }ATOM_PPLIB_PhaseSheddingLimits_Table;
 
 typedef struct _VCEClockInfo{
@@ -581,7 +585,7 @@ typedef struct _VCEClockInfo{
 
 typedef struct _VCEClockInfoArray{
     UCHAR ucNumEntries;
-    VCEClockInfo entries[1];
+    __DECLARE_FLEX_ARRAY(VCEClockInfo, entries);
 }VCEClockInfoArray;
 
 typedef struct _ATOM_PPLIB_VCE_Clock_Voltage_Limit_Record
@@ -593,7 +597,7 @@ typedef struct _ATOM_PPLIB_VCE_Clock_Voltage_Limit_Record
 typedef struct _ATOM_PPLIB_VCE_Clock_Voltage_Limit_Table
 {
     UCHAR numEntries;
-    ATOM_PPLIB_VCE_Clock_Voltage_Limit_Record entries[1];
+    __DECLARE_FLEX_ARRAY(ATOM_PPLIB_VCE_Clock_Voltage_Limit_Record, entries);
 }ATOM_PPLIB_VCE_Clock_Voltage_Limit_Table;
 
 typedef struct _ATOM_PPLIB_VCE_State_Record
@@ -605,7 +609,7 @@ typedef struct _ATOM_PPLIB_VCE_State_Record
 typedef struct _ATOM_PPLIB_VCE_State_Table
 {
     UCHAR numEntries;
-    ATOM_PPLIB_VCE_State_Record entries[1];
+    __DECLARE_FLEX_ARRAY(ATOM_PPLIB_VCE_State_Record, entries);
 }ATOM_PPLIB_VCE_State_Table;
 
 
@@ -627,7 +631,7 @@ typedef struct _UVDClockInfo{
 
 typedef struct _UVDClockInfoArray{
     UCHAR ucNumEntries;
-    UVDClockInfo entries[1];
+    __DECLARE_FLEX_ARRAY(UVDClockInfo, entries);
 }UVDClockInfoArray;
 
 typedef struct _ATOM_PPLIB_UVD_Clock_Voltage_Limit_Record
@@ -639,7 +643,7 @@ typedef struct _ATOM_PPLIB_UVD_Clock_Voltage_Limit_Record
 typedef struct _ATOM_PPLIB_UVD_Clock_Voltage_Limit_Table
 {
     UCHAR numEntries;
-    ATOM_PPLIB_UVD_Clock_Voltage_Limit_Record entries[1];
+    __DECLARE_FLEX_ARRAY(ATOM_PPLIB_UVD_Clock_Voltage_Limit_Record, entries);
 }ATOM_PPLIB_UVD_Clock_Voltage_Limit_Table;
 
 typedef struct _ATOM_PPLIB_UVD_Table
@@ -658,7 +662,7 @@ typedef struct _ATOM_PPLIB_SAMClk_Voltage_Limit_Record
 
 typedef struct _ATOM_PPLIB_SAMClk_Voltage_Limit_Table{
     UCHAR numEntries;
-    ATOM_PPLIB_SAMClk_Voltage_Limit_Record entries[1];
+    __DECLARE_FLEX_ARRAY(ATOM_PPLIB_SAMClk_Voltage_Limit_Record, entries);
 }ATOM_PPLIB_SAMClk_Voltage_Limit_Table;
 
 typedef struct _ATOM_PPLIB_SAMU_Table
@@ -676,7 +680,7 @@ typedef struct _ATOM_PPLIB_ACPClk_Voltage_Limit_Record
 
 typedef struct _ATOM_PPLIB_ACPClk_Voltage_Limit_Table{
     UCHAR numEntries;
-    ATOM_PPLIB_ACPClk_Voltage_Limit_Record entries[1];
+    __DECLARE_FLEX_ARRAY(ATOM_PPLIB_ACPClk_Voltage_Limit_Record, entries);
 }ATOM_PPLIB_ACPClk_Voltage_Limit_Table;
 
 typedef struct _ATOM_PPLIB_ACP_Table
@@ -745,7 +749,7 @@ typedef struct ATOM_PPLIB_VQ_Budgeting_Record{
 typedef struct ATOM_PPLIB_VQ_Budgeting_Table {
     UCHAR revid;
     UCHAR numEntries;
-    ATOM_PPLIB_VQ_Budgeting_Record         entries[1];
+    __DECLARE_FLEX_ARRAY(ATOM_PPLIB_VQ_Budgeting_Record, entries);
 } ATOM_PPLIB_VQ_Budgeting_Table;
 
 #pragma pack()
-- 
2.25.1

