Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B1FF649BFB
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 11:22:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231645AbiLLKWo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 05:22:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231555AbiLLKWk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 05:22:40 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E845B9F
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 02:22:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CD31A60F8B
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 10:22:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDEC5C433D2;
        Mon, 12 Dec 2022 10:22:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670840558;
        bh=82Mek9NsJD1mKAuPA30xuCcYkcZNBfTDDhKVt3EFQzM=;
        h=From:To:Cc:Subject:Date:From;
        b=NSxvdpOfC0nfZOwWAx93P5YDuR9z+uaqCTm72wucNf2PtG00NySQJGfuaJixbOQkZ
         ovks+zAa18D9YtDhXA49qCe8mGX9BGQLVx6vaCFoazXUXNrXhPCJA0JWyAO3Xob28n
         3hZHGBTIALF+7G66iHKqdtWdSmE9w5CuaoevQxeKWKfs5LqmernO+jaICDGK7l2NOD
         dde8cnUM8pU30uWYypHFk6Kd7G2pDUfq/RJysmEYwResxD+de45QAsi1VlW2ey11Te
         q61JxKm41cSkIVdP4w/c1Haa3sz5b4Jjl0ZW80SiXaETGhS3PrhWY4EdBovnQxhJSl
         EBlNkCAhXlD8Q==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     airlied@redhat.com
Cc:     linux-kernel@vger.kernel.org,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
        Martin Liska <mliska@suse.cz>, Ben Skeggs <bskeggs@redhat.com>,
        Karol Herbst <kherbst@redhat.com>,
        Lyude Paul <lyude@redhat.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org
Subject: [PATCH] drm/nouveau/kms/nv50- (gcc13): fix nv50_wndw_new_ prototype
Date:   Mon, 12 Dec 2022 11:22:33 +0100
Message-Id: <20221212102233.22212-1-jirislaby@kernel.org>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

gcc-13 warns about mismatching types for enums. That revealed switched
arguments of nv50_wndw_new_():
  drivers/gpu/drm/nouveau/dispnv50/wndw.c:696:1: error: conflicting types for 'nv50_wndw_new_' due to enum/integer mismatch; have 'int(const struct nv50_wndw_func *, struct drm_device *, enum drm_plane_type,  const char *, int,  const u32 *, u32,  enum nv50_disp_interlock_type,  u32,  struct nv50_wndw **)'
  drivers/gpu/drm/nouveau/dispnv50/wndw.h:36:5: note: previous declaration of 'nv50_wndw_new_' with type 'int(const struct nv50_wndw_func *, struct drm_device *, enum drm_plane_type,  const char *, int,  const u32 *, enum nv50_disp_interlock_type,  u32,  u32,  struct nv50_wndw **)'

It can be barely visible, but the declaration says about the parameters
in the middle:
  enum nv50_disp_interlock_type,
  u32 interlock_data,
  u32 heads,

While the definition states differently:
  u32 heads,
  enum nv50_disp_interlock_type interlock_type,
  u32 interlock_data,

Unify/fix the declaration to match the definition.

Cc: Martin Liska <mliska@suse.cz>
Cc: Ben Skeggs <bskeggs@redhat.com>
Cc: Karol Herbst <kherbst@redhat.com>
Cc: Lyude Paul <lyude@redhat.com>
Cc: David Airlie <airlied@gmail.com>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org
Cc: nouveau@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/gpu/drm/nouveau/dispnv50/wndw.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/dispnv50/wndw.h b/drivers/gpu/drm/nouveau/dispnv50/wndw.h
index 591c852f326b..76a6ae5d5652 100644
--- a/drivers/gpu/drm/nouveau/dispnv50/wndw.h
+++ b/drivers/gpu/drm/nouveau/dispnv50/wndw.h
@@ -35,8 +35,9 @@ struct nv50_wndw {
 
 int nv50_wndw_new_(const struct nv50_wndw_func *, struct drm_device *,
 		   enum drm_plane_type, const char *name, int index,
-		   const u32 *format, enum nv50_disp_interlock_type,
-		   u32 interlock_data, u32 heads, struct nv50_wndw **);
+		   const u32 *format, u32 heads,
+		   enum nv50_disp_interlock_type, u32 interlock_data,
+		   struct nv50_wndw **);
 void nv50_wndw_flush_set(struct nv50_wndw *, u32 *interlock,
 			 struct nv50_wndw_atom *);
 void nv50_wndw_flush_clr(struct nv50_wndw *, u32 *interlock, bool flush,
-- 
2.38.1

