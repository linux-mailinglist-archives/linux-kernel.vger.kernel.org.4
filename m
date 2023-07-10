Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6A2F74CD30
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 08:38:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230073AbjGJGiL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 02:38:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231361AbjGJGh7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 02:37:59 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3493AE6E
        for <linux-kernel@vger.kernel.org>; Sun,  9 Jul 2023 23:37:34 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4QzvRx4zkLzBHXh9
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 14:37:01 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1688971021; x=1691563022; bh=lCQQ6bZ2yko3g+i53phatiilgdz
        4TTN3JzNAMdsBb/c=; b=MXZcKlhWuxsqkJ3IP5TCBw7LTwnZiDyxzn5OrkT2+5Y
        M0TFW9QiHDvr6ZORHqmBye64aNQhHGBaS9BuyTjaSddbtfMl61jqSe6ovzbygsT1
        Dsvf2N9gzFyaS779kC3KyI4oTOoAQTdopYZ8xkPJYe88VU9eRtRxONN+DFpmNLji
        AYWFSQlBCu8jaL1mNlo7eqoiRa5MP81t74uyBLv0Y9OloI6OV3kNbOFtOB+SNyWq
        uTWSNoVQEfA8r7G2mfhttC22lnKeHGtKeW4WnYh5TNuP/eG6YNi2udqG4knnLQvp
        c3SCnCJpqHD63UMF3NOIPyMCzzLMflSY88NGzSfxvVg==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id mgGbKqhGrnzi for <linux-kernel@vger.kernel.org>;
        Mon, 10 Jul 2023 14:37:01 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4QzvRx2nWnzBHXgl;
        Mon, 10 Jul 2023 14:37:01 +0800 (CST)
MIME-Version: 1.0
Date:   Mon, 10 Jul 2023 14:37:01 +0800
From:   sunran001@208suo.com
To:     airlied@gmail.com, daniel@ffwll.ch
Cc:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/nouveau/i2c: do not use assignment in if condition
In-Reply-To: <20230710063529.53769-1-xujianghui@cdjrlc.com>
References: <20230710063529.53769-1-xujianghui@cdjrlc.com>
User-Agent: Roundcube Webmail
Message-ID: <2156ff3c1fcec8914f1493ac6d7cd807@208suo.com>
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
  drivers/gpu/drm/nouveau/nvkm/subdev/i2c/busgf119.c | 3 ++-
  1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/busgf119.c 
b/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/busgf119.c
index 96bbdda0f439..a1cf406ff141 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/busgf119.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/busgf119.c
@@ -85,7 +85,8 @@ gf119_i2c_bus_new(struct nvkm_i2c_pad *pad, int id, u8 
drive,
  {
      struct gf119_i2c_bus *bus;

-    if (!(bus = kzalloc(sizeof(*bus), GFP_KERNEL)))
+    bus = kzalloc(sizeof(*bus), GFP_KERNEL);
+    if (!bus)
          return -ENOMEM;
      *pbus = &bus->base;
