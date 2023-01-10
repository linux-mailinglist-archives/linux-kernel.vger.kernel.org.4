Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C701A6636C1
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 02:39:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230057AbjAJBja (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 20:39:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230295AbjAJBj0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 20:39:26 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9EFCA1B3;
        Mon,  9 Jan 2023 17:39:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4D785614B1;
        Tue, 10 Jan 2023 01:39:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57021C433D2;
        Tue, 10 Jan 2023 01:39:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673314763;
        bh=PT1aoEfMxbkfDZP2tvZEeoskJ4gixNERZPq/fY0PYE8=;
        h=Date:From:To:Cc:Subject:From;
        b=cznwhUoeV85DmTiZJkhZlq982DirYK7miUs1fVFvDe296SCK/1/QbIWcUqRlN4haE
         xe8Xt5VDPaCrrE8xJ+/w0Dtmjo4FVkxDflfpqdo1ymVWCAQ+FeOCjXJgCdAA9nPEnw
         PmOihzrKt41Z8jgDiHNpOyjUdB8v7exhIT34OMkY1LxlGtSz+o3tZjLMJnFMECOAiZ
         oXhWHISfdobmhjrJnRjSRWh1I3A0RtXrQ1j5wsYOQ+rr+9BMFXbrU9CbcbXXdkJlWZ
         e/WZptwcfdrCkWjn6zNWN3mpeaxqmDltXWcdfnKwavQ+JAr4qMJ/miVRkfczn6uj2U
         /ZcFVZB8BCyyw==
Date:   Mon, 9 Jan 2023 19:39:30 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Ben Skeggs <bskeggs@redhat.com>, Karol Herbst <kherbst@redhat.com>,
        Lyude Paul <lyude@redhat.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: [PATCH][next] drm/nouveau/nvkm: Replace zero-length array with
 flexible-array member
Message-ID: <Y7zB0q2pr7lEpHGs@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Zero-length arrays are deprecated[1] and we are moving towards
adopting C99 flexible-array members instead. So, replace zero-length
array declaration in struct nvfw_hs_load_header_v2 with flex-array
member.

This helps with the ongoing efforts to tighten the FORTIFY_SOURCE
routines on memcpy() and help us make progress towards globally
enabling -fstrict-flex-arrays=3 [2].

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays [1]
Link: https://gcc.gnu.org/pipermail/gcc-patches/2022-October/602902.html [2]
Link: https://github.com/KSPP/linux/issues/78
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/gpu/drm/nouveau/include/nvfw/hs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/include/nvfw/hs.h b/drivers/gpu/drm/nouveau/include/nvfw/hs.h
index 8c4cd08a7b5f..8b58b668fc0c 100644
--- a/drivers/gpu/drm/nouveau/include/nvfw/hs.h
+++ b/drivers/gpu/drm/nouveau/include/nvfw/hs.h
@@ -52,7 +52,7 @@ struct nvfw_hs_load_header_v2 {
 	struct {
 		u32 offset;
 		u32 size;
-	} app[0];
+	} app[];
 };
 
 const struct nvfw_hs_load_header_v2 *nvfw_hs_load_header_v2(struct nvkm_subdev *, const void *);
-- 
2.34.1

