Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EB96600CCD
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 12:46:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230233AbiJQKqU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 06:46:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230204AbiJQKqN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 06:46:13 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A3EAC1A04D
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 03:46:12 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9D33D1FC4;
        Mon, 17 Oct 2022 03:46:18 -0700 (PDT)
Received: from e122027.arm.com (unknown [10.57.1.201])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 345FD3F67D;
        Mon, 17 Oct 2022 03:46:11 -0700 (PDT)
From:   Steven Price <steven.price@arm.com>
To:     Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        =?UTF-8?q?Adri=C3=A1n=20Larumbe?= <adrian.larumbe@collabora.com>
Cc:     Steven Price <steven.price@arm.com>, Rob Herring <robh@kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH v2 1/2] drm/panfrost: Remove type name from internal structs
Date:   Mon, 17 Oct 2022 11:46:01 +0100
Message-Id: <20221017104602.142992-2-steven.price@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221017104602.142992-1-steven.price@arm.com>
References: <20221017104602.142992-1-steven.price@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The two structs internal to struct panfrost_dump_object_header were
named, but sadly that is incompatible with C++, causing an error: "an
anonymous union may only have public non-static data members".

However nothing refers to struct pan_reg_hdr and struct pan_bomap_hdr
and there's no need to export these definitions, so lets drop them. This
fixes the C++ build error with the minimum change in userspace API.

Reported-by: Adrián Larumbe <adrian.larumbe@collabora.com>
Fixes: 730c2bf4ad39 ("drm/panfrost: Add support for devcoredump")
Signed-off-by: Steven Price <steven.price@arm.com>
---
 include/uapi/drm/panfrost_drm.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/uapi/drm/panfrost_drm.h b/include/uapi/drm/panfrost_drm.h
index eac87310b348..bd77254be121 100644
--- a/include/uapi/drm/panfrost_drm.h
+++ b/include/uapi/drm/panfrost_drm.h
@@ -242,7 +242,7 @@ struct panfrost_dump_object_header {
 	__le32 file_offset;
 
 	union {
-		struct pan_reg_hdr {
+		struct {
 			__le64 jc;
 			__le32 gpu_id;
 			__le32 major;
@@ -250,7 +250,7 @@ struct panfrost_dump_object_header {
 			__le64 nbos;
 		} reghdr;
 
-		struct pan_bomap_hdr {
+		struct {
 			__le32 valid;
 			__le64 iova;
 			__le32 data[2];
-- 
2.34.1

