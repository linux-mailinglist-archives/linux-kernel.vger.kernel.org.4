Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73D5774CCFC
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 08:31:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230237AbjGJGba (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 02:31:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbjGJGb2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 02:31:28 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB391E1
        for <linux-kernel@vger.kernel.org>; Sun,  9 Jul 2023 23:31:24 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4QzvKM561DzBHXh8
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 14:31:19 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1688970679; x=1691562680; bh=aTlm6Xb7XXh6jhxQV0R2zMsPiDO
        qv5eG9s4lBNA59SU=; b=ltMav5J8wazDv3YZNCFgd3oFcSatAp7nwnZXwjxtiqi
        nm/jKVHuqLGU/QE4ekoH223zlVF2k5VKU7TTK0DtD4tpwdlvfXJOFlujJq/GnhuA
        /NRAwxvXTbVG26RhyUEmsvl4HUICeHmmK1ssjBw/3CDMQIFpj+3bP4/Q5dww0lbE
        OVlzx5F3j6eOwk0VDR+HdGzE3p7Nbh3l/AeGXVGVRP3LA+5Xi9eFmAgUXEMgJuZx
        34W+ZDx0e3W20KY3Hw0sMCHmYX1a8yj1aQc7sC1Wj401QHSrYQf7pPZbPMmF9WQn
        Ebfs+OcD0m9fbiO/omEH8Y2hSaUFS2y21jizxcgGVZA==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 4L-vFI1UoHlo for <linux-kernel@vger.kernel.org>;
        Mon, 10 Jul 2023 14:31:19 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4QzvKM2q8MzBHXgl;
        Mon, 10 Jul 2023 14:31:19 +0800 (CST)
MIME-Version: 1.0
Date:   Mon, 10 Jul 2023 14:31:15 +0800
From:   sunran001@208suo.com
To:     airlied@gmail.com, daniel@ffwll.ch
Cc:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/nouveau/i2c: do not use assignment in if condition
In-Reply-To: <20230710062932.53655-1-xujianghui@cdjrlc.com>
References: <20230710062932.53655-1-xujianghui@cdjrlc.com>
User-Agent: Roundcube Webmail
Message-ID: <7ab55aa7169d6a3bd0309b43c3de592e@208suo.com>
X-Sender: sunran001@208suo.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,SPF_HELO_FAIL,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Assignments in if condition are less readable and error-prone.  Fixes
also checkpatch warning:

ERROR: do not use assignment in if condition

Signed-off-by: Ran Sun <sunran001@208suo.com>
---
  drivers/gpu/drm/nouveau/nvkm/subdev/i2c/aux.c | 3 ++-
  1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/aux.c 
b/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/aux.c
index d063d0dc13c5..098051d3755c 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/aux.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/aux.c
@@ -209,7 +209,8 @@ nvkm_i2c_aux_new_(const struct nvkm_i2c_aux_func 
*func,
            struct nvkm_i2c_pad *pad, int id,
            struct nvkm_i2c_aux **paux)
  {
-    if (!(*paux = kzalloc(sizeof(**paux), GFP_KERNEL)))
+    *paux = kzalloc(sizeof(**paux), GFP_KERNEL);
+    if (!*paux)
          return -ENOMEM;
      return nvkm_i2c_aux_ctor(func, pad, id, *paux);
  }
