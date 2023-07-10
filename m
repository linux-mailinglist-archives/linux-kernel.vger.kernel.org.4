Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23CB374CAFF
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 06:07:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230155AbjGJEHV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 00:07:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjGJEHT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 00:07:19 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE410E6
        for <linux-kernel@vger.kernel.org>; Sun,  9 Jul 2023 21:07:17 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4Qzr765XvbzBHXgl
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 12:07:14 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1688962034; x=1691554035; bh=gRcZ3CLGEDPxZrkiTCKDOKBlXr/
        +k73D4egciW6sOpk=; b=eWvhsixi8tKjM7NCs0B685IGtqjz+l+82IYFkC6Q6Kt
        KS7HOty57NlUX61nnsMm8JaH530Opl2oTRhp35xMGB3GsAo5KO+LyMzK9e36K7Wn
        x0bIcFxIwFlGRmYjhOb6kYHG1B1aR3ra4LjkEi12memAeQUnZnYT7/L5dE7Pp+dh
        ulAXNVs7BY4DD1r8KdB9IP8qp+BwlpCzdfMfmR4VXOccx86/iVztg4qo1df+HSMT
        od/iIl4mMmKNHpreU6MMpp0DUWuW/DOLVMCSxc5Eh+K6UfLD4DyBPvfZfignm7lT
        NXzt+ky51giZ2x1NOVfHAvm9PeWGaZTZIBiaSekhDmA==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 6hZXDzVu71Xg for <linux-kernel@vger.kernel.org>;
        Mon, 10 Jul 2023 12:07:14 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4Qzr762vBwzBHXgf;
        Mon, 10 Jul 2023 12:07:14 +0800 (CST)
MIME-Version: 1.0
Date:   Mon, 10 Jul 2023 12:07:14 +0800
From:   sunran001@208suo.com
To:     airlied@gmail.com, daniel@ffwll.ch
Cc:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/nouveau/nvkm: do not use assignment in if condition
In-Reply-To: <20230710032131.52747-1-xujianghui@cdjrlc.com>
References: <20230710032131.52747-1-xujianghui@cdjrlc.com>
User-Agent: Roundcube Webmail
Message-ID: <decd9e6f68cbebda22d6648fa7b9b737@208suo.com>
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

Signed-off-by:Ran Sun <sunran001@208suo.com>
---
  drivers/gpu/drm/nouveau/nvkm/subdev/i2c/base.c | 3 ++-
  1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/base.c 
b/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/base.c
index 976539de4220..054fa42f1d04 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/base.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/base.c
@@ -286,7 +286,8 @@ nvkm_i2c_new_(const struct nvkm_i2c_func *func, 
struct nvkm_device *device,

          if (ccbE.share != DCB_I2C_UNUSED) {
              const int id = NVKM_I2C_PAD_HYBRID(ccbE.share);
-            if (!(pad = nvkm_i2c_pad_find(i2c, id)))
+            pad = nvkm_i2c_pad_find(i2c, id);
+            if (!pad)
                  ret = func->pad_s_new(i2c, id, &pad);
              else
                  ret = 0;
