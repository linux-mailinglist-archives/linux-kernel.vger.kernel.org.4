Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA60B714020
	for <lists+linux-kernel@lfdr.de>; Sun, 28 May 2023 22:26:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbjE1UZt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 May 2023 16:25:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbjE1UZs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 May 2023 16:25:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDAC499;
        Sun, 28 May 2023 13:25:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6EE06618FF;
        Sun, 28 May 2023 20:25:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA952C433EF;
        Sun, 28 May 2023 20:25:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685305545;
        bh=e/BaBW7sBtQzZAFcqXZIr6cq7jQWmf347wE2UrNWXvo=;
        h=Date:From:To:Cc:Subject:From;
        b=FTEYgj2FnQEvAiguJAMacBw5p1NZqoD4NnK0xqagSVW2y+RV4Cy6CxnEkio28/hxW
         NJmTo1snvbRMzSKbItYqw/k5XlB7TtrylKaWr/Y/ZTHzrXpEeywm9kGGvVU/9VcRiW
         ula1LF2SKa1xNguOXil1199HZwd+escpztA2+cVA2hoo9oF7AbPGmubSYSH2JzWiCg
         ktVvceTgB9onw2zpkPvieEACFgIPInxQcMgUI92WJqYsOD+VP0GRwp7UD+O/EDsWb7
         DsTGJHBPgtElBetm/i5rZsDZ1XjyaR9+jsJWglnF834kL83xR1IsQp8YqfbbAvbJB/
         BKBPsvFTpMCeQ==
Date:   Sun, 28 May 2023 14:26:37 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Alex Deucher <alexander.deucher@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: [PATCH][next] drm/amdgpu/discovery: Replace fake flex-arrays with
 flexible-array members
Message-ID: <ZHO4/Z+iO+lqV4rW@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Zero-length and one-element arrays are deprecated, and we are moving
towards adopting C99 flexible-array members, instead.

Use the DECLARE_FLEX_ARRAY() helper macro to transform zero-length
arrays in a union into flexible-array members. And replace a one-element
array with a C99 flexible-array member.

Address the following warnings found with GCC-13 and
-fstrict-flex-arrays=3 enabled:
drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c:1009:89: warning: array subscript kk is outside array bounds of ‘uint32_t[0]’ {aka ‘unsigned int[]’} [-Warray-bounds=]
drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c:1007:94: warning: array subscript kk is outside array bounds of ‘uint64_t[0]’ {aka ‘long long unsigned int[]’} [-Warray-bounds=]
drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c:1310:94: warning: array subscript k is outside array bounds of ‘uint64_t[0]’ {aka ‘long long unsigned int[]’} [-Warray-bounds=]
drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c:1309:57: warning: array subscript k is outside array bounds of ‘uint32_t[0]’ {aka ‘unsigned int[]’} [-Warray-bounds=]

This helps with the ongoing efforts to tighten the FORTIFY_SOURCE
routines on memcpy() and help us make progress towards globally
enabling -fstrict-flex-arrays=3 [1].

This results in no differences in binary output.

Link: https://github.com/KSPP/linux/issues/21
Link: https://github.com/KSPP/linux/issues/193
Link: https://github.com/KSPP/linux/issues/300
Link: https://gcc.gnu.org/pipermail/gcc-patches/2022-October/602902.html [1]
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/gpu/drm/amd/include/discovery.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/include/discovery.h b/drivers/gpu/drm/amd/include/discovery.h
index 9181e57887db..f43e29722ef7 100644
--- a/drivers/gpu/drm/amd/include/discovery.h
+++ b/drivers/gpu/drm/amd/include/discovery.h
@@ -122,7 +122,7 @@ typedef struct ip_v3
 	uint8_t sub_revision : 4;               /* HCID Sub-Revision */
 	uint8_t variant : 4;                    /* HW variant */
 #endif
-	uint32_t base_address[1];               /* Base Address list. Corresponds to the num_base_address field*/
+	uint32_t base_address[];		/* Base Address list. Corresponds to the num_base_address field*/
 } ip_v3;
 
 typedef struct ip_v4 {
@@ -140,8 +140,8 @@ typedef struct ip_v4 {
 	uint8_t sub_revision : 4;               /* HCID Sub-Revision */
 #endif
 	union {
-		uint32_t base_address[0];               /* 32-bit Base Address list. Corresponds to the num_base_address field*/
-		uint64_t base_address_64[0];            /* 64-bit Base Address list. Corresponds to the num_base_address field*/
+		DECLARE_FLEX_ARRAY(uint32_t, base_address);	/* 32-bit Base Address list. Corresponds to the num_base_address field*/
+		DECLARE_FLEX_ARRAY(uint64_t, base_address_64);	/* 64-bit Base Address list. Corresponds to the num_base_address field*/
 	} __packed;
 } ip_v4;
 
-- 
2.34.1

