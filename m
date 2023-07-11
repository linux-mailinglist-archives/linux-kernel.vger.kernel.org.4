Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B16B374E539
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 05:21:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230329AbjGKDVU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 23:21:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229928AbjGKDVQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 23:21:16 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D41E0BC
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 20:21:14 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R0R3X4gMLzBJDhY
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 11:21:12 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1689045672; x=1691637673; bh=dYPuDHl1tnfdtcIN5hTzLA5ou8I
        V58S6FNhlV5nglao=; b=BeGelFb5flgxR5VQBr/OwmCaYNoFpnRcg3wd6g7nEjz
        1jZ3lq7v//Y+BeKqzLzUXcT8gbcqkq+fGyUgyM68sQAL6X2r3dj7U2bGdlXFywZI
        F+yoXB7itv7hk7jmZPFjvRY0wwuvs+Y/UFIZFoVovHFBEIXaKNky+gaXkUSkPrzY
        oC4BNBrk8uvae9ECNuO9cPJ79KQmFKRY1p9dbRTMuPyLBQQFFDB/INR7SXLYulig
        jGR3CXZ7bfxptYlp6vj0DX44zpoLJ4fGX5+Sujygg4T5U8MJC+HepHgCWwxBV9FC
        4HYRL2CKSCJFP+RjJHFs4ymhuEx0qsDIOJ0IkZZdToQ==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id AsdiZ1CPIS7o for <linux-kernel@vger.kernel.org>;
        Tue, 11 Jul 2023 11:21:12 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R0R3X23NzzBJ8kq;
        Tue, 11 Jul 2023 11:21:12 +0800 (CST)
MIME-Version: 1.0
Date:   Tue, 11 Jul 2023 11:21:12 +0800
From:   sunran001@208suo.com
To:     airlied@gmail.com, daniel@ffwll.ch
Cc:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/nouveau/clk: Move assignment outside if condition
In-Reply-To: <20230711032005.78965-1-xujianghui@cdjrlc.com>
References: <20230711032005.78965-1-xujianghui@cdjrlc.com>
User-Agent: Roundcube Webmail
Message-ID: <2b80ed17d5c46a133887eb1f88691641@208suo.com>
X-Sender: sunran001@208suo.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RDNS_NONE,SPF_HELO_FAIL,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following checkpatch errors:

ERROR: do not use assignment in if condition

Signed-off-by: Ran Sun <sunran001@208suo.com>
---
  drivers/gpu/drm/nouveau/nvkm/subdev/clk/mcp77.c | 3 ++-
  1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/clk/mcp77.c 
b/drivers/gpu/drm/nouveau/nvkm/subdev/clk/mcp77.c
index f85d6a08c61a..77465bfa71ea 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/clk/mcp77.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/clk/mcp77.c
@@ -414,7 +414,8 @@ mcp77_clk_new(struct nvkm_device *device, enum 
nvkm_subdev_type type, int inst,
  {
      struct mcp77_clk *clk;

-    if (!(clk = kzalloc(sizeof(*clk), GFP_KERNEL)))
+    clk = kzalloc(sizeof(*clk), GFP_KERNEL);
+    if (!clk)
          return -ENOMEM;
      *pclk = &clk->base;
